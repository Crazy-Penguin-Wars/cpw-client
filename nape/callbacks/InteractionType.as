package nape.callbacks
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Flags;
   
   public final class InteractionType
   {
       
      
      public function InteractionType()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Flags.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "InteractionType" + " derp!";
         }
      }
      
      public static function get COLLISION() : InteractionType
      {
         if(ZPP_Flags.InteractionType_COLLISION == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InteractionType_COLLISION = new InteractionType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.InteractionType_COLLISION;
      }
      
      public static function get SENSOR() : InteractionType
      {
         if(ZPP_Flags.InteractionType_SENSOR == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InteractionType_SENSOR = new InteractionType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.InteractionType_SENSOR;
      }
      
      public static function get FLUID() : InteractionType
      {
         if(ZPP_Flags.InteractionType_FLUID == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InteractionType_FLUID = new InteractionType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.InteractionType_FLUID;
      }
      
      public static function get ANY() : InteractionType
      {
         if(ZPP_Flags.InteractionType_ANY == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InteractionType_ANY = new InteractionType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.InteractionType_ANY;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.InteractionType_COLLISION == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InteractionType_COLLISION = new InteractionType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.InteractionType_COLLISION)
         {
            return "COLLISION";
         }
         §§push(this);
         if(ZPP_Flags.InteractionType_SENSOR == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InteractionType_SENSOR = new InteractionType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.InteractionType_SENSOR)
         {
            return "SENSOR";
         }
         §§push(this);
         if(ZPP_Flags.InteractionType_FLUID == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InteractionType_FLUID = new InteractionType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.InteractionType_FLUID)
         {
            return "FLUID";
         }
         §§push(this);
         if(ZPP_Flags.InteractionType_ANY == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InteractionType_ANY = new InteractionType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.InteractionType_ANY)
         {
            return "ANY";
         }
         return "";
      }
   }
}
