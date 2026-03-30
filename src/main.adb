with Ada.Text_IO; use Ada.Text_IO;

with Shared_Data;
with Speed_Sensor;
with Distance_Sensor;
with Control_Task;
with Actuator_Task;

procedure Main is

   Shared_Obj : aliased Shared_Data.Shared;

   Speed_Task_Instance    : Speed_Sensor.Speed_Task(Shared_Obj'Access);
   Distance_Task_Instance : Distance_Sensor.Distance_Task(Shared_Obj'Access);
   Control_Instance       : Control_Task.Control(Shared_Obj'Access);
   Actuator_Instance      : Actuator_Task.Actuator(Shared_Obj'Access);

begin
   Put_Line("ADAS System Started...");

   delay 20.0;

   Put_Line("ADAS System Finished.");
end Main;