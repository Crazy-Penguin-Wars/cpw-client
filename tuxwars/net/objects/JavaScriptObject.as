package tuxwars.net.objects
{
   import com.dchoc.utils.*;
   
   public class JavaScriptObject
   {
      private var _method:String;
      
      private var _to:Array;
      
      private var _filters:Array;
      
      private var _toPlatform:String;
      
      private var _forcedRequest:Boolean;
      
      public function JavaScriptObject(param1:String, param2:Array, param3:Array, param4:String, param5:Boolean = false)
      {
         super();
         this._method = param1;
         this._to = param2;
         this._filters = param3;
         this._toPlatform = param4;
         this._forcedRequest = param5;
      }
      
      public function get callType() : String
      {
         LogUtils.log("Override this method!",this,3,"JavaScriptObject",false,true,true);
         return "";
      }
      
      public function get method() : String
      {
         return this._method;
      }
      
      public function get to() : String
      {
         if(Boolean(this._to) && this._to.length > 0)
         {
            return this._to[0];
         }
         return null;
      }
      
      public function get filters() : Array
      {
         return this._filters;
      }
      
      public function get toPlatform() : String
      {
         return this._toPlatform;
      }
      
      public function get forcedRequest() : Boolean
      {
         return this._forcedRequest;
      }
      
      public function toString() : String
      {
         return "method: " + this.method + ", to: " + this.to + ", filters: " + this.filters + ", toPlatform: " + this.toPlatform + ", forcedRequest: " + this.forcedRequest;
      }
   }
}

