package mx.core
{
   import mx.resources.ResourceManager;
   
   public class FlexVersion
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
      
      public static const CURRENT_VERSION:uint = 67436544;
      
      public static const VERSION_4_5:uint = 67436544;
      
      public static const VERSION_4_0:uint = 67108864;
      
      public static const VERSION_3_0:uint = 50331648;
      
      public static const VERSION_2_0_1:uint = 33554433;
      
      public static const VERSION_2_0:uint = 33554432;
      
      public static const VERSION_ALREADY_SET:String = "versionAlreadySet";
      
      public static const VERSION_ALREADY_READ:String = "versionAlreadyRead";
      
      private static var _compatibilityErrorFunction:Function;
      
      private static var _compatibilityVersion:uint = CURRENT_VERSION;
      
      private static var compatibilityVersionChanged:Boolean = false;
      
      private static var compatibilityVersionRead:Boolean = false;
       
      
      public function FlexVersion()
      {
         super();
      }
      
      public static function get compatibilityErrorFunction() : Function
      {
         return _compatibilityErrorFunction;
      }
      
      public static function set compatibilityErrorFunction(value:Function) : void
      {
         _compatibilityErrorFunction = value;
      }
      
      public static function get compatibilityVersion() : uint
      {
         compatibilityVersionRead = true;
         return _compatibilityVersion;
      }
      
      public static function set compatibilityVersion(value:uint) : void
      {
         var s:String = null;
         if(value == _compatibilityVersion)
         {
            return;
         }
         if(compatibilityVersionChanged)
         {
            if(compatibilityErrorFunction == null)
            {
               s = ResourceManager.getInstance().getString("core",VERSION_ALREADY_SET);
               throw new Error(s);
            }
            compatibilityErrorFunction(value,VERSION_ALREADY_SET);
         }
         if(compatibilityVersionRead)
         {
            if(compatibilityErrorFunction == null)
            {
               s = ResourceManager.getInstance().getString("core",VERSION_ALREADY_READ);
               throw new Error(s);
            }
            compatibilityErrorFunction(value,VERSION_ALREADY_READ);
         }
         _compatibilityVersion = value;
         compatibilityVersionChanged = true;
      }
      
      public static function get compatibilityVersionString() : String
      {
         var major:uint = compatibilityVersion >> 24 & 255;
         var minor:uint = compatibilityVersion >> 16 & 255;
         var update:uint = compatibilityVersion & 65535;
         return major.toString() + "." + minor.toString() + "." + update.toString();
      }
      
      public static function set compatibilityVersionString(value:String) : void
      {
         var pieces:Array = value.split(".");
         var major:uint = parseInt(pieces[0]);
         var minor:uint = parseInt(pieces[1]);
         var update:uint = parseInt(pieces[2]);
         compatibilityVersion = (major << 24) + (minor << 16) + update;
      }
      
      mx_internal static function changeCompatibilityVersionString(value:String) : void
      {
         var pieces:Array = value.split(".");
         var major:uint = parseInt(pieces[0]);
         var minor:uint = parseInt(pieces[1]);
         var update:uint = parseInt(pieces[2]);
         _compatibilityVersion = (major << 24) + (minor << 16) + update;
      }
   }
}
