with Ada.Text_IO;
with Ada.Numerics.Float_Random;

package body Lane_Sensor is

   task body Lane_Task is
      Gen : Ada.Numerics.Float_Random.Generator;
      Pos : Float := 0.0;
      Step : Float := 0.2;

      package Float_IO is new Ada.Text_IO.Float_IO(Float);
      use Float_IO;
   begin
      Ada.Numerics.Float_Random.Reset(Gen);
      loop
         Pos := Pos + Step;
         if Pos > 2.0 then
            Pos := 2.0;
            Step := -Step;
         elsif Pos < -2.0 then
            Pos := -2.0;
            Step := -Step;
         end if;

         Pos := Pos + (Ada.Numerics.Float_Random.Random(Gen) - 0.5) * 0.2;
         
         Shared_Obj.Set_Lane_Position(Pos);
         Ada.Text_IO.Put("Lane Sensor: ");
         Put(Pos, Fore => 1, Aft => 2, Exp => 0);
         Ada.Text_IO.New_Line;

         delay 3.0;
      end loop;
   end Lane_Task;

end Lane_Sensor;