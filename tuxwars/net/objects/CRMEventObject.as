package tuxwars.net.objects
{
   import com.dchoc.utils.*;
   
   public class CRMEventObject extends JavaScriptObject
   {
      private var _group:String;
      
      private var _type:String;
      
      private var _parameters:Object;
      
      public function CRMEventObject(param1:String, param2:String, param3:Object)
      {
         super(null,null,null,null);
         this._group = param1;
         this._type = param2;
         this._parameters = param3;
      }
      
      override public function get callType() : String
      {
         return "crmTrackEvent";
      }
      
      override public function toString() : String
      {
         return "group = " + this.group + ", type = " + this.type + ", parameters: " + DCUtils.objectToString(this._parameters);
      }
      
      public function get group() : String
      {
         return this._group;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get parameters() : Object
      {
         return this._parameters;
      }
   }
}

