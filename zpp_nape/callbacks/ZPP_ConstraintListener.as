package zpp_nape.callbacks
{
   import flash.Boot;
   import nape.callbacks.ConstraintListener;
   import nape.callbacks.OptionType;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPList_ZPP_ConstraintListener;
   import zpp_nape.util.ZNPNode_ZPP_CbSet;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZNPNode_ZPP_ConstraintListener;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_ConstraintListener extends ZPP_Listener
   {
       
      
      public var outer_zn:ConstraintListener;
      
      public var options:ZPP_OptionType;
      
      public var handler:Function;
      
      public function ZPP_ConstraintListener(param1:OptionType = undefined, param2:int = 0, param3:Function = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         handler = null;
         options = null;
         outer_zn = null;
         super();
         event = param2;
         handler = param3;
         constraint = this;
         type = ZPP_Flags.id_ListenerType_CONSTRAINT;
         options = param1.zpp_inner;
      }
      
      override public function swapEvent(param1:int) : void
      {
         if(param1 != ZPP_Flags.id_CbEvent_WAKE && param1 != ZPP_Flags.id_CbEvent_SLEEP && param1 != ZPP_Flags.id_CbEvent_BREAK)
         {
            Boot.lastError = new Error();
            throw "Error: ConstraintListener event must be either WAKE or SLEEP only";
         }
         removedFromSpace();
         event = param1;
         addedToSpace();
      }
      
      override public function removedFromSpace() : void
      {
         var _loc2_:* = null as ZPP_CbType;
         var _loc3_:* = null as ZNPNode_ZPP_CbSet;
         var _loc4_:* = null as ZPP_CbSet;
         var _loc1_:ZNPNode_ZPP_CbType = options.includes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.conlisteners.remove(this);
            _loc3_ = _loc2_.cbsets.head;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.elt;
               _loc4_.zip_conlisteners = true;
               _loc3_ = _loc3_.next;
            }
            _loc1_ = _loc1_.next;
         }
         options.handler = null;
      }
      
      override public function invalidate_precedence() : void
      {
         if(space != null)
         {
            removedFromSpace();
            addedToSpace();
         }
      }
      
      public function immutable_options() : void
      {
         if(space != null && space.midstep)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot change listener type options during space.step()";
         }
      }
      
      public function cbtype_change(param1:ZPP_CbType, param2:Boolean, param3:Boolean) : void
      {
         var _loc5_:* = null as ZNPNode_ZPP_CbType;
         var _loc6_:* = null as ZNPNode_ZPP_CbType;
         var _loc7_:* = null as ZPP_CbType;
         var _loc8_:* = null as ZNPList_ZPP_CbType;
         var _loc9_:* = null as ZNPNode_ZPP_CbType;
         var _loc10_:Boolean = false;
         removedFromSpace();
         var _loc4_:ZPP_OptionType = options;
         if(param2)
         {
            if(param3)
            {
               _loc5_ = null;
               _loc6_ = _loc4_.includes.head;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_.elt;
                  if(param1.id < _loc7_.id)
                  {
                     break;
                  }
                  _loc5_ = _loc6_;
                  _loc6_ = _loc6_.next;
               }
               _loc8_ = _loc4_.includes;
               if(ZNPNode_ZPP_CbType.zpp_pool == null)
               {
                  _loc9_ = new ZNPNode_ZPP_CbType();
               }
               else
               {
                  _loc9_ = ZNPNode_ZPP_CbType.zpp_pool;
                  ZNPNode_ZPP_CbType.zpp_pool = _loc9_.next;
                  _loc9_.next = null;
               }
               _loc9_.elt = param1;
               _loc6_ = _loc9_;
               if(_loc5_ == null)
               {
                  _loc6_.next = _loc8_.head;
                  _loc8_.head = _loc6_;
               }
               else
               {
                  _loc6_.next = _loc5_.next;
                  _loc5_.next = _loc6_;
               }
               _loc8_.pushmod = _loc8_.modified = true;
               _loc8_.length = _loc8_.length + 1;
               _loc6_;
            }
            else
            {
               _loc4_.includes.remove(param1);
            }
         }
         else if(param3)
         {
            _loc5_ = null;
            _loc6_ = _loc4_.excludes.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(param1.id < _loc7_.id)
               {
                  break;
               }
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.next;
            }
            _loc8_ = _loc4_.excludes;
            if(ZNPNode_ZPP_CbType.zpp_pool == null)
            {
               _loc9_ = new ZNPNode_ZPP_CbType();
            }
            else
            {
               _loc9_ = ZNPNode_ZPP_CbType.zpp_pool;
               ZNPNode_ZPP_CbType.zpp_pool = _loc9_.next;
               _loc9_.next = null;
            }
            _loc9_.elt = param1;
            _loc6_ = _loc9_;
            if(_loc5_ == null)
            {
               _loc6_.next = _loc8_.head;
               _loc8_.head = _loc6_;
            }
            else
            {
               _loc6_.next = _loc5_.next;
               _loc5_.next = _loc6_;
            }
            _loc8_.pushmod = _loc8_.modified = true;
            _loc8_.length = _loc8_.length + 1;
            _loc6_;
         }
         else
         {
            _loc4_.excludes.remove(param1);
         }
         addedToSpace();
      }
      
      override public function addedToSpace() : void
      {
         var _loc2_:* = null as ZPP_CbType;
         var _loc3_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc4_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc5_:* = null as ZPP_ConstraintListener;
         var _loc6_:* = null as ZNPList_ZPP_ConstraintListener;
         var _loc7_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as ZNPNode_ZPP_CbSet;
         var _loc10_:* = null as ZPP_CbSet;
         options.handler = cbtype_change;
         var _loc1_:ZNPNode_ZPP_CbType = options.includes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc3_ = null;
            _loc4_ = _loc2_.conlisteners.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               if(precedence > _loc5_.precedence || precedence == _loc5_.precedence && id > _loc5_.id)
               {
                  break;
               }
               _loc3_ = _loc4_;
               _loc4_ = _loc4_.next;
            }
            _loc6_ = _loc2_.conlisteners;
            if(ZNPNode_ZPP_ConstraintListener.zpp_pool == null)
            {
               _loc7_ = new ZNPNode_ZPP_ConstraintListener();
            }
            else
            {
               _loc7_ = ZNPNode_ZPP_ConstraintListener.zpp_pool;
               ZNPNode_ZPP_ConstraintListener.zpp_pool = _loc7_.next;
               _loc7_.next = null;
            }
            _loc7_.elt = this;
            _loc4_ = _loc7_;
            if(_loc3_ == null)
            {
               _loc4_.next = _loc6_.head;
               _loc6_.head = _loc4_;
            }
            else
            {
               _loc4_.next = _loc3_.next;
               _loc3_.next = _loc4_;
            }
            _loc6_.pushmod = _loc6_.modified = true;
            _loc6_.length = _loc6_.length + 1;
            _loc4_;
            _loc9_ = _loc2_.cbsets.head;
            while(_loc9_ != null)
            {
               _loc10_ = _loc9_.elt;
               _loc10_.zip_conlisteners = true;
               _loc9_ = _loc9_.next;
            }
            _loc1_ = _loc1_.next;
         }
      }
   }
}
