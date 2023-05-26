package zpp_nape.space
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.shape.ZPP_Shape;
   
   public class ZPP_AABBNode
   {
      
      public static var zpp_pool:ZPP_AABBNode = null;
       
      
      public var synced:Boolean;
      
      public var snext:ZPP_AABBNode;
      
      public var shape:ZPP_Shape;
      
      public var rayt:Number;
      
      public var parent:ZPP_AABBNode;
      
      public var next:ZPP_AABBNode;
      
      public var moved:Boolean;
      
      public var mnext:ZPP_AABBNode;
      
      public var height:int;
      
      public var first_sync:Boolean;
      
      public var dyn:Boolean;
      
      public var child2:ZPP_AABBNode;
      
      public var child1:ZPP_AABBNode;
      
      public var aabb:ZPP_AABB;
      
      public function ZPP_AABBNode()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         first_sync = false;
         synced = false;
         snext = null;
         moved = false;
         mnext = null;
         next = null;
         rayt = 0;
         height = 0;
         child2 = null;
         child1 = null;
         parent = null;
         dyn = false;
         shape = null;
         aabb = null;
         height = -1;
      }
   }
}
