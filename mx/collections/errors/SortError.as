package mx.collections.errors
{
   import mx.core.mx_internal;
   
   public class SortError extends Error
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
       
      
      public function SortError(message:String)
      {
         super(message);
      }
   }
}
