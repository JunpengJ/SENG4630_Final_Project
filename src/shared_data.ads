package Shared_Data is

   protected type Shared is
      procedure Set_Speed(Value : Float);
      function Get_Speed return Float;

      procedure Set_Distance(Value : Float);
      function Get_Distance return Float;

      procedure Set_Fault(Status : Boolean);
      function Get_Fault return Boolean;
   private
      Speed    : Float := 0.0;
      Distance : Float := 100.0;
      Fault    : Boolean := False;
   end Shared;

end Shared_Data;