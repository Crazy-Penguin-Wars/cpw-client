package tuxwars.net.objects
{
   import com.dchoc.utils.LogUtils;
   
   public class JavaScriptObject
   {
       
      
      private var _method:String;
      
      private var _to:Array;
      
      private var _filters:Array;
      
      private var _toPlatform:String;
      
      private var _forcedRequest:Boolean;
      
      public function JavaScriptObject(method:String, to:Array, filters:Array, toPlatform:String, forcedRequest:Boolean = false)
      {
         super();
         _method = method;
         _to = to;
         _filters = filters;
         _toPlatform = toPlatform;
         _forcedRequest = forcedRequest;
      }
      
      public function get callType() : String
      {
         LogUtils.log("Override this method!",this,3,"JavaScriptObject",false,true,true);
         return "";
      }
      
      public function get method() : String
      {
         return _method;
      }
      
      public function get to() : String
      {
         if(_to && _to.length > 0)
         {
            return _to[0];
         }
         return null;
      }
      
      public function get filters() : Array
      {
         return _filters;
      }
      
      public function get toPlatform() : String
      {
         return _toPlatform;
      }
      
      public function get forcedRequest() : Boolean
      {
         return _forcedRequest;
      }
      
      public function toString() : String
      {
         return "method: " + method + ", to: " + to + ", filters: " + filters + ", toPlatform: " + toPlatform + ", forcedRequest: " + forcedRequest;
      }
   }
}
