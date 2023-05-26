package zpp_nape.callbacks
{
   import flash.Boot;
   import nape.callbacks.CbType;
   import nape.callbacks.CbTypeIterator;
   import nape.callbacks.CbTypeList;
   import nape.callbacks.OptionType;
   import zpp_nape.ZPP_Const;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZPP_CbTypeList;
   
   public class ZPP_OptionType
   {
       
      
      public var wrap_includes:CbTypeList;
      
      public var wrap_excludes:CbTypeList;
      
      public var outer:OptionType;
      
      public var includes:ZNPList_ZPP_CbType;
      
      public var handler:Object;
      
      public var excludes:ZNPList_ZPP_CbType;
      
      public function ZPP_OptionType()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         wrap_excludes = null;
         wrap_includes = null;
         excludes = null;
         includes = null;
         handler = null;
         outer = null;
         includes = new ZNPList_ZPP_CbType();
         excludes = new ZNPList_ZPP_CbType();
      }
      
      public static function argument(param1:*) : OptionType
      {
         return param1 == null ? new OptionType() : (param1 is OptionType ? param1 : new OptionType().including(param1));
      }
      
      public function setup_includes() : void
      {
         wrap_includes = ZPP_CbTypeList.get(includes,true);
      }
      
      public function setup_excludes() : void
      {
         wrap_excludes = ZPP_CbTypeList.get(excludes,true);
      }
      
      public function set(param1:ZPP_OptionType) : ZPP_OptionType
      {
         var _loc2_:* = null as ZNPNode_ZPP_CbType;
         var _loc3_:* = null as ZPP_CbType;
         if(param1 != this)
         {
            while(includes.head != null)
            {
               append_type(excludes,includes.head.elt);
            }
            while(excludes.head != null)
            {
               append_type(includes,excludes.head.elt);
            }
            _loc2_ = param1.excludes.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               append_type(excludes,_loc3_);
               _loc2_ = _loc2_.next;
            }
            _loc2_ = param1.includes.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               append_type(includes,_loc3_);
               _loc2_ = _loc2_.next;
            }
         }
         return this;
      }
      
      public function nonemptyintersection(param1:ZNPList_ZPP_CbType, param2:ZNPList_ZPP_CbType) : Boolean
      {
         var _loc6_:* = null as ZPP_CbType;
         var _loc7_:* = null as ZPP_CbType;
         var _loc3_:Boolean = false;
         var _loc4_:ZNPNode_ZPP_CbType = param1.head;
         var _loc5_:ZNPNode_ZPP_CbType = param2.head;
         while(_loc5_ != null && _loc4_ != null)
         {
            _loc6_ = _loc5_.elt;
            _loc7_ = _loc4_.elt;
            if(_loc6_ == _loc7_)
            {
               _loc3_ = true;
               break;
            }
            if(_loc6_.id < _loc7_.id)
            {
               _loc5_ = _loc5_.next;
            }
            else
            {
               _loc4_ = _loc4_.next;
            }
         }
         return _loc3_;
      }
      
      public function included(param1:ZNPList_ZPP_CbType) : Boolean
      {
         return nonemptyintersection(param1,includes);
      }
      
      public function excluded(param1:ZNPList_ZPP_CbType) : Boolean
      {
         return nonemptyintersection(param1,excludes);
      }
      
      public function compatible(param1:ZNPList_ZPP_CbType) : Boolean
      {
         return nonemptyintersection(param1,includes) && !nonemptyintersection(param1,excludes);
      }
      
      public function append_type(param1:ZNPList_ZPP_CbType, param2:ZPP_CbType) : void
      {
         var _loc3_:* = null as ZNPNode_ZPP_CbType;
         var _loc4_:* = null as ZNPNode_ZPP_CbType;
         var _loc5_:* = null as ZPP_CbType;
         var _loc6_:* = null as ZNPList_ZPP_CbType;
         var _loc7_:* = null as ZNPNode_ZPP_CbType;
         var _loc8_:Boolean = false;
         if(param1 == includes)
         {
            if(!includes.has(param2))
            {
               if(!excludes.has(param2))
               {
                  if(handler != null)
                  {
                     handler(param2,true,true);
                  }
                  else
                  {
                     _loc3_ = null;
                     _loc4_ = includes.head;
                     while(_loc4_ != null)
                     {
                        _loc5_ = _loc4_.elt;
                        if(param2.id < _loc5_.id)
                        {
                           break;
                        }
                        _loc3_ = _loc4_;
                        _loc4_ = _loc4_.next;
                     }
                     _loc6_ = includes;
                     if(ZNPNode_ZPP_CbType.zpp_pool == null)
                     {
                        _loc7_ = new ZNPNode_ZPP_CbType();
                     }
                     else
                     {
                        _loc7_ = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc7_.next;
                        _loc7_.next = null;
                     }
                     _loc7_.elt = param2;
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
                  }
               }
               else if(handler != null)
               {
                  handler(param2,false,false);
               }
               else
               {
                  excludes.remove(param2);
               }
            }
         }
         else if(!excludes.has(param2))
         {
            if(!includes.has(param2))
            {
               if(handler != null)
               {
                  handler(param2,false,true);
               }
               else
               {
                  _loc3_ = null;
                  _loc4_ = excludes.head;
                  while(_loc4_ != null)
                  {
                     _loc5_ = _loc4_.elt;
                     if(param2.id < _loc5_.id)
                     {
                        break;
                     }
                     _loc3_ = _loc4_;
                     _loc4_ = _loc4_.next;
                  }
                  _loc6_ = excludes;
                  if(ZNPNode_ZPP_CbType.zpp_pool == null)
                  {
                     _loc7_ = new ZNPNode_ZPP_CbType();
                  }
                  else
                  {
                     _loc7_ = ZNPNode_ZPP_CbType.zpp_pool;
                     ZNPNode_ZPP_CbType.zpp_pool = _loc7_.next;
                     _loc7_.next = null;
                  }
                  _loc7_.elt = param2;
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
               }
            }
            else if(handler != null)
            {
               handler(param2,true,false);
            }
            else
            {
               includes.remove(param2);
            }
         }
      }
      
      public function append(param1:ZNPList_ZPP_CbType, param2:*) : void
      {
         var _loc3_:* = null as CbType;
         var _loc4_:* = null as CbTypeList;
         var _loc5_:* = null as CbTypeIterator;
         var _loc6_:int = 0;
         var _loc7_:* = null as CbTypeList;
         var _loc8_:* = null as Vector.<CbType>;
         var _loc9_:* = null as Array;
         var _loc10_:* = null;
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot append null, only CbType and CbType list values";
         }
         if(param2 is CbType)
         {
            _loc3_ = param2;
            append_type(param1,_loc3_.zpp_inner);
         }
         else if(param2 is CbTypeList)
         {
            _loc4_ = param2;
            _loc4_.zpp_inner.valmod();
            _loc5_ = CbTypeIterator.get(_loc4_);
            while(true)
            {
               _loc5_.zpp_inner.zpp_inner.valmod();
               _loc7_ = _loc5_.zpp_inner;
               _loc7_.zpp_inner.valmod();
               if(_loc7_.zpp_inner.zip_length)
               {
                  _loc7_.zpp_inner.zip_length = false;
                  _loc7_.zpp_inner.user_length = _loc7_.zpp_inner.inner.length;
               }
               _loc6_ = _loc7_.zpp_inner.user_length;
               _loc5_.zpp_critical = true;
               if(!(_loc5_.zpp_i < _loc6_ ? true : (_loc5_.zpp_next = CbTypeIterator.zpp_pool, CbTypeIterator.zpp_pool = _loc5_, _loc5_.zpp_inner = null, false)))
               {
                  break;
               }
               _loc5_.zpp_critical = false;
               _loc5_.zpp_i = (_loc6_ = _loc5_.zpp_i) + 1;
               _loc3_ = _loc5_.zpp_inner.at(_loc6_);
               append_type(param1,_loc3_.zpp_inner);
            }
         }
         else if(param2 is ZPP_Const.cbtypevector)
         {
            _loc8_ = param2;
            _loc6_ = 0;
            while(_loc6_ < _loc8_.length)
            {
               _loc3_ = _loc8_[_loc6_];
               _loc6_++;
               append_type(param1,_loc3_.zpp_inner);
            }
         }
         else
         {
            if(!(param2 is Array))
            {
               Boot.lastError = new Error();
               throw "Error: Cannot append non-CbType or CbType list value";
            }
            _loc9_ = param2;
            _loc6_ = 0;
            while(_loc6_ < _loc9_.length)
            {
               _loc10_ = _loc9_[_loc6_];
               _loc6_++;
               if(!(_loc10_ is CbType))
               {
                  Boot.lastError = new Error();
                  throw "Error: Cannot append non-CbType or CbType list value";
               }
               _loc3_ = _loc10_;
               append_type(param1,_loc3_.zpp_inner);
            }
         }
      }
   }
}
