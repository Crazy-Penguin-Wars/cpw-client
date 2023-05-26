package zpp_nape
{
   public class ZPP_Const
   {
      
      public static var vec2vector:Class = Type.getClass(new Vector.<Vec2>());
      
      public static var cbtypevector:Class = Type.getClass(new Vector.<CbType>());
      
      public static var optiontypevector:Class = Type.getClass(new Vector.<OptionType>());
       
      
      public function ZPP_Const()
      {
      }
      
      public static function POSINF() : Number
      {
         return 1.79e+308;
      }
      
      public static function NEGINF() : Number
      {
         return -1.79e+308;
      }
   }
}
