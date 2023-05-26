package mx.utils
{
   import mx.core.mx_internal;
   
   public class ArrayUtil
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
       
      
      public function ArrayUtil()
      {
         super();
      }
      
      public static function toArray(obj:Object) : Array
      {
         if(obj == null)
         {
            return [];
         }
         if(obj is Array)
         {
            return obj as Array;
         }
         return [obj];
      }
      
      public static function getItemIndex(item:Object, source:Array) : int
      {
         var n:int = source.length;
         for(var i:int = 0; i < n; i++)
         {
            if(source[i] === item)
            {
               return i;
            }
         }
         return -1;
      }
   }
}
