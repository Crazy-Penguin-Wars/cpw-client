package mx.rpc.http
{
   import mx.core.mx_internal;
   import mx.messaging.ChannelSet;
   import mx.messaging.config.LoaderConfig;
   import mx.rpc.AbstractInvoker;
   import mx.rpc.AsyncRequest;
   import mx.rpc.AsyncToken;
   import mx.utils.URLUtil;
   
   public class HTTPService extends AbstractInvoker
   {
      
      public static const RESULT_FORMAT_E4X:String = "e4x";
      
      public static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
      
      public static const RESULT_FORMAT_OBJECT:String = "object";
      
      public static const RESULT_FORMAT_ARRAY:String = "array";
      
      public static const RESULT_FORMAT_TEXT:String = "text";
      
      public static const RESULT_FORMAT_XML:String = "xml";
      
      public static const CONTENT_TYPE_XML:String = "application/xml";
      
      public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
      
      public static const DEFAULT_DESTINATION_HTTP:String = "DefaultHTTP";
      
      public static const DEFAULT_DESTINATION_HTTPS:String = "DefaultHTTPS";
      
      public static const ERROR_URL_REQUIRED:String = "Client.URLRequired";
      
      public static const ERROR_DECODING:String = "Client.CouldNotDecode";
      
      public static const ERROR_ENCODING:String = "Client.CouldNotEncode";
       
      
      mx_internal var operation:AbstractOperation;
      
      public function HTTPService(rootURL:String = null, destination:String = null)
      {
         super();
         this.mx_internal::operation = new HTTPOperation(this);
         this.mx_internal::operation.makeObjectsBindable = true;
         this.mx_internal::operation.mx_internal::_rootURL = rootURL;
         if(destination == null)
         {
            if(URLUtil.isHttpsURL(LoaderConfig.url))
            {
               this.mx_internal::asyncRequest.destination = DEFAULT_DESTINATION_HTTPS;
            }
            else
            {
               this.mx_internal::asyncRequest.destination = DEFAULT_DESTINATION_HTTP;
            }
         }
         else
         {
            this.mx_internal::asyncRequest.destination = destination;
            this.useProxy = true;
         }
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.mx_internal::operation.addEventListener(type,listener,useCapture,priority,useWeakReference);
         super.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         this.mx_internal::operation.removeEventListener(type,listener,useCapture);
         super.removeEventListener(type,listener,useCapture);
      }
      
      override mx_internal function set asyncRequest(ar:AsyncRequest) : void
      {
         this.mx_internal::operation.mx_internal::asyncRequest = ar;
      }
      
      override mx_internal function get asyncRequest() : AsyncRequest
      {
         return this.mx_internal::operation.mx_internal::asyncRequest;
      }
      
      public function get channelSet() : ChannelSet
      {
         return this.mx_internal::asyncRequest.channelSet;
      }
      
      public function set channelSet(value:ChannelSet) : void
      {
         this.useProxy = true;
         this.mx_internal::asyncRequest.channelSet = value;
      }
      
      public function get contentType() : String
      {
         return this.mx_internal::operation.contentType;
      }
      
      public function set contentType(c:String) : void
      {
         this.mx_internal::operation.contentType = c;
      }
      
      public function get concurrency() : String
      {
         return this.mx_internal::operation.concurrency;
      }
      
      public function set concurrency(c:String) : void
      {
         this.mx_internal::operation.concurrency = c;
      }
      
      public function get destination() : String
      {
         return this.mx_internal::asyncRequest.destination;
      }
      
      public function set destination(value:String) : void
      {
         this.useProxy = true;
         this.mx_internal::asyncRequest.destination = value;
      }
      
      override public function get makeObjectsBindable() : Boolean
      {
         return this.mx_internal::operation.makeObjectsBindable;
      }
      
      override public function set makeObjectsBindable(b:Boolean) : void
      {
         this.mx_internal::operation.makeObjectsBindable = b;
      }
      
      public function get headers() : Object
      {
         return this.mx_internal::operation.headers;
      }
      
      public function set headers(r:Object) : void
      {
         this.mx_internal::operation.headers = r;
      }
      
      public function get method() : String
      {
         return this.mx_internal::operation.method;
      }
      
      public function set method(m:String) : void
      {
         this.mx_internal::operation.method = m;
      }
      
      public function get request() : Object
      {
         return this.mx_internal::operation.request;
      }
      
      public function set request(r:Object) : void
      {
         this.mx_internal::operation.request = r;
      }
      
      public function get resultFormat() : String
      {
         return this.mx_internal::operation.resultFormat;
      }
      
      public function set resultFormat(rf:String) : void
      {
         this.mx_internal::operation.resultFormat = rf;
      }
      
      public function get rootURL() : String
      {
         return this.mx_internal::operation.rootURL;
      }
      
      public function set rootURL(ru:String) : void
      {
         this.mx_internal::operation.rootURL = ru;
      }
      
      public function get showBusyCursor() : Boolean
      {
         return this.mx_internal::operation.showBusyCursor;
      }
      
      public function set showBusyCursor(sbc:Boolean) : void
      {
         this.mx_internal::operation.showBusyCursor = sbc;
      }
      
      public function get serializationFilter() : SerializationFilter
      {
         return this.mx_internal::operation.serializationFilter;
      }
      
      public function set serializationFilter(s:SerializationFilter) : void
      {
         this.mx_internal::operation.serializationFilter = s;
      }
      
      public function get url() : String
      {
         return this.mx_internal::operation.url;
      }
      
      public function set url(u:String) : void
      {
         this.mx_internal::operation.url = u;
      }
      
      public function get useProxy() : Boolean
      {
         return this.mx_internal::operation.useProxy;
      }
      
      public function set useProxy(u:Boolean) : void
      {
         this.mx_internal::operation.useProxy = u;
      }
      
      public function get xmlDecode() : Function
      {
         return this.mx_internal::operation.xmlDecode;
      }
      
      public function set xmlDecode(u:Function) : void
      {
         this.mx_internal::operation.xmlDecode = u;
      }
      
      public function get xmlEncode() : Function
      {
         return this.mx_internal::operation.xmlEncode;
      }
      
      public function set xmlEncode(u:Function) : void
      {
         this.mx_internal::operation.xmlEncode = u;
      }
      
      [Bindable("resultForBinding")]
      override public function get lastResult() : Object
      {
         return this.mx_internal::operation.lastResult;
      }
      
      override public function clearResult(fireBindingEvent:Boolean = true) : void
      {
         this.mx_internal::operation.clearResult(fireBindingEvent);
      }
      
      public function get requestTimeout() : int
      {
         return this.mx_internal::asyncRequest.requestTimeout;
      }
      
      public function set requestTimeout(value:int) : void
      {
         if(this.mx_internal::asyncRequest.requestTimeout != value)
         {
            this.mx_internal::asyncRequest.requestTimeout = value;
            if(Boolean(this.mx_internal::operation))
            {
               this.mx_internal::operation.requestTimeout = value;
            }
         }
      }
      
      public function logout() : void
      {
         this.mx_internal::asyncRequest.logout();
      }
      
      public function send(parameters:Object = null) : AsyncToken
      {
         if(parameters == null)
         {
            parameters = this.request;
         }
         return this.mx_internal::operation.sendBody(parameters);
      }
      
      public function disconnect() : void
      {
         this.mx_internal::asyncRequest.disconnect();
      }
      
      public function setCredentials(username:String, password:String, charset:String = null) : void
      {
         this.mx_internal::asyncRequest.setCredentials(username,password,charset);
      }
      
      public function setRemoteCredentials(remoteUsername:String, remotePassword:String, charset:String = null) : void
      {
         this.mx_internal::asyncRequest.setRemoteCredentials(remoteUsername,remotePassword,charset);
      }
      
      override public function cancel(id:String = null) : AsyncToken
      {
         return this.mx_internal::operation.cancel(id);
      }
   }
}

import mx.core.mx_internal;
import mx.rpc.events.AbstractEvent;
import mx.rpc.http.AbstractOperation;
import mx.rpc.http.HTTPService;

class HTTPOperation extends AbstractOperation
{
    
   
   private var httpService:HTTPService;
   
   public function HTTPOperation(httpService:HTTPService, name:String = null)
   {
      super(null,name);
      this.httpService = httpService;
   }
   
   override mx_internal function dispatchRpcEvent(event:AbstractEvent) : void
   {
      if(hasEventListener(event.type))
      {
         event.mx_internal::callTokenResponders();
         if(!event.isDefaultPrevented())
         {
            dispatchEvent(event);
         }
      }
      else if(this.httpService != null)
      {
         this.httpService.mx_internal::dispatchRpcEvent(event);
      }
      else
      {
         event.mx_internal::callTokenResponders();
      }
   }
}
