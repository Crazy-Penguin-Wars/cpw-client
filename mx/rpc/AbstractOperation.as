package mx.rpc
{
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.rpc.events.AbstractEvent;
   
   public class AbstractOperation extends AbstractInvoker
   {
       
      
      public var arguments:Object;
      
      public var properties:Object;
      
      private var resourceManager:IResourceManager;
      
      mx_internal var _service:AbstractService;
      
      private var _name:String;
      
      public function AbstractOperation(service:AbstractService = null, name:String = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this.mx_internal::_service = service;
         this._name = name;
         this.arguments = {};
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(n:String) : void
      {
         var message:String = null;
         if(!this._name)
         {
            this._name = n;
            return;
         }
         message = this.resourceManager.getString("rpc","cannotResetOperationName");
         throw new Error(message);
      }
      
      public function get service() : AbstractService
      {
         return this.mx_internal::_service;
      }
      
      mx_internal function setService(s:AbstractService) : void
      {
         var message:String = null;
         if(!this.mx_internal::_service)
         {
            this.mx_internal::_service = s;
            return;
         }
         message = this.resourceManager.getString("rpc","cannotResetService");
         throw new Error(message);
      }
      
      public function send(... args) : AsyncToken
      {
         return null;
      }
      
      override mx_internal function dispatchRpcEvent(event:AbstractEvent) : void
      {
         event.mx_internal::callTokenResponders();
         if(!event.isDefaultPrevented())
         {
            if(hasEventListener(event.type))
            {
               dispatchEvent(event);
            }
            else if(this.mx_internal::_service != null)
            {
               this.mx_internal::_service.dispatchEvent(event);
            }
         }
      }
   }
}
