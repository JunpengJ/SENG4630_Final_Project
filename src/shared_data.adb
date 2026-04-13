package body Shared_Data is

   protected body Shared is

      procedure Set_Speed(Value : Float) is
      begin
         if Value >= 0.0 then
            Speed := Value;
         end if;
      end;

      function Get_Speed return Float is
      begin
         return Speed;
      end;

      procedure Set_Speed_Health(Health : Sensor_Health) is
      begin
         Speed_Health := Health;
      end;

      function Get_Speed_Health return Sensor_Health is
      begin
         return Speed_Health;
      end;

      procedure Set_Distance(Value : Float) is
      begin
         if Value >= 0.0 then
            Distance := Value;
         end if;
      end;

      function Get_Distance return Float is
      begin
         return Distance;
      end;

      procedure Set_Distance_Health(Health : Sensor_Health) is
      begin
         Distance_Health := Health;
      end;

      function Get_Distance_Health return Sensor_Health is
      begin
         return Distance_Health;
      end;

      procedure Set_Lane_Position(Value : Float) is
      begin
         Lane_Position := Value;
      end;

      function Get_Lane_Position return Float is
      begin
         return Lane_Position;
      end;

      procedure Set_Lane_Health(Health : Sensor_Health) is
      begin
         Lane_Health := Health;
      end;

      function Get_Lane_Health return Sensor_Health is
      begin
         return Lane_Health;
      end;

      procedure Set_Target_Speed(Value : Float) is
      begin
         if Value >= 0.0 and Value <= 120.0 then
            Target_Speed := Value;
         end if;
      end;

      function Get_Target_Speed return Float is
      begin
         return Target_Speed;
      end;

      procedure Set_Throttle(Value : Float) is
      begin
         if Value >= -1.0 and Value <= 1.0 then
            Throttle_Cmd := Value;
         end if;
      end;

      function Get_Throttle return Float is
      begin
         return Throttle_Cmd;
      end;

      procedure Set_Steering(Value : Float) is
      begin
         if Value >= -1.0 and Value <= 1.0 then
            Steering_Cmd := Value;
         end if;
      end;

      function Get_Steering return Float is
      begin
         return Steering_Cmd;
      end;

      procedure Set_Autopilot_Enabled(Enabled : Boolean) is
      begin
         Autopilot_Enabled := Enabled;
      end;

      function Is_Autopilot_Enabled return Boolean is
      begin
         return Autopilot_Enabled;
      end;

      procedure Set_Driver_Brake(Value : Float) is
      begin
         if Value >= 0.0 and Value <= 1.0 then
            Driver_Brake := Value;
         end if;
      end;

      function Get_Driver_Brake return Float is
      begin
         return Driver_Brake;
      end;

      procedure Set_Driver_Steering(Value : Float) is
      begin
         if Value >= -45.0 and Value <= 45.0 then
            Driver_Steering := Value;
         end if;
      end;

      function Get_Driver_Steering return Float is
      begin
         return Driver_Steering;
      end;

      function Is_Override_Active return Boolean is
      begin
         return Driver_Brake > 0.1 or abs(Driver_Steering) > 5.0;
      end;

      procedure Set_System_State(State : System_State) is
      begin
         Current_State := State;
      end;

      function Get_System_State return System_State is
      begin
         return Current_State;
      end;

      procedure Set_Fault(Severity : Fault_Severity; Message : String) is
      begin
         Fault_Active := True;
         Fault_Level := Severity;
         -- 复制消息（最多80字符）
         for I in Message'Range loop
            if I - Message'First + 1 <= 80 then
               Fault_Message(I - Message'First + 1) := Message(I);
            else
               exit;
            end if;
         end loop;
      end;

      procedure Clear_Fault is
      begin
         Fault_Active := False;
         Fault_Level := Info;
         Fault_Message := (others => ' ');
      end;

      function Get_Fault_Active return Boolean is
      begin
         return Fault_Active;
      end;

      function Get_Fault_Severity return Fault_Severity is
      begin
         return Fault_Level;
      end;

      function Get_Fault_Message return String is
      begin
         return Fault_Message;
      end;

      procedure Set_Output_Enabled(Enabled : Boolean) is
      begin
         Output_Enabled := Enabled;
      end;
      
      function Is_Output_Enabled return Boolean is
      begin
         return Output_Enabled;
      end;
   end Shared;

end Shared_Data;