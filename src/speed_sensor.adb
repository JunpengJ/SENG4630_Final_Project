with Ada.Text_IO;
with Ada.Numerics.Float_Random;
with Shared_Data; use Shared_Data;

package body Speed_Sensor is

   package Float_IO is new Ada.Text_IO.Float_IO(Float);
   use Float_IO;

   task body Speed_Task is
      Gen : Ada.Numerics.Float_Random.Generator;
      Speed_Value : Float := 50.0;
      Fault_Probability : constant Float := 0.02;
   begin
      Ada.Numerics.Float_Random.Reset(Gen);
      loop
         if Ada.Numerics.Float_Random.Random(Gen) < Fault_Probability then

            if Ada.Numerics.Float_Random.Random(Gen) < 0.5 then
               Shared_Obj.Set_Speed_Health(Timeout);
               Ada.Text_IO.Put_Line("Speed Sensor: TIMEOUT FAILURE");
            else
               Shared_Obj.Set_Speed_Health(Invalid_Data);
               Ada.Text_IO.Put_Line("Speed Sensor: INVALID DATA (negative speed)");

               Shared_Obj.Set_Speed(-10.0);
            end if;
         else

            Speed_Value := Speed_Value + 1.0;
            if Speed_Value > 120.0 then
               Speed_Value := 50.0;
            end if;
            Shared_Obj.Set_Speed(Speed_Value);
            Shared_Obj.Set_Speed_Health(Healthy);

            Ada.Text_IO.Put("Speed Sensor: ");
            Put(Speed_Value, Fore => 1, Aft => 2, Exp => 0);
            Ada.Text_IO.New_Line;
         end if;

         delay 3.0;
      end loop;
   end Speed_Task;

end Speed_Sensor;