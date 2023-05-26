package nape.callbacks
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_BodyListener;
   import zpp_nape.callbacks.ZPP_Listener;
   import zpp_nape.callbacks.ZPP_OptionType;
   import zpp_nape.util.ZPP_Flags;
   
   public final class BodyListener extends Listener
   {
       
      
      public var zpp_inner_zn:ZPP_BodyListener;
      
      public function BodyListener(param1:CbEvent, param2:*, param3:Function, param4:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = null;
         ZPP_Listener.§internal§ = true;
         super();
         ZPP_Listener.§internal§ = false;
         if(param3 == null)
         {
            Boot.lastError = new Error();
            throw "Error: BodyListener::handler cannot be null";
         }
         var _loc5_:int = -1;
         §§push(param1);
         if(ZPP_Flags.CbEvent_WAKE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_WAKE = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.CbEvent_WAKE)
         {
            _loc5_ = ZPP_Flags.id_CbEvent_WAKE;
         }
         else
         {
            §§push(param1);
            if(ZPP_Flags.CbEvent_SLEEP == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.CbEvent_SLEEP = new CbEvent();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() != ZPP_Flags.CbEvent_SLEEP)
            {
               Boot.lastError = new Error();
               throw "Error: cbEvent \'" + param1.toString() + "\' is not a valid event type for a BodyListener";
            }
            _loc5_ = ZPP_Flags.id_CbEvent_SLEEP;
         }
         zpp_inner_zn = new ZPP_BodyListener(ZPP_OptionType.argument(param2),_loc5_,param3);
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
         zpp_inner_zn.outer_zn = this;
         zpp_inner.precedence = param4;
      }
      
      public function set options(param1:OptionType) : OptionType
      {
         zpp_inner_zn.options.set(param1.zpp_inner);
         return zpp_inner_zn.options.outer;
      }
      
      public function set handler(param1:Function) : Function
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: BodyListener::handler cannot be null";
         }
         zpp_inner_zn.handler = param1;
         return zpp_inner_zn.handler;
      }
      
      public function get options() : OptionType
      {
         return zpp_inner_zn.options.outer;
      }
      
      public function get handler() : Function
      {
         return zpp_inner_zn.handler;
      }
   }
}
