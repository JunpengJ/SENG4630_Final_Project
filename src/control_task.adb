with Ada.Text_IO; use Ada.Text_IO;

package body Control_Task is

   task body Control is
      Speed    : Float;
      Distance : Float;
      Target_Speed   : Float;
      Error_Speed    : Float; 
      Error_Distance : Float;
      Throttle       : Float;
      Safe_Distance  : constant Float := 10.0;
      Kp_Speed       : constant Float := 0.5;
      Kp_Distance    : constant Float := 0.2;

   begin
      loop
         Speed    := Shared_Obj.Get_Speed;
         Distance := Shared_Obj.Get_Distance;
         Target_Speed := Shared_Obj.Get_Target_Speed;

         if Distance < 10.0 then
            Shared_Obj.Set_Fault(True);
            Put_Line("CONTROL: EMERGENCY!");
            Throttle := -1.0;
         else
            Shared_Obj.Set_Fault(False);
            Error_Speed := Target_Speed - Speed;
            Error_Distance := Distance - Safe_Distance;
            Throttle := Kp_Speed * Error_Speed + Kp_Distance * Error_Distance;
            if Throttle > 1.0 then
               Throttle := 1.0;
            elsif Throttle < -1.0 then
               Throttle := -1.0;
            end if;

            if Throttle > 0.0 then
               Put_Line("CONTROL: ACCELERATING, throttle=" & Float'Image(Throttle));
            else
               Put_Line("CONTROL: Braking, break force =" & Float'Image(-Throttle));
            end if;
         end if;
         
         Shared_Obj.Set_Throttle(Throttle);

         delay 0.5;
      end loop;
   end Control;

end Control_Task;