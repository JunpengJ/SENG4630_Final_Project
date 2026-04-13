with Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Shared_Data; use Shared_Data;

package body Driver_Input_Task is

   task body Driver_Input is
      Input_Line : String(1..80);
      Last       : Natural;
      Cmd        : Unbounded_String;
      Arg        : Unbounded_String;
      Brake_Val  : Float := 0.0;
      Steer_Val  : Float := 0.0;
      Running    : Boolean := True;
   begin
      Ada.Text_IO.Put_Line("Driver Input Task started.");
      Ada.Text_IO.Put_Line("Commands: brake <0..1>, steer <-45..45>, enable, disable, quit");

      while Running loop
         Ada.Text_IO.Put("> ");
         Ada.Text_IO.Get_Line(Input_Line, Last);

         begin
            if Last = 0 then
               null;
            else
               declare
                  First_Space : Natural := 0;
               begin
                  for I in 1..Last loop
                     if Input_Line(I) = ' ' then
                        First_Space := I;
                        exit;
                     end if;
                  end loop;

                  if First_Space = 0 then
                     Cmd := To_Unbounded_String(Input_Line(1..Last));
                     Arg := Null_Unbounded_String;
                  else
                     Cmd := To_Unbounded_String(Input_Line(1..First_Space-1));
                     Arg := To_Unbounded_String(Input_Line(First_Space+1..Last));
                  end if;
               end;

               if Cmd = "brake" or Cmd = "b" then
                  Brake_Val := Float'Value(To_String(Arg));
                  if Brake_Val < 0.0 then Brake_Val := 0.0;
                  elsif Brake_Val > 1.0 then Brake_Val := 1.0;
                  end if;
                  Shared_Obj.Set_Driver_Brake(Brake_Val);
                  Ada.Text_IO.Put_Line("Brake set to " & Float'Image(Brake_Val));
                  if Brake_Val > 0.1 then
                     Shared_Obj.Set_Autopilot_Enabled(False);
                     Ada.Text_IO.Put_Line("AUTOPILOT DISABLED due to brake override");
                  end if;

               elsif Cmd = "steer" or Cmd = "s" then
                  Steer_Val := Float'Value(To_String(Arg));
                  if Steer_Val < -45.0 then Steer_Val := -45.0;
                  elsif Steer_Val > 45.0 then Steer_Val := 45.0;
                  end if;
                  Shared_Obj.Set_Driver_Steering(Steer_Val);
                  Ada.Text_IO.Put_Line("Steering set to " & Float'Image(Steer_Val) & " deg");
                  if abs(Steer_Val) > 5.0 then
                     Shared_Obj.Set_Autopilot_Enabled(False);
                     Ada.Text_IO.Put_Line("AUTOPILOT DISABLED due to steering override");
                  end if;

               elsif Cmd = "enable" or Cmd = "on" then
                  Shared_Obj.Set_Autopilot_Enabled(True);
                  Ada.Text_IO.Put_Line("Autopilot ENABLED");

               elsif Cmd = "disable" or Cmd = "off" then
                  Shared_Obj.Set_Autopilot_Enabled(False);
                  Ada.Text_IO.Put_Line("Autopilot DISABLED");

               elsif Cmd = "quit" or Cmd = "exit" then
                  Running := False;
                  Ada.Text_IO.Put_Line("Exiting driver input task...");

               else
                  Ada.Text_IO.Put_Line("Unknown command.");
               end if;
            end if;
         exception
            when others =>
               Ada.Text_IO.Put_Line("Invalid command or argument.");
         end;
      end loop;
   end Driver_Input;

end Driver_Input_Task;