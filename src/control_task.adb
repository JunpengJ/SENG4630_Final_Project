with Ada.Text_IO; use Ada.Text_IO;

package body Control_Task is

   task body Control is
      Speed    : Float;
      Distance : Float;
   begin
      loop
         Speed    := Shared_Obj.Get_Speed;
         Distance := Shared_Obj.Get_Distance;

         if Distance < 10.0 then
            Shared_Obj.Set_Fault(True);
            Put_Line("CONTROL: EMERGENCY!");
         else
            Shared_Obj.Set_Fault(False);
            Put_Line("CONTROL: NORMAL");
         end if;

         delay 0.5;
      end loop;
   end Control;

end Control_Task;