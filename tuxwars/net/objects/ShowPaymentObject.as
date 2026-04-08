package tuxwars.net.objects
{
   public class ShowPaymentObject extends JavaScriptCRMObject
   {
      private var _currencyType:String;
      
      public function ShowPaymentObject(param1:String, param2:String = null, param3:Array = null, param4:Array = null, param5:String = null, param6:Boolean = false)
      {
         super(param2,param3,param4,param5,param6);
         this._currencyType = param1;
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
         return this._currencyType;
      }
   }
}

