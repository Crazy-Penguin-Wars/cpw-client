package zpp_nape
{
   public class ZPP_Const
   {
      public static var vec2vector:Class;
      
      public static var cbtypevector:Class;
      
      public static var optiontypevector:Class;
      
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

import nape.callbacks.CbType;
import nape.callbacks.OptionType;
import nape.geom.Vec2;

