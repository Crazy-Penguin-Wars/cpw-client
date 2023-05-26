package zpp_nape.geom
{
   import flash.Boot;
   
   public class ZPP_CutInt
   {
      
      public static var zpp_pool:ZPP_CutInt = null;
       
      
      public var virtualint:Boolean;
      
      public var vertex:Boolean;
      
      public var time:Number;
      
      public var start:ZPP_GeomVert;
      
      public var path1:ZPP_CutVert;
      
      public var path0:ZPP_CutVert;
      
      public var next:ZPP_CutInt;
      
      public var end:ZPP_GeomVert;
      
      public function ZPP_CutInt()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         path1 = null;
         start = null;
         end = null;
         path0 = null;
         vertex = false;
         virtualint = false;
         time = 0;
         next = null;
      }
      
      public static function get(param1:Number, param2:ZPP_GeomVert = undefined, param3:ZPP_GeomVert = undefined, param4:ZPP_CutVert = undefined, param5:ZPP_CutVert = undefined, param6:Boolean = false, param7:Boolean = false) : ZPP_CutInt
      {
         var _loc8_:* = null as ZPP_CutInt;
         if(ZPP_CutInt.zpp_pool == null)
         {
            _loc8_ = new ZPP_CutInt();
         }
         else
         {
            _loc8_ = ZPP_CutInt.zpp_pool;
            ZPP_CutInt.zpp_pool = _loc8_.next;
            _loc8_.next = null;
         }
         _loc8_.virtualint = param6;
         _loc8_.end = param2;
         _loc8_.start = param3;
         _loc8_.path0 = param4;
         _loc8_.path1 = param5;
         _loc8_.time = param1;
         _loc8_.vertex = param7;
         return _loc8_;
      }
   }
}
