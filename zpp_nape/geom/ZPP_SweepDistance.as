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
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 6206
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      public static function staticSweep(param1:ZPP_ToiEvent, param2:Number, param3:Number, param4:Number) : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 5194
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      public static function distanceBody(param1:ZPP_Body, param2:ZPP_Body, param3:ZPP_Vec2, param4:ZPP_Vec2) : Number
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 2310
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
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
