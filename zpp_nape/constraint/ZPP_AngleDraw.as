package zpp_nape.constraint
{
   import flash.Boot;
   import nape.Config;
   import nape.geom.Vec2;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_AngleDraw
   {
      public static var maxarc:Number;
      
      public function ZPP_AngleDraw()
      {
      }
      
      public static function indicator(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:int) : void
      {
         var _loc10_:* = null as Vec2;
         var _loc11_:Boolean = false;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc7_:Number = Math.cos(param3);
         var _loc8_:Number = Math.sin(param3);
         var _loc9_:Boolean = false;
         if(_loc7_ != _loc7_ || _loc8_ != _loc8_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc10_ = new Vec2();
         }
         else
         {
            _loc10_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc10_.zpp_pool;
            _loc10_.zpp_pool = null;
            _loc10_.zpp_disp = false;
            if(_loc10_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc10_.zpp_inner == null)
         {
            _loc11_ = false;
            §§push(_loc10_);
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
            _loc12_._immutable = _loc11_;
            _loc12_.x = _loc7_;
            _loc12_.y = _loc8_;
            §§pop().zpp_inner = _loc12_;
            _loc10_.zpp_inner.outer = _loc10_;
         }
         else
         {
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc10_.zpp_inner;
            if(_loc12_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc12_._isimmutable != null)
            {
               _loc12_._isimmutable();
            }
            if(_loc7_ != _loc7_ || _loc8_ != _loc8_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc12_ = _loc10_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            if(_loc10_.zpp_inner.x == _loc7_)
            {
               §§pop();
               if(_loc10_ != null && _loc10_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc12_ = _loc10_.zpp_inner;
               if(_loc12_._validate != null)
               {
                  _loc12_._validate();
               }
               §§push(_loc10_.zpp_inner.y == _loc8_);
            }
            if(!§§pop())
            {
               _loc10_.zpp_inner.x = _loc7_;
               _loc10_.zpp_inner.y = _loc8_;
               _loc12_ = _loc10_.zpp_inner;
               if(_loc12_._invalidate != null)
               {
                  _loc12_._invalidate(_loc12_);
               }
            }
            _loc10_;
         }
         _loc10_.zpp_inner.weak = _loc9_;
         var _loc6_:Vec2 = _loc10_;
         param1.drawFilledCircle(param2.add(_loc6_.mul(param4,true),true),2,param5);
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc12_ = _loc6_.zpp_inner;
         if(_loc12_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc12_._isimmutable != null)
         {
            _loc12_._isimmutable();
         }
         if(_loc6_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc12_ = _loc6_.zpp_inner;
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
         var _loc13_:ZPP_Vec2 = _loc12_;
         if(_loc13_.outer != null)
         {
            _loc13_.outer.zpp_inner = null;
            _loc13_.outer = null;
         }
         _loc13_._isimmutable = null;
         _loc13_._validate = null;
         _loc13_._invalidate = null;
         _loc13_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc13_;
      }
      
      public static function drawSpiralSpring(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:Number, param6:Number, param7:int, param8:int = 4) : void
      {
         var _loc9_:Number = NaN;
         var _loc15_:int = 0;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc26_:* = null as Vec2;
         var _loc27_:Boolean = false;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:* = null as Vec2;
         var _loc32_:* = null as Vec2;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:* = null as Vec2;
         var _loc42_:* = null as ZPP_Vec2;
         if(param3 > param4)
         {
            _loc9_ = param3;
            param3 = param4;
            param4 = _loc9_;
            _loc9_ = param5;
            param5 = param6;
            param6 = _loc9_;
         }
         if(param3 == param4)
         {
            return;
         }
         _loc9_ = param6 - param5;
         var _loc10_:Number = param4 - param3;
         var _loc12_:Number = 2 * Math.PI * _loc9_ / _loc10_;
         var _loc11_:Number = _loc12_ < 0 ? -_loc12_ : _loc12_;
         var _loc14_:int = int(Math.ceil(_loc10_ / ZPP_AngleDraw.maxarc * 3));
         _loc15_ = 4 * param8;
         var _loc13_:int = _loc14_ > _loc15_ ? _loc14_ : _loc15_;
         _loc12_ = _loc9_ / _loc13_;
         var _loc16_:Number = _loc10_ / _loc13_;
         var _loc17_:Number = 1 / _loc13_;
         var _loc18_:Number = Math.cos(param3);
         var _loc19_:Number = Math.sin(param3);
         var _loc21_:Number = param5 + _loc9_ * 0;
         var _loc20_:Number = _loc21_ + 0.75 * _loc11_ * Math.sin(2 * param8 * Math.PI * 0);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc23_ = param2.zpp_inner;
         if(_loc23_._validate != null)
         {
            _loc23_._validate();
         }
         _loc21_ = param2.zpp_inner.x + _loc20_ * _loc18_;
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc23_ = param2.zpp_inner;
         if(_loc23_._validate != null)
         {
            _loc23_._validate();
         }
         var _loc24_:Number = param2.zpp_inner.y + _loc20_ * _loc19_;
         var _loc25_:Boolean = false;
         if(_loc21_ != _loc21_ || _loc24_ != _loc24_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc26_ = new Vec2();
         }
         else
         {
            _loc26_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc26_.zpp_pool;
            _loc26_.zpp_pool = null;
            _loc26_.zpp_disp = false;
            if(_loc26_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc26_.zpp_inner == null)
         {
            _loc27_ = false;
            §§push(_loc26_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc23_ = new ZPP_Vec2();
            }
            else
            {
               _loc23_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc23_.next;
               _loc23_.next = null;
            }
            _loc23_.weak = false;
            _loc23_._immutable = _loc27_;
            _loc23_.x = _loc21_;
            _loc23_.y = _loc24_;
            §§pop().zpp_inner = _loc23_;
            _loc26_.zpp_inner.outer = _loc26_;
         }
         else
         {
            if(_loc26_ != null && _loc26_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc26_.zpp_inner;
            if(_loc23_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc23_._isimmutable != null)
            {
               _loc23_._isimmutable();
            }
            if(_loc21_ != _loc21_ || _loc24_ != _loc24_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc26_ != null && _loc26_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc26_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            if(_loc26_.zpp_inner.x == _loc21_)
            {
               §§pop();
               if(_loc26_ != null && _loc26_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc26_.zpp_inner.y == _loc24_);
            }
            if(!§§pop())
            {
               _loc26_.zpp_inner.x = _loc21_;
               _loc26_.zpp_inner.y = _loc24_;
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._invalidate != null)
               {
                  _loc23_._invalidate(_loc23_);
               }
            }
            _loc26_;
         }
         _loc26_.zpp_inner.weak = _loc25_;
         var _loc22_:Vec2 = _loc26_;
         _loc21_ = _loc9_ + 1.5 * param8 * _loc11_ * Math.PI * Math.cos(2 * param8 * Math.PI * 0);
         _loc24_ = _loc21_ * _loc18_ - _loc20_ * _loc10_ * _loc19_;
         var _loc28_:Number = _loc21_ * _loc19_ + _loc20_ * _loc10_ * _loc18_;
         _loc29_ = 0;
         _loc30_ = 0;
         _loc25_ = false;
         if(_loc29_ != _loc29_ || _loc30_ != _loc30_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc31_ = new Vec2();
         }
         else
         {
            _loc31_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc31_.zpp_pool;
            _loc31_.zpp_pool = null;
            _loc31_.zpp_disp = false;
            if(_loc31_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc31_.zpp_inner == null)
         {
            _loc27_ = false;
            §§push(_loc31_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc23_ = new ZPP_Vec2();
            }
            else
            {
               _loc23_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc23_.next;
               _loc23_.next = null;
            }
            _loc23_.weak = false;
            _loc23_._immutable = _loc27_;
            _loc23_.x = _loc29_;
            _loc23_.y = _loc30_;
            §§pop().zpp_inner = _loc23_;
            _loc31_.zpp_inner.outer = _loc31_;
         }
         else
         {
            if(_loc31_ != null && _loc31_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc31_.zpp_inner;
            if(_loc23_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc23_._isimmutable != null)
            {
               _loc23_._isimmutable();
            }
            if(_loc29_ != _loc29_ || _loc30_ != _loc30_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc31_ != null && _loc31_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc31_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            if(_loc31_.zpp_inner.x == _loc29_)
            {
               §§pop();
               if(_loc31_ != null && _loc31_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc31_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc31_.zpp_inner.y == _loc30_);
            }
            if(!§§pop())
            {
               _loc31_.zpp_inner.x = _loc29_;
               _loc31_.zpp_inner.y = _loc30_;
               _loc23_ = _loc31_.zpp_inner;
               if(_loc23_._invalidate != null)
               {
                  _loc23_._invalidate(_loc23_);
               }
            }
            _loc31_;
         }
         _loc31_.zpp_inner.weak = _loc25_;
         _loc26_ = _loc31_;
         _loc29_ = 0;
         _loc30_ = 0;
         _loc25_ = false;
         if(_loc29_ != _loc29_ || _loc30_ != _loc30_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc32_ = new Vec2();
         }
         else
         {
            _loc32_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc32_.zpp_pool;
            _loc32_.zpp_pool = null;
            _loc32_.zpp_disp = false;
            if(_loc32_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc32_.zpp_inner == null)
         {
            _loc27_ = false;
            §§push(_loc32_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc23_ = new ZPP_Vec2();
            }
            else
            {
               _loc23_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc23_.next;
               _loc23_.next = null;
            }
            _loc23_.weak = false;
            _loc23_._immutable = _loc27_;
            _loc23_.x = _loc29_;
            _loc23_.y = _loc30_;
            §§pop().zpp_inner = _loc23_;
            _loc32_.zpp_inner.outer = _loc32_;
         }
         else
         {
            if(_loc32_ != null && _loc32_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc32_.zpp_inner;
            if(_loc23_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc23_._isimmutable != null)
            {
               _loc23_._isimmutable();
            }
            if(_loc29_ != _loc29_ || _loc30_ != _loc30_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc32_ != null && _loc32_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc32_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            if(_loc32_.zpp_inner.x == _loc29_)
            {
               §§pop();
               if(_loc32_ != null && _loc32_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc32_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc32_.zpp_inner.y == _loc30_);
            }
            if(!§§pop())
            {
               _loc32_.zpp_inner.x = _loc29_;
               _loc32_.zpp_inner.y = _loc30_;
               _loc23_ = _loc32_.zpp_inner;
               if(_loc23_._invalidate != null)
               {
                  _loc23_._invalidate(_loc23_);
               }
            }
            _loc32_;
         }
         _loc32_.zpp_inner.weak = _loc25_;
         _loc31_ = _loc32_;
         _loc14_ = 0;
         while(_loc14_ < _loc13_)
         {
            _loc15_ = _loc14_++;
            _loc29_ = param3 + _loc16_;
            _loc30_ = Math.cos(_loc29_);
            _loc33_ = Math.sin(_loc29_);
            _loc35_ = param5 + _loc9_ * (_loc15_ + 1) * _loc17_;
            _loc34_ = _loc35_ + 0.75 * _loc11_ * Math.sin(2 * param8 * Math.PI * (_loc15_ + 1) * _loc17_);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = param2.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            _loc35_ = param2.zpp_inner.x + _loc34_ * _loc30_;
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = param2.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            _loc36_ = param2.zpp_inner.y + _loc34_ * _loc33_;
            if(_loc26_ != null && _loc26_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc26_.zpp_inner;
            if(_loc23_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc23_._isimmutable != null)
            {
               _loc23_._isimmutable();
            }
            if(_loc35_ != _loc35_ || _loc36_ != _loc36_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc26_ != null && _loc26_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc26_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            if(_loc26_.zpp_inner.x == _loc35_)
            {
               §§pop();
               if(_loc26_ != null && _loc26_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc26_.zpp_inner.y == _loc36_);
            }
            if(!§§pop())
            {
               _loc26_.zpp_inner.x = _loc35_;
               _loc26_.zpp_inner.y = _loc36_;
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._invalidate != null)
               {
                  _loc23_._invalidate(_loc23_);
               }
            }
            _loc26_;
            _loc35_ = _loc9_ + 1.5 * param8 * _loc11_ * Math.PI * Math.cos(2 * param8 * Math.PI * (_loc15_ + 1) * _loc17_);
            _loc36_ = _loc35_ * _loc30_ - _loc34_ * _loc10_ * _loc33_;
            _loc37_ = _loc35_ * _loc33_ + _loc34_ * _loc10_ * _loc30_;
            _loc38_ = _loc24_ * _loc37_ - _loc28_ * _loc36_;
            if(_loc38_ * _loc38_ < Config.epsilon || _loc24_ * _loc36_ + _loc28_ * _loc37_ <= 0 || _loc24_ * _loc36_ + _loc28_ * _loc37_ > 0.999)
            {
               param1.drawLine(_loc22_,_loc26_,param7);
            }
            else
            {
               if(_loc26_ != null && _loc26_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc26_.zpp_inner.x);
               if(_loc22_ != null && _loc22_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc22_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push((§§pop() - _loc22_.zpp_inner.x) * _loc37_);
               if(_loc22_ != null && _loc22_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc22_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc22_.zpp_inner.y);
               if(_loc26_ != null && _loc26_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               _loc39_ = (§§pop() + (§§pop() - _loc26_.zpp_inner.y) * _loc36_) / _loc38_;
               if(_loc39_ <= 0)
               {
                  param1.drawLine(_loc22_,_loc26_,param7);
               }
               else
               {
                  if(_loc22_ != null && _loc22_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc23_ = _loc22_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  _loc40_ = _loc22_.zpp_inner.x + _loc24_ * _loc39_;
                  if(_loc31_ != null && _loc31_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc23_ = _loc31_.zpp_inner;
                  if(_loc23_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc23_._isimmutable != null)
                  {
                     _loc23_._isimmutable();
                  }
                  if(_loc31_ != null && _loc31_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc23_ = _loc31_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  if(_loc31_.zpp_inner.x != _loc40_)
                  {
                     if(_loc40_ != _loc40_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2::" + "x" + " cannot be NaN";
                     }
                     _loc31_.zpp_inner.x = _loc40_;
                     _loc23_ = _loc31_.zpp_inner;
                     if(_loc23_._invalidate != null)
                     {
                        _loc23_._invalidate(_loc23_);
                     }
                  }
                  if(_loc31_ != null && _loc31_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc23_ = _loc31_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  _loc31_.zpp_inner.x;
                  if(_loc22_ != null && _loc22_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc23_ = _loc22_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  _loc40_ = _loc22_.zpp_inner.y + _loc28_ * _loc39_;
                  if(_loc31_ != null && _loc31_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc23_ = _loc31_.zpp_inner;
                  if(_loc23_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc23_._isimmutable != null)
                  {
                     _loc23_._isimmutable();
                  }
                  if(_loc31_ != null && _loc31_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc23_ = _loc31_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  if(_loc31_.zpp_inner.y != _loc40_)
                  {
                     if(_loc40_ != _loc40_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2::" + "y" + " cannot be NaN";
                     }
                     _loc31_.zpp_inner.y = _loc40_;
                     _loc23_ = _loc31_.zpp_inner;
                     if(_loc23_._invalidate != null)
                     {
                        _loc23_._invalidate(_loc23_);
                     }
                  }
                  if(_loc31_ != null && _loc31_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc23_ = _loc31_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  _loc31_.zpp_inner.y;
                  param1.drawCurve(_loc22_,_loc31_,_loc26_,param7);
               }
            }
            param3 = _loc29_;
            _loc18_ = _loc30_;
            _loc19_ = _loc33_;
            _loc24_ = _loc36_;
            _loc28_ = _loc37_;
            if(_loc22_ != null && _loc22_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(_loc26_ != null && _loc26_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc22_.zpp_inner;
            if(_loc23_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc23_._isimmutable != null)
            {
               _loc23_._isimmutable();
            }
            if(_loc26_ == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null Vec2";
            }
            if(_loc26_ != null && _loc26_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc26_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            _loc39_ = _loc26_.zpp_inner.x;
            if(_loc26_ != null && _loc26_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc26_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            _loc40_ = _loc26_.zpp_inner.y;
            if(_loc22_ != null && _loc22_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc23_ = _loc22_.zpp_inner;
            if(_loc23_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc23_._isimmutable != null)
            {
               _loc23_._isimmutable();
            }
            if(_loc39_ != _loc39_ || _loc40_ != _loc40_)
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
            _loc23_ = _loc22_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            if(_loc22_.zpp_inner.x == _loc39_)
            {
               §§pop();
               if(_loc22_ != null && _loc22_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc22_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc22_.zpp_inner.y == _loc40_);
            }
            if(!§§pop())
            {
               _loc22_.zpp_inner.x = _loc39_;
               _loc22_.zpp_inner.y = _loc40_;
               _loc23_ = _loc22_.zpp_inner;
               if(_loc23_._invalidate != null)
               {
                  _loc23_._invalidate(_loc23_);
               }
            }
            _loc32_ = _loc22_;
            if(_loc26_.zpp_inner.weak)
            {
               if(_loc26_ != null && _loc26_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc23_._isimmutable != null)
               {
                  _loc23_._isimmutable();
               }
               if(_loc26_.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc23_ = _loc26_.zpp_inner;
               _loc26_.zpp_inner.outer = null;
               _loc26_.zpp_inner = null;
               _loc41_ = _loc26_;
               _loc41_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc41_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc41_;
               }
               ZPP_PubPool.nextVec2 = _loc41_;
               _loc41_.zpp_disp = true;
               _loc42_ = _loc23_;
               if(_loc42_.outer != null)
               {
                  _loc42_.outer.zpp_inner = null;
                  _loc42_.outer = null;
               }
               _loc42_._isimmutable = null;
               _loc42_._validate = null;
               _loc42_._invalidate = null;
               _loc42_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc42_;
               true;
            }
            else
            {
               false;
            }
            _loc32_;
         }
         if(_loc22_ != null && _loc22_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc23_ = _loc22_.zpp_inner;
         if(_loc23_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc23_._isimmutable != null)
         {
            _loc23_._isimmutable();
         }
         if(_loc22_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc23_ = _loc22_.zpp_inner;
         _loc22_.zpp_inner.outer = null;
         _loc22_.zpp_inner = null;
         _loc32_ = _loc22_;
         _loc32_.zpp_pool = null;
         if(ZPP_PubPool.nextVec2 != null)
         {
            ZPP_PubPool.nextVec2.zpp_pool = _loc32_;
         }
         else
         {
            ZPP_PubPool.poolVec2 = _loc32_;
         }
         ZPP_PubPool.nextVec2 = _loc32_;
         _loc32_.zpp_disp = true;
         _loc42_ = _loc23_;
         if(_loc42_.outer != null)
         {
            _loc42_.outer.zpp_inner = null;
            _loc42_.outer = null;
         }
         _loc42_._isimmutable = null;
         _loc42_._validate = null;
         _loc42_._invalidate = null;
         _loc42_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc42_;
         if(_loc26_ != null && _loc26_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc23_ = _loc26_.zpp_inner;
         if(_loc23_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc23_._isimmutable != null)
         {
            _loc23_._isimmutable();
         }
         if(_loc26_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc23_ = _loc26_.zpp_inner;
         _loc26_.zpp_inner.outer = null;
         _loc26_.zpp_inner = null;
         _loc32_ = _loc26_;
         _loc32_.zpp_pool = null;
         if(ZPP_PubPool.nextVec2 != null)
         {
            ZPP_PubPool.nextVec2.zpp_pool = _loc32_;
         }
         else
         {
            ZPP_PubPool.poolVec2 = _loc32_;
         }
         ZPP_PubPool.nextVec2 = _loc32_;
         _loc32_.zpp_disp = true;
         _loc42_ = _loc23_;
         if(_loc42_.outer != null)
         {
            _loc42_.outer.zpp_inner = null;
            _loc42_.outer = null;
         }
         _loc42_._isimmutable = null;
         _loc42_._validate = null;
         _loc42_._invalidate = null;
         _loc42_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc42_;
         if(_loc31_ != null && _loc31_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc23_ = _loc31_.zpp_inner;
         if(_loc23_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc23_._isimmutable != null)
         {
            _loc23_._isimmutable();
         }
         if(_loc31_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc23_ = _loc31_.zpp_inner;
         _loc31_.zpp_inner.outer = null;
         _loc31_.zpp_inner = null;
         _loc32_ = _loc31_;
         _loc32_.zpp_pool = null;
         if(ZPP_PubPool.nextVec2 != null)
         {
            ZPP_PubPool.nextVec2.zpp_pool = _loc32_;
         }
         else
         {
            ZPP_PubPool.poolVec2 = _loc32_;
         }
         ZPP_PubPool.nextVec2 = _loc32_;
         _loc32_.zpp_disp = true;
         _loc42_ = _loc23_;
         if(_loc42_.outer != null)
         {
            _loc42_.outer.zpp_inner = null;
            _loc42_.outer = null;
         }
         _loc42_._isimmutable = null;
         _loc42_._validate = null;
         _loc42_._invalidate = null;
         _loc42_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc42_;
      }
      
      public static function drawSpiral(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:Number, param6:Number, param7:int) : void
      {
         var _loc8_:Number = NaN;
         var _loc17_:* = null as ZPP_Vec2;
         var _loc20_:* = null as Vec2;
         var _loc21_:Boolean = false;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:* = null as Vec2;
         var _loc25_:* = null as Vec2;
         var _loc27_:int = 0;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:* = null as Vec2;
         var _loc36_:* = null as ZPP_Vec2;
         if(param3 > param4)
         {
            _loc8_ = param3;
            param3 = param4;
            param4 = _loc8_;
            _loc8_ = param5;
            param5 = param6;
            param6 = _loc8_;
         }
         if(param3 == param4)
         {
            return;
         }
         _loc8_ = param6 - param5;
         var _loc9_:Number = param4 - param3;
         var _loc10_:int = int(Math.ceil(_loc9_ / ZPP_AngleDraw.maxarc));
         var _loc11_:Number = _loc8_ / _loc10_;
         var _loc12_:Number = _loc9_ / _loc10_;
         var _loc13_:Number = Math.cos(param3);
         var _loc14_:Number = Math.sin(param3);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc17_ = param2.zpp_inner;
         if(_loc17_._validate != null)
         {
            _loc17_._validate();
         }
         var _loc16_:Number = param2.zpp_inner.x + param5 * _loc13_;
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc17_ = param2.zpp_inner;
         if(_loc17_._validate != null)
         {
            _loc17_._validate();
         }
         var _loc18_:Number = param2.zpp_inner.y + param5 * _loc14_;
         var _loc19_:Boolean = false;
         if(_loc16_ != _loc16_ || _loc18_ != _loc18_)
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
               _loc17_ = new ZPP_Vec2();
            }
            else
            {
               _loc17_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc17_.next;
               _loc17_.next = null;
            }
            _loc17_.weak = false;
            _loc17_._immutable = _loc21_;
            _loc17_.x = _loc16_;
            _loc17_.y = _loc18_;
            §§pop().zpp_inner = _loc17_;
            _loc20_.zpp_inner.outer = _loc20_;
         }
         else
         {
            if(_loc20_ != null && _loc20_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc20_.zpp_inner;
            if(_loc17_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc17_._isimmutable != null)
            {
               _loc17_._isimmutable();
            }
            if(_loc16_ != _loc16_ || _loc18_ != _loc18_)
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
            _loc17_ = _loc20_.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            if(_loc20_.zpp_inner.x == _loc16_)
            {
               §§pop();
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc20_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               §§push(_loc20_.zpp_inner.y == _loc18_);
            }
            if(!§§pop())
            {
               _loc20_.zpp_inner.x = _loc16_;
               _loc20_.zpp_inner.y = _loc18_;
               _loc17_ = _loc20_.zpp_inner;
               if(_loc17_._invalidate != null)
               {
                  _loc17_._invalidate(_loc17_);
               }
            }
            _loc20_;
         }
         _loc20_.zpp_inner.weak = _loc19_;
         var _loc15_:Vec2 = _loc20_;
         _loc16_ = _loc8_ * _loc13_ - param5 * _loc9_ * _loc14_;
         _loc18_ = _loc8_ * _loc14_ + param5 * _loc9_ * _loc13_;
         _loc22_ = 0;
         _loc23_ = 0;
         _loc19_ = false;
         if(_loc22_ != _loc22_ || _loc23_ != _loc23_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc24_ = new Vec2();
         }
         else
         {
            _loc24_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc24_.zpp_pool;
            _loc24_.zpp_pool = null;
            _loc24_.zpp_disp = false;
            if(_loc24_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc24_.zpp_inner == null)
         {
            _loc21_ = false;
            §§push(_loc24_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc17_ = new ZPP_Vec2();
            }
            else
            {
               _loc17_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc17_.next;
               _loc17_.next = null;
            }
            _loc17_.weak = false;
            _loc17_._immutable = _loc21_;
            _loc17_.x = _loc22_;
            _loc17_.y = _loc23_;
            §§pop().zpp_inner = _loc17_;
            _loc24_.zpp_inner.outer = _loc24_;
         }
         else
         {
            if(_loc24_ != null && _loc24_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc24_.zpp_inner;
            if(_loc17_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc17_._isimmutable != null)
            {
               _loc17_._isimmutable();
            }
            if(_loc22_ != _loc22_ || _loc23_ != _loc23_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc24_ != null && _loc24_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc24_.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            if(_loc24_.zpp_inner.x == _loc22_)
            {
               §§pop();
               if(_loc24_ != null && _loc24_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc24_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               §§push(_loc24_.zpp_inner.y == _loc23_);
            }
            if(!§§pop())
            {
               _loc24_.zpp_inner.x = _loc22_;
               _loc24_.zpp_inner.y = _loc23_;
               _loc17_ = _loc24_.zpp_inner;
               if(_loc17_._invalidate != null)
               {
                  _loc17_._invalidate(_loc17_);
               }
            }
            _loc24_;
         }
         _loc24_.zpp_inner.weak = _loc19_;
         _loc20_ = _loc24_;
         _loc22_ = 0;
         _loc23_ = 0;
         _loc19_ = false;
         if(_loc22_ != _loc22_ || _loc23_ != _loc23_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc25_ = new Vec2();
         }
         else
         {
            _loc25_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc25_.zpp_pool;
            _loc25_.zpp_pool = null;
            _loc25_.zpp_disp = false;
            if(_loc25_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc25_.zpp_inner == null)
         {
            _loc21_ = false;
            §§push(_loc25_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc17_ = new ZPP_Vec2();
            }
            else
            {
               _loc17_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc17_.next;
               _loc17_.next = null;
            }
            _loc17_.weak = false;
            _loc17_._immutable = _loc21_;
            _loc17_.x = _loc22_;
            _loc17_.y = _loc23_;
            §§pop().zpp_inner = _loc17_;
            _loc25_.zpp_inner.outer = _loc25_;
         }
         else
         {
            if(_loc25_ != null && _loc25_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc25_.zpp_inner;
            if(_loc17_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc17_._isimmutable != null)
            {
               _loc17_._isimmutable();
            }
            if(_loc22_ != _loc22_ || _loc23_ != _loc23_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc25_ != null && _loc25_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc25_.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            if(_loc25_.zpp_inner.x == _loc22_)
            {
               §§pop();
               if(_loc25_ != null && _loc25_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc25_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               §§push(_loc25_.zpp_inner.y == _loc23_);
            }
            if(!§§pop())
            {
               _loc25_.zpp_inner.x = _loc22_;
               _loc25_.zpp_inner.y = _loc23_;
               _loc17_ = _loc25_.zpp_inner;
               if(_loc17_._invalidate != null)
               {
                  _loc17_._invalidate(_loc17_);
               }
            }
            _loc25_;
         }
         _loc25_.zpp_inner.weak = _loc19_;
         _loc24_ = _loc25_;
         var _loc26_:int = 0;
         while(_loc26_ < _loc10_)
         {
            _loc27_ = _loc26_++;
            _loc22_ = param5 + _loc11_;
            _loc23_ = param3 + _loc12_;
            _loc28_ = Math.cos(_loc23_);
            _loc29_ = Math.sin(_loc23_);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = param2.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            _loc30_ = param2.zpp_inner.x + _loc22_ * _loc28_;
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = param2.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            _loc31_ = param2.zpp_inner.y + _loc22_ * _loc29_;
            if(_loc20_ != null && _loc20_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc20_.zpp_inner;
            if(_loc17_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc17_._isimmutable != null)
            {
               _loc17_._isimmutable();
            }
            if(_loc30_ != _loc30_ || _loc31_ != _loc31_)
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
            _loc17_ = _loc20_.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            if(_loc20_.zpp_inner.x == _loc30_)
            {
               §§pop();
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc20_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               §§push(_loc20_.zpp_inner.y == _loc31_);
            }
            if(!§§pop())
            {
               _loc20_.zpp_inner.x = _loc30_;
               _loc20_.zpp_inner.y = _loc31_;
               _loc17_ = _loc20_.zpp_inner;
               if(_loc17_._invalidate != null)
               {
                  _loc17_._invalidate(_loc17_);
               }
            }
            _loc20_;
            _loc30_ = _loc8_ * _loc28_ - _loc22_ * _loc9_ * _loc29_;
            _loc31_ = _loc8_ * _loc29_ + _loc22_ * _loc9_ * _loc28_;
            _loc32_ = _loc16_ * _loc31_ - _loc18_ * _loc30_;
            if(_loc32_ * _loc32_ < Config.epsilon)
            {
               param1.drawLine(_loc15_,_loc20_,param7);
            }
            else
            {
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc20_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               §§push(_loc20_.zpp_inner.x);
               if(_loc15_ != null && _loc15_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc15_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               §§push((§§pop() - _loc15_.zpp_inner.x) * _loc31_);
               if(_loc15_ != null && _loc15_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc15_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               §§push(_loc15_.zpp_inner.y);
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc20_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               _loc33_ = (§§pop() + (§§pop() - _loc20_.zpp_inner.y) * _loc30_) / _loc32_;
               if(_loc33_ <= 0)
               {
                  param1.drawLine(_loc15_,_loc20_,param7);
               }
               else
               {
                  if(_loc15_ != null && _loc15_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = _loc15_.zpp_inner;
                  if(_loc17_._validate != null)
                  {
                     _loc17_._validate();
                  }
                  _loc34_ = _loc15_.zpp_inner.x + _loc16_ * _loc33_;
                  if(_loc24_ != null && _loc24_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = _loc24_.zpp_inner;
                  if(_loc17_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc17_._isimmutable != null)
                  {
                     _loc17_._isimmutable();
                  }
                  if(_loc24_ != null && _loc24_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = _loc24_.zpp_inner;
                  if(_loc17_._validate != null)
                  {
                     _loc17_._validate();
                  }
                  if(_loc24_.zpp_inner.x != _loc34_)
                  {
                     if(_loc34_ != _loc34_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2::" + "x" + " cannot be NaN";
                     }
                     _loc24_.zpp_inner.x = _loc34_;
                     _loc17_ = _loc24_.zpp_inner;
                     if(_loc17_._invalidate != null)
                     {
                        _loc17_._invalidate(_loc17_);
                     }
                  }
                  if(_loc24_ != null && _loc24_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = _loc24_.zpp_inner;
                  if(_loc17_._validate != null)
                  {
                     _loc17_._validate();
                  }
                  _loc24_.zpp_inner.x;
                  if(_loc15_ != null && _loc15_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = _loc15_.zpp_inner;
                  if(_loc17_._validate != null)
                  {
                     _loc17_._validate();
                  }
                  _loc34_ = _loc15_.zpp_inner.y + _loc18_ * _loc33_;
                  if(_loc24_ != null && _loc24_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = _loc24_.zpp_inner;
                  if(_loc17_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc17_._isimmutable != null)
                  {
                     _loc17_._isimmutable();
                  }
                  if(_loc24_ != null && _loc24_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = _loc24_.zpp_inner;
                  if(_loc17_._validate != null)
                  {
                     _loc17_._validate();
                  }
                  if(_loc24_.zpp_inner.y != _loc34_)
                  {
                     if(_loc34_ != _loc34_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2::" + "y" + " cannot be NaN";
                     }
                     _loc24_.zpp_inner.y = _loc34_;
                     _loc17_ = _loc24_.zpp_inner;
                     if(_loc17_._invalidate != null)
                     {
                        _loc17_._invalidate(_loc17_);
                     }
                  }
                  if(_loc24_ != null && _loc24_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc17_ = _loc24_.zpp_inner;
                  if(_loc17_._validate != null)
                  {
                     _loc17_._validate();
                  }
                  _loc24_.zpp_inner.y;
                  param1.drawCurve(_loc15_,_loc24_,_loc20_,param7);
               }
            }
            param5 = _loc22_;
            param3 = _loc23_;
            _loc13_ = _loc28_;
            _loc14_ = _loc29_;
            _loc16_ = _loc30_;
            _loc18_ = _loc31_;
            if(_loc15_ != null && _loc15_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(_loc20_ != null && _loc20_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc15_.zpp_inner;
            if(_loc17_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc17_._isimmutable != null)
            {
               _loc17_._isimmutable();
            }
            if(_loc20_ == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null Vec2";
            }
            if(_loc20_ != null && _loc20_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc20_.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            _loc33_ = _loc20_.zpp_inner.x;
            if(_loc20_ != null && _loc20_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc20_.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            _loc34_ = _loc20_.zpp_inner.y;
            if(_loc15_ != null && _loc15_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc15_.zpp_inner;
            if(_loc17_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc17_._isimmutable != null)
            {
               _loc17_._isimmutable();
            }
            if(_loc33_ != _loc33_ || _loc34_ != _loc34_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc15_ != null && _loc15_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc17_ = _loc15_.zpp_inner;
            if(_loc17_._validate != null)
            {
               _loc17_._validate();
            }
            if(_loc15_.zpp_inner.x == _loc33_)
            {
               §§pop();
               if(_loc15_ != null && _loc15_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc15_.zpp_inner;
               if(_loc17_._validate != null)
               {
                  _loc17_._validate();
               }
               §§push(_loc15_.zpp_inner.y == _loc34_);
            }
            if(!§§pop())
            {
               _loc15_.zpp_inner.x = _loc33_;
               _loc15_.zpp_inner.y = _loc34_;
               _loc17_ = _loc15_.zpp_inner;
               if(_loc17_._invalidate != null)
               {
                  _loc17_._invalidate(_loc17_);
               }
            }
            _loc25_ = _loc15_;
            if(_loc20_.zpp_inner.weak)
            {
               if(_loc20_ != null && _loc20_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc17_ = _loc20_.zpp_inner;
               if(_loc17_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc17_._isimmutable != null)
               {
                  _loc17_._isimmutable();
               }
               if(_loc20_.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc17_ = _loc20_.zpp_inner;
               _loc20_.zpp_inner.outer = null;
               _loc20_.zpp_inner = null;
               _loc35_ = _loc20_;
               _loc35_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc35_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc35_;
               }
               ZPP_PubPool.nextVec2 = _loc35_;
               _loc35_.zpp_disp = true;
               _loc36_ = _loc17_;
               if(_loc36_.outer != null)
               {
                  _loc36_.outer.zpp_inner = null;
                  _loc36_.outer = null;
               }
               _loc36_._isimmutable = null;
               _loc36_._validate = null;
               _loc36_._invalidate = null;
               _loc36_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc36_;
               true;
            }
            else
            {
               false;
            }
            _loc25_;
         }
         if(_loc15_ != null && _loc15_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc17_ = _loc15_.zpp_inner;
         if(_loc17_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc17_._isimmutable != null)
         {
            _loc17_._isimmutable();
         }
         if(_loc15_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc17_ = _loc15_.zpp_inner;
         _loc15_.zpp_inner.outer = null;
         _loc15_.zpp_inner = null;
         _loc25_ = _loc15_;
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
         _loc36_ = _loc17_;
         if(_loc36_.outer != null)
         {
            _loc36_.outer.zpp_inner = null;
            _loc36_.outer = null;
         }
         _loc36_._isimmutable = null;
         _loc36_._validate = null;
         _loc36_._invalidate = null;
         _loc36_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc36_;
         if(_loc20_ != null && _loc20_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc17_ = _loc20_.zpp_inner;
         if(_loc17_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc17_._isimmutable != null)
         {
            _loc17_._isimmutable();
         }
         if(_loc20_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc17_ = _loc20_.zpp_inner;
         _loc20_.zpp_inner.outer = null;
         _loc20_.zpp_inner = null;
         _loc25_ = _loc20_;
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
         _loc36_ = _loc17_;
         if(_loc36_.outer != null)
         {
            _loc36_.outer.zpp_inner = null;
            _loc36_.outer = null;
         }
         _loc36_._isimmutable = null;
         _loc36_._validate = null;
         _loc36_._invalidate = null;
         _loc36_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc36_;
         if(_loc24_ != null && _loc24_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc17_ = _loc24_.zpp_inner;
         if(_loc17_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc17_._isimmutable != null)
         {
            _loc17_._isimmutable();
         }
         if(_loc24_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc17_ = _loc24_.zpp_inner;
         _loc24_.zpp_inner.outer = null;
         _loc24_.zpp_inner = null;
         _loc25_ = _loc24_;
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
         _loc36_ = _loc17_;
         if(_loc36_.outer != null)
         {
            _loc36_.outer.zpp_inner = null;
            _loc36_.outer = null;
         }
         _loc36_._isimmutable = null;
         _loc36_._validate = null;
         _loc36_._invalidate = null;
         _loc36_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc36_;
      }
   }
}

