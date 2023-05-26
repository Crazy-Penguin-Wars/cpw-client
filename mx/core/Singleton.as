package mx.core
{
   public class Singleton
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
      
      private static var classMap:Object = {};
       
      
      public function Singleton()
      {
         super();
      }
      
      public static function registerClass(interfaceName:String, clazz:Class) : void
      {
         var c:Class = classMap[interfaceName];
         if(!c)
         {
            classMap[interfaceName] = clazz;
         }
      }
      
      public static function getClass(interfaceName:String) : Class
      {
         return classMap[interfaceName];
      }
      
      public static function getInstance(interfaceName:String) : Object
      {
         var c:Class = classMap[interfaceName];
         if(!c)
         {
            throw new Error("No class registered for interface \'" + interfaceName + "\'.");
         }
         return c["getInstance"]();
      }
   }
}
