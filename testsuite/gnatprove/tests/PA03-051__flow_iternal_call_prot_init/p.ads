package P is

   protected type PT is
      function Func return Integer;
   private
      Priv : Integer := Func;
   end PT;

end P;
