package
{
   import flash.*;
   
   public class Std
   {
      public function Std()
      {
         super();
      }
      
      public static function string(param1:*) : String
      {
         return Boot.__string_rec(param1,"");
      }
   }
}

