package zpp_nape.geom
{
   import flash.Boot;
   
   public class ZPP_MarchSpan
   {
      
      public static var zpp_pool:ZPP_MarchSpan = null;
       
      
      public var rank:int;
      
      public var parent:ZPP_MarchSpan;
      
      public var out:Boolean;
      
      public var next:ZPP_MarchSpan;
      
      public function ZPP_MarchSpan()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         next = null;
         out = false;
         rank = 0;
         parent = null;
         parent = this;
      }
   }
}
