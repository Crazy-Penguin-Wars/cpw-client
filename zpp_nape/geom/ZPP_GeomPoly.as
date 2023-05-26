package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.GeomPoly;
   
   public class ZPP_GeomPoly
   {
       
      
      public var vertices:ZPP_GeomVert;
      
      public var outer:GeomPoly;
      
      public function ZPP_GeomPoly(param1:GeomPoly = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         vertices = null;
         outer = null;
         outer = param1;
      }
   }
}
