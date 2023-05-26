package zpp_nape.space
{
   import flash.Boot;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.phys.ZPP_Body;
   
   public class ZPP_Component
   {
      
      public static var zpp_pool:ZPP_Component = null;
       
      
      public var woken:Boolean;
      
      public var waket:int;
      
      public var sleeping:Boolean;
      
      public var rank:int;
      
      public var parent:ZPP_Component;
      
      public var next:ZPP_Component;
      
      public var island:ZPP_Island;
      
      public var isBody:Boolean;
      
      public var constraint:ZPP_Constraint;
      
      public var body:ZPP_Body;
      
      public function ZPP_Component()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         woken = false;
         waket = 0;
         sleeping = false;
         island = null;
         constraint = null;
         body = null;
         isBody = false;
         rank = 0;
         parent = null;
         next = null;
         sleeping = false;
         island = null;
         parent = this;
         rank = 0;
         woken = false;
      }
   }
}
