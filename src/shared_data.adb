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

   end Shared;

end Shared_Data;