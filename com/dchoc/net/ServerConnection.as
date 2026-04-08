package com.dchoc.net
{
   import com.adobe.crypto.*;
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.utils.*;
   import flash.xml.XMLDocument;
   import mx.rpc.events.*;
   import mx.rpc.http.*;
   import mx.rpc.xml.*;
   import mx.utils.object_proxy;
   
   use namespace object_proxy;
   
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
      
      public function callService(param1:String, param2:Object) : String
      {
         var _loc3_:String = "call_" + this.counter++;
         LogUtils.log("Calling server service: " + param1 + " call id: " + _loc3_,this,1,"Server");
         var _loc4_:HTTPService = new HTTPService(Config.getServerURL());
         _loc4_.xmlDecode = this.xmlDecoder;
         _loc4_.url = Config.getServerURL();
         if(_loc4_.url.charAt(_loc4_.url.length - 1) != "/")
         {
            _loc4_.url += "/";
         }
         _loc4_.url += param1;
         _loc4_.request = param2;
         _loc4_.request.call_id = _loc3_;
         _loc4_.request.uid = Config.getUserId();
         _loc4_.request.platform = Config.getPlatform();
         _loc4_.request.time = getTimer();
         _loc4_.request.sig = this.createSignature(_loc4_.request);
         _loc4_.addEventListener("result",this.resultHandler,false,0,true);
         _loc4_.addEventListener("fault",this.faultHandler,false,0,true);
         _loc4_.send();
         return _loc3_;
      }
      
      public function resultHandler(param1:ResultEvent) : void
      {
         var _loc2_:Object = null;
         if(Boolean(param1.result) && param1.result != "")
         {
            _loc2_ = param1.result.object_proxy::object;
            if(!_loc2_.data)
            {
               _loc2_.data = {};
            }
            _loc2_.data.response_code = _loc2_.response_code;
            MessageCenter.sendEvent(new ServerResponse(_loc2_.response_code,_loc2_._serviceId,_loc2_._callId,_loc2_.data,_loc2_.error_msg,_loc2_.maintenance));
         }
         else
         {
            MessageCenter.sendEvent(new ErrorMessage("HTTP Service Error","resultHandler","Service (" + param1.token.message.body.call_id + "): " + param1.message.toString()));
         }
      }
      
      public function faultHandler(param1:FaultEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ServerRequest = null;
         var _loc4_:String = null;
         if(this.checkIfConnectionError(param1))
         {
            _loc2_ = this.getCallId(param1);
            _loc3_ = Server.findRequest(_loc2_);
            if(Boolean(_loc3_) && getTimer() - _loc3_.timeCreated < 30000)
            {
               _loc4_ = this.callService(_loc3_.serviceId,_loc3_.data);
               _loc3_.callId = _loc4_;
               LogUtils.log("Connection error. Trying again " + _loc3_.serviceId,this,0,"Server");
               return;
            }
         }
         MessageCenter.sendEvent(new ErrorMessage("HTTP Service Error","faultHandler",!!param1 ? param1.message.toString() : "No message"));
      }
      
      private function getCallId(param1:FaultEvent) : String
      {
         var _loc2_:String = null;
         _loc2_ = "call%5Fid=";
         var _loc3_:int = int(param1.fault.message.indexOf("call%5Fid="));
         var _loc4_:int = int(param1.fault.message.indexOf("&",_loc3_));
         if(_loc4_ == -1)
         {
            _loc4_ = int(param1.fault.message.indexOf("\"",_loc3_));
         }
         return param1.fault.message.substring(_loc3_ + "call%5Fid=".length,_loc4_).replace("%5F","_");
      }
      
      private function checkIfConnectionError(param1:FaultEvent) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(param1 != null && param1.fault != null && param1.fault.faultDetail != null)
         {
            _loc2_ = int(param1.fault.faultDetail.indexOf("text=\""));
            _loc3_ = int(param1.fault.faultDetail.indexOf("URL:",_loc2_));
            if(_loc2_ >= 0 && _loc3_ >= 0 && _loc3_ > _loc2_ + 6)
            {
               _loc4_ = param1.fault.faultDetail.substring(_loc2_ + 6,_loc3_);
            }
            if(_loc4_ == null || _loc4_ == "")
            {
               _loc4_ = "HTTP";
            }
            if(_loc4_.indexOf("2032") >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function xmlDecoder(param1:XMLDocument) : Object
      {
         LogUtils.log("---------------------------------------------------------");
         LogUtils.log(param1.toString(),this,1,"ServerResponse");
         LogUtils.log("---------------------------------------------------------");
         var _loc2_:Object = simpleXMLDecoder.decodeXML(param1.firstChild);
         if(Boolean(_loc2_) && _loc2_.service == "GetAccountInformation")
         {
            LogUtils.log(param1.toString(),this,0,"AccountInformation",false,false,true);
         }
         _loc2_._serviceId = param1.firstChild.attributes.service;
         _loc2_._callId = param1.firstChild.attributes.call_id;
         return _loc2_;
      }
      
      private function createSignature(param1:Object) : String
      {
         var _loc2_:Array = this.createParamMap(param1);
         var _loc3_:String = this.concatSecrets(this.concatParams(_loc2_));
         LogUtils.log("Request Signature: " + _loc3_,"ServerConnection",1,"Server",false);
         return MD5.hash(_loc3_);
      }
      
      private function concatSecrets(param1:String) : String
      {
         return param1 + Config.getToken() + "PreCr4c4";
      }
      
      private function concatParams(param1:Array) : String
      {
         return param1.join("&");
      }
      
      private function createParamMap(param1:Object) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc2_.push(new Pair(_loc3_,param1[_loc3_]));
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
   
   public function Pair(param1:String, param2:String)
   {
      super();
      this.key = param1;
      this.value = param2;
   }
   
   public function toString() : String
   {
      return this.key + "=" + this.value;
   }
}
