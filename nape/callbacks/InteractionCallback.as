package nape.callbacks
{
   import flash.Boot;
   import nape.dynamics.ArbiterList;
   import nape.phys.Interactor;
   
   public final class InteractionCallback extends Callback
   {
       
      
      public function InteractionCallback()
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
         _loc1_ += ["BEGIN","END","","","","","ONGOING"][zpp_inner.event];
         _loc1_ += ":" + zpp_inner.int1.outer_i.toString() + "/" + zpp_inner.int2.outer_i.toString();
         _loc1_ += " : " + zpp_inner.wrap_arbiters.toString();
         return _loc1_ + (" : listener: " + Std.string(zpp_inner.listener.outer));
      }
      
      public function get int2() : Interactor
      {
         return zpp_inner.int2.outer_i;
      }
      
      public function get int1() : Interactor
      {
         return zpp_inner.int1.outer_i;
      }
      
      public function get arbiters() : ArbiterList
      {
         return zpp_inner.wrap_arbiters;
      }
   }
}
