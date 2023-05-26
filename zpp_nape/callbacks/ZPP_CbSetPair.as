package zpp_nape.callbacks
{
   import flash.Boot;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPList_ZPP_InteractionListener;
   import zpp_nape.util.ZNPNode_ZPP_InteractionListener;
   
   public class ZPP_CbSetPair
   {
      
      public static var zpp_pool:ZPP_CbSetPair = null;
       
      
      public var zip_listeners:Boolean;
      
      public var next:ZPP_CbSetPair;
      
      public var listeners:ZNPList_ZPP_InteractionListener;
      
      public var b:ZPP_CbSet;
      
      public var a:ZPP_CbSet;
      
      public function ZPP_CbSetPair()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         listeners = null;
         zip_listeners = false;
         next = null;
         b = null;
         a = null;
         listeners = new ZNPList_ZPP_InteractionListener();
      }
      
      public static function get(param1:ZPP_CbSet, param2:ZPP_CbSet) : ZPP_CbSetPair
      {
         var _loc3_:* = null as ZPP_CbSetPair;
         if(ZPP_CbSetPair.zpp_pool == null)
         {
            _loc3_ = new ZPP_CbSetPair();
         }
         else
         {
            _loc3_ = ZPP_CbSetPair.zpp_pool;
            ZPP_CbSetPair.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.zip_listeners = true;
         if(ZPP_CbSet.setlt(param1,param2))
         {
            _loc3_.a = param1;
            _loc3_.b = param2;
         }
         else
         {
            _loc3_.a = param2;
            _loc3_.b = param1;
         }
         return _loc3_;
      }
      
      public static function setlt(param1:ZPP_CbSetPair, param2:ZPP_CbSetPair) : Boolean
      {
         return ZPP_CbSet.setlt(param1.a,param2.a) || param1.a == param2.a && ZPP_CbSet.setlt(param1.b,param2.b);
      }
      
      public function __validate() : void
      {
         var _loc3_:* = null as ZPP_InteractionListener;
         var _loc4_:* = null as ZPP_InteractionListener;
         var _loc5_:* = null as ZPP_OptionType;
         var _loc6_:* = null as ZNPList_ZPP_CbType;
         listeners.clear();
         var _loc1_:ZNPNode_ZPP_InteractionListener = a.listeners.head;
         var _loc2_:ZNPNode_ZPP_InteractionListener = b.listeners.head;
         while(_loc1_ != null && _loc2_ != null)
         {
            _loc3_ = _loc1_.elt;
            _loc4_ = _loc2_.elt;
            if(_loc3_ == _loc4_)
            {
               _loc5_ = _loc3_.options1;
               _loc6_ = a.cbTypes;
               if(_loc5_.nonemptyintersection(_loc6_,_loc5_.includes) && !_loc5_.nonemptyintersection(_loc6_,_loc5_.excludes) && (_loc5_.nonemptyintersection(_loc6_,_loc5_.includes) && !_loc5_.nonemptyintersection(_loc6_,_loc5_.excludes)) || _loc5_.nonemptyintersection(_loc6_,_loc5_.includes) && !_loc5_.nonemptyintersection(_loc6_,_loc5_.excludes) && (_loc5_.nonemptyintersection(_loc6_,_loc5_.includes) && !_loc5_.nonemptyintersection(_loc6_,_loc5_.excludes)))
               {
                  listeners.add(_loc3_);
               }
               _loc1_ = _loc1_.next;
               _loc2_ = _loc2_.next;
            }
            else if(_loc3_.precedence > _loc4_.precedence || _loc3_.precedence == _loc4_.precedence && _loc3_.id > _loc4_.id)
            {
               _loc1_ = _loc1_.next;
            }
            else
            {
               _loc2_ = _loc2_.next;
            }
         }
      }
   }
}
