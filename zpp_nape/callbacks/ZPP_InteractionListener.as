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
      public static var UCbSet:ZNPList_ZPP_CbSet;
      
      public static var VCbSet:ZNPList_ZPP_CbSet;
      
      public static var WCbSet:ZNPList_ZPP_CbSet;
      
      public static var UCbType:ZNPList_ZPP_CbType;
      
      public static var VCbType:ZNPList_ZPP_CbType;
      
      public static var WCbType:ZNPList_ZPP_CbType;
      
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
         var _loc3_:* = null as ZPP_Set_ZPP_CbSetPair;
         var _loc10_:* = null as ZPP_CbType;
         var _loc11_:* = null as ZPP_CbType;
         var _loc12_:* = null as ZNPNode_ZPP_CbType;
         var _loc13_:* = null as ZNPNode_ZPP_CbType;
         var _loc14_:* = null as ZNPList_ZPP_CbSet;
         var _loc15_:* = null as ZNPList_ZPP_CbSet;
         var _loc16_:* = null as ZNPList_ZPP_CbSet;
         var _loc17_:* = null as ZNPList_ZPP_CbSet;
         var _loc18_:* = null as ZNPNode_ZPP_CbSet;
         var _loc19_:* = null as ZNPNode_ZPP_CbSet;
         var _loc20_:* = null as ZPP_CbSet;
         var _loc21_:* = null as ZPP_CbSet;
         var _loc22_:* = null as ZNPNode_ZPP_CbSet;
         var _loc23_:* = null as ZNPNode_ZPP_CbSet;
         var _loc24_:* = null as ZPP_CbSetPair;
         var _loc25_:* = null as ZPP_Set_ZPP_CbSetPair;
         var _loc26_:* = null as ZPP_CbSetPair;
         var _loc27_:* = null as ZPP_Set_ZPP_CbSetPair;
         var _loc28_:* = null as ZPP_Set_ZPP_CbSetPair;
         var _loc2_:ZPP_InteractionListener = this;
         if(ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
         {
            _loc3_ = new ZPP_Set_ZPP_CbSetPair();
         }
         else
         {
            _loc3_ = ZPP_Set_ZPP_CbSetPair.zpp_pool;
            ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         null;
         _loc3_.lt = ZPP_CbSetPair.setlt;
         var _loc4_:ZNPList_ZPP_CbType = options2.includes;
         var _loc5_:ZNPList_ZPP_CbType = ZPP_InteractionListener.UCbType;
         var _loc6_:ZNPList_ZPP_CbType = ZPP_InteractionListener.VCbType;
         var _loc7_:ZNPList_ZPP_CbType = ZPP_InteractionListener.WCbType;
         var _loc8_:ZNPNode_ZPP_CbType = options1.includes.head;
         var _loc9_:ZNPNode_ZPP_CbType = _loc4_.head;
         while(_loc8_ != null && _loc9_ != null)
         {
            _loc10_ = _loc8_.elt;
            _loc11_ = _loc9_.elt;
            if(_loc10_ == _loc11_)
            {
               if(ZNPNode_ZPP_CbType.zpp_pool == null)
               {
                  _loc13_ = new ZNPNode_ZPP_CbType();
               }
               else
               {
                  _loc13_ = ZNPNode_ZPP_CbType.zpp_pool;
                  ZNPNode_ZPP_CbType.zpp_pool = _loc13_.next;
                  _loc13_.next = null;
               }
               null;
               _loc13_.elt = _loc10_;
               _loc12_ = _loc13_;
               _loc12_.next = _loc7_.head;
               _loc7_.head = _loc12_;
               _loc7_.modified = true;
               ++_loc7_.length;
               _loc10_;
               _loc8_ = _loc8_.next;
               _loc9_ = _loc9_.next;
            }
            else if(_loc10_.id < _loc11_.id)
            {
               if(ZNPNode_ZPP_CbType.zpp_pool == null)
               {
                  _loc13_ = new ZNPNode_ZPP_CbType();
               }
               else
               {
                  _loc13_ = ZNPNode_ZPP_CbType.zpp_pool;
                  ZNPNode_ZPP_CbType.zpp_pool = _loc13_.next;
                  _loc13_.next = null;
               }
               null;
               _loc13_.elt = _loc10_;
               _loc12_ = _loc13_;
               _loc12_.next = _loc5_.head;
               _loc5_.head = _loc12_;
               _loc5_.modified = true;
               ++_loc5_.length;
               _loc10_;
               _loc8_ = _loc8_.next;
            }
            else
            {
               if(ZNPNode_ZPP_CbType.zpp_pool == null)
               {
                  _loc13_ = new ZNPNode_ZPP_CbType();
               }
               else
               {
                  _loc13_ = ZNPNode_ZPP_CbType.zpp_pool;
                  ZNPNode_ZPP_CbType.zpp_pool = _loc13_.next;
                  _loc13_.next = null;
               }
               null;
               _loc13_.elt = _loc11_;
               _loc12_ = _loc13_;
               _loc12_.next = _loc6_.head;
               _loc6_.head = _loc12_;
               _loc6_.modified = true;
               ++_loc6_.length;
               _loc11_;
               _loc9_ = _loc9_.next;
            }
         }
         while(_loc8_ != null)
         {
            _loc10_ = _loc8_.elt;
            if(ZNPNode_ZPP_CbType.zpp_pool == null)
            {
               _loc13_ = new ZNPNode_ZPP_CbType();
            }
            else
            {
               _loc13_ = ZNPNode_ZPP_CbType.zpp_pool;
               ZNPNode_ZPP_CbType.zpp_pool = _loc13_.next;
               _loc13_.next = null;
            }
            null;
            _loc13_.elt = _loc10_;
            _loc12_ = _loc13_;
            _loc12_.next = _loc5_.head;
            _loc5_.head = _loc12_;
            _loc5_.modified = true;
            ++_loc5_.length;
            _loc10_;
            _loc8_ = _loc8_.next;
         }
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            if(ZNPNode_ZPP_CbType.zpp_pool == null)
            {
               _loc13_ = new ZNPNode_ZPP_CbType();
            }
            else
            {
               _loc13_ = ZNPNode_ZPP_CbType.zpp_pool;
               ZNPNode_ZPP_CbType.zpp_pool = _loc13_.next;
               _loc13_.next = null;
            }
            null;
            _loc13_.elt = _loc10_;
            _loc12_ = _loc13_;
            _loc12_.next = _loc6_.head;
            _loc6_.head = _loc12_;
            _loc6_.modified = true;
            ++_loc6_.length;
            _loc10_;
            _loc9_ = _loc9_.next;
         }
         while(_loc5_.head != null)
         {
            _loc10_ = _loc5_.pop_unsafe();
            _loc12_ = _loc4_.head;
            while(_loc12_ != null)
            {
               _loc11_ = _loc12_.elt;
               _loc14_ = _loc11_.cbsets;
               _loc15_ = ZPP_InteractionListener.UCbSet;
               _loc16_ = ZPP_InteractionListener.VCbSet;
               _loc17_ = ZPP_InteractionListener.WCbSet;
               _loc18_ = _loc10_.cbsets.head;
               _loc19_ = _loc14_.head;
               while(_loc18_ != null && _loc19_ != null)
               {
                  _loc20_ = _loc18_.elt;
                  _loc21_ = _loc19_.elt;
                  if(_loc20_ == _loc21_)
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc20_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc17_.head;
                     _loc17_.head = _loc22_;
                     _loc17_.modified = true;
                     ++_loc17_.length;
                     _loc20_;
                     _loc18_ = _loc18_.next;
                     _loc19_ = _loc19_.next;
                  }
                  else if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc20_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc15_.head;
                     _loc15_.head = _loc22_;
                     _loc15_.modified = true;
                     ++_loc15_.length;
                     _loc20_;
                     _loc18_ = _loc18_.next;
                  }
                  else
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc21_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc16_.head;
                     _loc16_.head = _loc22_;
                     _loc16_.modified = true;
                     ++_loc16_.length;
                     _loc21_;
                     _loc19_ = _loc19_.next;
                  }
               }
               while(_loc18_ != null)
               {
                  _loc20_ = _loc18_.elt;
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc20_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc15_.head;
                  _loc15_.head = _loc22_;
                  _loc15_.modified = true;
                  ++_loc15_.length;
                  _loc20_;
                  _loc18_ = _loc18_.next;
               }
               while(_loc19_ != null)
               {
                  _loc20_ = _loc19_.elt;
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc20_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc16_.head;
                  _loc16_.head = _loc22_;
                  _loc16_.modified = true;
                  ++_loc16_.length;
                  _loc20_;
                  _loc19_ = _loc19_.next;
               }
               while(_loc15_.head != null)
               {
                  _loc20_ = _loc15_.pop_unsafe();
                  _loc22_ = _loc14_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               while(_loc16_.head != null)
               {
                  _loc20_ = _loc16_.pop_unsafe();
                  _loc22_ = _loc17_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               while(_loc17_.head != null)
               {
                  _loc20_ = _loc17_.pop_unsafe();
                  _loc20_.validate();
                  _loc20_.validate();
                  if(ZPP_CbSet.single_intersection(_loc20_,_loc20_,_loc2_))
                  {
                     §§push(_loc3_);
                     if(ZPP_CbSetPair.zpp_pool == null)
                     {
                        _loc24_ = new ZPP_CbSetPair();
                     }
                     else
                     {
                        _loc24_ = ZPP_CbSetPair.zpp_pool;
                        ZPP_CbSetPair.zpp_pool = _loc24_.next;
                        _loc24_.next = null;
                     }
                     _loc24_.zip_listeners = true;
                     if(ZPP_CbSet.setlt(_loc20_,_loc20_))
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc20_;
                     }
                     else
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc20_;
                     }
                     §§pop().try_insert(_loc24_);
                  }
                  _loc22_ = _loc17_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               _loc12_ = _loc12_.next;
            }
         }
         while(_loc6_.head != null)
         {
            _loc10_ = _loc6_.pop_unsafe();
            _loc12_ = _loc7_.head;
            while(_loc12_ != null)
            {
               _loc11_ = _loc12_.elt;
               _loc14_ = _loc11_.cbsets;
               _loc15_ = ZPP_InteractionListener.UCbSet;
               _loc16_ = ZPP_InteractionListener.VCbSet;
               _loc17_ = ZPP_InteractionListener.WCbSet;
               _loc18_ = _loc10_.cbsets.head;
               _loc19_ = _loc14_.head;
               while(_loc18_ != null && _loc19_ != null)
               {
                  _loc20_ = _loc18_.elt;
                  _loc21_ = _loc19_.elt;
                  if(_loc20_ == _loc21_)
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc20_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc17_.head;
                     _loc17_.head = _loc22_;
                     _loc17_.modified = true;
                     ++_loc17_.length;
                     _loc20_;
                     _loc18_ = _loc18_.next;
                     _loc19_ = _loc19_.next;
                  }
                  else if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc20_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc15_.head;
                     _loc15_.head = _loc22_;
                     _loc15_.modified = true;
                     ++_loc15_.length;
                     _loc20_;
                     _loc18_ = _loc18_.next;
                  }
                  else
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc21_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc16_.head;
                     _loc16_.head = _loc22_;
                     _loc16_.modified = true;
                     ++_loc16_.length;
                     _loc21_;
                     _loc19_ = _loc19_.next;
                  }
               }
               while(_loc18_ != null)
               {
                  _loc20_ = _loc18_.elt;
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc20_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc15_.head;
                  _loc15_.head = _loc22_;
                  _loc15_.modified = true;
                  ++_loc15_.length;
                  _loc20_;
                  _loc18_ = _loc18_.next;
               }
               while(_loc19_ != null)
               {
                  _loc20_ = _loc19_.elt;
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc20_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc16_.head;
                  _loc16_.head = _loc22_;
                  _loc16_.modified = true;
                  ++_loc16_.length;
                  _loc20_;
                  _loc19_ = _loc19_.next;
               }
               while(_loc15_.head != null)
               {
                  _loc20_ = _loc15_.pop_unsafe();
                  _loc22_ = _loc14_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               while(_loc16_.head != null)
               {
                  _loc20_ = _loc16_.pop_unsafe();
                  _loc22_ = _loc17_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               while(_loc17_.head != null)
               {
                  _loc20_ = _loc17_.pop_unsafe();
                  _loc20_.validate();
                  _loc20_.validate();
                  if(ZPP_CbSet.single_intersection(_loc20_,_loc20_,_loc2_))
                  {
                     §§push(_loc3_);
                     if(ZPP_CbSetPair.zpp_pool == null)
                     {
                        _loc24_ = new ZPP_CbSetPair();
                     }
                     else
                     {
                        _loc24_ = ZPP_CbSetPair.zpp_pool;
                        ZPP_CbSetPair.zpp_pool = _loc24_.next;
                        _loc24_.next = null;
                     }
                     _loc24_.zip_listeners = true;
                     if(ZPP_CbSet.setlt(_loc20_,_loc20_))
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc20_;
                     }
                     else
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc20_;
                     }
                     §§pop().try_insert(_loc24_);
                  }
                  _loc22_ = _loc17_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               _loc12_ = _loc12_.next;
            }
         }
         while(_loc7_.head != null)
         {
            _loc10_ = _loc7_.pop_unsafe();
            _loc14_ = _loc10_.cbsets;
            _loc15_ = ZPP_InteractionListener.UCbSet;
            _loc16_ = ZPP_InteractionListener.VCbSet;
            _loc17_ = ZPP_InteractionListener.WCbSet;
            _loc18_ = _loc10_.cbsets.head;
            _loc19_ = _loc14_.head;
            while(_loc18_ != null && _loc19_ != null)
            {
               _loc20_ = _loc18_.elt;
               _loc21_ = _loc19_.elt;
               if(_loc20_ == _loc21_)
               {
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc20_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc17_.head;
                  _loc17_.head = _loc22_;
                  _loc17_.modified = true;
                  ++_loc17_.length;
                  _loc20_;
                  _loc18_ = _loc18_.next;
                  _loc19_ = _loc19_.next;
               }
               else if(ZPP_CbSet.setlt(_loc20_,_loc21_))
               {
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc20_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc15_.head;
                  _loc15_.head = _loc22_;
                  _loc15_.modified = true;
                  ++_loc15_.length;
                  _loc20_;
                  _loc18_ = _loc18_.next;
               }
               else
               {
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc21_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc16_.head;
                  _loc16_.head = _loc22_;
                  _loc16_.modified = true;
                  ++_loc16_.length;
                  _loc21_;
                  _loc19_ = _loc19_.next;
               }
            }
            while(_loc18_ != null)
            {
               _loc20_ = _loc18_.elt;
               if(ZNPNode_ZPP_CbSet.zpp_pool == null)
               {
                  _loc23_ = new ZNPNode_ZPP_CbSet();
               }
               else
               {
                  _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                  ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                  _loc23_.next = null;
               }
               null;
               _loc23_.elt = _loc20_;
               _loc22_ = _loc23_;
               _loc22_.next = _loc15_.head;
               _loc15_.head = _loc22_;
               _loc15_.modified = true;
               ++_loc15_.length;
               _loc20_;
               _loc18_ = _loc18_.next;
            }
            while(_loc19_ != null)
            {
               _loc20_ = _loc19_.elt;
               if(ZNPNode_ZPP_CbSet.zpp_pool == null)
               {
                  _loc23_ = new ZNPNode_ZPP_CbSet();
               }
               else
               {
                  _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                  ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                  _loc23_.next = null;
               }
               null;
               _loc23_.elt = _loc20_;
               _loc22_ = _loc23_;
               _loc22_.next = _loc16_.head;
               _loc16_.head = _loc22_;
               _loc16_.modified = true;
               ++_loc16_.length;
               _loc20_;
               _loc19_ = _loc19_.next;
            }
            while(_loc15_.head != null)
            {
               _loc20_ = _loc15_.pop_unsafe();
               _loc22_ = _loc14_.head;
               while(_loc22_ != null)
               {
                  _loc21_ = _loc22_.elt;
                  _loc20_.validate();
                  _loc21_.validate();
                  if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                  {
                     §§push(_loc3_);
                     if(ZPP_CbSetPair.zpp_pool == null)
                     {
                        _loc24_ = new ZPP_CbSetPair();
                     }
                     else
                     {
                        _loc24_ = ZPP_CbSetPair.zpp_pool;
                        ZPP_CbSetPair.zpp_pool = _loc24_.next;
                        _loc24_.next = null;
                     }
                     _loc24_.zip_listeners = true;
                     if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc21_;
                     }
                     else
                     {
                        _loc24_.a = _loc21_;
                        _loc24_.b = _loc20_;
                     }
                     §§pop().try_insert(_loc24_);
                  }
                  _loc22_ = _loc22_.next;
               }
            }
            while(_loc16_.head != null)
            {
               _loc20_ = _loc16_.pop_unsafe();
               _loc22_ = _loc17_.head;
               while(_loc22_ != null)
               {
                  _loc21_ = _loc22_.elt;
                  _loc20_.validate();
                  _loc21_.validate();
                  if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                  {
                     §§push(_loc3_);
                     if(ZPP_CbSetPair.zpp_pool == null)
                     {
                        _loc24_ = new ZPP_CbSetPair();
                     }
                     else
                     {
                        _loc24_ = ZPP_CbSetPair.zpp_pool;
                        ZPP_CbSetPair.zpp_pool = _loc24_.next;
                        _loc24_.next = null;
                     }
                     _loc24_.zip_listeners = true;
                     if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc21_;
                     }
                     else
                     {
                        _loc24_.a = _loc21_;
                        _loc24_.b = _loc20_;
                     }
                     §§pop().try_insert(_loc24_);
                  }
                  _loc22_ = _loc22_.next;
               }
            }
            while(_loc17_.head != null)
            {
               _loc20_ = _loc17_.pop_unsafe();
               _loc20_.validate();
               _loc20_.validate();
               if(ZPP_CbSet.single_intersection(_loc20_,_loc20_,_loc2_))
               {
                  §§push(_loc3_);
                  if(ZPP_CbSetPair.zpp_pool == null)
                  {
                     _loc24_ = new ZPP_CbSetPair();
                  }
                  else
                  {
                     _loc24_ = ZPP_CbSetPair.zpp_pool;
                     ZPP_CbSetPair.zpp_pool = _loc24_.next;
                     _loc24_.next = null;
                  }
                  _loc24_.zip_listeners = true;
                  if(ZPP_CbSet.setlt(_loc20_,_loc20_))
                  {
                     _loc24_.a = _loc20_;
                     _loc24_.b = _loc20_;
                  }
                  else
                  {
                     _loc24_.a = _loc20_;
                     _loc24_.b = _loc20_;
                  }
                  §§pop().try_insert(_loc24_);
               }
               _loc22_ = _loc17_.head;
               while(_loc22_ != null)
               {
                  _loc21_ = _loc22_.elt;
                  _loc20_.validate();
                  _loc21_.validate();
                  if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                  {
                     §§push(_loc3_);
                     if(ZPP_CbSetPair.zpp_pool == null)
                     {
                        _loc24_ = new ZPP_CbSetPair();
                     }
                     else
                     {
                        _loc24_ = ZPP_CbSetPair.zpp_pool;
                        ZPP_CbSetPair.zpp_pool = _loc24_.next;
                        _loc24_.next = null;
                     }
                     _loc24_.zip_listeners = true;
                     if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc21_;
                     }
                     else
                     {
                        _loc24_.a = _loc21_;
                        _loc24_.b = _loc20_;
                     }
                     §§pop().try_insert(_loc24_);
                  }
                  _loc22_ = _loc22_.next;
               }
            }
            _loc12_ = _loc7_.head;
            while(_loc12_ != null)
            {
               _loc11_ = _loc12_.elt;
               _loc14_ = _loc11_.cbsets;
               _loc15_ = ZPP_InteractionListener.UCbSet;
               _loc16_ = ZPP_InteractionListener.VCbSet;
               _loc17_ = ZPP_InteractionListener.WCbSet;
               _loc18_ = _loc10_.cbsets.head;
               _loc19_ = _loc14_.head;
               while(_loc18_ != null && _loc19_ != null)
               {
                  _loc20_ = _loc18_.elt;
                  _loc21_ = _loc19_.elt;
                  if(_loc20_ == _loc21_)
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc20_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc17_.head;
                     _loc17_.head = _loc22_;
                     _loc17_.modified = true;
                     ++_loc17_.length;
                     _loc20_;
                     _loc18_ = _loc18_.next;
                     _loc19_ = _loc19_.next;
                  }
                  else if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc20_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc15_.head;
                     _loc15_.head = _loc22_;
                     _loc15_.modified = true;
                     ++_loc15_.length;
                     _loc20_;
                     _loc18_ = _loc18_.next;
                  }
                  else
                  {
                     if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                     {
                        _loc23_ = new ZNPNode_ZPP_CbSet();
                     }
                     else
                     {
                        _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                        _loc23_.next = null;
                     }
                     null;
                     _loc23_.elt = _loc21_;
                     _loc22_ = _loc23_;
                     _loc22_.next = _loc16_.head;
                     _loc16_.head = _loc22_;
                     _loc16_.modified = true;
                     ++_loc16_.length;
                     _loc21_;
                     _loc19_ = _loc19_.next;
                  }
               }
               while(_loc18_ != null)
               {
                  _loc20_ = _loc18_.elt;
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc20_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc15_.head;
                  _loc15_.head = _loc22_;
                  _loc15_.modified = true;
                  ++_loc15_.length;
                  _loc20_;
                  _loc18_ = _loc18_.next;
               }
               while(_loc19_ != null)
               {
                  _loc20_ = _loc19_.elt;
                  if(ZNPNode_ZPP_CbSet.zpp_pool == null)
                  {
                     _loc23_ = new ZNPNode_ZPP_CbSet();
                  }
                  else
                  {
                     _loc23_ = ZNPNode_ZPP_CbSet.zpp_pool;
                     ZNPNode_ZPP_CbSet.zpp_pool = _loc23_.next;
                     _loc23_.next = null;
                  }
                  null;
                  _loc23_.elt = _loc20_;
                  _loc22_ = _loc23_;
                  _loc22_.next = _loc16_.head;
                  _loc16_.head = _loc22_;
                  _loc16_.modified = true;
                  ++_loc16_.length;
                  _loc20_;
                  _loc19_ = _loc19_.next;
               }
               while(_loc15_.head != null)
               {
                  _loc20_ = _loc15_.pop_unsafe();
                  _loc22_ = _loc14_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               while(_loc16_.head != null)
               {
                  _loc20_ = _loc16_.pop_unsafe();
                  _loc22_ = _loc17_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               while(_loc17_.head != null)
               {
                  _loc20_ = _loc17_.pop_unsafe();
                  _loc20_.validate();
                  _loc20_.validate();
                  if(ZPP_CbSet.single_intersection(_loc20_,_loc20_,_loc2_))
                  {
                     §§push(_loc3_);
                     if(ZPP_CbSetPair.zpp_pool == null)
                     {
                        _loc24_ = new ZPP_CbSetPair();
                     }
                     else
                     {
                        _loc24_ = ZPP_CbSetPair.zpp_pool;
                        ZPP_CbSetPair.zpp_pool = _loc24_.next;
                        _loc24_.next = null;
                     }
                     _loc24_.zip_listeners = true;
                     if(ZPP_CbSet.setlt(_loc20_,_loc20_))
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc20_;
                     }
                     else
                     {
                        _loc24_.a = _loc20_;
                        _loc24_.b = _loc20_;
                     }
                     §§pop().try_insert(_loc24_);
                  }
                  _loc22_ = _loc17_.head;
                  while(_loc22_ != null)
                  {
                     _loc21_ = _loc22_.elt;
                     _loc20_.validate();
                     _loc21_.validate();
                     if(ZPP_CbSet.single_intersection(_loc20_,_loc21_,_loc2_))
                     {
                        §§push(_loc3_);
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc24_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc24_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc24_.next;
                           _loc24_.next = null;
                        }
                        _loc24_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc20_,_loc21_))
                        {
                           _loc24_.a = _loc20_;
                           _loc24_.b = _loc21_;
                        }
                        else
                        {
                           _loc24_.a = _loc21_;
                           _loc24_.b = _loc20_;
                        }
                        §§pop().try_insert(_loc24_);
                     }
                     _loc22_ = _loc22_.next;
                  }
               }
               _loc12_ = _loc12_.next;
            }
         }
         if(_loc3_.parent == null)
         {
            null;
         }
         else
         {
            _loc25_ = _loc3_.parent;
            while(_loc25_ != null)
            {
               if(_loc25_.prev != null)
               {
                  §§push(_loc25_.prev);
               }
               else if(_loc25_.next != null)
               {
                  §§push(_loc25_.next);
               }
               else
               {
                  _loc24_ = _loc25_.data;
                  if(param1)
                  {
                     _loc2_.space.freshListenerType(_loc24_.a,_loc24_.b);
                  }
                  else
                  {
                     _loc2_.space.nullListenerType(_loc24_.a,_loc24_.b);
                  }
                  _loc26_ = _loc24_;
                  _loc26_.a = _loc26_.b = null;
                  _loc26_.listeners.clear();
                  _loc26_.next = ZPP_CbSetPair.zpp_pool;
                  ZPP_CbSetPair.zpp_pool = _loc26_;
                  _loc27_ = _loc25_.parent;
                  if(_loc27_ != null)
                  {
                     if(_loc25_ == _loc27_.prev)
                     {
                        _loc27_.prev = null;
                     }
                     else
                     {
                        _loc27_.next = null;
                     }
                     _loc25_.parent = null;
                  }
                  _loc28_ = _loc25_;
                  _loc28_.data = null;
                  _loc28_.lt = null;
                  _loc28_.swapped = null;
                  _loc28_.next = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                  ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc28_;
                  §§push(_loc27_);
               }
               _loc25_ = §§pop();
            }
            _loc3_.parent = null;
         }
         _loc25_ = _loc3_;
         _loc25_.data = null;
         _loc25_.lt = null;
         _loc25_.swapped = null;
         _loc25_.next = ZPP_Set_ZPP_CbSetPair.zpp_pool;
         ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc25_;
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
                  null;
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
                  ++_loc12_.length;
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
                  null;
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
                  ++_loc12_.length;
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
                  null;
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
                  ++_loc12_.length;
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
               null;
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
               ++_loc12_.length;
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
               null;
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
               ++_loc12_.length;
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
               null;
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
               ++_loc8_.length;
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
            null;
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
            ++_loc8_.length;
            _loc6_;
         }
         else
         {
            param1.excludes.remove(param2);
         }
         addedToSpace();
         null;
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
               null;
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
               ++_loc10_.length;
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
               null;
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
               ++_loc10_.length;
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
               null;
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
               ++_loc10_.length;
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
            null;
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
            ++_loc10_.length;
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
            null;
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
            ++_loc10_.length;
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

import zpp_nape.util.ZNPList_ZPP_CbSet;
import zpp_nape.util.ZNPList_ZPP_CbType;

