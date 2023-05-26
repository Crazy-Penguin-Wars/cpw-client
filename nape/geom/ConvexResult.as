package nape.geom
{
   import flash.Boot;
   import nape.shape.Shape;
   import zpp_nape.geom.ZPP_ConvexRayResult;
   
   public final class ConvexResult
   {
       
      
      public var zpp_inner:ZPP_ConvexRayResult;
      
      public function ConvexResult()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(!ZPP_ConvexRayResult.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: ConvexResult cannot be instantiated derp!";
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
         §§push(§§pop() + §§pop().string(zpp_inner.shape) + " toi: ");
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         return §§pop() + zpp_inner.toiDistance + " }";
      }
      
      public function get toi() : Number
      {
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         return zpp_inner.toiDistance;
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
      
      public function get position() : Vec2
      {
         if(zpp_inner.next != null)
         {
            Boot.lastError = new Error();
            throw "Error: This object has been disposed of and cannot be used";
         }
         return zpp_inner.position;
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
