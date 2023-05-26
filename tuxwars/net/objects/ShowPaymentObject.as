package tuxwars.net.objects
{
   public class ShowPaymentObject extends JavaScriptCRMObject
   {
       
      
      private var _currencyType:String;
      
      public function ShowPaymentObject(currencyType:String, method:String = null, to:Array = null, filters:Array = null, toPlatform:String = null, forcedRequest:Boolean = false)
      {
         super(method,to,filters,toPlatform,forcedRequest);
         _currencyType = currencyType;
      }
      
      override public function toString() : String
      {
         return super.toString() + ",\nCurrencyType";
      }
      
      override public function get callType() : String
      {
         return "showPaymentUI";
      }
      
      public function get currencyType() : String
      {
         return _currencyType;
      }
   }
}
