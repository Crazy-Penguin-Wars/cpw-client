package mx.resources
{
   import flash.system.ApplicationDomain;
   import mx.core.mx_internal;
   
   public class ResourceBundle implements IResourceBundle
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
      
      mx_internal static var locale:String;
      
      mx_internal static var backupApplicationDomain:ApplicationDomain;
       
      
      mx_internal var _bundleName:String;
      
      private var _content:Object;
      
      mx_internal var _locale:String;
      
      public function ResourceBundle(locale:String = null, bundleName:String = null)
      {
         this._content = {};
         super();
         this.mx_internal::_locale = locale;
         this.mx_internal::_bundleName = bundleName;
         this._content = this.getContent();
      }
      
      private static function getClassByName(name:String, domain:ApplicationDomain) : Class
      {
         var c:Class = null;
         if(domain.hasDefinition(name))
         {
            c = domain.getDefinition(name) as Class;
         }
         return c;
      }
      
      public function get bundleName() : String
      {
         return this.mx_internal::_bundleName;
      }
      
      public function get content() : Object
      {
         return this._content;
      }
      
      public function get locale() : String
      {
         return this.mx_internal::_locale;
      }
      
      protected function getContent() : Object
      {
         return {};
      }
      
      private function _getObject(key:String) : Object
      {
         var value:Object = this.content[key];
         if(!value)
         {
            throw new Error("Key " + key + " was not found in resource bundle " + this.bundleName);
         }
         return value;
      }
   }
}
