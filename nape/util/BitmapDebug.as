package nape.util
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
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
   import zpp_nape.util.ZPP_BitmapDebug;
   import zpp_nape.util.ZPP_Debug;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class BitmapDebug extends Debug
   {
      public var zpp_inner_zn:ZPP_BitmapDebug;
      
      public function BitmapDebug(param1:int, param2:int, param3:int = 3355443, param4:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
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
         zpp_inner_zn = new ZPP_BitmapDebug(param1,param2,param3,param4);
         zpp_inner_zn.outer_zn = this;
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
      }
      
      public function prepare() : void
      {
         zpp_inner_zn.prepare();
      }
      
      override public function flush() : void
      {
         zpp_inner_zn.flush();
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
         var _loc9_:* = null as Array;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:* = null as Vec2;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Boolean = false;
         var _loc16_:* = null as ZPP_Vec2;
         var _loc17_:Boolean = false;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:* = null as Vec2;
         var _loc21_:Boolean = false;
         var _loc22_:* = null as Vec2;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as Vector.<Vec2>;
         var _loc25_:* = null as Vec2;
         var _loc26_:* = null as Vec2List;
         var _loc27_:* = null as Vec2Iterator;
         var _loc28_:* = null as GeomPoly;
         var _loc29_:* = null as ZPP_GeomVert;
         var _loc30_:* = null as ZPP_GeomVert;
         var _loc31_:* = null as ZNPList_ZPP_Vec2;
         var _loc32_:* = null as ZNPNode_ZPP_Vec2;
         var _loc33_:* = null as ZNPNode_ZPP_Vec2;
         var _loc34_:* = null as ZPP_Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot draw null Vec2 list";
         }
         var _loc3_:int = param2 | -16777216;
         var _loc6_:Vec2 = null;
         var _loc5_:int;
         var _loc7_:int;
         var _loc8_:int;
         var _loc4_:int = _loc5_ = _loc7_ = _loc8_ = 0;
         if(param1 is Array)
         {
            _loc9_ = param1;
            _loc10_ = 0;
            while(_loc10_ < int(_loc9_.length))
            {
               _loc11_ = _loc9_[_loc10_];
               _loc10_++;
               if(_loc11_ == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Array<Vec2> contains null objects";
               }
               if(!(_loc11_ is Vec2))
               {
                  Boot.lastError = new Error();
                  throw "Error: Array<Vec2> contains non Vec2 objects";
               }
               _loc12_ = _loc11_;
               if(_loc12_ != null && _loc12_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc6_ == null;
               if(zpp_inner.xnull)
               {
                  if(_loc12_ != null && _loc12_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc12_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = int(_loc12_.zpp_inner.x + 0.5);
                  if(_loc12_ != null && _loc12_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc12_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc14_ = int(_loc12_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc17_ = false;
                     if(_loc12_ != null && _loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc18_ = _loc12_.zpp_inner.x;
                     if(_loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc19_ = _loc12_.zpp_inner.y;
                     if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc20_ = new Vec2();
                     }
                     else
                     {
                        _loc20_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc20_.zpp_pool;
                        _loc20_.zpp_pool = null;
                        _loc20_.zpp_disp = false;
                        if(_loc20_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc20_.zpp_inner == null)
                     {
                        _loc21_ = false;
                        §§push(_loc20_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc16_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc16_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc16_.next;
                           _loc16_.next = null;
                        }
                        _loc16_.weak = false;
                        _loc16_._immutable = _loc21_;
                        _loc16_.x = _loc18_;
                        _loc16_.y = _loc19_;
                        §§pop().zpp_inner = _loc16_;
                        _loc20_.zpp_inner.outer = _loc20_;
                     }
                     else
                     {
                        if(_loc20_ != null && _loc20_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc20_.zpp_inner;
                        if(_loc16_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc16_._isimmutable != null)
                        {
                           _loc16_._isimmutable();
                        }
                        if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc20_ != null && _loc20_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc20_.zpp_inner;
                        if(_loc16_._validate != null)
                        {
                           _loc16_._validate();
                        }
                        if(_loc20_.zpp_inner.x == _loc18_)
                        {
                           §§pop();
                           if(_loc20_ != null && _loc20_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc16_ = _loc20_.zpp_inner;
                           if(_loc16_._validate != null)
                           {
                              _loc16_._validate();
                           }
                           §§push(_loc20_.zpp_inner.y == _loc19_);
                        }
                        if(!§§pop())
                        {
                           _loc20_.zpp_inner.x = _loc18_;
                           _loc20_.zpp_inner.y = _loc19_;
                           _loc16_ = _loc20_.zpp_inner;
                           if(_loc16_._invalidate != null)
                           {
                              _loc16_._invalidate(_loc16_);
                           }
                        }
                        _loc20_;
                     }
                     _loc20_.zpp_inner.weak = _loc17_;
                     _loc6_ = _loc20_;
                  }
               }
               else
               {
                  _loc20_ = zpp_inner.xform.outer.transform(_loc12_);
                  if(_loc20_ != null && _loc20_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = int(_loc20_.zpp_inner.x + 0.5);
                  if(_loc20_ != null && _loc20_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc14_ = int(_loc20_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc6_ = _loc20_;
                  }
                  else
                  {
                     if(_loc20_ != null && _loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc16_._isimmutable != null)
                     {
                        _loc16_._isimmutable();
                     }
                     if(_loc20_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     _loc20_.zpp_inner.outer = null;
                     _loc20_.zpp_inner = null;
                     _loc22_ = _loc20_;
                     _loc22_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc22_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc22_;
                     }
                     ZPP_PubPool.nextVec2 = _loc22_;
                     _loc22_.zpp_disp = true;
                     _loc23_ = _loc16_;
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
               }
               if(_loc15_)
               {
                  _loc4_ = _loc7_ = _loc13_;
                  _loc5_ = _loc8_ = _loc14_;
               }
               else
               {
                  zpp_inner_zn.__line(_loc7_,_loc8_,_loc13_,_loc14_,_loc3_);
                  _loc7_ = _loc13_;
                  _loc8_ = _loc14_;
               }
            }
         }
         else if(param1 is ZPP_Const.vec2vector)
         {
            _loc24_ = param1;
            _loc10_ = 0;
            while(_loc10_ < _loc24_.length)
            {
               _loc12_ = _loc24_[_loc10_];
               _loc10_++;
               if(_loc12_ == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: flash.Vector<Vec2> contains null objects";
               }
               _loc20_ = _loc12_;
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc6_ == null;
               if(zpp_inner.xnull)
               {
                  if(_loc20_ != null && _loc20_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = int(_loc20_.zpp_inner.x + 0.5);
                  if(_loc20_ != null && _loc20_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc14_ = int(_loc20_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc17_ = false;
                     if(_loc20_ != null && _loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc18_ = _loc20_.zpp_inner.x;
                     if(_loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc19_ = _loc20_.zpp_inner.y;
                     if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc22_ = new Vec2();
                     }
                     else
                     {
                        _loc22_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc22_.zpp_pool;
                        _loc22_.zpp_pool = null;
                        _loc22_.zpp_disp = false;
                        if(_loc22_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc22_.zpp_inner == null)
                     {
                        _loc21_ = false;
                        §§push(_loc22_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc16_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc16_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc16_.next;
                           _loc16_.next = null;
                        }
                        _loc16_.weak = false;
                        _loc16_._immutable = _loc21_;
                        _loc16_.x = _loc18_;
                        _loc16_.y = _loc19_;
                        §§pop().zpp_inner = _loc16_;
                        _loc22_.zpp_inner.outer = _loc22_;
                     }
                     else
                     {
                        if(_loc22_ != null && _loc22_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc22_.zpp_inner;
                        if(_loc16_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc16_._isimmutable != null)
                        {
                           _loc16_._isimmutable();
                        }
                        if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc22_ != null && _loc22_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc22_.zpp_inner;
                        if(_loc16_._validate != null)
                        {
                           _loc16_._validate();
                        }
                        if(_loc22_.zpp_inner.x == _loc18_)
                        {
                           §§pop();
                           if(_loc22_ != null && _loc22_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc16_ = _loc22_.zpp_inner;
                           if(_loc16_._validate != null)
                           {
                              _loc16_._validate();
                           }
                           §§push(_loc22_.zpp_inner.y == _loc19_);
                        }
                        if(!§§pop())
                        {
                           _loc22_.zpp_inner.x = _loc18_;
                           _loc22_.zpp_inner.y = _loc19_;
                           _loc16_ = _loc22_.zpp_inner;
                           if(_loc16_._invalidate != null)
                           {
                              _loc16_._invalidate(_loc16_);
                           }
                        }
                        _loc22_;
                     }
                     _loc22_.zpp_inner.weak = _loc17_;
                     _loc6_ = _loc22_;
                  }
               }
               else
               {
                  _loc22_ = zpp_inner.xform.outer.transform(_loc20_);
                  if(_loc22_ != null && _loc22_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc22_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = int(_loc22_.zpp_inner.x + 0.5);
                  if(_loc22_ != null && _loc22_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc22_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc14_ = int(_loc22_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc6_ = _loc22_;
                  }
                  else
                  {
                     if(_loc22_ != null && _loc22_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc22_.zpp_inner;
                     if(_loc16_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc16_._isimmutable != null)
                     {
                        _loc16_._isimmutable();
                     }
                     if(_loc22_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc16_ = _loc22_.zpp_inner;
                     _loc22_.zpp_inner.outer = null;
                     _loc22_.zpp_inner = null;
                     _loc25_ = _loc22_;
                     _loc25_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc25_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc25_;
                     }
                     ZPP_PubPool.nextVec2 = _loc25_;
                     _loc25_.zpp_disp = true;
                     _loc23_ = _loc16_;
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
               }
               if(_loc15_)
               {
                  _loc4_ = _loc7_ = _loc13_;
                  _loc5_ = _loc8_ = _loc14_;
               }
               else
               {
                  zpp_inner_zn.__line(_loc7_,_loc8_,_loc13_,_loc14_,_loc3_);
                  _loc7_ = _loc13_;
                  _loc8_ = _loc14_;
               }
            }
         }
         else if(param1 is Vec2List)
         {
            _loc26_ = param1;
            _loc27_ = _loc26_.iterator();
            while(true)
            {
               _loc27_.zpp_inner.zpp_inner.valmod();
               _loc10_ = _loc27_.zpp_inner.zpp_gl();
               _loc27_.zpp_critical = true;
               if(!(_loc27_.zpp_i < _loc10_ ? true : (_loc27_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc27_, _loc27_.zpp_inner = null, false)))
               {
                  break;
               }
               _loc27_.zpp_critical = false;
               _loc27_.zpp_i = (_loc10_ = _loc27_.zpp_i) + 1;
               _loc12_ = _loc27_.zpp_inner.at(_loc10_);
               if(_loc12_ == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2List contains null objects";
               }
               if(_loc12_ != null && _loc12_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc6_ == null;
               if(zpp_inner.xnull)
               {
                  if(_loc12_ != null && _loc12_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc12_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc10_ = int(_loc12_.zpp_inner.x + 0.5);
                  if(_loc12_ != null && _loc12_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc12_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = int(_loc12_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc17_ = false;
                     if(_loc12_ != null && _loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc18_ = _loc12_.zpp_inner.x;
                     if(_loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc19_ = _loc12_.zpp_inner.y;
                     if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc20_ = new Vec2();
                     }
                     else
                     {
                        _loc20_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc20_.zpp_pool;
                        _loc20_.zpp_pool = null;
                        _loc20_.zpp_disp = false;
                        if(_loc20_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc20_.zpp_inner == null)
                     {
                        _loc21_ = false;
                        §§push(_loc20_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc16_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc16_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc16_.next;
                           _loc16_.next = null;
                        }
                        _loc16_.weak = false;
                        _loc16_._immutable = _loc21_;
                        _loc16_.x = _loc18_;
                        _loc16_.y = _loc19_;
                        §§pop().zpp_inner = _loc16_;
                        _loc20_.zpp_inner.outer = _loc20_;
                     }
                     else
                     {
                        if(_loc20_ != null && _loc20_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc20_.zpp_inner;
                        if(_loc16_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc16_._isimmutable != null)
                        {
                           _loc16_._isimmutable();
                        }
                        if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc20_ != null && _loc20_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc20_.zpp_inner;
                        if(_loc16_._validate != null)
                        {
                           _loc16_._validate();
                        }
                        if(_loc20_.zpp_inner.x == _loc18_)
                        {
                           §§pop();
                           if(_loc20_ != null && _loc20_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc16_ = _loc20_.zpp_inner;
                           if(_loc16_._validate != null)
                           {
                              _loc16_._validate();
                           }
                           §§push(_loc20_.zpp_inner.y == _loc19_);
                        }
                        if(!§§pop())
                        {
                           _loc20_.zpp_inner.x = _loc18_;
                           _loc20_.zpp_inner.y = _loc19_;
                           _loc16_ = _loc20_.zpp_inner;
                           if(_loc16_._invalidate != null)
                           {
                              _loc16_._invalidate(_loc16_);
                           }
                        }
                        _loc20_;
                     }
                     _loc20_.zpp_inner.weak = _loc17_;
                     _loc6_ = _loc20_;
                  }
               }
               else
               {
                  _loc20_ = zpp_inner.xform.outer.transform(_loc12_);
                  if(_loc20_ != null && _loc20_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc10_ = int(_loc20_.zpp_inner.x + 0.5);
                  if(_loc20_ != null && _loc20_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = int(_loc20_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc6_ = _loc20_;
                  }
                  else
                  {
                     if(_loc20_ != null && _loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc16_._isimmutable != null)
                     {
                        _loc16_._isimmutable();
                     }
                     if(_loc20_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     _loc20_.zpp_inner.outer = null;
                     _loc20_.zpp_inner = null;
                     _loc22_ = _loc20_;
                     _loc22_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc22_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc22_;
                     }
                     ZPP_PubPool.nextVec2 = _loc22_;
                     _loc22_.zpp_disp = true;
                     _loc23_ = _loc16_;
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
               }
               if(_loc15_)
               {
                  _loc4_ = _loc7_ = _loc10_;
                  _loc5_ = _loc8_ = _loc13_;
               }
               else
               {
                  zpp_inner_zn.__line(_loc7_,_loc8_,_loc10_,_loc13_,_loc3_);
                  _loc7_ = _loc10_;
                  _loc8_ = _loc13_;
               }
            }
         }
         else
         {
            if(!(param1 is GeomPoly))
            {
               Boot.lastError = new Error();
               throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
            }
            _loc28_ = param1;
            if(_loc28_ != null && _loc28_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            _loc29_ = _loc28_.zpp_inner.vertices;
            if(_loc29_ != null)
            {
               _loc30_ = _loc29_;
               do
               {
                  _loc18_ = _loc30_.x;
                  _loc19_ = _loc30_.y;
                  _loc15_ = false;
                  if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 components cannot be NaN";
                  }
                  if(ZPP_PubPool.poolVec2 == null)
                  {
                     _loc20_ = new Vec2();
                  }
                  else
                  {
                     _loc20_ = ZPP_PubPool.poolVec2;
                     ZPP_PubPool.poolVec2 = _loc20_.zpp_pool;
                     _loc20_.zpp_pool = null;
                     _loc20_.zpp_disp = false;
                     if(_loc20_ == ZPP_PubPool.nextVec2)
                     {
                        ZPP_PubPool.nextVec2 = null;
                     }
                  }
                  if(_loc20_.zpp_inner == null)
                  {
                     _loc17_ = false;
                     §§push(_loc20_);
                     if(ZPP_Vec2.zpp_pool == null)
                     {
                        _loc16_ = new ZPP_Vec2();
                     }
                     else
                     {
                        _loc16_ = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc16_.next;
                        _loc16_.next = null;
                     }
                     _loc16_.weak = false;
                     _loc16_._immutable = _loc17_;
                     _loc16_.x = _loc18_;
                     _loc16_.y = _loc19_;
                     §§pop().zpp_inner = _loc16_;
                     _loc20_.zpp_inner.outer = _loc20_;
                  }
                  else
                  {
                     if(_loc20_ != null && _loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc16_._isimmutable != null)
                     {
                        _loc16_._isimmutable();
                     }
                     if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     §§push(false);
                     if(_loc20_ != null && _loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     if(_loc20_.zpp_inner.x == _loc18_)
                     {
                        §§pop();
                        if(_loc20_ != null && _loc20_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc20_.zpp_inner;
                        if(_loc16_._validate != null)
                        {
                           _loc16_._validate();
                        }
                        §§push(_loc20_.zpp_inner.y == _loc19_);
                     }
                     if(!§§pop())
                     {
                        _loc20_.zpp_inner.x = _loc18_;
                        _loc20_.zpp_inner.y = _loc19_;
                        _loc16_ = _loc20_.zpp_inner;
                        if(_loc16_._invalidate != null)
                        {
                           _loc16_._invalidate(_loc16_);
                        }
                     }
                     _loc20_;
                  }
                  _loc20_.zpp_inner.weak = _loc15_;
                  _loc12_ = _loc20_;
                  _loc30_ = _loc30_.next;
                  _loc15_ = _loc6_ == null;
                  if(zpp_inner.xnull)
                  {
                     if(_loc12_ != null && _loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc10_ = int(_loc12_.zpp_inner.x + 0.5);
                     if(_loc12_ != null && _loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc13_ = int(_loc12_.zpp_inner.y + 0.5);
                     if(_loc15_)
                     {
                        _loc17_ = false;
                        if(_loc12_ != null && _loc12_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if(_loc12_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc12_.zpp_inner;
                        if(_loc16_._validate != null)
                        {
                           _loc16_._validate();
                        }
                        _loc18_ = _loc12_.zpp_inner.x;
                        if(_loc12_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc12_.zpp_inner;
                        if(_loc16_._validate != null)
                        {
                           _loc16_._validate();
                        }
                        _loc19_ = _loc12_.zpp_inner.y;
                        if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        if(ZPP_PubPool.poolVec2 == null)
                        {
                           _loc20_ = new Vec2();
                        }
                        else
                        {
                           _loc20_ = ZPP_PubPool.poolVec2;
                           ZPP_PubPool.poolVec2 = _loc20_.zpp_pool;
                           _loc20_.zpp_pool = null;
                           _loc20_.zpp_disp = false;
                           if(_loc20_ == ZPP_PubPool.nextVec2)
                           {
                              ZPP_PubPool.nextVec2 = null;
                           }
                        }
                        if(_loc20_.zpp_inner == null)
                        {
                           _loc21_ = false;
                           §§push(_loc20_);
                           if(ZPP_Vec2.zpp_pool == null)
                           {
                              _loc16_ = new ZPP_Vec2();
                           }
                           else
                           {
                              _loc16_ = ZPP_Vec2.zpp_pool;
                              ZPP_Vec2.zpp_pool = _loc16_.next;
                              _loc16_.next = null;
                           }
                           _loc16_.weak = false;
                           _loc16_._immutable = _loc21_;
                           _loc16_.x = _loc18_;
                           _loc16_.y = _loc19_;
                           §§pop().zpp_inner = _loc16_;
                           _loc20_.zpp_inner.outer = _loc20_;
                        }
                        else
                        {
                           if(_loc20_ != null && _loc20_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc16_ = _loc20_.zpp_inner;
                           if(_loc16_._immutable)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 is immutable";
                           }
                           if(_loc16_._isimmutable != null)
                           {
                              _loc16_._isimmutable();
                           }
                           if(_loc18_ != _loc18_ || _loc19_ != _loc19_)
                           {
                              Boot.lastError = new Error();
                              throw "Error: Vec2 components cannot be NaN";
                           }
                           §§push(false);
                           if(_loc20_ != null && _loc20_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc16_ = _loc20_.zpp_inner;
                           if(_loc16_._validate != null)
                           {
                              _loc16_._validate();
                           }
                           if(_loc20_.zpp_inner.x == _loc18_)
                           {
                              §§pop();
                              if(_loc20_ != null && _loc20_.zpp_disp)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                              }
                              _loc16_ = _loc20_.zpp_inner;
                              if(_loc16_._validate != null)
                              {
                                 _loc16_._validate();
                              }
                              §§push(_loc20_.zpp_inner.y == _loc19_);
                           }
                           if(!§§pop())
                           {
                              _loc20_.zpp_inner.x = _loc18_;
                              _loc20_.zpp_inner.y = _loc19_;
                              _loc16_ = _loc20_.zpp_inner;
                              if(_loc16_._invalidate != null)
                              {
                                 _loc16_._invalidate(_loc16_);
                              }
                           }
                           _loc20_;
                        }
                        _loc20_.zpp_inner.weak = _loc17_;
                        _loc6_ = _loc20_;
                     }
                  }
                  else
                  {
                     _loc20_ = zpp_inner.xform.outer.transform(_loc12_);
                     if(_loc20_ != null && _loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc10_ = int(_loc20_.zpp_inner.x + 0.5);
                     if(_loc20_ != null && _loc20_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc13_ = int(_loc20_.zpp_inner.y + 0.5);
                     if(_loc15_)
                     {
                        _loc6_ = _loc20_;
                     }
                     else
                     {
                        if(_loc20_ != null && _loc20_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc16_ = _loc20_.zpp_inner;
                        if(_loc16_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc16_._isimmutable != null)
                        {
                           _loc16_._isimmutable();
                        }
                        if(_loc20_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc16_ = _loc20_.zpp_inner;
                        _loc20_.zpp_inner.outer = null;
                        _loc20_.zpp_inner = null;
                        _loc22_ = _loc20_;
                        _loc22_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc22_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc22_;
                        }
                        ZPP_PubPool.nextVec2 = _loc22_;
                        _loc22_.zpp_disp = true;
                        _loc23_ = _loc16_;
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
                  }
                  if(_loc15_)
                  {
                     _loc4_ = _loc7_ = _loc10_;
                     _loc5_ = _loc8_ = _loc13_;
                  }
                  else
                  {
                     zpp_inner_zn.__line(_loc7_,_loc8_,_loc10_,_loc13_,_loc3_);
                     _loc7_ = _loc10_;
                     _loc8_ = _loc13_;
                  }
                  if(_loc12_ != null && _loc12_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc12_.zpp_inner;
                  if(_loc16_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc16_._isimmutable != null)
                  {
                     _loc16_._isimmutable();
                  }
                  if(_loc12_.zpp_inner._inuse)
                  {
                     Boot.lastError = new Error();
                     throw "Error: This Vec2 is not disposable";
                  }
                  _loc16_ = _loc12_.zpp_inner;
                  _loc12_.zpp_inner.outer = null;
                  _loc12_.zpp_inner = null;
                  _loc20_ = _loc12_;
                  _loc20_.zpp_pool = null;
                  if(ZPP_PubPool.nextVec2 != null)
                  {
                     ZPP_PubPool.nextVec2.zpp_pool = _loc20_;
                  }
                  else
                  {
                     ZPP_PubPool.poolVec2 = _loc20_;
                  }
                  ZPP_PubPool.nextVec2 = _loc20_;
                  _loc20_.zpp_disp = true;
                  _loc23_ = _loc16_;
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
               while(_loc30_ != _loc29_);
               
            }
         }
         zpp_inner_zn.__line(_loc7_,_loc8_,_loc4_,_loc5_,_loc3_);
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc16_ = _loc6_.zpp_inner;
         if(_loc16_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc16_._isimmutable != null)
         {
            _loc16_._isimmutable();
         }
         if(_loc6_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc16_ = _loc6_.zpp_inner;
         _loc6_.zpp_inner.outer = null;
         _loc6_.zpp_inner = null;
         _loc12_ = _loc6_;
         _loc12_.zpp_pool = null;
         if(ZPP_PubPool.nextVec2 != null)
         {
            ZPP_PubPool.nextVec2.zpp_pool = _loc12_;
         }
         else
         {
            ZPP_PubPool.poolVec2 = _loc12_;
         }
         ZPP_PubPool.nextVec2 = _loc12_;
         _loc12_.zpp_disp = true;
         _loc23_ = _loc16_;
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
         if(param1 is Array)
         {
            _loc9_ = param1;
            _loc10_ = 0;
            while(_loc10_ < int(_loc9_.length))
            {
               _loc12_ = _loc9_[_loc10_];
               if(_loc12_.zpp_inner.weak)
               {
                  if(_loc12_ != null && _loc12_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc12_.zpp_inner;
                  if(_loc16_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc16_._isimmutable != null)
                  {
                     _loc16_._isimmutable();
                  }
                  if(_loc12_.zpp_inner._inuse)
                  {
                     Boot.lastError = new Error();
                     throw "Error: This Vec2 is not disposable";
                  }
                  _loc16_ = _loc12_.zpp_inner;
                  _loc12_.zpp_inner.outer = null;
                  _loc12_.zpp_inner = null;
                  _loc20_ = _loc12_;
                  _loc20_.zpp_pool = null;
                  if(ZPP_PubPool.nextVec2 != null)
                  {
                     ZPP_PubPool.nextVec2.zpp_pool = _loc20_;
                  }
                  else
                  {
                     ZPP_PubPool.poolVec2 = _loc20_;
                  }
                  ZPP_PubPool.nextVec2 = _loc20_;
                  _loc20_.zpp_disp = true;
                  _loc23_ = _loc16_;
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
                  _loc9_.splice(_loc10_,1);
               }
               else
               {
                  _loc10_++;
               }
            }
         }
         else if(param1 is ZPP_Const.vec2vector)
         {
            _loc24_ = param1;
            if(!_loc24_.fixed)
            {
               _loc10_ = 0;
               while(_loc10_ < int(_loc24_.length))
               {
                  _loc12_ = _loc24_[_loc10_];
                  if(_loc12_.zpp_inner.weak)
                  {
                     if(_loc12_ != null && _loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc16_._isimmutable != null)
                     {
                        _loc16_._isimmutable();
                     }
                     if(_loc12_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc16_ = _loc12_.zpp_inner;
                     _loc12_.zpp_inner.outer = null;
                     _loc12_.zpp_inner = null;
                     _loc20_ = _loc12_;
                     _loc20_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc20_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc20_;
                     }
                     ZPP_PubPool.nextVec2 = _loc20_;
                     _loc20_.zpp_disp = true;
                     _loc23_ = _loc16_;
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
                     _loc24_.splice(_loc10_,1);
                  }
                  else
                  {
                     _loc10_++;
                  }
               }
            }
         }
         else if(param1 is Vec2List)
         {
            _loc26_ = param1;
            if(_loc26_.zpp_inner._validate != null)
            {
               _loc26_.zpp_inner._validate();
            }
            _loc31_ = _loc26_.zpp_inner.inner;
            _loc32_ = null;
            _loc33_ = _loc31_.head;
            while(_loc33_ != null)
            {
               _loc16_ = _loc33_.elt;
               if(_loc16_.outer.zpp_inner.weak)
               {
                  _loc33_ = _loc31_.erase(_loc32_);
                  if(_loc16_.outer.zpp_inner.weak)
                  {
                     _loc12_ = _loc16_.outer;
                     if(_loc12_ != null && _loc12_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc23_ = _loc12_.zpp_inner;
                     if(_loc23_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc23_._isimmutable != null)
                     {
                        _loc23_._isimmutable();
                     }
                     if(_loc12_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc23_ = _loc12_.zpp_inner;
                     _loc12_.zpp_inner.outer = null;
                     _loc12_.zpp_inner = null;
                     _loc20_ = _loc12_;
                     _loc20_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc20_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc20_;
                     }
                     ZPP_PubPool.nextVec2 = _loc20_;
                     _loc20_.zpp_disp = true;
                     _loc34_ = _loc23_;
                     if(_loc34_.outer != null)
                     {
                        _loc34_.outer.zpp_inner = null;
                        _loc34_.outer = null;
                     }
                     _loc34_._isimmutable = null;
                     _loc34_._validate = null;
                     _loc34_._invalidate = null;
                     _loc34_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc34_;
                     true;
                  }
                  else
                  {
                     false;
                  }
               }
               else
               {
                  _loc32_ = _loc33_;
                  _loc33_ = _loc33_.next;
               }
            }
         }
      }
      
      override public function drawLine(param1:Vec2, param2:Vec2, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_Vec2;
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
         if(zpp_inner.xnull)
         {
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
            _loc4_ = int(param1.zpp_inner.x + 0.5);
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
            _loc6_ = int(param1.zpp_inner.y + 0.5);
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
            _loc7_ = int(param2.zpp_inner.x + 0.5);
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
            _loc8_ = int(param2.zpp_inner.y + 0.5);
            zpp_inner_zn.__line(_loc4_,_loc6_,_loc7_,_loc8_,param3 | -16777216);
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
               _loc9_ = param1;
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
               _loc10_ = _loc5_;
               if(_loc10_.outer != null)
               {
                  _loc10_.outer.zpp_inner = null;
                  _loc10_.outer = null;
               }
               _loc10_._isimmutable = null;
               _loc10_._validate = null;
               _loc10_._invalidate = null;
               _loc10_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc10_;
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
               _loc9_ = param2;
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
               _loc10_ = _loc5_;
               if(_loc10_.outer != null)
               {
                  _loc10_.outer.zpp_inner = null;
                  _loc10_.outer = null;
               }
               _loc10_._isimmutable = null;
               _loc10_._validate = null;
               _loc10_._invalidate = null;
               _loc10_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc10_;
               true;
            }
            else
            {
               false;
            }
         }
         else
         {
            _loc9_ = zpp_inner.xform.outer.transform(param1);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = int(_loc9_.zpp_inner.x + 0.5);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = int(_loc9_.zpp_inner.y + 0.5);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc9_.zpp_inner;
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
            _loc10_ = _loc5_;
            if(_loc10_.outer != null)
            {
               _loc10_.outer.zpp_inner = null;
               _loc10_.outer = null;
            }
            _loc10_._isimmutable = null;
            _loc10_._validate = null;
            _loc10_._invalidate = null;
            _loc10_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc10_;
            _loc9_ = zpp_inner.xform.outer.transform(param2);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc7_ = int(_loc9_.zpp_inner.x + 0.5);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc8_ = int(_loc9_.zpp_inner.y + 0.5);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc9_.zpp_inner;
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
            _loc10_ = _loc5_;
            if(_loc10_.outer != null)
            {
               _loc10_.outer.zpp_inner = null;
               _loc10_.outer = null;
            }
            _loc10_._isimmutable = null;
            _loc10_._validate = null;
            _loc10_._invalidate = null;
            _loc10_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc10_;
            zpp_inner_zn.__line(_loc4_,_loc6_,_loc7_,_loc8_,param3 | -16777216);
         }
      }
      
      override public function drawFilledTriangle(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
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
         zpp_inner_zn.__tri(param1,param2,param3,param4);
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
         if(param3.zpp_inner.weak)
         {
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param3.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(param3.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = param3.zpp_inner;
            param3.zpp_inner.outer = null;
            param3.zpp_inner = null;
            _loc6_ = param3;
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
      
      override public function drawFilledPolygon(param1:*, param2:int) : void
      {
         var _loc7_:* = null as Array;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null as Vec2;
         var _loc11_:* = null as Vec2;
         var _loc12_:Boolean = false;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as ZPP_Vec2;
         var _loc15_:Number = NaN;
         var _loc16_:* = null as Vec2;
         var _loc17_:Boolean = false;
         var _loc18_:* = null as Vector.<Vec2>;
         var _loc19_:* = null as Vec2;
         var _loc20_:* = null as Vec2List;
         var _loc21_:* = null as Vec2Iterator;
         var _loc22_:* = null as GeomPoly;
         var _loc23_:* = null as ZPP_GeomVert;
         var _loc24_:* = null as ZPP_GeomVert;
         var _loc25_:* = null as ZPP_Vec2;
         var _loc26_:* = null as ZNPList_ZPP_Vec2;
         var _loc27_:* = null as ZNPNode_ZPP_Vec2;
         var _loc28_:* = null as ZNPNode_ZPP_Vec2;
         var _loc29_:* = null as ZPP_Vec2;
         var _loc33_:int = 0;
         var _loc34_:int = 0;
         var _loc35_:int = 0;
         var _loc36_:int = 0;
         var _loc37_:int = 0;
         var _loc38_:int = 0;
         var _loc39_:int = 0;
         var _loc40_:int = 0;
         var _loc41_:int = 0;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot render null polygon";
         }
         var _loc3_:int = param2 | -16777216;
         var _loc4_:Number = Number(Math.POSITIVE_INFINITY);
         var _loc5_:Number = Number(Math.NEGATIVE_INFINITY);
         var _loc6_:Array = zpp_inner_zn.filledVertices;
         if(param1 is Array)
         {
            _loc7_ = param1;
            _loc8_ = 0;
            while(_loc8_ < int(_loc7_.length))
            {
               _loc9_ = _loc7_[_loc8_];
               _loc8_++;
               if(_loc9_ == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Array<Vec2> contains null objects";
               }
               if(!(_loc9_ is Vec2))
               {
                  Boot.lastError = new Error();
                  throw "Error: Array<Vec2> contains non Vec2 objects";
               }
               _loc10_ = _loc9_;
               if(_loc10_ != null && _loc10_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               if(zpp_inner.xnull)
               {
                  _loc12_ = false;
                  §§push(_loc6_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc13_ = _loc10_.zpp_inner.x;
                  if(_loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc15_ = _loc10_.zpp_inner.y;
                  if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
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
                        _loc14_ = new ZPP_Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc14_.next;
                        _loc14_.next = null;
                     }
                     _loc14_.weak = false;
                     _loc14_._immutable = _loc17_;
                     _loc14_.x = _loc13_;
                     _loc14_.y = _loc15_;
                     §§pop().zpp_inner = _loc14_;
                     _loc16_.zpp_inner.outer = _loc16_;
                  }
                  else
                  {
                     if(_loc16_ != null && _loc16_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc16_.zpp_inner;
                     if(_loc14_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc14_._isimmutable != null)
                     {
                        _loc14_._isimmutable();
                     }
                     if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
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
                     _loc14_ = _loc16_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     if(_loc16_.zpp_inner.x == _loc13_)
                     {
                        §§pop();
                        if(_loc16_ != null && _loc16_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc14_ = _loc16_.zpp_inner;
                        if(_loc14_._validate != null)
                        {
                           _loc14_._validate();
                        }
                        §§push(_loc16_.zpp_inner.y == _loc15_);
                     }
                     if(!§§pop())
                     {
                        _loc16_.zpp_inner.x = _loc13_;
                        _loc16_.zpp_inner.y = _loc15_;
                        _loc14_ = _loc16_.zpp_inner;
                        if(_loc14_._invalidate != null)
                        {
                           _loc14_._invalidate(_loc14_);
                        }
                     }
                     _loc16_;
                  }
                  _loc16_.zpp_inner.weak = _loc12_;
                  _loc11_ = _loc16_;
                  §§pop().push(_loc11_);
               }
               else
               {
                  _loc11_ = zpp_inner.xform.outer.transform(_loc10_);
                  _loc6_.push(_loc11_);
               }
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc14_ = _loc11_.zpp_inner;
               if(_loc14_._validate != null)
               {
                  _loc14_._validate();
               }
               if(_loc11_.zpp_inner.y < _loc4_)
               {
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc4_ = _loc11_.zpp_inner.y;
               }
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc14_ = _loc11_.zpp_inner;
               if(_loc14_._validate != null)
               {
                  _loc14_._validate();
               }
               if(_loc11_.zpp_inner.y > _loc5_)
               {
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc5_ = _loc11_.zpp_inner.y;
               }
            }
         }
         else if(param1 is ZPP_Const.vec2vector)
         {
            _loc18_ = param1;
            _loc8_ = 0;
            while(_loc8_ < _loc18_.length)
            {
               _loc10_ = _loc18_[_loc8_];
               _loc8_++;
               if(_loc10_ == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: flash.Vector<Vec2> contains null objects";
               }
               _loc11_ = _loc10_;
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               if(zpp_inner.xnull)
               {
                  _loc12_ = false;
                  §§push(_loc6_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc13_ = _loc11_.zpp_inner.x;
                  if(_loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc15_ = _loc11_.zpp_inner.y;
                  if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
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
                        _loc14_ = new ZPP_Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc14_.next;
                        _loc14_.next = null;
                     }
                     _loc14_.weak = false;
                     _loc14_._immutable = _loc17_;
                     _loc14_.x = _loc13_;
                     _loc14_.y = _loc15_;
                     §§pop().zpp_inner = _loc14_;
                     _loc19_.zpp_inner.outer = _loc19_;
                  }
                  else
                  {
                     if(_loc19_ != null && _loc19_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc19_.zpp_inner;
                     if(_loc14_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc14_._isimmutable != null)
                     {
                        _loc14_._isimmutable();
                     }
                     if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
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
                     _loc14_ = _loc19_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     if(_loc19_.zpp_inner.x == _loc13_)
                     {
                        §§pop();
                        if(_loc19_ != null && _loc19_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc14_ = _loc19_.zpp_inner;
                        if(_loc14_._validate != null)
                        {
                           _loc14_._validate();
                        }
                        §§push(_loc19_.zpp_inner.y == _loc15_);
                     }
                     if(!§§pop())
                     {
                        _loc19_.zpp_inner.x = _loc13_;
                        _loc19_.zpp_inner.y = _loc15_;
                        _loc14_ = _loc19_.zpp_inner;
                        if(_loc14_._invalidate != null)
                        {
                           _loc14_._invalidate(_loc14_);
                        }
                     }
                     _loc19_;
                  }
                  _loc19_.zpp_inner.weak = _loc12_;
                  _loc16_ = _loc19_;
                  §§pop().push(_loc16_);
               }
               else
               {
                  _loc16_ = zpp_inner.xform.outer.transform(_loc11_);
                  _loc6_.push(_loc16_);
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc14_ = _loc16_.zpp_inner;
               if(_loc14_._validate != null)
               {
                  _loc14_._validate();
               }
               if(_loc16_.zpp_inner.y < _loc4_)
               {
                  if(_loc16_ != null && _loc16_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc16_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc4_ = _loc16_.zpp_inner.y;
               }
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc14_ = _loc16_.zpp_inner;
               if(_loc14_._validate != null)
               {
                  _loc14_._validate();
               }
               if(_loc16_.zpp_inner.y > _loc5_)
               {
                  if(_loc16_ != null && _loc16_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc16_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc5_ = _loc16_.zpp_inner.y;
               }
            }
         }
         else if(param1 is Vec2List)
         {
            _loc20_ = param1;
            _loc21_ = _loc20_.iterator();
            while(true)
            {
               _loc21_.zpp_inner.zpp_inner.valmod();
               _loc8_ = _loc21_.zpp_inner.zpp_gl();
               _loc21_.zpp_critical = true;
               if(!(_loc21_.zpp_i < _loc8_ ? true : (_loc21_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc21_, _loc21_.zpp_inner = null, false)))
               {
                  break;
               }
               _loc21_.zpp_critical = false;
               _loc21_.zpp_i = (_loc8_ = _loc21_.zpp_i) + 1;
               _loc10_ = _loc21_.zpp_inner.at(_loc8_);
               if(_loc10_ == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2List contains null objects";
               }
               if(_loc10_ != null && _loc10_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               if(zpp_inner.xnull)
               {
                  _loc12_ = false;
                  §§push(_loc6_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc13_ = _loc10_.zpp_inner.x;
                  if(_loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc15_ = _loc10_.zpp_inner.y;
                  if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
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
                        _loc14_ = new ZPP_Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc14_.next;
                        _loc14_.next = null;
                     }
                     _loc14_.weak = false;
                     _loc14_._immutable = _loc17_;
                     _loc14_.x = _loc13_;
                     _loc14_.y = _loc15_;
                     §§pop().zpp_inner = _loc14_;
                     _loc16_.zpp_inner.outer = _loc16_;
                  }
                  else
                  {
                     if(_loc16_ != null && _loc16_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc16_.zpp_inner;
                     if(_loc14_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc14_._isimmutable != null)
                     {
                        _loc14_._isimmutable();
                     }
                     if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
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
                     _loc14_ = _loc16_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     if(_loc16_.zpp_inner.x == _loc13_)
                     {
                        §§pop();
                        if(_loc16_ != null && _loc16_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc14_ = _loc16_.zpp_inner;
                        if(_loc14_._validate != null)
                        {
                           _loc14_._validate();
                        }
                        §§push(_loc16_.zpp_inner.y == _loc15_);
                     }
                     if(!§§pop())
                     {
                        _loc16_.zpp_inner.x = _loc13_;
                        _loc16_.zpp_inner.y = _loc15_;
                        _loc14_ = _loc16_.zpp_inner;
                        if(_loc14_._invalidate != null)
                        {
                           _loc14_._invalidate(_loc14_);
                        }
                     }
                     _loc16_;
                  }
                  _loc16_.zpp_inner.weak = _loc12_;
                  _loc11_ = _loc16_;
                  §§pop().push(_loc11_);
               }
               else
               {
                  _loc11_ = zpp_inner.xform.outer.transform(_loc10_);
                  _loc6_.push(_loc11_);
               }
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc14_ = _loc11_.zpp_inner;
               if(_loc14_._validate != null)
               {
                  _loc14_._validate();
               }
               if(_loc11_.zpp_inner.y < _loc4_)
               {
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc4_ = _loc11_.zpp_inner.y;
               }
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc14_ = _loc11_.zpp_inner;
               if(_loc14_._validate != null)
               {
                  _loc14_._validate();
               }
               if(_loc11_.zpp_inner.y > _loc5_)
               {
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc5_ = _loc11_.zpp_inner.y;
               }
            }
         }
         else
         {
            if(!(param1 is GeomPoly))
            {
               Boot.lastError = new Error();
               throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
            }
            _loc22_ = param1;
            if(_loc22_ != null && _loc22_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc22_.zpp_inner.vertices;
            if(_loc23_ != null)
            {
               _loc24_ = _loc23_;
               do
               {
                  _loc13_ = _loc24_.x;
                  _loc15_ = _loc24_.y;
                  _loc12_ = false;
                  if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 components cannot be NaN";
                  }
                  if(ZPP_PubPool.poolVec2 == null)
                  {
                     _loc11_ = new Vec2();
                  }
                  else
                  {
                     _loc11_ = ZPP_PubPool.poolVec2;
                     ZPP_PubPool.poolVec2 = _loc11_.zpp_pool;
                     _loc11_.zpp_pool = null;
                     _loc11_.zpp_disp = false;
                     if(_loc11_ == ZPP_PubPool.nextVec2)
                     {
                        ZPP_PubPool.nextVec2 = null;
                     }
                  }
                  if(_loc11_.zpp_inner == null)
                  {
                     _loc17_ = false;
                     §§push(_loc11_);
                     if(ZPP_Vec2.zpp_pool == null)
                     {
                        _loc14_ = new ZPP_Vec2();
                     }
                     else
                     {
                        _loc14_ = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc14_.next;
                        _loc14_.next = null;
                     }
                     _loc14_.weak = false;
                     _loc14_._immutable = _loc17_;
                     _loc14_.x = _loc13_;
                     _loc14_.y = _loc15_;
                     §§pop().zpp_inner = _loc14_;
                     _loc11_.zpp_inner.outer = _loc11_;
                  }
                  else
                  {
                     if(_loc11_ != null && _loc11_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc11_.zpp_inner;
                     if(_loc14_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc14_._isimmutable != null)
                     {
                        _loc14_._isimmutable();
                     }
                     if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     §§push(false);
                     if(_loc11_ != null && _loc11_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc11_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     if(_loc11_.zpp_inner.x == _loc13_)
                     {
                        §§pop();
                        if(_loc11_ != null && _loc11_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc14_ = _loc11_.zpp_inner;
                        if(_loc14_._validate != null)
                        {
                           _loc14_._validate();
                        }
                        §§push(_loc11_.zpp_inner.y == _loc15_);
                     }
                     if(!§§pop())
                     {
                        _loc11_.zpp_inner.x = _loc13_;
                        _loc11_.zpp_inner.y = _loc15_;
                        _loc14_ = _loc11_.zpp_inner;
                        if(_loc14_._invalidate != null)
                        {
                           _loc14_._invalidate(_loc14_);
                        }
                     }
                     _loc11_;
                  }
                  _loc11_.zpp_inner.weak = _loc12_;
                  _loc10_ = _loc11_;
                  _loc24_ = _loc24_.next;
                  if(zpp_inner.xnull)
                  {
                     _loc12_ = false;
                     §§push(_loc6_);
                     if(_loc10_ != null && _loc10_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc10_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc10_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     _loc13_ = _loc10_.zpp_inner.x;
                     if(_loc10_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc10_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     _loc15_ = _loc10_.zpp_inner.y;
                     if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
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
                           _loc14_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc14_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc14_.next;
                           _loc14_.next = null;
                        }
                        _loc14_.weak = false;
                        _loc14_._immutable = _loc17_;
                        _loc14_.x = _loc13_;
                        _loc14_.y = _loc15_;
                        §§pop().zpp_inner = _loc14_;
                        _loc16_.zpp_inner.outer = _loc16_;
                     }
                     else
                     {
                        if(_loc16_ != null && _loc16_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc14_ = _loc16_.zpp_inner;
                        if(_loc14_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc14_._isimmutable != null)
                        {
                           _loc14_._isimmutable();
                        }
                        if(_loc13_ != _loc13_ || _loc15_ != _loc15_)
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
                        _loc14_ = _loc16_.zpp_inner;
                        if(_loc14_._validate != null)
                        {
                           _loc14_._validate();
                        }
                        if(_loc16_.zpp_inner.x == _loc13_)
                        {
                           §§pop();
                           if(_loc16_ != null && _loc16_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc14_ = _loc16_.zpp_inner;
                           if(_loc14_._validate != null)
                           {
                              _loc14_._validate();
                           }
                           §§push(_loc16_.zpp_inner.y == _loc15_);
                        }
                        if(!§§pop())
                        {
                           _loc16_.zpp_inner.x = _loc13_;
                           _loc16_.zpp_inner.y = _loc15_;
                           _loc14_ = _loc16_.zpp_inner;
                           if(_loc14_._invalidate != null)
                           {
                              _loc14_._invalidate(_loc14_);
                           }
                        }
                        _loc16_;
                     }
                     _loc16_.zpp_inner.weak = _loc12_;
                     _loc11_ = _loc16_;
                     §§pop().push(_loc11_);
                  }
                  else
                  {
                     _loc11_ = zpp_inner.xform.outer.transform(_loc10_);
                     _loc6_.push(_loc11_);
                  }
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  if(_loc11_.zpp_inner.y < _loc4_)
                  {
                     if(_loc11_ != null && _loc11_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc11_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     _loc4_ = _loc11_.zpp_inner.y;
                  }
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  if(_loc11_.zpp_inner.y > _loc5_)
                  {
                     if(_loc11_ != null && _loc11_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc11_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     _loc5_ = _loc11_.zpp_inner.y;
                  }
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc14_._isimmutable != null)
                  {
                     _loc14_._isimmutable();
                  }
                  if(_loc10_.zpp_inner._inuse)
                  {
                     Boot.lastError = new Error();
                     throw "Error: This Vec2 is not disposable";
                  }
                  _loc14_ = _loc10_.zpp_inner;
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
                  _loc25_ = _loc14_;
                  if(_loc25_.outer != null)
                  {
                     _loc25_.outer.zpp_inner = null;
                     _loc25_.outer = null;
                  }
                  _loc25_._isimmutable = null;
                  _loc25_._validate = null;
                  _loc25_._invalidate = null;
                  _loc25_.next = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc25_;
               }
               while(_loc24_ != _loc23_);
               
            }
         }
         if(param1 is Array)
         {
            _loc7_ = param1;
            _loc8_ = 0;
            while(_loc8_ < int(_loc7_.length))
            {
               _loc10_ = _loc7_[_loc8_];
               if(_loc10_.zpp_inner.weak)
               {
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc14_._isimmutable != null)
                  {
                     _loc14_._isimmutable();
                  }
                  if(_loc10_.zpp_inner._inuse)
                  {
                     Boot.lastError = new Error();
                     throw "Error: This Vec2 is not disposable";
                  }
                  _loc14_ = _loc10_.zpp_inner;
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
                  _loc25_ = _loc14_;
                  if(_loc25_.outer != null)
                  {
                     _loc25_.outer.zpp_inner = null;
                     _loc25_.outer = null;
                  }
                  _loc25_._isimmutable = null;
                  _loc25_._validate = null;
                  _loc25_._invalidate = null;
                  _loc25_.next = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc25_;
                  §§push(true);
               }
               else
               {
                  §§push(false);
               }
               if(§§pop())
               {
                  _loc7_.splice(_loc8_,1);
               }
               else
               {
                  _loc8_++;
               }
            }
         }
         else if(param1 is ZPP_Const.vec2vector)
         {
            _loc18_ = param1;
            if(!_loc18_.fixed)
            {
               _loc8_ = 0;
               while(_loc8_ < int(_loc18_.length))
               {
                  _loc10_ = _loc18_[_loc8_];
                  if(_loc10_.zpp_inner.weak)
                  {
                     if(_loc10_ != null && _loc10_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc10_.zpp_inner;
                     if(_loc14_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc14_._isimmutable != null)
                     {
                        _loc14_._isimmutable();
                     }
                     if(_loc10_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc14_ = _loc10_.zpp_inner;
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
                     _loc25_ = _loc14_;
                     if(_loc25_.outer != null)
                     {
                        _loc25_.outer.zpp_inner = null;
                        _loc25_.outer = null;
                     }
                     _loc25_._isimmutable = null;
                     _loc25_._validate = null;
                     _loc25_._invalidate = null;
                     _loc25_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc25_;
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  if(§§pop())
                  {
                     _loc18_.splice(_loc8_,1);
                  }
                  else
                  {
                     _loc8_++;
                  }
               }
            }
         }
         else if(param1 is Vec2List)
         {
            _loc20_ = param1;
            if(_loc20_.zpp_inner._validate != null)
            {
               _loc20_.zpp_inner._validate();
            }
            _loc26_ = _loc20_.zpp_inner.inner;
            _loc27_ = null;
            _loc28_ = _loc26_.head;
            while(_loc28_ != null)
            {
               _loc14_ = _loc28_.elt;
               if(_loc14_.outer.zpp_inner.weak)
               {
                  _loc28_ = _loc26_.erase(_loc27_);
                  if(_loc14_.outer.zpp_inner.weak)
                  {
                     _loc10_ = _loc14_.outer;
                     if(_loc10_ != null && _loc10_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc25_ = _loc10_.zpp_inner;
                     if(_loc25_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc25_._isimmutable != null)
                     {
                        _loc25_._isimmutable();
                     }
                     if(_loc10_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc25_ = _loc10_.zpp_inner;
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
                     _loc29_ = _loc25_;
                     if(_loc29_.outer != null)
                     {
                        _loc29_.outer.zpp_inner = null;
                        _loc29_.outer = null;
                     }
                     _loc29_._isimmutable = null;
                     _loc29_._validate = null;
                     _loc29_._invalidate = null;
                     _loc29_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc29_;
                     true;
                  }
                  else
                  {
                     false;
                  }
               }
               else
               {
                  _loc27_ = _loc28_;
                  _loc28_ = _loc28_.next;
               }
            }
         }
         _loc8_ = int(_loc4_ + 0.5);
         var _loc30_:int = int(_loc5_ + 0.5);
         if(_loc30_ < 0 || _loc8_ >= zpp_inner.height)
         {
            return;
         }
         if(_loc8_ < 0)
         {
            _loc8_ = 0;
         }
         if(_loc30_ >= zpp_inner.height)
         {
            _loc30_ = zpp_inner.height - 1;
         }
         _loc7_ = zpp_inner_zn.filledXs;
         var _loc31_:int = _loc8_;
         var _loc32_:int = _loc30_ + 1;
         while(_loc31_ < _loc32_)
         {
            _loc33_ = _loc31_++;
            _loc34_ = 0;
            _loc35_ = 0;
            _loc36_ = int(_loc6_.length);
            while(_loc35_ < _loc36_)
            {
               _loc37_ = _loc35_++;
               _loc10_ = _loc6_[_loc37_];
               _loc11_ = _loc6_[int((_loc37_ + 1) % int(_loc6_.length))];
               §§push(true);
               §§push(false);
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc14_ = _loc11_.zpp_inner;
               if(_loc14_._validate != null)
               {
                  _loc14_._validate();
               }
               if(_loc11_.zpp_inner.y < _loc33_)
               {
                  §§pop();
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  §§push(_loc10_.zpp_inner.y >= _loc33_);
               }
               if(!§§pop())
               {
                  §§pop();
                  §§push(false);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  if(_loc10_.zpp_inner.y < _loc33_)
                  {
                     §§pop();
                     if(_loc11_ != null && _loc11_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc14_ = _loc11_.zpp_inner;
                     if(_loc14_._validate != null)
                     {
                        _loc14_._validate();
                     }
                     §§push(_loc11_.zpp_inner.y >= _loc33_);
                  }
                  §§push(§§pop());
               }
               if(§§pop())
               {
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  §§push(_loc11_.zpp_inner.x);
                  §§push(_loc33_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  §§push(§§pop() - _loc11_.zpp_inner.y);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  §§push(_loc10_.zpp_inner.y);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  §§push(§§pop() / (§§pop() - _loc11_.zpp_inner.y));
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc10_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  §§push(_loc10_.zpp_inner.x);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc13_ = §§pop() + §§pop() * (§§pop() - _loc11_.zpp_inner.x);
                  _loc7_[_loc34_++] = int(_loc13_ + 0.5);
               }
            }
            _loc35_ = 1;
            while(_loc35_ < _loc34_)
            {
               _loc36_ = _loc35_++;
               _loc37_ = int(_loc7_[_loc36_]);
               _loc38_ = _loc36_;
               while(_loc38_ > 0)
               {
                  _loc39_ = int(_loc7_[_loc38_ - 1]);
                  if(_loc39_ < _loc37_)
                  {
                     break;
                  }
                  _loc7_[_loc38_] = _loc39_;
                  _loc38_--;
               }
               _loc7_[_loc38_] = _loc37_;
            }
            _loc35_ = 0;
            while(_loc35_ + 1 < _loc34_)
            {
               _loc36_ = int(_loc7_[_loc35_++]);
               _loc37_ = int(_loc7_[_loc35_++]);
               if(_loc37_ >= 0)
               {
                  if(_loc36_ >= zpp_inner.width)
                  {
                     break;
                  }
                  if(_loc36_ < 0)
                  {
                     _loc36_ = 0;
                  }
                  if(_loc37_ >= zpp_inner.width)
                  {
                     _loc37_ = zpp_inner.width - 1;
                  }
                  _loc38_ = _loc33_ * zpp_inner_zn.width + _loc36_;
                  _loc39_ = _loc36_;
                  _loc40_ = _loc37_ + 1;
                  while(_loc39_ < _loc40_)
                  {
                     _loc41_ = _loc39_++;
                     si32(_loc3_,_loc38_++ << 2);
                  }
               }
            }
         }
         while(int(_loc6_.length) > 0)
         {
            _loc10_ = _loc6_.pop();
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc14_ = _loc10_.zpp_inner;
            if(_loc14_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc14_._isimmutable != null)
            {
               _loc14_._isimmutable();
            }
            if(_loc10_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc14_ = _loc10_.zpp_inner;
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
            _loc25_ = _loc14_;
            if(_loc25_.outer != null)
            {
               _loc25_.outer.zpp_inner = null;
               _loc25_.outer = null;
            }
            _loc25_._isimmutable = null;
            _loc25_._validate = null;
            _loc25_._invalidate = null;
            _loc25_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc25_;
         }
      }
      
      override public function drawFilledCircle(param1:Vec2, param2:Number, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as Vec2;
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
         if(zpp_inner.xnull)
         {
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
            _loc4_ = int(param1.zpp_inner.x + 0.5);
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
            _loc6_ = int(param1.zpp_inner.y + 0.5);
            _loc7_ = int(param2 + 0.5);
            zpp_inner_zn.__fcircle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
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
               _loc8_ = param1;
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
               _loc9_ = _loc5_;
               if(_loc9_.outer != null)
               {
                  _loc9_.outer.zpp_inner = null;
                  _loc9_.outer = null;
               }
               _loc9_._isimmutable = null;
               _loc9_._validate = null;
               _loc9_._invalidate = null;
               _loc9_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc9_;
               true;
            }
            else
            {
               false;
            }
         }
         else
         {
            _loc8_ = zpp_inner.xform.outer.transform(param1);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = int(_loc8_.zpp_inner.x + 0.5);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = int(_loc8_.zpp_inner.y + 0.5);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc10_ = _loc8_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
            _loc9_ = _loc5_;
            if(_loc9_.outer != null)
            {
               _loc9_.outer.zpp_inner = null;
               _loc9_.outer = null;
            }
            _loc9_._isimmutable = null;
            _loc9_._validate = null;
            _loc9_._invalidate = null;
            _loc9_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc9_;
            _loc7_ = int(param2 * zpp_inner.xdet + 0.5);
            zpp_inner_zn.__fcircle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
         }
      }
      
      override public function drawCurve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as Vec2;
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
         if(zpp_inner.xnull)
         {
            zpp_inner_zn.__curve(param1,param2,param3,param4);
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
            if(param3.zpp_inner.weak)
            {
               if(param3 != null && param3.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = param3.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(param3.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = param3.zpp_inner;
               param3.zpp_inner.outer = null;
               param3.zpp_inner = null;
               _loc6_ = param3;
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
            _loc8_ = zpp_inner.xform.outer.transform(param2);
            _loc9_ = zpp_inner.xform.outer.transform(param3);
            zpp_inner_zn.__curve(_loc6_,_loc8_,_loc9_,param4);
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
            _loc10_ = _loc6_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
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
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc10_ = _loc8_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
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
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc9_.zpp_inner;
            _loc9_.zpp_inner.outer = null;
            _loc9_.zpp_inner = null;
            _loc10_ = _loc9_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
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
      
      override public function drawCircle(param1:Vec2, param2:Number, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as Vec2;
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
         if(zpp_inner.xnull)
         {
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
            _loc4_ = int(param1.zpp_inner.x + 0.5);
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
            _loc6_ = int(param1.zpp_inner.y + 0.5);
            _loc7_ = int(param2 + 0.5);
            zpp_inner_zn.__circle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
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
               _loc8_ = param1;
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
               _loc9_ = _loc5_;
               if(_loc9_.outer != null)
               {
                  _loc9_.outer.zpp_inner = null;
                  _loc9_.outer = null;
               }
               _loc9_._isimmutable = null;
               _loc9_._validate = null;
               _loc9_._invalidate = null;
               _loc9_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc9_;
               true;
            }
            else
            {
               false;
            }
         }
         else
         {
            _loc8_ = zpp_inner.xform.outer.transform(param1);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = int(_loc8_.zpp_inner.x + 0.5);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = int(_loc8_.zpp_inner.y + 0.5);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc10_ = _loc8_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
            _loc9_ = _loc5_;
            if(_loc9_.outer != null)
            {
               _loc9_.outer.zpp_inner = null;
               _loc9_.outer = null;
            }
            _loc9_._isimmutable = null;
            _loc9_._validate = null;
            _loc9_._invalidate = null;
            _loc9_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc9_;
            _loc7_ = int(param2 * zpp_inner.xdet + 0.5);
            zpp_inner_zn.__circle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
         }
      }
      
      override public function drawAABB(param1:AABB, param2:int) : void
      {
         var _loc3_:* = null as Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_AABB;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as Vec2;
         var _loc9_:Boolean = false;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as Vec2;
         var _loc12_:* = null as Vec2;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:* = null as Vec2;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:int = 0;
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
         if(zpp_inner.xnull)
         {
            zpp_inner_zn.__aabb(param1.zpp_inner,param2);
         }
         else
         {
            _loc3_ = zpp_inner.xform.outer.transform(param1.zpp_inner.getmin());
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            _loc5_ = _loc6_.maxx - _loc6_.minx;
            _loc7_ = false;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc8_ = new Vec2();
            }
            else
            {
               _loc8_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc8_.zpp_pool;
               _loc8_.zpp_pool = null;
               _loc8_.zpp_disp = false;
               if(_loc8_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc8_.zpp_inner == null)
            {
               _loc9_ = false;
               §§push(_loc8_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc10_ = new ZPP_Vec2();
               }
               else
               {
                  _loc10_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc10_.next;
                  _loc10_.next = null;
               }
               _loc10_.weak = false;
               _loc10_._immutable = _loc9_;
               _loc10_.x = _loc5_;
               _loc10_.y = 0;
               §§pop().zpp_inner = _loc10_;
               _loc8_.zpp_inner.outer = _loc8_;
            }
            else
            {
               if(_loc8_ != null && _loc8_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc8_.zpp_inner;
               if(_loc10_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc10_._isimmutable != null)
               {
                  _loc10_._isimmutable();
               }
               if(_loc5_ != _loc5_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc8_ != null && _loc8_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc8_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               if(_loc8_.zpp_inner.x == _loc5_)
               {
                  §§pop();
                  if(_loc8_ != null && _loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc10_ = _loc8_.zpp_inner;
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  §§push(_loc8_.zpp_inner.y == 0);
               }
               if(!§§pop())
               {
                  _loc8_.zpp_inner.x = _loc5_;
                  _loc8_.zpp_inner.y = 0;
                  _loc10_ = _loc8_.zpp_inner;
                  if(_loc10_._invalidate != null)
                  {
                     _loc10_._invalidate(_loc10_);
                  }
               }
               _loc8_;
            }
            _loc8_.zpp_inner.weak = _loc7_;
            _loc4_ = _loc8_;
            _loc8_ = zpp_inner.xform.outer.transform(_loc4_,true);
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            _loc5_ = _loc6_.maxy - _loc6_.miny;
            _loc7_ = false;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc12_ = new Vec2();
            }
            else
            {
               _loc12_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc12_.zpp_pool;
               _loc12_.zpp_pool = null;
               _loc12_.zpp_disp = false;
               if(_loc12_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc12_.zpp_inner == null)
            {
               _loc9_ = false;
               §§push(_loc12_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc10_ = new ZPP_Vec2();
               }
               else
               {
                  _loc10_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc10_.next;
                  _loc10_.next = null;
               }
               _loc10_.weak = false;
               _loc10_._immutable = _loc9_;
               _loc10_.x = 0;
               _loc10_.y = _loc5_;
               §§pop().zpp_inner = _loc10_;
               _loc12_.zpp_inner.outer = _loc12_;
            }
            else
            {
               if(_loc12_ != null && _loc12_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc12_.zpp_inner;
               if(_loc10_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc10_._isimmutable != null)
               {
                  _loc10_._isimmutable();
               }
               if(_loc5_ != _loc5_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc12_ != null && _loc12_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc12_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               if(_loc12_.zpp_inner.x == 0)
               {
                  §§pop();
                  if(_loc12_ != null && _loc12_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc10_ = _loc12_.zpp_inner;
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  §§push(_loc12_.zpp_inner.y == _loc5_);
               }
               if(!§§pop())
               {
                  _loc12_.zpp_inner.x = 0;
                  _loc12_.zpp_inner.y = _loc5_;
                  _loc10_ = _loc12_.zpp_inner;
                  if(_loc10_._invalidate != null)
                  {
                     _loc10_._invalidate(_loc10_);
                  }
               }
               _loc12_;
            }
            _loc12_.zpp_inner.weak = _loc7_;
            _loc11_ = _loc12_;
            _loc12_ = zpp_inner.xform.outer.transform(_loc11_,true);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc13_ = int(_loc3_.zpp_inner.x + 0.5);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc14_ = int(_loc3_.zpp_inner.y + 0.5);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.x);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc15_ = int(§§pop() + _loc8_.zpp_inner.x + 0.5);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.y);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc16_ = int(§§pop() + _loc8_.zpp_inner.y + 0.5);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.x);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(§§pop() + _loc8_.zpp_inner.x);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc17_ = int(§§pop() + _loc12_.zpp_inner.x + 0.5);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.y);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(§§pop() + _loc8_.zpp_inner.y);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc18_ = int(§§pop() + _loc12_.zpp_inner.y + 0.5);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.x);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc19_ = int(§§pop() + _loc12_.zpp_inner.x + 0.5);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.y);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc20_ = int(§§pop() + _loc12_.zpp_inner.y + 0.5);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc3_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc3_.zpp_inner;
            _loc3_.zpp_inner.outer = null;
            _loc3_.zpp_inner = null;
            _loc21_ = _loc3_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
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
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc4_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc4_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc4_.zpp_inner;
            _loc4_.zpp_inner.outer = null;
            _loc4_.zpp_inner = null;
            _loc21_ = _loc4_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
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
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc21_ = _loc8_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
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
            if(_loc11_ != null && _loc11_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc11_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc11_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc11_.zpp_inner;
            _loc11_.zpp_inner.outer = null;
            _loc11_.zpp_inner = null;
            _loc21_ = _loc11_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
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
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc12_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc12_.zpp_inner;
            _loc12_.zpp_inner.outer = null;
            _loc12_.zpp_inner = null;
            _loc21_ = _loc12_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
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
            _loc23_ = param2 | -16777216;
            zpp_inner_zn.__line(_loc13_,_loc14_,_loc15_,_loc16_,_loc23_);
            zpp_inner_zn.__line(_loc15_,_loc16_,_loc17_,_loc18_,_loc23_);
            zpp_inner_zn.__line(_loc17_,_loc18_,_loc19_,_loc20_,_loc23_);
            zpp_inner_zn.__line(_loc19_,_loc20_,_loc13_,_loc14_,_loc23_);
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
         zpp_inner_zn.clear();
      }
   }
}

