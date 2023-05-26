package nape.phys
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Flags;
   
   public final class BodyType
   {
       
      
      public function BodyType()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Flags.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "BodyType" + " derp!";
         }
      }
      
      public static function get STATIC() : BodyType
      {
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.BodyType_STATIC;
      }
      
      public static function get DYNAMIC() : BodyType
      {
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.BodyType_DYNAMIC;
      }
      
      public static function get KINEMATIC() : BodyType
      {
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.BodyType_KINEMATIC;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.BodyType_STATIC)
         {
            return "STATIC";
         }
         §§push(this);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.BodyType_DYNAMIC)
         {
            return "DYNAMIC";
         }
         §§push(this);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.BodyType_KINEMATIC)
         {
            return "KINEMATIC";
         }
         return "";
      }
   }
}
