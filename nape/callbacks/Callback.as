package nape.callbacks
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_Callback;
   import zpp_nape.util.ZPP_Flags;
   
   public class Callback
   {
       
      
      public var zpp_inner:ZPP_Callback;
      
      public function Callback()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(!ZPP_Callback.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Callback cannot be instantiated derp!";
         }
      }
      
      public function toString() : String
      {
         return "";
      }
      
      public function get listener() : Listener
      {
         return zpp_inner.listener.outer;
      }
      
      public function get event() : CbEvent
      {
         if(ZPP_Flags.CbEvent_BEGIN == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_BEGIN = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.CbEvent_BEGIN);
         if(ZPP_Flags.CbEvent_END == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_END = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.CbEvent_END);
         if(ZPP_Flags.CbEvent_WAKE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_WAKE = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.CbEvent_WAKE);
         if(ZPP_Flags.CbEvent_SLEEP == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_SLEEP = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.CbEvent_SLEEP);
         if(ZPP_Flags.CbEvent_BREAK == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_BREAK = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.CbEvent_BREAK);
         if(ZPP_Flags.CbEvent_PRE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_PRE = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.CbEvent_PRE);
         if(ZPP_Flags.CbEvent_ONGOING == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_ONGOING = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.event];
      }
   }
}
