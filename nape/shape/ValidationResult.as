package nape.shape
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Flags;
   
   public final class ValidationResult
   {
       
      
      public function ValidationResult()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Flags.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "ValidationResult" + " derp!";
         }
      }
      
      public static function get VALID() : ValidationResult
      {
         if(ZPP_Flags.ValidationResult_VALID == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ValidationResult_VALID = new ValidationResult();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ValidationResult_VALID;
      }
      
      public static function get DEGENERATE() : ValidationResult
      {
         if(ZPP_Flags.ValidationResult_DEGENERATE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ValidationResult_DEGENERATE = new ValidationResult();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ValidationResult_DEGENERATE;
      }
      
      public static function get CONCAVE() : ValidationResult
      {
         if(ZPP_Flags.ValidationResult_CONCAVE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ValidationResult_CONCAVE = new ValidationResult();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ValidationResult_CONCAVE;
      }
      
      public static function get SELF_INTERSECTING() : ValidationResult
      {
         if(ZPP_Flags.ValidationResult_SELF_INTERSECTING == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ValidationResult_SELF_INTERSECTING = new ValidationResult();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ValidationResult_SELF_INTERSECTING;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.ValidationResult_VALID == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ValidationResult_VALID = new ValidationResult();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ValidationResult_VALID)
         {
            return "VALID";
         }
         §§push(this);
         if(ZPP_Flags.ValidationResult_DEGENERATE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ValidationResult_DEGENERATE = new ValidationResult();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ValidationResult_DEGENERATE)
         {
            return "DEGENERATE";
         }
         §§push(this);
         if(ZPP_Flags.ValidationResult_CONCAVE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ValidationResult_CONCAVE = new ValidationResult();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ValidationResult_CONCAVE)
         {
            return "CONCAVE";
         }
         §§push(this);
         if(ZPP_Flags.ValidationResult_SELF_INTERSECTING == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ValidationResult_SELF_INTERSECTING = new ValidationResult();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ValidationResult_SELF_INTERSECTING)
         {
            return "SELF_INTERSECTING";
         }
         return "";
      }
   }
}
