package zpp_nape.space
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_CbSet;
   import zpp_nape.callbacks.ZPP_CbSetPair;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPNode_ZPP_CbSetPair;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZPP_Set_ZPP_CbSet;
   
   public class ZPP_CbSetManager
   {
       
      
      public var space:ZPP_Space;
      
      public var cbsets:ZPP_Set_ZPP_CbSet;
      
      public function ZPP_CbSetManager(param1:ZPP_Space = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         space = null;
         cbsets = null;
         if(ZPP_Set_ZPP_CbSet.zpp_pool == null)
         {
            cbsets = new ZPP_Set_ZPP_CbSet();
         }
         else
         {
            cbsets = ZPP_Set_ZPP_CbSet.zpp_pool;
            ZPP_Set_ZPP_CbSet.zpp_pool = cbsets.next;
            cbsets.next = null;
         }
         cbsets.lt = ZPP_CbSet.setlt;
         space = param1;
      }
      
      public function remove(param1:ZPP_CbSet) : void
      {
         var _loc2_:* = null as ZPP_CbSetPair;
         var _loc3_:* = null as ZPP_CbSetPair;
         var _loc4_:* = null as ZPP_CbSet;
         cbsets.remove(param1);
         while(param1.cbpairs.head != null)
         {
            _loc2_ = param1.cbpairs.pop_unsafe();
            if(_loc2_.a != _loc2_.b)
            {
               if(param1 == _loc2_.a)
               {
                  _loc2_.b.cbpairs.remove(_loc2_);
               }
               else
               {
                  _loc2_.a.cbpairs.remove(_loc2_);
               }
            }
            _loc3_ = _loc2_;
            _loc3_.a = _loc3_.b = null;
            _loc3_.listeners.clear();
            _loc3_.next = ZPP_CbSetPair.zpp_pool;
            ZPP_CbSetPair.zpp_pool = _loc3_;
         }
         param1.manager = null;
      }
      
      public function get(param1:ZNPList_ZPP_CbType) : ZPP_CbSet
      {
         var _loc2_:* = null as ZPP_CbSet;
         var _loc6_:* = null as ZPP_CbSet;
         var _loc7_:* = null as ZPP_CbType;
         if(param1.head == null)
         {
            return null;
         }
         if(ZPP_CbSet.zpp_pool == null)
         {
            _loc2_ = new ZPP_CbSet();
         }
         else
         {
            _loc2_ = ZPP_CbSet.zpp_pool;
            ZPP_CbSet.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         var _loc3_:ZNPList_ZPP_CbType = _loc2_.cbTypes;
         _loc2_.cbTypes = param1;
         var _loc4_:ZPP_Set_ZPP_CbSet = cbsets.find_weak(_loc2_);
         var _loc5_:ZPP_CbSet = _loc4_ != null ? _loc4_.data : (_loc6_ = ZPP_CbSet.get(param1), cbsets.insert(_loc6_), _loc6_.manager = this, _loc6_);
         _loc2_.cbTypes = _loc3_;
         _loc6_ = _loc2_;
         _loc6_.listeners.clear();
         _loc6_.zip_listeners = true;
         _loc6_.bodylisteners.clear();
         _loc6_.zip_bodylisteners = true;
         _loc6_.conlisteners.clear();
         _loc6_.zip_conlisteners = true;
         while(_loc6_.cbTypes.head != null)
         {
            _loc7_ = _loc6_.cbTypes.pop_unsafe();
            _loc7_.cbsets.remove(_loc6_);
         }
         _loc6_.next = ZPP_CbSet.zpp_pool;
         ZPP_CbSet.zpp_pool = _loc6_;
         return _loc5_;
      }
      
      public function clear() : void
      {
      }
   }
}
