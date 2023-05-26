package mx.logging.errors
{
   import mx.core.mx_internal;
   
   public class InvalidCategoryError extends Error
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
       
      
      public function InvalidCategoryError(message:String)
      {
         super(message);
      }
      
      public function toString() : String
      {
         return String(message);
      }
   }
}
