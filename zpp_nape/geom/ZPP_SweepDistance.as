package zpp_nape.geom
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import nape.Config;
   import nape.geom.Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_SweepDistance
   {
      public function ZPP_SweepDistance()
      {
      }
      
      public static function dynamicSweep(param1:ZPP_ToiEvent, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : void
      {
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:* = null as ZPP_Polygon;
         var _loc28_:* = null as ZPP_Vec2;
         var _loc29_:* = null as ZPP_Vec2;
         var _loc30_:* = null as ZPP_Vec2;
         var _loc31_:* = null as ZPP_Vec2;
         var _loc32_:* = null as ZNPNode_ZPP_Edge;
         var _loc33_:* = null as ZPP_Edge;
         var _loc34_:* = null as ZPP_Shape;
         var _loc35_:* = null as ZPP_Shape;
         var _loc36_:* = null as ZPP_Circle;
         var _loc37_:* = null as ZPP_Circle;
         var _loc38_:Number = NaN;
         var _loc39_:Boolean = false;
         var _loc40_:* = null as ZPP_Shape;
         var _loc41_:* = null as ZPP_Edge;
         var _loc42_:Number = NaN;
         var _loc43_:int = 0;
         var _loc44_:* = null as ZPP_Polygon;
         var _loc45_:* = null as ZPP_Edge;
         var _loc46_:* = null as ZPP_Polygon;
         var _loc47_:* = null as ZPP_Polygon;
         var _loc48_:* = null as ZPP_Edge;
         var _loc49_:* = null as ZPP_Edge;
         var _loc50_:* = null as ZPP_Vec2;
         var _loc51_:* = null as ZPP_Vec2;
         var _loc52_:Number = NaN;
         var _loc53_:Number = NaN;
         var _loc54_:Number = NaN;
         var _loc55_:Number = NaN;
         var _loc56_:Number = NaN;
         var _loc57_:Number = NaN;
         var _loc58_:Number = NaN;
         var _loc59_:Number = NaN;
         var _loc60_:Number = NaN;
         var _loc61_:Number = NaN;
         var _loc62_:Number = NaN;
         var _loc63_:Number = NaN;
         var _loc64_:Number = NaN;
         var _loc65_:Number = NaN;
         var _loc66_:Number = NaN;
         var _loc67_:Number = NaN;
         var _loc68_:Number = NaN;
         var _loc69_:Number = NaN;
         var _loc70_:Number = NaN;
         var _loc71_:* = null as ZPP_Vec2;
         var _loc72_:Number = NaN;
         var _loc73_:Number = NaN;
         var _loc74_:* = null as ZPP_Vec2;
         var _loc75_:Number = NaN;
         var _loc76_:Number = NaN;
         var _loc77_:Number = NaN;
         var _loc78_:Number = NaN;
         var _loc79_:Number = NaN;
         var _loc6_:ZPP_Shape = param1.s1;
         var _loc7_:ZPP_Shape = param1.s2;
         var _loc8_:ZPP_Body = _loc6_.body;
         var _loc9_:ZPP_Body = _loc7_.body;
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         _loc10_ = _loc9_.velx - _loc8_.velx;
         _loc11_ = _loc9_.vely - _loc8_.vely;
         var _loc12_:Number = _loc8_.angvel;
         if(_loc12_ < 0)
         {
            _loc12_ = -_loc12_;
         }
         var _loc13_:Number = _loc9_.angvel;
         if(_loc13_ < 0)
         {
            _loc13_ = -_loc13_;
         }
         var _loc14_:Number = _loc6_.sweepCoef * _loc12_ + _loc7_.sweepCoef * _loc13_;
         if(!param5 && !param1.kinematic && _loc10_ * _loc10_ + _loc11_ * _loc11_ < Config.dynamicSweepLinearThreshold * Config.dynamicSweepLinearThreshold && _loc14_ < Config.dynamicSweepAngularThreshold)
         {
            param1.toi = -1;
            param1.failed = true;
            return;
         }
         var _loc15_:ZPP_Vec2 = param1.c1;
         var _loc16_:ZPP_Vec2 = param1.c2;
         var _loc17_:ZPP_Vec2 = param1.axis;
         var _loc18_:Number = param3;
         var _loc19_:int = 0;
         while(true)
         {
            _loc20_ = _loc18_ * param2;
            _loc21_ = _loc20_ - _loc8_.sweepTime;
            if(_loc21_ != 0)
            {
               _loc8_.sweepTime = _loc20_;
               _loc22_ = _loc21_;
               _loc8_.posx += _loc8_.velx * _loc22_;
               _loc8_.posy += _loc8_.vely * _loc22_;
               if(_loc8_.angvel != 0)
               {
                  _loc22_ = _loc8_.sweep_angvel * _loc21_;
                  _loc8_.rot += _loc22_;
                  if(_loc22_ * _loc22_ > 0.0001)
                  {
                     _loc8_.axisx = Math.sin(_loc8_.rot);
                     _loc8_.axisy = Math.cos(_loc8_.rot);
                     null;
                  }
                  else
                  {
                     _loc23_ = _loc22_ * _loc22_;
                     _loc24_ = 1 - 0.5 * _loc23_;
                     _loc25_ = 1 - _loc23_ * _loc23_ / 8;
                     _loc26_ = (_loc24_ * _loc8_.axisx + _loc22_ * _loc8_.axisy) * _loc25_;
                     _loc8_.axisy = (_loc24_ * _loc8_.axisy - _loc22_ * _loc8_.axisx) * _loc25_;
                     _loc8_.axisx = _loc26_;
                  }
               }
            }
            if(_loc6_.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc6_.worldCOMx = _loc8_.posx + (_loc8_.axisy * _loc6_.localCOMx - _loc8_.axisx * _loc6_.localCOMy);
               _loc6_.worldCOMy = _loc8_.posy + (_loc6_.localCOMx * _loc8_.axisx + _loc6_.localCOMy * _loc8_.axisy);
            }
            else
            {
               _loc27_ = _loc6_.polygon;
               _loc28_ = _loc27_.lverts.next;
               _loc29_ = _loc27_.gverts.next;
               while(_loc29_ != null)
               {
                  _loc30_ = _loc29_;
                  _loc31_ = _loc28_;
                  _loc28_ = _loc28_.next;
                  _loc30_.x = _loc8_.posx + (_loc8_.axisy * _loc31_.x - _loc8_.axisx * _loc31_.y);
                  _loc30_.y = _loc8_.posy + (_loc31_.x * _loc8_.axisx + _loc31_.y * _loc8_.axisy);
                  _loc29_ = _loc29_.next;
               }
               _loc32_ = _loc27_.edges.head;
               _loc29_ = _loc27_.gverts.next;
               _loc30_ = _loc29_;
               _loc29_ = _loc29_.next;
               while(_loc29_ != null)
               {
                  _loc31_ = _loc29_;
                  _loc33_ = _loc32_.elt;
                  _loc32_ = _loc32_.next;
                  _loc33_.gnormx = _loc8_.axisy * _loc33_.lnormx - _loc8_.axisx * _loc33_.lnormy;
                  _loc33_.gnormy = _loc33_.lnormx * _loc8_.axisx + _loc33_.lnormy * _loc8_.axisy;
                  _loc33_.gprojection = _loc8_.posx * _loc33_.gnormx + _loc8_.posy * _loc33_.gnormy + _loc33_.lprojection;
                  _loc33_.tp0 = _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy;
                  _loc33_.tp1 = _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy;
                  _loc30_ = _loc31_;
                  _loc29_ = _loc29_.next;
               }
               _loc31_ = _loc27_.gverts.next;
               _loc33_ = _loc32_.elt;
               _loc32_ = _loc32_.next;
               _loc33_.gnormx = _loc8_.axisy * _loc33_.lnormx - _loc8_.axisx * _loc33_.lnormy;
               _loc33_.gnormy = _loc33_.lnormx * _loc8_.axisx + _loc33_.lnormy * _loc8_.axisy;
               _loc33_.gprojection = _loc8_.posx * _loc33_.gnormx + _loc8_.posy * _loc33_.gnormy + _loc33_.lprojection;
               _loc33_.tp0 = _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy;
               _loc33_.tp1 = _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy;
            }
            _loc20_ = _loc18_ * param2;
            _loc21_ = _loc20_ - _loc9_.sweepTime;
            if(_loc21_ != 0)
            {
               _loc9_.sweepTime = _loc20_;
               _loc22_ = _loc21_;
               _loc9_.posx += _loc9_.velx * _loc22_;
               _loc9_.posy += _loc9_.vely * _loc22_;
               if(_loc9_.angvel != 0)
               {
                  _loc22_ = _loc9_.sweep_angvel * _loc21_;
                  _loc9_.rot += _loc22_;
                  if(_loc22_ * _loc22_ > 0.0001)
                  {
                     _loc9_.axisx = Math.sin(_loc9_.rot);
                     _loc9_.axisy = Math.cos(_loc9_.rot);
                     null;
                  }
                  else
                  {
                     _loc23_ = _loc22_ * _loc22_;
                     _loc24_ = 1 - 0.5 * _loc23_;
                     _loc25_ = 1 - _loc23_ * _loc23_ / 8;
                     _loc26_ = (_loc24_ * _loc9_.axisx + _loc22_ * _loc9_.axisy) * _loc25_;
                     _loc9_.axisy = (_loc24_ * _loc9_.axisy - _loc22_ * _loc9_.axisx) * _loc25_;
                     _loc9_.axisx = _loc26_;
                  }
               }
            }
            if(_loc7_.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc7_.worldCOMx = _loc9_.posx + (_loc9_.axisy * _loc7_.localCOMx - _loc9_.axisx * _loc7_.localCOMy);
               _loc7_.worldCOMy = _loc9_.posy + (_loc7_.localCOMx * _loc9_.axisx + _loc7_.localCOMy * _loc9_.axisy);
            }
            else
            {
               _loc27_ = _loc7_.polygon;
               _loc28_ = _loc27_.lverts.next;
               _loc29_ = _loc27_.gverts.next;
               while(_loc29_ != null)
               {
                  _loc30_ = _loc29_;
                  _loc31_ = _loc28_;
                  _loc28_ = _loc28_.next;
                  _loc30_.x = _loc9_.posx + (_loc9_.axisy * _loc31_.x - _loc9_.axisx * _loc31_.y);
                  _loc30_.y = _loc9_.posy + (_loc31_.x * _loc9_.axisx + _loc31_.y * _loc9_.axisy);
                  _loc29_ = _loc29_.next;
               }
               _loc32_ = _loc27_.edges.head;
               _loc29_ = _loc27_.gverts.next;
               _loc30_ = _loc29_;
               _loc29_ = _loc29_.next;
               while(_loc29_ != null)
               {
                  _loc31_ = _loc29_;
                  _loc33_ = _loc32_.elt;
                  _loc32_ = _loc32_.next;
                  _loc33_.gnormx = _loc9_.axisy * _loc33_.lnormx - _loc9_.axisx * _loc33_.lnormy;
                  _loc33_.gnormy = _loc33_.lnormx * _loc9_.axisx + _loc33_.lnormy * _loc9_.axisy;
                  _loc33_.gprojection = _loc9_.posx * _loc33_.gnormx + _loc9_.posy * _loc33_.gnormy + _loc33_.lprojection;
                  _loc33_.tp0 = _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy;
                  _loc33_.tp1 = _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy;
                  _loc30_ = _loc31_;
                  _loc29_ = _loc29_.next;
               }
               _loc31_ = _loc27_.gverts.next;
               _loc33_ = _loc32_.elt;
               _loc32_ = _loc32_.next;
               _loc33_.gnormx = _loc9_.axisy * _loc33_.lnormx - _loc9_.axisx * _loc33_.lnormy;
               _loc33_.gnormy = _loc33_.lnormx * _loc9_.axisx + _loc33_.lnormy * _loc9_.axisy;
               _loc33_.gprojection = _loc9_.posx * _loc33_.gnormx + _loc9_.posy * _loc33_.gnormy + _loc33_.lprojection;
               _loc33_.tp0 = _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy;
               _loc33_.tp1 = _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy;
            }
            _loc34_ = _loc6_;
            _loc35_ = _loc7_;
            _loc28_ = _loc15_;
            _loc29_ = _loc16_;
            _loc21_ = 1e+100;
            if(_loc34_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc35_.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc36_ = _loc34_.circle;
               _loc37_ = _loc35_.circle;
               _loc23_ = 0;
               _loc24_ = 0;
               _loc23_ = _loc37_.worldCOMx - _loc36_.worldCOMx;
               _loc24_ = _loc37_.worldCOMy - _loc36_.worldCOMy;
               _loc26_ = _loc23_ * _loc23_ + _loc24_ * _loc24_;
               _loc25_ = _loc26_ == 0 ? 0 : (sf32(_loc26_,0), si32(1597463007 - (li32(0) >> 1),0), _loc38_ = lf32(0), 1 / (_loc38_ * (1.5 - 0.5 * _loc26_ * _loc38_ * _loc38_)));
               _loc22_ = _loc25_ - (_loc36_.radius + _loc37_.radius);
               if(_loc22_ < _loc21_)
               {
                  if(_loc25_ == 0)
                  {
                     _loc23_ = 1;
                     _loc24_ = 0;
                  }
                  else
                  {
                     _loc26_ = 1 / _loc25_;
                     _loc23_ *= _loc26_;
                     _loc24_ *= _loc26_;
                  }
                  _loc26_ = _loc36_.radius;
                  _loc28_.x = _loc36_.worldCOMx + _loc23_ * _loc26_;
                  _loc28_.y = _loc36_.worldCOMy + _loc24_ * _loc26_;
                  _loc26_ = -_loc37_.radius;
                  _loc29_.x = _loc37_.worldCOMx + _loc23_ * _loc26_;
                  _loc29_.y = _loc37_.worldCOMy + _loc24_ * _loc26_;
                  _loc17_.x = _loc23_;
                  _loc17_.y = _loc24_;
               }
               §§push(_loc22_);
            }
            else
            {
               _loc39_ = false;
               if(_loc34_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc35_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc40_ = _loc34_;
                  _loc34_ = _loc35_;
                  _loc35_ = _loc40_;
                  _loc30_ = _loc28_;
                  _loc28_ = _loc29_;
                  _loc29_ = _loc30_;
                  _loc39_ = true;
               }
               if(_loc34_.type == ZPP_Flags.id_ShapeType_POLYGON && _loc35_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc27_ = _loc34_.polygon;
                  _loc36_ = _loc35_.circle;
                  _loc22_ = -1e+100;
                  _loc33_ = null;
                  _loc32_ = _loc27_.edges.head;
                  while(_loc32_ != null)
                  {
                     _loc41_ = _loc32_.elt;
                     _loc23_ = _loc41_.gnormx * _loc36_.worldCOMx + _loc41_.gnormy * _loc36_.worldCOMy - _loc41_.gprojection - _loc36_.radius;
                     if(_loc23_ > _loc21_)
                     {
                        _loc22_ = _loc23_;
                        break;
                     }
                     if(_loc23_ > 0)
                     {
                        if(_loc23_ > _loc22_)
                        {
                           _loc22_ = _loc23_;
                           _loc33_ = _loc41_;
                        }
                     }
                     else if(_loc22_ < 0 && _loc23_ > _loc22_)
                     {
                        _loc22_ = _loc23_;
                        _loc33_ = _loc41_;
                     }
                     _loc32_ = _loc32_.next;
                  }
                  if(_loc22_ < _loc21_)
                  {
                     _loc30_ = _loc33_.gp0;
                     _loc31_ = _loc33_.gp1;
                     _loc23_ = _loc36_.worldCOMy * _loc33_.gnormx - _loc36_.worldCOMx * _loc33_.gnormy;
                     if(_loc23_ <= _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy)
                     {
                        _loc24_ = 0;
                        _loc25_ = 0;
                        _loc24_ = _loc36_.worldCOMx - _loc30_.x;
                        _loc25_ = _loc36_.worldCOMy - _loc30_.y;
                        _loc38_ = _loc24_ * _loc24_ + _loc25_ * _loc25_;
                        _loc26_ = _loc38_ == 0 ? 0 : (sf32(_loc38_,0), si32(1597463007 - (li32(0) >> 1),0), _loc42_ = lf32(0), 1 / (_loc42_ * (1.5 - 0.5 * _loc38_ * _loc42_ * _loc42_)));
                        _loc22_ = _loc26_ - _loc36_.radius;
                        if(_loc22_ < _loc21_)
                        {
                           if(_loc26_ == 0)
                           {
                              _loc24_ = 1;
                              _loc25_ = 0;
                           }
                           else
                           {
                              _loc38_ = 1 / _loc26_;
                              _loc24_ *= _loc38_;
                              _loc25_ *= _loc38_;
                           }
                           _loc43_ = 0;
                           _loc28_.x = _loc30_.x + _loc24_ * _loc43_;
                           _loc28_.y = _loc30_.y + _loc25_ * _loc43_;
                           _loc38_ = -_loc36_.radius;
                           _loc29_.x = _loc36_.worldCOMx + _loc24_ * _loc38_;
                           _loc29_.y = _loc36_.worldCOMy + _loc25_ * _loc38_;
                           _loc17_.x = _loc24_;
                           _loc17_.y = _loc25_;
                        }
                     }
                     else if(_loc23_ >= _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy)
                     {
                        _loc24_ = 0;
                        _loc25_ = 0;
                        _loc24_ = _loc36_.worldCOMx - _loc31_.x;
                        _loc25_ = _loc36_.worldCOMy - _loc31_.y;
                        _loc38_ = _loc24_ * _loc24_ + _loc25_ * _loc25_;
                        _loc26_ = _loc38_ == 0 ? 0 : (sf32(_loc38_,0), si32(1597463007 - (li32(0) >> 1),0), _loc42_ = lf32(0), 1 / (_loc42_ * (1.5 - 0.5 * _loc38_ * _loc42_ * _loc42_)));
                        _loc22_ = _loc26_ - _loc36_.radius;
                        if(_loc22_ < _loc21_)
                        {
                           if(_loc26_ == 0)
                           {
                              _loc24_ = 1;
                              _loc25_ = 0;
                           }
                           else
                           {
                              _loc38_ = 1 / _loc26_;
                              _loc24_ *= _loc38_;
                              _loc25_ *= _loc38_;
                           }
                           _loc43_ = 0;
                           _loc28_.x = _loc31_.x + _loc24_ * _loc43_;
                           _loc28_.y = _loc31_.y + _loc25_ * _loc43_;
                           _loc38_ = -_loc36_.radius;
                           _loc29_.x = _loc36_.worldCOMx + _loc24_ * _loc38_;
                           _loc29_.y = _loc36_.worldCOMy + _loc25_ * _loc38_;
                           _loc17_.x = _loc24_;
                           _loc17_.y = _loc25_;
                        }
                     }
                     else
                     {
                        _loc24_ = -_loc36_.radius;
                        _loc29_.x = _loc36_.worldCOMx + _loc33_.gnormx * _loc24_;
                        _loc29_.y = _loc36_.worldCOMy + _loc33_.gnormy * _loc24_;
                        _loc24_ = -_loc22_;
                        _loc28_.x = _loc29_.x + _loc33_.gnormx * _loc24_;
                        _loc28_.y = _loc29_.y + _loc33_.gnormy * _loc24_;
                        _loc17_.x = _loc33_.gnormx;
                        _loc17_.y = _loc33_.gnormy;
                     }
                  }
                  if(_loc39_)
                  {
                     _loc17_.x = -_loc17_.x;
                     _loc17_.y = -_loc17_.y;
                  }
                  §§push(_loc22_);
               }
               else
               {
                  _loc27_ = _loc34_.polygon;
                  _loc44_ = _loc35_.polygon;
                  _loc22_ = -1e+100;
                  _loc33_ = null;
                  _loc41_ = null;
                  _loc43_ = 0;
                  _loc32_ = _loc27_.edges.head;
                  while(_loc32_ != null)
                  {
                     _loc45_ = _loc32_.elt;
                     _loc23_ = 1e+100;
                     _loc30_ = _loc44_.gverts.next;
                     while(_loc30_ != null)
                     {
                        _loc31_ = _loc30_;
                        _loc24_ = _loc45_.gnormx * _loc31_.x + _loc45_.gnormy * _loc31_.y;
                        if(_loc24_ < _loc23_)
                        {
                           _loc23_ = _loc24_;
                        }
                        _loc30_ = _loc30_.next;
                     }
                     _loc23_ -= _loc45_.gprojection;
                     if(_loc23_ > _loc21_)
                     {
                        _loc22_ = _loc23_;
                        break;
                     }
                     if(_loc23_ > 0)
                     {
                        if(_loc23_ > _loc22_)
                        {
                           _loc22_ = _loc23_;
                           _loc33_ = _loc45_;
                           _loc43_ = 1;
                        }
                     }
                     else if(_loc22_ < 0 && _loc23_ > _loc22_)
                     {
                        _loc22_ = _loc23_;
                        _loc33_ = _loc45_;
                        _loc43_ = 1;
                     }
                     _loc32_ = _loc32_.next;
                  }
                  if(_loc22_ < _loc21_)
                  {
                     _loc32_ = _loc44_.edges.head;
                     while(_loc32_ != null)
                     {
                        _loc45_ = _loc32_.elt;
                        _loc23_ = 1e+100;
                        _loc30_ = _loc27_.gverts.next;
                        while(_loc30_ != null)
                        {
                           _loc31_ = _loc30_;
                           _loc24_ = _loc45_.gnormx * _loc31_.x + _loc45_.gnormy * _loc31_.y;
                           if(_loc24_ < _loc23_)
                           {
                              _loc23_ = _loc24_;
                           }
                           _loc30_ = _loc30_.next;
                        }
                        _loc23_ -= _loc45_.gprojection;
                        if(_loc23_ > _loc21_)
                        {
                           _loc22_ = _loc23_;
                           break;
                        }
                        if(_loc23_ > 0)
                        {
                           if(_loc23_ > _loc22_)
                           {
                              _loc22_ = _loc23_;
                              _loc41_ = _loc45_;
                              _loc43_ = 2;
                           }
                        }
                        else if(_loc22_ < 0 && _loc23_ > _loc22_)
                        {
                           _loc22_ = _loc23_;
                           _loc41_ = _loc45_;
                           _loc43_ = 2;
                        }
                        _loc32_ = _loc32_.next;
                     }
                     if(_loc22_ < _loc21_)
                     {
                        if(_loc43_ == 1)
                        {
                           _loc46_ = _loc27_;
                           _loc47_ = _loc44_;
                           _loc45_ = _loc33_;
                        }
                        else
                        {
                           _loc46_ = _loc44_;
                           _loc47_ = _loc27_;
                           _loc45_ = _loc41_;
                           _loc30_ = _loc28_;
                           _loc28_ = _loc29_;
                           _loc29_ = _loc30_;
                           _loc39_ = !_loc39_;
                        }
                        _loc48_ = null;
                        _loc23_ = 1e+100;
                        _loc32_ = _loc47_.edges.head;
                        while(_loc32_ != null)
                        {
                           _loc49_ = _loc32_.elt;
                           _loc24_ = _loc45_.gnormx * _loc49_.gnormx + _loc45_.gnormy * _loc49_.gnormy;
                           if(_loc24_ < _loc23_)
                           {
                              _loc23_ = _loc24_;
                              _loc48_ = _loc49_;
                           }
                           _loc32_ = _loc32_.next;
                        }
                        if(_loc39_)
                        {
                           _loc17_.x = -_loc45_.gnormx;
                           _loc17_.y = -_loc45_.gnormy;
                        }
                        else
                        {
                           _loc17_.x = _loc45_.gnormx;
                           _loc17_.y = _loc45_.gnormy;
                        }
                        if(_loc22_ >= 0)
                        {
                           _loc30_ = _loc45_.gp0;
                           _loc31_ = _loc45_.gp1;
                           _loc50_ = _loc48_.gp0;
                           _loc51_ = _loc48_.gp1;
                           _loc24_ = 0;
                           _loc25_ = 0;
                           _loc26_ = 0;
                           _loc38_ = 0;
                           _loc24_ = _loc31_.x - _loc30_.x;
                           _loc25_ = _loc31_.y - _loc30_.y;
                           _loc26_ = _loc51_.x - _loc50_.x;
                           _loc38_ = _loc51_.y - _loc50_.y;
                           _loc42_ = 1 / (_loc24_ * _loc24_ + _loc25_ * _loc25_);
                           _loc52_ = 1 / (_loc26_ * _loc26_ + _loc38_ * _loc38_);
                           _loc53_ = -(_loc24_ * (_loc30_.x - _loc50_.x) + _loc25_ * (_loc30_.y - _loc50_.y)) * _loc42_;
                           _loc54_ = -(_loc24_ * (_loc30_.x - _loc51_.x) + _loc25_ * (_loc30_.y - _loc51_.y)) * _loc42_;
                           _loc55_ = -(_loc26_ * (_loc50_.x - _loc30_.x) + _loc38_ * (_loc50_.y - _loc30_.y)) * _loc52_;
                           _loc56_ = -(_loc26_ * (_loc50_.x - _loc31_.x) + _loc38_ * (_loc50_.y - _loc31_.y)) * _loc52_;
                           if(_loc53_ < 0)
                           {
                              _loc53_ = 0;
                           }
                           else if(_loc53_ > 1)
                           {
                              _loc53_ = 1;
                           }
                           if(_loc54_ < 0)
                           {
                              _loc54_ = 0;
                           }
                           else if(_loc54_ > 1)
                           {
                              _loc54_ = 1;
                           }
                           if(_loc55_ < 0)
                           {
                              _loc55_ = 0;
                           }
                           else if(_loc55_ > 1)
                           {
                              _loc55_ = 1;
                           }
                           if(_loc56_ < 0)
                           {
                              _loc56_ = 0;
                           }
                           else if(_loc56_ > 1)
                           {
                              _loc56_ = 1;
                           }
                           _loc57_ = 0;
                           _loc58_ = 0;
                           _loc59_ = _loc53_;
                           _loc57_ = _loc30_.x + _loc24_ * _loc59_;
                           _loc58_ = _loc30_.y + _loc25_ * _loc59_;
                           _loc59_ = 0;
                           _loc60_ = 0;
                           _loc61_ = _loc54_;
                           _loc59_ = _loc30_.x + _loc24_ * _loc61_;
                           _loc60_ = _loc30_.y + _loc25_ * _loc61_;
                           _loc61_ = 0;
                           _loc62_ = 0;
                           _loc63_ = _loc55_;
                           _loc61_ = _loc50_.x + _loc26_ * _loc63_;
                           _loc62_ = _loc50_.y + _loc38_ * _loc63_;
                           _loc63_ = 0;
                           _loc64_ = 0;
                           _loc65_ = _loc56_;
                           _loc63_ = _loc50_.x + _loc26_ * _loc65_;
                           _loc64_ = _loc50_.y + _loc38_ * _loc65_;
                           _loc66_ = 0;
                           _loc67_ = 0;
                           _loc66_ = _loc57_ - _loc50_.x;
                           _loc67_ = _loc58_ - _loc50_.y;
                           _loc65_ = _loc66_ * _loc66_ + _loc67_ * _loc67_;
                           _loc67_ = 0;
                           _loc68_ = 0;
                           _loc67_ = _loc59_ - _loc51_.x;
                           _loc68_ = _loc60_ - _loc51_.y;
                           _loc66_ = _loc67_ * _loc67_ + _loc68_ * _loc68_;
                           _loc68_ = 0;
                           _loc69_ = 0;
                           _loc68_ = _loc61_ - _loc30_.x;
                           _loc69_ = _loc62_ - _loc30_.y;
                           _loc67_ = _loc68_ * _loc68_ + _loc69_ * _loc69_;
                           _loc69_ = 0;
                           _loc70_ = 0;
                           _loc69_ = _loc63_ - _loc31_.x;
                           _loc70_ = _loc64_ - _loc31_.y;
                           _loc68_ = _loc69_ * _loc69_ + _loc70_ * _loc70_;
                           _loc69_ = 0;
                           _loc70_ = 0;
                           _loc71_ = null;
                           if(_loc65_ < _loc66_)
                           {
                              _loc69_ = _loc57_;
                              _loc70_ = _loc58_;
                              _loc71_ = _loc50_;
                           }
                           else
                           {
                              _loc69_ = _loc59_;
                              _loc70_ = _loc60_;
                              _loc71_ = _loc51_;
                              _loc65_ = _loc66_;
                           }
                           _loc72_ = 0;
                           _loc73_ = 0;
                           _loc74_ = null;
                           if(_loc67_ < _loc68_)
                           {
                              _loc72_ = _loc61_;
                              _loc73_ = _loc62_;
                              _loc74_ = _loc30_;
                           }
                           else
                           {
                              _loc72_ = _loc63_;
                              _loc73_ = _loc64_;
                              _loc74_ = _loc31_;
                              _loc67_ = _loc68_;
                           }
                           if(_loc65_ < _loc67_)
                           {
                              _loc28_.x = _loc69_;
                              _loc28_.y = _loc70_;
                              _loc29_.x = _loc71_.x;
                              _loc29_.y = _loc71_.y;
                              _loc22_ = Math.sqrt(_loc65_);
                           }
                           else
                           {
                              _loc29_.x = _loc72_;
                              _loc29_.y = _loc73_;
                              _loc28_.x = _loc74_.x;
                              _loc28_.y = _loc74_.y;
                              _loc22_ = Math.sqrt(_loc67_);
                           }
                           if(_loc22_ != 0)
                           {
                              _loc17_.x = _loc29_.x - _loc28_.x;
                              _loc17_.y = _loc29_.y - _loc28_.y;
                              _loc75_ = 1 / _loc22_;
                              _loc17_.x *= _loc75_;
                              _loc17_.y *= _loc75_;
                              if(_loc39_)
                              {
                                 _loc17_.x = -_loc17_.x;
                                 _loc17_.y = -_loc17_.y;
                              }
                           }
                           §§push(_loc22_);
                        }
                        else
                        {
                           _loc24_ = 0;
                           _loc25_ = 0;
                           _loc24_ = _loc48_.gp0.x;
                           _loc25_ = _loc48_.gp0.y;
                           _loc26_ = 0;
                           _loc38_ = 0;
                           _loc26_ = _loc48_.gp1.x;
                           _loc38_ = _loc48_.gp1.y;
                           _loc42_ = 0;
                           _loc52_ = 0;
                           _loc42_ = _loc26_ - _loc24_;
                           _loc52_ = _loc38_ - _loc25_;
                           _loc53_ = _loc45_.gnormy * _loc24_ - _loc45_.gnormx * _loc25_;
                           _loc54_ = _loc45_.gnormy * _loc26_ - _loc45_.gnormx * _loc38_;
                           _loc55_ = 1 / (_loc54_ - _loc53_);
                           _loc56_ = (-_loc45_.tp1 - _loc53_) * _loc55_;
                           if(_loc56_ > Config.epsilon)
                           {
                              _loc57_ = _loc56_;
                              _loc24_ += _loc42_ * _loc57_;
                              _loc25_ += _loc52_ * _loc57_;
                           }
                           _loc57_ = (-_loc45_.tp0 - _loc54_) * _loc55_;
                           if(_loc57_ < -Config.epsilon)
                           {
                              _loc58_ = _loc57_;
                              _loc26_ += _loc42_ * _loc58_;
                              _loc38_ += _loc52_ * _loc58_;
                           }
                           _loc58_ = _loc24_ * _loc45_.gnormx + _loc25_ * _loc45_.gnormy - _loc45_.gprojection;
                           _loc59_ = _loc26_ * _loc45_.gnormx + _loc38_ * _loc45_.gnormy - _loc45_.gprojection;
                           §§push(_loc58_ < _loc59_ ? (_loc29_.x = _loc24_, _loc29_.y = _loc25_, _loc60_ = -_loc58_, _loc28_.x = _loc29_.x + _loc45_.gnormx * _loc60_, _loc28_.y = _loc29_.y + _loc45_.gnormy * _loc60_, _loc58_) : (_loc29_.x = _loc26_, _loc29_.y = _loc38_, _loc60_ = -_loc59_, _loc28_.x = _loc29_.x + _loc45_.gnormx * _loc60_, _loc28_.y = _loc29_.y + _loc45_.gnormy * _loc60_, _loc59_));
                        }
                     }
                     else
                     {
                        §§push(_loc21_);
                     }
                  }
                  else
                  {
                     §§push(_loc21_);
                  }
               }
            }
            _loc20_ = §§pop() + param4;
            _loc21_ = _loc10_ * _loc17_.x + _loc11_ * _loc17_.y;
            if(_loc20_ < Config.distanceThresholdCCD)
            {
               if(param5)
               {
                  break;
               }
               _loc22_ = 0;
               _loc23_ = 0;
               _loc22_ = _loc15_.x - _loc8_.posx;
               _loc23_ = _loc15_.y - _loc8_.posy;
               _loc24_ = 0;
               _loc25_ = 0;
               _loc24_ = _loc16_.x - _loc9_.posx;
               _loc25_ = _loc16_.y - _loc9_.posy;
               _loc26_ = _loc21_ - _loc8_.sweep_angvel * (_loc17_.y * _loc22_ - _loc17_.x * _loc23_) + _loc9_.sweep_angvel * (_loc17_.y * _loc24_ - _loc17_.x * _loc25_);
               if(_loc26_ > 0)
               {
                  param1.slipped = true;
               }
               if(_loc26_ <= 0 || _loc20_ < Config.distanceThresholdCCD * 0.5)
               {
                  break;
               }
            }
            _loc22_ = (_loc14_ - _loc21_) * param2;
            if(_loc22_ <= 0)
            {
               _loc18_ = -1;
               break;
            }
            _loc23_ = _loc20_ / _loc22_;
            if(_loc23_ < 0.000001)
            {
               _loc23_ = 0.000001;
            }
            _loc18_ += _loc23_;
            if(_loc18_ >= 1)
            {
               _loc18_ = 1;
               _loc24_ = _loc18_ * param2;
               _loc25_ = _loc24_ - _loc8_.sweepTime;
               if(_loc25_ != 0)
               {
                  _loc8_.sweepTime = _loc24_;
                  _loc26_ = _loc25_;
                  _loc8_.posx += _loc8_.velx * _loc26_;
                  _loc8_.posy += _loc8_.vely * _loc26_;
                  if(_loc8_.angvel != 0)
                  {
                     _loc26_ = _loc8_.sweep_angvel * _loc25_;
                     _loc8_.rot += _loc26_;
                     if(_loc26_ * _loc26_ > 0.0001)
                     {
                        _loc8_.axisx = Math.sin(_loc8_.rot);
                        _loc8_.axisy = Math.cos(_loc8_.rot);
                        null;
                     }
                     else
                     {
                        _loc38_ = _loc26_ * _loc26_;
                        _loc42_ = 1 - 0.5 * _loc38_;
                        _loc52_ = 1 - _loc38_ * _loc38_ / 8;
                        _loc53_ = (_loc42_ * _loc8_.axisx + _loc26_ * _loc8_.axisy) * _loc52_;
                        _loc8_.axisy = (_loc42_ * _loc8_.axisy - _loc26_ * _loc8_.axisx) * _loc52_;
                        _loc8_.axisx = _loc53_;
                     }
                  }
               }
               if(_loc6_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc6_.worldCOMx = _loc8_.posx + (_loc8_.axisy * _loc6_.localCOMx - _loc8_.axisx * _loc6_.localCOMy);
                  _loc6_.worldCOMy = _loc8_.posy + (_loc6_.localCOMx * _loc8_.axisx + _loc6_.localCOMy * _loc8_.axisy);
               }
               else
               {
                  _loc27_ = _loc6_.polygon;
                  _loc28_ = _loc27_.lverts.next;
                  _loc29_ = _loc27_.gverts.next;
                  while(_loc29_ != null)
                  {
                     _loc30_ = _loc29_;
                     _loc31_ = _loc28_;
                     _loc28_ = _loc28_.next;
                     _loc30_.x = _loc8_.posx + (_loc8_.axisy * _loc31_.x - _loc8_.axisx * _loc31_.y);
                     _loc30_.y = _loc8_.posy + (_loc31_.x * _loc8_.axisx + _loc31_.y * _loc8_.axisy);
                     _loc29_ = _loc29_.next;
                  }
                  _loc32_ = _loc27_.edges.head;
                  _loc29_ = _loc27_.gverts.next;
                  _loc30_ = _loc29_;
                  _loc29_ = _loc29_.next;
                  while(_loc29_ != null)
                  {
                     _loc31_ = _loc29_;
                     _loc33_ = _loc32_.elt;
                     _loc32_ = _loc32_.next;
                     _loc33_.gnormx = _loc8_.axisy * _loc33_.lnormx - _loc8_.axisx * _loc33_.lnormy;
                     _loc33_.gnormy = _loc33_.lnormx * _loc8_.axisx + _loc33_.lnormy * _loc8_.axisy;
                     _loc33_.gprojection = _loc8_.posx * _loc33_.gnormx + _loc8_.posy * _loc33_.gnormy + _loc33_.lprojection;
                     _loc33_.tp0 = _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy;
                     _loc33_.tp1 = _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy;
                     _loc30_ = _loc31_;
                     _loc29_ = _loc29_.next;
                  }
                  _loc31_ = _loc27_.gverts.next;
                  _loc33_ = _loc32_.elt;
                  _loc32_ = _loc32_.next;
                  _loc33_.gnormx = _loc8_.axisy * _loc33_.lnormx - _loc8_.axisx * _loc33_.lnormy;
                  _loc33_.gnormy = _loc33_.lnormx * _loc8_.axisx + _loc33_.lnormy * _loc8_.axisy;
                  _loc33_.gprojection = _loc8_.posx * _loc33_.gnormx + _loc8_.posy * _loc33_.gnormy + _loc33_.lprojection;
                  _loc33_.tp0 = _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy;
                  _loc33_.tp1 = _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy;
               }
               _loc24_ = _loc18_ * param2;
               _loc25_ = _loc24_ - _loc9_.sweepTime;
               if(_loc25_ != 0)
               {
                  _loc9_.sweepTime = _loc24_;
                  _loc26_ = _loc25_;
                  _loc9_.posx += _loc9_.velx * _loc26_;
                  _loc9_.posy += _loc9_.vely * _loc26_;
                  if(_loc9_.angvel != 0)
                  {
                     _loc26_ = _loc9_.sweep_angvel * _loc25_;
                     _loc9_.rot += _loc26_;
                     if(_loc26_ * _loc26_ > 0.0001)
                     {
                        _loc9_.axisx = Math.sin(_loc9_.rot);
                        _loc9_.axisy = Math.cos(_loc9_.rot);
                        null;
                     }
                     else
                     {
                        _loc38_ = _loc26_ * _loc26_;
                        _loc42_ = 1 - 0.5 * _loc38_;
                        _loc52_ = 1 - _loc38_ * _loc38_ / 8;
                        _loc53_ = (_loc42_ * _loc9_.axisx + _loc26_ * _loc9_.axisy) * _loc52_;
                        _loc9_.axisy = (_loc42_ * _loc9_.axisy - _loc26_ * _loc9_.axisx) * _loc52_;
                        _loc9_.axisx = _loc53_;
                     }
                  }
               }
               if(_loc7_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc7_.worldCOMx = _loc9_.posx + (_loc9_.axisy * _loc7_.localCOMx - _loc9_.axisx * _loc7_.localCOMy);
                  _loc7_.worldCOMy = _loc9_.posy + (_loc7_.localCOMx * _loc9_.axisx + _loc7_.localCOMy * _loc9_.axisy);
               }
               else
               {
                  _loc27_ = _loc7_.polygon;
                  _loc28_ = _loc27_.lverts.next;
                  _loc29_ = _loc27_.gverts.next;
                  while(_loc29_ != null)
                  {
                     _loc30_ = _loc29_;
                     _loc31_ = _loc28_;
                     _loc28_ = _loc28_.next;
                     _loc30_.x = _loc9_.posx + (_loc9_.axisy * _loc31_.x - _loc9_.axisx * _loc31_.y);
                     _loc30_.y = _loc9_.posy + (_loc31_.x * _loc9_.axisx + _loc31_.y * _loc9_.axisy);
                     _loc29_ = _loc29_.next;
                  }
                  _loc32_ = _loc27_.edges.head;
                  _loc29_ = _loc27_.gverts.next;
                  _loc30_ = _loc29_;
                  _loc29_ = _loc29_.next;
                  while(_loc29_ != null)
                  {
                     _loc31_ = _loc29_;
                     _loc33_ = _loc32_.elt;
                     _loc32_ = _loc32_.next;
                     _loc33_.gnormx = _loc9_.axisy * _loc33_.lnormx - _loc9_.axisx * _loc33_.lnormy;
                     _loc33_.gnormy = _loc33_.lnormx * _loc9_.axisx + _loc33_.lnormy * _loc9_.axisy;
                     _loc33_.gprojection = _loc9_.posx * _loc33_.gnormx + _loc9_.posy * _loc33_.gnormy + _loc33_.lprojection;
                     _loc33_.tp0 = _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy;
                     _loc33_.tp1 = _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy;
                     _loc30_ = _loc31_;
                     _loc29_ = _loc29_.next;
                  }
                  _loc31_ = _loc27_.gverts.next;
                  _loc33_ = _loc32_.elt;
                  _loc32_ = _loc32_.next;
                  _loc33_.gnormx = _loc9_.axisy * _loc33_.lnormx - _loc9_.axisx * _loc33_.lnormy;
                  _loc33_.gnormy = _loc33_.lnormx * _loc9_.axisx + _loc33_.lnormy * _loc9_.axisy;
                  _loc33_.gprojection = _loc9_.posx * _loc33_.gnormx + _loc9_.posy * _loc33_.gnormy + _loc33_.lprojection;
                  _loc33_.tp0 = _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy;
                  _loc33_.tp1 = _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy;
               }
               _loc34_ = _loc6_;
               _loc35_ = _loc7_;
               _loc28_ = _loc15_;
               _loc29_ = _loc16_;
               _loc25_ = 1e+100;
               if(_loc34_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc35_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc36_ = _loc34_.circle;
                  _loc37_ = _loc35_.circle;
                  _loc38_ = 0;
                  _loc42_ = 0;
                  _loc38_ = _loc37_.worldCOMx - _loc36_.worldCOMx;
                  _loc42_ = _loc37_.worldCOMy - _loc36_.worldCOMy;
                  _loc53_ = _loc38_ * _loc38_ + _loc42_ * _loc42_;
                  _loc52_ = _loc53_ == 0 ? 0 : (sf32(_loc53_,0), si32(1597463007 - (li32(0) >> 1),0), _loc54_ = lf32(0), 1 / (_loc54_ * (1.5 - 0.5 * _loc53_ * _loc54_ * _loc54_)));
                  _loc26_ = _loc52_ - (_loc36_.radius + _loc37_.radius);
                  if(_loc26_ < _loc25_)
                  {
                     if(_loc52_ == 0)
                     {
                        _loc38_ = 1;
                        _loc42_ = 0;
                     }
                     else
                     {
                        _loc53_ = 1 / _loc52_;
                        _loc38_ *= _loc53_;
                        _loc42_ *= _loc53_;
                     }
                     _loc53_ = _loc36_.radius;
                     _loc28_.x = _loc36_.worldCOMx + _loc38_ * _loc53_;
                     _loc28_.y = _loc36_.worldCOMy + _loc42_ * _loc53_;
                     _loc53_ = -_loc37_.radius;
                     _loc29_.x = _loc37_.worldCOMx + _loc38_ * _loc53_;
                     _loc29_.y = _loc37_.worldCOMy + _loc42_ * _loc53_;
                     _loc17_.x = _loc38_;
                     _loc17_.y = _loc42_;
                  }
                  §§push(_loc26_);
               }
               else
               {
                  _loc39_ = false;
                  if(_loc34_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc35_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc40_ = _loc34_;
                     _loc34_ = _loc35_;
                     _loc35_ = _loc40_;
                     _loc30_ = _loc28_;
                     _loc28_ = _loc29_;
                     _loc29_ = _loc30_;
                     _loc39_ = true;
                  }
                  if(_loc34_.type == ZPP_Flags.id_ShapeType_POLYGON && _loc35_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc27_ = _loc34_.polygon;
                     _loc36_ = _loc35_.circle;
                     _loc26_ = -1e+100;
                     _loc33_ = null;
                     _loc32_ = _loc27_.edges.head;
                     while(_loc32_ != null)
                     {
                        _loc41_ = _loc32_.elt;
                        _loc38_ = _loc41_.gnormx * _loc36_.worldCOMx + _loc41_.gnormy * _loc36_.worldCOMy - _loc41_.gprojection - _loc36_.radius;
                        if(_loc38_ > _loc25_)
                        {
                           _loc26_ = _loc38_;
                           break;
                        }
                        if(_loc38_ > 0)
                        {
                           if(_loc38_ > _loc26_)
                           {
                              _loc26_ = _loc38_;
                              _loc33_ = _loc41_;
                           }
                        }
                        else if(_loc26_ < 0 && _loc38_ > _loc26_)
                        {
                           _loc26_ = _loc38_;
                           _loc33_ = _loc41_;
                        }
                        _loc32_ = _loc32_.next;
                     }
                     if(_loc26_ < _loc25_)
                     {
                        _loc30_ = _loc33_.gp0;
                        _loc31_ = _loc33_.gp1;
                        _loc38_ = _loc36_.worldCOMy * _loc33_.gnormx - _loc36_.worldCOMx * _loc33_.gnormy;
                        if(_loc38_ <= _loc30_.y * _loc33_.gnormx - _loc30_.x * _loc33_.gnormy)
                        {
                           _loc42_ = 0;
                           _loc52_ = 0;
                           _loc42_ = _loc36_.worldCOMx - _loc30_.x;
                           _loc52_ = _loc36_.worldCOMy - _loc30_.y;
                           _loc54_ = _loc42_ * _loc42_ + _loc52_ * _loc52_;
                           _loc53_ = _loc54_ == 0 ? 0 : (sf32(_loc54_,0), si32(1597463007 - (li32(0) >> 1),0), _loc55_ = lf32(0), 1 / (_loc55_ * (1.5 - 0.5 * _loc54_ * _loc55_ * _loc55_)));
                           _loc26_ = _loc53_ - _loc36_.radius;
                           if(_loc26_ < _loc25_)
                           {
                              if(_loc53_ == 0)
                              {
                                 _loc42_ = 1;
                                 _loc52_ = 0;
                              }
                              else
                              {
                                 _loc54_ = 1 / _loc53_;
                                 _loc42_ *= _loc54_;
                                 _loc52_ *= _loc54_;
                              }
                              _loc43_ = 0;
                              _loc28_.x = _loc30_.x + _loc42_ * _loc43_;
                              _loc28_.y = _loc30_.y + _loc52_ * _loc43_;
                              _loc54_ = -_loc36_.radius;
                              _loc29_.x = _loc36_.worldCOMx + _loc42_ * _loc54_;
                              _loc29_.y = _loc36_.worldCOMy + _loc52_ * _loc54_;
                              _loc17_.x = _loc42_;
                              _loc17_.y = _loc52_;
                           }
                        }
                        else if(_loc38_ >= _loc31_.y * _loc33_.gnormx - _loc31_.x * _loc33_.gnormy)
                        {
                           _loc42_ = 0;
                           _loc52_ = 0;
                           _loc42_ = _loc36_.worldCOMx - _loc31_.x;
                           _loc52_ = _loc36_.worldCOMy - _loc31_.y;
                           _loc54_ = _loc42_ * _loc42_ + _loc52_ * _loc52_;
                           _loc53_ = _loc54_ == 0 ? 0 : (sf32(_loc54_,0), si32(1597463007 - (li32(0) >> 1),0), _loc55_ = lf32(0), 1 / (_loc55_ * (1.5 - 0.5 * _loc54_ * _loc55_ * _loc55_)));
                           _loc26_ = _loc53_ - _loc36_.radius;
                           if(_loc26_ < _loc25_)
                           {
                              if(_loc53_ == 0)
                              {
                                 _loc42_ = 1;
                                 _loc52_ = 0;
                              }
                              else
                              {
                                 _loc54_ = 1 / _loc53_;
                                 _loc42_ *= _loc54_;
                                 _loc52_ *= _loc54_;
                              }
                              _loc43_ = 0;
                              _loc28_.x = _loc31_.x + _loc42_ * _loc43_;
                              _loc28_.y = _loc31_.y + _loc52_ * _loc43_;
                              _loc54_ = -_loc36_.radius;
                              _loc29_.x = _loc36_.worldCOMx + _loc42_ * _loc54_;
                              _loc29_.y = _loc36_.worldCOMy + _loc52_ * _loc54_;
                              _loc17_.x = _loc42_;
                              _loc17_.y = _loc52_;
                           }
                        }
                        else
                        {
                           _loc42_ = -_loc36_.radius;
                           _loc29_.x = _loc36_.worldCOMx + _loc33_.gnormx * _loc42_;
                           _loc29_.y = _loc36_.worldCOMy + _loc33_.gnormy * _loc42_;
                           _loc42_ = -_loc26_;
                           _loc28_.x = _loc29_.x + _loc33_.gnormx * _loc42_;
                           _loc28_.y = _loc29_.y + _loc33_.gnormy * _loc42_;
                           _loc17_.x = _loc33_.gnormx;
                           _loc17_.y = _loc33_.gnormy;
                        }
                     }
                     if(_loc39_)
                     {
                        _loc17_.x = -_loc17_.x;
                        _loc17_.y = -_loc17_.y;
                     }
                     §§push(_loc26_);
                  }
                  else
                  {
                     _loc27_ = _loc34_.polygon;
                     _loc44_ = _loc35_.polygon;
                     _loc26_ = -1e+100;
                     _loc33_ = null;
                     _loc41_ = null;
                     _loc43_ = 0;
                     _loc32_ = _loc27_.edges.head;
                     while(_loc32_ != null)
                     {
                        _loc45_ = _loc32_.elt;
                        _loc38_ = 1e+100;
                        _loc30_ = _loc44_.gverts.next;
                        while(_loc30_ != null)
                        {
                           _loc31_ = _loc30_;
                           _loc42_ = _loc45_.gnormx * _loc31_.x + _loc45_.gnormy * _loc31_.y;
                           if(_loc42_ < _loc38_)
                           {
                              _loc38_ = _loc42_;
                           }
                           _loc30_ = _loc30_.next;
                        }
                        _loc38_ -= _loc45_.gprojection;
                        if(_loc38_ > _loc25_)
                        {
                           _loc26_ = _loc38_;
                           break;
                        }
                        if(_loc38_ > 0)
                        {
                           if(_loc38_ > _loc26_)
                           {
                              _loc26_ = _loc38_;
                              _loc33_ = _loc45_;
                              _loc43_ = 1;
                           }
                        }
                        else if(_loc26_ < 0 && _loc38_ > _loc26_)
                        {
                           _loc26_ = _loc38_;
                           _loc33_ = _loc45_;
                           _loc43_ = 1;
                        }
                        _loc32_ = _loc32_.next;
                     }
                     if(_loc26_ < _loc25_)
                     {
                        _loc32_ = _loc44_.edges.head;
                        while(_loc32_ != null)
                        {
                           _loc45_ = _loc32_.elt;
                           _loc38_ = 1e+100;
                           _loc30_ = _loc27_.gverts.next;
                           while(_loc30_ != null)
                           {
                              _loc31_ = _loc30_;
                              _loc42_ = _loc45_.gnormx * _loc31_.x + _loc45_.gnormy * _loc31_.y;
                              if(_loc42_ < _loc38_)
                              {
                                 _loc38_ = _loc42_;
                              }
                              _loc30_ = _loc30_.next;
                           }
                           _loc38_ -= _loc45_.gprojection;
                           if(_loc38_ > _loc25_)
                           {
                              _loc26_ = _loc38_;
                              break;
                           }
                           if(_loc38_ > 0)
                           {
                              if(_loc38_ > _loc26_)
                              {
                                 _loc26_ = _loc38_;
                                 _loc41_ = _loc45_;
                                 _loc43_ = 2;
                              }
                           }
                           else if(_loc26_ < 0 && _loc38_ > _loc26_)
                           {
                              _loc26_ = _loc38_;
                              _loc41_ = _loc45_;
                              _loc43_ = 2;
                           }
                           _loc32_ = _loc32_.next;
                        }
                        if(_loc26_ < _loc25_)
                        {
                           if(_loc43_ == 1)
                           {
                              _loc46_ = _loc27_;
                              _loc47_ = _loc44_;
                              _loc45_ = _loc33_;
                           }
                           else
                           {
                              _loc46_ = _loc44_;
                              _loc47_ = _loc27_;
                              _loc45_ = _loc41_;
                              _loc30_ = _loc28_;
                              _loc28_ = _loc29_;
                              _loc29_ = _loc30_;
                              _loc39_ = !_loc39_;
                           }
                           _loc48_ = null;
                           _loc38_ = 1e+100;
                           _loc32_ = _loc47_.edges.head;
                           while(_loc32_ != null)
                           {
                              _loc49_ = _loc32_.elt;
                              _loc42_ = _loc45_.gnormx * _loc49_.gnormx + _loc45_.gnormy * _loc49_.gnormy;
                              if(_loc42_ < _loc38_)
                              {
                                 _loc38_ = _loc42_;
                                 _loc48_ = _loc49_;
                              }
                              _loc32_ = _loc32_.next;
                           }
                           if(_loc39_)
                           {
                              _loc17_.x = -_loc45_.gnormx;
                              _loc17_.y = -_loc45_.gnormy;
                           }
                           else
                           {
                              _loc17_.x = _loc45_.gnormx;
                              _loc17_.y = _loc45_.gnormy;
                           }
                           if(_loc26_ >= 0)
                           {
                              _loc30_ = _loc45_.gp0;
                              _loc31_ = _loc45_.gp1;
                              _loc50_ = _loc48_.gp0;
                              _loc51_ = _loc48_.gp1;
                              _loc42_ = 0;
                              _loc52_ = 0;
                              _loc53_ = 0;
                              _loc54_ = 0;
                              _loc42_ = _loc31_.x - _loc30_.x;
                              _loc52_ = _loc31_.y - _loc30_.y;
                              _loc53_ = _loc51_.x - _loc50_.x;
                              _loc54_ = _loc51_.y - _loc50_.y;
                              _loc55_ = 1 / (_loc42_ * _loc42_ + _loc52_ * _loc52_);
                              _loc56_ = 1 / (_loc53_ * _loc53_ + _loc54_ * _loc54_);
                              _loc57_ = -(_loc42_ * (_loc30_.x - _loc50_.x) + _loc52_ * (_loc30_.y - _loc50_.y)) * _loc55_;
                              _loc58_ = -(_loc42_ * (_loc30_.x - _loc51_.x) + _loc52_ * (_loc30_.y - _loc51_.y)) * _loc55_;
                              _loc59_ = -(_loc53_ * (_loc50_.x - _loc30_.x) + _loc54_ * (_loc50_.y - _loc30_.y)) * _loc56_;
                              _loc60_ = -(_loc53_ * (_loc50_.x - _loc31_.x) + _loc54_ * (_loc50_.y - _loc31_.y)) * _loc56_;
                              if(_loc57_ < 0)
                              {
                                 _loc57_ = 0;
                              }
                              else if(_loc57_ > 1)
                              {
                                 _loc57_ = 1;
                              }
                              if(_loc58_ < 0)
                              {
                                 _loc58_ = 0;
                              }
                              else if(_loc58_ > 1)
                              {
                                 _loc58_ = 1;
                              }
                              if(_loc59_ < 0)
                              {
                                 _loc59_ = 0;
                              }
                              else if(_loc59_ > 1)
                              {
                                 _loc59_ = 1;
                              }
                              if(_loc60_ < 0)
                              {
                                 _loc60_ = 0;
                              }
                              else if(_loc60_ > 1)
                              {
                                 _loc60_ = 1;
                              }
                              _loc61_ = 0;
                              _loc62_ = 0;
                              _loc63_ = _loc57_;
                              _loc61_ = _loc30_.x + _loc42_ * _loc63_;
                              _loc62_ = _loc30_.y + _loc52_ * _loc63_;
                              _loc63_ = 0;
                              _loc64_ = 0;
                              _loc65_ = _loc58_;
                              _loc63_ = _loc30_.x + _loc42_ * _loc65_;
                              _loc64_ = _loc30_.y + _loc52_ * _loc65_;
                              _loc65_ = 0;
                              _loc66_ = 0;
                              _loc67_ = _loc59_;
                              _loc65_ = _loc50_.x + _loc53_ * _loc67_;
                              _loc66_ = _loc50_.y + _loc54_ * _loc67_;
                              _loc67_ = 0;
                              _loc68_ = 0;
                              _loc69_ = _loc60_;
                              _loc67_ = _loc50_.x + _loc53_ * _loc69_;
                              _loc68_ = _loc50_.y + _loc54_ * _loc69_;
                              _loc70_ = 0;
                              _loc72_ = 0;
                              _loc70_ = _loc61_ - _loc50_.x;
                              _loc72_ = _loc62_ - _loc50_.y;
                              _loc69_ = _loc70_ * _loc70_ + _loc72_ * _loc72_;
                              _loc72_ = 0;
                              _loc73_ = 0;
                              _loc72_ = _loc63_ - _loc51_.x;
                              _loc73_ = _loc64_ - _loc51_.y;
                              _loc70_ = _loc72_ * _loc72_ + _loc73_ * _loc73_;
                              _loc73_ = 0;
                              _loc75_ = 0;
                              _loc73_ = _loc65_ - _loc30_.x;
                              _loc75_ = _loc66_ - _loc30_.y;
                              _loc72_ = _loc73_ * _loc73_ + _loc75_ * _loc75_;
                              _loc75_ = 0;
                              _loc76_ = 0;
                              _loc75_ = _loc67_ - _loc31_.x;
                              _loc76_ = _loc68_ - _loc31_.y;
                              _loc73_ = _loc75_ * _loc75_ + _loc76_ * _loc76_;
                              _loc75_ = 0;
                              _loc76_ = 0;
                              _loc71_ = null;
                              if(_loc69_ < _loc70_)
                              {
                                 _loc75_ = _loc61_;
                                 _loc76_ = _loc62_;
                                 _loc71_ = _loc50_;
                              }
                              else
                              {
                                 _loc75_ = _loc63_;
                                 _loc76_ = _loc64_;
                                 _loc71_ = _loc51_;
                                 _loc69_ = _loc70_;
                              }
                              _loc77_ = 0;
                              _loc78_ = 0;
                              _loc74_ = null;
                              if(_loc72_ < _loc73_)
                              {
                                 _loc77_ = _loc65_;
                                 _loc78_ = _loc66_;
                                 _loc74_ = _loc30_;
                              }
                              else
                              {
                                 _loc77_ = _loc67_;
                                 _loc78_ = _loc68_;
                                 _loc74_ = _loc31_;
                                 _loc72_ = _loc73_;
                              }
                              if(_loc69_ < _loc72_)
                              {
                                 _loc28_.x = _loc75_;
                                 _loc28_.y = _loc76_;
                                 _loc29_.x = _loc71_.x;
                                 _loc29_.y = _loc71_.y;
                                 _loc26_ = Math.sqrt(_loc69_);
                              }
                              else
                              {
                                 _loc29_.x = _loc77_;
                                 _loc29_.y = _loc78_;
                                 _loc28_.x = _loc74_.x;
                                 _loc28_.y = _loc74_.y;
                                 _loc26_ = Math.sqrt(_loc72_);
                              }
                              if(_loc26_ != 0)
                              {
                                 _loc17_.x = _loc29_.x - _loc28_.x;
                                 _loc17_.y = _loc29_.y - _loc28_.y;
                                 _loc79_ = 1 / _loc26_;
                                 _loc17_.x *= _loc79_;
                                 _loc17_.y *= _loc79_;
                                 if(_loc39_)
                                 {
                                    _loc17_.x = -_loc17_.x;
                                    _loc17_.y = -_loc17_.y;
                                 }
                              }
                              §§push(_loc26_);
                           }
                           else
                           {
                              _loc42_ = 0;
                              _loc52_ = 0;
                              _loc42_ = _loc48_.gp0.x;
                              _loc52_ = _loc48_.gp0.y;
                              _loc53_ = 0;
                              _loc54_ = 0;
                              _loc53_ = _loc48_.gp1.x;
                              _loc54_ = _loc48_.gp1.y;
                              _loc55_ = 0;
                              _loc56_ = 0;
                              _loc55_ = _loc53_ - _loc42_;
                              _loc56_ = _loc54_ - _loc52_;
                              _loc57_ = _loc45_.gnormy * _loc42_ - _loc45_.gnormx * _loc52_;
                              _loc58_ = _loc45_.gnormy * _loc53_ - _loc45_.gnormx * _loc54_;
                              _loc59_ = 1 / (_loc58_ - _loc57_);
                              _loc60_ = (-_loc45_.tp1 - _loc57_) * _loc59_;
                              if(_loc60_ > Config.epsilon)
                              {
                                 _loc61_ = _loc60_;
                                 _loc42_ += _loc55_ * _loc61_;
                                 _loc52_ += _loc56_ * _loc61_;
                              }
                              _loc61_ = (-_loc45_.tp0 - _loc58_) * _loc59_;
                              if(_loc61_ < -Config.epsilon)
                              {
                                 _loc62_ = _loc61_;
                                 _loc53_ += _loc55_ * _loc62_;
                                 _loc54_ += _loc56_ * _loc62_;
                              }
                              _loc62_ = _loc42_ * _loc45_.gnormx + _loc52_ * _loc45_.gnormy - _loc45_.gprojection;
                              _loc63_ = _loc53_ * _loc45_.gnormx + _loc54_ * _loc45_.gnormy - _loc45_.gprojection;
                              §§push(_loc62_ < _loc63_ ? (_loc29_.x = _loc42_, _loc29_.y = _loc52_, _loc64_ = -_loc62_, _loc28_.x = _loc29_.x + _loc45_.gnormx * _loc64_, _loc28_.y = _loc29_.y + _loc45_.gnormy * _loc64_, _loc62_) : (_loc29_.x = _loc53_, _loc29_.y = _loc54_, _loc64_ = -_loc63_, _loc28_.x = _loc29_.x + _loc45_.gnormx * _loc64_, _loc28_.y = _loc29_.y + _loc45_.gnormy * _loc64_, _loc63_));
                           }
                        }
                        else
                        {
                           §§push(_loc25_);
                        }
                     }
                     else
                     {
                        §§push(_loc25_);
                     }
                  }
               }
               _loc24_ = §§pop() + param4;
               _loc25_ = _loc10_ * _loc17_.x + _loc11_ * _loc17_.y;
               if(_loc24_ < Config.distanceThresholdCCD)
               {
                  if(param5)
                  {
                     break;
                  }
                  _loc26_ = 0;
                  _loc38_ = 0;
                  _loc26_ = _loc15_.x - _loc8_.posx;
                  _loc38_ = _loc15_.y - _loc8_.posy;
                  _loc42_ = 0;
                  _loc52_ = 0;
                  _loc42_ = _loc16_.x - _loc9_.posx;
                  _loc52_ = _loc16_.y - _loc9_.posy;
                  _loc53_ = _loc25_ - _loc8_.sweep_angvel * (_loc17_.y * _loc26_ - _loc17_.x * _loc38_) + _loc9_.sweep_angvel * (_loc17_.y * _loc42_ - _loc17_.x * _loc52_);
                  if(_loc53_ > 0)
                  {
                     param1.slipped = true;
                  }
                  if(_loc53_ <= 0 || _loc24_ < Config.distanceThresholdCCD * 0.5)
                  {
                     break;
                  }
               }
               _loc18_ = -1;
               break;
            }
            _loc19_++;
            if(_loc19_ >= 40)
            {
               if(_loc20_ > param4)
               {
                  param1.failed = true;
               }
               break;
            }
         }
         param1.toi = _loc18_;
      }
      
      public static function staticSweep(param1:ZPP_ToiEvent, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:* = null as ZPP_Polygon;
         var _loc26_:* = null as ZPP_Vec2;
         var _loc27_:* = null as ZPP_Vec2;
         var _loc28_:* = null as ZPP_Vec2;
         var _loc29_:* = null as ZPP_Vec2;
         var _loc30_:* = null as ZNPNode_ZPP_Edge;
         var _loc31_:* = null as ZPP_Edge;
         var _loc32_:* = null as ZPP_Shape;
         var _loc33_:* = null as ZPP_Shape;
         var _loc34_:* = null as ZPP_Circle;
         var _loc35_:* = null as ZPP_Circle;
         var _loc36_:Number = NaN;
         var _loc37_:Boolean = false;
         var _loc38_:* = null as ZPP_Shape;
         var _loc39_:* = null as ZPP_Edge;
         var _loc40_:Number = NaN;
         var _loc41_:int = 0;
         var _loc42_:* = null as ZPP_Polygon;
         var _loc43_:* = null as ZPP_Edge;
         var _loc44_:* = null as ZPP_Polygon;
         var _loc45_:* = null as ZPP_Polygon;
         var _loc46_:* = null as ZPP_Edge;
         var _loc47_:* = null as ZPP_Edge;
         var _loc48_:* = null as ZPP_Vec2;
         var _loc49_:* = null as ZPP_Vec2;
         var _loc50_:Number = NaN;
         var _loc51_:Number = NaN;
         var _loc52_:Number = NaN;
         var _loc53_:Number = NaN;
         var _loc54_:Number = NaN;
         var _loc55_:Number = NaN;
         var _loc56_:Number = NaN;
         var _loc57_:Number = NaN;
         var _loc58_:Number = NaN;
         var _loc59_:Number = NaN;
         var _loc60_:Number = NaN;
         var _loc61_:Number = NaN;
         var _loc62_:Number = NaN;
         var _loc63_:Number = NaN;
         var _loc64_:Number = NaN;
         var _loc65_:Number = NaN;
         var _loc66_:Number = NaN;
         var _loc67_:Number = NaN;
         var _loc68_:Number = NaN;
         var _loc69_:* = null as ZPP_Vec2;
         var _loc70_:Number = NaN;
         var _loc71_:Number = NaN;
         var _loc72_:* = null as ZPP_Vec2;
         var _loc73_:Number = NaN;
         var _loc74_:Number = NaN;
         var _loc75_:Number = NaN;
         var _loc76_:Number = NaN;
         var _loc77_:Number = NaN;
         var _loc5_:ZPP_Shape = param1.s1;
         var _loc6_:ZPP_Shape = param1.s2;
         var _loc7_:ZPP_Body = _loc5_.body;
         var _loc8_:ZPP_Body = _loc6_.body;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         _loc9_ = -_loc7_.velx;
         _loc10_ = -_loc7_.vely;
         var _loc11_:Number = _loc7_.sweep_angvel;
         if(_loc11_ < 0)
         {
            _loc11_ = -_loc11_;
         }
         var _loc12_:Number = _loc5_.sweepCoef * _loc11_;
         var _loc13_:ZPP_Vec2 = param1.c1;
         var _loc14_:ZPP_Vec2 = param1.c2;
         var _loc15_:ZPP_Vec2 = param1.axis;
         var _loc16_:Number = param3;
         var _loc17_:int = 0;
         while(true)
         {
            _loc18_ = _loc16_ * param2;
            _loc19_ = _loc18_ - _loc7_.sweepTime;
            if(_loc19_ != 0)
            {
               _loc7_.sweepTime = _loc18_;
               _loc20_ = _loc19_;
               _loc7_.posx += _loc7_.velx * _loc20_;
               _loc7_.posy += _loc7_.vely * _loc20_;
               if(_loc7_.angvel != 0)
               {
                  _loc20_ = _loc7_.sweep_angvel * _loc19_;
                  _loc7_.rot += _loc20_;
                  if(_loc20_ * _loc20_ > 0.0001)
                  {
                     _loc7_.axisx = Math.sin(_loc7_.rot);
                     _loc7_.axisy = Math.cos(_loc7_.rot);
                     null;
                  }
                  else
                  {
                     _loc21_ = _loc20_ * _loc20_;
                     _loc22_ = 1 - 0.5 * _loc21_;
                     _loc23_ = 1 - _loc21_ * _loc21_ / 8;
                     _loc24_ = (_loc22_ * _loc7_.axisx + _loc20_ * _loc7_.axisy) * _loc23_;
                     _loc7_.axisy = (_loc22_ * _loc7_.axisy - _loc20_ * _loc7_.axisx) * _loc23_;
                     _loc7_.axisx = _loc24_;
                  }
               }
            }
            if(_loc5_.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc5_.worldCOMx = _loc7_.posx + (_loc7_.axisy * _loc5_.localCOMx - _loc7_.axisx * _loc5_.localCOMy);
               _loc5_.worldCOMy = _loc7_.posy + (_loc5_.localCOMx * _loc7_.axisx + _loc5_.localCOMy * _loc7_.axisy);
            }
            else
            {
               _loc25_ = _loc5_.polygon;
               _loc26_ = _loc25_.lverts.next;
               _loc27_ = _loc25_.gverts.next;
               while(_loc27_ != null)
               {
                  _loc28_ = _loc27_;
                  _loc29_ = _loc26_;
                  _loc26_ = _loc26_.next;
                  _loc28_.x = _loc7_.posx + (_loc7_.axisy * _loc29_.x - _loc7_.axisx * _loc29_.y);
                  _loc28_.y = _loc7_.posy + (_loc29_.x * _loc7_.axisx + _loc29_.y * _loc7_.axisy);
                  _loc27_ = _loc27_.next;
               }
               _loc30_ = _loc25_.edges.head;
               _loc27_ = _loc25_.gverts.next;
               _loc28_ = _loc27_;
               _loc27_ = _loc27_.next;
               while(_loc27_ != null)
               {
                  _loc29_ = _loc27_;
                  _loc31_ = _loc30_.elt;
                  _loc30_ = _loc30_.next;
                  _loc31_.gnormx = _loc7_.axisy * _loc31_.lnormx - _loc7_.axisx * _loc31_.lnormy;
                  _loc31_.gnormy = _loc31_.lnormx * _loc7_.axisx + _loc31_.lnormy * _loc7_.axisy;
                  _loc31_.gprojection = _loc7_.posx * _loc31_.gnormx + _loc7_.posy * _loc31_.gnormy + _loc31_.lprojection;
                  _loc31_.tp0 = _loc28_.y * _loc31_.gnormx - _loc28_.x * _loc31_.gnormy;
                  _loc31_.tp1 = _loc29_.y * _loc31_.gnormx - _loc29_.x * _loc31_.gnormy;
                  _loc28_ = _loc29_;
                  _loc27_ = _loc27_.next;
               }
               _loc29_ = _loc25_.gverts.next;
               _loc31_ = _loc30_.elt;
               _loc30_ = _loc30_.next;
               _loc31_.gnormx = _loc7_.axisy * _loc31_.lnormx - _loc7_.axisx * _loc31_.lnormy;
               _loc31_.gnormy = _loc31_.lnormx * _loc7_.axisx + _loc31_.lnormy * _loc7_.axisy;
               _loc31_.gprojection = _loc7_.posx * _loc31_.gnormx + _loc7_.posy * _loc31_.gnormy + _loc31_.lprojection;
               _loc31_.tp0 = _loc28_.y * _loc31_.gnormx - _loc28_.x * _loc31_.gnormy;
               _loc31_.tp1 = _loc29_.y * _loc31_.gnormx - _loc29_.x * _loc31_.gnormy;
            }
            _loc32_ = _loc5_;
            _loc33_ = _loc6_;
            _loc26_ = _loc13_;
            _loc27_ = _loc14_;
            _loc19_ = 1e+100;
            if(_loc32_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc33_.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc34_ = _loc32_.circle;
               _loc35_ = _loc33_.circle;
               _loc21_ = 0;
               _loc22_ = 0;
               _loc21_ = _loc35_.worldCOMx - _loc34_.worldCOMx;
               _loc22_ = _loc35_.worldCOMy - _loc34_.worldCOMy;
               _loc24_ = _loc21_ * _loc21_ + _loc22_ * _loc22_;
               _loc23_ = _loc24_ == 0 ? 0 : (sf32(_loc24_,0), si32(1597463007 - (li32(0) >> 1),0), _loc36_ = lf32(0), 1 / (_loc36_ * (1.5 - 0.5 * _loc24_ * _loc36_ * _loc36_)));
               _loc20_ = _loc23_ - (_loc34_.radius + _loc35_.radius);
               if(_loc20_ < _loc19_)
               {
                  if(_loc23_ == 0)
                  {
                     _loc21_ = 1;
                     _loc22_ = 0;
                  }
                  else
                  {
                     _loc24_ = 1 / _loc23_;
                     _loc21_ *= _loc24_;
                     _loc22_ *= _loc24_;
                  }
                  _loc24_ = _loc34_.radius;
                  _loc26_.x = _loc34_.worldCOMx + _loc21_ * _loc24_;
                  _loc26_.y = _loc34_.worldCOMy + _loc22_ * _loc24_;
                  _loc24_ = -_loc35_.radius;
                  _loc27_.x = _loc35_.worldCOMx + _loc21_ * _loc24_;
                  _loc27_.y = _loc35_.worldCOMy + _loc22_ * _loc24_;
                  _loc15_.x = _loc21_;
                  _loc15_.y = _loc22_;
               }
               §§push(_loc20_);
            }
            else
            {
               _loc37_ = false;
               if(_loc32_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc33_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc38_ = _loc32_;
                  _loc32_ = _loc33_;
                  _loc33_ = _loc38_;
                  _loc28_ = _loc26_;
                  _loc26_ = _loc27_;
                  _loc27_ = _loc28_;
                  _loc37_ = true;
               }
               if(_loc32_.type == ZPP_Flags.id_ShapeType_POLYGON && _loc33_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc25_ = _loc32_.polygon;
                  _loc34_ = _loc33_.circle;
                  _loc20_ = -1e+100;
                  _loc31_ = null;
                  _loc30_ = _loc25_.edges.head;
                  while(_loc30_ != null)
                  {
                     _loc39_ = _loc30_.elt;
                     _loc21_ = _loc39_.gnormx * _loc34_.worldCOMx + _loc39_.gnormy * _loc34_.worldCOMy - _loc39_.gprojection - _loc34_.radius;
                     if(_loc21_ > _loc19_)
                     {
                        _loc20_ = _loc21_;
                        break;
                     }
                     if(_loc21_ > 0)
                     {
                        if(_loc21_ > _loc20_)
                        {
                           _loc20_ = _loc21_;
                           _loc31_ = _loc39_;
                        }
                     }
                     else if(_loc20_ < 0 && _loc21_ > _loc20_)
                     {
                        _loc20_ = _loc21_;
                        _loc31_ = _loc39_;
                     }
                     _loc30_ = _loc30_.next;
                  }
                  if(_loc20_ < _loc19_)
                  {
                     _loc28_ = _loc31_.gp0;
                     _loc29_ = _loc31_.gp1;
                     _loc21_ = _loc34_.worldCOMy * _loc31_.gnormx - _loc34_.worldCOMx * _loc31_.gnormy;
                     if(_loc21_ <= _loc28_.y * _loc31_.gnormx - _loc28_.x * _loc31_.gnormy)
                     {
                        _loc22_ = 0;
                        _loc23_ = 0;
                        _loc22_ = _loc34_.worldCOMx - _loc28_.x;
                        _loc23_ = _loc34_.worldCOMy - _loc28_.y;
                        _loc36_ = _loc22_ * _loc22_ + _loc23_ * _loc23_;
                        _loc24_ = _loc36_ == 0 ? 0 : (sf32(_loc36_,0), si32(1597463007 - (li32(0) >> 1),0), _loc40_ = lf32(0), 1 / (_loc40_ * (1.5 - 0.5 * _loc36_ * _loc40_ * _loc40_)));
                        _loc20_ = _loc24_ - _loc34_.radius;
                        if(_loc20_ < _loc19_)
                        {
                           if(_loc24_ == 0)
                           {
                              _loc22_ = 1;
                              _loc23_ = 0;
                           }
                           else
                           {
                              _loc36_ = 1 / _loc24_;
                              _loc22_ *= _loc36_;
                              _loc23_ *= _loc36_;
                           }
                           _loc41_ = 0;
                           _loc26_.x = _loc28_.x + _loc22_ * _loc41_;
                           _loc26_.y = _loc28_.y + _loc23_ * _loc41_;
                           _loc36_ = -_loc34_.radius;
                           _loc27_.x = _loc34_.worldCOMx + _loc22_ * _loc36_;
                           _loc27_.y = _loc34_.worldCOMy + _loc23_ * _loc36_;
                           _loc15_.x = _loc22_;
                           _loc15_.y = _loc23_;
                        }
                     }
                     else if(_loc21_ >= _loc29_.y * _loc31_.gnormx - _loc29_.x * _loc31_.gnormy)
                     {
                        _loc22_ = 0;
                        _loc23_ = 0;
                        _loc22_ = _loc34_.worldCOMx - _loc29_.x;
                        _loc23_ = _loc34_.worldCOMy - _loc29_.y;
                        _loc36_ = _loc22_ * _loc22_ + _loc23_ * _loc23_;
                        _loc24_ = _loc36_ == 0 ? 0 : (sf32(_loc36_,0), si32(1597463007 - (li32(0) >> 1),0), _loc40_ = lf32(0), 1 / (_loc40_ * (1.5 - 0.5 * _loc36_ * _loc40_ * _loc40_)));
                        _loc20_ = _loc24_ - _loc34_.radius;
                        if(_loc20_ < _loc19_)
                        {
                           if(_loc24_ == 0)
                           {
                              _loc22_ = 1;
                              _loc23_ = 0;
                           }
                           else
                           {
                              _loc36_ = 1 / _loc24_;
                              _loc22_ *= _loc36_;
                              _loc23_ *= _loc36_;
                           }
                           _loc41_ = 0;
                           _loc26_.x = _loc29_.x + _loc22_ * _loc41_;
                           _loc26_.y = _loc29_.y + _loc23_ * _loc41_;
                           _loc36_ = -_loc34_.radius;
                           _loc27_.x = _loc34_.worldCOMx + _loc22_ * _loc36_;
                           _loc27_.y = _loc34_.worldCOMy + _loc23_ * _loc36_;
                           _loc15_.x = _loc22_;
                           _loc15_.y = _loc23_;
                        }
                     }
                     else
                     {
                        _loc22_ = -_loc34_.radius;
                        _loc27_.x = _loc34_.worldCOMx + _loc31_.gnormx * _loc22_;
                        _loc27_.y = _loc34_.worldCOMy + _loc31_.gnormy * _loc22_;
                        _loc22_ = -_loc20_;
                        _loc26_.x = _loc27_.x + _loc31_.gnormx * _loc22_;
                        _loc26_.y = _loc27_.y + _loc31_.gnormy * _loc22_;
                        _loc15_.x = _loc31_.gnormx;
                        _loc15_.y = _loc31_.gnormy;
                     }
                  }
                  if(_loc37_)
                  {
                     _loc15_.x = -_loc15_.x;
                     _loc15_.y = -_loc15_.y;
                  }
                  §§push(_loc20_);
               }
               else
               {
                  _loc25_ = _loc32_.polygon;
                  _loc42_ = _loc33_.polygon;
                  _loc20_ = -1e+100;
                  _loc31_ = null;
                  _loc39_ = null;
                  _loc41_ = 0;
                  _loc30_ = _loc25_.edges.head;
                  while(_loc30_ != null)
                  {
                     _loc43_ = _loc30_.elt;
                     _loc21_ = 1e+100;
                     _loc28_ = _loc42_.gverts.next;
                     while(_loc28_ != null)
                     {
                        _loc29_ = _loc28_;
                        _loc22_ = _loc43_.gnormx * _loc29_.x + _loc43_.gnormy * _loc29_.y;
                        if(_loc22_ < _loc21_)
                        {
                           _loc21_ = _loc22_;
                        }
                        _loc28_ = _loc28_.next;
                     }
                     _loc21_ -= _loc43_.gprojection;
                     if(_loc21_ > _loc19_)
                     {
                        _loc20_ = _loc21_;
                        break;
                     }
                     if(_loc21_ > 0)
                     {
                        if(_loc21_ > _loc20_)
                        {
                           _loc20_ = _loc21_;
                           _loc31_ = _loc43_;
                           _loc41_ = 1;
                        }
                     }
                     else if(_loc20_ < 0 && _loc21_ > _loc20_)
                     {
                        _loc20_ = _loc21_;
                        _loc31_ = _loc43_;
                        _loc41_ = 1;
                     }
                     _loc30_ = _loc30_.next;
                  }
                  if(_loc20_ < _loc19_)
                  {
                     _loc30_ = _loc42_.edges.head;
                     while(_loc30_ != null)
                     {
                        _loc43_ = _loc30_.elt;
                        _loc21_ = 1e+100;
                        _loc28_ = _loc25_.gverts.next;
                        while(_loc28_ != null)
                        {
                           _loc29_ = _loc28_;
                           _loc22_ = _loc43_.gnormx * _loc29_.x + _loc43_.gnormy * _loc29_.y;
                           if(_loc22_ < _loc21_)
                           {
                              _loc21_ = _loc22_;
                           }
                           _loc28_ = _loc28_.next;
                        }
                        _loc21_ -= _loc43_.gprojection;
                        if(_loc21_ > _loc19_)
                        {
                           _loc20_ = _loc21_;
                           break;
                        }
                        if(_loc21_ > 0)
                        {
                           if(_loc21_ > _loc20_)
                           {
                              _loc20_ = _loc21_;
                              _loc39_ = _loc43_;
                              _loc41_ = 2;
                           }
                        }
                        else if(_loc20_ < 0 && _loc21_ > _loc20_)
                        {
                           _loc20_ = _loc21_;
                           _loc39_ = _loc43_;
                           _loc41_ = 2;
                        }
                        _loc30_ = _loc30_.next;
                     }
                     if(_loc20_ < _loc19_)
                     {
                        if(_loc41_ == 1)
                        {
                           _loc44_ = _loc25_;
                           _loc45_ = _loc42_;
                           _loc43_ = _loc31_;
                        }
                        else
                        {
                           _loc44_ = _loc42_;
                           _loc45_ = _loc25_;
                           _loc43_ = _loc39_;
                           _loc28_ = _loc26_;
                           _loc26_ = _loc27_;
                           _loc27_ = _loc28_;
                           _loc37_ = !_loc37_;
                        }
                        _loc46_ = null;
                        _loc21_ = 1e+100;
                        _loc30_ = _loc45_.edges.head;
                        while(_loc30_ != null)
                        {
                           _loc47_ = _loc30_.elt;
                           _loc22_ = _loc43_.gnormx * _loc47_.gnormx + _loc43_.gnormy * _loc47_.gnormy;
                           if(_loc22_ < _loc21_)
                           {
                              _loc21_ = _loc22_;
                              _loc46_ = _loc47_;
                           }
                           _loc30_ = _loc30_.next;
                        }
                        if(_loc37_)
                        {
                           _loc15_.x = -_loc43_.gnormx;
                           _loc15_.y = -_loc43_.gnormy;
                        }
                        else
                        {
                           _loc15_.x = _loc43_.gnormx;
                           _loc15_.y = _loc43_.gnormy;
                        }
                        if(_loc20_ >= 0)
                        {
                           _loc28_ = _loc43_.gp0;
                           _loc29_ = _loc43_.gp1;
                           _loc48_ = _loc46_.gp0;
                           _loc49_ = _loc46_.gp1;
                           _loc22_ = 0;
                           _loc23_ = 0;
                           _loc24_ = 0;
                           _loc36_ = 0;
                           _loc22_ = _loc29_.x - _loc28_.x;
                           _loc23_ = _loc29_.y - _loc28_.y;
                           _loc24_ = _loc49_.x - _loc48_.x;
                           _loc36_ = _loc49_.y - _loc48_.y;
                           _loc40_ = 1 / (_loc22_ * _loc22_ + _loc23_ * _loc23_);
                           _loc50_ = 1 / (_loc24_ * _loc24_ + _loc36_ * _loc36_);
                           _loc51_ = -(_loc22_ * (_loc28_.x - _loc48_.x) + _loc23_ * (_loc28_.y - _loc48_.y)) * _loc40_;
                           _loc52_ = -(_loc22_ * (_loc28_.x - _loc49_.x) + _loc23_ * (_loc28_.y - _loc49_.y)) * _loc40_;
                           _loc53_ = -(_loc24_ * (_loc48_.x - _loc28_.x) + _loc36_ * (_loc48_.y - _loc28_.y)) * _loc50_;
                           _loc54_ = -(_loc24_ * (_loc48_.x - _loc29_.x) + _loc36_ * (_loc48_.y - _loc29_.y)) * _loc50_;
                           if(_loc51_ < 0)
                           {
                              _loc51_ = 0;
                           }
                           else if(_loc51_ > 1)
                           {
                              _loc51_ = 1;
                           }
                           if(_loc52_ < 0)
                           {
                              _loc52_ = 0;
                           }
                           else if(_loc52_ > 1)
                           {
                              _loc52_ = 1;
                           }
                           if(_loc53_ < 0)
                           {
                              _loc53_ = 0;
                           }
                           else if(_loc53_ > 1)
                           {
                              _loc53_ = 1;
                           }
                           if(_loc54_ < 0)
                           {
                              _loc54_ = 0;
                           }
                           else if(_loc54_ > 1)
                           {
                              _loc54_ = 1;
                           }
                           _loc55_ = 0;
                           _loc56_ = 0;
                           _loc57_ = _loc51_;
                           _loc55_ = _loc28_.x + _loc22_ * _loc57_;
                           _loc56_ = _loc28_.y + _loc23_ * _loc57_;
                           _loc57_ = 0;
                           _loc58_ = 0;
                           _loc59_ = _loc52_;
                           _loc57_ = _loc28_.x + _loc22_ * _loc59_;
                           _loc58_ = _loc28_.y + _loc23_ * _loc59_;
                           _loc59_ = 0;
                           _loc60_ = 0;
                           _loc61_ = _loc53_;
                           _loc59_ = _loc48_.x + _loc24_ * _loc61_;
                           _loc60_ = _loc48_.y + _loc36_ * _loc61_;
                           _loc61_ = 0;
                           _loc62_ = 0;
                           _loc63_ = _loc54_;
                           _loc61_ = _loc48_.x + _loc24_ * _loc63_;
                           _loc62_ = _loc48_.y + _loc36_ * _loc63_;
                           _loc64_ = 0;
                           _loc65_ = 0;
                           _loc64_ = _loc55_ - _loc48_.x;
                           _loc65_ = _loc56_ - _loc48_.y;
                           _loc63_ = _loc64_ * _loc64_ + _loc65_ * _loc65_;
                           _loc65_ = 0;
                           _loc66_ = 0;
                           _loc65_ = _loc57_ - _loc49_.x;
                           _loc66_ = _loc58_ - _loc49_.y;
                           _loc64_ = _loc65_ * _loc65_ + _loc66_ * _loc66_;
                           _loc66_ = 0;
                           _loc67_ = 0;
                           _loc66_ = _loc59_ - _loc28_.x;
                           _loc67_ = _loc60_ - _loc28_.y;
                           _loc65_ = _loc66_ * _loc66_ + _loc67_ * _loc67_;
                           _loc67_ = 0;
                           _loc68_ = 0;
                           _loc67_ = _loc61_ - _loc29_.x;
                           _loc68_ = _loc62_ - _loc29_.y;
                           _loc66_ = _loc67_ * _loc67_ + _loc68_ * _loc68_;
                           _loc67_ = 0;
                           _loc68_ = 0;
                           _loc69_ = null;
                           if(_loc63_ < _loc64_)
                           {
                              _loc67_ = _loc55_;
                              _loc68_ = _loc56_;
                              _loc69_ = _loc48_;
                           }
                           else
                           {
                              _loc67_ = _loc57_;
                              _loc68_ = _loc58_;
                              _loc69_ = _loc49_;
                              _loc63_ = _loc64_;
                           }
                           _loc70_ = 0;
                           _loc71_ = 0;
                           _loc72_ = null;
                           if(_loc65_ < _loc66_)
                           {
                              _loc70_ = _loc59_;
                              _loc71_ = _loc60_;
                              _loc72_ = _loc28_;
                           }
                           else
                           {
                              _loc70_ = _loc61_;
                              _loc71_ = _loc62_;
                              _loc72_ = _loc29_;
                              _loc65_ = _loc66_;
                           }
                           if(_loc63_ < _loc65_)
                           {
                              _loc26_.x = _loc67_;
                              _loc26_.y = _loc68_;
                              _loc27_.x = _loc69_.x;
                              _loc27_.y = _loc69_.y;
                              _loc20_ = Math.sqrt(_loc63_);
                           }
                           else
                           {
                              _loc27_.x = _loc70_;
                              _loc27_.y = _loc71_;
                              _loc26_.x = _loc72_.x;
                              _loc26_.y = _loc72_.y;
                              _loc20_ = Math.sqrt(_loc65_);
                           }
                           if(_loc20_ != 0)
                           {
                              _loc15_.x = _loc27_.x - _loc26_.x;
                              _loc15_.y = _loc27_.y - _loc26_.y;
                              _loc73_ = 1 / _loc20_;
                              _loc15_.x *= _loc73_;
                              _loc15_.y *= _loc73_;
                              if(_loc37_)
                              {
                                 _loc15_.x = -_loc15_.x;
                                 _loc15_.y = -_loc15_.y;
                              }
                           }
                           §§push(_loc20_);
                        }
                        else
                        {
                           _loc22_ = 0;
                           _loc23_ = 0;
                           _loc22_ = _loc46_.gp0.x;
                           _loc23_ = _loc46_.gp0.y;
                           _loc24_ = 0;
                           _loc36_ = 0;
                           _loc24_ = _loc46_.gp1.x;
                           _loc36_ = _loc46_.gp1.y;
                           _loc40_ = 0;
                           _loc50_ = 0;
                           _loc40_ = _loc24_ - _loc22_;
                           _loc50_ = _loc36_ - _loc23_;
                           _loc51_ = _loc43_.gnormy * _loc22_ - _loc43_.gnormx * _loc23_;
                           _loc52_ = _loc43_.gnormy * _loc24_ - _loc43_.gnormx * _loc36_;
                           _loc53_ = 1 / (_loc52_ - _loc51_);
                           _loc54_ = (-_loc43_.tp1 - _loc51_) * _loc53_;
                           if(_loc54_ > Config.epsilon)
                           {
                              _loc55_ = _loc54_;
                              _loc22_ += _loc40_ * _loc55_;
                              _loc23_ += _loc50_ * _loc55_;
                           }
                           _loc55_ = (-_loc43_.tp0 - _loc52_) * _loc53_;
                           if(_loc55_ < -Config.epsilon)
                           {
                              _loc56_ = _loc55_;
                              _loc24_ += _loc40_ * _loc56_;
                              _loc36_ += _loc50_ * _loc56_;
                           }
                           _loc56_ = _loc22_ * _loc43_.gnormx + _loc23_ * _loc43_.gnormy - _loc43_.gprojection;
                           _loc57_ = _loc24_ * _loc43_.gnormx + _loc36_ * _loc43_.gnormy - _loc43_.gprojection;
                           §§push(_loc56_ < _loc57_ ? (_loc27_.x = _loc22_, _loc27_.y = _loc23_, _loc58_ = -_loc56_, _loc26_.x = _loc27_.x + _loc43_.gnormx * _loc58_, _loc26_.y = _loc27_.y + _loc43_.gnormy * _loc58_, _loc56_) : (_loc27_.x = _loc24_, _loc27_.y = _loc36_, _loc58_ = -_loc57_, _loc26_.x = _loc27_.x + _loc43_.gnormx * _loc58_, _loc26_.y = _loc27_.y + _loc43_.gnormy * _loc58_, _loc57_));
                        }
                     }
                     else
                     {
                        §§push(_loc19_);
                     }
                  }
                  else
                  {
                     §§push(_loc19_);
                  }
               }
            }
            _loc18_ = §§pop() + param4;
            _loc19_ = _loc9_ * _loc15_.x + _loc10_ * _loc15_.y;
            if(_loc18_ < Config.distanceThresholdCCD)
            {
               _loc20_ = 0;
               _loc21_ = 0;
               _loc20_ = _loc13_.x - _loc7_.posx;
               _loc21_ = _loc13_.y - _loc7_.posy;
               _loc22_ = _loc19_ - _loc7_.sweep_angvel * (_loc15_.y * _loc20_ - _loc15_.x * _loc21_);
               if(_loc22_ > 0)
               {
                  param1.slipped = true;
               }
               if(_loc22_ <= 0 || _loc18_ < Config.distanceThresholdCCD * 0.5)
               {
                  break;
               }
            }
            _loc20_ = (_loc12_ - _loc19_) * param2;
            if(_loc20_ <= 0)
            {
               _loc16_ = -1;
               break;
            }
            _loc21_ = _loc18_ / _loc20_;
            if(_loc21_ < 0.000001)
            {
               _loc21_ = 0.000001;
            }
            _loc16_ += _loc21_;
            if(_loc16_ >= 1)
            {
               _loc16_ = 1;
               _loc22_ = _loc16_ * param2;
               _loc23_ = _loc22_ - _loc7_.sweepTime;
               if(_loc23_ != 0)
               {
                  _loc7_.sweepTime = _loc22_;
                  _loc24_ = _loc23_;
                  _loc7_.posx += _loc7_.velx * _loc24_;
                  _loc7_.posy += _loc7_.vely * _loc24_;
                  if(_loc7_.angvel != 0)
                  {
                     _loc24_ = _loc7_.sweep_angvel * _loc23_;
                     _loc7_.rot += _loc24_;
                     if(_loc24_ * _loc24_ > 0.0001)
                     {
                        _loc7_.axisx = Math.sin(_loc7_.rot);
                        _loc7_.axisy = Math.cos(_loc7_.rot);
                        null;
                     }
                     else
                     {
                        _loc36_ = _loc24_ * _loc24_;
                        _loc40_ = 1 - 0.5 * _loc36_;
                        _loc50_ = 1 - _loc36_ * _loc36_ / 8;
                        _loc51_ = (_loc40_ * _loc7_.axisx + _loc24_ * _loc7_.axisy) * _loc50_;
                        _loc7_.axisy = (_loc40_ * _loc7_.axisy - _loc24_ * _loc7_.axisx) * _loc50_;
                        _loc7_.axisx = _loc51_;
                     }
                  }
               }
               if(_loc5_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc5_.worldCOMx = _loc7_.posx + (_loc7_.axisy * _loc5_.localCOMx - _loc7_.axisx * _loc5_.localCOMy);
                  _loc5_.worldCOMy = _loc7_.posy + (_loc5_.localCOMx * _loc7_.axisx + _loc5_.localCOMy * _loc7_.axisy);
               }
               else
               {
                  _loc25_ = _loc5_.polygon;
                  _loc26_ = _loc25_.lverts.next;
                  _loc27_ = _loc25_.gverts.next;
                  while(_loc27_ != null)
                  {
                     _loc28_ = _loc27_;
                     _loc29_ = _loc26_;
                     _loc26_ = _loc26_.next;
                     _loc28_.x = _loc7_.posx + (_loc7_.axisy * _loc29_.x - _loc7_.axisx * _loc29_.y);
                     _loc28_.y = _loc7_.posy + (_loc29_.x * _loc7_.axisx + _loc29_.y * _loc7_.axisy);
                     _loc27_ = _loc27_.next;
                  }
                  _loc30_ = _loc25_.edges.head;
                  _loc27_ = _loc25_.gverts.next;
                  _loc28_ = _loc27_;
                  _loc27_ = _loc27_.next;
                  while(_loc27_ != null)
                  {
                     _loc29_ = _loc27_;
                     _loc31_ = _loc30_.elt;
                     _loc30_ = _loc30_.next;
                     _loc31_.gnormx = _loc7_.axisy * _loc31_.lnormx - _loc7_.axisx * _loc31_.lnormy;
                     _loc31_.gnormy = _loc31_.lnormx * _loc7_.axisx + _loc31_.lnormy * _loc7_.axisy;
                     _loc31_.gprojection = _loc7_.posx * _loc31_.gnormx + _loc7_.posy * _loc31_.gnormy + _loc31_.lprojection;
                     _loc31_.tp0 = _loc28_.y * _loc31_.gnormx - _loc28_.x * _loc31_.gnormy;
                     _loc31_.tp1 = _loc29_.y * _loc31_.gnormx - _loc29_.x * _loc31_.gnormy;
                     _loc28_ = _loc29_;
                     _loc27_ = _loc27_.next;
                  }
                  _loc29_ = _loc25_.gverts.next;
                  _loc31_ = _loc30_.elt;
                  _loc30_ = _loc30_.next;
                  _loc31_.gnormx = _loc7_.axisy * _loc31_.lnormx - _loc7_.axisx * _loc31_.lnormy;
                  _loc31_.gnormy = _loc31_.lnormx * _loc7_.axisx + _loc31_.lnormy * _loc7_.axisy;
                  _loc31_.gprojection = _loc7_.posx * _loc31_.gnormx + _loc7_.posy * _loc31_.gnormy + _loc31_.lprojection;
                  _loc31_.tp0 = _loc28_.y * _loc31_.gnormx - _loc28_.x * _loc31_.gnormy;
                  _loc31_.tp1 = _loc29_.y * _loc31_.gnormx - _loc29_.x * _loc31_.gnormy;
               }
               _loc32_ = _loc5_;
               _loc33_ = _loc6_;
               _loc26_ = _loc13_;
               _loc27_ = _loc14_;
               _loc23_ = 1e+100;
               if(_loc32_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc33_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc34_ = _loc32_.circle;
                  _loc35_ = _loc33_.circle;
                  _loc36_ = 0;
                  _loc40_ = 0;
                  _loc36_ = _loc35_.worldCOMx - _loc34_.worldCOMx;
                  _loc40_ = _loc35_.worldCOMy - _loc34_.worldCOMy;
                  _loc51_ = _loc36_ * _loc36_ + _loc40_ * _loc40_;
                  _loc50_ = _loc51_ == 0 ? 0 : (sf32(_loc51_,0), si32(1597463007 - (li32(0) >> 1),0), _loc52_ = lf32(0), 1 / (_loc52_ * (1.5 - 0.5 * _loc51_ * _loc52_ * _loc52_)));
                  _loc24_ = _loc50_ - (_loc34_.radius + _loc35_.radius);
                  if(_loc24_ < _loc23_)
                  {
                     if(_loc50_ == 0)
                     {
                        _loc36_ = 1;
                        _loc40_ = 0;
                     }
                     else
                     {
                        _loc51_ = 1 / _loc50_;
                        _loc36_ *= _loc51_;
                        _loc40_ *= _loc51_;
                     }
                     _loc51_ = _loc34_.radius;
                     _loc26_.x = _loc34_.worldCOMx + _loc36_ * _loc51_;
                     _loc26_.y = _loc34_.worldCOMy + _loc40_ * _loc51_;
                     _loc51_ = -_loc35_.radius;
                     _loc27_.x = _loc35_.worldCOMx + _loc36_ * _loc51_;
                     _loc27_.y = _loc35_.worldCOMy + _loc40_ * _loc51_;
                     _loc15_.x = _loc36_;
                     _loc15_.y = _loc40_;
                  }
                  §§push(_loc24_);
               }
               else
               {
                  _loc37_ = false;
                  if(_loc32_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc33_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc38_ = _loc32_;
                     _loc32_ = _loc33_;
                     _loc33_ = _loc38_;
                     _loc28_ = _loc26_;
                     _loc26_ = _loc27_;
                     _loc27_ = _loc28_;
                     _loc37_ = true;
                  }
                  if(_loc32_.type == ZPP_Flags.id_ShapeType_POLYGON && _loc33_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc25_ = _loc32_.polygon;
                     _loc34_ = _loc33_.circle;
                     _loc24_ = -1e+100;
                     _loc31_ = null;
                     _loc30_ = _loc25_.edges.head;
                     while(_loc30_ != null)
                     {
                        _loc39_ = _loc30_.elt;
                        _loc36_ = _loc39_.gnormx * _loc34_.worldCOMx + _loc39_.gnormy * _loc34_.worldCOMy - _loc39_.gprojection - _loc34_.radius;
                        if(_loc36_ > _loc23_)
                        {
                           _loc24_ = _loc36_;
                           break;
                        }
                        if(_loc36_ > 0)
                        {
                           if(_loc36_ > _loc24_)
                           {
                              _loc24_ = _loc36_;
                              _loc31_ = _loc39_;
                           }
                        }
                        else if(_loc24_ < 0 && _loc36_ > _loc24_)
                        {
                           _loc24_ = _loc36_;
                           _loc31_ = _loc39_;
                        }
                        _loc30_ = _loc30_.next;
                     }
                     if(_loc24_ < _loc23_)
                     {
                        _loc28_ = _loc31_.gp0;
                        _loc29_ = _loc31_.gp1;
                        _loc36_ = _loc34_.worldCOMy * _loc31_.gnormx - _loc34_.worldCOMx * _loc31_.gnormy;
                        if(_loc36_ <= _loc28_.y * _loc31_.gnormx - _loc28_.x * _loc31_.gnormy)
                        {
                           _loc40_ = 0;
                           _loc50_ = 0;
                           _loc40_ = _loc34_.worldCOMx - _loc28_.x;
                           _loc50_ = _loc34_.worldCOMy - _loc28_.y;
                           _loc52_ = _loc40_ * _loc40_ + _loc50_ * _loc50_;
                           _loc51_ = _loc52_ == 0 ? 0 : (sf32(_loc52_,0), si32(1597463007 - (li32(0) >> 1),0), _loc53_ = lf32(0), 1 / (_loc53_ * (1.5 - 0.5 * _loc52_ * _loc53_ * _loc53_)));
                           _loc24_ = _loc51_ - _loc34_.radius;
                           if(_loc24_ < _loc23_)
                           {
                              if(_loc51_ == 0)
                              {
                                 _loc40_ = 1;
                                 _loc50_ = 0;
                              }
                              else
                              {
                                 _loc52_ = 1 / _loc51_;
                                 _loc40_ *= _loc52_;
                                 _loc50_ *= _loc52_;
                              }
                              _loc41_ = 0;
                              _loc26_.x = _loc28_.x + _loc40_ * _loc41_;
                              _loc26_.y = _loc28_.y + _loc50_ * _loc41_;
                              _loc52_ = -_loc34_.radius;
                              _loc27_.x = _loc34_.worldCOMx + _loc40_ * _loc52_;
                              _loc27_.y = _loc34_.worldCOMy + _loc50_ * _loc52_;
                              _loc15_.x = _loc40_;
                              _loc15_.y = _loc50_;
                           }
                        }
                        else if(_loc36_ >= _loc29_.y * _loc31_.gnormx - _loc29_.x * _loc31_.gnormy)
                        {
                           _loc40_ = 0;
                           _loc50_ = 0;
                           _loc40_ = _loc34_.worldCOMx - _loc29_.x;
                           _loc50_ = _loc34_.worldCOMy - _loc29_.y;
                           _loc52_ = _loc40_ * _loc40_ + _loc50_ * _loc50_;
                           _loc51_ = _loc52_ == 0 ? 0 : (sf32(_loc52_,0), si32(1597463007 - (li32(0) >> 1),0), _loc53_ = lf32(0), 1 / (_loc53_ * (1.5 - 0.5 * _loc52_ * _loc53_ * _loc53_)));
                           _loc24_ = _loc51_ - _loc34_.radius;
                           if(_loc24_ < _loc23_)
                           {
                              if(_loc51_ == 0)
                              {
                                 _loc40_ = 1;
                                 _loc50_ = 0;
                              }
                              else
                              {
                                 _loc52_ = 1 / _loc51_;
                                 _loc40_ *= _loc52_;
                                 _loc50_ *= _loc52_;
                              }
                              _loc41_ = 0;
                              _loc26_.x = _loc29_.x + _loc40_ * _loc41_;
                              _loc26_.y = _loc29_.y + _loc50_ * _loc41_;
                              _loc52_ = -_loc34_.radius;
                              _loc27_.x = _loc34_.worldCOMx + _loc40_ * _loc52_;
                              _loc27_.y = _loc34_.worldCOMy + _loc50_ * _loc52_;
                              _loc15_.x = _loc40_;
                              _loc15_.y = _loc50_;
                           }
                        }
                        else
                        {
                           _loc40_ = -_loc34_.radius;
                           _loc27_.x = _loc34_.worldCOMx + _loc31_.gnormx * _loc40_;
                           _loc27_.y = _loc34_.worldCOMy + _loc31_.gnormy * _loc40_;
                           _loc40_ = -_loc24_;
                           _loc26_.x = _loc27_.x + _loc31_.gnormx * _loc40_;
                           _loc26_.y = _loc27_.y + _loc31_.gnormy * _loc40_;
                           _loc15_.x = _loc31_.gnormx;
                           _loc15_.y = _loc31_.gnormy;
                        }
                     }
                     if(_loc37_)
                     {
                        _loc15_.x = -_loc15_.x;
                        _loc15_.y = -_loc15_.y;
                     }
                     §§push(_loc24_);
                  }
                  else
                  {
                     _loc25_ = _loc32_.polygon;
                     _loc42_ = _loc33_.polygon;
                     _loc24_ = -1e+100;
                     _loc31_ = null;
                     _loc39_ = null;
                     _loc41_ = 0;
                     _loc30_ = _loc25_.edges.head;
                     while(_loc30_ != null)
                     {
                        _loc43_ = _loc30_.elt;
                        _loc36_ = 1e+100;
                        _loc28_ = _loc42_.gverts.next;
                        while(_loc28_ != null)
                        {
                           _loc29_ = _loc28_;
                           _loc40_ = _loc43_.gnormx * _loc29_.x + _loc43_.gnormy * _loc29_.y;
                           if(_loc40_ < _loc36_)
                           {
                              _loc36_ = _loc40_;
                           }
                           _loc28_ = _loc28_.next;
                        }
                        _loc36_ -= _loc43_.gprojection;
                        if(_loc36_ > _loc23_)
                        {
                           _loc24_ = _loc36_;
                           break;
                        }
                        if(_loc36_ > 0)
                        {
                           if(_loc36_ > _loc24_)
                           {
                              _loc24_ = _loc36_;
                              _loc31_ = _loc43_;
                              _loc41_ = 1;
                           }
                        }
                        else if(_loc24_ < 0 && _loc36_ > _loc24_)
                        {
                           _loc24_ = _loc36_;
                           _loc31_ = _loc43_;
                           _loc41_ = 1;
                        }
                        _loc30_ = _loc30_.next;
                     }
                     if(_loc24_ < _loc23_)
                     {
                        _loc30_ = _loc42_.edges.head;
                        while(_loc30_ != null)
                        {
                           _loc43_ = _loc30_.elt;
                           _loc36_ = 1e+100;
                           _loc28_ = _loc25_.gverts.next;
                           while(_loc28_ != null)
                           {
                              _loc29_ = _loc28_;
                              _loc40_ = _loc43_.gnormx * _loc29_.x + _loc43_.gnormy * _loc29_.y;
                              if(_loc40_ < _loc36_)
                              {
                                 _loc36_ = _loc40_;
                              }
                              _loc28_ = _loc28_.next;
                           }
                           _loc36_ -= _loc43_.gprojection;
                           if(_loc36_ > _loc23_)
                           {
                              _loc24_ = _loc36_;
                              break;
                           }
                           if(_loc36_ > 0)
                           {
                              if(_loc36_ > _loc24_)
                              {
                                 _loc24_ = _loc36_;
                                 _loc39_ = _loc43_;
                                 _loc41_ = 2;
                              }
                           }
                           else if(_loc24_ < 0 && _loc36_ > _loc24_)
                           {
                              _loc24_ = _loc36_;
                              _loc39_ = _loc43_;
                              _loc41_ = 2;
                           }
                           _loc30_ = _loc30_.next;
                        }
                        if(_loc24_ < _loc23_)
                        {
                           if(_loc41_ == 1)
                           {
                              _loc44_ = _loc25_;
                              _loc45_ = _loc42_;
                              _loc43_ = _loc31_;
                           }
                           else
                           {
                              _loc44_ = _loc42_;
                              _loc45_ = _loc25_;
                              _loc43_ = _loc39_;
                              _loc28_ = _loc26_;
                              _loc26_ = _loc27_;
                              _loc27_ = _loc28_;
                              _loc37_ = !_loc37_;
                           }
                           _loc46_ = null;
                           _loc36_ = 1e+100;
                           _loc30_ = _loc45_.edges.head;
                           while(_loc30_ != null)
                           {
                              _loc47_ = _loc30_.elt;
                              _loc40_ = _loc43_.gnormx * _loc47_.gnormx + _loc43_.gnormy * _loc47_.gnormy;
                              if(_loc40_ < _loc36_)
                              {
                                 _loc36_ = _loc40_;
                                 _loc46_ = _loc47_;
                              }
                              _loc30_ = _loc30_.next;
                           }
                           if(_loc37_)
                           {
                              _loc15_.x = -_loc43_.gnormx;
                              _loc15_.y = -_loc43_.gnormy;
                           }
                           else
                           {
                              _loc15_.x = _loc43_.gnormx;
                              _loc15_.y = _loc43_.gnormy;
                           }
                           if(_loc24_ >= 0)
                           {
                              _loc28_ = _loc43_.gp0;
                              _loc29_ = _loc43_.gp1;
                              _loc48_ = _loc46_.gp0;
                              _loc49_ = _loc46_.gp1;
                              _loc40_ = 0;
                              _loc50_ = 0;
                              _loc51_ = 0;
                              _loc52_ = 0;
                              _loc40_ = _loc29_.x - _loc28_.x;
                              _loc50_ = _loc29_.y - _loc28_.y;
                              _loc51_ = _loc49_.x - _loc48_.x;
                              _loc52_ = _loc49_.y - _loc48_.y;
                              _loc53_ = 1 / (_loc40_ * _loc40_ + _loc50_ * _loc50_);
                              _loc54_ = 1 / (_loc51_ * _loc51_ + _loc52_ * _loc52_);
                              _loc55_ = -(_loc40_ * (_loc28_.x - _loc48_.x) + _loc50_ * (_loc28_.y - _loc48_.y)) * _loc53_;
                              _loc56_ = -(_loc40_ * (_loc28_.x - _loc49_.x) + _loc50_ * (_loc28_.y - _loc49_.y)) * _loc53_;
                              _loc57_ = -(_loc51_ * (_loc48_.x - _loc28_.x) + _loc52_ * (_loc48_.y - _loc28_.y)) * _loc54_;
                              _loc58_ = -(_loc51_ * (_loc48_.x - _loc29_.x) + _loc52_ * (_loc48_.y - _loc29_.y)) * _loc54_;
                              if(_loc55_ < 0)
                              {
                                 _loc55_ = 0;
                              }
                              else if(_loc55_ > 1)
                              {
                                 _loc55_ = 1;
                              }
                              if(_loc56_ < 0)
                              {
                                 _loc56_ = 0;
                              }
                              else if(_loc56_ > 1)
                              {
                                 _loc56_ = 1;
                              }
                              if(_loc57_ < 0)
                              {
                                 _loc57_ = 0;
                              }
                              else if(_loc57_ > 1)
                              {
                                 _loc57_ = 1;
                              }
                              if(_loc58_ < 0)
                              {
                                 _loc58_ = 0;
                              }
                              else if(_loc58_ > 1)
                              {
                                 _loc58_ = 1;
                              }
                              _loc59_ = 0;
                              _loc60_ = 0;
                              _loc61_ = _loc55_;
                              _loc59_ = _loc28_.x + _loc40_ * _loc61_;
                              _loc60_ = _loc28_.y + _loc50_ * _loc61_;
                              _loc61_ = 0;
                              _loc62_ = 0;
                              _loc63_ = _loc56_;
                              _loc61_ = _loc28_.x + _loc40_ * _loc63_;
                              _loc62_ = _loc28_.y + _loc50_ * _loc63_;
                              _loc63_ = 0;
                              _loc64_ = 0;
                              _loc65_ = _loc57_;
                              _loc63_ = _loc48_.x + _loc51_ * _loc65_;
                              _loc64_ = _loc48_.y + _loc52_ * _loc65_;
                              _loc65_ = 0;
                              _loc66_ = 0;
                              _loc67_ = _loc58_;
                              _loc65_ = _loc48_.x + _loc51_ * _loc67_;
                              _loc66_ = _loc48_.y + _loc52_ * _loc67_;
                              _loc68_ = 0;
                              _loc70_ = 0;
                              _loc68_ = _loc59_ - _loc48_.x;
                              _loc70_ = _loc60_ - _loc48_.y;
                              _loc67_ = _loc68_ * _loc68_ + _loc70_ * _loc70_;
                              _loc70_ = 0;
                              _loc71_ = 0;
                              _loc70_ = _loc61_ - _loc49_.x;
                              _loc71_ = _loc62_ - _loc49_.y;
                              _loc68_ = _loc70_ * _loc70_ + _loc71_ * _loc71_;
                              _loc71_ = 0;
                              _loc73_ = 0;
                              _loc71_ = _loc63_ - _loc28_.x;
                              _loc73_ = _loc64_ - _loc28_.y;
                              _loc70_ = _loc71_ * _loc71_ + _loc73_ * _loc73_;
                              _loc73_ = 0;
                              _loc74_ = 0;
                              _loc73_ = _loc65_ - _loc29_.x;
                              _loc74_ = _loc66_ - _loc29_.y;
                              _loc71_ = _loc73_ * _loc73_ + _loc74_ * _loc74_;
                              _loc73_ = 0;
                              _loc74_ = 0;
                              _loc69_ = null;
                              if(_loc67_ < _loc68_)
                              {
                                 _loc73_ = _loc59_;
                                 _loc74_ = _loc60_;
                                 _loc69_ = _loc48_;
                              }
                              else
                              {
                                 _loc73_ = _loc61_;
                                 _loc74_ = _loc62_;
                                 _loc69_ = _loc49_;
                                 _loc67_ = _loc68_;
                              }
                              _loc75_ = 0;
                              _loc76_ = 0;
                              _loc72_ = null;
                              if(_loc70_ < _loc71_)
                              {
                                 _loc75_ = _loc63_;
                                 _loc76_ = _loc64_;
                                 _loc72_ = _loc28_;
                              }
                              else
                              {
                                 _loc75_ = _loc65_;
                                 _loc76_ = _loc66_;
                                 _loc72_ = _loc29_;
                                 _loc70_ = _loc71_;
                              }
                              if(_loc67_ < _loc70_)
                              {
                                 _loc26_.x = _loc73_;
                                 _loc26_.y = _loc74_;
                                 _loc27_.x = _loc69_.x;
                                 _loc27_.y = _loc69_.y;
                                 _loc24_ = Math.sqrt(_loc67_);
                              }
                              else
                              {
                                 _loc27_.x = _loc75_;
                                 _loc27_.y = _loc76_;
                                 _loc26_.x = _loc72_.x;
                                 _loc26_.y = _loc72_.y;
                                 _loc24_ = Math.sqrt(_loc70_);
                              }
                              if(_loc24_ != 0)
                              {
                                 _loc15_.x = _loc27_.x - _loc26_.x;
                                 _loc15_.y = _loc27_.y - _loc26_.y;
                                 _loc77_ = 1 / _loc24_;
                                 _loc15_.x *= _loc77_;
                                 _loc15_.y *= _loc77_;
                                 if(_loc37_)
                                 {
                                    _loc15_.x = -_loc15_.x;
                                    _loc15_.y = -_loc15_.y;
                                 }
                              }
                              §§push(_loc24_);
                           }
                           else
                           {
                              _loc40_ = 0;
                              _loc50_ = 0;
                              _loc40_ = _loc46_.gp0.x;
                              _loc50_ = _loc46_.gp0.y;
                              _loc51_ = 0;
                              _loc52_ = 0;
                              _loc51_ = _loc46_.gp1.x;
                              _loc52_ = _loc46_.gp1.y;
                              _loc53_ = 0;
                              _loc54_ = 0;
                              _loc53_ = _loc51_ - _loc40_;
                              _loc54_ = _loc52_ - _loc50_;
                              _loc55_ = _loc43_.gnormy * _loc40_ - _loc43_.gnormx * _loc50_;
                              _loc56_ = _loc43_.gnormy * _loc51_ - _loc43_.gnormx * _loc52_;
                              _loc57_ = 1 / (_loc56_ - _loc55_);
                              _loc58_ = (-_loc43_.tp1 - _loc55_) * _loc57_;
                              if(_loc58_ > Config.epsilon)
                              {
                                 _loc59_ = _loc58_;
                                 _loc40_ += _loc53_ * _loc59_;
                                 _loc50_ += _loc54_ * _loc59_;
                              }
                              _loc59_ = (-_loc43_.tp0 - _loc56_) * _loc57_;
                              if(_loc59_ < -Config.epsilon)
                              {
                                 _loc60_ = _loc59_;
                                 _loc51_ += _loc53_ * _loc60_;
                                 _loc52_ += _loc54_ * _loc60_;
                              }
                              _loc60_ = _loc40_ * _loc43_.gnormx + _loc50_ * _loc43_.gnormy - _loc43_.gprojection;
                              _loc61_ = _loc51_ * _loc43_.gnormx + _loc52_ * _loc43_.gnormy - _loc43_.gprojection;
                              §§push(_loc60_ < _loc61_ ? (_loc27_.x = _loc40_, _loc27_.y = _loc50_, _loc62_ = -_loc60_, _loc26_.x = _loc27_.x + _loc43_.gnormx * _loc62_, _loc26_.y = _loc27_.y + _loc43_.gnormy * _loc62_, _loc60_) : (_loc27_.x = _loc51_, _loc27_.y = _loc52_, _loc62_ = -_loc61_, _loc26_.x = _loc27_.x + _loc43_.gnormx * _loc62_, _loc26_.y = _loc27_.y + _loc43_.gnormy * _loc62_, _loc61_));
                           }
                        }
                        else
                        {
                           §§push(_loc23_);
                        }
                     }
                     else
                     {
                        §§push(_loc23_);
                     }
                  }
               }
               _loc22_ = §§pop() + param4;
               _loc23_ = _loc9_ * _loc15_.x + _loc10_ * _loc15_.y;
               if(_loc22_ < Config.distanceThresholdCCD)
               {
                  _loc24_ = 0;
                  _loc36_ = 0;
                  _loc24_ = _loc13_.x - _loc7_.posx;
                  _loc36_ = _loc13_.y - _loc7_.posy;
                  _loc40_ = _loc23_ - _loc7_.sweep_angvel * (_loc15_.y * _loc24_ - _loc15_.x * _loc36_);
                  if(_loc40_ > 0)
                  {
                     param1.slipped = true;
                  }
                  if(_loc40_ <= 0 || _loc22_ < Config.distanceThresholdCCD * 0.5)
                  {
                     break;
                  }
               }
               _loc16_ = -1;
               break;
            }
            _loc17_++;
            if(_loc17_ >= 40)
            {
               if(_loc18_ > param4)
               {
                  param1.failed = true;
               }
               break;
            }
         }
         param1.toi = _loc16_;
      }
      
      public static function distanceBody(param1:ZPP_Body, param2:ZPP_Body, param3:ZPP_Vec2, param4:ZPP_Vec2) : Number
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Shape;
         var _loc11_:* = null as ZNPNode_ZPP_Shape;
         var _loc12_:* = null as ZPP_Shape;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as ZPP_Shape;
         var _loc15_:* = null as ZPP_Shape;
         var _loc16_:* = null as ZPP_Vec2;
         var _loc17_:* = null as ZPP_Vec2;
         var _loc18_:* = null as ZPP_Circle;
         var _loc19_:* = null as ZPP_Circle;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Boolean = false;
         var _loc27_:* = null as ZPP_Shape;
         var _loc28_:* = null as ZPP_Vec2;
         var _loc29_:* = null as ZPP_Polygon;
         var _loc30_:* = null as ZPP_Edge;
         var _loc31_:* = null as ZNPNode_ZPP_Edge;
         var _loc32_:* = null as ZPP_Edge;
         var _loc33_:* = null as ZPP_Vec2;
         var _loc34_:Number = NaN;
         var _loc35_:int = 0;
         var _loc36_:* = null as ZPP_Polygon;
         var _loc37_:* = null as ZPP_Edge;
         var _loc38_:* = null as ZPP_Polygon;
         var _loc39_:* = null as ZPP_Polygon;
         var _loc40_:* = null as ZPP_Edge;
         var _loc41_:* = null as ZPP_Edge;
         var _loc42_:* = null as ZPP_Vec2;
         var _loc43_:* = null as ZPP_Vec2;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc47_:Number = NaN;
         var _loc48_:Number = NaN;
         var _loc49_:Number = NaN;
         var _loc50_:Number = NaN;
         var _loc51_:Number = NaN;
         var _loc52_:Number = NaN;
         var _loc53_:Number = NaN;
         var _loc54_:Number = NaN;
         var _loc55_:Number = NaN;
         var _loc56_:Number = NaN;
         var _loc57_:Number = NaN;
         var _loc58_:Number = NaN;
         var _loc59_:Number = NaN;
         var _loc60_:Number = NaN;
         var _loc61_:Number = NaN;
         var _loc62_:Number = NaN;
         var _loc63_:* = null as ZPP_Vec2;
         var _loc64_:Number = NaN;
         var _loc65_:Number = NaN;
         var _loc66_:* = null as ZPP_Vec2;
         var _loc67_:Number = NaN;
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc5_ = new ZPP_Vec2();
         }
         else
         {
            _loc5_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc5_.next;
            _loc5_.next = null;
         }
         _loc5_.weak = false;
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc6_ = new ZPP_Vec2();
         }
         else
         {
            _loc6_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc6_.next;
            _loc6_.next = null;
         }
         _loc6_.weak = false;
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc7_ = new ZPP_Vec2();
         }
         else
         {
            _loc7_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc7_.next;
            _loc7_.next = null;
         }
         _loc7_.weak = false;
         var _loc8_:Number = 1e+100;
         var _loc9_:ZNPNode_ZPP_Shape = param1.shapes.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            _loc11_ = param2.shapes.head;
            while(_loc11_ != null)
            {
               _loc12_ = _loc11_.elt;
               _loc14_ = _loc10_;
               _loc15_ = _loc12_;
               _loc16_ = _loc5_;
               _loc17_ = _loc6_;
               if(_loc14_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc15_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc18_ = _loc14_.circle;
                  _loc19_ = _loc15_.circle;
                  _loc21_ = 0;
                  _loc22_ = 0;
                  _loc21_ = _loc19_.worldCOMx - _loc18_.worldCOMx;
                  _loc22_ = _loc19_.worldCOMy - _loc18_.worldCOMy;
                  _loc24_ = _loc21_ * _loc21_ + _loc22_ * _loc22_;
                  _loc23_ = _loc24_ == 0 ? 0 : (sf32(_loc24_,0), si32(1597463007 - (li32(0) >> 1),0), _loc25_ = lf32(0), 1 / (_loc25_ * (1.5 - 0.5 * _loc24_ * _loc25_ * _loc25_)));
                  _loc20_ = _loc23_ - (_loc18_.radius + _loc19_.radius);
                  if(_loc20_ < _loc8_)
                  {
                     if(_loc23_ == 0)
                     {
                        _loc21_ = 1;
                        _loc22_ = 0;
                     }
                     else
                     {
                        _loc24_ = 1 / _loc23_;
                        _loc21_ *= _loc24_;
                        _loc22_ *= _loc24_;
                     }
                     _loc24_ = _loc18_.radius;
                     _loc16_.x = _loc18_.worldCOMx + _loc21_ * _loc24_;
                     _loc16_.y = _loc18_.worldCOMy + _loc22_ * _loc24_;
                     _loc24_ = -_loc19_.radius;
                     _loc17_.x = _loc19_.worldCOMx + _loc21_ * _loc24_;
                     _loc17_.y = _loc19_.worldCOMy + _loc22_ * _loc24_;
                     _loc7_.x = _loc21_;
                     _loc7_.y = _loc22_;
                  }
                  §§push(_loc20_);
               }
               else
               {
                  _loc26_ = false;
                  if(_loc14_.type == ZPP_Flags.id_ShapeType_CIRCLE && _loc15_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc27_ = _loc14_;
                     _loc14_ = _loc15_;
                     _loc15_ = _loc27_;
                     _loc28_ = _loc16_;
                     _loc16_ = _loc17_;
                     _loc17_ = _loc28_;
                     _loc26_ = true;
                  }
                  if(_loc14_.type == ZPP_Flags.id_ShapeType_POLYGON && _loc15_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc29_ = _loc14_.polygon;
                     _loc18_ = _loc15_.circle;
                     _loc20_ = -1e+100;
                     _loc30_ = null;
                     _loc31_ = _loc29_.edges.head;
                     while(_loc31_ != null)
                     {
                        _loc32_ = _loc31_.elt;
                        _loc21_ = _loc32_.gnormx * _loc18_.worldCOMx + _loc32_.gnormy * _loc18_.worldCOMy - _loc32_.gprojection - _loc18_.radius;
                        if(_loc21_ > _loc8_)
                        {
                           _loc20_ = _loc21_;
                           break;
                        }
                        if(_loc21_ > 0)
                        {
                           if(_loc21_ > _loc20_)
                           {
                              _loc20_ = _loc21_;
                              _loc30_ = _loc32_;
                           }
                        }
                        else if(_loc20_ < 0 && _loc21_ > _loc20_)
                        {
                           _loc20_ = _loc21_;
                           _loc30_ = _loc32_;
                        }
                        _loc31_ = _loc31_.next;
                     }
                     if(_loc20_ < _loc8_)
                     {
                        _loc28_ = _loc30_.gp0;
                        _loc33_ = _loc30_.gp1;
                        _loc21_ = _loc18_.worldCOMy * _loc30_.gnormx - _loc18_.worldCOMx * _loc30_.gnormy;
                        if(_loc21_ <= _loc28_.y * _loc30_.gnormx - _loc28_.x * _loc30_.gnormy)
                        {
                           _loc22_ = 0;
                           _loc23_ = 0;
                           _loc22_ = _loc18_.worldCOMx - _loc28_.x;
                           _loc23_ = _loc18_.worldCOMy - _loc28_.y;
                           _loc25_ = _loc22_ * _loc22_ + _loc23_ * _loc23_;
                           _loc24_ = _loc25_ == 0 ? 0 : (sf32(_loc25_,0), si32(1597463007 - (li32(0) >> 1),0), _loc34_ = lf32(0), 1 / (_loc34_ * (1.5 - 0.5 * _loc25_ * _loc34_ * _loc34_)));
                           _loc20_ = _loc24_ - _loc18_.radius;
                           if(_loc20_ < _loc8_)
                           {
                              if(_loc24_ == 0)
                              {
                                 _loc22_ = 1;
                                 _loc23_ = 0;
                              }
                              else
                              {
                                 _loc25_ = 1 / _loc24_;
                                 _loc22_ *= _loc25_;
                                 _loc23_ *= _loc25_;
                              }
                              _loc35_ = 0;
                              _loc16_.x = _loc28_.x + _loc22_ * _loc35_;
                              _loc16_.y = _loc28_.y + _loc23_ * _loc35_;
                              _loc25_ = -_loc18_.radius;
                              _loc17_.x = _loc18_.worldCOMx + _loc22_ * _loc25_;
                              _loc17_.y = _loc18_.worldCOMy + _loc23_ * _loc25_;
                              _loc7_.x = _loc22_;
                              _loc7_.y = _loc23_;
                           }
                        }
                        else if(_loc21_ >= _loc33_.y * _loc30_.gnormx - _loc33_.x * _loc30_.gnormy)
                        {
                           _loc22_ = 0;
                           _loc23_ = 0;
                           _loc22_ = _loc18_.worldCOMx - _loc33_.x;
                           _loc23_ = _loc18_.worldCOMy - _loc33_.y;
                           _loc25_ = _loc22_ * _loc22_ + _loc23_ * _loc23_;
                           _loc24_ = _loc25_ == 0 ? 0 : (sf32(_loc25_,0), si32(1597463007 - (li32(0) >> 1),0), _loc34_ = lf32(0), 1 / (_loc34_ * (1.5 - 0.5 * _loc25_ * _loc34_ * _loc34_)));
                           _loc20_ = _loc24_ - _loc18_.radius;
                           if(_loc20_ < _loc8_)
                           {
                              if(_loc24_ == 0)
                              {
                                 _loc22_ = 1;
                                 _loc23_ = 0;
                              }
                              else
                              {
                                 _loc25_ = 1 / _loc24_;
                                 _loc22_ *= _loc25_;
                                 _loc23_ *= _loc25_;
                              }
                              _loc35_ = 0;
                              _loc16_.x = _loc33_.x + _loc22_ * _loc35_;
                              _loc16_.y = _loc33_.y + _loc23_ * _loc35_;
                              _loc25_ = -_loc18_.radius;
                              _loc17_.x = _loc18_.worldCOMx + _loc22_ * _loc25_;
                              _loc17_.y = _loc18_.worldCOMy + _loc23_ * _loc25_;
                              _loc7_.x = _loc22_;
                              _loc7_.y = _loc23_;
                           }
                        }
                        else
                        {
                           _loc22_ = -_loc18_.radius;
                           _loc17_.x = _loc18_.worldCOMx + _loc30_.gnormx * _loc22_;
                           _loc17_.y = _loc18_.worldCOMy + _loc30_.gnormy * _loc22_;
                           _loc22_ = -_loc20_;
                           _loc16_.x = _loc17_.x + _loc30_.gnormx * _loc22_;
                           _loc16_.y = _loc17_.y + _loc30_.gnormy * _loc22_;
                           _loc7_.x = _loc30_.gnormx;
                           _loc7_.y = _loc30_.gnormy;
                        }
                     }
                     if(_loc26_)
                     {
                        _loc7_.x = -_loc7_.x;
                        _loc7_.y = -_loc7_.y;
                     }
                     §§push(_loc20_);
                  }
                  else
                  {
                     _loc29_ = _loc14_.polygon;
                     _loc36_ = _loc15_.polygon;
                     _loc20_ = -1e+100;
                     _loc30_ = null;
                     _loc32_ = null;
                     _loc35_ = 0;
                     _loc31_ = _loc29_.edges.head;
                     while(_loc31_ != null)
                     {
                        _loc37_ = _loc31_.elt;
                        _loc21_ = 1e+100;
                        _loc28_ = _loc36_.gverts.next;
                        while(_loc28_ != null)
                        {
                           _loc33_ = _loc28_;
                           _loc22_ = _loc37_.gnormx * _loc33_.x + _loc37_.gnormy * _loc33_.y;
                           if(_loc22_ < _loc21_)
                           {
                              _loc21_ = _loc22_;
                           }
                           _loc28_ = _loc28_.next;
                        }
                        _loc21_ -= _loc37_.gprojection;
                        if(_loc21_ > _loc8_)
                        {
                           _loc20_ = _loc21_;
                           break;
                        }
                        if(_loc21_ > 0)
                        {
                           if(_loc21_ > _loc20_)
                           {
                              _loc20_ = _loc21_;
                              _loc30_ = _loc37_;
                              _loc35_ = 1;
                           }
                        }
                        else if(_loc20_ < 0 && _loc21_ > _loc20_)
                        {
                           _loc20_ = _loc21_;
                           _loc30_ = _loc37_;
                           _loc35_ = 1;
                        }
                        _loc31_ = _loc31_.next;
                     }
                     if(_loc20_ < _loc8_)
                     {
                        _loc31_ = _loc36_.edges.head;
                        while(_loc31_ != null)
                        {
                           _loc37_ = _loc31_.elt;
                           _loc21_ = 1e+100;
                           _loc28_ = _loc29_.gverts.next;
                           while(_loc28_ != null)
                           {
                              _loc33_ = _loc28_;
                              _loc22_ = _loc37_.gnormx * _loc33_.x + _loc37_.gnormy * _loc33_.y;
                              if(_loc22_ < _loc21_)
                              {
                                 _loc21_ = _loc22_;
                              }
                              _loc28_ = _loc28_.next;
                           }
                           _loc21_ -= _loc37_.gprojection;
                           if(_loc21_ > _loc8_)
                           {
                              _loc20_ = _loc21_;
                              break;
                           }
                           if(_loc21_ > 0)
                           {
                              if(_loc21_ > _loc20_)
                              {
                                 _loc20_ = _loc21_;
                                 _loc32_ = _loc37_;
                                 _loc35_ = 2;
                              }
                           }
                           else if(_loc20_ < 0 && _loc21_ > _loc20_)
                           {
                              _loc20_ = _loc21_;
                              _loc32_ = _loc37_;
                              _loc35_ = 2;
                           }
                           _loc31_ = _loc31_.next;
                        }
                        if(_loc20_ < _loc8_)
                        {
                           if(_loc35_ == 1)
                           {
                              _loc38_ = _loc29_;
                              _loc39_ = _loc36_;
                              _loc37_ = _loc30_;
                           }
                           else
                           {
                              _loc38_ = _loc36_;
                              _loc39_ = _loc29_;
                              _loc37_ = _loc32_;
                              _loc28_ = _loc16_;
                              _loc16_ = _loc17_;
                              _loc17_ = _loc28_;
                              _loc26_ = !_loc26_;
                           }
                           _loc40_ = null;
                           _loc21_ = 1e+100;
                           _loc31_ = _loc39_.edges.head;
                           while(_loc31_ != null)
                           {
                              _loc41_ = _loc31_.elt;
                              _loc22_ = _loc37_.gnormx * _loc41_.gnormx + _loc37_.gnormy * _loc41_.gnormy;
                              if(_loc22_ < _loc21_)
                              {
                                 _loc21_ = _loc22_;
                                 _loc40_ = _loc41_;
                              }
                              _loc31_ = _loc31_.next;
                           }
                           if(_loc26_)
                           {
                              _loc7_.x = -_loc37_.gnormx;
                              _loc7_.y = -_loc37_.gnormy;
                           }
                           else
                           {
                              _loc7_.x = _loc37_.gnormx;
                              _loc7_.y = _loc37_.gnormy;
                           }
                           if(_loc20_ >= 0)
                           {
                              _loc28_ = _loc37_.gp0;
                              _loc33_ = _loc37_.gp1;
                              _loc42_ = _loc40_.gp0;
                              _loc43_ = _loc40_.gp1;
                              _loc22_ = 0;
                              _loc23_ = 0;
                              _loc24_ = 0;
                              _loc25_ = 0;
                              _loc22_ = _loc33_.x - _loc28_.x;
                              _loc23_ = _loc33_.y - _loc28_.y;
                              _loc24_ = _loc43_.x - _loc42_.x;
                              _loc25_ = _loc43_.y - _loc42_.y;
                              _loc34_ = 1 / (_loc22_ * _loc22_ + _loc23_ * _loc23_);
                              _loc44_ = 1 / (_loc24_ * _loc24_ + _loc25_ * _loc25_);
                              _loc45_ = -(_loc22_ * (_loc28_.x - _loc42_.x) + _loc23_ * (_loc28_.y - _loc42_.y)) * _loc34_;
                              _loc46_ = -(_loc22_ * (_loc28_.x - _loc43_.x) + _loc23_ * (_loc28_.y - _loc43_.y)) * _loc34_;
                              _loc47_ = -(_loc24_ * (_loc42_.x - _loc28_.x) + _loc25_ * (_loc42_.y - _loc28_.y)) * _loc44_;
                              _loc48_ = -(_loc24_ * (_loc42_.x - _loc33_.x) + _loc25_ * (_loc42_.y - _loc33_.y)) * _loc44_;
                              if(_loc45_ < 0)
                              {
                                 _loc45_ = 0;
                              }
                              else if(_loc45_ > 1)
                              {
                                 _loc45_ = 1;
                              }
                              if(_loc46_ < 0)
                              {
                                 _loc46_ = 0;
                              }
                              else if(_loc46_ > 1)
                              {
                                 _loc46_ = 1;
                              }
                              if(_loc47_ < 0)
                              {
                                 _loc47_ = 0;
                              }
                              else if(_loc47_ > 1)
                              {
                                 _loc47_ = 1;
                              }
                              if(_loc48_ < 0)
                              {
                                 _loc48_ = 0;
                              }
                              else if(_loc48_ > 1)
                              {
                                 _loc48_ = 1;
                              }
                              _loc49_ = 0;
                              _loc50_ = 0;
                              _loc51_ = _loc45_;
                              _loc49_ = _loc28_.x + _loc22_ * _loc51_;
                              _loc50_ = _loc28_.y + _loc23_ * _loc51_;
                              _loc51_ = 0;
                              _loc52_ = 0;
                              _loc53_ = _loc46_;
                              _loc51_ = _loc28_.x + _loc22_ * _loc53_;
                              _loc52_ = _loc28_.y + _loc23_ * _loc53_;
                              _loc53_ = 0;
                              _loc54_ = 0;
                              _loc55_ = _loc47_;
                              _loc53_ = _loc42_.x + _loc24_ * _loc55_;
                              _loc54_ = _loc42_.y + _loc25_ * _loc55_;
                              _loc55_ = 0;
                              _loc56_ = 0;
                              _loc57_ = _loc48_;
                              _loc55_ = _loc42_.x + _loc24_ * _loc57_;
                              _loc56_ = _loc42_.y + _loc25_ * _loc57_;
                              _loc58_ = 0;
                              _loc59_ = 0;
                              _loc58_ = _loc49_ - _loc42_.x;
                              _loc59_ = _loc50_ - _loc42_.y;
                              _loc57_ = _loc58_ * _loc58_ + _loc59_ * _loc59_;
                              _loc59_ = 0;
                              _loc60_ = 0;
                              _loc59_ = _loc51_ - _loc43_.x;
                              _loc60_ = _loc52_ - _loc43_.y;
                              _loc58_ = _loc59_ * _loc59_ + _loc60_ * _loc60_;
                              _loc60_ = 0;
                              _loc61_ = 0;
                              _loc60_ = _loc53_ - _loc28_.x;
                              _loc61_ = _loc54_ - _loc28_.y;
                              _loc59_ = _loc60_ * _loc60_ + _loc61_ * _loc61_;
                              _loc61_ = 0;
                              _loc62_ = 0;
                              _loc61_ = _loc55_ - _loc33_.x;
                              _loc62_ = _loc56_ - _loc33_.y;
                              _loc60_ = _loc61_ * _loc61_ + _loc62_ * _loc62_;
                              _loc61_ = 0;
                              _loc62_ = 0;
                              _loc63_ = null;
                              if(_loc57_ < _loc58_)
                              {
                                 _loc61_ = _loc49_;
                                 _loc62_ = _loc50_;
                                 _loc63_ = _loc42_;
                              }
                              else
                              {
                                 _loc61_ = _loc51_;
                                 _loc62_ = _loc52_;
                                 _loc63_ = _loc43_;
                                 _loc57_ = _loc58_;
                              }
                              _loc64_ = 0;
                              _loc65_ = 0;
                              _loc66_ = null;
                              if(_loc59_ < _loc60_)
                              {
                                 _loc64_ = _loc53_;
                                 _loc65_ = _loc54_;
                                 _loc66_ = _loc28_;
                              }
                              else
                              {
                                 _loc64_ = _loc55_;
                                 _loc65_ = _loc56_;
                                 _loc66_ = _loc33_;
                                 _loc59_ = _loc60_;
                              }
                              if(_loc57_ < _loc59_)
                              {
                                 _loc16_.x = _loc61_;
                                 _loc16_.y = _loc62_;
                                 _loc17_.x = _loc63_.x;
                                 _loc17_.y = _loc63_.y;
                                 _loc20_ = Math.sqrt(_loc57_);
                              }
                              else
                              {
                                 _loc17_.x = _loc64_;
                                 _loc17_.y = _loc65_;
                                 _loc16_.x = _loc66_.x;
                                 _loc16_.y = _loc66_.y;
                                 _loc20_ = Math.sqrt(_loc59_);
                              }
                              if(_loc20_ != 0)
                              {
                                 _loc7_.x = _loc17_.x - _loc16_.x;
                                 _loc7_.y = _loc17_.y - _loc16_.y;
                                 _loc67_ = 1 / _loc20_;
                                 _loc7_.x *= _loc67_;
                                 _loc7_.y *= _loc67_;
                                 if(_loc26_)
                                 {
                                    _loc7_.x = -_loc7_.x;
                                    _loc7_.y = -_loc7_.y;
                                 }
                              }
                              §§push(_loc20_);
                           }
                           else
                           {
                              _loc22_ = 0;
                              _loc23_ = 0;
                              _loc22_ = _loc40_.gp0.x;
                              _loc23_ = _loc40_.gp0.y;
                              _loc24_ = 0;
                              _loc25_ = 0;
                              _loc24_ = _loc40_.gp1.x;
                              _loc25_ = _loc40_.gp1.y;
                              _loc34_ = 0;
                              _loc44_ = 0;
                              _loc34_ = _loc24_ - _loc22_;
                              _loc44_ = _loc25_ - _loc23_;
                              _loc45_ = _loc37_.gnormy * _loc22_ - _loc37_.gnormx * _loc23_;
                              _loc46_ = _loc37_.gnormy * _loc24_ - _loc37_.gnormx * _loc25_;
                              _loc47_ = 1 / (_loc46_ - _loc45_);
                              _loc48_ = (-_loc37_.tp1 - _loc45_) * _loc47_;
                              if(_loc48_ > Config.epsilon)
                              {
                                 _loc49_ = _loc48_;
                                 _loc22_ += _loc34_ * _loc49_;
                                 _loc23_ += _loc44_ * _loc49_;
                              }
                              _loc49_ = (-_loc37_.tp0 - _loc46_) * _loc47_;
                              if(_loc49_ < -Config.epsilon)
                              {
                                 _loc50_ = _loc49_;
                                 _loc24_ += _loc34_ * _loc50_;
                                 _loc25_ += _loc44_ * _loc50_;
                              }
                              _loc50_ = _loc22_ * _loc37_.gnormx + _loc23_ * _loc37_.gnormy - _loc37_.gprojection;
                              _loc51_ = _loc24_ * _loc37_.gnormx + _loc25_ * _loc37_.gnormy - _loc37_.gprojection;
                              §§push(_loc50_ < _loc51_ ? (_loc17_.x = _loc22_, _loc17_.y = _loc23_, _loc52_ = -_loc50_, _loc16_.x = _loc17_.x + _loc37_.gnormx * _loc52_, _loc16_.y = _loc17_.y + _loc37_.gnormy * _loc52_, _loc50_) : (_loc17_.x = _loc24_, _loc17_.y = _loc25_, _loc52_ = -_loc51_, _loc16_.x = _loc17_.x + _loc37_.gnormx * _loc52_, _loc16_.y = _loc17_.y + _loc37_.gnormy * _loc52_, _loc51_));
                           }
                        }
                        else
                        {
                           §§push(_loc8_);
                        }
                     }
                     else
                     {
                        §§push(_loc8_);
                     }
                  }
               }
               _loc13_ = §§pop();
               if(_loc13_ < _loc8_)
               {
                  _loc8_ = _loc13_;
                  param3.x = _loc5_.x;
                  param3.y = _loc5_.y;
                  param4.x = _loc6_.x;
                  param4.y = _loc6_.y;
               }
               _loc11_ = _loc11_.next;
            }
            _loc9_ = _loc9_.next;
         }
         _loc16_ = _loc5_;
         if(_loc16_.outer != null)
         {
            _loc16_.outer.zpp_inner = null;
            _loc16_.outer = null;
         }
         _loc16_._isimmutable = null;
         _loc16_._validate = null;
         _loc16_._invalidate = null;
         _loc16_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc16_;
         _loc16_ = _loc6_;
         if(_loc16_.outer != null)
         {
            _loc16_.outer.zpp_inner = null;
            _loc16_.outer = null;
         }
         _loc16_._isimmutable = null;
         _loc16_._validate = null;
         _loc16_._invalidate = null;
         _loc16_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc16_;
         return _loc8_;
      }
      
      public static function distance(param1:ZPP_Shape, param2:ZPP_Shape, param3:ZPP_Vec2, param4:ZPP_Vec2, param5:ZPP_Vec2, param6:Number = 1e+100) : Number
      {
         var _loc7_:* = null as ZPP_Circle;
         var _loc8_:* = null as ZPP_Circle;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Boolean = false;
         var _loc16_:* = null as ZPP_Shape;
         var _loc17_:* = null as ZPP_Vec2;
         var _loc18_:* = null as ZPP_Polygon;
         var _loc19_:* = null as ZPP_Edge;
         var _loc20_:* = null as ZNPNode_ZPP_Edge;
         var _loc21_:* = null as ZPP_Edge;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:Number = NaN;
         var _loc24_:int = 0;
         var _loc25_:* = null as ZPP_Polygon;
         var _loc26_:* = null as ZPP_Edge;
         var _loc27_:* = null as ZPP_Polygon;
         var _loc28_:* = null as ZPP_Polygon;
         var _loc29_:* = null as ZPP_Edge;
         var _loc30_:* = null as ZPP_Edge;
         var _loc31_:* = null as ZPP_Vec2;
         var _loc32_:* = null as ZPP_Vec2;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc47_:Number = NaN;
         var _loc48_:Number = NaN;
         var _loc49_:Number = NaN;
         var _loc50_:Number = NaN;
         var _loc51_:Number = NaN;
         var _loc52_:* = null as ZPP_Vec2;
         var _loc53_:Number = NaN;
         var _loc54_:Number = NaN;
         var _loc55_:* = null as ZPP_Vec2;
         var _loc56_:Number = NaN;
         if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE && param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            _loc7_ = param1.circle;
            _loc8_ = param2.circle;
            _loc10_ = 0;
            _loc11_ = 0;
            _loc10_ = _loc8_.worldCOMx - _loc7_.worldCOMx;
            _loc11_ = _loc8_.worldCOMy - _loc7_.worldCOMy;
            _loc13_ = _loc10_ * _loc10_ + _loc11_ * _loc11_;
            _loc12_ = _loc13_ == 0 ? 0 : (sf32(_loc13_,0), si32(1597463007 - (li32(0) >> 1),0), _loc14_ = lf32(0), 1 / (_loc14_ * (1.5 - 0.5 * _loc13_ * _loc14_ * _loc14_)));
            _loc9_ = _loc12_ - (_loc7_.radius + _loc8_.radius);
            if(_loc9_ < param6)
            {
               if(_loc12_ == 0)
               {
                  _loc10_ = 1;
                  _loc11_ = 0;
               }
               else
               {
                  _loc13_ = 1 / _loc12_;
                  _loc10_ *= _loc13_;
                  _loc11_ *= _loc13_;
               }
               _loc13_ = _loc7_.radius;
               param3.x = _loc7_.worldCOMx + _loc10_ * _loc13_;
               param3.y = _loc7_.worldCOMy + _loc11_ * _loc13_;
               _loc13_ = -_loc8_.radius;
               param4.x = _loc8_.worldCOMx + _loc10_ * _loc13_;
               param4.y = _loc8_.worldCOMy + _loc11_ * _loc13_;
               param5.x = _loc10_;
               param5.y = _loc11_;
            }
            return _loc9_;
         }
         _loc15_ = false;
         if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE && param2.type == ZPP_Flags.id_ShapeType_POLYGON)
         {
            _loc16_ = param1;
            param1 = param2;
            param2 = _loc16_;
            _loc17_ = param3;
            param3 = param4;
            param4 = _loc17_;
            _loc15_ = true;
         }
         if(param1.type == ZPP_Flags.id_ShapeType_POLYGON && param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            _loc18_ = param1.polygon;
            _loc7_ = param2.circle;
            _loc9_ = -1e+100;
            _loc19_ = null;
            _loc20_ = _loc18_.edges.head;
            while(_loc20_ != null)
            {
               _loc21_ = _loc20_.elt;
               _loc10_ = _loc21_.gnormx * _loc7_.worldCOMx + _loc21_.gnormy * _loc7_.worldCOMy - _loc21_.gprojection - _loc7_.radius;
               if(_loc10_ > param6)
               {
                  _loc9_ = _loc10_;
                  break;
               }
               if(_loc10_ > 0)
               {
                  if(_loc10_ > _loc9_)
                  {
                     _loc9_ = _loc10_;
                     _loc19_ = _loc21_;
                  }
               }
               else if(_loc9_ < 0 && _loc10_ > _loc9_)
               {
                  _loc9_ = _loc10_;
                  _loc19_ = _loc21_;
               }
               _loc20_ = _loc20_.next;
            }
            if(_loc9_ < param6)
            {
               _loc17_ = _loc19_.gp0;
               _loc22_ = _loc19_.gp1;
               _loc10_ = _loc7_.worldCOMy * _loc19_.gnormx - _loc7_.worldCOMx * _loc19_.gnormy;
               if(_loc10_ <= _loc17_.y * _loc19_.gnormx - _loc17_.x * _loc19_.gnormy)
               {
                  _loc11_ = 0;
                  _loc12_ = 0;
                  _loc11_ = _loc7_.worldCOMx - _loc17_.x;
                  _loc12_ = _loc7_.worldCOMy - _loc17_.y;
                  _loc14_ = _loc11_ * _loc11_ + _loc12_ * _loc12_;
                  _loc13_ = _loc14_ == 0 ? 0 : (sf32(_loc14_,0), si32(1597463007 - (li32(0) >> 1),0), _loc23_ = lf32(0), 1 / (_loc23_ * (1.5 - 0.5 * _loc14_ * _loc23_ * _loc23_)));
                  _loc9_ = _loc13_ - _loc7_.radius;
                  if(_loc9_ < param6)
                  {
                     if(_loc13_ == 0)
                     {
                        _loc11_ = 1;
                        _loc12_ = 0;
                     }
                     else
                     {
                        _loc14_ = 1 / _loc13_;
                        _loc11_ *= _loc14_;
                        _loc12_ *= _loc14_;
                     }
                     _loc24_ = 0;
                     param3.x = _loc17_.x + _loc11_ * _loc24_;
                     param3.y = _loc17_.y + _loc12_ * _loc24_;
                     _loc14_ = -_loc7_.radius;
                     param4.x = _loc7_.worldCOMx + _loc11_ * _loc14_;
                     param4.y = _loc7_.worldCOMy + _loc12_ * _loc14_;
                     param5.x = _loc11_;
                     param5.y = _loc12_;
                  }
               }
               else if(_loc10_ >= _loc22_.y * _loc19_.gnormx - _loc22_.x * _loc19_.gnormy)
               {
                  _loc11_ = 0;
                  _loc12_ = 0;
                  _loc11_ = _loc7_.worldCOMx - _loc22_.x;
                  _loc12_ = _loc7_.worldCOMy - _loc22_.y;
                  _loc14_ = _loc11_ * _loc11_ + _loc12_ * _loc12_;
                  _loc13_ = _loc14_ == 0 ? 0 : (sf32(_loc14_,0), si32(1597463007 - (li32(0) >> 1),0), _loc23_ = lf32(0), 1 / (_loc23_ * (1.5 - 0.5 * _loc14_ * _loc23_ * _loc23_)));
                  _loc9_ = _loc13_ - _loc7_.radius;
                  if(_loc9_ < param6)
                  {
                     if(_loc13_ == 0)
                     {
                        _loc11_ = 1;
                        _loc12_ = 0;
                     }
                     else
                     {
                        _loc14_ = 1 / _loc13_;
                        _loc11_ *= _loc14_;
                        _loc12_ *= _loc14_;
                     }
                     _loc24_ = 0;
                     param3.x = _loc22_.x + _loc11_ * _loc24_;
                     param3.y = _loc22_.y + _loc12_ * _loc24_;
                     _loc14_ = -_loc7_.radius;
                     param4.x = _loc7_.worldCOMx + _loc11_ * _loc14_;
                     param4.y = _loc7_.worldCOMy + _loc12_ * _loc14_;
                     param5.x = _loc11_;
                     param5.y = _loc12_;
                  }
               }
               else
               {
                  _loc11_ = -_loc7_.radius;
                  param4.x = _loc7_.worldCOMx + _loc19_.gnormx * _loc11_;
                  param4.y = _loc7_.worldCOMy + _loc19_.gnormy * _loc11_;
                  _loc11_ = -_loc9_;
                  param3.x = param4.x + _loc19_.gnormx * _loc11_;
                  param3.y = param4.y + _loc19_.gnormy * _loc11_;
                  param5.x = _loc19_.gnormx;
                  param5.y = _loc19_.gnormy;
               }
            }
            if(_loc15_)
            {
               param5.x = -param5.x;
               param5.y = -param5.y;
            }
            return _loc9_;
         }
         _loc18_ = param1.polygon;
         _loc25_ = param2.polygon;
         _loc9_ = -1e+100;
         _loc19_ = null;
         _loc21_ = null;
         _loc24_ = 0;
         _loc20_ = _loc18_.edges.head;
         while(_loc20_ != null)
         {
            _loc26_ = _loc20_.elt;
            _loc10_ = 1e+100;
            _loc17_ = _loc25_.gverts.next;
            while(_loc17_ != null)
            {
               _loc22_ = _loc17_;
               _loc11_ = _loc26_.gnormx * _loc22_.x + _loc26_.gnormy * _loc22_.y;
               if(_loc11_ < _loc10_)
               {
                  _loc10_ = _loc11_;
               }
               _loc17_ = _loc17_.next;
            }
            _loc10_ -= _loc26_.gprojection;
            if(_loc10_ > param6)
            {
               _loc9_ = _loc10_;
               break;
            }
            if(_loc10_ > 0)
            {
               if(_loc10_ > _loc9_)
               {
                  _loc9_ = _loc10_;
                  _loc19_ = _loc26_;
                  _loc24_ = 1;
               }
            }
            else if(_loc9_ < 0 && _loc10_ > _loc9_)
            {
               _loc9_ = _loc10_;
               _loc19_ = _loc26_;
               _loc24_ = 1;
            }
            _loc20_ = _loc20_.next;
         }
         if(_loc9_ < param6)
         {
            _loc20_ = _loc25_.edges.head;
            while(_loc20_ != null)
            {
               _loc26_ = _loc20_.elt;
               _loc10_ = 1e+100;
               _loc17_ = _loc18_.gverts.next;
               while(_loc17_ != null)
               {
                  _loc22_ = _loc17_;
                  _loc11_ = _loc26_.gnormx * _loc22_.x + _loc26_.gnormy * _loc22_.y;
                  if(_loc11_ < _loc10_)
                  {
                     _loc10_ = _loc11_;
                  }
                  _loc17_ = _loc17_.next;
               }
               _loc10_ -= _loc26_.gprojection;
               if(_loc10_ > param6)
               {
                  _loc9_ = _loc10_;
                  break;
               }
               if(_loc10_ > 0)
               {
                  if(_loc10_ > _loc9_)
                  {
                     _loc9_ = _loc10_;
                     _loc21_ = _loc26_;
                     _loc24_ = 2;
                  }
               }
               else if(_loc9_ < 0 && _loc10_ > _loc9_)
               {
                  _loc9_ = _loc10_;
                  _loc21_ = _loc26_;
                  _loc24_ = 2;
               }
               _loc20_ = _loc20_.next;
            }
            if(_loc9_ < param6)
            {
               if(_loc24_ == 1)
               {
                  _loc27_ = _loc18_;
                  _loc28_ = _loc25_;
                  _loc26_ = _loc19_;
               }
               else
               {
                  _loc27_ = _loc25_;
                  _loc28_ = _loc18_;
                  _loc26_ = _loc21_;
                  _loc17_ = param3;
                  param3 = param4;
                  param4 = _loc17_;
                  _loc15_ = !_loc15_;
               }
               _loc29_ = null;
               _loc10_ = 1e+100;
               _loc20_ = _loc28_.edges.head;
               while(_loc20_ != null)
               {
                  _loc30_ = _loc20_.elt;
                  _loc11_ = _loc26_.gnormx * _loc30_.gnormx + _loc26_.gnormy * _loc30_.gnormy;
                  if(_loc11_ < _loc10_)
                  {
                     _loc10_ = _loc11_;
                     _loc29_ = _loc30_;
                  }
                  _loc20_ = _loc20_.next;
               }
               if(_loc15_)
               {
                  param5.x = -_loc26_.gnormx;
                  param5.y = -_loc26_.gnormy;
               }
               else
               {
                  param5.x = _loc26_.gnormx;
                  param5.y = _loc26_.gnormy;
               }
               if(_loc9_ >= 0)
               {
                  _loc17_ = _loc26_.gp0;
                  _loc22_ = _loc26_.gp1;
                  _loc31_ = _loc29_.gp0;
                  _loc32_ = _loc29_.gp1;
                  _loc11_ = 0;
                  _loc12_ = 0;
                  _loc13_ = 0;
                  _loc14_ = 0;
                  _loc11_ = _loc22_.x - _loc17_.x;
                  _loc12_ = _loc22_.y - _loc17_.y;
                  _loc13_ = _loc32_.x - _loc31_.x;
                  _loc14_ = _loc32_.y - _loc31_.y;
                  _loc23_ = 1 / (_loc11_ * _loc11_ + _loc12_ * _loc12_);
                  _loc33_ = 1 / (_loc13_ * _loc13_ + _loc14_ * _loc14_);
                  _loc34_ = -(_loc11_ * (_loc17_.x - _loc31_.x) + _loc12_ * (_loc17_.y - _loc31_.y)) * _loc23_;
                  _loc35_ = -(_loc11_ * (_loc17_.x - _loc32_.x) + _loc12_ * (_loc17_.y - _loc32_.y)) * _loc23_;
                  _loc36_ = -(_loc13_ * (_loc31_.x - _loc17_.x) + _loc14_ * (_loc31_.y - _loc17_.y)) * _loc33_;
                  _loc37_ = -(_loc13_ * (_loc31_.x - _loc22_.x) + _loc14_ * (_loc31_.y - _loc22_.y)) * _loc33_;
                  if(_loc34_ < 0)
                  {
                     _loc34_ = 0;
                  }
                  else if(_loc34_ > 1)
                  {
                     _loc34_ = 1;
                  }
                  if(_loc35_ < 0)
                  {
                     _loc35_ = 0;
                  }
                  else if(_loc35_ > 1)
                  {
                     _loc35_ = 1;
                  }
                  if(_loc36_ < 0)
                  {
                     _loc36_ = 0;
                  }
                  else if(_loc36_ > 1)
                  {
                     _loc36_ = 1;
                  }
                  if(_loc37_ < 0)
                  {
                     _loc37_ = 0;
                  }
                  else if(_loc37_ > 1)
                  {
                     _loc37_ = 1;
                  }
                  _loc38_ = 0;
                  _loc39_ = 0;
                  _loc40_ = _loc34_;
                  _loc38_ = _loc17_.x + _loc11_ * _loc40_;
                  _loc39_ = _loc17_.y + _loc12_ * _loc40_;
                  _loc40_ = 0;
                  _loc41_ = 0;
                  _loc42_ = _loc35_;
                  _loc40_ = _loc17_.x + _loc11_ * _loc42_;
                  _loc41_ = _loc17_.y + _loc12_ * _loc42_;
                  _loc42_ = 0;
                  _loc43_ = 0;
                  _loc44_ = _loc36_;
                  _loc42_ = _loc31_.x + _loc13_ * _loc44_;
                  _loc43_ = _loc31_.y + _loc14_ * _loc44_;
                  _loc44_ = 0;
                  _loc45_ = 0;
                  _loc46_ = _loc37_;
                  _loc44_ = _loc31_.x + _loc13_ * _loc46_;
                  _loc45_ = _loc31_.y + _loc14_ * _loc46_;
                  _loc47_ = 0;
                  _loc48_ = 0;
                  _loc47_ = _loc38_ - _loc31_.x;
                  _loc48_ = _loc39_ - _loc31_.y;
                  _loc46_ = _loc47_ * _loc47_ + _loc48_ * _loc48_;
                  _loc48_ = 0;
                  _loc49_ = 0;
                  _loc48_ = _loc40_ - _loc32_.x;
                  _loc49_ = _loc41_ - _loc32_.y;
                  _loc47_ = _loc48_ * _loc48_ + _loc49_ * _loc49_;
                  _loc49_ = 0;
                  _loc50_ = 0;
                  _loc49_ = _loc42_ - _loc17_.x;
                  _loc50_ = _loc43_ - _loc17_.y;
                  _loc48_ = _loc49_ * _loc49_ + _loc50_ * _loc50_;
                  _loc50_ = 0;
                  _loc51_ = 0;
                  _loc50_ = _loc44_ - _loc22_.x;
                  _loc51_ = _loc45_ - _loc22_.y;
                  _loc49_ = _loc50_ * _loc50_ + _loc51_ * _loc51_;
                  _loc50_ = 0;
                  _loc51_ = 0;
                  _loc52_ = null;
                  if(_loc46_ < _loc47_)
                  {
                     _loc50_ = _loc38_;
                     _loc51_ = _loc39_;
                     _loc52_ = _loc31_;
                  }
                  else
                  {
                     _loc50_ = _loc40_;
                     _loc51_ = _loc41_;
                     _loc52_ = _loc32_;
                     _loc46_ = _loc47_;
                  }
                  _loc53_ = 0;
                  _loc54_ = 0;
                  _loc55_ = null;
                  if(_loc48_ < _loc49_)
                  {
                     _loc53_ = _loc42_;
                     _loc54_ = _loc43_;
                     _loc55_ = _loc17_;
                  }
                  else
                  {
                     _loc53_ = _loc44_;
                     _loc54_ = _loc45_;
                     _loc55_ = _loc22_;
                     _loc48_ = _loc49_;
                  }
                  if(_loc46_ < _loc48_)
                  {
                     param3.x = _loc50_;
                     param3.y = _loc51_;
                     param4.x = _loc52_.x;
                     param4.y = _loc52_.y;
                     _loc9_ = Math.sqrt(_loc46_);
                  }
                  else
                  {
                     param4.x = _loc53_;
                     param4.y = _loc54_;
                     param3.x = _loc55_.x;
                     param3.y = _loc55_.y;
                     _loc9_ = Math.sqrt(_loc48_);
                  }
                  if(_loc9_ != 0)
                  {
                     param5.x = param4.x - param3.x;
                     param5.y = param4.y - param3.y;
                     _loc56_ = 1 / _loc9_;
                     param5.x *= _loc56_;
                     param5.y *= _loc56_;
                     if(_loc15_)
                     {
                        param5.x = -param5.x;
                        param5.y = -param5.y;
                     }
                  }
                  return _loc9_;
               }
               _loc11_ = 0;
               _loc12_ = 0;
               _loc11_ = _loc29_.gp0.x;
               _loc12_ = _loc29_.gp0.y;
               _loc13_ = 0;
               _loc14_ = 0;
               _loc13_ = _loc29_.gp1.x;
               _loc14_ = _loc29_.gp1.y;
               _loc23_ = 0;
               _loc33_ = 0;
               _loc23_ = _loc13_ - _loc11_;
               _loc33_ = _loc14_ - _loc12_;
               _loc34_ = _loc26_.gnormy * _loc11_ - _loc26_.gnormx * _loc12_;
               _loc35_ = _loc26_.gnormy * _loc13_ - _loc26_.gnormx * _loc14_;
               _loc36_ = 1 / (_loc35_ - _loc34_);
               _loc37_ = (-_loc26_.tp1 - _loc34_) * _loc36_;
               if(_loc37_ > Config.epsilon)
               {
                  _loc38_ = _loc37_;
                  _loc11_ += _loc23_ * _loc38_;
                  _loc12_ += _loc33_ * _loc38_;
               }
               _loc38_ = (-_loc26_.tp0 - _loc35_) * _loc36_;
               if(_loc38_ < -Config.epsilon)
               {
                  _loc39_ = _loc38_;
                  _loc13_ += _loc23_ * _loc39_;
                  _loc14_ += _loc33_ * _loc39_;
               }
               _loc39_ = _loc11_ * _loc26_.gnormx + _loc12_ * _loc26_.gnormy - _loc26_.gprojection;
               _loc40_ = _loc13_ * _loc26_.gnormx + _loc14_ * _loc26_.gnormy - _loc26_.gprojection;
               if(_loc39_ < _loc40_)
               {
                  param4.x = _loc11_;
                  param4.y = _loc12_;
                  _loc41_ = -_loc39_;
                  param3.x = param4.x + _loc26_.gnormx * _loc41_;
                  param3.y = param4.y + _loc26_.gnormy * _loc41_;
                  return _loc39_;
               }
               param4.x = _loc13_;
               param4.y = _loc14_;
               _loc41_ = -_loc40_;
               param3.x = param4.x + _loc26_.gnormx * _loc41_;
               param3.y = param4.y + _loc26_.gnormy * _loc41_;
               return _loc40_;
            }
            return param6;
         }
         return param6;
      }
   }
}

