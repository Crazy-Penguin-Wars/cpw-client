package tuxwars.net.objects
{
   import com.dchoc.utils.DCUtils;
   
   public class CRMEventObject extends JavaScriptObject
   {
       
      
      private var _group:String;
      
      private var _type:String;
      
      private var _parameters:Object;
      
      public function CRMEventObject(group:String, type:String, parameters:Object)
      {
         super(null,null,null,null);
         _group = group;
         _type = type;
         _parameters = parameters;
      }
      
      override public function get callType() : String
      {
         return "crmTrackEvent";
      }
      
      override public function toString() : String
      {
         return "group = " + group + ", type = " + type + ", parameters: " + DCUtils.objectToString(_parameters);
      }
      
      public function get group() : String
      {
         return _group;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get parameters() : Object
      {
         return _parameters;
      }
   }
}
