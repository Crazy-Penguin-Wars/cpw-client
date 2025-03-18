package nape.util
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import flash.display.Graphics;
   import nape.constraint.Constraint;
   import nape.geom.AABB;
   import nape.geom.GeomPoly;
   import nape.geom.Vec2;
   import nape.geom.Vec2Iterator;
   import nape.geom.Vec2List;
   import nape.phys.Body;
   import nape.phys.Compound;
   import nape.shape.Shape;
   import nape.space.Space;
   import zpp_nape.ZPP_Const;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZNPList_ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_Debug;
   import zpp_nape.util.ZPP_PubPool;
   import zpp_nape.util.ZPP_ShapeDebug;
   
   public final class ShapeDebug extends Debug
   {
      public var zpp_inner_zn:ZPP_ShapeDebug;
      
      public var thickness:Number;
      
      public function ShapeDebug(param1:int, param2:int, param3:int = 3355443)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         thickness = 0;
         zpp_inner_zn = null;
         if(param1 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Debug width must be > 0";
         }
         if(param2 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Debug height must be > 0";
         }
         ZPP_Debug.§internal§ = true;
         super();
         ZPP_Debug.§internal§ = false;
         zpp_inner_zn = new ZPP_ShapeDebug(param1,param2);
         zpp_inner_zn.outer_zn = this;
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
         if(zpp_inner.isbmp)
         {
            zpp_inner.d_bmp.setbg(param3);
         }
         else
         {
            zpp_inner.d_shape.setbg(param3);
         }
         zpp_inner.bg_col;
         thickness = 0.1;
      }
      
      override public function drawSpring(param1:Vec2, param2:Vec2, param3:int, param4:int = 3, param5:Number = 3) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as Vec2;
         var _loc15_:Boolean = false;
         var _loc16_:* = null as Vec2;
         var _loc17_:Boolean = false;
         var _loc18_:* = null as Vec2;
         var _loc19_:* = null as Vec2;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::start cannot be null";
         }
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::end cannot be null";
         }
         if(param4 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::coils must be >= 0";
         }
         if(param4 == 0)
         {
            drawLine(param1,param2,param3);
         }
         else
         {
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param2.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            §§push(param2.zpp_inner.x);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc6_ = §§pop() - param1.zpp_inner.x;
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param2.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            §§push(param2.zpp_inner.y);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc8_ = §§pop() - param1.zpp_inner.y;
            _loc9_ = 1 / (param4 * 4);
            _loc6_ *= _loc9_;
            _loc8_ *= _loc9_;
            _loc9_ = 0;
            _loc10_ = 0;
            _loc9_ = _loc6_;
            _loc10_ = _loc8_;
            if(_loc9_ * _loc9_ + _loc10_ * _loc10_ < 0.1)
            {
               return;
            }
            _loc11_ = _loc9_ * _loc9_ + _loc10_ * _loc10_;
            sf32(_loc11_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc13_ = lf32(0);
            _loc12_ = _loc13_ * (1.5 - 0.5 * _loc11_ * _loc13_ * _loc13_);
            _loc13_ = _loc12_;
            _loc9_ *= _loc13_;
            _loc10_ *= _loc13_;
            _loc11_ = _loc9_;
            _loc9_ = -_loc10_;
            _loc10_ = _loc11_;
            _loc11_ = param5 * 2;
            _loc9_ *= _loc11_;
            _loc10_ *= _loc11_;
            _loc15_ = false;
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc11_ = param1.zpp_inner.x;
            if(param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc12_ = param1.zpp_inner.y;
            if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc16_ = new Vec2();
            }
            else
            {
               _loc16_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc16_.zpp_pool;
               _loc16_.zpp_pool = null;
               _loc16_.zpp_disp = false;
               if(_loc16_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc16_.zpp_inner == null)
            {
               _loc17_ = false;
               §§push(_loc16_);
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
               _loc7_._immutable = _loc17_;
               _loc7_.x = _loc11_;
               _loc7_.y = _loc12_;
               §§pop().zpp_inner = _loc7_;
               _loc16_.zpp_inner.outer = _loc16_;
            }
            else
            {
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.x == _loc11_)
               {
                  §§pop();
                  if(_loc16_ != null && _loc16_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  §§push(_loc16_.zpp_inner.y == _loc12_);
               }
               if(!§§pop())
               {
                  _loc16_.zpp_inner.x = _loc11_;
                  _loc16_.zpp_inner.y = _loc12_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc16_;
            }
            _loc16_.zpp_inner.weak = _loc15_;
            _loc14_ = _loc16_;
            _loc11_ = 0;
            _loc12_ = 0;
            _loc15_ = false;
            if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc18_ = new Vec2();
            }
            else
            {
               _loc18_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc18_.zpp_pool;
               _loc18_.zpp_pool = null;
               _loc18_.zpp_disp = false;
               if(_loc18_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc18_.zpp_inner == null)
            {
               _loc17_ = false;
               §§push(_loc18_);
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
               _loc7_._immutable = _loc17_;
               _loc7_.x = _loc11_;
               _loc7_.y = _loc12_;
               §§pop().zpp_inner = _loc7_;
               _loc18_.zpp_inner.outer = _loc18_;
            }
            else
            {
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc18_.zpp_inner.x == _loc11_)
               {
                  §§pop();
                  if(_loc18_ != null && _loc18_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc7_ = _loc18_.zpp_inner;
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  §§push(_loc18_.zpp_inner.y == _loc12_);
               }
               if(!§§pop())
               {
                  _loc18_.zpp_inner.x = _loc11_;
                  _loc18_.zpp_inner.y = _loc12_;
                  _loc7_ = _loc18_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc18_;
            }
            _loc18_.zpp_inner.weak = _loc15_;
            _loc16_ = _loc18_;
            _loc11_ = 0;
            _loc12_ = 0;
            _loc15_ = false;
            if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc19_ = new Vec2();
            }
            else
            {
               _loc19_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc19_.zpp_pool;
               _loc19_.zpp_pool = null;
               _loc19_.zpp_disp = false;
               if(_loc19_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc19_.zpp_inner == null)
            {
               _loc17_ = false;
               §§push(_loc19_);
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
               _loc7_._immutable = _loc17_;
               _loc7_.x = _loc11_;
               _loc7_.y = _loc12_;
               §§pop().zpp_inner = _loc7_;
               _loc19_.zpp_inner.outer = _loc19_;
            }
            else
            {
               if(_loc19_ != null && _loc19_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc19_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc19_ != null && _loc19_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc19_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc19_.zpp_inner.x == _loc11_)
               {
                  §§pop();
                  if(_loc19_ != null && _loc19_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc7_ = _loc19_.zpp_inner;
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  §§push(_loc19_.zpp_inner.y == _loc12_);
               }
               if(!§§pop())
               {
                  _loc19_.zpp_inner.x = _loc11_;
                  _loc19_.zpp_inner.y = _loc12_;
                  _loc7_ = _loc19_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc19_;
            }
            _loc19_.zpp_inner.weak = _loc15_;
            _loc18_ = _loc19_;
            _loc20_ = 0;
            while(_loc20_ < param4)
            {
               _loc21_ = _loc20_++;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.x + _loc6_ + _loc9_;
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.x != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "x" + " cannot be NaN";
                  }
                  _loc16_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc16_.zpp_inner.x;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.y + _loc8_ + _loc10_;
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.y != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "y" + " cannot be NaN";
                  }
                  _loc16_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc16_.zpp_inner.y;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.x + _loc6_ * 2;
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc18_.zpp_inner.x != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "x" + " cannot be NaN";
                  }
                  _loc18_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc18_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc18_.zpp_inner.x;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.y + _loc8_ * 2;
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc18_.zpp_inner.y != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "y" + " cannot be NaN";
                  }
                  _loc18_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc18_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc18_.zpp_inner.y;
               drawCurve(_loc14_,_loc16_,_loc18_,param3);
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc18_.zpp_inner.x;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc14_.zpp_inner.x != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "x" + " cannot be NaN";
                  }
                  _loc14_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc14_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc14_.zpp_inner.x;
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc18_.zpp_inner.y;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc14_.zpp_inner.y != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "y" + " cannot be NaN";
                  }
                  _loc14_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc14_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc14_.zpp_inner.y;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.x + _loc6_ - _loc9_;
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.x != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "x" + " cannot be NaN";
                  }
                  _loc16_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc16_.zpp_inner.x;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.y + _loc8_ - _loc10_;
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.y != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "y" + " cannot be NaN";
                  }
                  _loc16_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc16_.zpp_inner.y;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.x + _loc6_ * 2;
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc18_.zpp_inner.x != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "x" + " cannot be NaN";
                  }
                  _loc18_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc18_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc18_.zpp_inner.x;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.y + _loc8_ * 2;
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc18_.zpp_inner.y != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "y" + " cannot be NaN";
                  }
                  _loc18_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc18_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc18_.zpp_inner.y;
               drawCurve(_loc14_,_loc16_,_loc18_,param3);
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc18_.zpp_inner.x;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc14_.zpp_inner.x != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "x" + " cannot be NaN";
                  }
                  _loc14_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc14_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc14_.zpp_inner.x;
               if(_loc18_ != null && _loc18_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc18_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc18_.zpp_inner.y;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc14_.zpp_inner.y != _loc11_)
               {
                  if(_loc11_ != _loc11_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2::" + "y" + " cannot be NaN";
                  }
                  _loc14_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc14_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc14_.zpp_inner.y;
            }
            if(_loc14_ != null && _loc14_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc14_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc14_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc14_.zpp_inner;
            _loc14_.zpp_inner.outer = null;
            _loc14_.zpp_inner = null;
            _loc19_ = _loc14_;
            _loc19_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc19_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc19_;
            }
            ZPP_PubPool.nextVec2 = _loc19_;
            _loc19_.zpp_disp = true;
            _loc22_ = _loc7_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            if(_loc16_ != null && _loc16_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc16_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc16_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc16_.zpp_inner;
            _loc16_.zpp_inner.outer = null;
            _loc16_.zpp_inner = null;
            _loc19_ = _loc16_;
            _loc19_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc19_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc19_;
            }
            ZPP_PubPool.nextVec2 = _loc19_;
            _loc19_.zpp_disp = true;
            _loc22_ = _loc7_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            if(_loc18_ != null && _loc18_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc18_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc18_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc18_.zpp_inner;
            _loc18_.zpp_inner.outer = null;
            _loc18_.zpp_inner = null;
            _loc19_ = _loc18_;
            _loc19_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc19_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc19_;
            }
            ZPP_PubPool.nextVec2 = _loc19_;
            _loc19_.zpp_disp = true;
            _loc22_ = _loc7_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
         }
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc14_ = param1;
            _loc14_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc14_;
            }
            ZPP_PubPool.nextVec2 = _loc14_;
            _loc14_.zpp_disp = true;
            _loc22_ = _loc7_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            true;
         }
         else
         {
            false;
         }
         if(param2.zpp_inner.weak)
         {
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param2.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(param2.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = param2.zpp_inner;
            param2.zpp_inner.outer = null;
            param2.zpp_inner = null;
            _loc14_ = param2;
            _loc14_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc14_;
            }
            ZPP_PubPool.nextVec2 = _loc14_;
            _loc14_.zpp_disp = true;
            _loc22_ = _loc7_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            true;
         }
         else
         {
            false;
         }
      }
      
      override public function drawPolygon(param1:*, param2:int) : void
      {
         var _loc6_:* = null as Array;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null as Vec2;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as Vec2;
         var _loc15_:Boolean = false;
         var _loc16_:* = null as Vector.<Vec2>;
         var _loc17_:* = null as Vec2;
         var _loc18_:* = null as Vec2List;
         var _loc19_:* = null as Vec2Iterator;
         var _loc20_:* = null as GeomPoly;
         var _loc21_:* = null as ZPP_GeomVert;
         var _loc22_:* = null as ZPP_GeomVert;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as Vec2;
         var _loc25_:* = null as ZNPList_ZPP_Vec2;
         var _loc26_:* = null as ZNPNode_ZPP_Vec2;
         var _loc27_:* = null as ZNPNode_ZPP_Vec2;
         var _loc28_:* = null as ZPP_Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot draw null polygon";
         }
         var _loc3_:Graphics = zpp_inner_zn.graphics;
         _loc3_.lineStyle(0.1,param2 & 0xFFFFFF,1);
         var _loc4_:Vec2 = null;
         var _loc5_:Boolean = true;
         if(zpp_inner.xnull)
         {
            if(param1 is Array)
            {
               _loc6_ = param1;
               _loc7_ = 0;
               while(_loc7_ < int(_loc6_.length))
               {
                  _loc8_ = _loc6_[_loc7_];
                  _loc7_++;
                  if(_loc8_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains null objects";
                  }
                  if(!(_loc8_ is Vec2))
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains non Vec2 objects";
                  }
                  _loc9_ = _loc8_;
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc5_)
                  {
                     _loc10_ = false;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc11_ = _loc9_.zpp_inner.x;
                     if(_loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc13_ = _loc9_.zpp_inner.y;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc14_ = new Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                        _loc14_.zpp_pool = null;
                        _loc14_.zpp_disp = false;
                        if(_loc14_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc14_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc14_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc14_.zpp_inner.outer = _loc14_;
                     }
                     else
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc14_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc14_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc14_.zpp_inner.x = _loc11_;
                           _loc14_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc14_;
                     }
                     _loc14_.zpp_inner.weak = _loc10_;
                     _loc4_ = _loc14_;
                     §§push(_loc3_);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc9_.zpp_inner.x);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc9_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc9_.zpp_inner.x);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc9_.zpp_inner.y);
                  }
                  _loc5_ = false;
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc16_ = param1;
               _loc7_ = 0;
               while(_loc7_ < _loc16_.length)
               {
                  _loc9_ = _loc16_[_loc7_];
                  _loc7_++;
                  if(_loc9_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: flash.Vector<Vec2> contains null objects";
                  }
                  _loc14_ = _loc9_;
                  if(_loc14_ != null && _loc14_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc5_)
                  {
                     _loc10_ = false;
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc11_ = _loc14_.zpp_inner.x;
                     if(_loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc13_ = _loc14_.zpp_inner.y;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc17_ = new Vec2();
                     }
                     else
                     {
                        _loc17_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc17_.zpp_pool;
                        _loc17_.zpp_pool = null;
                        _loc17_.zpp_disp = false;
                        if(_loc17_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc17_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc17_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc17_.zpp_inner.outer = _loc17_;
                     }
                     else
                     {
                        if(_loc17_ != null && _loc17_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc17_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc17_ != null && _loc17_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc17_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc17_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc17_ != null && _loc17_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc17_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc17_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc17_.zpp_inner.x = _loc11_;
                           _loc17_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc17_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc17_;
                     }
                     _loc17_.zpp_inner.weak = _loc10_;
                     _loc4_ = _loc17_;
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  _loc5_ = false;
               }
            }
            else if(param1 is Vec2List)
            {
               _loc18_ = param1;
               _loc19_ = _loc18_.iterator();
               while(true)
               {
                  _loc19_.zpp_inner.zpp_inner.valmod();
                  _loc7_ = _loc19_.zpp_inner.zpp_gl();
                  _loc19_.zpp_critical = true;
                  if(!(_loc19_.zpp_i < _loc7_ ? true : (_loc19_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc19_, _loc19_.zpp_inner = null, false)))
                  {
                     break;
                  }
                  _loc19_.zpp_critical = false;
                  _loc19_.zpp_i = (_loc7_ = _loc19_.zpp_i) + 1;
                  _loc9_ = _loc19_.zpp_inner.at(_loc7_);
                  if(_loc9_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2List contains null objects";
                  }
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc5_)
                  {
                     _loc10_ = false;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc11_ = _loc9_.zpp_inner.x;
                     if(_loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc13_ = _loc9_.zpp_inner.y;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc14_ = new Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                        _loc14_.zpp_pool = null;
                        _loc14_.zpp_disp = false;
                        if(_loc14_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc14_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc14_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc14_.zpp_inner.outer = _loc14_;
                     }
                     else
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc14_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc14_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc14_.zpp_inner.x = _loc11_;
                           _loc14_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc14_;
                     }
                     _loc14_.zpp_inner.weak = _loc10_;
                     _loc4_ = _loc14_;
                     §§push(_loc3_);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc9_.zpp_inner.x);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc9_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc9_.zpp_inner.x);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc9_.zpp_inner.y);
                  }
                  _loc5_ = false;
               }
            }
            else
            {
               if(!(param1 is GeomPoly))
               {
                  Boot.lastError = new Error();
                  throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
               }
               _loc20_ = param1;
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
               }
               _loc21_ = _loc20_.zpp_inner.vertices;
               if(_loc21_ != null)
               {
                  _loc22_ = _loc21_;
                  do
                  {
                     _loc11_ = _loc22_.x;
                     _loc13_ = _loc22_.y;
                     _loc10_ = false;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc14_ = new Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                        _loc14_.zpp_pool = null;
                        _loc14_.zpp_disp = false;
                        if(_loc14_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc14_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc14_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc14_.zpp_inner.outer = _loc14_;
                     }
                     else
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc14_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc14_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc14_.zpp_inner.x = _loc11_;
                           _loc14_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc14_;
                     }
                     _loc14_.zpp_inner.weak = _loc10_;
                     _loc9_ = _loc14_;
                     _loc22_ = _loc22_.next;
                     if(_loc5_)
                     {
                        _loc10_ = false;
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if(_loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        _loc11_ = _loc9_.zpp_inner.x;
                        if(_loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        _loc13_ = _loc9_.zpp_inner.y;
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        if(ZPP_PubPool.poolVec2 == null)
                        {
                           _loc14_ = new Vec2();
                        }
                        else
                        {
                           _loc14_ = ZPP_PubPool.poolVec2;
                           ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                           _loc14_.zpp_pool = null;
                           _loc14_.zpp_disp = false;
                           if(_loc14_ == ZPP_PubPool.nextVec2)
                           {
                              ZPP_PubPool.nextVec2 = null;
                           }
                        }
                        if(_loc14_.zpp_inner == null)
                        {
                           _loc15_ = false;
                           §§push(_loc14_);
                           if(ZPP_Vec2.zpp_pool == null)
                           {
                              _loc12_ = new ZPP_Vec2();
                           }
                           else
                           {
                              _loc12_ = ZPP_Vec2.zpp_pool;
                              ZPP_Vec2.zpp_pool = _loc12_.next;
                              _loc12_.next = null;
                           }
                           _loc12_.weak = false;
                           _loc12_._immutable = _loc15_;
                           _loc12_.x = _loc11_;
                           _loc12_.y = _loc13_;
                           §§pop().zpp_inner = _loc12_;
                           _loc14_.zpp_inner.outer = _loc14_;
                        }
                        else
                        {
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc12_._isimmutable != null)
                           {
                              _loc12_._isimmutable();
                           }
                           if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 components cannot be NaN";
                           }
                           §§push(false);
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           if(_loc14_.zpp_inner.x == _loc11_)
                           {
                              §§pop();
                              if(_loc14_ != null && _loc14_.zpp_disp)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                              }
                              _loc12_ = _loc14_.zpp_inner;
                              if(_loc12_._validate != null)
                              {
                                 _loc12_._validate();
                              }
                              §§push(_loc14_.zpp_inner.y == _loc13_);
                           }
                           if(!§§pop())
                           {
                              _loc14_.zpp_inner.x = _loc11_;
                              _loc14_.zpp_inner.y = _loc13_;
                              _loc12_ = _loc14_.zpp_inner;
                              if(_loc12_._invalidate != null)
                              {
                                 _loc12_._invalidate(_loc12_);
                              }
                           }
                           _loc14_;
                        }
                        _loc14_.zpp_inner.weak = _loc10_;
                        _loc4_ = _loc14_;
                        §§push(_loc3_);
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§push(_loc9_.zpp_inner.x);
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§pop().moveTo(§§pop(),_loc9_.zpp_inner.y);
                     }
                     else
                     {
                        §§push(_loc3_);
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§push(_loc9_.zpp_inner.x);
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§pop().lineTo(§§pop(),_loc9_.zpp_inner.y);
                     }
                     _loc5_ = false;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc9_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     _loc9_.zpp_inner.outer = null;
                     _loc9_.zpp_inner = null;
                     _loc14_ = _loc9_;
                     _loc14_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc14_;
                     }
                     ZPP_PubPool.nextVec2 = _loc14_;
                     _loc14_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  while(_loc22_ != _loc21_);
                  
               }
            }
            §§push(_loc3_);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§push(_loc4_.zpp_inner.x);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§pop().lineTo(§§pop(),_loc4_.zpp_inner.y);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc12_._isimmutable != null)
            {
               _loc12_._isimmutable();
            }
            if(_loc4_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc12_ = _loc4_.zpp_inner;
            _loc4_.zpp_inner.outer = null;
            _loc4_.zpp_inner = null;
            _loc9_ = _loc4_;
            _loc9_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc9_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc9_;
            }
            ZPP_PubPool.nextVec2 = _loc9_;
            _loc9_.zpp_disp = true;
            _loc23_ = _loc12_;
            if(_loc23_.outer != null)
            {
               _loc23_.outer.zpp_inner = null;
               _loc23_.outer = null;
            }
            _loc23_._isimmutable = null;
            _loc23_._validate = null;
            _loc23_._invalidate = null;
            _loc23_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc23_;
         }
         else
         {
            if(param1 is Array)
            {
               _loc6_ = param1;
               _loc7_ = 0;
               while(_loc7_ < int(_loc6_.length))
               {
                  _loc8_ = _loc6_[_loc7_];
                  _loc7_++;
                  if(_loc8_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains null objects";
                  }
                  if(!(_loc8_ is Vec2))
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains non Vec2 objects";
                  }
                  _loc9_ = _loc8_;
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = zpp_inner.xform.outer.transform(_loc9_);
                  if(_loc5_)
                  {
                     _loc4_ = _loc14_;
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  if(!_loc5_)
                  {
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc14_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     _loc14_.zpp_inner.outer = null;
                     _loc14_.zpp_inner = null;
                     _loc17_ = _loc14_;
                     _loc17_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc17_;
                     }
                     ZPP_PubPool.nextVec2 = _loc17_;
                     _loc17_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  _loc5_ = false;
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc16_ = param1;
               _loc7_ = 0;
               while(_loc7_ < _loc16_.length)
               {
                  _loc9_ = _loc16_[_loc7_];
                  _loc7_++;
                  if(_loc9_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: flash.Vector<Vec2> contains null objects";
                  }
                  _loc14_ = _loc9_;
                  if(_loc14_ != null && _loc14_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = zpp_inner.xform.outer.transform(_loc14_);
                  if(_loc5_)
                  {
                     _loc4_ = _loc17_;
                     §§push(_loc3_);
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc17_.zpp_inner.x);
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc17_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc17_.zpp_inner.x);
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc17_.zpp_inner.y);
                  }
                  if(!_loc5_)
                  {
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc17_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     _loc17_.zpp_inner.outer = null;
                     _loc17_.zpp_inner = null;
                     _loc24_ = _loc17_;
                     _loc24_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc24_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc24_;
                     }
                     ZPP_PubPool.nextVec2 = _loc24_;
                     _loc24_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  _loc5_ = false;
               }
            }
            else if(param1 is Vec2List)
            {
               _loc18_ = param1;
               _loc19_ = _loc18_.iterator();
               while(true)
               {
                  _loc19_.zpp_inner.zpp_inner.valmod();
                  _loc7_ = _loc19_.zpp_inner.zpp_gl();
                  _loc19_.zpp_critical = true;
                  if(!(_loc19_.zpp_i < _loc7_ ? true : (_loc19_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc19_, _loc19_.zpp_inner = null, false)))
                  {
                     break;
                  }
                  _loc19_.zpp_critical = false;
                  _loc19_.zpp_i = (_loc7_ = _loc19_.zpp_i) + 1;
                  _loc9_ = _loc19_.zpp_inner.at(_loc7_);
                  if(_loc9_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2List contains null objects";
                  }
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = zpp_inner.xform.outer.transform(_loc9_);
                  if(_loc5_)
                  {
                     _loc4_ = _loc14_;
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  if(!_loc5_)
                  {
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc14_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     _loc14_.zpp_inner.outer = null;
                     _loc14_.zpp_inner = null;
                     _loc17_ = _loc14_;
                     _loc17_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc17_;
                     }
                     ZPP_PubPool.nextVec2 = _loc17_;
                     _loc17_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  _loc5_ = false;
               }
            }
            else
            {
               if(!(param1 is GeomPoly))
               {
                  Boot.lastError = new Error();
                  throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
               }
               _loc20_ = param1;
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
               }
               _loc21_ = _loc20_.zpp_inner.vertices;
               if(_loc21_ != null)
               {
                  _loc22_ = _loc21_;
                  do
                  {
                     _loc11_ = _loc22_.x;
                     _loc13_ = _loc22_.y;
                     _loc10_ = false;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc14_ = new Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                        _loc14_.zpp_pool = null;
                        _loc14_.zpp_disp = false;
                        if(_loc14_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc14_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc14_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc14_.zpp_inner.outer = _loc14_;
                     }
                     else
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc14_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc14_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc14_.zpp_inner.x = _loc11_;
                           _loc14_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc14_;
                     }
                     _loc14_.zpp_inner.weak = _loc10_;
                     _loc9_ = _loc14_;
                     _loc22_ = _loc22_.next;
                     _loc14_ = zpp_inner.xform.outer.transform(_loc9_);
                     if(_loc5_)
                     {
                        _loc4_ = _loc14_;
                        §§push(_loc3_);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§push(_loc14_.zpp_inner.x);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
                     }
                     else
                     {
                        §§push(_loc3_);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§push(_loc14_.zpp_inner.x);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
                     }
                     if(!_loc5_)
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc14_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        _loc14_.zpp_inner.outer = null;
                        _loc14_.zpp_inner = null;
                        _loc17_ = _loc14_;
                        _loc17_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc17_;
                        }
                        ZPP_PubPool.nextVec2 = _loc17_;
                        _loc17_.zpp_disp = true;
                        _loc23_ = _loc12_;
                        if(_loc23_.outer != null)
                        {
                           _loc23_.outer.zpp_inner = null;
                           _loc23_.outer = null;
                        }
                        _loc23_._isimmutable = null;
                        _loc23_._validate = null;
                        _loc23_._invalidate = null;
                        _loc23_.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc23_;
                     }
                     _loc5_ = false;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc9_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     _loc9_.zpp_inner.outer = null;
                     _loc9_.zpp_inner = null;
                     _loc14_ = _loc9_;
                     _loc14_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc14_;
                     }
                     ZPP_PubPool.nextVec2 = _loc14_;
                     _loc14_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  while(_loc22_ != _loc21_);
                  
               }
            }
            §§push(_loc3_);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§push(_loc4_.zpp_inner.x);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§pop().lineTo(§§pop(),_loc4_.zpp_inner.y);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc12_._isimmutable != null)
            {
               _loc12_._isimmutable();
            }
            if(_loc4_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc12_ = _loc4_.zpp_inner;
            _loc4_.zpp_inner.outer = null;
            _loc4_.zpp_inner = null;
            _loc9_ = _loc4_;
            _loc9_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc9_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc9_;
            }
            ZPP_PubPool.nextVec2 = _loc9_;
            _loc9_.zpp_disp = true;
            _loc23_ = _loc12_;
            if(_loc23_.outer != null)
            {
               _loc23_.outer.zpp_inner = null;
               _loc23_.outer = null;
            }
            _loc23_._isimmutable = null;
            _loc23_._validate = null;
            _loc23_._invalidate = null;
            _loc23_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc23_;
         }
         if(param1 is Array)
         {
            _loc6_ = param1;
            _loc7_ = 0;
            while(_loc7_ < int(_loc6_.length))
            {
               _loc9_ = _loc6_[_loc7_];
               if(_loc9_.zpp_inner.weak)
               {
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc12_ = _loc9_.zpp_inner;
                  if(_loc12_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc12_._isimmutable != null)
                  {
                     _loc12_._isimmutable();
                  }
                  if(_loc9_.zpp_inner._inuse)
                  {
                     Boot.lastError = new Error();
                     throw "Error: This Vec2 is not disposable";
                  }
                  _loc12_ = _loc9_.zpp_inner;
                  _loc9_.zpp_inner.outer = null;
                  _loc9_.zpp_inner = null;
                  _loc14_ = _loc9_;
                  _loc14_.zpp_pool = null;
                  if(ZPP_PubPool.nextVec2 != null)
                  {
                     ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                  }
                  else
                  {
                     ZPP_PubPool.poolVec2 = _loc14_;
                  }
                  ZPP_PubPool.nextVec2 = _loc14_;
                  _loc14_.zpp_disp = true;
                  _loc23_ = _loc12_;
                  if(_loc23_.outer != null)
                  {
                     _loc23_.outer.zpp_inner = null;
                     _loc23_.outer = null;
                  }
                  _loc23_._isimmutable = null;
                  _loc23_._validate = null;
                  _loc23_._invalidate = null;
                  _loc23_.next = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc23_;
                  §§push(true);
               }
               else
               {
                  §§push(false);
               }
               if(§§pop())
               {
                  _loc6_.splice(_loc7_,1);
               }
               else
               {
                  _loc7_++;
               }
            }
         }
         else if(param1 is ZPP_Const.vec2vector)
         {
            _loc16_ = param1;
            if(!_loc16_.fixed)
            {
               _loc7_ = 0;
               while(_loc7_ < int(_loc16_.length))
               {
                  _loc9_ = _loc16_[_loc7_];
                  if(_loc9_.zpp_inner.weak)
                  {
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc9_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     _loc9_.zpp_inner.outer = null;
                     _loc9_.zpp_inner = null;
                     _loc14_ = _loc9_;
                     _loc14_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc14_;
                     }
                     ZPP_PubPool.nextVec2 = _loc14_;
                     _loc14_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  if(§§pop())
                  {
                     _loc16_.splice(_loc7_,1);
                  }
                  else
                  {
                     _loc7_++;
                  }
               }
            }
         }
         else if(param1 is Vec2List)
         {
            _loc18_ = param1;
            if(_loc18_.zpp_inner._validate != null)
            {
               _loc18_.zpp_inner._validate();
            }
            _loc25_ = _loc18_.zpp_inner.inner;
            _loc26_ = null;
            _loc27_ = _loc25_.head;
            while(_loc27_ != null)
            {
               _loc12_ = _loc27_.elt;
               if(_loc12_.outer.zpp_inner.weak)
               {
                  _loc27_ = _loc25_.erase(_loc26_);
                  if(_loc12_.outer.zpp_inner.weak)
                  {
                     _loc9_ = _loc12_.outer;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc23_ = _loc9_.zpp_inner;
                     if(_loc23_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc23_._isimmutable != null)
                     {
                        _loc23_._isimmutable();
                     }
                     if(_loc9_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc23_ = _loc9_.zpp_inner;
                     _loc9_.zpp_inner.outer = null;
                     _loc9_.zpp_inner = null;
                     _loc14_ = _loc9_;
                     _loc14_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc14_;
                     }
                     ZPP_PubPool.nextVec2 = _loc14_;
                     _loc14_.zpp_disp = true;
                     _loc28_ = _loc23_;
                     if(_loc28_.outer != null)
                     {
                        _loc28_.outer.zpp_inner = null;
                        _loc28_.outer = null;
                     }
                     _loc28_._isimmutable = null;
                     _loc28_._validate = null;
                     _loc28_._invalidate = null;
                     _loc28_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc28_;
                     true;
                  }
                  else
                  {
                     false;
                  }
               }
               else
               {
                  _loc26_ = _loc27_;
                  _loc27_ = _loc27_.next;
               }
            }
         }
      }
      
      override public function drawLine(param1:Vec2, param2:Vec2, param3:int) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawLine::start cannot be null";
         }
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawLine::end cannot be null";
         }
         var _loc4_:Graphics = zpp_inner_zn.graphics;
         _loc4_.lineStyle(0.1,param3 & 0xFFFFFF,1);
         if(zpp_inner.xnull)
         {
            §§push(_loc4_);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(param1.zpp_inner.x);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§pop().moveTo(§§pop(),param1.zpp_inner.y);
            §§push(_loc4_);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param2.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(param2.zpp_inner.x);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param2.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§pop().lineTo(§§pop(),param2.zpp_inner.y);
            if(param1.zpp_inner.weak)
            {
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = param1.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(param1.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = param1.zpp_inner;
               param1.zpp_inner.outer = null;
               param1.zpp_inner = null;
               _loc6_ = param1;
               _loc6_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc6_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc6_;
               }
               ZPP_PubPool.nextVec2 = _loc6_;
               _loc6_.zpp_disp = true;
               _loc7_ = _loc5_;
               if(_loc7_.outer != null)
               {
                  _loc7_.outer.zpp_inner = null;
                  _loc7_.outer = null;
               }
               _loc7_._isimmutable = null;
               _loc7_._validate = null;
               _loc7_._invalidate = null;
               _loc7_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc7_;
               true;
            }
            else
            {
               false;
            }
            if(param2.zpp_inner.weak)
            {
               if(param2 != null && param2.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = param2.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(param2.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = param2.zpp_inner;
               param2.zpp_inner.outer = null;
               param2.zpp_inner = null;
               _loc6_ = param2;
               _loc6_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc6_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc6_;
               }
               ZPP_PubPool.nextVec2 = _loc6_;
               _loc6_.zpp_disp = true;
               _loc7_ = _loc5_;
               if(_loc7_.outer != null)
               {
                  _loc7_.outer.zpp_inner = null;
                  _loc7_.outer = null;
               }
               _loc7_._isimmutable = null;
               _loc7_._validate = null;
               _loc7_._invalidate = null;
               _loc7_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc7_;
               true;
            }
            else
            {
               false;
            }
         }
         else
         {
            _loc6_ = zpp_inner.xform.outer.transform(param1);
            §§push(_loc4_);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(_loc6_.zpp_inner.x);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§pop().moveTo(§§pop(),_loc6_.zpp_inner.y);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc6_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc6_.zpp_inner;
            _loc6_.zpp_inner.outer = null;
            _loc6_.zpp_inner = null;
            _loc8_ = _loc6_;
            _loc8_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc8_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc8_;
            }
            ZPP_PubPool.nextVec2 = _loc8_;
            _loc8_.zpp_disp = true;
            _loc7_ = _loc5_;
            if(_loc7_.outer != null)
            {
               _loc7_.outer.zpp_inner = null;
               _loc7_.outer = null;
            }
            _loc7_._isimmutable = null;
            _loc7_._validate = null;
            _loc7_._invalidate = null;
            _loc7_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc7_;
            _loc6_ = zpp_inner.xform.outer.transform(param2);
            §§push(_loc4_);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(_loc6_.zpp_inner.x);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§pop().lineTo(§§pop(),_loc6_.zpp_inner.y);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc6_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc6_.zpp_inner;
            _loc6_.zpp_inner.outer = null;
            _loc6_.zpp_inner = null;
            _loc8_ = _loc6_;
            _loc8_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc8_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc8_;
            }
            ZPP_PubPool.nextVec2 = _loc8_;
            _loc8_.zpp_disp = true;
            _loc7_ = _loc5_;
            if(_loc7_.outer != null)
            {
               _loc7_.outer.zpp_inner = null;
               _loc7_.outer = null;
            }
            _loc7_._isimmutable = null;
            _loc7_._validate = null;
            _loc7_._invalidate = null;
            _loc7_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc7_;
         }
      }
      
      override public function drawFilledTriangle(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null || param2 == null || param3 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawFilledTriangle can\'t use null points";
         }
         var _loc5_:Graphics = zpp_inner_zn.graphics;
         _loc5_.lineStyle(0,0,0);
         _loc5_.beginFill(param4 & 0xFFFFFF,1);
         if(zpp_inner.xnull)
         {
            §§push(_loc5_);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param1.zpp_inner.x);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().moveTo(§§pop(),param1.zpp_inner.y);
            §§push(_loc5_);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param2.zpp_inner.x);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().lineTo(§§pop(),param2.zpp_inner.y);
            §§push(_loc5_);
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param3.zpp_inner.x);
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().lineTo(§§pop(),param3.zpp_inner.y);
            if(param1.zpp_inner.weak)
            {
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = param1.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(param1.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc6_ = param1.zpp_inner;
               param1.zpp_inner.outer = null;
               param1.zpp_inner = null;
               _loc7_ = param1;
               _loc7_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc7_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc7_;
               }
               ZPP_PubPool.nextVec2 = _loc7_;
               _loc7_.zpp_disp = true;
               _loc8_ = _loc6_;
               if(_loc8_.outer != null)
               {
                  _loc8_.outer.zpp_inner = null;
                  _loc8_.outer = null;
               }
               _loc8_._isimmutable = null;
               _loc8_._validate = null;
               _loc8_._invalidate = null;
               _loc8_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc8_;
               true;
            }
            else
            {
               false;
            }
            if(param2.zpp_inner.weak)
            {
               if(param2 != null && param2.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = param2.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(param2.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc6_ = param2.zpp_inner;
               param2.zpp_inner.outer = null;
               param2.zpp_inner = null;
               _loc7_ = param2;
               _loc7_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc7_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc7_;
               }
               ZPP_PubPool.nextVec2 = _loc7_;
               _loc7_.zpp_disp = true;
               _loc8_ = _loc6_;
               if(_loc8_.outer != null)
               {
                  _loc8_.outer.zpp_inner = null;
                  _loc8_.outer = null;
               }
               _loc8_._isimmutable = null;
               _loc8_._validate = null;
               _loc8_._invalidate = null;
               _loc8_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc8_;
               true;
            }
            else
            {
               false;
            }
            if(param3.zpp_inner.weak)
            {
               if(param3 != null && param3.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = param3.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(param3.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc6_ = param3.zpp_inner;
               param3.zpp_inner.outer = null;
               param3.zpp_inner = null;
               _loc7_ = param3;
               _loc7_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc7_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc7_;
               }
               ZPP_PubPool.nextVec2 = _loc7_;
               _loc7_.zpp_disp = true;
               _loc8_ = _loc6_;
               if(_loc8_.outer != null)
               {
                  _loc8_.outer.zpp_inner = null;
                  _loc8_.outer = null;
               }
               _loc8_._isimmutable = null;
               _loc8_._validate = null;
               _loc8_._invalidate = null;
               _loc8_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc8_;
               true;
            }
            else
            {
               false;
            }
         }
         else
         {
            _loc7_ = zpp_inner.xform.outer.transform(param1);
            §§push(_loc5_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc7_.zpp_inner.x);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().moveTo(§§pop(),_loc7_.zpp_inner.y);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc7_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc7_.zpp_inner;
            _loc7_.zpp_inner.outer = null;
            _loc7_.zpp_inner = null;
            _loc9_ = _loc7_;
            _loc9_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc9_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc9_;
            }
            ZPP_PubPool.nextVec2 = _loc9_;
            _loc9_.zpp_disp = true;
            _loc8_ = _loc6_;
            if(_loc8_.outer != null)
            {
               _loc8_.outer.zpp_inner = null;
               _loc8_.outer = null;
            }
            _loc8_._isimmutable = null;
            _loc8_._validate = null;
            _loc8_._invalidate = null;
            _loc8_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc8_;
            _loc7_ = zpp_inner.xform.outer.transform(param2);
            §§push(_loc5_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc7_.zpp_inner.x);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().lineTo(§§pop(),_loc7_.zpp_inner.y);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc7_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc7_.zpp_inner;
            _loc7_.zpp_inner.outer = null;
            _loc7_.zpp_inner = null;
            _loc9_ = _loc7_;
            _loc9_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc9_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc9_;
            }
            ZPP_PubPool.nextVec2 = _loc9_;
            _loc9_.zpp_disp = true;
            _loc8_ = _loc6_;
            if(_loc8_.outer != null)
            {
               _loc8_.outer.zpp_inner = null;
               _loc8_.outer = null;
            }
            _loc8_._isimmutable = null;
            _loc8_._validate = null;
            _loc8_._invalidate = null;
            _loc8_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc8_;
            _loc7_ = zpp_inner.xform.outer.transform(param3);
            §§push(_loc5_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc7_.zpp_inner.x);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().lineTo(§§pop(),_loc7_.zpp_inner.y);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc7_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc7_.zpp_inner;
            _loc7_.zpp_inner.outer = null;
            _loc7_.zpp_inner = null;
            _loc9_ = _loc7_;
            _loc9_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc9_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc9_;
            }
            ZPP_PubPool.nextVec2 = _loc9_;
            _loc9_.zpp_disp = true;
            _loc8_ = _loc6_;
            if(_loc8_.outer != null)
            {
               _loc8_.outer.zpp_inner = null;
               _loc8_.outer = null;
            }
            _loc8_._isimmutable = null;
            _loc8_._validate = null;
            _loc8_._invalidate = null;
            _loc8_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc8_;
         }
         _loc5_.endFill();
      }
      
      override public function drawFilledPolygon(param1:*, param2:int) : void
      {
         var _loc6_:* = null as Array;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null as Vec2;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as Vec2;
         var _loc15_:Boolean = false;
         var _loc16_:* = null as Vector.<Vec2>;
         var _loc17_:* = null as Vec2;
         var _loc18_:* = null as Vec2List;
         var _loc19_:* = null as Vec2Iterator;
         var _loc20_:* = null as GeomPoly;
         var _loc21_:* = null as ZPP_GeomVert;
         var _loc22_:* = null as ZPP_GeomVert;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as Vec2;
         var _loc25_:* = null as ZNPList_ZPP_Vec2;
         var _loc26_:* = null as ZNPNode_ZPP_Vec2;
         var _loc27_:* = null as ZNPNode_ZPP_Vec2;
         var _loc28_:* = null as ZPP_Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot draw null polygon!";
         }
         var _loc3_:Graphics = zpp_inner_zn.graphics;
         _loc3_.beginFill(param2 & 0xFFFFFF,1);
         _loc3_.lineStyle(0,0,0);
         var _loc4_:Vec2 = null;
         var _loc5_:Boolean = true;
         if(zpp_inner.xnull)
         {
            if(param1 is Array)
            {
               _loc6_ = param1;
               _loc7_ = 0;
               while(_loc7_ < int(_loc6_.length))
               {
                  _loc8_ = _loc6_[_loc7_];
                  _loc7_++;
                  if(_loc8_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains null objects";
                  }
                  if(!(_loc8_ is Vec2))
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains non Vec2 objects";
                  }
                  _loc9_ = _loc8_;
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc5_)
                  {
                     _loc10_ = false;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc11_ = _loc9_.zpp_inner.x;
                     if(_loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc13_ = _loc9_.zpp_inner.y;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc14_ = new Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                        _loc14_.zpp_pool = null;
                        _loc14_.zpp_disp = false;
                        if(_loc14_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc14_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc14_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc14_.zpp_inner.outer = _loc14_;
                     }
                     else
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc14_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc14_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc14_.zpp_inner.x = _loc11_;
                           _loc14_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc14_;
                     }
                     _loc14_.zpp_inner.weak = _loc10_;
                     _loc4_ = _loc14_;
                     §§push(_loc3_);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc9_.zpp_inner.x);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc9_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc9_.zpp_inner.x);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc9_.zpp_inner.y);
                  }
                  _loc5_ = false;
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc16_ = param1;
               _loc7_ = 0;
               while(_loc7_ < _loc16_.length)
               {
                  _loc9_ = _loc16_[_loc7_];
                  _loc7_++;
                  if(_loc9_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: flash.Vector<Vec2> contains null objects";
                  }
                  _loc14_ = _loc9_;
                  if(_loc14_ != null && _loc14_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc5_)
                  {
                     _loc10_ = false;
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc11_ = _loc14_.zpp_inner.x;
                     if(_loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc13_ = _loc14_.zpp_inner.y;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc17_ = new Vec2();
                     }
                     else
                     {
                        _loc17_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc17_.zpp_pool;
                        _loc17_.zpp_pool = null;
                        _loc17_.zpp_disp = false;
                        if(_loc17_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc17_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc17_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc17_.zpp_inner.outer = _loc17_;
                     }
                     else
                     {
                        if(_loc17_ != null && _loc17_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc17_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc17_ != null && _loc17_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc17_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc17_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc17_ != null && _loc17_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc17_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc17_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc17_.zpp_inner.x = _loc11_;
                           _loc17_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc17_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc17_;
                     }
                     _loc17_.zpp_inner.weak = _loc10_;
                     _loc4_ = _loc17_;
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  _loc5_ = false;
               }
            }
            else if(param1 is Vec2List)
            {
               _loc18_ = param1;
               _loc19_ = _loc18_.iterator();
               while(true)
               {
                  _loc19_.zpp_inner.zpp_inner.valmod();
                  _loc7_ = _loc19_.zpp_inner.zpp_gl();
                  _loc19_.zpp_critical = true;
                  if(!(_loc19_.zpp_i < _loc7_ ? true : (_loc19_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc19_, _loc19_.zpp_inner = null, false)))
                  {
                     break;
                  }
                  _loc19_.zpp_critical = false;
                  _loc19_.zpp_i = (_loc7_ = _loc19_.zpp_i) + 1;
                  _loc9_ = _loc19_.zpp_inner.at(_loc7_);
                  if(_loc9_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2List contains null objects";
                  }
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc5_)
                  {
                     _loc10_ = false;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc11_ = _loc9_.zpp_inner.x;
                     if(_loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc13_ = _loc9_.zpp_inner.y;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc14_ = new Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                        _loc14_.zpp_pool = null;
                        _loc14_.zpp_disp = false;
                        if(_loc14_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc14_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc14_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc14_.zpp_inner.outer = _loc14_;
                     }
                     else
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc14_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc14_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc14_.zpp_inner.x = _loc11_;
                           _loc14_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc14_;
                     }
                     _loc14_.zpp_inner.weak = _loc10_;
                     _loc4_ = _loc14_;
                     §§push(_loc3_);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc9_.zpp_inner.x);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc9_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc9_.zpp_inner.x);
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc9_.zpp_inner.y);
                  }
                  _loc5_ = false;
               }
            }
            else
            {
               if(!(param1 is GeomPoly))
               {
                  Boot.lastError = new Error();
                  throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
               }
               _loc20_ = param1;
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
               }
               _loc21_ = _loc20_.zpp_inner.vertices;
               if(_loc21_ != null)
               {
                  _loc22_ = _loc21_;
                  do
                  {
                     _loc11_ = _loc22_.x;
                     _loc13_ = _loc22_.y;
                     _loc10_ = false;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc14_ = new Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                        _loc14_.zpp_pool = null;
                        _loc14_.zpp_disp = false;
                        if(_loc14_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc14_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc14_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc14_.zpp_inner.outer = _loc14_;
                     }
                     else
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc14_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc14_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc14_.zpp_inner.x = _loc11_;
                           _loc14_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc14_;
                     }
                     _loc14_.zpp_inner.weak = _loc10_;
                     _loc9_ = _loc14_;
                     _loc22_ = _loc22_.next;
                     if(_loc5_)
                     {
                        _loc10_ = false;
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if(_loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        _loc11_ = _loc9_.zpp_inner.x;
                        if(_loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        _loc13_ = _loc9_.zpp_inner.y;
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        if(ZPP_PubPool.poolVec2 == null)
                        {
                           _loc14_ = new Vec2();
                        }
                        else
                        {
                           _loc14_ = ZPP_PubPool.poolVec2;
                           ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                           _loc14_.zpp_pool = null;
                           _loc14_.zpp_disp = false;
                           if(_loc14_ == ZPP_PubPool.nextVec2)
                           {
                              ZPP_PubPool.nextVec2 = null;
                           }
                        }
                        if(_loc14_.zpp_inner == null)
                        {
                           _loc15_ = false;
                           §§push(_loc14_);
                           if(ZPP_Vec2.zpp_pool == null)
                           {
                              _loc12_ = new ZPP_Vec2();
                           }
                           else
                           {
                              _loc12_ = ZPP_Vec2.zpp_pool;
                              ZPP_Vec2.zpp_pool = _loc12_.next;
                              _loc12_.next = null;
                           }
                           _loc12_.weak = false;
                           _loc12_._immutable = _loc15_;
                           _loc12_.x = _loc11_;
                           _loc12_.y = _loc13_;
                           §§pop().zpp_inner = _loc12_;
                           _loc14_.zpp_inner.outer = _loc14_;
                        }
                        else
                        {
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc12_._isimmutable != null)
                           {
                              _loc12_._isimmutable();
                           }
                           if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 components cannot be NaN";
                           }
                           §§push(false);
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           if(_loc14_.zpp_inner.x == _loc11_)
                           {
                              §§pop();
                              if(_loc14_ != null && _loc14_.zpp_disp)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                              }
                              _loc12_ = _loc14_.zpp_inner;
                              if(_loc12_._validate != null)
                              {
                                 _loc12_._validate();
                              }
                              §§push(_loc14_.zpp_inner.y == _loc13_);
                           }
                           if(!§§pop())
                           {
                              _loc14_.zpp_inner.x = _loc11_;
                              _loc14_.zpp_inner.y = _loc13_;
                              _loc12_ = _loc14_.zpp_inner;
                              if(_loc12_._invalidate != null)
                              {
                                 _loc12_._invalidate(_loc12_);
                              }
                           }
                           _loc14_;
                        }
                        _loc14_.zpp_inner.weak = _loc10_;
                        _loc4_ = _loc14_;
                        §§push(_loc3_);
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§push(_loc9_.zpp_inner.x);
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§pop().moveTo(§§pop(),_loc9_.zpp_inner.y);
                     }
                     else
                     {
                        §§push(_loc3_);
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§push(_loc9_.zpp_inner.x);
                        if(_loc9_ != null && _loc9_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc9_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§pop().lineTo(§§pop(),_loc9_.zpp_inner.y);
                     }
                     _loc5_ = false;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc9_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     _loc9_.zpp_inner.outer = null;
                     _loc9_.zpp_inner = null;
                     _loc14_ = _loc9_;
                     _loc14_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc14_;
                     }
                     ZPP_PubPool.nextVec2 = _loc14_;
                     _loc14_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  while(_loc22_ != _loc21_);
                  
               }
            }
            §§push(_loc3_);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§push(_loc4_.zpp_inner.x);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§pop().lineTo(§§pop(),_loc4_.zpp_inner.y);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc12_._isimmutable != null)
            {
               _loc12_._isimmutable();
            }
            if(_loc4_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc12_ = _loc4_.zpp_inner;
            _loc4_.zpp_inner.outer = null;
            _loc4_.zpp_inner = null;
            _loc9_ = _loc4_;
            _loc9_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc9_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc9_;
            }
            ZPP_PubPool.nextVec2 = _loc9_;
            _loc9_.zpp_disp = true;
            _loc23_ = _loc12_;
            if(_loc23_.outer != null)
            {
               _loc23_.outer.zpp_inner = null;
               _loc23_.outer = null;
            }
            _loc23_._isimmutable = null;
            _loc23_._validate = null;
            _loc23_._invalidate = null;
            _loc23_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc23_;
         }
         else
         {
            if(param1 is Array)
            {
               _loc6_ = param1;
               _loc7_ = 0;
               while(_loc7_ < int(_loc6_.length))
               {
                  _loc8_ = _loc6_[_loc7_];
                  _loc7_++;
                  if(_loc8_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains null objects";
                  }
                  if(!(_loc8_ is Vec2))
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains non Vec2 objects";
                  }
                  _loc9_ = _loc8_;
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = zpp_inner.xform.outer.transform(_loc9_);
                  if(_loc5_)
                  {
                     _loc4_ = _loc14_;
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  if(!_loc5_)
                  {
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc14_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     _loc14_.zpp_inner.outer = null;
                     _loc14_.zpp_inner = null;
                     _loc17_ = _loc14_;
                     _loc17_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc17_;
                     }
                     ZPP_PubPool.nextVec2 = _loc17_;
                     _loc17_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  _loc5_ = false;
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc16_ = param1;
               _loc7_ = 0;
               while(_loc7_ < _loc16_.length)
               {
                  _loc9_ = _loc16_[_loc7_];
                  _loc7_++;
                  if(_loc9_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: flash.Vector<Vec2> contains null objects";
                  }
                  _loc14_ = _loc9_;
                  if(_loc14_ != null && _loc14_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = zpp_inner.xform.outer.transform(_loc14_);
                  if(_loc5_)
                  {
                     _loc4_ = _loc17_;
                     §§push(_loc3_);
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc17_.zpp_inner.x);
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc17_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc17_.zpp_inner.x);
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc17_.zpp_inner.y);
                  }
                  if(!_loc5_)
                  {
                     if(_loc17_ != null && _loc17_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc17_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc17_.zpp_inner;
                     _loc17_.zpp_inner.outer = null;
                     _loc17_.zpp_inner = null;
                     _loc24_ = _loc17_;
                     _loc24_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc24_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc24_;
                     }
                     ZPP_PubPool.nextVec2 = _loc24_;
                     _loc24_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  _loc5_ = false;
               }
            }
            else if(param1 is Vec2List)
            {
               _loc18_ = param1;
               _loc19_ = _loc18_.iterator();
               while(true)
               {
                  _loc19_.zpp_inner.zpp_inner.valmod();
                  _loc7_ = _loc19_.zpp_inner.zpp_gl();
                  _loc19_.zpp_critical = true;
                  if(!(_loc19_.zpp_i < _loc7_ ? true : (_loc19_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc19_, _loc19_.zpp_inner = null, false)))
                  {
                     break;
                  }
                  _loc19_.zpp_critical = false;
                  _loc19_.zpp_i = (_loc7_ = _loc19_.zpp_i) + 1;
                  _loc9_ = _loc19_.zpp_inner.at(_loc7_);
                  if(_loc9_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2List contains null objects";
                  }
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = zpp_inner.xform.outer.transform(_loc9_);
                  if(_loc5_)
                  {
                     _loc4_ = _loc14_;
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  else
                  {
                     §§push(_loc3_);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc14_.zpp_inner.x);
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
                  }
                  if(!_loc5_)
                  {
                     if(_loc14_ != null && _loc14_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc14_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc14_.zpp_inner;
                     _loc14_.zpp_inner.outer = null;
                     _loc14_.zpp_inner = null;
                     _loc17_ = _loc14_;
                     _loc17_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc17_;
                     }
                     ZPP_PubPool.nextVec2 = _loc17_;
                     _loc17_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  _loc5_ = false;
               }
            }
            else
            {
               if(!(param1 is GeomPoly))
               {
                  Boot.lastError = new Error();
                  throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
               }
               _loc20_ = param1;
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
               }
               _loc21_ = _loc20_.zpp_inner.vertices;
               if(_loc21_ != null)
               {
                  _loc22_ = _loc21_;
                  do
                  {
                     _loc11_ = _loc22_.x;
                     _loc13_ = _loc22_.y;
                     _loc10_ = false;
                     if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc14_ = new Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
                        _loc14_.zpp_pool = null;
                        _loc14_.zpp_disp = false;
                        if(_loc14_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc14_.zpp_inner == null)
                     {
                        _loc15_ = false;
                        §§push(_loc14_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc12_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.weak = false;
                        _loc12_._immutable = _loc15_;
                        _loc12_.x = _loc11_;
                        _loc12_.y = _loc13_;
                        §§pop().zpp_inner = _loc12_;
                        _loc14_.zpp_inner.outer = _loc14_;
                     }
                     else
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc11_ != _loc11_ || _loc13_ != _loc13_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        if(_loc14_.zpp_inner.x == _loc11_)
                        {
                           §§pop();
                           if(_loc14_ != null && _loc14_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._validate != null)
                           {
                              _loc12_._validate();
                           }
                           §§push(_loc14_.zpp_inner.y == _loc13_);
                        }
                        if(!§§pop())
                        {
                           _loc14_.zpp_inner.x = _loc11_;
                           _loc14_.zpp_inner.y = _loc13_;
                           _loc12_ = _loc14_.zpp_inner;
                           if(_loc12_._invalidate != null)
                           {
                              _loc12_._invalidate(_loc12_);
                           }
                        }
                        _loc14_;
                     }
                     _loc14_.zpp_inner.weak = _loc10_;
                     _loc9_ = _loc14_;
                     _loc22_ = _loc22_.next;
                     _loc14_ = zpp_inner.xform.outer.transform(_loc9_);
                     if(_loc5_)
                     {
                        _loc4_ = _loc14_;
                        §§push(_loc3_);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§push(_loc14_.zpp_inner.x);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
                     }
                     else
                     {
                        §§push(_loc3_);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§push(_loc14_.zpp_inner.x);
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._validate != null)
                        {
                           _loc12_._validate();
                        }
                        §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
                     }
                     if(!_loc5_)
                     {
                        if(_loc14_ != null && _loc14_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        if(_loc12_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc12_._isimmutable != null)
                        {
                           _loc12_._isimmutable();
                        }
                        if(_loc14_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc12_ = _loc14_.zpp_inner;
                        _loc14_.zpp_inner.outer = null;
                        _loc14_.zpp_inner = null;
                        _loc17_ = _loc14_;
                        _loc17_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc17_;
                        }
                        ZPP_PubPool.nextVec2 = _loc17_;
                        _loc17_.zpp_disp = true;
                        _loc23_ = _loc12_;
                        if(_loc23_.outer != null)
                        {
                           _loc23_.outer.zpp_inner = null;
                           _loc23_.outer = null;
                        }
                        _loc23_._isimmutable = null;
                        _loc23_._validate = null;
                        _loc23_._invalidate = null;
                        _loc23_.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc23_;
                     }
                     _loc5_ = false;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc9_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     _loc9_.zpp_inner.outer = null;
                     _loc9_.zpp_inner = null;
                     _loc14_ = _loc9_;
                     _loc14_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc14_;
                     }
                     ZPP_PubPool.nextVec2 = _loc14_;
                     _loc14_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                  }
                  while(_loc22_ != _loc21_);
                  
               }
            }
            §§push(_loc3_);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§push(_loc4_.zpp_inner.x);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§pop().lineTo(§§pop(),_loc4_.zpp_inner.y);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc4_.zpp_inner;
            if(_loc12_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc12_._isimmutable != null)
            {
               _loc12_._isimmutable();
            }
            if(_loc4_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc12_ = _loc4_.zpp_inner;
            _loc4_.zpp_inner.outer = null;
            _loc4_.zpp_inner = null;
            _loc9_ = _loc4_;
            _loc9_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc9_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc9_;
            }
            ZPP_PubPool.nextVec2 = _loc9_;
            _loc9_.zpp_disp = true;
            _loc23_ = _loc12_;
            if(_loc23_.outer != null)
            {
               _loc23_.outer.zpp_inner = null;
               _loc23_.outer = null;
            }
            _loc23_._isimmutable = null;
            _loc23_._validate = null;
            _loc23_._invalidate = null;
            _loc23_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc23_;
         }
         _loc3_.endFill();
         if(param1 is Array)
         {
            _loc6_ = param1;
            _loc7_ = 0;
            while(_loc7_ < int(_loc6_.length))
            {
               _loc9_ = _loc6_[_loc7_];
               if(_loc9_.zpp_inner.weak)
               {
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc12_ = _loc9_.zpp_inner;
                  if(_loc12_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc12_._isimmutable != null)
                  {
                     _loc12_._isimmutable();
                  }
                  if(_loc9_.zpp_inner._inuse)
                  {
                     Boot.lastError = new Error();
                     throw "Error: This Vec2 is not disposable";
                  }
                  _loc12_ = _loc9_.zpp_inner;
                  _loc9_.zpp_inner.outer = null;
                  _loc9_.zpp_inner = null;
                  _loc14_ = _loc9_;
                  _loc14_.zpp_pool = null;
                  if(ZPP_PubPool.nextVec2 != null)
                  {
                     ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                  }
                  else
                  {
                     ZPP_PubPool.poolVec2 = _loc14_;
                  }
                  ZPP_PubPool.nextVec2 = _loc14_;
                  _loc14_.zpp_disp = true;
                  _loc23_ = _loc12_;
                  if(_loc23_.outer != null)
                  {
                     _loc23_.outer.zpp_inner = null;
                     _loc23_.outer = null;
                  }
                  _loc23_._isimmutable = null;
                  _loc23_._validate = null;
                  _loc23_._invalidate = null;
                  _loc23_.next = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc23_;
                  §§push(true);
               }
               else
               {
                  §§push(false);
               }
               if(§§pop())
               {
                  _loc6_.splice(_loc7_,1);
               }
               else
               {
                  _loc7_++;
               }
            }
         }
         else if(param1 is ZPP_Const.vec2vector)
         {
            _loc16_ = param1;
            if(!_loc16_.fixed)
            {
               _loc7_ = 0;
               while(_loc7_ < int(_loc16_.length))
               {
                  _loc9_ = _loc16_[_loc7_];
                  if(_loc9_.zpp_inner.weak)
                  {
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     if(_loc12_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc12_._isimmutable != null)
                     {
                        _loc12_._isimmutable();
                     }
                     if(_loc9_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc12_ = _loc9_.zpp_inner;
                     _loc9_.zpp_inner.outer = null;
                     _loc9_.zpp_inner = null;
                     _loc14_ = _loc9_;
                     _loc14_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc14_;
                     }
                     ZPP_PubPool.nextVec2 = _loc14_;
                     _loc14_.zpp_disp = true;
                     _loc23_ = _loc12_;
                     if(_loc23_.outer != null)
                     {
                        _loc23_.outer.zpp_inner = null;
                        _loc23_.outer = null;
                     }
                     _loc23_._isimmutable = null;
                     _loc23_._validate = null;
                     _loc23_._invalidate = null;
                     _loc23_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc23_;
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  if(§§pop())
                  {
                     _loc16_.splice(_loc7_,1);
                  }
                  else
                  {
                     _loc7_++;
                  }
               }
            }
         }
         else if(param1 is Vec2List)
         {
            _loc18_ = param1;
            if(_loc18_.zpp_inner._validate != null)
            {
               _loc18_.zpp_inner._validate();
            }
            _loc25_ = _loc18_.zpp_inner.inner;
            _loc26_ = null;
            _loc27_ = _loc25_.head;
            while(_loc27_ != null)
            {
               _loc12_ = _loc27_.elt;
               if(_loc12_.outer.zpp_inner.weak)
               {
                  _loc27_ = _loc25_.erase(_loc26_);
                  if(_loc12_.outer.zpp_inner.weak)
                  {
                     _loc9_ = _loc12_.outer;
                     if(_loc9_ != null && _loc9_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc23_ = _loc9_.zpp_inner;
                     if(_loc23_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc23_._isimmutable != null)
                     {
                        _loc23_._isimmutable();
                     }
                     if(_loc9_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc23_ = _loc9_.zpp_inner;
                     _loc9_.zpp_inner.outer = null;
                     _loc9_.zpp_inner = null;
                     _loc14_ = _loc9_;
                     _loc14_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc14_;
                     }
                     ZPP_PubPool.nextVec2 = _loc14_;
                     _loc14_.zpp_disp = true;
                     _loc28_ = _loc23_;
                     if(_loc28_.outer != null)
                     {
                        _loc28_.outer.zpp_inner = null;
                        _loc28_.outer = null;
                     }
                     _loc28_._isimmutable = null;
                     _loc28_._validate = null;
                     _loc28_._invalidate = null;
                     _loc28_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc28_;
                     true;
                  }
                  else
                  {
                     false;
                  }
               }
               else
               {
                  _loc26_ = _loc27_;
                  _loc27_ = _loc27_.next;
               }
            }
         }
      }
      
      override public function drawFilledCircle(param1:Vec2, param2:Number, param3:int) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawFilledCircle::position cannot be null";
         }
         if(param2 != param2 || param2 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: drawFilledCircle::radius must be >=0";
         }
         var _loc4_:Graphics = zpp_inner_zn.graphics;
         _loc4_.lineStyle(0,0,0);
         _loc4_.beginFill(param3 & 0xFFFFFF,1);
         if(zpp_inner.xnull)
         {
            §§push(_loc4_);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(param1.zpp_inner.x);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§pop().drawCircle(§§pop(),param1.zpp_inner.y,param2);
            if(param1.zpp_inner.weak)
            {
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = param1.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(param1.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = param1.zpp_inner;
               param1.zpp_inner.outer = null;
               param1.zpp_inner = null;
               _loc6_ = param1;
               _loc6_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc6_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc6_;
               }
               ZPP_PubPool.nextVec2 = _loc6_;
               _loc6_.zpp_disp = true;
               _loc7_ = _loc5_;
               if(_loc7_.outer != null)
               {
                  _loc7_.outer.zpp_inner = null;
                  _loc7_.outer = null;
               }
               _loc7_._isimmutable = null;
               _loc7_._validate = null;
               _loc7_._invalidate = null;
               _loc7_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc7_;
               true;
            }
            else
            {
               false;
            }
         }
         else
         {
            _loc6_ = zpp_inner.xform.outer.transform(param1);
            §§push(_loc4_);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(_loc6_.zpp_inner.x);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§pop().drawCircle(§§pop(),_loc6_.zpp_inner.y,param2 * zpp_inner.xdet);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc6_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc6_.zpp_inner;
            _loc6_.zpp_inner.outer = null;
            _loc6_.zpp_inner = null;
            _loc8_ = _loc6_;
            _loc8_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc8_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc8_;
            }
            ZPP_PubPool.nextVec2 = _loc8_;
            _loc8_.zpp_disp = true;
            _loc7_ = _loc5_;
            if(_loc7_.outer != null)
            {
               _loc7_.outer.zpp_inner = null;
               _loc7_.outer = null;
            }
            _loc7_._isimmutable = null;
            _loc7_._validate = null;
            _loc7_._invalidate = null;
            _loc7_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc7_;
         }
         _loc4_.endFill();
      }
      
      override public function drawCurve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as Vec2;
         var _loc11_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::start cannot be null";
         }
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::control cannot be null";
         }
         if(param3 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::end cannot be null";
         }
         var _loc5_:Graphics = zpp_inner_zn.graphics;
         _loc5_.lineStyle(0.1,param4 & 0xFFFFFF,1);
         if(zpp_inner.xnull)
         {
            §§push(_loc5_);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param1.zpp_inner.x);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().moveTo(§§pop(),param1.zpp_inner.y);
            §§push(_loc5_);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param2.zpp_inner.x);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param2.zpp_inner.y);
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param3.zpp_inner.x);
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().curveTo(§§pop(),§§pop(),§§pop(),param3.zpp_inner.y);
            if(param1.zpp_inner.weak)
            {
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = param1.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(param1.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc6_ = param1.zpp_inner;
               param1.zpp_inner.outer = null;
               param1.zpp_inner = null;
               _loc7_ = param1;
               _loc7_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc7_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc7_;
               }
               ZPP_PubPool.nextVec2 = _loc7_;
               _loc7_.zpp_disp = true;
               _loc8_ = _loc6_;
               if(_loc8_.outer != null)
               {
                  _loc8_.outer.zpp_inner = null;
                  _loc8_.outer = null;
               }
               _loc8_._isimmutable = null;
               _loc8_._validate = null;
               _loc8_._invalidate = null;
               _loc8_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc8_;
               true;
            }
            else
            {
               false;
            }
            if(param2.zpp_inner.weak)
            {
               if(param2 != null && param2.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = param2.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(param2.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc6_ = param2.zpp_inner;
               param2.zpp_inner.outer = null;
               param2.zpp_inner = null;
               _loc7_ = param2;
               _loc7_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc7_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc7_;
               }
               ZPP_PubPool.nextVec2 = _loc7_;
               _loc7_.zpp_disp = true;
               _loc8_ = _loc6_;
               if(_loc8_.outer != null)
               {
                  _loc8_.outer.zpp_inner = null;
                  _loc8_.outer = null;
               }
               _loc8_._isimmutable = null;
               _loc8_._validate = null;
               _loc8_._invalidate = null;
               _loc8_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc8_;
               true;
            }
            else
            {
               false;
            }
            if(param3.zpp_inner.weak)
            {
               if(param3 != null && param3.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = param3.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(param3.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc6_ = param3.zpp_inner;
               param3.zpp_inner.outer = null;
               param3.zpp_inner = null;
               _loc7_ = param3;
               _loc7_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc7_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc7_;
               }
               ZPP_PubPool.nextVec2 = _loc7_;
               _loc7_.zpp_disp = true;
               _loc8_ = _loc6_;
               if(_loc8_.outer != null)
               {
                  _loc8_.outer.zpp_inner = null;
                  _loc8_.outer = null;
               }
               _loc8_._isimmutable = null;
               _loc8_._validate = null;
               _loc8_._invalidate = null;
               _loc8_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc8_;
               true;
            }
            else
            {
               false;
            }
         }
         else
         {
            _loc7_ = zpp_inner.xform.outer.transform(param1);
            _loc9_ = zpp_inner.xform.outer.transform(param2);
            _loc10_ = zpp_inner.xform.outer.transform(param3);
            §§push(_loc5_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc7_.zpp_inner.x);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().moveTo(§§pop(),_loc7_.zpp_inner.y);
            §§push(_loc5_);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc9_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc9_.zpp_inner.x);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc9_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc9_.zpp_inner.y);
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc10_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc10_.zpp_inner.x);
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc10_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().curveTo(§§pop(),§§pop(),§§pop(),_loc10_.zpp_inner.y);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc7_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc7_.zpp_inner;
            _loc7_.zpp_inner.outer = null;
            _loc7_.zpp_inner = null;
            _loc11_ = _loc7_;
            _loc11_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc11_;
            }
            ZPP_PubPool.nextVec2 = _loc11_;
            _loc11_.zpp_disp = true;
            _loc8_ = _loc6_;
            if(_loc8_.outer != null)
            {
               _loc8_.outer.zpp_inner = null;
               _loc8_.outer = null;
            }
            _loc8_._isimmutable = null;
            _loc8_._validate = null;
            _loc8_._invalidate = null;
            _loc8_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc8_;
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc9_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc9_.zpp_inner;
            _loc9_.zpp_inner.outer = null;
            _loc9_.zpp_inner = null;
            _loc11_ = _loc9_;
            _loc11_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc11_;
            }
            ZPP_PubPool.nextVec2 = _loc11_;
            _loc11_.zpp_disp = true;
            _loc8_ = _loc6_;
            if(_loc8_.outer != null)
            {
               _loc8_.outer.zpp_inner = null;
               _loc8_.outer = null;
            }
            _loc8_._isimmutable = null;
            _loc8_._validate = null;
            _loc8_._invalidate = null;
            _loc8_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc8_;
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc10_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc10_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc10_.zpp_inner;
            _loc10_.zpp_inner.outer = null;
            _loc10_.zpp_inner = null;
            _loc11_ = _loc10_;
            _loc11_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc11_;
            }
            ZPP_PubPool.nextVec2 = _loc11_;
            _loc11_.zpp_disp = true;
            _loc8_ = _loc6_;
            if(_loc8_.outer != null)
            {
               _loc8_.outer.zpp_inner = null;
               _loc8_.outer = null;
            }
            _loc8_._isimmutable = null;
            _loc8_._validate = null;
            _loc8_._invalidate = null;
            _loc8_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc8_;
         }
      }
      
      override public function drawCircle(param1:Vec2, param2:Number, param3:int) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCircle::position cannot be null";
         }
         if(param2 != param2 || param2 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: drawCircle::radius must be >=0";
         }
         var _loc4_:Graphics = zpp_inner_zn.graphics;
         _loc4_.lineStyle(0.1,param3 & 0xFFFFFF,1);
         if(zpp_inner.xnull)
         {
            §§push(_loc4_);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(param1.zpp_inner.x);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§pop().drawCircle(§§pop(),param1.zpp_inner.y,param2);
            if(param1.zpp_inner.weak)
            {
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = param1.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(param1.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = param1.zpp_inner;
               param1.zpp_inner.outer = null;
               param1.zpp_inner = null;
               _loc6_ = param1;
               _loc6_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc6_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc6_;
               }
               ZPP_PubPool.nextVec2 = _loc6_;
               _loc6_.zpp_disp = true;
               _loc7_ = _loc5_;
               if(_loc7_.outer != null)
               {
                  _loc7_.outer.zpp_inner = null;
                  _loc7_.outer = null;
               }
               _loc7_._isimmutable = null;
               _loc7_._validate = null;
               _loc7_._invalidate = null;
               _loc7_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc7_;
               true;
            }
            else
            {
               false;
            }
         }
         else
         {
            _loc6_ = zpp_inner.xform.outer.transform(param1);
            §§push(_loc4_);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(_loc6_.zpp_inner.x);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§pop().drawCircle(§§pop(),_loc6_.zpp_inner.y,param2 * zpp_inner.xdet);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc6_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc6_.zpp_inner;
            _loc6_.zpp_inner.outer = null;
            _loc6_.zpp_inner = null;
            _loc8_ = _loc6_;
            _loc8_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc8_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc8_;
            }
            ZPP_PubPool.nextVec2 = _loc8_;
            _loc8_.zpp_disp = true;
            _loc7_ = _loc5_;
            if(_loc7_.outer != null)
            {
               _loc7_.outer.zpp_inner = null;
               _loc7_.outer = null;
            }
            _loc7_._isimmutable = null;
            _loc7_._validate = null;
            _loc7_._invalidate = null;
            _loc7_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc7_;
         }
      }
      
      override public function drawAABB(param1:AABB, param2:int) : void
      {
         var _loc4_:* = null as ZPP_AABB;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as Vec2;
         var _loc10_:Boolean = false;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as Vec2;
         var _loc13_:* = null as Vec2;
         var _loc14_:* = null as Vec2;
         var _loc15_:* = null as ZPP_Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawAABB::aabb cannot be null";
         }
         var _loc3_:Graphics = zpp_inner_zn.graphics;
         _loc3_.lineStyle(0.1,param2 & 0xFFFFFF,1);
         if(zpp_inner.xnull)
         {
            _loc4_ = param1.zpp_inner;
            §§push(_loc3_);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§push(param1.zpp_inner.minx);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§push(param1.zpp_inner.miny);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            _loc4_ = param1.zpp_inner;
            §§push(_loc4_.maxx - _loc4_.minx);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§pop().drawRect(§§pop(),§§pop(),§§pop(),_loc4_.maxy - _loc4_.miny);
         }
         else
         {
            _loc5_ = zpp_inner.xform.outer.transform(param1.zpp_inner.getmin());
            _loc4_ = param1.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            _loc7_ = _loc4_.maxx - _loc4_.minx;
            _loc8_ = false;
            if(_loc7_ != _loc7_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc9_ = new Vec2();
            }
            else
            {
               _loc9_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc9_.zpp_pool;
               _loc9_.zpp_pool = null;
               _loc9_.zpp_disp = false;
               if(_loc9_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc9_.zpp_inner == null)
            {
               _loc10_ = false;
               §§push(_loc9_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc11_ = new ZPP_Vec2();
               }
               else
               {
                  _loc11_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.weak = false;
               _loc11_._immutable = _loc10_;
               _loc11_.x = _loc7_;
               _loc11_.y = 0;
               §§pop().zpp_inner = _loc11_;
               _loc9_.zpp_inner.outer = _loc9_;
            }
            else
            {
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc11_._isimmutable != null)
               {
                  _loc11_._isimmutable();
               }
               if(_loc7_ != _loc7_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               if(_loc9_.zpp_inner.x == _loc7_)
               {
                  §§pop();
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  §§push(_loc9_.zpp_inner.y == 0);
               }
               if(!§§pop())
               {
                  _loc9_.zpp_inner.x = _loc7_;
                  _loc9_.zpp_inner.y = 0;
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._invalidate != null)
                  {
                     _loc11_._invalidate(_loc11_);
                  }
               }
               _loc9_;
            }
            _loc9_.zpp_inner.weak = _loc8_;
            _loc6_ = _loc9_;
            _loc9_ = zpp_inner.xform.outer.transform(_loc6_,true);
            _loc4_ = param1.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            _loc7_ = _loc4_.maxy - _loc4_.miny;
            _loc8_ = false;
            if(_loc7_ != _loc7_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc13_ = new Vec2();
            }
            else
            {
               _loc13_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc13_.zpp_pool;
               _loc13_.zpp_pool = null;
               _loc13_.zpp_disp = false;
               if(_loc13_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc13_.zpp_inner == null)
            {
               _loc10_ = false;
               §§push(_loc13_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc11_ = new ZPP_Vec2();
               }
               else
               {
                  _loc11_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.weak = false;
               _loc11_._immutable = _loc10_;
               _loc11_.x = _loc7_;
               _loc11_.y = 0;
               §§pop().zpp_inner = _loc11_;
               _loc13_.zpp_inner.outer = _loc13_;
            }
            else
            {
               if(_loc13_ != null && _loc13_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc13_.zpp_inner;
               if(_loc11_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc11_._isimmutable != null)
               {
                  _loc11_._isimmutable();
               }
               if(_loc7_ != _loc7_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc13_ != null && _loc13_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc13_.zpp_inner;
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               if(_loc13_.zpp_inner.x == _loc7_)
               {
                  §§pop();
                  if(_loc13_ != null && _loc13_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc13_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  §§push(_loc13_.zpp_inner.y == 0);
               }
               if(!§§pop())
               {
                  _loc13_.zpp_inner.x = _loc7_;
                  _loc13_.zpp_inner.y = 0;
                  _loc11_ = _loc13_.zpp_inner;
                  if(_loc11_._invalidate != null)
                  {
                     _loc11_._invalidate(_loc11_);
                  }
               }
               _loc13_;
            }
            _loc13_.zpp_inner.weak = _loc8_;
            _loc12_ = _loc13_;
            _loc13_ = zpp_inner.xform.outer.transform(_loc12_,true);
            §§push(_loc3_);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(_loc5_.zpp_inner.x);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§pop().moveTo(§§pop(),_loc5_.zpp_inner.y);
            §§push(_loc3_);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(_loc5_.zpp_inner.x);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc9_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(§§pop() + _loc9_.zpp_inner.x);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(_loc5_.zpp_inner.y);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc9_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§pop().lineTo(§§pop(),§§pop() + _loc9_.zpp_inner.y);
            §§push(_loc3_);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(_loc5_.zpp_inner.x);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc9_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(§§pop() + _loc9_.zpp_inner.x);
            if(_loc13_ != null && _loc13_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc13_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(§§pop() + _loc13_.zpp_inner.x);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(_loc5_.zpp_inner.y);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc9_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(§§pop() + _loc9_.zpp_inner.y);
            if(_loc13_ != null && _loc13_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc13_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§pop().lineTo(§§pop(),§§pop() + _loc13_.zpp_inner.y);
            §§push(_loc3_);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(_loc5_.zpp_inner.x);
            if(_loc13_ != null && _loc13_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc13_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(§§pop() + _loc13_.zpp_inner.x);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(_loc5_.zpp_inner.y);
            if(_loc13_ != null && _loc13_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc13_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§pop().lineTo(§§pop(),§§pop() + _loc13_.zpp_inner.y);
            §§push(_loc3_);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§push(_loc5_.zpp_inner.x);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            §§pop().lineTo(§§pop(),_loc5_.zpp_inner.y);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc5_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
            }
            if(_loc5_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc11_ = _loc5_.zpp_inner;
            _loc5_.zpp_inner.outer = null;
            _loc5_.zpp_inner = null;
            _loc14_ = _loc5_;
            _loc14_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc14_;
            }
            ZPP_PubPool.nextVec2 = _loc14_;
            _loc14_.zpp_disp = true;
            _loc15_ = _loc11_;
            if(_loc15_.outer != null)
            {
               _loc15_.outer.zpp_inner = null;
               _loc15_.outer = null;
            }
            _loc15_._isimmutable = null;
            _loc15_._validate = null;
            _loc15_._invalidate = null;
            _loc15_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc15_;
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc6_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
            }
            if(_loc6_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc11_ = _loc6_.zpp_inner;
            _loc6_.zpp_inner.outer = null;
            _loc6_.zpp_inner = null;
            _loc14_ = _loc6_;
            _loc14_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc14_;
            }
            ZPP_PubPool.nextVec2 = _loc14_;
            _loc14_.zpp_disp = true;
            _loc15_ = _loc11_;
            if(_loc15_.outer != null)
            {
               _loc15_.outer.zpp_inner = null;
               _loc15_.outer = null;
            }
            _loc15_._isimmutable = null;
            _loc15_._validate = null;
            _loc15_._invalidate = null;
            _loc15_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc15_;
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc9_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc11_ = _loc9_.zpp_inner;
            _loc9_.zpp_inner.outer = null;
            _loc9_.zpp_inner = null;
            _loc14_ = _loc9_;
            _loc14_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc14_;
            }
            ZPP_PubPool.nextVec2 = _loc14_;
            _loc14_.zpp_disp = true;
            _loc15_ = _loc11_;
            if(_loc15_.outer != null)
            {
               _loc15_.outer.zpp_inner = null;
               _loc15_.outer = null;
            }
            _loc15_._isimmutable = null;
            _loc15_._validate = null;
            _loc15_._invalidate = null;
            _loc15_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc15_;
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc12_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
            }
            if(_loc12_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc11_ = _loc12_.zpp_inner;
            _loc12_.zpp_inner.outer = null;
            _loc12_.zpp_inner = null;
            _loc14_ = _loc12_;
            _loc14_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc14_;
            }
            ZPP_PubPool.nextVec2 = _loc14_;
            _loc14_.zpp_disp = true;
            _loc15_ = _loc11_;
            if(_loc15_.outer != null)
            {
               _loc15_.outer.zpp_inner = null;
               _loc15_.outer = null;
            }
            _loc15_._isimmutable = null;
            _loc15_._validate = null;
            _loc15_._invalidate = null;
            _loc15_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc15_;
            if(_loc13_ != null && _loc13_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc13_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
            }
            if(_loc13_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc11_ = _loc13_.zpp_inner;
            _loc13_.zpp_inner.outer = null;
            _loc13_.zpp_inner = null;
            _loc14_ = _loc13_;
            _loc14_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc14_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc14_;
            }
            ZPP_PubPool.nextVec2 = _loc14_;
            _loc14_.zpp_disp = true;
            _loc15_ = _loc11_;
            if(_loc15_.outer != null)
            {
               _loc15_.outer.zpp_inner = null;
               _loc15_.outer = null;
            }
            _loc15_._isimmutable = null;
            _loc15_._validate = null;
            _loc15_._invalidate = null;
            _loc15_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc15_;
         }
      }
      
      override public function draw(param1:*) : void
      {
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(zpp_inner.xnull)
         {
            if(param1 is Space)
            {
               zpp_inner_zn.draw_space(param1.zpp_inner,null,1,true);
            }
            else if(param1 is Compound)
            {
               zpp_inner_zn.draw_compound(param1.zpp_inner,null,1,true);
            }
            else if(param1 is Body)
            {
               zpp_inner_zn.draw_body(param1.zpp_inner,null,1,true);
            }
            else if(param1 is Shape)
            {
               zpp_inner_zn.draw_shape(param1.zpp_inner,null,1,true);
            }
            else
            {
               if(!(param1 is Constraint))
               {
                  Boot.lastError = new Error();
                  throw "Error: Unhandled object type for Debug draw";
               }
               param1.zpp_inner.draw(this);
            }
         }
         else if(param1 is Space)
         {
            zpp_inner_zn.draw_space(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else if(param1 is Body)
         {
            zpp_inner_zn.draw_body(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else if(param1 is Shape)
         {
            zpp_inner_zn.draw_shape(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else
         {
            if(!(param1 is Constraint))
            {
               Boot.lastError = new Error();
               throw "Error: Unhandled object type for Debug draw";
            }
            param1.zpp_inner.draw(this);
         }
      }
      
      override public function clear() : void
      {
         zpp_inner_zn.graphics.clear();
      }
   }
}

