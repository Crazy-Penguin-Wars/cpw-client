package nape.callbacks
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Flags;
   
   public final class PreFlag
   {
       
      
      public function PreFlag()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Flags.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "PreFlag" + " derp!";
         }
      }
      
      public static function get ACCEPT() : PreFlag
      {
         if(ZPP_Flags.PreFlag_ACCEPT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.PreFlag_ACCEPT;
      }
      
      public static function get IGNORE() : PreFlag
      {
         if(ZPP_Flags.PreFlag_IGNORE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.PreFlag_IGNORE = new PreFlag();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.PreFlag_IGNORE;
      }
      
      public static function get ACCEPT_ONCE() : PreFlag
      {
         if(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.PreFlag_ACCEPT_ONCE;
      }
      
      public static function get IGNORE_ONCE() : PreFlag
      {
         if(ZPP_Flags.PreFlag_IGNORE_ONCE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.PreFlag_IGNORE_ONCE = new PreFlag();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.PreFlag_IGNORE_ONCE;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.PreFlag_ACCEPT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.PreFlag_ACCEPT)
         {
            return "ACCEPT";
         }
         §§push(this);
         if(ZPP_Flags.PreFlag_IGNORE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.PreFlag_IGNORE = new PreFlag();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.PreFlag_IGNORE)
         {
            return "IGNORE";
         }
         §§push(this);
         if(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.PreFlag_ACCEPT_ONCE)
         {
            return "ACCEPT_ONCE";
         }
         §§push(this);
         if(ZPP_Flags.PreFlag_IGNORE_ONCE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.PreFlag_IGNORE_ONCE = new PreFlag();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.PreFlag_IGNORE_ONCE)
         {
            return "IGNORE_ONCE";
         }
         return "";
      }
   }
}
