package mx.collections.errors
{
   import mx.core.mx_internal;
   import mx.rpc.IResponder;
   
   public class ItemPendingError extends Error
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
       
      
      private var _responders:Array;
      
      public function ItemPendingError(message:String)
      {
         super(message);
      }
      
      public function get responders() : Array
      {
         return this._responders;
      }
      
      public function addResponder(responder:IResponder) : void
      {
         if(!this._responders)
         {
            this._responders = [];
         }
         this._responders.push(responder);
      }
   }
}
