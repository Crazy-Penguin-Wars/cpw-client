package tuxwars.net.objects
{
   public class RequestObject extends JavaScriptCRMObject
   {
       
      
      private var _title:String;
      
      private var _message:String;
      
      private var _data:String;
      
      public function RequestObject(to:Array, filters:Array, toPlatform:String, title:String, message:String, data:String, forcedRequest:Boolean = false)
      {
         super("apprequests",to,filters,toPlatform,forcedRequest);
         _title = title;
         _message = message;
         _data = data;
      }
      
      override public function toString() : String
      {
         return super.toString() + ",\ntitle: " + title + ",\nmessage :" + message + ",\ndata: " + data;
      }
      
      override public function get callType() : String
      {
         return "platformSendRequest";
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get data() : String
      {
         return _data;
      }
   }
}
