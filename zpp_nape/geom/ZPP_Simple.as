package zpp_nape.geom
{
   import flash.Boot;
   import zpp_nape.util.FastHash2_Hashable2_Boolfalse;
   import zpp_nape.util.Hashable2_Boolfalse;
   import zpp_nape.util.ZNPList_ZPP_GeomVert;
   import zpp_nape.util.ZNPList_ZPP_SimpleEvent;
   import zpp_nape.util.ZNPList_ZPP_SimpleVert;
   import zpp_nape.util.ZNPNode_ZPP_SimpleEvent;
   import zpp_nape.util.ZNPNode_ZPP_SimpleVert;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleEvent;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleSeg;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleVert;
   
   public class ZPP_Simple
   {
      
      public static var sweep:ZPP_SimpleSweep = null;
      
      public static var inthash:FastHash2_Hashable2_Boolfalse = null;
      
      public static var vertices:ZPP_Set_ZPP_SimpleVert = null;
      
      public static var queue:ZPP_Set_ZPP_SimpleEvent = null;
      
      public static var ints:ZPP_Set_ZPP_SimpleEvent = null;
      
      public static var list_vertices:ZNPList_ZPP_SimpleVert = null;
      
      public static var list_queue:ZNPList_ZPP_SimpleEvent = null;
       
      
      public function ZPP_Simple()
      {
      }
      
      public static function decompose(param1:ZPP_GeomVert, param2:ZNPList_ZPP_GeomVert = undefined) : ZNPList_ZPP_GeomVert
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 3231
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      public static function clip_polygon(param1:ZPP_Set_ZPP_SimpleVert, param2:ZNPList_ZPP_GeomVert) : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as ZPP_GeomVert;
         var _loc15_:* = null as ZPP_GeomVert;
         var _loc16_:* = null as ZPP_SimpleVert;
         var _loc17_:* = null as ZPP_Set_ZPP_SimpleVert;
         var _loc18_:* = null as ZPP_SimpleVert;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc3_:ZPP_GeomVert = null;
         var _loc4_:ZPP_SimpleVert = param1.first();
         var _loc5_:ZPP_SimpleVert = _loc4_;
         var _loc6_:ZPP_Set_ZPP_SimpleVert = _loc4_.links.parent;
         var _loc7_:ZPP_Set_ZPP_SimpleVert = _loc6_.prev == null ? _loc6_.next : _loc6_.prev;
         var _loc8_:ZPP_SimpleVert = _loc6_.data;
         var _loc9_:ZPP_SimpleVert = _loc7_.data;
         _loc10_ = 0;
         _loc11_ = 0;
         _loc10_ = _loc4_.x - _loc8_.x;
         _loc11_ = _loc4_.y - _loc8_.y;
         _loc12_ = 0;
         _loc13_ = 0;
         _loc12_ = _loc9_.x - _loc4_.x;
         _loc13_ = _loc9_.y - _loc4_.y;
         if(_loc13_ * _loc10_ - _loc12_ * _loc11_ < 0)
         {
            _loc9_ = _loc8_;
         }
         if(ZPP_GeomVert.zpp_pool == null)
         {
            _loc15_ = new ZPP_GeomVert();
         }
         else
         {
            _loc15_ = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc15_.next;
            _loc15_.next = null;
         }
         _loc15_.forced = false;
         _loc15_.x = _loc4_.x;
         _loc15_.y = _loc4_.y;
         _loc14_ = _loc15_;
         if(_loc3_ == null)
         {
            _loc3_ = _loc14_.prev = _loc14_.next = _loc14_;
         }
         else
         {
            _loc14_.prev = _loc3_;
            _loc14_.next = _loc3_.next;
            _loc3_.next.prev = _loc14_;
            _loc3_.next = _loc14_;
         }
         _loc3_ = _loc14_;
         _loc3_.forced = _loc4_.forced;
         while(true)
         {
            _loc4_.links.remove(_loc9_);
            _loc9_.links.remove(_loc4_);
            if(_loc9_ == _loc5_)
            {
               break;
            }
            if(ZPP_GeomVert.zpp_pool == null)
            {
               _loc15_ = new ZPP_GeomVert();
            }
            else
            {
               _loc15_ = ZPP_GeomVert.zpp_pool;
               ZPP_GeomVert.zpp_pool = _loc15_.next;
               _loc15_.next = null;
            }
            _loc15_.forced = false;
            _loc15_.x = _loc9_.x;
            _loc15_.y = _loc9_.y;
            _loc14_ = _loc15_;
            if(_loc3_ == null)
            {
               _loc3_ = _loc14_.prev = _loc14_.next = _loc14_;
            }
            else
            {
               _loc14_.prev = _loc3_;
               _loc14_.next = _loc3_.next;
               _loc3_.next.prev = _loc14_;
               _loc3_.next = _loc14_;
            }
            _loc3_ = _loc14_;
            _loc3_.forced = _loc9_.forced;
            if(_loc9_.links.singular())
            {
               if(_loc4_.links.empty())
               {
                  param1.remove(_loc4_);
                  _loc16_ = _loc4_;
                  _loc16_.links.clear();
                  _loc16_.node = null;
                  _loc16_.forced = false;
                  _loc16_.next = ZPP_SimpleVert.zpp_pool;
                  ZPP_SimpleVert.zpp_pool = _loc16_;
               }
               _loc4_ = _loc9_;
               _loc9_ = _loc9_.links.parent.data;
            }
            else
            {
               _loc16_ = null;
               _loc10_ = 0;
               if(!_loc9_.links.empty())
               {
                  _loc17_ = _loc9_.links.parent;
                  while(_loc17_.prev != null)
                  {
                     _loc17_ = _loc17_.prev;
                  }
                  while(_loc17_ != null)
                  {
                     _loc18_ = _loc17_.data;
                     if(_loc16_ == null)
                     {
                        _loc16_ = _loc18_;
                        _loc11_ = 0;
                        _loc12_ = 0;
                        _loc11_ = _loc9_.x - _loc4_.x;
                        _loc12_ = _loc9_.y - _loc4_.y;
                        _loc13_ = 0;
                        _loc19_ = 0;
                        _loc13_ = _loc18_.x - _loc9_.x;
                        _loc19_ = _loc18_.y - _loc9_.y;
                        _loc10_ = _loc19_ * _loc11_ - _loc13_ * _loc12_;
                     }
                     else
                     {
                        _loc12_ = 0;
                        _loc13_ = 0;
                        _loc12_ = _loc9_.x - _loc4_.x;
                        _loc13_ = _loc9_.y - _loc4_.y;
                        _loc19_ = 0;
                        _loc20_ = 0;
                        _loc19_ = _loc18_.x - _loc9_.x;
                        _loc20_ = _loc18_.y - _loc9_.y;
                        _loc11_ = _loc20_ * _loc12_ - _loc19_ * _loc13_;
                        if(_loc11_ > 0 && _loc10_ <= 0)
                        {
                           _loc16_ = _loc18_;
                           _loc10_ = _loc11_;
                        }
                        else if(_loc10_ * _loc11_ >= 0)
                        {
                           _loc13_ = 0;
                           _loc19_ = 0;
                           _loc13_ = _loc9_.x - _loc18_.x;
                           _loc19_ = _loc9_.y - _loc18_.y;
                           _loc20_ = 0;
                           _loc21_ = 0;
                           _loc20_ = _loc16_.x - _loc9_.x;
                           _loc21_ = _loc16_.y - _loc9_.y;
                           _loc12_ = _loc21_ * _loc13_ - _loc20_ * _loc19_;
                           if(_loc12_ > 0)
                           {
                              _loc16_ = _loc18_;
                              _loc10_ = _loc11_;
                           }
                        }
                     }
                     if(_loc17_.next != null)
                     {
                        _loc17_ = _loc17_.next;
                        while(_loc17_.prev != null)
                        {
                           _loc17_ = _loc17_.prev;
                        }
                     }
                     else
                     {
                        while(_loc17_.parent != null && _loc17_ == _loc17_.parent.next)
                        {
                           _loc17_ = _loc17_.parent;
                        }
                        _loc17_ = _loc17_.parent;
                     }
                  }
               }
               if(_loc4_.links.empty())
               {
                  param1.remove(_loc4_);
                  _loc18_ = _loc4_;
                  _loc18_.links.clear();
                  _loc18_.node = null;
                  _loc18_.forced = false;
                  _loc18_.next = ZPP_SimpleVert.zpp_pool;
                  ZPP_SimpleVert.zpp_pool = _loc18_;
               }
               _loc4_ = _loc9_;
               _loc9_ = _loc16_;
            }
         }
         if(_loc4_.links.empty())
         {
            param1.remove(_loc4_);
            _loc16_ = _loc4_;
            _loc16_.links.clear();
            _loc16_.node = null;
            _loc16_.forced = false;
            _loc16_.next = ZPP_SimpleVert.zpp_pool;
            ZPP_SimpleVert.zpp_pool = _loc16_;
         }
         param1.remove(_loc5_);
         _loc16_ = _loc5_;
         _loc16_.links.clear();
         _loc16_.node = null;
         _loc16_.forced = false;
         _loc16_.next = ZPP_SimpleVert.zpp_pool;
         ZPP_SimpleVert.zpp_pool = _loc16_;
         param2.add(_loc3_);
      }
      
      public static function isSimple(param1:ZPP_GeomVert) : Boolean
      {
         var _loc3_:* = null as ZNPList_ZPP_SimpleVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_SimpleVert;
         var _loc10_:* = null as ZNPList_ZPP_SimpleEvent;
         var _loc12_:* = null as ZPP_SimpleVert;
         var _loc13_:* = null as ZPP_SimpleEvent;
         var _loc14_:* = null as ZPP_SimpleEvent;
         var _loc15_:* = null as ZPP_SimpleEvent;
         var _loc16_:* = null as ZPP_SimpleSeg;
         var _loc17_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc18_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc19_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc20_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc21_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc27_:* = null as ZPP_SimpleSeg;
         if(ZPP_Simple.sweep == null)
         {
            ZPP_Simple.sweep = new ZPP_SimpleSweep();
            ZPP_Simple.inthash = new FastHash2_Hashable2_Boolfalse();
         }
         var _loc2_:ZNPList_ZPP_SimpleVert = ZPP_Simple.list_vertices;
         if(_loc2_ == null)
         {
            _loc2_ = ZPP_Simple.list_vertices = new ZNPList_ZPP_SimpleVert();
         }
         var _loc4_:ZPP_GeomVert = param1;
         var _loc5_:ZPP_GeomVert = param1;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_;
            do
            {
               _loc7_ = _loc6_;
               §§push(_loc2_);
               if(ZPP_SimpleVert.zpp_pool == null)
               {
                  _loc8_ = new ZPP_SimpleVert();
               }
               else
               {
                  _loc8_ = ZPP_SimpleVert.zpp_pool;
                  ZPP_SimpleVert.zpp_pool = _loc8_.next;
                  _loc8_.next = null;
               }
               _loc8_.x = _loc7_.x;
               _loc8_.y = _loc7_.y;
               §§pop().add(_loc8_);
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != _loc5_);
            
         }
         var _loc9_:ZNPList_ZPP_SimpleEvent = ZPP_Simple.list_queue;
         if(_loc9_ == null)
         {
            _loc9_ = ZPP_Simple.list_queue = new ZNPList_ZPP_SimpleEvent();
         }
         var _loc11_:ZNPNode_ZPP_SimpleVert = _loc2_.head;
         _loc8_ = _loc11_.elt;
         _loc11_ = _loc11_.next;
         while(_loc11_ != null)
         {
            _loc12_ = _loc11_.elt;
            §§push(_loc9_);
            if(ZPP_SimpleEvent.zpp_pool == null)
            {
               _loc14_ = new ZPP_SimpleEvent();
            }
            else
            {
               _loc14_ = ZPP_SimpleEvent.zpp_pool;
               ZPP_SimpleEvent.zpp_pool = _loc14_.next;
               _loc14_.next = null;
            }
            _loc14_.vertex = _loc8_;
            _loc13_ = §§pop().add(_loc14_);
            §§push(_loc9_);
            if(ZPP_SimpleEvent.zpp_pool == null)
            {
               _loc15_ = new ZPP_SimpleEvent();
            }
            else
            {
               _loc15_ = ZPP_SimpleEvent.zpp_pool;
               ZPP_SimpleEvent.zpp_pool = _loc15_.next;
               _loc15_.next = null;
            }
            _loc15_.vertex = _loc12_;
            _loc14_ = §§pop().add(_loc15_);
            _loc13_.segment = _loc14_.segment = ZPP_SimpleEvent.less_xy(_loc13_,_loc14_) ? (_loc13_.type = 1, _loc14_.type = 2, ZPP_SimpleSeg.get(_loc8_,_loc12_)) : (_loc13_.type = 2, _loc14_.type = 1, ZPP_SimpleSeg.get(_loc12_,_loc8_));
            _loc8_ = _loc12_;
            _loc11_ = _loc11_.next;
         }
         _loc12_ = _loc2_.head.elt;
         §§push(_loc9_);
         if(ZPP_SimpleEvent.zpp_pool == null)
         {
            _loc14_ = new ZPP_SimpleEvent();
         }
         else
         {
            _loc14_ = ZPP_SimpleEvent.zpp_pool;
            ZPP_SimpleEvent.zpp_pool = _loc14_.next;
            _loc14_.next = null;
         }
         _loc14_.vertex = _loc8_;
         _loc13_ = §§pop().add(_loc14_);
         §§push(_loc9_);
         if(ZPP_SimpleEvent.zpp_pool == null)
         {
            _loc15_ = new ZPP_SimpleEvent();
         }
         else
         {
            _loc15_ = ZPP_SimpleEvent.zpp_pool;
            ZPP_SimpleEvent.zpp_pool = _loc15_.next;
            _loc15_.next = null;
         }
         _loc15_.vertex = _loc12_;
         _loc14_ = §§pop().add(_loc15_);
         _loc13_.segment = _loc14_.segment = ZPP_SimpleEvent.less_xy(_loc13_,_loc14_) ? (_loc13_.type = 1, _loc14_.type = 2, ZPP_SimpleSeg.get(_loc8_,_loc12_)) : (_loc13_.type = 2, _loc14_.type = 1, ZPP_SimpleSeg.get(_loc12_,_loc8_));
         _loc10_ = _loc9_;
         if(_loc10_.head != null && _loc10_.head.next != null)
         {
            _loc17_ = _loc10_.head;
            _loc18_ = null;
            _loc19_ = null;
            _loc20_ = null;
            _loc21_ = null;
            _loc22_ = 1;
            do
            {
               _loc23_ = 0;
               _loc19_ = _loc17_;
               _loc18_ = _loc17_ = null;
               while(_loc19_ != null)
               {
                  _loc23_++;
                  _loc20_ = _loc19_;
                  _loc24_ = 0;
                  _loc25_ = _loc22_;
                  while(_loc20_ != null && _loc24_ < _loc22_)
                  {
                     _loc24_++;
                     _loc20_ = _loc20_.next;
                  }
                  while(_loc24_ > 0 || _loc25_ > 0 && _loc20_ != null)
                  {
                     if(_loc24_ == 0)
                     {
                        _loc21_ = _loc20_;
                        _loc20_ = _loc20_.next;
                        _loc25_--;
                     }
                     else if(_loc25_ == 0 || _loc20_ == null)
                     {
                        _loc21_ = _loc19_;
                        _loc19_ = _loc19_.next;
                        _loc24_--;
                     }
                     else if(ZPP_SimpleEvent.less_xy(_loc19_.elt,_loc20_.elt))
                     {
                        _loc21_ = _loc19_;
                        _loc19_ = _loc19_.next;
                        _loc24_--;
                     }
                     else
                     {
                        _loc21_ = _loc20_;
                        _loc20_ = _loc20_.next;
                        _loc25_--;
                     }
                     if(_loc18_ != null)
                     {
                        _loc18_.next = _loc21_;
                     }
                     else
                     {
                        _loc17_ = _loc21_;
                     }
                     _loc18_ = _loc21_;
                  }
                  _loc19_ = _loc20_;
               }
               _loc18_.next = null;
               _loc22_ <<= 1;
            }
            while(_loc23_ > 1);
            
            _loc10_.head = _loc17_;
            _loc10_.modified = true;
            _loc10_.pushmod = true;
         }
         var _loc26_:Boolean = true;
         while(_loc9_.head != null)
         {
            _loc13_ = _loc9_.pop_unsafe();
            _loc16_ = _loc13_.segment;
            if(_loc13_.type == 1)
            {
               ZPP_Simple.sweep.add(_loc16_);
               if(ZPP_Simple.sweep.intersect(_loc16_,_loc16_.next) || ZPP_Simple.sweep.intersect(_loc16_,_loc16_.prev))
               {
                  _loc26_ = false;
                  break;
               }
            }
            else if(_loc13_.type == 2)
            {
               if(ZPP_Simple.sweep.intersect(_loc16_.prev,_loc16_.next))
               {
                  _loc26_ = false;
                  break;
               }
               ZPP_Simple.sweep.remove(_loc16_);
               _loc27_ = _loc16_;
               _loc27_.left = _loc27_.right = null;
               _loc27_.prev = null;
               _loc27_.node = null;
               _loc27_.vertices.clear();
               _loc27_.next = ZPP_SimpleSeg.zpp_pool;
               ZPP_SimpleSeg.zpp_pool = _loc27_;
            }
            _loc14_ = _loc13_;
            _loc14_.vertex = null;
            _loc14_.segment = _loc14_.segment2 = null;
            _loc14_.node = null;
            _loc14_.next = ZPP_SimpleEvent.zpp_pool;
            ZPP_SimpleEvent.zpp_pool = _loc14_;
         }
         while(_loc9_.head != null)
         {
            _loc13_ = _loc9_.pop_unsafe();
            if(_loc13_.type == 2)
            {
               _loc16_ = _loc13_.segment;
               _loc16_.left = _loc16_.right = null;
               _loc16_.prev = null;
               _loc16_.node = null;
               _loc16_.vertices.clear();
               _loc16_.next = ZPP_SimpleSeg.zpp_pool;
               ZPP_SimpleSeg.zpp_pool = _loc16_;
            }
            _loc14_ = _loc13_;
            _loc14_.vertex = null;
            _loc14_.segment = _loc14_.segment2 = null;
            _loc14_.node = null;
            _loc14_.next = ZPP_SimpleEvent.zpp_pool;
            ZPP_SimpleEvent.zpp_pool = _loc14_;
         }
         ZPP_Simple.sweep.clear();
         while(_loc2_.head != null)
         {
            _loc8_ = _loc2_.pop_unsafe();
            _loc8_.links.clear();
            _loc8_.node = null;
            _loc8_.forced = false;
            _loc8_.next = ZPP_SimpleVert.zpp_pool;
            ZPP_SimpleVert.zpp_pool = _loc8_;
         }
         return _loc26_;
      }
   }
}
