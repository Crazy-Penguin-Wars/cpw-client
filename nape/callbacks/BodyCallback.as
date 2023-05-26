package nape.callbacks
{
   import flash.Boot;
   import nape.phys.Body;
   import zpp_nape.util.ZPP_Flags;
   
   public final class BodyCallback extends Callback
   {
       
      
      public function BodyCallback()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "Cb:";
         _loc1_ += ["WAKE","SLEEP"][zpp_inner.event - ZPP_Flags.id_CbEvent_WAKE];
         _loc1_ += ":" + zpp_inner.body.outer.toString();
         return _loc1_ + (" : listener: " + Std.string(zpp_inner.listener.outer));
      }
      
      public function get body() : Body
      {
         return zpp_inner.body.outer;
      }
   }
}
