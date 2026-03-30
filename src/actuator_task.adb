with Ada.Text_IO; use Ada.Text_IO;

package body Actuator_Task is

   task body Actuator is
      Fault : Boolean;
   begin
      loop
         Fault := Shared_Obj.Get_Fault;

         if Fault then
            Put_Line("ACTUATOR: >>> BRAKE APPLIED <<<");
         else
            Put_Line("ACTUATOR: Driving normally");
         end if;

         delay 0.5;
      end loop;
   end Actuator;

end Actuator_Task;