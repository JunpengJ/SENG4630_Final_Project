package Shared_Data is

   type System_State is (Off, Standby, Active, Fault, Emergency_Braking, Manual_Override);
   type Fault_Severity is (Info, Warning, Critical);
   type Sensor_Health is (Healthy, Timeout, Invalid_Data);

   protected type Shared is
      procedure Set_Speed(Value : Float)
         with Pre => Value >= 0.0;
      function Get_Speed return Float;

      procedure Set_Speed_Health(Health : Sensor_Health);
      function Get_Speed_Health return Sensor_Health;

      procedure Set_Distance(Value : Float)
         with Pre => Value >= 0.0;
      function Get_Distance return Float;

      procedure Set_Distance_Health(Health : Sensor_Health);
      function Get_Distance_Health return Sensor_Health;

      procedure Set_Lane_Position(Value : Float);
      function Get_Lane_Position return Float;
      procedure Set_Lane_Health(Health : Sensor_Health);
      function Get_Lane_Health return Sensor_Health;

      procedure Set_Target_Speed(Value : Float)
         with Pre => Value >= 0.0 and Value <= 120.0;
      function Get_Target_Speed return Float;

      procedure Set_Throttle(Value : Float)
         with Pre => Value in -1.0 .. 1.0;
      function Get_Throttle return Float;

      procedure Set_Steering(Value : Float)
         with Pre => Value in -1.0 .. 1.0;
      function Get_Steering return Float;

      procedure Set_Autopilot_Enabled(Enabled : Boolean);
      function Is_Autopilot_Enabled return Boolean;

      procedure Set_Driver_Brake(Value : Float)
         with Pre => Value in 0.0 .. 1.0;
      function Get_Driver_Brake return Float;

      procedure Set_Driver_Steering(Value : Float)
         with Pre => Value in -45.0 .. 45.0;
      function Get_Driver_Steering return Float;

      procedure Set_System_State(State : System_State);
      function Get_System_State return System_State;
      procedure Set_Fault(Severity : Fault_Severity; Message : String);
      procedure Clear_Fault;
      function Get_Fault_Active return Boolean;

      procedure Set_Output_Enabled(Enabled : Boolean);
      function Is_Output_Enabled return Boolean;

   private
      Speed         : Float := 0.0;
      Distance      : Float := 100.0;
      Lane_Position : Float := 0.0;
      Target_Speed  : Float := 80.0;
      Throttle_Cmd  : Float := 0.0;
      Steering_Cmd  : Float := 0.0;

      Autopilot_Enabled : Boolean := True; 

      Driver_Brake : Float := 0.0;
      Driver_Steering : Float := 0.0;

      Current_State   : System_State := Off;
      Fault_Active    : Boolean := False;
      Fault_Level     : Fault_Severity := Info;
      Fault_Message   : String(1..80) := (others => ' ');

      Speed_Health    : Sensor_Health := Healthy;
      Distance_Health : Sensor_Health := Healthy;
      Lane_Health     : Sensor_Health := Healthy;

      Output_Enabled  : Boolean := True;
   end Shared;

end Shared_Data;