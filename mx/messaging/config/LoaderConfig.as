package mx.messaging.config
{
   import flash.display.DisplayObject;
   import mx.core.mx_internal;
   import mx.utils.LoaderUtil;
   
   public class LoaderConfig
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
      
      mx_internal static var _parameters:Object;
      
      mx_internal static var _swfVersion:uint;
      
      mx_internal static var _url:String = null;
       
      
      public function LoaderConfig()
      {
         super();
      }
      
      public static function init(root:DisplayObject) : void
      {
         if(!mx_internal::_url)
         {
            mx_internal::_url = LoaderUtil.normalizeURL(root.loaderInfo);
            mx_internal::_parameters = root.loaderInfo.parameters;
            mx_internal::_swfVersion = root.loaderInfo.swfVersion;
         }
      }
      
      public static function get parameters() : Object
      {
         return mx_internal::_parameters;
      }
      
      public static function get swfVersion() : uint
      {
         return mx_internal::_swfVersion;
      }
      
      public static function get url() : String
      {
         return mx_internal::_url;
      }
   }
}
