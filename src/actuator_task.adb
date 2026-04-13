with Ada.Text_IO;
with Shared_Data; use Shared_Data;

package body Actuator_Task is

   package Float_IO is new Ada.Text_IO.Float_IO(Float);
   use Float_IO;

   task body Actuator is
      Fault_Active   : Boolean;
      Throttle_Cmd   : Float;
      Steering_Cmd   : Float;
      Autopilot_En   : Boolean;
      Driver_Brake   : Float;
      Driver_Steer   : Float;
      System_State   : Shared_Data.System_State;
   begin
      loop
         Fault_Active   := Shared_Obj.Get_Fault_Active;
         Throttle_Cmd   := Shared_Obj.Get_Throttle;
         Steering_Cmd   := Shared_Obj.Get_Steering;
         Autopilot_En   := Shared_Obj.Is_Autopilot_Enabled;
         Driver_Brake   := Shared_Obj.Get_Driver_Brake;
         Driver_Steer   := Shared_Obj.Get_Driver_Steering;
         System_State   := Shared_Obj.Get_System_State;

         if System_State = Emergency_Braking or Fault_Active then
            Ada.Text_IO.Put_Line("ACTUATOR: >>> EMERGENCY BRAKE APPLIED <<<");

         else
            if not Autopilot_En or System_State = Manual_Override then
               if Driver_Brake > 0.1 then
                  Ada.Text_IO.Put("ACTUATOR: Driver braking force = ");
                  Put(Driver_Brake, Fore => 1, Aft => 2, Exp => 0);
                  Ada.Text_IO.New_Line;
               elsif abs(Driver_Steer) > 5.0 then
                  Ada.Text_IO.Put("ACTUATOR: Driver steering angle = ");
                  Put(Driver_Steer, Fore => 1, Aft => 2, Exp => 0);
                  Ada.Text_IO.New_Line;
               else
                  Ada.Text_IO.Put_Line("ACTUATOR: Manual control - no active input");
               end if;
            else

               if Throttle_Cmd < 0.0 then
                  Ada.Text_IO.Put("ACTUATOR: Braking force = ");
                  Put(-Throttle_Cmd, Fore => 1, Aft => 2, Exp => 0);
                  Ada.Text_IO.New_Line;
               elsif Throttle_Cmd > 0.0 then
                  Ada.Text_IO.Put("ACTUATOR: Accelerating throttle = ");
                  Put(Throttle_Cmd, Fore => 1, Aft => 2, Exp => 0);
                  Ada.Text_IO.New_Line;
               else
                  Ada.Text_IO.Put_Line("ACTUATOR: Coasting");
               end if;

               if abs(Steering_Cmd) > 0.01 then
                  Ada.Text_IO.Put("ACTUATOR: Steering correction = ");
                  Put(Steering_Cmd, Fore => 1, Aft => 2, Exp => 0);
                  Ada.Text_IO.New_Line;
               end if;
            end if;
         end if;

         delay 1.5;
      end loop;
   end Actuator;

end Actuator_Task;