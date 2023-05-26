package nape.geom
{
   import flash.Boot;
   import nape.shape.Shape;
   import zpp_nape.geom.ZPP_ConvexRayResult;
   
   public final class RayResult
   {
       
      
      public var zpp_inner:ZPP_ConvexRayResult;
      
      public function RayResult()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(!ZPP_ConvexRayResult.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: RayResult cannot be instantiated derp!";
         }
      }
      
      public function toString() : String
      {
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         §§push("{ shape: ");
         §§push(Std);
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         §§push(§§pop() + §§pop().string(zpp_inner.shape) + " distance: ");
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         §§push(§§pop() + zpp_inner.toiDistance + " ?inner: ");
         §§push(Std);
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         return §§pop() + §§pop().string(zpp_inner.inner) + " }";
      }
      
      public function get shape() : Shape
      {
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         return zpp_inner.shape;
      }
      
      public function get normal() : Vec2
      {
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         return zpp_inner.normal;
      }
      
      public function get inner() : Boolean
      {
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         return zpp_inner.inner;
      }
      
      public function get distance() : Number
      {
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         return zpp_inner.toiDistance;
      }
      
      public function dispose() : void
      {
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         zpp_inner.free();
      }
   }
}
