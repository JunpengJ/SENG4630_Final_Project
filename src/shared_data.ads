package Shared_Data is

   protected type Shared is
      procedure Set_Speed(Value : Float);
      function Get_Speed return Float;

      procedure Set_Distance(Value : Float);
      function Get_Distance return Float;

      procedure Set_Target_Speed(Value : Float);
      function Get_Target_Speed return Float;

      procedure Set_Throttle(Value : Float);
      function Get_Throttle return Float;

      procedure Set_Fault(Status : Boolean);
      function Get_Fault return Boolean;

      --  procedure Set_Autopilot_Enabled(Enabled : Boolean);
      --  function Get_Autopilot_Enabled return Boolean;

      --  procedure Set_Driver_Streering(Value  : Float);
      --  function Get_Driver_Steering return Float;

      --  function Is_Override_Active return Boolean;

   private
      Speed    : Float := 0.0;
      Distance : Float := 100.0;
      Target_Speed : Float := 80.0;
      Throttle_Cmd : Float := 0.0;
      Fault    : Boolean := False;

      --  Autopilot_Enabled : Boolean := True;
      --  Driver_Brak : Float := 0.0;
      --  Driver_Steering : Float := 0.0;
   end Shared;

end Shared_Data;