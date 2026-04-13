with Ada.Text_IO;
with Shared_Data; use Shared_Data;

package body Control_Task is
   task body Control is
      Speed, Distance, Lane : Float;
      Target_Speed : Float;
      Speed_Health, Dist_Health, Lane_Health : Sensor_Health;
      Throttle, Steering : Float;
      Safe_Distance  : constant Float := 10.0;
      Kp_Speed       : constant Float := 0.5;
      Kp_Dist        : constant Float := 0.2;  
      Kp_Lane        : constant Float := 0.8;

      package Float_IO is new Ada.Text_IO.Float_IO(Float);
      use Float_IO;
   begin
      loop
         Speed        := Shared_Obj.Get_Speed;
         Distance     := Shared_Obj.Get_Distance;
         Lane         := Shared_Obj.Get_Lane_Position;
         Target_Speed := Shared_Obj.Get_Target_Speed;
         Speed_Health := Shared_Obj.Get_Speed_Health;
         Dist_Health  := Shared_Obj.Get_Distance_Health;
         Lane_Health  := Shared_Obj.Get_Lane_Health;

         if Speed_Health /= Healthy or Dist_Health /= Healthy or Lane_Health /= Healthy then
            Shared_Obj.Set_Fault(Critical, "Sensor failure detected");
            Shared_Obj.Set_System_State(Fault);
            Shared_Obj.Set_Autopilot_Enabled(False);
         else
            if Shared_Obj.Get_System_State = Fault then
               Shared_Obj.Clear_Fault;
               Shared_Obj.Set_System_State(Standby);
            end if;
         end if; 

         declare
            State : System_State := Shared_Obj.Get_System_State;
         begin
            case State is
               when Off =>
                  null;
               when Standby =>
                  if Shared_Obj.Is_Autopilot_Enabled then
                     Shared_Obj.Set_System_State(Active);
                  end if;
               when Active => 
                  if Distance < Safe_Distance then
                     Shared_Obj.Set_System_State(Emergency_Braking);
                     Throttle := -1.0;
                     Steering := 0.0;
                  else
                     declare
                        Error_Speed : Float := Target_Speed - Speed;
                        Error_Dist  : Float := Distance - Safe_Distance;
                     begin
                        Throttle := Kp_Speed * Error_Speed + Kp_Dist * Error_Dist;
                        if Throttle > 1.0 then Throttle := 1.0;
                        elsif Throttle < -1.0 then Throttle := -1.0;
                        end if;
                     end;
                     Steering := -Kp_Lane * Lane;
                     if Steering > 1.0 then Steering := 1.0;
                     elsif Steering < -1.0 then Steering := -1.0;
                     end if;
                  end if;
               when Emergency_Braking =>
                  Throttle := -1.0;
                  Steering := 0.0;
                  if Distance >= Safe_Distance + 2.0 then
                     Shared_Obj.Set_System_State(Active);
                  end if;
               when Fault =>
                  Throttle := 0.0;
                  Steering := 0.0;
                  Shared_Obj.Set_Autopilot_Enabled(False);
               when Manual_Override =>
                  Throttle := 0.0;
                  Steering := 0.0;
            end case;
         end;

         if not Shared_Obj.Is_Autopilot_Enabled then
            declare
               Current : System_State := Shared_Obj.Get_System_State;
            begin
               if Current /= Fault and Current /= Emergency_Braking then
                  Shared_Obj.Set_System_State(Manual_Override);
               end if;
            end;
         end if;

         if Shared_Obj.Is_Autopilot_Enabled then
            declare
               Current : System_State := Shared_Obj.Get_System_State;
            begin
               if Current = Manual_Override then
                  Shared_Obj.Set_System_State(Standby);
               end if;
            end;
         end if;

         Shared_Obj.Set_Throttle(Throttle);
         Shared_Obj.Set_Steering(Steering);

         Ada.Text_IO.Put_Line("CONTROL: State= " & System_State'Image(Shared_Obj.Get_System_State));
         Ada.Text_IO.Put("Throttle= ");
         Put(Throttle, Fore => 1, Aft => 2, Exp => 0);
         Ada.Text_IO.New_Line;
         Ada.Text_IO.Put("Steering= ");
         Put(Steering, Fore => 1, Aft => 2, Exp => 0);
         Ada.Text_IO.New_Line;

         delay 3.0;
      end loop;
   end Control;
end Control_Task;