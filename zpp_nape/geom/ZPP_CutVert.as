package zpp_nape.geom
{
   import flash.Boot;
   
   public class ZPP_CutVert
   {
      
      public static var zpp_pool:ZPP_CutVert = null;
       
      
      public var vert:ZPP_GeomVert;
      
      public var value:Number;
      
      public var used:Boolean;
      
      public var rank:int;
      
      public var prev:ZPP_CutVert;
      
      public var posy:Number;
      
      public var posx:Number;
      
      public var positive:Boolean;
      
      public var parent:ZPP_CutVert;
      
      public var next:ZPP_CutVert;
      
      public function ZPP_CutVert()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         used = false;
         rank = 0;
         parent = null;
         positive = false;
         value = 0;
         vert = null;
         posy = 0;
         posx = 0;
         next = null;
         prev = null;
      }
      
      public static function path(param1:ZPP_GeomVert) : ZPP_CutVert
      {
         var _loc2_:* = null as ZPP_CutVert;
         if(ZPP_CutVert.zpp_pool == null)
         {
            _loc2_ = new ZPP_CutVert();
         }
         else
         {
            _loc2_ = ZPP_CutVert.zpp_pool;
            ZPP_CutVert.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         _loc2_.vert = param1;
         _loc2_.parent = _loc2_;
         _loc2_.rank = 0;
         _loc2_.used = false;
         return _loc2_;
      }
   }
}
