package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.MatMN;
   
   public class ZPP_MatMN
   {
       
      
      public var x:Vector.<Number>;
      
      public var outer:MatMN;
      
      public var n:int;
      
      public var m:int;
      
      public function ZPP_MatMN(param1:int = 0, param2:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         x = null;
         n = 0;
         m = 0;
         outer = null;
         m = param1;
         n = param2;
         x = new Vector.<Number>(param1 * param2,true);
      }
   }
}
