package zpp_nape.callbacks
{
   import flash.Boot;
   import nape.callbacks.InteractionListener;
   import nape.callbacks.OptionType;
   import nape.callbacks.PreListener;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_CbSet;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPList_ZPP_InteractionListener;
   import zpp_nape.util.ZNPNode_ZPP_CbSet;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZNPNode_ZPP_InteractionListener;
   import zpp_nape.util.ZNPNode_ZPP_Interactor;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_Set_ZPP_CbSetPair;
   
   public class ZPP_InteractionListener extends ZPP_Listener
   {
      
      public static var UCbSet:ZNPList_ZPP_CbSet = new ZNPList_ZPP_CbSet();
      
      public static var VCbSet:ZNPList_ZPP_CbSet = new ZNPList_ZPP_CbSet();
      
      public static var WCbSet:ZNPList_ZPP_CbSet = new ZNPList_ZPP_CbSet();
      
      public static var UCbType:ZNPList_ZPP_CbType = new ZNPList_ZPP_CbType();
      
      public static var VCbType:ZNPList_ZPP_CbType = new ZNPList_ZPP_CbType();
      
      public static var WCbType:ZNPList_ZPP_CbType = new ZNPList_ZPP_CbType();
       
      
      public var pure:Boolean;
      
      public var outer_znp:PreListener;
      
      public var outer_zni:InteractionListener;
      
      public var options2:ZPP_OptionType;
      
      public var options1:ZPP_OptionType;
      
      public var itype:int;
      
      public var handlerp:Object;
      
      public var handleri:Object;
      
      public var allowSleepingCallbacks:Boolean;
      
      public function ZPP_InteractionListener(param1:OptionType = undefined, param2:OptionType = undefined, param3:int = 0, param4:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         handlerp = null;
         pure = false;
         allowSleepingCallbacks = false;
         handleri = null;
         options2 = null;
         options1 = null;
         itype = 0;
         outer_znp = null;
         outer_zni = null;
         super();
         type = param4;
         interaction = this;
         event = param3;
         options1 = param1.zpp_inner;
         options2 = param2.zpp_inner;
         allowSleepingCallbacks = false;
      }
      
      public function with_uniquesets(param1:Boolean) : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 3375
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      public function wake() : void
      {
         var _loc3_:* = null as ZPP_CbType;
         var _loc4_:* = null as ZPP_CbType;
         var _loc5_:* = null as ZNPNode_ZPP_Interactor;
         var _loc6_:* = null as ZPP_Interactor;
         var _loc1_:ZNPNode_ZPP_CbType = options1.includes.head;
         var _loc2_:ZNPNode_ZPP_CbType = options2.includes.head;
         while(_loc1_ != null && _loc2_ != null)
         {
            _loc3_ = _loc1_.elt;
            _loc4_ = _loc2_.elt;
            if(_loc3_ == _loc4_)
            {
               _loc5_ = _loc3_.interactors.head;
               while(_loc5_ != null)
               {
                  _loc6_ = _loc5_.elt;
                  _loc6_.wake();
                  _loc5_ = _loc5_.next;
               }
               _loc1_ = _loc1_.next;
               _loc2_ = _loc2_.next;
            }
            else if(_loc3_.id < _loc4_.id)
            {
               _loc5_ = _loc3_.interactors.head;
               while(_loc5_ != null)
               {
                  _loc6_ = _loc5_.elt;
                  _loc6_.wake();
                  _loc5_ = _loc5_.next;
               }
               _loc1_ = _loc1_.next;
            }
            else
            {
               _loc5_ = _loc4_.interactors.head;
               while(_loc5_ != null)
               {
                  _loc6_ = _loc5_.elt;
                  _loc6_.wake();
                  _loc5_ = _loc5_.next;
               }
               _loc2_ = _loc2_.next;
            }
         }
         while(_loc1_ != null)
         {
            _loc5_ = _loc1_.elt.interactors.head;
            while(_loc5_ != null)
            {
               _loc6_ = _loc5_.elt;
               _loc6_.wake();
               _loc5_ = _loc5_.next;
            }
            _loc1_ = _loc1_.next;
         }
         while(_loc2_ != null)
         {
            _loc5_ = _loc2_.elt.interactors.head;
            while(_loc5_ != null)
            {
               _loc6_ = _loc5_.elt;
               _loc6_.wake();
               _loc5_ = _loc5_.next;
            }
            _loc2_ = _loc2_.next;
         }
      }
      
      override public function swapEvent(param1:int) : void
      {
         if(type == ZPP_Flags.id_ListenerType_PRE)
         {
            Boot.lastError = new Error();
            throw "Error: PreListener event can only be PRE";
         }
         if(param1 != ZPP_Flags.id_CbEvent_BEGIN && param1 != ZPP_Flags.id_CbEvent_END && param1 != ZPP_Flags.id_CbEvent_ONGOING)
         {
            Boot.lastError = new Error();
            throw "Error: InteractionListener event must be either BEGIN, END, ONGOING";
         }
         removedFromSpace();
         event = param1;
         addedToSpace();
      }
      
      override public function removedFromSpace() : void
      {
         var _loc5_:* = null as ZPP_CbType;
         var _loc6_:* = null as ZPP_CbType;
         var _loc7_:* = null as ZNPNode_ZPP_CbSet;
         var _loc8_:* = null as ZPP_CbSet;
         var _loc9_:* = null as ZNPNode_ZPP_Interactor;
         var _loc10_:* = null as ZPP_Interactor;
         var _loc1_:ZPP_InteractionListener = this;
         with_uniquesets(false);
         var _loc2_:Boolean = type == ZPP_Flags.id_ListenerType_PRE;
         var _loc3_:ZNPNode_ZPP_CbType = options1.includes.head;
         var _loc4_:ZNPNode_ZPP_CbType = options2.includes.head;
         while(_loc3_ != null && _loc4_ != null)
         {
            _loc5_ = _loc3_.elt;
            _loc6_ = _loc4_.elt;
            if(_loc5_ == _loc6_)
            {
               _loc5_.listeners.remove(_loc1_);
               _loc7_ = _loc5_.cbsets.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc8_.zip_listeners = true;
                  _loc8_.invalidate_pairs();
                  _loc7_ = _loc7_.next;
               }
               if(_loc2_)
               {
                  _loc9_ = _loc5_.interactors.head;
                  while(_loc9_ != null)
                  {
                     _loc10_ = _loc9_.elt;
                     _loc10_.wake();
                     _loc9_ = _loc9_.next;
                  }
               }
               _loc3_ = _loc3_.next;
               _loc4_ = _loc4_.next;
            }
            else if(_loc5_.id < _loc6_.id)
            {
               _loc5_.listeners.remove(_loc1_);
               _loc7_ = _loc5_.cbsets.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc8_.zip_listeners = true;
                  _loc8_.invalidate_pairs();
                  _loc7_ = _loc7_.next;
               }
               if(_loc2_)
               {
                  _loc9_ = _loc5_.interactors.head;
                  while(_loc9_ != null)
                  {
                     _loc10_ = _loc9_.elt;
                     _loc10_.wake();
                     _loc9_ = _loc9_.next;
                  }
               }
               _loc3_ = _loc3_.next;
            }
            else
            {
               _loc6_.listeners.remove(_loc1_);
               _loc7_ = _loc6_.cbsets.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc8_.zip_listeners = true;
                  _loc8_.invalidate_pairs();
                  _loc7_ = _loc7_.next;
               }
               if(_loc2_)
               {
                  _loc9_ = _loc6_.interactors.head;
                  while(_loc9_ != null)
                  {
                     _loc10_ = _loc9_.elt;
                     _loc10_.wake();
                     _loc9_ = _loc9_.next;
                  }
               }
               _loc4_ = _loc4_.next;
            }
         }
         while(_loc3_ != null)
         {
            _loc5_ = _loc3_.elt;
            _loc5_.listeners.remove(_loc1_);
            _loc7_ = _loc5_.cbsets.head;
            while(_loc7_ != null)
            {
               _loc8_ = _loc7_.elt;
               _loc8_.zip_listeners = true;
               _loc8_.invalidate_pairs();
               _loc7_ = _loc7_.next;
            }
            if(_loc2_)
            {
               _loc9_ = _loc5_.interactors.head;
               while(_loc9_ != null)
               {
                  _loc10_ = _loc9_.elt;
                  _loc10_.wake();
                  _loc9_ = _loc9_.next;
               }
            }
            _loc3_ = _loc3_.next;
         }
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc5_.listeners.remove(_loc1_);
            _loc7_ = _loc5_.cbsets.head;
            while(_loc7_ != null)
            {
               _loc8_ = _loc7_.elt;
               _loc8_.zip_listeners = true;
               _loc8_.invalidate_pairs();
               _loc7_ = _loc7_.next;
            }
            if(_loc2_)
            {
               _loc9_ = _loc5_.interactors.head;
               while(_loc9_ != null)
               {
                  _loc10_ = _loc9_.elt;
                  _loc10_.wake();
                  _loc9_ = _loc9_.next;
               }
            }
            _loc4_ = _loc4_.next;
         }
         options1.handler = null;
         options2.handler = null;
      }
      
      override public function invalidate_precedence() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:* = null as ZNPNode_ZPP_CbType;
         var _loc4_:* = null as ZNPNode_ZPP_CbType;
         var _loc5_:* = null as ZPP_CbType;
         var _loc6_:* = null as ZPP_CbType;
         var _loc7_:* = null as ZNPNode_ZPP_CbSet;
         var _loc8_:* = null as ZPP_CbSet;
         var _loc9_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc10_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc11_:* = null as ZPP_InteractionListener;
         var _loc12_:* = null as ZNPList_ZPP_InteractionListener;
         var _loc13_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc14_:Boolean = false;
         var _loc15_:* = null as ZNPNode_ZPP_Interactor;
         var _loc16_:* = null as ZPP_Interactor;
         var _loc1_:ZPP_InteractionListener = this;
         if(space != null)
         {
            _loc2_ = type == ZPP_Flags.id_ListenerType_PRE;
            _loc3_ = options1.includes.head;
            _loc4_ = options2.includes.head;
            while(_loc3_ != null && _loc4_ != null)
            {
               _loc5_ = _loc3_.elt;
               _loc6_ = _loc4_.elt;
               if(_loc5_ == _loc6_)
               {
                  _loc5_.listeners.remove(_loc1_);
                  _loc7_ = _loc5_.cbsets.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     _loc8_.zip_listeners = true;
                     _loc8_.invalidate_pairs();
                     _loc7_ = _loc7_.next;
                  }
                  _loc9_ = null;
                  _loc10_ = _loc5_.listeners.head;
                  while(_loc10_ != null)
                  {
                     _loc11_ = _loc10_.elt;
                     if(_loc1_.precedence > _loc11_.precedence || _loc1_.precedence == _loc11_.precedence && _loc1_.id > _loc11_.id)
                     {
                        break;
                     }
                     _loc9_ = _loc10_;
                     _loc10_ = _loc10_.next;
                  }
                  _loc12_ = _loc5_.listeners;
                  if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                  {
                     _loc13_ = new ZNPNode_ZPP_InteractionListener();
                  }
                  else
                  {
                     _loc13_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                     ZNPNode_ZPP_InteractionListener.zpp_pool = _loc13_.next;
                     _loc13_.next = null;
                  }
                  _loc13_.elt = _loc1_;
                  _loc10_ = _loc13_;
                  if(_loc9_ == null)
                  {
                     _loc10_.next = _loc12_.head;
                     _loc12_.head = _loc10_;
                  }
                  else
                  {
                     _loc10_.next = _loc9_.next;
                     _loc9_.next = _loc10_;
                  }
                  _loc12_.pushmod = _loc12_.modified = true;
                  _loc12_.length = _loc12_.length + 1;
                  _loc10_;
                  _loc7_ = _loc5_.cbsets.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     _loc8_.zip_listeners = true;
                     _loc8_.invalidate_pairs();
                     _loc7_ = _loc7_.next;
                  }
                  if(_loc2_)
                  {
                     _loc15_ = _loc5_.interactors.head;
                     while(_loc15_ != null)
                     {
                        _loc16_ = _loc15_.elt;
                        _loc16_.wake();
                        _loc15_ = _loc15_.next;
                     }
                  }
                  _loc3_ = _loc3_.next;
                  _loc4_ = _loc4_.next;
               }
               else if(_loc5_.id < _loc6_.id)
               {
                  _loc5_.listeners.remove(_loc1_);
                  _loc7_ = _loc5_.cbsets.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     _loc8_.zip_listeners = true;
                     _loc8_.invalidate_pairs();
                     _loc7_ = _loc7_.next;
                  }
                  _loc9_ = null;
                  _loc10_ = _loc5_.listeners.head;
                  while(_loc10_ != null)
                  {
                     _loc11_ = _loc10_.elt;
                     if(_loc1_.precedence > _loc11_.precedence || _loc1_.precedence == _loc11_.precedence && _loc1_.id > _loc11_.id)
                     {
                        break;
                     }
                     _loc9_ = _loc10_;
                     _loc10_ = _loc10_.next;
                  }
                  _loc12_ = _loc5_.listeners;
                  if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                  {
                     _loc13_ = new ZNPNode_ZPP_InteractionListener();
                  }
                  else
                  {
                     _loc13_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                     ZNPNode_ZPP_InteractionListener.zpp_pool = _loc13_.next;
                     _loc13_.next = null;
                  }
                  _loc13_.elt = _loc1_;
                  _loc10_ = _loc13_;
                  if(_loc9_ == null)
                  {
                     _loc10_.next = _loc12_.head;
                     _loc12_.head = _loc10_;
                  }
                  else
                  {
                     _loc10_.next = _loc9_.next;
                     _loc9_.next = _loc10_;
                  }
                  _loc12_.pushmod = _loc12_.modified = true;
                  _loc12_.length = _loc12_.length + 1;
                  _loc10_;
                  _loc7_ = _loc5_.cbsets.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     _loc8_.zip_listeners = true;
                     _loc8_.invalidate_pairs();
                     _loc7_ = _loc7_.next;
                  }
                  if(_loc2_)
                  {
                     _loc15_ = _loc5_.interactors.head;
                     while(_loc15_ != null)
                     {
                        _loc16_ = _loc15_.elt;
                        _loc16_.wake();
                        _loc15_ = _loc15_.next;
                     }
                  }
                  _loc3_ = _loc3_.next;
               }
               else
               {
                  _loc6_.listeners.remove(_loc1_);
                  _loc7_ = _loc6_.cbsets.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     _loc8_.zip_listeners = true;
                     _loc8_.invalidate_pairs();
                     _loc7_ = _loc7_.next;
                  }
                  _loc9_ = null;
                  _loc10_ = _loc6_.listeners.head;
                  while(_loc10_ != null)
                  {
                     _loc11_ = _loc10_.elt;
                     if(_loc1_.precedence > _loc11_.precedence || _loc1_.precedence == _loc11_.precedence && _loc1_.id > _loc11_.id)
                     {
                        break;
                     }
                     _loc9_ = _loc10_;
                     _loc10_ = _loc10_.next;
                  }
                  _loc12_ = _loc6_.listeners;
                  if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                  {
                     _loc13_ = new ZNPNode_ZPP_InteractionListener();
                  }
                  else
                  {
                     _loc13_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                     ZNPNode_ZPP_InteractionListener.zpp_pool = _loc13_.next;
                     _loc13_.next = null;
                  }
                  _loc13_.elt = _loc1_;
                  _loc10_ = _loc13_;
                  if(_loc9_ == null)
                  {
                     _loc10_.next = _loc12_.head;
                     _loc12_.head = _loc10_;
                  }
                  else
                  {
                     _loc10_.next = _loc9_.next;
                     _loc9_.next = _loc10_;
                  }
                  _loc12_.pushmod = _loc12_.modified = true;
                  _loc12_.length = _loc12_.length + 1;
                  _loc10_;
                  _loc7_ = _loc6_.cbsets.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     _loc8_.zip_listeners = true;
                     _loc8_.invalidate_pairs();
                     _loc7_ = _loc7_.next;
                  }
                  if(_loc2_)
                  {
                     _loc15_ = _loc6_.interactors.head;
                     while(_loc15_ != null)
                     {
                        _loc16_ = _loc15_.elt;
                        _loc16_.wake();
                        _loc15_ = _loc15_.next;
                     }
                  }
                  _loc4_ = _loc4_.next;
               }
            }
            while(_loc3_ != null)
            {
               _loc5_ = _loc3_.elt;
               _loc5_.listeners.remove(_loc1_);
               _loc7_ = _loc5_.cbsets.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc8_.zip_listeners = true;
                  _loc8_.invalidate_pairs();
                  _loc7_ = _loc7_.next;
               }
               _loc9_ = null;
               _loc10_ = _loc5_.listeners.head;
               while(_loc10_ != null)
               {
                  _loc11_ = _loc10_.elt;
                  if(_loc1_.precedence > _loc11_.precedence || _loc1_.precedence == _loc11_.precedence && _loc1_.id > _loc11_.id)
                  {
                     break;
                  }
                  _loc9_ = _loc10_;
                  _loc10_ = _loc10_.next;
               }
               _loc12_ = _loc5_.listeners;
               if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
               {
                  _loc13_ = new ZNPNode_ZPP_InteractionListener();
               }
               else
               {
                  _loc13_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                  ZNPNode_ZPP_InteractionListener.zpp_pool = _loc13_.next;
                  _loc13_.next = null;
               }
               _loc13_.elt = _loc1_;
               _loc10_ = _loc13_;
               if(_loc9_ == null)
               {
                  _loc10_.next = _loc12_.head;
                  _loc12_.head = _loc10_;
               }
               else
               {
                  _loc10_.next = _loc9_.next;
                  _loc9_.next = _loc10_;
               }
               _loc12_.pushmod = _loc12_.modified = true;
               _loc12_.length = _loc12_.length + 1;
               _loc10_;
               _loc7_ = _loc5_.cbsets.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc8_.zip_listeners = true;
                  _loc8_.invalidate_pairs();
                  _loc7_ = _loc7_.next;
               }
               if(_loc2_)
               {
                  _loc15_ = _loc5_.interactors.head;
                  while(_loc15_ != null)
                  {
                     _loc16_ = _loc15_.elt;
                     _loc16_.wake();
                     _loc15_ = _loc15_.next;
                  }
               }
               _loc3_ = _loc3_.next;
            }
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               _loc5_.listeners.remove(_loc1_);
               _loc7_ = _loc5_.cbsets.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc8_.zip_listeners = true;
                  _loc8_.invalidate_pairs();
                  _loc7_ = _loc7_.next;
               }
               _loc9_ = null;
               _loc10_ = _loc5_.listeners.head;
               while(_loc10_ != null)
               {
                  _loc11_ = _loc10_.elt;
                  if(_loc1_.precedence > _loc11_.precedence || _loc1_.precedence == _loc11_.precedence && _loc1_.id > _loc11_.id)
                  {
                     break;
                  }
                  _loc9_ = _loc10_;
                  _loc10_ = _loc10_.next;
               }
               _loc12_ = _loc5_.listeners;
               if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
               {
                  _loc13_ = new ZNPNode_ZPP_InteractionListener();
               }
               else
               {
                  _loc13_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                  ZNPNode_ZPP_InteractionListener.zpp_pool = _loc13_.next;
                  _loc13_.next = null;
               }
               _loc13_.elt = _loc1_;
               _loc10_ = _loc13_;
               if(_loc9_ == null)
               {
                  _loc10_.next = _loc12_.head;
                  _loc12_.head = _loc10_;
               }
               else
               {
                  _loc10_.next = _loc9_.next;
                  _loc9_.next = _loc10_;
               }
               _loc12_.pushmod = _loc12_.modified = true;
               _loc12_.length = _loc12_.length + 1;
               _loc10_;
               _loc7_ = _loc5_.cbsets.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc8_.zip_listeners = true;
                  _loc8_.invalidate_pairs();
                  _loc7_ = _loc7_.next;
               }
               if(_loc2_)
               {
                  _loc15_ = _loc5_.interactors.head;
                  while(_loc15_ != null)
                  {
                     _loc16_ = _loc15_.elt;
                     _loc16_.wake();
                     _loc15_ = _loc15_.next;
                  }
               }
               _loc4_ = _loc4_.next;
            }
         }
      }
      
      public function cbtype_change2(param1:ZPP_CbType, param2:Boolean, param3:Boolean) : void
      {
         cbtype_change(options2,param1,param2,param3);
      }
      
      public function cbtype_change1(param1:ZPP_CbType, param2:Boolean, param3:Boolean) : void
      {
         cbtype_change(options1,param1,param2,param3);
      }
      
      public function cbtype_change(param1:ZPP_OptionType, param2:ZPP_CbType, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:* = null as ZNPNode_ZPP_CbType;
         var _loc6_:* = null as ZNPNode_ZPP_CbType;
         var _loc7_:* = null as ZPP_CbType;
         var _loc8_:* = null as ZNPList_ZPP_CbType;
         var _loc9_:* = null as ZNPNode_ZPP_CbType;
         var _loc10_:Boolean = false;
         removedFromSpace();
         if(param3)
         {
            if(param4)
            {
               _loc5_ = null;
               _loc6_ = param1.includes.head;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_.elt;
                  if(param2.id < _loc7_.id)
                  {
                     break;
                  }
                  _loc5_ = _loc6_;
                  _loc6_ = _loc6_.next;
               }
               _loc8_ = param1.includes;
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
               _loc9_.elt = param2;
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
               param1.includes.remove(param2);
            }
         }
         else if(param4)
         {
            _loc5_ = null;
            _loc6_ = param1.excludes.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(param2.id < _loc7_.id)
               {
                  break;
               }
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.next;
            }
            _loc8_ = param1.excludes;
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
            _loc9_.elt = param2;
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
            param1.excludes.remove(param2);
         }
         addedToSpace();
      }
      
      override public function addedToSpace() : void
      {
         var _loc5_:* = null as ZPP_CbType;
         var _loc6_:* = null as ZPP_CbType;
         var _loc7_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc8_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc9_:* = null as ZPP_InteractionListener;
         var _loc10_:* = null as ZNPList_ZPP_InteractionListener;
         var _loc11_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc12_:Boolean = false;
         var _loc13_:* = null as ZNPNode_ZPP_CbSet;
         var _loc14_:* = null as ZPP_CbSet;
         var _loc15_:* = null as ZNPNode_ZPP_Interactor;
         var _loc16_:* = null as ZPP_Interactor;
         var _loc1_:ZPP_InteractionListener = this;
         var _loc2_:Boolean = type == ZPP_Flags.id_ListenerType_PRE;
         var _loc3_:ZNPNode_ZPP_CbType = options1.includes.head;
         var _loc4_:ZNPNode_ZPP_CbType = options2.includes.head;
         while(_loc3_ != null && _loc4_ != null)
         {
            _loc5_ = _loc3_.elt;
            _loc6_ = _loc4_.elt;
            if(_loc5_ == _loc6_)
            {
               _loc7_ = null;
               _loc8_ = _loc5_.listeners.head;
               while(_loc8_ != null)
               {
                  _loc9_ = _loc8_.elt;
                  if(_loc1_.precedence > _loc9_.precedence || _loc1_.precedence == _loc9_.precedence && _loc1_.id > _loc9_.id)
                  {
                     break;
                  }
                  _loc7_ = _loc8_;
                  _loc8_ = _loc8_.next;
               }
               _loc10_ = _loc5_.listeners;
               if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
               {
                  _loc11_ = new ZNPNode_ZPP_InteractionListener();
               }
               else
               {
                  _loc11_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                  ZNPNode_ZPP_InteractionListener.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.elt = _loc1_;
               _loc8_ = _loc11_;
               if(_loc7_ == null)
               {
                  _loc8_.next = _loc10_.head;
                  _loc10_.head = _loc8_;
               }
               else
               {
                  _loc8_.next = _loc7_.next;
                  _loc7_.next = _loc8_;
               }
               _loc10_.pushmod = _loc10_.modified = true;
               _loc10_.length = _loc10_.length + 1;
               _loc8_;
               _loc13_ = _loc5_.cbsets.head;
               while(_loc13_ != null)
               {
                  _loc14_ = _loc13_.elt;
                  _loc14_.zip_listeners = true;
                  _loc14_.invalidate_pairs();
                  _loc13_ = _loc13_.next;
               }
               if(_loc2_)
               {
                  _loc15_ = _loc5_.interactors.head;
                  while(_loc15_ != null)
                  {
                     _loc16_ = _loc15_.elt;
                     _loc16_.wake();
                     _loc15_ = _loc15_.next;
                  }
               }
               _loc3_ = _loc3_.next;
               _loc4_ = _loc4_.next;
            }
            else if(_loc5_.id < _loc6_.id)
            {
               _loc7_ = null;
               _loc8_ = _loc5_.listeners.head;
               while(_loc8_ != null)
               {
                  _loc9_ = _loc8_.elt;
                  if(_loc1_.precedence > _loc9_.precedence || _loc1_.precedence == _loc9_.precedence && _loc1_.id > _loc9_.id)
                  {
                     break;
                  }
                  _loc7_ = _loc8_;
                  _loc8_ = _loc8_.next;
               }
               _loc10_ = _loc5_.listeners;
               if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
               {
                  _loc11_ = new ZNPNode_ZPP_InteractionListener();
               }
               else
               {
                  _loc11_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                  ZNPNode_ZPP_InteractionListener.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.elt = _loc1_;
               _loc8_ = _loc11_;
               if(_loc7_ == null)
               {
                  _loc8_.next = _loc10_.head;
                  _loc10_.head = _loc8_;
               }
               else
               {
                  _loc8_.next = _loc7_.next;
                  _loc7_.next = _loc8_;
               }
               _loc10_.pushmod = _loc10_.modified = true;
               _loc10_.length = _loc10_.length + 1;
               _loc8_;
               _loc13_ = _loc5_.cbsets.head;
               while(_loc13_ != null)
               {
                  _loc14_ = _loc13_.elt;
                  _loc14_.zip_listeners = true;
                  _loc14_.invalidate_pairs();
                  _loc13_ = _loc13_.next;
               }
               if(_loc2_)
               {
                  _loc15_ = _loc5_.interactors.head;
                  while(_loc15_ != null)
                  {
                     _loc16_ = _loc15_.elt;
                     _loc16_.wake();
                     _loc15_ = _loc15_.next;
                  }
               }
               _loc3_ = _loc3_.next;
            }
            else
            {
               _loc7_ = null;
               _loc8_ = _loc6_.listeners.head;
               while(_loc8_ != null)
               {
                  _loc9_ = _loc8_.elt;
                  if(_loc1_.precedence > _loc9_.precedence || _loc1_.precedence == _loc9_.precedence && _loc1_.id > _loc9_.id)
                  {
                     break;
                  }
                  _loc7_ = _loc8_;
                  _loc8_ = _loc8_.next;
               }
               _loc10_ = _loc6_.listeners;
               if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
               {
                  _loc11_ = new ZNPNode_ZPP_InteractionListener();
               }
               else
               {
                  _loc11_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                  ZNPNode_ZPP_InteractionListener.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.elt = _loc1_;
               _loc8_ = _loc11_;
               if(_loc7_ == null)
               {
                  _loc8_.next = _loc10_.head;
                  _loc10_.head = _loc8_;
               }
               else
               {
                  _loc8_.next = _loc7_.next;
                  _loc7_.next = _loc8_;
               }
               _loc10_.pushmod = _loc10_.modified = true;
               _loc10_.length = _loc10_.length + 1;
               _loc8_;
               _loc13_ = _loc6_.cbsets.head;
               while(_loc13_ != null)
               {
                  _loc14_ = _loc13_.elt;
                  _loc14_.zip_listeners = true;
                  _loc14_.invalidate_pairs();
                  _loc13_ = _loc13_.next;
               }
               if(_loc2_)
               {
                  _loc15_ = _loc6_.interactors.head;
                  while(_loc15_ != null)
                  {
                     _loc16_ = _loc15_.elt;
                     _loc16_.wake();
                     _loc15_ = _loc15_.next;
                  }
               }
               _loc4_ = _loc4_.next;
            }
         }
         while(_loc3_ != null)
         {
            _loc5_ = _loc3_.elt;
            _loc7_ = null;
            _loc8_ = _loc5_.listeners.head;
            while(_loc8_ != null)
            {
               _loc9_ = _loc8_.elt;
               if(_loc1_.precedence > _loc9_.precedence || _loc1_.precedence == _loc9_.precedence && _loc1_.id > _loc9_.id)
               {
                  break;
               }
               _loc7_ = _loc8_;
               _loc8_ = _loc8_.next;
            }
            _loc10_ = _loc5_.listeners;
            if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
            {
               _loc11_ = new ZNPNode_ZPP_InteractionListener();
            }
            else
            {
               _loc11_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
               ZNPNode_ZPP_InteractionListener.zpp_pool = _loc11_.next;
               _loc11_.next = null;
            }
            _loc11_.elt = _loc1_;
            _loc8_ = _loc11_;
            if(_loc7_ == null)
            {
               _loc8_.next = _loc10_.head;
               _loc10_.head = _loc8_;
            }
            else
            {
               _loc8_.next = _loc7_.next;
               _loc7_.next = _loc8_;
            }
            _loc10_.pushmod = _loc10_.modified = true;
            _loc10_.length = _loc10_.length + 1;
            _loc8_;
            _loc13_ = _loc5_.cbsets.head;
            while(_loc13_ != null)
            {
               _loc14_ = _loc13_.elt;
               _loc14_.zip_listeners = true;
               _loc14_.invalidate_pairs();
               _loc13_ = _loc13_.next;
            }
            if(_loc2_)
            {
               _loc15_ = _loc5_.interactors.head;
               while(_loc15_ != null)
               {
                  _loc16_ = _loc15_.elt;
                  _loc16_.wake();
                  _loc15_ = _loc15_.next;
               }
            }
            _loc3_ = _loc3_.next;
         }
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc7_ = null;
            _loc8_ = _loc5_.listeners.head;
            while(_loc8_ != null)
            {
               _loc9_ = _loc8_.elt;
               if(_loc1_.precedence > _loc9_.precedence || _loc1_.precedence == _loc9_.precedence && _loc1_.id > _loc9_.id)
               {
                  break;
               }
               _loc7_ = _loc8_;
               _loc8_ = _loc8_.next;
            }
            _loc10_ = _loc5_.listeners;
            if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
            {
               _loc11_ = new ZNPNode_ZPP_InteractionListener();
            }
            else
            {
               _loc11_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
               ZNPNode_ZPP_InteractionListener.zpp_pool = _loc11_.next;
               _loc11_.next = null;
            }
            _loc11_.elt = _loc1_;
            _loc8_ = _loc11_;
            if(_loc7_ == null)
            {
               _loc8_.next = _loc10_.head;
               _loc10_.head = _loc8_;
            }
            else
            {
               _loc8_.next = _loc7_.next;
               _loc7_.next = _loc8_;
            }
            _loc10_.pushmod = _loc10_.modified = true;
            _loc10_.length = _loc10_.length + 1;
            _loc8_;
            _loc13_ = _loc5_.cbsets.head;
            while(_loc13_ != null)
            {
               _loc14_ = _loc13_.elt;
               _loc14_.zip_listeners = true;
               _loc14_.invalidate_pairs();
               _loc13_ = _loc13_.next;
            }
            if(_loc2_)
            {
               _loc15_ = _loc5_.interactors.head;
               while(_loc15_ != null)
               {
                  _loc16_ = _loc15_.elt;
                  _loc16_.wake();
                  _loc15_ = _loc15_.next;
               }
            }
            _loc4_ = _loc4_.next;
         }
         options1.handler = cbtype_change1;
         options2.handler = cbtype_change2;
         with_uniquesets(true);
      }
   }
}
