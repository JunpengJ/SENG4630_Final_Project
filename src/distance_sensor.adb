with Ada.Text_IO;

package body Distance_Sensor is
   task body Distance_Task is
      Distance_Value : Float := 100.0;

      package Float_IO is new Ada.Text_IO.Float_IO(Float);
      use Float_IO;
   begin
      loop
         Distance_Value := Distance_Value - 2.0;

         if Distance_Value < 0.0 then
            Distance_Value := 100.0;
         end if;

         Shared_Obj.Set_Distance(Distance_Value);

         Ada.Text_IO.Put("Distance Sensor: ");
         Float_IO.Put(Distance_Value, Fore => 1, Aft => 2, Exp => 0);
         Ada.Text_IO.New_Line;
         delay 3.0;
      end loop;
   end Distance_Task;

end Distance_Sensor;