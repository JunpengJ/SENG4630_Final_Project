with Ada.Text_IO; use Ada.Text_IO;
with Shared_Data; use Shared_Data;

with Shared_Data;
with Speed_Sensor;
with Distance_Sensor;
with Control_Task;
with Actuator_Task;
with Driver_Input_Task;
with Lane_Sensor;

procedure Main is

   Shared_Obj : aliased Shared_Data.Shared;

   Speed_Task_Instance    : Speed_Sensor.Speed_Task(Shared_Obj'Access);
   Distance_Task_Instance : Distance_Sensor.Distance_Task(Shared_Obj'Access);
   Control_Instance       : Control_Task.Control(Shared_Obj'Access);
   Actuator_Instance      : Actuator_Task.Actuator(Shared_Obj'Access);
   Driver_Input_Instance  : Driver_Input_Task.Driver_Input(Shared_Obj'Access);
   Lane_Task_Instance     : Lane_Sensor.Lane_Task(Shared_Obj'Access);

begin
   Put_Line("ADAS System Started...");
   Put_Line("System will run for 120 seconds. Type 'quit' to exit early.");
   Shared_Obj.Set_System_State(Shared_Data.Standby);
   Shared_Obj.Set_Autopilot_Enabled(True);
   Shared_Obj.Set_Target_Speed(80.0);

   delay 120.0;

   Put_Line("ADAS System Finished.");
end Main;