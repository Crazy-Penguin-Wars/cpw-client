package zpp_nape.geom
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.geom.GeomPoly;
   import nape.geom.GeomPolyList;
   import nape.geom.Vec2;
   import zpp_nape.util.ZNPList_ZPP_CutInt;
   import zpp_nape.util.ZNPList_ZPP_CutVert;
   import zpp_nape.util.ZNPNode_ZPP_CutInt;
   import zpp_nape.util.ZNPNode_ZPP_CutVert;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_Cutter
   {
      public static var ints:ZNPList_ZPP_CutInt;
      
      public static var paths:ZNPList_ZPP_CutVert;
      
      public function ZPP_Cutter()
      {
      }
      
      public static function run(param1:ZPP_GeomVert, param2:Vec2, param3:Vec2, param4:Boolean, param5:Boolean, param6:GeomPolyList) : GeomPolyList
      {
         var _loc9_:* = null as ZPP_Vec2;
         var _loc18_:* = null as ZPP_CutVert;
         var _loc19_:* = null as ZPP_CutVert;
         var _loc20_:* = null as ZPP_CutVert;
         var _loc21_:* = null as ZPP_CutVert;
         var _loc22_:* = null as ZPP_CutVert;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Boolean = false;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Boolean = false;
         var _loc32_:* = null as ZPP_GeomVert;
         var _loc33_:* = null as ZPP_GeomVert;
         var _loc34_:* = null as ZPP_GeomVert;
         var _loc35_:* = null as ZPP_GeomVert;
         var _loc36_:* = null as ZPP_GeomVert;
         var _loc37_:* = null as ZPP_CutVert;
         var _loc38_:* = null as ZPP_CutVert;
         var _loc39_:* = null as ZPP_CutVert;
         var _loc40_:* = null as ZPP_CutInt;
         var _loc41_:* = null as ZPP_GeomVert;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc46_:* = null as ZNPNode_ZPP_CutInt;
         var _loc47_:* = null as ZNPNode_ZPP_CutInt;
         var _loc48_:* = null as ZNPNode_ZPP_CutInt;
         var _loc49_:* = null as ZNPNode_ZPP_CutInt;
         var _loc50_:* = null as ZNPNode_ZPP_CutInt;
         var _loc51_:int = 0;
         var _loc52_:int = 0;
         var _loc53_:int = 0;
         var _loc54_:int = 0;
         var _loc55_:* = null as ZPP_CutInt;
         var _loc56_:* = null as Vec2;
         var _loc57_:* = null as Vec2;
         var _loc58_:* = null as ZPP_Vec2;
         var _loc59_:* = null as ZPP_CutInt;
         var _loc62_:* = null as GeomPoly;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc9_ = param2.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         _loc7_ = param2.zpp_inner.x;
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc9_ = param2.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         _loc8_ = param2.zpp_inner.y;
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc9_ = param3.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         _loc10_ = param3.zpp_inner.x - _loc7_;
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc9_ = param3.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         _loc11_ = param3.zpp_inner.y - _loc8_;
         var _loc12_:Number = param4 ? 0 : -1.79e+308;
         var _loc13_:Number = param5 ? 1 : 1.79e+308;
         var _loc14_:Number = -(_loc8_ * _loc10_ - _loc7_ * _loc11_);
         var _loc15_:ZPP_CutVert = null;
         var _loc16_:Boolean = false;
         var _loc17_:ZPP_GeomVert = param1;
         do
         {
            if(ZPP_CutVert.zpp_pool == null)
            {
               _loc18_ = new ZPP_CutVert();
            }
            else
            {
               _loc18_ = ZPP_CutVert.zpp_pool;
               ZPP_CutVert.zpp_pool = _loc18_.next;
               _loc18_.next = null;
            }
            null;
            _loc18_.vert = _loc17_;
            _loc18_.posx = _loc18_.vert.x;
            _loc18_.posy = _loc18_.vert.y;
            _loc18_.value = _loc18_.posy * _loc10_ - _loc18_.posx * _loc11_ + _loc14_;
            _loc18_.positive = _loc18_.value > 0;
            if(_loc18_.value == 0)
            {
               _loc16_ = true;
            }
            _loc19_ = _loc18_;
            if(_loc15_ == null)
            {
               _loc15_ = _loc19_.prev = _loc19_.next = _loc19_;
            }
            else
            {
               _loc19_.prev = _loc15_;
               _loc19_.next = _loc15_.next;
               _loc15_.next.prev = _loc19_;
               _loc15_.next = _loc19_;
            }
            _loc15_ = _loc19_;
            _loc17_ = _loc17_.next;
         }
         while(_loc17_ != param1);
         
         if(_loc16_)
         {
            _loc18_ = null;
            _loc19_ = _loc15_;
            _loc20_ = _loc15_;
            if(_loc19_ != null)
            {
               _loc21_ = _loc19_;
               do
               {
                  _loc22_ = _loc21_;
                  if(_loc22_.value != 0)
                  {
                     _loc18_ = _loc22_;
                     break;
                  }
                  _loc21_ = _loc21_.next;
               }
               while(_loc21_ != _loc20_);
               
            }
            _loc23_ = 0;
            _loc24_ = 0;
            _loc23_ = _loc10_;
            _loc24_ = _loc11_;
            _loc25_ = _loc23_ * _loc23_ + _loc24_ * _loc24_;
            sf32(_loc25_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc27_ = lf32(0);
            _loc26_ = _loc27_ * (1.5 - 0.5 * _loc25_ * _loc27_ * _loc27_);
            _loc27_ = _loc26_;
            _loc23_ *= _loc27_;
            _loc24_ *= _loc27_;
            _loc25_ = _loc23_;
            _loc23_ = -_loc24_;
            _loc24_ = _loc25_;
            _loc19_ = null;
            _loc20_ = _loc18_;
            do
            {
               if(_loc20_.value != 0 && (_loc19_ == null || _loc20_ == _loc19_.next))
               {
                  _loc19_ = _loc20_;
                  _loc20_ = _loc20_.next;
               }
               else
               {
                  _loc25_ = _loc19_.value * _loc20_.value;
                  if(_loc25_ == 0)
                  {
                     _loc20_ = _loc20_.next;
                  }
                  else
                  {
                     _loc21_ = _loc19_.next;
                     if(_loc25_ > 0)
                     {
                        §§push(_loc19_.positive);
                     }
                     else
                     {
                        _loc22_ = _loc21_.next;
                        _loc26_ = 0;
                        _loc27_ = 0;
                        _loc26_ = _loc21_.posx + _loc22_.posx;
                        _loc27_ = _loc21_.posy + _loc22_.posy;
                        _loc29_ = 0.5;
                        _loc26_ *= _loc29_;
                        _loc27_ *= _loc29_;
                        _loc29_ = _loc26_ + _loc23_ * 1e-8;
                        _loc30_ = _loc27_ + _loc24_ * 1e-8;
                        _loc31_ = false;
                        _loc32_ = param1;
                        _loc33_ = param1;
                        if(_loc32_ != null)
                        {
                           _loc34_ = _loc32_;
                           do
                           {
                              _loc35_ = _loc34_;
                              _loc36_ = _loc35_.prev;
                              if((_loc35_.y < _loc30_ && _loc36_.y >= _loc30_ || _loc36_.y < _loc30_ && _loc35_.y >= _loc30_) && (_loc35_.x <= _loc29_ || _loc36_.x <= _loc29_))
                              {
                                 if(_loc35_.x + (_loc30_ - _loc35_.y) / (_loc36_.y - _loc35_.y) * (_loc36_.x - _loc35_.x) < _loc29_)
                                 {
                                    _loc31_ = !_loc31_;
                                 }
                              }
                              _loc34_ = _loc34_.next;
                           }
                           while(_loc34_ != _loc33_);
                           
                        }
                        §§push(_loc31_);
                     }
                     _loc28_ = §§pop();
                     _loc22_ = _loc21_;
                     _loc37_ = _loc20_;
                     if(_loc22_ != null)
                     {
                        _loc38_ = _loc22_;
                        do
                        {
                           _loc39_ = _loc38_;
                           _loc39_.positive = _loc28_;
                           _loc38_ = _loc38_.next;
                        }
                        while(_loc38_ != _loc37_);
                        
                     }
                     _loc19_ = _loc20_;
                     _loc20_ = _loc20_.next;
                  }
               }
            }
            while(_loc20_ != _loc18_);
            
            do
            {
               if(_loc20_.value != 0 && (_loc19_ == null || _loc20_ == _loc19_.next))
               {
                  _loc19_ = _loc20_;
                  _loc20_ = _loc20_.next;
               }
               else
               {
                  _loc25_ = _loc19_.value * _loc20_.value;
                  if(_loc25_ == 0)
                  {
                     _loc20_ = _loc20_.next;
                  }
                  else
                  {
                     _loc21_ = _loc19_.next;
                     if(_loc25_ > 0)
                     {
                        §§push(_loc19_.positive);
                     }
                     else
                     {
                        _loc22_ = _loc21_.next;
                        _loc26_ = 0;
                        _loc27_ = 0;
                        _loc26_ = _loc21_.posx + _loc22_.posx;
                        _loc27_ = _loc21_.posy + _loc22_.posy;
                        _loc29_ = 0.5;
                        _loc26_ *= _loc29_;
                        _loc27_ *= _loc29_;
                        _loc29_ = _loc26_ + _loc23_ * 1e-8;
                        _loc30_ = _loc27_ + _loc24_ * 1e-8;
                        _loc31_ = false;
                        _loc32_ = param1;
                        _loc33_ = param1;
                        if(_loc32_ != null)
                        {
                           _loc34_ = _loc32_;
                           do
                           {
                              _loc35_ = _loc34_;
                              _loc36_ = _loc35_.prev;
                              if((_loc35_.y < _loc30_ && _loc36_.y >= _loc30_ || _loc36_.y < _loc30_ && _loc35_.y >= _loc30_) && (_loc35_.x <= _loc29_ || _loc36_.x <= _loc29_))
                              {
                                 if(_loc35_.x + (_loc30_ - _loc35_.y) / (_loc36_.y - _loc35_.y) * (_loc36_.x - _loc35_.x) < _loc29_)
                                 {
                                    _loc31_ = !_loc31_;
                                 }
                              }
                              _loc34_ = _loc34_.next;
                           }
                           while(_loc34_ != _loc33_);
                           
                        }
                        §§push(_loc31_);
                     }
                     _loc28_ = §§pop();
                     _loc22_ = _loc21_;
                     _loc37_ = _loc20_;
                     if(_loc22_ != null)
                     {
                        _loc38_ = _loc22_;
                        do
                        {
                           _loc39_ = _loc38_;
                           _loc39_.positive = _loc28_;
                           _loc38_ = _loc38_.next;
                        }
                        while(_loc38_ != _loc37_);
                        
                     }
                     _loc19_ = _loc20_;
                     _loc20_ = _loc20_.next;
                  }
               }
            }
            while(false);
            
         }
         if(ZPP_Cutter.ints == null)
         {
            ZPP_Cutter.ints = new ZNPList_ZPP_CutInt();
         }
         if(ZPP_Cutter.paths == null)
         {
            ZPP_Cutter.paths = new ZNPList_ZPP_CutVert();
         }
         _loc32_ = null;
         if(ZPP_GeomVert.zpp_pool == null)
         {
            _loc34_ = new ZPP_GeomVert();
         }
         else
         {
            _loc34_ = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc34_.next;
            _loc34_.next = null;
         }
         _loc34_.forced = false;
         _loc34_.x = _loc15_.posx;
         _loc34_.y = _loc15_.posy;
         _loc33_ = _loc34_;
         if(_loc32_ == null)
         {
            _loc32_ = _loc33_.prev = _loc33_.next = _loc33_;
         }
         else
         {
            _loc33_.next = _loc32_;
            _loc33_.prev = _loc32_.prev;
            _loc32_.prev.next = _loc33_;
            _loc32_.prev = _loc33_;
         }
         _loc33_;
         _loc33_ = _loc32_;
         if(ZPP_CutVert.zpp_pool == null)
         {
            _loc19_ = new ZPP_CutVert();
         }
         else
         {
            _loc19_ = ZPP_CutVert.zpp_pool;
            ZPP_CutVert.zpp_pool = _loc19_.next;
            _loc19_.next = null;
         }
         null;
         _loc19_.vert = _loc32_;
         _loc19_.parent = _loc19_;
         _loc19_.rank = 0;
         _loc19_.used = false;
         _loc18_ = _loc19_;
         ZPP_Cutter.paths.add(_loc18_);
         _loc19_ = _loc15_;
         do
         {
            _loc20_ = _loc19_.next;
            if(ZPP_GeomVert.zpp_pool == null)
            {
               _loc35_ = new ZPP_GeomVert();
            }
            else
            {
               _loc35_ = ZPP_GeomVert.zpp_pool;
               ZPP_GeomVert.zpp_pool = _loc35_.next;
               _loc35_.next = null;
            }
            _loc35_.forced = false;
            _loc35_.x = _loc20_.posx;
            _loc35_.y = _loc20_.posy;
            _loc34_ = _loc35_;
            if(_loc19_.positive == _loc20_.positive)
            {
               _loc35_ = _loc34_;
               if(_loc32_ == null)
               {
                  _loc32_ = _loc35_.prev = _loc35_.next = _loc35_;
               }
               else
               {
                  _loc35_.next = _loc32_;
                  _loc35_.prev = _loc32_.prev;
                  _loc32_.prev.next = _loc35_;
                  _loc32_.prev = _loc35_;
               }
               _loc35_;
            }
            else
            {
               _loc23_ = 0;
               _loc24_ = 0;
               _loc23_ = _loc20_.posx - _loc19_.posx;
               _loc24_ = _loc20_.posy - _loc19_.posy;
               _loc25_ = _loc11_ * _loc23_ - _loc10_ * _loc24_;
               _loc25_ = 1 / _loc25_;
               _loc26_ = 0;
               _loc27_ = 0;
               _loc26_ = _loc7_ - _loc19_.posx;
               _loc27_ = _loc8_ - _loc19_.posy;
               _loc29_ = (_loc24_ * _loc26_ - _loc23_ * _loc27_) * _loc25_;
               if(_loc29_ < _loc12_ || _loc29_ > _loc13_)
               {
                  _loc28_ = false;
                  §§push(ZPP_Cutter.ints);
                  if(ZPP_CutInt.zpp_pool == null)
                  {
                     _loc40_ = new ZPP_CutInt();
                  }
                  else
                  {
                     _loc40_ = ZPP_CutInt.zpp_pool;
                     ZPP_CutInt.zpp_pool = _loc40_.next;
                     _loc40_.next = null;
                  }
                  null;
                  _loc40_.virtualint = true;
                  _loc40_.end = null;
                  _loc40_.start = null;
                  _loc40_.path0 = null;
                  _loc40_.path1 = null;
                  _loc40_.time = _loc29_;
                  _loc40_.vertex = _loc28_;
                  §§pop().add(_loc40_);
                  _loc35_ = _loc34_;
                  if(_loc32_ == null)
                  {
                     _loc32_ = _loc35_.prev = _loc35_.next = _loc35_;
                  }
                  else
                  {
                     _loc35_.next = _loc32_;
                     _loc35_.prev = _loc32_.prev;
                     _loc32_.prev.next = _loc35_;
                     _loc32_.prev = _loc35_;
                  }
                  _loc35_;
               }
               else if(_loc19_.value == 0)
               {
                  _loc35_ = _loc32_.prev;
                  _loc32_ = null;
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc41_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc41_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc41_.next;
                     _loc41_.next = null;
                  }
                  _loc41_.forced = false;
                  _loc41_.x = _loc35_.x;
                  _loc41_.y = _loc35_.y;
                  _loc36_ = _loc41_;
                  if(_loc32_ == null)
                  {
                     _loc32_ = _loc36_.prev = _loc36_.next = _loc36_;
                  }
                  else
                  {
                     _loc36_.next = _loc32_;
                     _loc36_.prev = _loc32_.prev;
                     _loc32_.prev.next = _loc36_;
                     _loc32_.prev = _loc36_;
                  }
                  _loc36_;
                  _loc36_ = _loc34_;
                  if(_loc32_ == null)
                  {
                     _loc32_ = _loc36_.prev = _loc36_.next = _loc36_;
                  }
                  else
                  {
                     _loc36_.next = _loc32_;
                     _loc36_.prev = _loc32_.prev;
                     _loc32_.prev.next = _loc36_;
                     _loc32_.prev = _loc36_;
                  }
                  _loc36_;
                  _loc21_ = ZPP_Cutter.paths.head.elt;
                  §§push(ZPP_Cutter.paths);
                  if(ZPP_CutVert.zpp_pool == null)
                  {
                     _loc22_ = new ZPP_CutVert();
                  }
                  else
                  {
                     _loc22_ = ZPP_CutVert.zpp_pool;
                     ZPP_CutVert.zpp_pool = _loc22_.next;
                     _loc22_.next = null;
                  }
                  null;
                  _loc22_.vert = _loc32_;
                  _loc22_.parent = _loc22_;
                  _loc22_.rank = 0;
                  _loc22_.used = false;
                  §§pop().add(_loc22_);
                  _loc22_ = ZPP_Cutter.paths.head.elt;
                  _loc28_ = false;
                  §§push(ZPP_Cutter.ints);
                  if(ZPP_CutInt.zpp_pool == null)
                  {
                     _loc40_ = new ZPP_CutInt();
                  }
                  else
                  {
                     _loc40_ = ZPP_CutInt.zpp_pool;
                     ZPP_CutInt.zpp_pool = _loc40_.next;
                     _loc40_.next = null;
                  }
                  null;
                  _loc40_.virtualint = true;
                  _loc40_.end = _loc35_;
                  _loc40_.start = _loc32_;
                  _loc40_.path0 = _loc21_;
                  _loc40_.path1 = _loc22_;
                  _loc40_.time = _loc29_;
                  _loc40_.vertex = _loc28_;
                  §§pop().add(_loc40_);
               }
               else if(_loc20_.value == 0)
               {
                  _loc35_ = _loc34_;
                  if(_loc32_ == null)
                  {
                     _loc32_ = _loc35_.prev = _loc35_.next = _loc35_;
                  }
                  else
                  {
                     _loc35_.next = _loc32_;
                     _loc35_.prev = _loc32_.prev;
                     _loc32_.prev.next = _loc35_;
                     _loc32_.prev = _loc35_;
                  }
                  _loc35_;
                  _loc35_ = _loc32_.prev;
                  _loc32_ = null;
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc41_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc41_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc41_.next;
                     _loc41_.next = null;
                  }
                  _loc41_.forced = false;
                  _loc41_.x = _loc20_.posx;
                  _loc41_.y = _loc20_.posy;
                  _loc36_ = _loc41_;
                  if(_loc32_ == null)
                  {
                     _loc32_ = _loc36_.prev = _loc36_.next = _loc36_;
                  }
                  else
                  {
                     _loc36_.next = _loc32_;
                     _loc36_.prev = _loc32_.prev;
                     _loc32_.prev.next = _loc36_;
                     _loc32_.prev = _loc36_;
                  }
                  _loc36_;
                  _loc21_ = ZPP_Cutter.paths.head.elt;
                  §§push(ZPP_Cutter.paths);
                  if(ZPP_CutVert.zpp_pool == null)
                  {
                     _loc22_ = new ZPP_CutVert();
                  }
                  else
                  {
                     _loc22_ = ZPP_CutVert.zpp_pool;
                     ZPP_CutVert.zpp_pool = _loc22_.next;
                     _loc22_.next = null;
                  }
                  null;
                  _loc22_.vert = _loc32_;
                  _loc22_.parent = _loc22_;
                  _loc22_.rank = 0;
                  _loc22_.used = false;
                  §§pop().add(_loc22_);
                  _loc22_ = ZPP_Cutter.paths.head.elt;
                  _loc28_ = false;
                  §§push(ZPP_Cutter.ints);
                  if(ZPP_CutInt.zpp_pool == null)
                  {
                     _loc40_ = new ZPP_CutInt();
                  }
                  else
                  {
                     _loc40_ = ZPP_CutInt.zpp_pool;
                     ZPP_CutInt.zpp_pool = _loc40_.next;
                     _loc40_.next = null;
                  }
                  null;
                  _loc40_.virtualint = true;
                  _loc40_.end = _loc35_;
                  _loc40_.start = _loc32_;
                  _loc40_.path0 = _loc21_;
                  _loc40_.path1 = _loc22_;
                  _loc40_.time = _loc29_;
                  _loc40_.vertex = _loc28_;
                  §§pop().add(_loc40_);
               }
               else
               {
                  _loc30_ = (_loc11_ * _loc26_ - _loc10_ * _loc27_) * _loc25_;
                  _loc42_ = 0;
                  _loc43_ = 0;
                  _loc42_ = _loc19_.posx;
                  _loc43_ = _loc19_.posy;
                  _loc44_ = _loc30_;
                  _loc42_ += _loc23_ * _loc44_;
                  _loc43_ += _loc24_ * _loc44_;
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc36_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc36_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc36_.next;
                     _loc36_.next = null;
                  }
                  _loc36_.forced = false;
                  _loc36_.x = _loc42_;
                  _loc36_.y = _loc43_;
                  _loc35_ = _loc36_;
                  if(_loc32_ == null)
                  {
                     _loc32_ = _loc35_.prev = _loc35_.next = _loc35_;
                  }
                  else
                  {
                     _loc35_.next = _loc32_;
                     _loc35_.prev = _loc32_.prev;
                     _loc32_.prev.next = _loc35_;
                     _loc32_.prev = _loc35_;
                  }
                  _loc35_;
                  _loc35_ = _loc32_.prev;
                  _loc32_ = null;
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc41_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc41_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc41_.next;
                     _loc41_.next = null;
                  }
                  _loc41_.forced = false;
                  _loc41_.x = _loc42_;
                  _loc41_.y = _loc43_;
                  _loc36_ = _loc41_;
                  if(_loc32_ == null)
                  {
                     _loc32_ = _loc36_.prev = _loc36_.next = _loc36_;
                  }
                  else
                  {
                     _loc36_.next = _loc32_;
                     _loc36_.prev = _loc32_.prev;
                     _loc32_.prev.next = _loc36_;
                     _loc32_.prev = _loc36_;
                  }
                  _loc36_;
                  _loc36_ = _loc34_;
                  if(_loc32_ == null)
                  {
                     _loc32_ = _loc36_.prev = _loc36_.next = _loc36_;
                  }
                  else
                  {
                     _loc36_.next = _loc32_;
                     _loc36_.prev = _loc32_.prev;
                     _loc32_.prev.next = _loc36_;
                     _loc32_.prev = _loc36_;
                  }
                  _loc36_;
                  _loc21_ = ZPP_Cutter.paths.head.elt;
                  §§push(ZPP_Cutter.paths);
                  if(ZPP_CutVert.zpp_pool == null)
                  {
                     _loc22_ = new ZPP_CutVert();
                  }
                  else
                  {
                     _loc22_ = ZPP_CutVert.zpp_pool;
                     ZPP_CutVert.zpp_pool = _loc22_.next;
                     _loc22_.next = null;
                  }
                  null;
                  _loc22_.vert = _loc32_;
                  _loc22_.parent = _loc22_;
                  _loc22_.rank = 0;
                  _loc22_.used = false;
                  §§pop().add(_loc22_);
                  _loc22_ = ZPP_Cutter.paths.head.elt;
                  _loc28_ = false;
                  §§push(ZPP_Cutter.ints);
                  if(ZPP_CutInt.zpp_pool == null)
                  {
                     _loc40_ = new ZPP_CutInt();
                  }
                  else
                  {
                     _loc40_ = ZPP_CutInt.zpp_pool;
                     ZPP_CutInt.zpp_pool = _loc40_.next;
                     _loc40_.next = null;
                  }
                  null;
                  _loc40_.virtualint = false;
                  _loc40_.end = _loc35_;
                  _loc40_.start = _loc32_;
                  _loc40_.path0 = _loc21_;
                  _loc40_.path1 = _loc22_;
                  _loc40_.time = _loc29_;
                  _loc40_.vertex = _loc28_;
                  §§pop().add(_loc40_);
               }
            }
            _loc19_ = _loc19_.next;
         }
         while(_loc19_ != _loc15_);
         
         _loc34_ = _loc32_.prev;
         _loc34_.next.prev = _loc33_.prev;
         _loc33_.prev.next = _loc34_.next;
         _loc34_.next = _loc33_;
         _loc33_.prev = _loc34_;
         _loc20_ = ZPP_Cutter.paths.head.elt;
         if(_loc18_ == _loc18_.parent)
         {
            §§push(_loc18_);
         }
         else
         {
            _loc22_ = _loc18_;
            _loc37_ = null;
            while(_loc22_ != _loc22_.parent)
            {
               _loc38_ = _loc22_.parent;
               _loc22_.parent = _loc37_;
               _loc37_ = _loc22_;
               _loc22_ = _loc38_;
            }
            while(_loc37_ != null)
            {
               _loc38_ = _loc37_.parent;
               _loc37_.parent = _loc22_;
               _loc37_ = _loc38_;
            }
            §§push(_loc22_);
         }
         _loc21_ = §§pop();
         if(_loc20_ == _loc20_.parent)
         {
            §§push(_loc20_);
         }
         else
         {
            _loc37_ = _loc20_;
            _loc38_ = null;
            while(_loc37_ != _loc37_.parent)
            {
               _loc39_ = _loc37_.parent;
               _loc37_.parent = _loc38_;
               _loc38_ = _loc37_;
               _loc37_ = _loc39_;
            }
            while(_loc38_ != null)
            {
               _loc39_ = _loc38_.parent;
               _loc38_.parent = _loc37_;
               _loc38_ = _loc39_;
            }
            §§push(_loc37_);
         }
         _loc22_ = §§pop();
         if(_loc21_ != _loc22_)
         {
            if(_loc21_.rank < _loc22_.rank)
            {
               _loc21_.parent = _loc22_;
            }
            else if(_loc21_.rank > _loc22_.rank)
            {
               _loc22_.parent = _loc21_;
            }
            else
            {
               _loc22_.parent = _loc21_;
               ++_loc21_.rank;
            }
         }
         var _loc45_:ZNPList_ZPP_CutInt = ZPP_Cutter.ints;
         if(_loc45_.head != null && _loc45_.head.next != null)
         {
            _loc46_ = _loc45_.head;
            _loc47_ = null;
            _loc48_ = null;
            _loc49_ = null;
            _loc50_ = null;
            _loc51_ = 1;
            do
            {
               _loc52_ = 0;
               _loc48_ = _loc46_;
               _loc47_ = _loc46_ = null;
               while(_loc48_ != null)
               {
                  _loc52_++;
                  _loc49_ = _loc48_;
                  _loc53_ = 0;
                  _loc54_ = _loc51_;
                  while(_loc49_ != null && _loc53_ < _loc51_)
                  {
                     _loc53_++;
                     _loc49_ = _loc49_.next;
                  }
                  while(_loc53_ > 0 || _loc54_ > 0 && _loc49_ != null)
                  {
                     if(_loc53_ == 0)
                     {
                        _loc50_ = _loc49_;
                        _loc49_ = _loc49_.next;
                        _loc54_--;
                     }
                     else if(_loc54_ == 0 || _loc49_ == null)
                     {
                        _loc50_ = _loc48_;
                        _loc48_ = _loc48_.next;
                        _loc53_--;
                     }
                     else if(_loc48_.elt.time < _loc49_.elt.time)
                     {
                        _loc50_ = _loc48_;
                        _loc48_ = _loc48_.next;
                        _loc53_--;
                     }
                     else
                     {
                        _loc50_ = _loc49_;
                        _loc49_ = _loc49_.next;
                        _loc54_--;
                     }
                     if(_loc47_ != null)
                     {
                        _loc47_.next = _loc50_;
                     }
                     else
                     {
                        _loc46_ = _loc50_;
                     }
                     _loc47_ = _loc50_;
                  }
                  _loc48_ = _loc49_;
               }
               _loc47_.next = null;
               _loc51_ <<= 1;
            }
            while(_loc52_ > 1);
            
            _loc45_.head = _loc46_;
            _loc45_.modified = true;
            _loc45_.pushmod = true;
         }
         while(ZPP_Cutter.ints.head != null)
         {
            _loc40_ = ZPP_Cutter.ints.pop_unsafe();
            _loc55_ = ZPP_Cutter.ints.pop_unsafe();
            if(!_loc40_.virtualint && !_loc55_.virtualint)
            {
               _loc40_.end.next.prev = _loc55_.start.prev;
               _loc55_.start.prev.next = _loc40_.end.next;
               _loc40_.end.next = _loc55_.start;
               _loc55_.start.prev = _loc40_.end;
               _loc55_.end.next.prev = _loc40_.start.prev;
               _loc40_.start.prev.next = _loc55_.end.next;
               _loc55_.end.next = _loc40_.start;
               _loc40_.start.prev = _loc55_.end;
               if(_loc40_.path0 == _loc40_.path0.parent)
               {
                  §§push(_loc40_.path0);
               }
               else
               {
                  _loc22_ = _loc40_.path0;
                  _loc37_ = null;
                  while(_loc22_ != _loc22_.parent)
                  {
                     _loc38_ = _loc22_.parent;
                     _loc22_.parent = _loc37_;
                     _loc37_ = _loc22_;
                     _loc22_ = _loc38_;
                  }
                  while(_loc37_ != null)
                  {
                     _loc38_ = _loc37_.parent;
                     _loc37_.parent = _loc22_;
                     _loc37_ = _loc38_;
                  }
                  §§push(_loc22_);
               }
               _loc21_ = §§pop();
               if(_loc55_.path1 == _loc55_.path1.parent)
               {
                  §§push(_loc55_.path1);
               }
               else
               {
                  _loc37_ = _loc55_.path1;
                  _loc38_ = null;
                  while(_loc37_ != _loc37_.parent)
                  {
                     _loc39_ = _loc37_.parent;
                     _loc37_.parent = _loc38_;
                     _loc38_ = _loc37_;
                     _loc37_ = _loc39_;
                  }
                  while(_loc38_ != null)
                  {
                     _loc39_ = _loc38_.parent;
                     _loc38_.parent = _loc37_;
                     _loc38_ = _loc39_;
                  }
                  §§push(_loc37_);
               }
               _loc22_ = §§pop();
               if(_loc21_ != _loc22_)
               {
                  if(_loc21_.rank < _loc22_.rank)
                  {
                     _loc21_.parent = _loc22_;
                  }
                  else if(_loc21_.rank > _loc22_.rank)
                  {
                     _loc22_.parent = _loc21_;
                  }
                  else
                  {
                     _loc22_.parent = _loc21_;
                     ++_loc21_.rank;
                  }
               }
               if(_loc40_.path1 == _loc40_.path1.parent)
               {
                  §§push(_loc40_.path1);
               }
               else
               {
                  _loc22_ = _loc40_.path1;
                  _loc37_ = null;
                  while(_loc22_ != _loc22_.parent)
                  {
                     _loc38_ = _loc22_.parent;
                     _loc22_.parent = _loc37_;
                     _loc37_ = _loc22_;
                     _loc22_ = _loc38_;
                  }
                  while(_loc37_ != null)
                  {
                     _loc38_ = _loc37_.parent;
                     _loc37_.parent = _loc22_;
                     _loc37_ = _loc38_;
                  }
                  §§push(_loc22_);
               }
               _loc21_ = §§pop();
               if(_loc55_.path0 == _loc55_.path0.parent)
               {
                  §§push(_loc55_.path0);
               }
               else
               {
                  _loc37_ = _loc55_.path0;
                  _loc38_ = null;
                  while(_loc37_ != _loc37_.parent)
                  {
                     _loc39_ = _loc37_.parent;
                     _loc37_.parent = _loc38_;
                     _loc38_ = _loc37_;
                     _loc37_ = _loc39_;
                  }
                  while(_loc38_ != null)
                  {
                     _loc39_ = _loc38_.parent;
                     _loc38_.parent = _loc37_;
                     _loc38_ = _loc39_;
                  }
                  §§push(_loc37_);
               }
               _loc22_ = §§pop();
               if(_loc21_ != _loc22_)
               {
                  if(_loc21_.rank < _loc22_.rank)
                  {
                     _loc21_.parent = _loc22_;
                  }
                  else if(_loc21_.rank > _loc22_.rank)
                  {
                     _loc22_.parent = _loc21_;
                  }
                  else
                  {
                     _loc22_.parent = _loc21_;
                     ++_loc21_.rank;
                  }
               }
            }
            else if(_loc40_.virtualint && !_loc55_.virtualint)
            {
               §§push(_loc55_);
               if(_loc55_.end != null && _loc55_.end.prev == _loc55_.end)
               {
                  _loc55_.end.next = _loc55_.end.prev = null;
                  _loc35_ = _loc55_.end;
                  if(_loc35_.wrap != null)
                  {
                     _loc35_.wrap.zpp_inner._inuse = false;
                     _loc56_ = _loc35_.wrap;
                     if(_loc56_ != null && _loc56_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc9_ = _loc56_.zpp_inner;
                     if(_loc9_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc9_._isimmutable != null)
                     {
                        _loc9_._isimmutable();
                     }
                     if(_loc56_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc9_ = _loc56_.zpp_inner;
                     _loc56_.zpp_inner.outer = null;
                     _loc56_.zpp_inner = null;
                     _loc57_ = _loc56_;
                     _loc57_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc57_;
                     }
                     ZPP_PubPool.nextVec2 = _loc57_;
                     _loc57_.zpp_disp = true;
                     _loc58_ = _loc9_;
                     if(_loc58_.outer != null)
                     {
                        _loc58_.outer.zpp_inner = null;
                        _loc58_.outer = null;
                     }
                     _loc58_._isimmutable = null;
                     _loc58_._validate = null;
                     _loc58_._invalidate = null;
                     _loc58_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc58_;
                     _loc35_.wrap = null;
                  }
                  _loc35_.prev = _loc35_.next = null;
                  _loc35_.next = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc35_;
                  §§push(null);
               }
               else
               {
                  _loc35_ = _loc55_.end.prev;
                  _loc55_.end.prev.next = _loc55_.end.next;
                  _loc55_.end.next.prev = _loc55_.end.prev;
                  _loc55_.end.next = _loc55_.end.prev = null;
                  _loc36_ = _loc55_.end;
                  if(_loc36_.wrap != null)
                  {
                     _loc36_.wrap.zpp_inner._inuse = false;
                     _loc56_ = _loc36_.wrap;
                     if(_loc56_ != null && _loc56_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc9_ = _loc56_.zpp_inner;
                     if(_loc9_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc9_._isimmutable != null)
                     {
                        _loc9_._isimmutable();
                     }
                     if(_loc56_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc9_ = _loc56_.zpp_inner;
                     _loc56_.zpp_inner.outer = null;
                     _loc56_.zpp_inner = null;
                     _loc57_ = _loc56_;
                     _loc57_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc57_;
                     }
                     ZPP_PubPool.nextVec2 = _loc57_;
                     _loc57_.zpp_disp = true;
                     _loc58_ = _loc9_;
                     if(_loc58_.outer != null)
                     {
                        _loc58_.outer.zpp_inner = null;
                        _loc58_.outer = null;
                     }
                     _loc58_._isimmutable = null;
                     _loc58_._validate = null;
                     _loc58_._invalidate = null;
                     _loc58_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc58_;
                     _loc36_.wrap = null;
                  }
                  _loc36_.prev = _loc36_.next = null;
                  _loc36_.next = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc36_;
                  _loc55_.end = null;
                  §§push(_loc35_);
               }
               §§pop().end = §§pop();
               if(!_loc55_.vertex)
               {
                  if(_loc55_.end != _loc55_.path0.vert)
                  {
                     _loc55_.start.x = _loc55_.end.x;
                     _loc55_.start.y = _loc55_.end.y;
                     §§push(_loc55_);
                     if(_loc55_.end != null && _loc55_.end.prev == _loc55_.end)
                     {
                        _loc55_.end.next = _loc55_.end.prev = null;
                        _loc35_ = _loc55_.end;
                        if(_loc35_.wrap != null)
                        {
                           _loc35_.wrap.zpp_inner._inuse = false;
                           _loc56_ = _loc35_.wrap;
                           if(_loc56_ != null && _loc56_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           if(_loc9_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc9_._isimmutable != null)
                           {
                              _loc9_._isimmutable();
                           }
                           if(_loc56_.zpp_inner._inuse)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This Vec2 is not disposable";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           _loc56_.zpp_inner.outer = null;
                           _loc56_.zpp_inner = null;
                           _loc57_ = _loc56_;
                           _loc57_.zpp_pool = null;
                           if(ZPP_PubPool.nextVec2 != null)
                           {
                              ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                           }
                           else
                           {
                              ZPP_PubPool.poolVec2 = _loc57_;
                           }
                           ZPP_PubPool.nextVec2 = _loc57_;
                           _loc57_.zpp_disp = true;
                           _loc58_ = _loc9_;
                           if(_loc58_.outer != null)
                           {
                              _loc58_.outer.zpp_inner = null;
                              _loc58_.outer = null;
                           }
                           _loc58_._isimmutable = null;
                           _loc58_._validate = null;
                           _loc58_._invalidate = null;
                           _loc58_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc58_;
                           _loc35_.wrap = null;
                        }
                        _loc35_.prev = _loc35_.next = null;
                        _loc35_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc35_;
                        §§push(null);
                     }
                     else
                     {
                        _loc35_ = _loc55_.end.prev;
                        _loc55_.end.prev.next = _loc55_.end.next;
                        _loc55_.end.next.prev = _loc55_.end.prev;
                        _loc55_.end.next = _loc55_.end.prev = null;
                        _loc36_ = _loc55_.end;
                        if(_loc36_.wrap != null)
                        {
                           _loc36_.wrap.zpp_inner._inuse = false;
                           _loc56_ = _loc36_.wrap;
                           if(_loc56_ != null && _loc56_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           if(_loc9_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc9_._isimmutable != null)
                           {
                              _loc9_._isimmutable();
                           }
                           if(_loc56_.zpp_inner._inuse)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This Vec2 is not disposable";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           _loc56_.zpp_inner.outer = null;
                           _loc56_.zpp_inner = null;
                           _loc57_ = _loc56_;
                           _loc57_.zpp_pool = null;
                           if(ZPP_PubPool.nextVec2 != null)
                           {
                              ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                           }
                           else
                           {
                              ZPP_PubPool.poolVec2 = _loc57_;
                           }
                           ZPP_PubPool.nextVec2 = _loc57_;
                           _loc57_.zpp_disp = true;
                           _loc58_ = _loc9_;
                           if(_loc58_.outer != null)
                           {
                              _loc58_.outer.zpp_inner = null;
                              _loc58_.outer = null;
                           }
                           _loc58_._isimmutable = null;
                           _loc58_._validate = null;
                           _loc58_._invalidate = null;
                           _loc58_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc58_;
                           _loc36_.wrap = null;
                        }
                        _loc36_.prev = _loc36_.next = null;
                        _loc36_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc36_;
                        _loc55_.end = null;
                        §§push(_loc35_);
                     }
                     §§pop().end = §§pop();
                  }
                  else
                  {
                     _loc35_ = _loc55_.start.next;
                     _loc55_.start.x = _loc35_.x;
                     _loc55_.start.y = _loc35_.y;
                     if(_loc35_ != null && _loc35_.prev == _loc35_)
                     {
                        _loc35_.next = _loc35_.prev = null;
                        _loc36_ = _loc35_;
                        if(_loc36_.wrap != null)
                        {
                           _loc36_.wrap.zpp_inner._inuse = false;
                           _loc56_ = _loc36_.wrap;
                           if(_loc56_ != null && _loc56_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           if(_loc9_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc9_._isimmutable != null)
                           {
                              _loc9_._isimmutable();
                           }
                           if(_loc56_.zpp_inner._inuse)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This Vec2 is not disposable";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           _loc56_.zpp_inner.outer = null;
                           _loc56_.zpp_inner = null;
                           _loc57_ = _loc56_;
                           _loc57_.zpp_pool = null;
                           if(ZPP_PubPool.nextVec2 != null)
                           {
                              ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                           }
                           else
                           {
                              ZPP_PubPool.poolVec2 = _loc57_;
                           }
                           ZPP_PubPool.nextVec2 = _loc57_;
                           _loc57_.zpp_disp = true;
                           _loc58_ = _loc9_;
                           if(_loc58_.outer != null)
                           {
                              _loc58_.outer.zpp_inner = null;
                              _loc58_.outer = null;
                           }
                           _loc58_._isimmutable = null;
                           _loc58_._validate = null;
                           _loc58_._invalidate = null;
                           _loc58_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc58_;
                           _loc36_.wrap = null;
                        }
                        _loc36_.prev = _loc36_.next = null;
                        _loc36_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc36_;
                        _loc35_ = null;
                     }
                     else
                     {
                        _loc35_.prev.next = _loc35_.next;
                        _loc35_.next.prev = _loc35_.prev;
                        _loc35_.next = _loc35_.prev = null;
                        _loc36_ = _loc35_;
                        if(_loc36_.wrap != null)
                        {
                           _loc36_.wrap.zpp_inner._inuse = false;
                           _loc56_ = _loc36_.wrap;
                           if(_loc56_ != null && _loc56_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           if(_loc9_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc9_._isimmutable != null)
                           {
                              _loc9_._isimmutable();
                           }
                           if(_loc56_.zpp_inner._inuse)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This Vec2 is not disposable";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           _loc56_.zpp_inner.outer = null;
                           _loc56_.zpp_inner = null;
                           _loc57_ = _loc56_;
                           _loc57_.zpp_pool = null;
                           if(ZPP_PubPool.nextVec2 != null)
                           {
                              ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                           }
                           else
                           {
                              ZPP_PubPool.poolVec2 = _loc57_;
                           }
                           ZPP_PubPool.nextVec2 = _loc57_;
                           _loc57_.zpp_disp = true;
                           _loc58_ = _loc9_;
                           if(_loc58_.outer != null)
                           {
                              _loc58_.outer.zpp_inner = null;
                              _loc58_.outer = null;
                           }
                           _loc58_._isimmutable = null;
                           _loc58_._validate = null;
                           _loc58_._invalidate = null;
                           _loc58_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc58_;
                           _loc36_.wrap = null;
                        }
                        _loc36_.prev = _loc36_.next = null;
                        _loc36_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc36_;
                     }
                  }
               }
               _loc55_.end.next.prev = _loc55_.start.prev;
               _loc55_.start.prev.next = _loc55_.end.next;
               _loc55_.end.next = _loc55_.start;
               _loc55_.start.prev = _loc55_.end;
               if(_loc55_.path0 == _loc55_.path0.parent)
               {
                  §§push(_loc55_.path0);
               }
               else
               {
                  _loc22_ = _loc55_.path0;
                  _loc37_ = null;
                  while(_loc22_ != _loc22_.parent)
                  {
                     _loc38_ = _loc22_.parent;
                     _loc22_.parent = _loc37_;
                     _loc37_ = _loc22_;
                     _loc22_ = _loc38_;
                  }
                  while(_loc37_ != null)
                  {
                     _loc38_ = _loc37_.parent;
                     _loc37_.parent = _loc22_;
                     _loc37_ = _loc38_;
                  }
                  §§push(_loc22_);
               }
               _loc21_ = §§pop();
               if(_loc55_.path1 == _loc55_.path1.parent)
               {
                  §§push(_loc55_.path1);
               }
               else
               {
                  _loc37_ = _loc55_.path1;
                  _loc38_ = null;
                  while(_loc37_ != _loc37_.parent)
                  {
                     _loc39_ = _loc37_.parent;
                     _loc37_.parent = _loc38_;
                     _loc38_ = _loc37_;
                     _loc37_ = _loc39_;
                  }
                  while(_loc38_ != null)
                  {
                     _loc39_ = _loc38_.parent;
                     _loc38_.parent = _loc37_;
                     _loc38_ = _loc39_;
                  }
                  §§push(_loc37_);
               }
               _loc22_ = §§pop();
               if(_loc21_ != _loc22_)
               {
                  if(_loc21_.rank < _loc22_.rank)
                  {
                     _loc21_.parent = _loc22_;
                  }
                  else if(_loc21_.rank > _loc22_.rank)
                  {
                     _loc22_.parent = _loc21_;
                  }
                  else
                  {
                     _loc22_.parent = _loc21_;
                     ++_loc21_.rank;
                  }
               }
            }
            else if(_loc55_.virtualint && !_loc40_.virtualint)
            {
               §§push(_loc40_);
               if(_loc40_.end != null && _loc40_.end.prev == _loc40_.end)
               {
                  _loc40_.end.next = _loc40_.end.prev = null;
                  _loc35_ = _loc40_.end;
                  if(_loc35_.wrap != null)
                  {
                     _loc35_.wrap.zpp_inner._inuse = false;
                     _loc56_ = _loc35_.wrap;
                     if(_loc56_ != null && _loc56_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc9_ = _loc56_.zpp_inner;
                     if(_loc9_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc9_._isimmutable != null)
                     {
                        _loc9_._isimmutable();
                     }
                     if(_loc56_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc9_ = _loc56_.zpp_inner;
                     _loc56_.zpp_inner.outer = null;
                     _loc56_.zpp_inner = null;
                     _loc57_ = _loc56_;
                     _loc57_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc57_;
                     }
                     ZPP_PubPool.nextVec2 = _loc57_;
                     _loc57_.zpp_disp = true;
                     _loc58_ = _loc9_;
                     if(_loc58_.outer != null)
                     {
                        _loc58_.outer.zpp_inner = null;
                        _loc58_.outer = null;
                     }
                     _loc58_._isimmutable = null;
                     _loc58_._validate = null;
                     _loc58_._invalidate = null;
                     _loc58_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc58_;
                     _loc35_.wrap = null;
                  }
                  _loc35_.prev = _loc35_.next = null;
                  _loc35_.next = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc35_;
                  §§push(null);
               }
               else
               {
                  _loc35_ = _loc40_.end.prev;
                  _loc40_.end.prev.next = _loc40_.end.next;
                  _loc40_.end.next.prev = _loc40_.end.prev;
                  _loc40_.end.next = _loc40_.end.prev = null;
                  _loc36_ = _loc40_.end;
                  if(_loc36_.wrap != null)
                  {
                     _loc36_.wrap.zpp_inner._inuse = false;
                     _loc56_ = _loc36_.wrap;
                     if(_loc56_ != null && _loc56_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc9_ = _loc56_.zpp_inner;
                     if(_loc9_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc9_._isimmutable != null)
                     {
                        _loc9_._isimmutable();
                     }
                     if(_loc56_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc9_ = _loc56_.zpp_inner;
                     _loc56_.zpp_inner.outer = null;
                     _loc56_.zpp_inner = null;
                     _loc57_ = _loc56_;
                     _loc57_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc57_;
                     }
                     ZPP_PubPool.nextVec2 = _loc57_;
                     _loc57_.zpp_disp = true;
                     _loc58_ = _loc9_;
                     if(_loc58_.outer != null)
                     {
                        _loc58_.outer.zpp_inner = null;
                        _loc58_.outer = null;
                     }
                     _loc58_._isimmutable = null;
                     _loc58_._validate = null;
                     _loc58_._invalidate = null;
                     _loc58_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc58_;
                     _loc36_.wrap = null;
                  }
                  _loc36_.prev = _loc36_.next = null;
                  _loc36_.next = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc36_;
                  _loc40_.end = null;
                  §§push(_loc35_);
               }
               §§pop().end = §§pop();
               if(!_loc40_.vertex)
               {
                  if(_loc40_.end != _loc40_.path0.vert)
                  {
                     _loc40_.start.x = _loc40_.end.x;
                     _loc40_.start.y = _loc40_.end.y;
                     §§push(_loc40_);
                     if(_loc40_.end != null && _loc40_.end.prev == _loc40_.end)
                     {
                        _loc40_.end.next = _loc40_.end.prev = null;
                        _loc35_ = _loc40_.end;
                        if(_loc35_.wrap != null)
                        {
                           _loc35_.wrap.zpp_inner._inuse = false;
                           _loc56_ = _loc35_.wrap;
                           if(_loc56_ != null && _loc56_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           if(_loc9_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc9_._isimmutable != null)
                           {
                              _loc9_._isimmutable();
                           }
                           if(_loc56_.zpp_inner._inuse)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This Vec2 is not disposable";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           _loc56_.zpp_inner.outer = null;
                           _loc56_.zpp_inner = null;
                           _loc57_ = _loc56_;
                           _loc57_.zpp_pool = null;
                           if(ZPP_PubPool.nextVec2 != null)
                           {
                              ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                           }
                           else
                           {
                              ZPP_PubPool.poolVec2 = _loc57_;
                           }
                           ZPP_PubPool.nextVec2 = _loc57_;
                           _loc57_.zpp_disp = true;
                           _loc58_ = _loc9_;
                           if(_loc58_.outer != null)
                           {
                              _loc58_.outer.zpp_inner = null;
                              _loc58_.outer = null;
                           }
                           _loc58_._isimmutable = null;
                           _loc58_._validate = null;
                           _loc58_._invalidate = null;
                           _loc58_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc58_;
                           _loc35_.wrap = null;
                        }
                        _loc35_.prev = _loc35_.next = null;
                        _loc35_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc35_;
                        §§push(null);
                     }
                     else
                     {
                        _loc35_ = _loc40_.end.prev;
                        _loc40_.end.prev.next = _loc40_.end.next;
                        _loc40_.end.next.prev = _loc40_.end.prev;
                        _loc40_.end.next = _loc40_.end.prev = null;
                        _loc36_ = _loc40_.end;
                        if(_loc36_.wrap != null)
                        {
                           _loc36_.wrap.zpp_inner._inuse = false;
                           _loc56_ = _loc36_.wrap;
                           if(_loc56_ != null && _loc56_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           if(_loc9_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc9_._isimmutable != null)
                           {
                              _loc9_._isimmutable();
                           }
                           if(_loc56_.zpp_inner._inuse)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This Vec2 is not disposable";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           _loc56_.zpp_inner.outer = null;
                           _loc56_.zpp_inner = null;
                           _loc57_ = _loc56_;
                           _loc57_.zpp_pool = null;
                           if(ZPP_PubPool.nextVec2 != null)
                           {
                              ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                           }
                           else
                           {
                              ZPP_PubPool.poolVec2 = _loc57_;
                           }
                           ZPP_PubPool.nextVec2 = _loc57_;
                           _loc57_.zpp_disp = true;
                           _loc58_ = _loc9_;
                           if(_loc58_.outer != null)
                           {
                              _loc58_.outer.zpp_inner = null;
                              _loc58_.outer = null;
                           }
                           _loc58_._isimmutable = null;
                           _loc58_._validate = null;
                           _loc58_._invalidate = null;
                           _loc58_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc58_;
                           _loc36_.wrap = null;
                        }
                        _loc36_.prev = _loc36_.next = null;
                        _loc36_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc36_;
                        _loc40_.end = null;
                        §§push(_loc35_);
                     }
                     §§pop().end = §§pop();
                  }
                  else
                  {
                     _loc35_ = _loc40_.start.next;
                     _loc40_.start.x = _loc35_.x;
                     _loc40_.start.y = _loc35_.y;
                     if(_loc35_ != null && _loc35_.prev == _loc35_)
                     {
                        _loc35_.next = _loc35_.prev = null;
                        _loc36_ = _loc35_;
                        if(_loc36_.wrap != null)
                        {
                           _loc36_.wrap.zpp_inner._inuse = false;
                           _loc56_ = _loc36_.wrap;
                           if(_loc56_ != null && _loc56_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           if(_loc9_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc9_._isimmutable != null)
                           {
                              _loc9_._isimmutable();
                           }
                           if(_loc56_.zpp_inner._inuse)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This Vec2 is not disposable";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           _loc56_.zpp_inner.outer = null;
                           _loc56_.zpp_inner = null;
                           _loc57_ = _loc56_;
                           _loc57_.zpp_pool = null;
                           if(ZPP_PubPool.nextVec2 != null)
                           {
                              ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                           }
                           else
                           {
                              ZPP_PubPool.poolVec2 = _loc57_;
                           }
                           ZPP_PubPool.nextVec2 = _loc57_;
                           _loc57_.zpp_disp = true;
                           _loc58_ = _loc9_;
                           if(_loc58_.outer != null)
                           {
                              _loc58_.outer.zpp_inner = null;
                              _loc58_.outer = null;
                           }
                           _loc58_._isimmutable = null;
                           _loc58_._validate = null;
                           _loc58_._invalidate = null;
                           _loc58_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc58_;
                           _loc36_.wrap = null;
                        }
                        _loc36_.prev = _loc36_.next = null;
                        _loc36_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc36_;
                        _loc35_ = null;
                     }
                     else
                     {
                        _loc35_.prev.next = _loc35_.next;
                        _loc35_.next.prev = _loc35_.prev;
                        _loc35_.next = _loc35_.prev = null;
                        _loc36_ = _loc35_;
                        if(_loc36_.wrap != null)
                        {
                           _loc36_.wrap.zpp_inner._inuse = false;
                           _loc56_ = _loc36_.wrap;
                           if(_loc56_ != null && _loc56_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           if(_loc9_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc9_._isimmutable != null)
                           {
                              _loc9_._isimmutable();
                           }
                           if(_loc56_.zpp_inner._inuse)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This Vec2 is not disposable";
                           }
                           _loc9_ = _loc56_.zpp_inner;
                           _loc56_.zpp_inner.outer = null;
                           _loc56_.zpp_inner = null;
                           _loc57_ = _loc56_;
                           _loc57_.zpp_pool = null;
                           if(ZPP_PubPool.nextVec2 != null)
                           {
                              ZPP_PubPool.nextVec2.zpp_pool = _loc57_;
                           }
                           else
                           {
                              ZPP_PubPool.poolVec2 = _loc57_;
                           }
                           ZPP_PubPool.nextVec2 = _loc57_;
                           _loc57_.zpp_disp = true;
                           _loc58_ = _loc9_;
                           if(_loc58_.outer != null)
                           {
                              _loc58_.outer.zpp_inner = null;
                              _loc58_.outer = null;
                           }
                           _loc58_._isimmutable = null;
                           _loc58_._validate = null;
                           _loc58_._invalidate = null;
                           _loc58_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc58_;
                           _loc36_.wrap = null;
                        }
                        _loc36_.prev = _loc36_.next = null;
                        _loc36_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc36_;
                     }
                  }
               }
               _loc40_.end.next.prev = _loc40_.start.prev;
               _loc40_.start.prev.next = _loc40_.end.next;
               _loc40_.end.next = _loc40_.start;
               _loc40_.start.prev = _loc40_.end;
               if(_loc40_.path0 == _loc40_.path0.parent)
               {
                  §§push(_loc40_.path0);
               }
               else
               {
                  _loc22_ = _loc40_.path0;
                  _loc37_ = null;
                  while(_loc22_ != _loc22_.parent)
                  {
                     _loc38_ = _loc22_.parent;
                     _loc22_.parent = _loc37_;
                     _loc37_ = _loc22_;
                     _loc22_ = _loc38_;
                  }
                  while(_loc37_ != null)
                  {
                     _loc38_ = _loc37_.parent;
                     _loc37_.parent = _loc22_;
                     _loc37_ = _loc38_;
                  }
                  §§push(_loc22_);
               }
               _loc21_ = §§pop();
               if(_loc40_.path1 == _loc40_.path1.parent)
               {
                  §§push(_loc40_.path1);
               }
               else
               {
                  _loc37_ = _loc40_.path1;
                  _loc38_ = null;
                  while(_loc37_ != _loc37_.parent)
                  {
                     _loc39_ = _loc37_.parent;
                     _loc37_.parent = _loc38_;
                     _loc38_ = _loc37_;
                     _loc37_ = _loc39_;
                  }
                  while(_loc38_ != null)
                  {
                     _loc39_ = _loc38_.parent;
                     _loc38_.parent = _loc37_;
                     _loc38_ = _loc39_;
                  }
                  §§push(_loc37_);
               }
               _loc22_ = §§pop();
               if(_loc21_ != _loc22_)
               {
                  if(_loc21_.rank < _loc22_.rank)
                  {
                     _loc21_.parent = _loc22_;
                  }
                  else if(_loc21_.rank > _loc22_.rank)
                  {
                     _loc22_.parent = _loc21_;
                  }
                  else
                  {
                     _loc22_.parent = _loc21_;
                     ++_loc21_.rank;
                  }
               }
            }
            _loc59_ = _loc40_;
            _loc59_.end = _loc59_.start = null;
            _loc59_.path0 = _loc59_.path1 = null;
            _loc59_.next = ZPP_CutInt.zpp_pool;
            ZPP_CutInt.zpp_pool = _loc59_;
            _loc59_ = _loc55_;
            _loc59_.end = _loc59_.start = null;
            _loc59_.path0 = _loc59_.path1 = null;
            _loc59_.next = ZPP_CutInt.zpp_pool;
            ZPP_CutInt.zpp_pool = _loc59_;
         }
         var _loc60_:GeomPolyList = param6 == null ? new GeomPolyList() : param6;
         var _loc61_:ZNPNode_ZPP_CutVert = ZPP_Cutter.paths.head;
         while(_loc61_ != null)
         {
            _loc21_ = _loc61_.elt;
            if(_loc21_ == _loc21_.parent)
            {
               §§push(_loc21_);
            }
            else
            {
               _loc37_ = _loc21_;
               _loc38_ = null;
               while(_loc37_ != _loc37_.parent)
               {
                  _loc39_ = _loc37_.parent;
                  _loc37_.parent = _loc38_;
                  _loc38_ = _loc37_;
                  _loc37_ = _loc39_;
               }
               while(_loc38_ != null)
               {
                  _loc39_ = _loc38_.parent;
                  _loc38_.parent = _loc37_;
                  _loc38_ = _loc39_;
               }
               §§push(_loc37_);
            }
            _loc22_ = §§pop();
            if(_loc22_.used)
            {
               _loc61_ = _loc61_.next;
            }
            else
            {
               _loc22_.used = true;
               _loc35_ = _loc22_.vert;
               _loc28_ = true;
               while(_loc22_.vert != null && (_loc28_ || _loc35_ != _loc22_.vert))
               {
                  _loc28_ = false;
                  if(_loc35_.x == _loc35_.next.x && _loc35_.y == _loc35_.next.y)
                  {
                     if(_loc35_ == _loc22_.vert)
                     {
                        _loc22_.vert = _loc35_.next == _loc35_ ? null : _loc35_.next;
                        _loc28_ = true;
                     }
                     _loc35_ = null;
                     _loc35_ = _loc35_ != null && _loc35_.prev == _loc35_ ? (_loc35_.next = _loc35_.prev = null, _loc35_) : (_loc36_ = _loc35_.next, _loc35_.prev.next = _loc35_.next, _loc35_.next.prev = _loc35_.prev, _loc35_.next = _loc35_.prev = null, _loc35_ = null, _loc36_);
                  }
                  else
                  {
                     _loc35_ = _loc35_.next;
                  }
               }
               if(_loc22_.vert != null)
               {
                  _loc62_ = GeomPoly.get();
                  _loc62_.zpp_inner.vertices = _loc22_.vert;
                  if(_loc60_.zpp_inner.reverse_flag)
                  {
                     _loc60_.push(_loc62_);
                  }
                  else
                  {
                     _loc60_.unshift(_loc62_);
                  }
               }
               _loc61_ = _loc61_.next;
            }
         }
         while(ZPP_Cutter.paths.head != null)
         {
            _loc21_ = ZPP_Cutter.paths.pop_unsafe();
            _loc22_ = _loc21_;
            _loc22_.vert = null;
            _loc22_.parent = null;
            _loc22_.next = ZPP_CutVert.zpp_pool;
            ZPP_CutVert.zpp_pool = _loc22_;
         }
         while(_loc15_ != null)
         {
            _loc15_ = null;
            _loc15_ = _loc15_ != null && _loc15_.prev == _loc15_ ? (_loc15_.next = _loc15_.prev = null, _loc21_ = _loc15_, _loc21_.vert = null, _loc21_.parent = null, _loc21_.next = ZPP_CutVert.zpp_pool, ZPP_CutVert.zpp_pool = _loc21_, _loc15_) : (_loc21_ = _loc15_.next, _loc15_.prev.next = _loc15_.next, _loc15_.next.prev = _loc15_.prev, _loc15_.next = _loc15_.prev = null, _loc22_ = _loc15_, _loc22_.vert = null, _loc22_.parent = null, _loc22_.next = ZPP_CutVert.zpp_pool, ZPP_CutVert.zpp_pool = _loc22_, _loc15_ = null, _loc21_);
         }
         return _loc60_;
      }
   }
}

import zpp_nape.util.ZNPList_ZPP_CutInt;
import zpp_nape.util.ZNPList_ZPP_CutVert;

