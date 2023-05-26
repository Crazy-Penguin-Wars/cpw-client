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
      
      public static var maxarc:Number = Math.PI / 4;
       
      
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
         _loc10_.zpp_inner.weak = false;
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
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 3000
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      public static function drawSpiral(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:Number, param6:Number, param7:int) : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 2822
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
   }
}
