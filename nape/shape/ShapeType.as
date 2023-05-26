package nape.shape
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Flags;
   
   public final class ShapeType
   {
       
      
      public function ShapeType()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Flags.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "ShapeType" + " derp!";
         }
      }
      
      public static function get CIRCLE() : ShapeType
      {
         if(ZPP_Flags.ShapeType_CIRCLE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ShapeType_CIRCLE = new ShapeType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ShapeType_CIRCLE;
      }
      
      public static function get POLYGON() : ShapeType
      {
         if(ZPP_Flags.ShapeType_POLYGON == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ShapeType_POLYGON = new ShapeType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ShapeType_POLYGON;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.ShapeType_CIRCLE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ShapeType_CIRCLE = new ShapeType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ShapeType_CIRCLE)
         {
            return "CIRCLE";
         }
         §§push(this);
         if(ZPP_Flags.ShapeType_POLYGON == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ShapeType_POLYGON = new ShapeType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ShapeType_POLYGON)
         {
            return "POLYGON";
         }
         return "";
      }
   }
}
