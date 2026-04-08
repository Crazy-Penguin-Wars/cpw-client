package tuxwars.net.objects
{
   public class RequestObject extends JavaScriptCRMObject
   {
      private var _title:String;
      
      private var _message:String;
      
      private var _data:String;
      
      public function RequestObject(param1:Array, param2:Array, param3:String, param4:String, param5:String, param6:String, param7:Boolean = false)
      {
         super("apprequests",param1,param2,param3,param7);
         this._title = param4;
         this._message = param5;
         this._data = param6;
      }
      
      override public function toString() : String
      {
         return super.toString() + ",\ntitle: " + this.title + ",\nmessage :" + this.message + ",\ndata: " + this.data;
      }
      
      override public function get callType() : String
      {
         return "platformSendRequest";
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function get data() : String
      {
         return this._data;
      }
   }
}

