package tuxwars.net.objects
{
   public class PaymentObject extends JavaScriptCRMObject
   {
      private var _title:String;
      
      private var _message:String;
      
      private var _purchaseType:String;
      
      public function PaymentObject(param1:String, param2:String, param3:String, param4:String, param5:Boolean = false)
      {
         super("pay",null,filters,param2,param5);
         this._title = param3;
         this._message = param4;
         this._purchaseType = "item";
         var _loc6_:Object = {};
         _loc6_.id = param1;
         order_info = _loc6_;
         product = param1;
         action = "buy_item";
      }
      
      override public function toString() : String
      {
         return super.toString() + "\npurchase_type: " + this.purchase_type + ",\ntitle: " + this.title + ",\nmessage :" + this.message;
      }
      
      override public function get callType() : String
      {
         return "placeOrder";
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function get purchase_type() : String
      {
         return this._purchaseType;
      }
   }
}

