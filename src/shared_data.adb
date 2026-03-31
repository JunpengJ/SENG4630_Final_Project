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

      procedure Set_Fault(Status : Boolean) is
      begin
         Fault := Status;
      end;

      function Get_Fault return Boolean is
      begin
         return Fault;
      end;

      procedure Set_Target_Speed(Value : Float) is
      begin
         if Value >= 0.0  and Value <= 120.0 then
            Target_Speed := Value;
         end if;
      end;

      function Get_Target_Speed return Float is
      begin
         return Target_Speed;
      end;

      procedure Set_Throttle(Value : Float) is
      begin
         if Value >= -1.0  and Value <= 1.0 then
            Throttle_Cmd := Value;
         end if;
      end;

      function Get_Throttle return Float is
      begin
         return Throttle_Cmd;
      end;

   end Shared;

end Shared_Data;