with Ada.Text_IO; use Ada.Text_IO;

package body Speed_Sensor is

   task body Speed_Task is
      Speed_Value : Float := 50.0;
   begin
      loop
         Speed_Value := Speed_Value + 1.0;

         if Speed_Value > 120.0 then
            Speed_Value := 50.0;
         end if;

         Shared_Obj.Set_Speed(Speed_Value);

         Put_Line("Speed Sensor: " & Float'Image(Speed_Value));

         delay 0.5;
      end loop;
   end Speed_Task;

end Speed_Sensor;