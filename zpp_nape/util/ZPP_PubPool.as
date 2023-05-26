package zpp_nape.util
{
   import nape.geom.GeomPoly;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   
   public class ZPP_PubPool
   {
      
      public static var poolGeomPoly:GeomPoly = null;
      
      public static var nextGeomPoly:GeomPoly = null;
      
      public static var poolVec2:Vec2 = null;
      
      public static var nextVec2:Vec2 = null;
      
      public static var poolVec3:Vec3 = null;
      
      public static var nextVec3:Vec3 = null;
       
      
      public function ZPP_PubPool()
      {
      }
   }
}
