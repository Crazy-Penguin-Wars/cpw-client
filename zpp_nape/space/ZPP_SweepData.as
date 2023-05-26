package zpp_nape.space
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.shape.ZPP_Shape;
   
   public class ZPP_SweepData
   {
      
      public static var zpp_pool:ZPP_SweepData = null;
       
      
      public var shape:ZPP_Shape;
      
      public var prev:ZPP_SweepData;
      
      public var next:ZPP_SweepData;
      
      public var aabb:ZPP_AABB;
      
      public function ZPP_SweepData()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         aabb = null;
         shape = null;
         prev = null;
         next = null;
      }
   }
}
