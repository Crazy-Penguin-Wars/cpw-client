package zpp_nape.callbacks
{
   import flash.Boot;
   import nape.callbacks.Listener;
   import zpp_nape.ZPP_ID;
   import zpp_nape.space.ZPP_Space;
   
   public class ZPP_Listener
   {
      
      public static var §internal§:Boolean = false;
       
      
      public var type:int;
      
      public var space:ZPP_Space;
      
      public var precedence:int;
      
      public var outer:Listener;
      
      public var interaction:ZPP_InteractionListener;
      
      public var id:int;
      
      public var event:int;
      
      public var constraint:ZPP_ConstraintListener;
      
      public var body:ZPP_BodyListener;
      
      public function ZPP_Listener()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         space = null;
         interaction = null;
         constraint = null;
         body = null;
         precedence = 0;
         event = 0;
         type = 0;
         id = 0;
         outer = null;
         id = ZPP_ID.Listener();
      }
      
      public static function setlt(param1:ZPP_Listener, param2:ZPP_Listener) : Boolean
      {
         return param1.precedence > param2.precedence || param1.precedence == param2.precedence && param1.id > param2.id;
      }
      
      public function swapEvent(param1:int) : void
      {
      }
      
      public function removedFromSpace() : void
      {
      }
      
      public function invalidate_precedence() : void
      {
      }
      
      public function addedToSpace() : void
      {
      }
   }
}
