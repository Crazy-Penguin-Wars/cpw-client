package com.dchoc.net
{
   import com.adobe.crypto.MD5;
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.utils.getTimer;
   import flash.xml.XMLDocument;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
   import mx.rpc.xml.SimpleXMLDecoder;
   import mx.utils.object_proxy;
   
   public class ServerConnection
   {
      
      public static const RESPONSE_CODE_OK:int = 0;
      
      public static const RESPONSE_CODE_FACEBOOK_SESSION_LOST:int = 4;
      
      public static const FACEBOOK_ERROR_CODE_SESSION_LOST:String = "102";
      
      public static const CONNECTION_ERROR_TYPE_STREAM:String = "2032";
      
      public static const CONNECTION_ERROR_RETRY_TIME:int = 30000;
      
      private static const simpleXMLDecoder:SimpleXMLDecoder = new SimpleXMLDecoder();
       
      
      private var counter:int;
      
      public function ServerConnection()
      {
         super();
      }
      
      public function callService(serviceName:String, parameters:Object) : String
      {
         var _loc3_:String = "call_" + counter++;
         LogUtils.log("Calling server service: " + serviceName + " call id: " + _loc3_,this,1,"Server");
         var _loc4_:HTTPService = new HTTPService(Config.getServerURL());
         _loc4_.xmlDecode = xmlDecoder;
         _loc4_.url = Config.getServerURL();
         if(_loc4_.url.charAt(_loc4_.url.length - 1) != "/")
         {
            _loc4_.url += "/";
         }
         _loc4_.url += serviceName;
         _loc4_.request = parameters;
         _loc4_.request.call_id = _loc3_;
         _loc4_.request.uid = Config.getUserId();
         _loc4_.request.platform = Config.getPlatform();
         _loc4_.request.time = getTimer();
         _loc4_.request.sig = createSignature(_loc4_.request);
         _loc4_.addEventListener("result",resultHandler,false,0,true);
         _loc4_.addEventListener("fault",faultHandler,false,0,true);
         _loc4_.send();
         return _loc3_;
      }
      
      public function resultHandler(event:ResultEvent) : void
      {
         var _loc2_:* = null;
         if(event.result && event.result != "")
         {
            _loc2_ = event.result.object_proxy::object;
            if(!_loc2_.data)
            {
               _loc2_.data = {};
            }
            _loc2_.data.response_code = _loc2_.response_code;
            MessageCenter.sendEvent(new ServerResponse(_loc2_.response_code,_loc2_._serviceId,_loc2_._callId,_loc2_.data,_loc2_.error_msg,_loc2_.maintenance));
         }
         else
         {
            MessageCenter.sendEvent(new ErrorMessage("HTTP Service Error","resultHandler","Service (" + event.token.message.body.call_id + "): " + event.message.toString()));
         }
      }
      
      public function faultHandler(event:FaultEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(checkIfConnectionError(event))
         {
            _loc3_ = getCallId(event);
            _loc2_ = Server.findRequest(_loc3_);
            if(_loc2_ && getTimer() - _loc2_.timeCreated < 30000)
            {
               _loc4_ = callService(_loc2_.serviceId,_loc2_.data);
               _loc2_.callId = _loc4_;
               LogUtils.log("Connection error. Trying again " + _loc2_.serviceId,this,0,"Server");
               return;
            }
         }
         MessageCenter.sendEvent(new ErrorMessage("HTTP Service Error","faultHandler",!!event ? event.message.toString() : "No message"));
      }
      
      private function getCallId(event:FaultEvent) : String
      {
         var _loc4_:* = null;
         _loc4_ = "call%5Fid=";
         var _loc2_:int = int(event.fault.message.indexOf("call%5Fid="));
         var end:int = int(event.fault.message.indexOf("&",_loc2_));
         if(end == -1)
         {
            end = int(event.fault.message.indexOf("\"",_loc2_));
         }
         return event.fault.message.substring(_loc2_ + "call%5Fid=".length,end).replace("%5F","_");
      }
      
      private function checkIfConnectionError(event:FaultEvent) : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var errorCode:* = null;
         if(event != null && event.fault != null && event.fault.faultDetail != null)
         {
            _loc2_ = event.fault.faultDetail.indexOf("text=\"");
            _loc4_ = event.fault.faultDetail.indexOf("URL:",_loc2_);
            if(_loc2_ >= 0 && _loc4_ >= 0 && _loc4_ > _loc2_ + 6)
            {
               errorCode = event.fault.faultDetail.substring(_loc2_ + 6,_loc4_);
            }
            if(errorCode == null || errorCode == "")
            {
               errorCode = "HTTP";
            }
            if(errorCode.indexOf("2032") >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function xmlDecoder(xml:XMLDocument) : Object
      {
         LogUtils.log("---------------------------------------------------------");
         LogUtils.log(xml.toString(),this,1,"ServerResponse");
         LogUtils.log("---------------------------------------------------------");
         var _loc2_:Object = simpleXMLDecoder.decodeXML(xml.firstChild);
         if(_loc2_ && _loc2_.service == "GetAccountInformation")
         {
            LogUtils.log(xml.toString(),this,0,"AccountInformation",false,false,true);
         }
         _loc2_._serviceId = xml.firstChild.attributes.service;
         _loc2_._callId = xml.firstChild.attributes.call_id;
         return _loc2_;
      }
      
      private function createSignature(params:Object) : String
      {
         var _loc2_:Array = createParamMap(params);
         var _loc3_:String = concatSecrets(concatParams(_loc2_));
         LogUtils.log("Request Signature: " + _loc3_,"ServerConnection",1,"Server",false);
         return MD5.hash(_loc3_);
      }
      
      private function concatSecrets(baseString:String) : String
      {
         return baseString + Config.getToken() + "PreCr4c4";
      }
      
      private function concatParams(paramMap:Array) : String
      {
         return paramMap.join("&");
      }
      
      private function createParamMap(params:Object) : Array
      {
         var _loc2_:Array = [];
         for(var key in params)
         {
            _loc2_.push(new Pair(key,params[key]));
         }
         _loc2_.sortOn("key",1);
         return _loc2_;
      }
   }
}

class Pair
{
    
   
   public var key:String;
   
   public var value:String;
   
   public function Pair(key:String, value:String)
   {
      super();
      this.key = key;
      this.value = value;
   }
   
   public function toString() : String
   {
      return key + "=" + value;
   }
}
