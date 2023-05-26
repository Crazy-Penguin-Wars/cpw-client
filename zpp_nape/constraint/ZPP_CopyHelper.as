package zpp_nape.constraint
{
   import flash.Boot;
   import nape.phys.Body;
   
   public class ZPP_CopyHelper
   {
       
      
      public var id:int;
      
      public var cb:Function;
      
      public var bc:Body;
      
      public function ZPP_CopyHelper()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         cb = null;
         bc = null;
         id = 0;
      }
      
      public static function dict(param1:int, param2:Body) : ZPP_CopyHelper
      {
         var _loc3_:ZPP_CopyHelper = new ZPP_CopyHelper();
         _loc3_.id = param1;
         _loc3_.bc = param2;
         return _loc3_;
      }
      
      public static function todo(param1:int, param2:Function) : ZPP_CopyHelper
      {
         var _loc3_:ZPP_CopyHelper = new ZPP_CopyHelper();
         _loc3_.id = param1;
         _loc3_.cb = param2;
         return _loc3_;
      }
   }
}
