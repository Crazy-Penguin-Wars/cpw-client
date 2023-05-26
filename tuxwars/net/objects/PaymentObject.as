package tuxwars.net.objects
{
   public class PaymentObject extends JavaScriptCRMObject
   {
       
      
      private var _title:String;
      
      private var _message:String;
      
      private var _purchaseType:String;
      
      public function PaymentObject(packageId:String, toPlatform:String, title:String, message:String, forcedRequest:Boolean = false)
      {
         super("pay",null,filters,toPlatform,forcedRequest);
         _title = title;
         _message = message;
         _purchaseType = "item";
         var orderInfoObject:Object = {};
         orderInfoObject.id = packageId;
         order_info = orderInfoObject;
         product = packageId;
         action = "buy_item";
      }
      
      override public function toString() : String
      {
         return super.toString() + "\npurchase_type: " + purchase_type + ",\ntitle: " + title + ",\nmessage :" + message;
      }
      
      override public function get callType() : String
      {
         return "placeOrder";
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get purchase_type() : String
      {
         return _purchaseType;
      }
   }
}
