package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.constraint.ZPP_Constraint;
   
   public class ZNPNode_ZPP_Constraint
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Constraint = null;
       
      
      public var next:ZNPNode_ZPP_Constraint;
      
      public var elt:ZPP_Constraint;
      
      public function ZNPNode_ZPP_Constraint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         elt = null;
         next = null;
      }
   }
}
