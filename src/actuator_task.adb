with Ada.Text_IO; use Ada.Text_IO;

package body Actuator_Task is

   task body Actuator is
      Fault : Boolean;
      Throttle : Float;
   begin
      loop
         Fault := Shared_Obj.Get_Fault;
         Throttle := Shared_Obj.Get_Throttle;

         if Fault then
            Put_Line("ACTUATOR: >>> EMERGENCY BRAKE APPLIED <<<");
         elsif Throttle > 0.0 then
            Put_Line("ACTUATOR: Accelerating with throttle=" & Float'Image(Throttle));
         elsif Throttle < 0.0 then 
            Put_Line("ACTUATOR: Braking with force=" & Float'Image(-Throttle));
         else
            Put_Line("ACTUATOR: Coasting");
         end if;

         delay 0.5;
      end loop;
   end Actuator;

end Actuator_Task;