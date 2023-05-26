package nape.geom
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Flags;
   
   public final class Winding
   {
       
      
      public function Winding()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Flags.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "Winding" + " derp!";
         }
      }
      
      public static function get UNDEFINED() : Winding
      {
         if(ZPP_Flags.Winding_UNDEFINED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_UNDEFINED = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.Winding_UNDEFINED;
      }
      
      public static function get CLOCKWISE() : Winding
      {
         if(ZPP_Flags.Winding_CLOCKWISE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_CLOCKWISE = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.Winding_CLOCKWISE;
      }
      
      public static function get ANTICLOCKWISE() : Winding
      {
         if(ZPP_Flags.Winding_ANTICLOCKWISE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_ANTICLOCKWISE = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.Winding_ANTICLOCKWISE;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.Winding_UNDEFINED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_UNDEFINED = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.Winding_UNDEFINED)
         {
            return "UNDEFINED";
         }
         §§push(this);
         if(ZPP_Flags.Winding_CLOCKWISE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_CLOCKWISE = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.Winding_CLOCKWISE)
         {
            return "CLOCKWISE";
         }
         §§push(this);
         if(ZPP_Flags.Winding_ANTICLOCKWISE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_ANTICLOCKWISE = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.Winding_ANTICLOCKWISE)
         {
            return "ANTICLOCKWISE";
         }
         return "";
      }
   }
}
