package nape.callbacks
{
   import flash.Boot;
   import nape.dynamics.Arbiter;
   import nape.phys.Interactor;
   
   public final class PreCallback extends Callback
   {
       
      
      public function PreCallback()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "Cb:PRE:";
         _loc1_ += ":" + zpp_inner.int1.outer_i.toString() + "/" + zpp_inner.int2.outer_i.toString();
         _loc1_ += " : " + zpp_inner.pre_arbiter.wrapper().toString();
         return _loc1_ + (" : listnener: " + Std.string(zpp_inner.listener.outer));
      }
      
      public function get swapped() : Boolean
      {
         return zpp_inner.pre_swapped;
      }
      
      public function get int2() : Interactor
      {
         return zpp_inner.int2.outer_i;
      }
      
      public function get int1() : Interactor
      {
         return zpp_inner.int1.outer_i;
      }
      
      public function get arbiter() : Arbiter
      {
         return zpp_inner.pre_arbiter.wrapper();
      }
   }
}
