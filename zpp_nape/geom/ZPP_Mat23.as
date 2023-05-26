package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.Mat23;
   
   public class ZPP_Mat23
   {
      
      public static var zpp_pool:ZPP_Mat23 = null;
       
      
      public var ty:Number;
      
      public var tx:Number;
      
      public var outer:Mat23;
      
      public var next:ZPP_Mat23;
      
      public var d:Number;
      
      public var c:Number;
      
      public var b:Number;
      
      public var a:Number;
      
      public var _invalidate:Object;
      
      public function ZPP_Mat23()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         next = null;
         _invalidate = null;
         ty = 0;
         tx = 0;
         d = 0;
         c = 0;
         b = 0;
         a = 0;
         outer = null;
      }
      
      public static function get() : ZPP_Mat23
      {
         var _loc1_:* = null as ZPP_Mat23;
         if(ZPP_Mat23.zpp_pool == null)
         {
            _loc1_ = new ZPP_Mat23();
         }
         else
         {
            _loc1_ = ZPP_Mat23.zpp_pool;
            ZPP_Mat23.zpp_pool = _loc1_.next;
            _loc1_.next = null;
         }
         return _loc1_;
      }
      
      public static function identity() : ZPP_Mat23
      {
         var _loc1_:ZPP_Mat23 = ZPP_Mat23.get();
         _loc1_.setas(1,0,0,1,0,0);
         return _loc1_;
      }
      
      public function wrapper() : Mat23
      {
         var _loc1_:* = null as ZPP_Mat23;
         if(outer == null)
         {
            outer = new Mat23();
            _loc1_ = outer.zpp_inner;
            _loc1_.next = ZPP_Mat23.zpp_pool;
            ZPP_Mat23.zpp_pool = _loc1_;
            outer.zpp_inner = this;
         }
         return outer;
      }
      
      public function setas(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         tx = param5;
         ty = param6;
         a = param1;
         b = param2;
         c = param3;
         d = param4;
      }
   }
}
