package zpp_nape.shape
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.shape.Edge;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_Edge
   {
      
      public static var zpp_pool:ZPP_Edge = null;
      
      public static var §internal§:Boolean = false;
       
      
      public var wrap_lnorm:Vec2;
      
      public var wrap_gnorm:Vec2;
      
      public var tp1:Number;
      
      public var tp0:Number;
      
      public var polygon:ZPP_Polygon;
      
      public var outer:Edge;
      
      public var next:ZPP_Edge;
      
      public var lprojection:Number;
      
      public var lp1:ZPP_Vec2;
      
      public var lp0:ZPP_Vec2;
      
      public var lnormy:Number;
      
      public var lnormx:Number;
      
      public var length:Number;
      
      public var gprojection:Number;
      
      public var gp1:ZPP_Vec2;
      
      public var gp0:ZPP_Vec2;
      
      public var gnormy:Number;
      
      public var gnormx:Number;
      
      public function ZPP_Edge()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         tp1 = 0;
         tp0 = 0;
         gp1 = null;
         lp1 = null;
         gp0 = null;
         lp0 = null;
         gprojection = 0;
         lprojection = 0;
         length = 0;
         wrap_gnorm = null;
         gnormy = 0;
         gnormx = 0;
         wrap_lnorm = null;
         lnormy = 0;
         lnormx = 0;
         outer = null;
         polygon = null;
         next = null;
         lnormx = 0;
         lnormy = 0;
         gnormx = 0;
         gnormy = 0;
         length = 0;
         lprojection = 0;
         gprojection = 0;
      }
      
      public function wrapper() : Edge
      {
         if(outer == null)
         {
            ZPP_Edge.§internal§ = true;
            outer = new Edge();
            ZPP_Edge.§internal§ = false;
            outer.zpp_inner = this;
         }
         return outer;
      }
      
      public function lnorm_validate() : void
      {
         if(polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not currently in use";
         }
         polygon.validate_laxi();
         wrap_lnorm.zpp_inner.x = lnormx;
         wrap_lnorm.zpp_inner.y = lnormy;
      }
      
      public function gnorm_validate() : void
      {
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZNPNode_ZPP_Edge;
         var _loc8_:* = null as ZPP_Edge;
         if(polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not currently in use";
         }
         if(polygon.body == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge worldNormal only makes sense if the parent Polygon is contained within a rigid body";
         }
         var _loc1_:ZPP_Polygon = polygon;
         if(_loc1_.zip_gaxi)
         {
            if(_loc1_.body != null)
            {
               _loc1_.zip_gaxi = false;
               _loc1_.validate_laxi();
               _loc2_ = _loc1_.body;
               if(_loc2_.zip_axis)
               {
                  _loc2_.zip_axis = false;
                  _loc2_.axisx = Math.sin(_loc2_.rot);
                  _loc2_.axisy = Math.cos(_loc2_.rot);
               }
               if(_loc1_.zip_gverts)
               {
                  if(_loc1_.body != null)
                  {
                     _loc1_.zip_gverts = false;
                     _loc1_.validate_lverts();
                     _loc2_ = _loc1_.body;
                     if(_loc2_.zip_axis)
                     {
                        _loc2_.zip_axis = false;
                        _loc2_.axisx = Math.sin(_loc2_.rot);
                        _loc2_.axisy = Math.cos(_loc2_.rot);
                     }
                     _loc3_ = _loc1_.lverts.next;
                     _loc4_ = _loc1_.gverts.next;
                     while(_loc4_ != null)
                     {
                        _loc5_ = _loc4_;
                        _loc6_ = _loc3_;
                        _loc3_ = _loc3_.next;
                        _loc5_.x = _loc1_.body.posx + (_loc1_.body.axisy * _loc6_.x - _loc1_.body.axisx * _loc6_.y);
                        _loc5_.y = _loc1_.body.posy + (_loc6_.x * _loc1_.body.axisx + _loc6_.y * _loc1_.body.axisy);
                        _loc4_ = _loc4_.next;
                     }
                  }
               }
               _loc7_ = _loc1_.edges.head;
               _loc3_ = _loc1_.gverts.next;
               _loc4_ = _loc3_;
               _loc3_ = _loc3_.next;
               while(_loc3_ != null)
               {
                  _loc5_ = _loc3_;
                  _loc8_ = _loc7_.elt;
                  _loc7_ = _loc7_.next;
                  _loc8_.gp0 = _loc4_;
                  _loc8_.gp1 = _loc5_;
                  _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
                  _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
                  _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
                  if(_loc8_.wrap_gnorm != null)
                  {
                     _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                     _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
                  }
                  _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
                  _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
                  _loc4_ = _loc5_;
                  _loc3_ = _loc3_.next;
               }
               _loc5_ = _loc1_.gverts.next;
               _loc8_ = _loc7_.elt;
               _loc7_ = _loc7_.next;
               _loc8_.gp0 = _loc4_;
               _loc8_.gp1 = _loc5_;
               _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
               _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
               _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
               if(_loc8_.wrap_gnorm != null)
               {
                  _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                  _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
               }
               _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
               _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
            }
         }
         wrap_gnorm.zpp_inner.x = gnormx;
         wrap_gnorm.zpp_inner.y = gnormy;
      }
      
      public function getlnorm() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = lnormx;
         var _loc2_:Number = lnormy;
         §§push(§§findproperty(wrap_lnorm));
         if(_loc1_ != _loc1_ || _loc2_ != _loc2_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc4_ = new Vec2();
         }
         else
         {
            _loc4_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc4_.zpp_pool;
            _loc4_.zpp_pool = null;
            _loc4_.zpp_disp = false;
            if(_loc4_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc4_.zpp_inner == null)
         {
            _loc5_ = false;
            §§push(_loc4_);
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
            _loc6_._immutable = _loc5_;
            _loc6_.x = _loc1_;
            _loc6_.y = _loc2_;
            §§pop().zpp_inner = _loc6_;
            _loc4_.zpp_inner.outer = _loc4_;
         }
         else
         {
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc1_ != _loc1_ || _loc2_ != _loc2_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            if(_loc4_.zpp_inner.x == _loc1_)
            {
               §§pop();
               if(_loc4_ != null && _loc4_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               §§push(_loc4_.zpp_inner.y == _loc2_);
            }
            if(!§§pop())
            {
               _loc4_.zpp_inner.x = _loc1_;
               _loc4_.zpp_inner.y = _loc2_;
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc4_;
         }
         _loc4_.zpp_inner.weak = false;
         §§pop().wrap_lnorm = _loc4_;
         wrap_lnorm.zpp_inner._immutable = true;
         wrap_lnorm.zpp_inner._validate = lnorm_validate;
      }
      
      public function getgnorm() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = gnormx;
         var _loc2_:Number = gnormy;
         §§push(§§findproperty(wrap_gnorm));
         if(_loc1_ != _loc1_ || _loc2_ != _loc2_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc4_ = new Vec2();
         }
         else
         {
            _loc4_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc4_.zpp_pool;
            _loc4_.zpp_pool = null;
            _loc4_.zpp_disp = false;
            if(_loc4_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc4_.zpp_inner == null)
         {
            _loc5_ = false;
            §§push(_loc4_);
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
            _loc6_._immutable = _loc5_;
            _loc6_.x = _loc1_;
            _loc6_.y = _loc2_;
            §§pop().zpp_inner = _loc6_;
            _loc4_.zpp_inner.outer = _loc4_;
         }
         else
         {
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc1_ != _loc1_ || _loc2_ != _loc2_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            if(_loc4_.zpp_inner.x == _loc1_)
            {
               §§pop();
               if(_loc4_ != null && _loc4_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               §§push(_loc4_.zpp_inner.y == _loc2_);
            }
            if(!§§pop())
            {
               _loc4_.zpp_inner.x = _loc1_;
               _loc4_.zpp_inner.y = _loc2_;
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc4_;
         }
         _loc4_.zpp_inner.weak = false;
         §§pop().wrap_gnorm = _loc4_;
         wrap_gnorm.zpp_inner._immutable = true;
         wrap_gnorm.zpp_inner._validate = gnorm_validate;
      }
   }
}
