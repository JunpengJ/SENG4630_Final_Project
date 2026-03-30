with Ada.Text_IO; use Ada.Text_IO;

package body Distance_Sensor is

   task body Distance_Task is
      Distance_Value : Float := 100.0;
   begin
      loop
         Distance_Value := Distance_Value - 2.0;

         if Distance_Value < 0.0 then
            Distance_Value := 100.0;
         end if;

         Shared_Obj.Set_Distance(Distance_Value);

         Put_Line("Distance Sensor: " & Float'Image(Distance_Value));

         delay 0.5;
      end loop;
   end Distance_Task;

end Distance_Sensor;