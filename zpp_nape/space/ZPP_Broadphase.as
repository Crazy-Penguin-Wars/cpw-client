package zpp_nape.space
{
   import flash.Boot;
   import nape.geom.Mat23;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.phys.BodyType;
   import nape.shape.Circle;
   import nape.shape.Polygon;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Ray;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_Broadphase
   {
       
      
      public var sweep:ZPP_SweepPhase;
      
      public var space:ZPP_Space;
      
      public var matrix:Mat23;
      
      public var is_sweep:Boolean;
      
      public var dynab:ZPP_DynAABBPhase;
      
      public var circShape:Shape;
      
      public var aabbShape:Shape;
      
      public function ZPP_Broadphase()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         circShape = null;
         matrix = null;
         aabbShape = null;
         dynab = null;
         sweep = null;
         is_sweep = false;
         space = null;
      }
      
      public function validateShape(param1:ZPP_Shape) : void
      {
         var _loc2_:* = null as ZPP_Polygon;
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZNPNode_ZPP_Edge;
         var _loc9_:* = null as ZPP_Edge;
         var _loc10_:* = null as ZPP_Circle;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as ZPP_Vec2;
         if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
         {
            _loc2_ = param1.polygon;
            if(_loc2_.zip_gaxi)
            {
               if(_loc2_.body != null)
               {
                  _loc2_.zip_gaxi = false;
                  _loc2_.validate_laxi();
                  _loc3_ = _loc2_.body;
                  if(_loc3_.zip_axis)
                  {
                     _loc3_.zip_axis = false;
                     _loc3_.axisx = Math.sin(_loc3_.rot);
                     _loc3_.axisy = Math.cos(_loc3_.rot);
                  }
                  if(_loc2_.zip_gverts)
                  {
                     if(_loc2_.body != null)
                     {
                        _loc2_.zip_gverts = false;
                        _loc2_.validate_lverts();
                        _loc3_ = _loc2_.body;
                        if(_loc3_.zip_axis)
                        {
                           _loc3_.zip_axis = false;
                           _loc3_.axisx = Math.sin(_loc3_.rot);
                           _loc3_.axisy = Math.cos(_loc3_.rot);
                        }
                        _loc4_ = _loc2_.lverts.next;
                        _loc5_ = _loc2_.gverts.next;
                        while(_loc5_ != null)
                        {
                           _loc6_ = _loc5_;
                           _loc7_ = _loc4_;
                           _loc4_ = _loc4_.next;
                           _loc6_.x = _loc2_.body.posx + (_loc2_.body.axisy * _loc7_.x - _loc2_.body.axisx * _loc7_.y);
                           _loc6_.y = _loc2_.body.posy + (_loc7_.x * _loc2_.body.axisx + _loc7_.y * _loc2_.body.axisy);
                           _loc5_ = _loc5_.next;
                        }
                     }
                  }
                  _loc8_ = _loc2_.edges.head;
                  _loc4_ = _loc2_.gverts.next;
                  _loc5_ = _loc4_;
                  _loc4_ = _loc4_.next;
                  while(_loc4_ != null)
                  {
                     _loc6_ = _loc4_;
                     _loc9_ = _loc8_.elt;
                     _loc8_ = _loc8_.next;
                     _loc9_.gp0 = _loc5_;
                     _loc9_.gp1 = _loc6_;
                     _loc9_.gnormx = _loc2_.body.axisy * _loc9_.lnormx - _loc2_.body.axisx * _loc9_.lnormy;
                     _loc9_.gnormy = _loc9_.lnormx * _loc2_.body.axisx + _loc9_.lnormy * _loc2_.body.axisy;
                     _loc9_.gprojection = _loc2_.body.posx * _loc9_.gnormx + _loc2_.body.posy * _loc9_.gnormy + _loc9_.lprojection;
                     if(_loc9_.wrap_gnorm != null)
                     {
                        _loc9_.wrap_gnorm.zpp_inner.x = _loc9_.gnormx;
                        _loc9_.wrap_gnorm.zpp_inner.y = _loc9_.gnormy;
                     }
                     _loc9_.tp0 = _loc9_.gp0.y * _loc9_.gnormx - _loc9_.gp0.x * _loc9_.gnormy;
                     _loc9_.tp1 = _loc9_.gp1.y * _loc9_.gnormx - _loc9_.gp1.x * _loc9_.gnormy;
                     _loc5_ = _loc6_;
                     _loc4_ = _loc4_.next;
                  }
                  _loc6_ = _loc2_.gverts.next;
                  _loc9_ = _loc8_.elt;
                  _loc8_ = _loc8_.next;
                  _loc9_.gp0 = _loc5_;
                  _loc9_.gp1 = _loc6_;
                  _loc9_.gnormx = _loc2_.body.axisy * _loc9_.lnormx - _loc2_.body.axisx * _loc9_.lnormy;
                  _loc9_.gnormy = _loc9_.lnormx * _loc2_.body.axisx + _loc9_.lnormy * _loc2_.body.axisy;
                  _loc9_.gprojection = _loc2_.body.posx * _loc9_.gnormx + _loc2_.body.posy * _loc9_.gnormy + _loc9_.lprojection;
                  if(_loc9_.wrap_gnorm != null)
                  {
                     _loc9_.wrap_gnorm.zpp_inner.x = _loc9_.gnormx;
                     _loc9_.wrap_gnorm.zpp_inner.y = _loc9_.gnormy;
                  }
                  _loc9_.tp0 = _loc9_.gp0.y * _loc9_.gnormx - _loc9_.gp0.x * _loc9_.gnormy;
                  _loc9_.tp1 = _loc9_.gp1.y * _loc9_.gnormx - _loc9_.gp1.x * _loc9_.gnormy;
               }
            }
         }
         if(param1.zip_aabb)
         {
            if(param1.body != null)
            {
               param1.zip_aabb = false;
               if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc10_ = param1.circle;
                  if(_loc10_.zip_worldCOM)
                  {
                     if(_loc10_.body != null)
                     {
                        _loc10_.zip_worldCOM = false;
                        if(_loc10_.zip_localCOM)
                        {
                           _loc10_.zip_localCOM = false;
                           if(_loc10_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc2_ = _loc10_.polygon;
                              if(_loc2_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful localCOM";
                              }
                              if(_loc2_.lverts.next.next == null)
                              {
                                 _loc2_.localCOMx = _loc2_.lverts.next.x;
                                 _loc2_.localCOMy = _loc2_.lverts.next.y;
                              }
                              else if(_loc2_.lverts.next.next.next == null)
                              {
                                 _loc2_.localCOMx = _loc2_.lverts.next.x;
                                 _loc2_.localCOMy = _loc2_.lverts.next.y;
                                 _loc11_ = 1;
                                 _loc2_.localCOMx += _loc2_.lverts.next.next.x * _loc11_;
                                 _loc2_.localCOMy += _loc2_.lverts.next.next.y * _loc11_;
                                 _loc11_ = 0.5;
                                 _loc2_.localCOMx *= _loc11_;
                                 _loc2_.localCOMy *= _loc11_;
                              }
                              else
                              {
                                 _loc2_.localCOMx = 0;
                                 _loc2_.localCOMy = 0;
                                 _loc11_ = 0;
                                 _loc4_ = _loc2_.lverts.next;
                                 _loc5_ = _loc4_;
                                 _loc4_ = _loc4_.next;
                                 _loc6_ = _loc4_;
                                 _loc4_ = _loc4_.next;
                                 while(_loc4_ != null)
                                 {
                                    _loc7_ = _loc4_;
                                    _loc11_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                                    _loc12_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                                    _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc12_;
                                    _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc12_;
                                    _loc5_ = _loc6_;
                                    _loc6_ = _loc7_;
                                    _loc4_ = _loc4_.next;
                                 }
                                 _loc4_ = _loc2_.lverts.next;
                                 _loc7_ = _loc4_;
                                 _loc11_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                                 _loc12_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                                 _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc12_;
                                 _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc12_;
                                 _loc5_ = _loc6_;
                                 _loc6_ = _loc7_;
                                 _loc4_ = _loc4_.next;
                                 _loc13_ = _loc4_;
                                 _loc11_ += _loc6_.x * (_loc13_.y - _loc5_.y);
                                 _loc12_ = _loc13_.y * _loc6_.x - _loc13_.x * _loc6_.y;
                                 _loc2_.localCOMx += (_loc6_.x + _loc13_.x) * _loc12_;
                                 _loc2_.localCOMy += (_loc6_.y + _loc13_.y) * _loc12_;
                                 _loc11_ = 1 / (3 * _loc11_);
                                 _loc12_ = _loc11_;
                                 _loc2_.localCOMx *= _loc12_;
                                 _loc2_.localCOMy *= _loc12_;
                              }
                           }
                        }
                        _loc3_ = _loc10_.body;
                        if(_loc3_.zip_axis)
                        {
                           _loc3_.zip_axis = false;
                           _loc3_.axisx = Math.sin(_loc3_.rot);
                           _loc3_.axisy = Math.cos(_loc3_.rot);
                        }
                        _loc10_.worldCOMx = _loc10_.body.posx + (_loc10_.body.axisy * _loc10_.localCOMx - _loc10_.body.axisx * _loc10_.localCOMy);
                        _loc10_.worldCOMy = _loc10_.body.posy + (_loc10_.localCOMx * _loc10_.body.axisx + _loc10_.localCOMy * _loc10_.body.axisy);
                     }
                  }
                  _loc11_ = _loc10_.radius;
                  _loc12_ = _loc10_.radius;
                  _loc10_.aabb.minx = _loc10_.worldCOMx - _loc11_;
                  _loc10_.aabb.miny = _loc10_.worldCOMy - _loc12_;
                  _loc10_.aabb.maxx = _loc10_.worldCOMx + _loc11_;
                  _loc10_.aabb.maxy = _loc10_.worldCOMy + _loc12_;
               }
               else
               {
                  _loc2_ = param1.polygon;
                  if(_loc2_.zip_gverts)
                  {
                     if(_loc2_.body != null)
                     {
                        _loc2_.zip_gverts = false;
                        _loc2_.validate_lverts();
                        _loc3_ = _loc2_.body;
                        if(_loc3_.zip_axis)
                        {
                           _loc3_.zip_axis = false;
                           _loc3_.axisx = Math.sin(_loc3_.rot);
                           _loc3_.axisy = Math.cos(_loc3_.rot);
                        }
                        _loc4_ = _loc2_.lverts.next;
                        _loc5_ = _loc2_.gverts.next;
                        while(_loc5_ != null)
                        {
                           _loc6_ = _loc5_;
                           _loc7_ = _loc4_;
                           _loc4_ = _loc4_.next;
                           _loc6_.x = _loc2_.body.posx + (_loc2_.body.axisy * _loc7_.x - _loc2_.body.axisx * _loc7_.y);
                           _loc6_.y = _loc2_.body.posy + (_loc7_.x * _loc2_.body.axisx + _loc7_.y * _loc2_.body.axisy);
                           _loc5_ = _loc5_.next;
                        }
                     }
                  }
                  if(_loc2_.lverts.next == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: An empty polygon has no meaningful bounds";
                  }
                  _loc4_ = _loc2_.gverts.next;
                  _loc2_.aabb.minx = _loc4_.x;
                  _loc2_.aabb.miny = _loc4_.y;
                  _loc2_.aabb.maxx = _loc4_.x;
                  _loc2_.aabb.maxy = _loc4_.y;
                  _loc5_ = _loc2_.gverts.next.next;
                  while(_loc5_ != null)
                  {
                     _loc6_ = _loc5_;
                     if(_loc6_.x < _loc2_.aabb.minx)
                     {
                        _loc2_.aabb.minx = _loc6_.x;
                     }
                     if(_loc6_.x > _loc2_.aabb.maxx)
                     {
                        _loc2_.aabb.maxx = _loc6_.x;
                     }
                     if(_loc6_.y < _loc2_.aabb.miny)
                     {
                        _loc2_.aabb.miny = _loc6_.y;
                     }
                     if(_loc6_.y > _loc2_.aabb.maxy)
                     {
                        _loc2_.aabb.maxy = _loc6_.y;
                     }
                     _loc5_ = _loc5_.next;
                  }
               }
            }
         }
         if(param1.zip_worldCOM)
         {
            if(param1.body != null)
            {
               param1.zip_worldCOM = false;
               if(param1.zip_localCOM)
               {
                  param1.zip_localCOM = false;
                  if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc2_ = param1.polygon;
                     if(_loc2_.lverts.next == null)
                     {
                        Boot.lastError = new Error();
                        throw "Error: An empty polygon has no meaningful localCOM";
                     }
                     if(_loc2_.lverts.next.next == null)
                     {
                        _loc2_.localCOMx = _loc2_.lverts.next.x;
                        _loc2_.localCOMy = _loc2_.lverts.next.y;
                     }
                     else if(_loc2_.lverts.next.next.next == null)
                     {
                        _loc2_.localCOMx = _loc2_.lverts.next.x;
                        _loc2_.localCOMy = _loc2_.lverts.next.y;
                        _loc11_ = 1;
                        _loc2_.localCOMx += _loc2_.lverts.next.next.x * _loc11_;
                        _loc2_.localCOMy += _loc2_.lverts.next.next.y * _loc11_;
                        _loc11_ = 0.5;
                        _loc2_.localCOMx *= _loc11_;
                        _loc2_.localCOMy *= _loc11_;
                     }
                     else
                     {
                        _loc2_.localCOMx = 0;
                        _loc2_.localCOMy = 0;
                        _loc11_ = 0;
                        _loc4_ = _loc2_.lverts.next;
                        _loc5_ = _loc4_;
                        _loc4_ = _loc4_.next;
                        _loc6_ = _loc4_;
                        _loc4_ = _loc4_.next;
                        while(_loc4_ != null)
                        {
                           _loc7_ = _loc4_;
                           _loc11_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                           _loc12_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                           _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc12_;
                           _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc12_;
                           _loc5_ = _loc6_;
                           _loc6_ = _loc7_;
                           _loc4_ = _loc4_.next;
                        }
                        _loc4_ = _loc2_.lverts.next;
                        _loc7_ = _loc4_;
                        _loc11_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                        _loc12_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                        _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc12_;
                        _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc12_;
                        _loc5_ = _loc6_;
                        _loc6_ = _loc7_;
                        _loc4_ = _loc4_.next;
                        _loc13_ = _loc4_;
                        _loc11_ += _loc6_.x * (_loc13_.y - _loc5_.y);
                        _loc12_ = _loc13_.y * _loc6_.x - _loc13_.x * _loc6_.y;
                        _loc2_.localCOMx += (_loc6_.x + _loc13_.x) * _loc12_;
                        _loc2_.localCOMy += (_loc6_.y + _loc13_.y) * _loc12_;
                        _loc11_ = 1 / (3 * _loc11_);
                        _loc12_ = _loc11_;
                        _loc2_.localCOMx *= _loc12_;
                        _loc2_.localCOMy *= _loc12_;
                     }
                  }
               }
               _loc3_ = param1.body;
               if(_loc3_.zip_axis)
               {
                  _loc3_.zip_axis = false;
                  _loc3_.axisx = Math.sin(_loc3_.rot);
                  _loc3_.axisy = Math.cos(_loc3_.rot);
               }
               param1.worldCOMx = param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy);
               param1.worldCOMy = param1.body.posy + (param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy);
            }
         }
      }
      
      public function updateCircShape(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:* = null as Body;
         var _loc5_:* = null as ShapeList;
         var _loc6_:* = null as Shape;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as Vec2;
         var _loc9_:Boolean = false;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as Shape;
         var _loc12_:* = null as ZPP_Circle;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as Mat23;
         var _loc15_:Number = NaN;
         var _loc16_:* = null as Mat23;
         var _loc17_:* = null as ZPP_Mat23;
         var _loc19_:* = null as ZPP_Polygon;
         var _loc20_:* = null as ZPP_Vec2;
         var _loc21_:* = null as ZPP_Vec2;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as ZPP_Body;
         if(circShape == null)
         {
            §§push(§§findproperty(Body));
            if(ZPP_Flags.BodyType_STATIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_STATIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            _loc4_ = new §§pop().Body(ZPP_Flags.BodyType_STATIC);
            _loc5_ = _loc4_.zpp_inner.wrap_shapes;
            _loc7_ = false;
            §§push(§§findproperty(circShape));
            §§push(§§findproperty(Circle));
            §§push(param3);
            if(param1 != param1 || param2 != param2)
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
               _loc10_.x = param1;
               _loc10_.y = param2;
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
               if(param1 != param1 || param2 != param2)
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
               if(_loc8_.zpp_inner.x == param1)
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
                  §§push(_loc8_.zpp_inner.y == param2);
               }
               if(!§§pop())
               {
                  _loc8_.zpp_inner.x = param1;
                  _loc8_.zpp_inner.y = param2;
                  _loc10_ = _loc8_.zpp_inner;
                  if(_loc10_._invalidate != null)
                  {
                     _loc10_._invalidate(_loc10_);
                  }
               }
               _loc8_;
            }
            _loc8_.zpp_inner.weak = _loc7_;
            _loc6_ = §§pop().circShape = new §§pop().Circle(§§pop(),_loc8_);
            if(_loc5_.zpp_inner.reverse_flag)
            {
               _loc5_.push(_loc6_);
            }
            else
            {
               _loc5_.unshift(_loc6_);
            }
         }
         else
         {
            _loc12_ = circShape.zpp_inner.circle;
            _loc13_ = param3 / _loc12_.radius;
            if(matrix == null)
            {
               matrix = new Mat23();
            }
            _loc14_ = matrix;
            _loc16_ = matrix;
            if(_loc13_ != _loc13_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "d" + " cannot be NaN";
            }
            _loc16_.zpp_inner.d = _loc13_;
            _loc17_ = _loc16_.zpp_inner;
            if(_loc17_._invalidate != null)
            {
               _loc17_._invalidate();
            }
            _loc15_ = _loc16_.zpp_inner.d;
            if(_loc15_ != _loc15_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "a" + " cannot be NaN";
            }
            _loc14_.zpp_inner.a = _loc15_;
            _loc17_ = _loc14_.zpp_inner;
            if(_loc17_._invalidate != null)
            {
               _loc17_._invalidate();
            }
            _loc14_.zpp_inner.a;
            _loc14_ = matrix;
            _loc16_ = matrix;
            _loc16_.zpp_inner.c = 0;
            _loc17_ = _loc16_.zpp_inner;
            if(_loc17_._invalidate != null)
            {
               _loc17_._invalidate();
            }
            _loc15_ = _loc16_.zpp_inner.c;
            if(_loc15_ != _loc15_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "b" + " cannot be NaN";
            }
            _loc14_.zpp_inner.b = _loc15_;
            _loc17_ = _loc14_.zpp_inner;
            if(_loc17_._invalidate != null)
            {
               _loc17_._invalidate();
            }
            _loc14_.zpp_inner.b;
            _loc14_ = matrix;
            _loc15_ = param1 - _loc13_ * _loc12_.localCOMx;
            if(_loc15_ != _loc15_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "tx" + " cannot be NaN";
            }
            _loc14_.zpp_inner.tx = _loc15_;
            _loc17_ = _loc14_.zpp_inner;
            if(_loc17_._invalidate != null)
            {
               _loc17_._invalidate();
            }
            _loc14_.zpp_inner.tx;
            _loc14_ = matrix;
            _loc15_ = param2 - _loc13_ * _loc12_.localCOMy;
            if(_loc15_ != _loc15_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "ty" + " cannot be NaN";
            }
            _loc14_.zpp_inner.ty = _loc15_;
            _loc17_ = _loc14_.zpp_inner;
            if(_loc17_._invalidate != null)
            {
               _loc17_._invalidate();
            }
            _loc14_.zpp_inner.ty;
            circShape.transform(matrix);
         }
         var _loc18_:ZPP_Shape = circShape.zpp_inner;
         if(_loc18_.zip_aabb)
         {
            if(_loc18_.body != null)
            {
               _loc18_.zip_aabb = false;
               if(_loc18_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc12_ = _loc18_.circle;
                  if(_loc12_.zip_worldCOM)
                  {
                     if(_loc12_.body != null)
                     {
                        _loc12_.zip_worldCOM = false;
                        if(_loc12_.zip_localCOM)
                        {
                           _loc12_.zip_localCOM = false;
                           if(_loc12_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc19_ = _loc12_.polygon;
                              if(_loc19_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful localCOM";
                              }
                              if(_loc19_.lverts.next.next == null)
                              {
                                 _loc19_.localCOMx = _loc19_.lverts.next.x;
                                 _loc19_.localCOMy = _loc19_.lverts.next.y;
                              }
                              else if(_loc19_.lverts.next.next.next == null)
                              {
                                 _loc19_.localCOMx = _loc19_.lverts.next.x;
                                 _loc19_.localCOMy = _loc19_.lverts.next.y;
                                 _loc13_ = 1;
                                 _loc19_.localCOMx += _loc19_.lverts.next.next.x * _loc13_;
                                 _loc19_.localCOMy += _loc19_.lverts.next.next.y * _loc13_;
                                 _loc13_ = 0.5;
                                 _loc19_.localCOMx *= _loc13_;
                                 _loc19_.localCOMy *= _loc13_;
                              }
                              else
                              {
                                 _loc19_.localCOMx = 0;
                                 _loc19_.localCOMy = 0;
                                 _loc13_ = 0;
                                 _loc10_ = _loc19_.lverts.next;
                                 _loc20_ = _loc10_;
                                 _loc10_ = _loc10_.next;
                                 _loc21_ = _loc10_;
                                 _loc10_ = _loc10_.next;
                                 while(_loc10_ != null)
                                 {
                                    _loc22_ = _loc10_;
                                    _loc13_ += _loc21_.x * (_loc22_.y - _loc20_.y);
                                    _loc15_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                                    _loc19_.localCOMx += (_loc21_.x + _loc22_.x) * _loc15_;
                                    _loc19_.localCOMy += (_loc21_.y + _loc22_.y) * _loc15_;
                                    _loc20_ = _loc21_;
                                    _loc21_ = _loc22_;
                                    _loc10_ = _loc10_.next;
                                 }
                                 _loc10_ = _loc19_.lverts.next;
                                 _loc22_ = _loc10_;
                                 _loc13_ += _loc21_.x * (_loc22_.y - _loc20_.y);
                                 _loc15_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                                 _loc19_.localCOMx += (_loc21_.x + _loc22_.x) * _loc15_;
                                 _loc19_.localCOMy += (_loc21_.y + _loc22_.y) * _loc15_;
                                 _loc20_ = _loc21_;
                                 _loc21_ = _loc22_;
                                 _loc10_ = _loc10_.next;
                                 _loc23_ = _loc10_;
                                 _loc13_ += _loc21_.x * (_loc23_.y - _loc20_.y);
                                 _loc15_ = _loc23_.y * _loc21_.x - _loc23_.x * _loc21_.y;
                                 _loc19_.localCOMx += (_loc21_.x + _loc23_.x) * _loc15_;
                                 _loc19_.localCOMy += (_loc21_.y + _loc23_.y) * _loc15_;
                                 _loc13_ = 1 / (3 * _loc13_);
                                 _loc15_ = _loc13_;
                                 _loc19_.localCOMx *= _loc15_;
                                 _loc19_.localCOMy *= _loc15_;
                              }
                           }
                        }
                        _loc24_ = _loc12_.body;
                        if(_loc24_.zip_axis)
                        {
                           _loc24_.zip_axis = false;
                           _loc24_.axisx = Math.sin(_loc24_.rot);
                           _loc24_.axisy = Math.cos(_loc24_.rot);
                        }
                        _loc12_.worldCOMx = _loc12_.body.posx + (_loc12_.body.axisy * _loc12_.localCOMx - _loc12_.body.axisx * _loc12_.localCOMy);
                        _loc12_.worldCOMy = _loc12_.body.posy + (_loc12_.localCOMx * _loc12_.body.axisx + _loc12_.localCOMy * _loc12_.body.axisy);
                     }
                  }
                  _loc13_ = _loc12_.radius;
                  _loc15_ = _loc12_.radius;
                  _loc12_.aabb.minx = _loc12_.worldCOMx - _loc13_;
                  _loc12_.aabb.miny = _loc12_.worldCOMy - _loc15_;
                  _loc12_.aabb.maxx = _loc12_.worldCOMx + _loc13_;
                  _loc12_.aabb.maxy = _loc12_.worldCOMy + _loc15_;
               }
               else
               {
                  _loc19_ = _loc18_.polygon;
                  if(_loc19_.zip_gverts)
                  {
                     if(_loc19_.body != null)
                     {
                        _loc19_.zip_gverts = false;
                        _loc19_.validate_lverts();
                        _loc24_ = _loc19_.body;
                        if(_loc24_.zip_axis)
                        {
                           _loc24_.zip_axis = false;
                           _loc24_.axisx = Math.sin(_loc24_.rot);
                           _loc24_.axisy = Math.cos(_loc24_.rot);
                        }
                        _loc10_ = _loc19_.lverts.next;
                        _loc20_ = _loc19_.gverts.next;
                        while(_loc20_ != null)
                        {
                           _loc21_ = _loc20_;
                           _loc22_ = _loc10_;
                           _loc10_ = _loc10_.next;
                           _loc21_.x = _loc19_.body.posx + (_loc19_.body.axisy * _loc22_.x - _loc19_.body.axisx * _loc22_.y);
                           _loc21_.y = _loc19_.body.posy + (_loc22_.x * _loc19_.body.axisx + _loc22_.y * _loc19_.body.axisy);
                           _loc20_ = _loc20_.next;
                        }
                     }
                  }
                  if(_loc19_.lverts.next == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: An empty polygon has no meaningful bounds";
                  }
                  _loc10_ = _loc19_.gverts.next;
                  _loc19_.aabb.minx = _loc10_.x;
                  _loc19_.aabb.miny = _loc10_.y;
                  _loc19_.aabb.maxx = _loc10_.x;
                  _loc19_.aabb.maxy = _loc10_.y;
                  _loc20_ = _loc19_.gverts.next.next;
                  while(_loc20_ != null)
                  {
                     _loc21_ = _loc20_;
                     if(_loc21_.x < _loc19_.aabb.minx)
                     {
                        _loc19_.aabb.minx = _loc21_.x;
                     }
                     if(_loc21_.x > _loc19_.aabb.maxx)
                     {
                        _loc19_.aabb.maxx = _loc21_.x;
                     }
                     if(_loc21_.y < _loc19_.aabb.miny)
                     {
                        _loc19_.aabb.miny = _loc21_.y;
                     }
                     if(_loc21_.y > _loc19_.aabb.maxy)
                     {
                        _loc19_.aabb.maxy = _loc21_.y;
                     }
                     _loc20_ = _loc20_.next;
                  }
               }
            }
         }
      }
      
      public function updateAABBShape(param1:ZPP_AABB) : void
      {
         var _loc2_:* = null as Body;
         var _loc3_:* = null as ShapeList;
         var _loc4_:* = null as Shape;
         var _loc5_:* = null as Shape;
         var _loc6_:* = null as ZPP_AABB;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as Mat23;
         var _loc10_:* = null as ZPP_Mat23;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as Mat23;
         var _loc14_:* = null as ZPP_Circle;
         var _loc15_:* = null as ZPP_Polygon;
         var _loc16_:* = null as ZPP_Vec2;
         var _loc17_:* = null as ZPP_Vec2;
         var _loc18_:* = null as ZPP_Vec2;
         var _loc19_:* = null as ZPP_Vec2;
         var _loc20_:* = null as ZPP_Vec2;
         var _loc21_:* = null as ZPP_Body;
         var _loc22_:* = null as ZNPNode_ZPP_Edge;
         var _loc23_:* = null as ZPP_Edge;
         if(aabbShape == null)
         {
            §§push(§§findproperty(Body));
            if(ZPP_Flags.BodyType_STATIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_STATIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            _loc2_ = new §§pop().Body(ZPP_Flags.BodyType_STATIC);
            _loc3_ = _loc2_.zpp_inner.wrap_shapes;
            _loc4_ = aabbShape = new Polygon(Polygon.rect(param1.minx,param1.miny,param1.maxx - param1.minx,param1.maxy - param1.miny));
            if(_loc3_.zpp_inner.reverse_flag)
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc3_.unshift(_loc4_);
            }
         }
         else
         {
            _loc6_ = aabbShape.zpp_inner.aabb;
            _loc7_ = (param1.maxx - param1.minx) / (_loc6_.maxx - _loc6_.minx);
            _loc8_ = (param1.maxy - param1.miny) / (_loc6_.maxy - _loc6_.miny);
            if(matrix == null)
            {
               matrix = new Mat23();
            }
            _loc9_ = matrix;
            if(_loc7_ != _loc7_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "a" + " cannot be NaN";
            }
            _loc9_.zpp_inner.a = _loc7_;
            _loc10_ = _loc9_.zpp_inner;
            if(_loc10_._invalidate != null)
            {
               _loc10_._invalidate();
            }
            _loc9_.zpp_inner.a;
            _loc9_ = matrix;
            _loc12_ = matrix;
            _loc12_.zpp_inner.c = 0;
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._invalidate != null)
            {
               _loc10_._invalidate();
            }
            _loc11_ = _loc12_.zpp_inner.c;
            if(_loc11_ != _loc11_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "b" + " cannot be NaN";
            }
            _loc9_.zpp_inner.b = _loc11_;
            _loc10_ = _loc9_.zpp_inner;
            if(_loc10_._invalidate != null)
            {
               _loc10_._invalidate();
            }
            _loc9_.zpp_inner.b;
            _loc9_ = matrix;
            if(_loc8_ != _loc8_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "d" + " cannot be NaN";
            }
            _loc9_.zpp_inner.d = _loc8_;
            _loc10_ = _loc9_.zpp_inner;
            if(_loc10_._invalidate != null)
            {
               _loc10_._invalidate();
            }
            _loc9_.zpp_inner.d;
            _loc9_ = matrix;
            _loc11_ = param1.minx - _loc7_ * _loc6_.minx;
            if(_loc11_ != _loc11_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "tx" + " cannot be NaN";
            }
            _loc9_.zpp_inner.tx = _loc11_;
            _loc10_ = _loc9_.zpp_inner;
            if(_loc10_._invalidate != null)
            {
               _loc10_._invalidate();
            }
            _loc9_.zpp_inner.tx;
            _loc9_ = matrix;
            _loc11_ = param1.miny - _loc8_ * _loc6_.miny;
            if(_loc11_ != _loc11_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "ty" + " cannot be NaN";
            }
            _loc9_.zpp_inner.ty = _loc11_;
            _loc10_ = _loc9_.zpp_inner;
            if(_loc10_._invalidate != null)
            {
               _loc10_._invalidate();
            }
            _loc9_.zpp_inner.ty;
            aabbShape.transform(matrix);
         }
         var _loc13_:ZPP_Shape = aabbShape.zpp_inner;
         if(_loc13_.zip_aabb)
         {
            if(_loc13_.body != null)
            {
               _loc13_.zip_aabb = false;
               if(_loc13_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc14_ = _loc13_.circle;
                  if(_loc14_.zip_worldCOM)
                  {
                     if(_loc14_.body != null)
                     {
                        _loc14_.zip_worldCOM = false;
                        if(_loc14_.zip_localCOM)
                        {
                           _loc14_.zip_localCOM = false;
                           if(_loc14_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc15_ = _loc14_.polygon;
                              if(_loc15_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful localCOM";
                              }
                              if(_loc15_.lverts.next.next == null)
                              {
                                 _loc15_.localCOMx = _loc15_.lverts.next.x;
                                 _loc15_.localCOMy = _loc15_.lverts.next.y;
                              }
                              else if(_loc15_.lverts.next.next.next == null)
                              {
                                 _loc15_.localCOMx = _loc15_.lverts.next.x;
                                 _loc15_.localCOMy = _loc15_.lverts.next.y;
                                 _loc7_ = 1;
                                 _loc15_.localCOMx += _loc15_.lverts.next.next.x * _loc7_;
                                 _loc15_.localCOMy += _loc15_.lverts.next.next.y * _loc7_;
                                 _loc7_ = 0.5;
                                 _loc15_.localCOMx *= _loc7_;
                                 _loc15_.localCOMy *= _loc7_;
                              }
                              else
                              {
                                 _loc15_.localCOMx = 0;
                                 _loc15_.localCOMy = 0;
                                 _loc7_ = 0;
                                 _loc16_ = _loc15_.lverts.next;
                                 _loc17_ = _loc16_;
                                 _loc16_ = _loc16_.next;
                                 _loc18_ = _loc16_;
                                 _loc16_ = _loc16_.next;
                                 while(_loc16_ != null)
                                 {
                                    _loc19_ = _loc16_;
                                    _loc7_ += _loc18_.x * (_loc19_.y - _loc17_.y);
                                    _loc8_ = _loc19_.y * _loc18_.x - _loc19_.x * _loc18_.y;
                                    _loc15_.localCOMx += (_loc18_.x + _loc19_.x) * _loc8_;
                                    _loc15_.localCOMy += (_loc18_.y + _loc19_.y) * _loc8_;
                                    _loc17_ = _loc18_;
                                    _loc18_ = _loc19_;
                                    _loc16_ = _loc16_.next;
                                 }
                                 _loc16_ = _loc15_.lverts.next;
                                 _loc19_ = _loc16_;
                                 _loc7_ += _loc18_.x * (_loc19_.y - _loc17_.y);
                                 _loc8_ = _loc19_.y * _loc18_.x - _loc19_.x * _loc18_.y;
                                 _loc15_.localCOMx += (_loc18_.x + _loc19_.x) * _loc8_;
                                 _loc15_.localCOMy += (_loc18_.y + _loc19_.y) * _loc8_;
                                 _loc17_ = _loc18_;
                                 _loc18_ = _loc19_;
                                 _loc16_ = _loc16_.next;
                                 _loc20_ = _loc16_;
                                 _loc7_ += _loc18_.x * (_loc20_.y - _loc17_.y);
                                 _loc8_ = _loc20_.y * _loc18_.x - _loc20_.x * _loc18_.y;
                                 _loc15_.localCOMx += (_loc18_.x + _loc20_.x) * _loc8_;
                                 _loc15_.localCOMy += (_loc18_.y + _loc20_.y) * _loc8_;
                                 _loc7_ = 1 / (3 * _loc7_);
                                 _loc8_ = _loc7_;
                                 _loc15_.localCOMx *= _loc8_;
                                 _loc15_.localCOMy *= _loc8_;
                              }
                           }
                        }
                        _loc21_ = _loc14_.body;
                        if(_loc21_.zip_axis)
                        {
                           _loc21_.zip_axis = false;
                           _loc21_.axisx = Math.sin(_loc21_.rot);
                           _loc21_.axisy = Math.cos(_loc21_.rot);
                        }
                        _loc14_.worldCOMx = _loc14_.body.posx + (_loc14_.body.axisy * _loc14_.localCOMx - _loc14_.body.axisx * _loc14_.localCOMy);
                        _loc14_.worldCOMy = _loc14_.body.posy + (_loc14_.localCOMx * _loc14_.body.axisx + _loc14_.localCOMy * _loc14_.body.axisy);
                     }
                  }
                  _loc7_ = _loc14_.radius;
                  _loc8_ = _loc14_.radius;
                  _loc14_.aabb.minx = _loc14_.worldCOMx - _loc7_;
                  _loc14_.aabb.miny = _loc14_.worldCOMy - _loc8_;
                  _loc14_.aabb.maxx = _loc14_.worldCOMx + _loc7_;
                  _loc14_.aabb.maxy = _loc14_.worldCOMy + _loc8_;
               }
               else
               {
                  _loc15_ = _loc13_.polygon;
                  if(_loc15_.zip_gverts)
                  {
                     if(_loc15_.body != null)
                     {
                        _loc15_.zip_gverts = false;
                        _loc15_.validate_lverts();
                        _loc21_ = _loc15_.body;
                        if(_loc21_.zip_axis)
                        {
                           _loc21_.zip_axis = false;
                           _loc21_.axisx = Math.sin(_loc21_.rot);
                           _loc21_.axisy = Math.cos(_loc21_.rot);
                        }
                        _loc16_ = _loc15_.lverts.next;
                        _loc17_ = _loc15_.gverts.next;
                        while(_loc17_ != null)
                        {
                           _loc18_ = _loc17_;
                           _loc19_ = _loc16_;
                           _loc16_ = _loc16_.next;
                           _loc18_.x = _loc15_.body.posx + (_loc15_.body.axisy * _loc19_.x - _loc15_.body.axisx * _loc19_.y);
                           _loc18_.y = _loc15_.body.posy + (_loc19_.x * _loc15_.body.axisx + _loc19_.y * _loc15_.body.axisy);
                           _loc17_ = _loc17_.next;
                        }
                     }
                  }
                  if(_loc15_.lverts.next == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: An empty polygon has no meaningful bounds";
                  }
                  _loc16_ = _loc15_.gverts.next;
                  _loc15_.aabb.minx = _loc16_.x;
                  _loc15_.aabb.miny = _loc16_.y;
                  _loc15_.aabb.maxx = _loc16_.x;
                  _loc15_.aabb.maxy = _loc16_.y;
                  _loc17_ = _loc15_.gverts.next.next;
                  while(_loc17_ != null)
                  {
                     _loc18_ = _loc17_;
                     if(_loc18_.x < _loc15_.aabb.minx)
                     {
                        _loc15_.aabb.minx = _loc18_.x;
                     }
                     if(_loc18_.x > _loc15_.aabb.maxx)
                     {
                        _loc15_.aabb.maxx = _loc18_.x;
                     }
                     if(_loc18_.y < _loc15_.aabb.miny)
                     {
                        _loc15_.aabb.miny = _loc18_.y;
                     }
                     if(_loc18_.y > _loc15_.aabb.maxy)
                     {
                        _loc15_.aabb.maxy = _loc18_.y;
                     }
                     _loc17_ = _loc17_.next;
                  }
               }
            }
         }
         _loc15_ = aabbShape.zpp_inner.polygon;
         if(_loc15_.zip_gaxi)
         {
            if(_loc15_.body != null)
            {
               _loc15_.zip_gaxi = false;
               _loc15_.validate_laxi();
               _loc21_ = _loc15_.body;
               if(_loc21_.zip_axis)
               {
                  _loc21_.zip_axis = false;
                  _loc21_.axisx = Math.sin(_loc21_.rot);
                  _loc21_.axisy = Math.cos(_loc21_.rot);
               }
               if(_loc15_.zip_gverts)
               {
                  if(_loc15_.body != null)
                  {
                     _loc15_.zip_gverts = false;
                     _loc15_.validate_lverts();
                     _loc21_ = _loc15_.body;
                     if(_loc21_.zip_axis)
                     {
                        _loc21_.zip_axis = false;
                        _loc21_.axisx = Math.sin(_loc21_.rot);
                        _loc21_.axisy = Math.cos(_loc21_.rot);
                     }
                     _loc16_ = _loc15_.lverts.next;
                     _loc17_ = _loc15_.gverts.next;
                     while(_loc17_ != null)
                     {
                        _loc18_ = _loc17_;
                        _loc19_ = _loc16_;
                        _loc16_ = _loc16_.next;
                        _loc18_.x = _loc15_.body.posx + (_loc15_.body.axisy * _loc19_.x - _loc15_.body.axisx * _loc19_.y);
                        _loc18_.y = _loc15_.body.posy + (_loc19_.x * _loc15_.body.axisx + _loc19_.y * _loc15_.body.axisy);
                        _loc17_ = _loc17_.next;
                     }
                  }
               }
               _loc22_ = _loc15_.edges.head;
               _loc16_ = _loc15_.gverts.next;
               _loc17_ = _loc16_;
               _loc16_ = _loc16_.next;
               while(_loc16_ != null)
               {
                  _loc18_ = _loc16_;
                  _loc23_ = _loc22_.elt;
                  _loc22_ = _loc22_.next;
                  _loc23_.gp0 = _loc17_;
                  _loc23_.gp1 = _loc18_;
                  _loc23_.gnormx = _loc15_.body.axisy * _loc23_.lnormx - _loc15_.body.axisx * _loc23_.lnormy;
                  _loc23_.gnormy = _loc23_.lnormx * _loc15_.body.axisx + _loc23_.lnormy * _loc15_.body.axisy;
                  _loc23_.gprojection = _loc15_.body.posx * _loc23_.gnormx + _loc15_.body.posy * _loc23_.gnormy + _loc23_.lprojection;
                  if(_loc23_.wrap_gnorm != null)
                  {
                     _loc23_.wrap_gnorm.zpp_inner.x = _loc23_.gnormx;
                     _loc23_.wrap_gnorm.zpp_inner.y = _loc23_.gnormy;
                  }
                  _loc23_.tp0 = _loc23_.gp0.y * _loc23_.gnormx - _loc23_.gp0.x * _loc23_.gnormy;
                  _loc23_.tp1 = _loc23_.gp1.y * _loc23_.gnormx - _loc23_.gp1.x * _loc23_.gnormy;
                  _loc17_ = _loc18_;
                  _loc16_ = _loc16_.next;
               }
               _loc18_ = _loc15_.gverts.next;
               _loc23_ = _loc22_.elt;
               _loc22_ = _loc22_.next;
               _loc23_.gp0 = _loc17_;
               _loc23_.gp1 = _loc18_;
               _loc23_.gnormx = _loc15_.body.axisy * _loc23_.lnormx - _loc15_.body.axisx * _loc23_.lnormy;
               _loc23_.gnormy = _loc23_.lnormx * _loc15_.body.axisx + _loc23_.lnormy * _loc15_.body.axisy;
               _loc23_.gprojection = _loc15_.body.posx * _loc23_.gnormx + _loc15_.body.posy * _loc23_.gnormy + _loc23_.lprojection;
               if(_loc23_.wrap_gnorm != null)
               {
                  _loc23_.wrap_gnorm.zpp_inner.x = _loc23_.gnormx;
                  _loc23_.wrap_gnorm.zpp_inner.y = _loc23_.gnormy;
               }
               _loc23_.tp0 = _loc23_.gp0.y * _loc23_.gnormx - _loc23_.gp0.x * _loc23_.gnormy;
               _loc23_.tp1 = _loc23_.gp1.y * _loc23_.gnormx - _loc23_.gp1.x * _loc23_.gnormy;
            }
         }
      }
      
      public function sync(param1:ZPP_Shape) : void
      {
         var _loc2_:* = null as ZPP_Circle;
         var _loc3_:* = null as ZPP_Polygon;
         var _loc4_:Number = NaN;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:Number = NaN;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as ZPP_Body;
         var _loc12_:* = null as ZPP_DynAABBPhase;
         var _loc13_:* = null as ZPP_AABBNode;
         var _loc14_:Boolean = false;
         var _loc15_:* = null as ZPP_AABB;
         var _loc16_:* = null as ZPP_AABB;
         if(is_sweep)
         {
            if(!sweep.space.continuous)
            {
               if(param1.zip_aabb)
               {
                  if(param1.body != null)
                  {
                     param1.zip_aabb = false;
                     if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc2_ = param1.circle;
                        if(_loc2_.zip_worldCOM)
                        {
                           if(_loc2_.body != null)
                           {
                              _loc2_.zip_worldCOM = false;
                              if(_loc2_.zip_localCOM)
                              {
                                 _loc2_.zip_localCOM = false;
                                 if(_loc2_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc3_ = _loc2_.polygon;
                                    if(_loc3_.lverts.next == null)
                                    {
                                       Boot.lastError = new Error();
                                       throw "Error: An empty polygon has no meaningful localCOM";
                                    }
                                    if(_loc3_.lverts.next.next == null)
                                    {
                                       _loc3_.localCOMx = _loc3_.lverts.next.x;
                                       _loc3_.localCOMy = _loc3_.lverts.next.y;
                                    }
                                    else if(_loc3_.lverts.next.next.next == null)
                                    {
                                       _loc3_.localCOMx = _loc3_.lverts.next.x;
                                       _loc3_.localCOMy = _loc3_.lverts.next.y;
                                       _loc4_ = 1;
                                       _loc3_.localCOMx += _loc3_.lverts.next.next.x * _loc4_;
                                       _loc3_.localCOMy += _loc3_.lverts.next.next.y * _loc4_;
                                       _loc4_ = 0.5;
                                       _loc3_.localCOMx *= _loc4_;
                                       _loc3_.localCOMy *= _loc4_;
                                    }
                                    else
                                    {
                                       _loc3_.localCOMx = 0;
                                       _loc3_.localCOMy = 0;
                                       _loc4_ = 0;
                                       _loc5_ = _loc3_.lverts.next;
                                       _loc6_ = _loc5_;
                                       _loc5_ = _loc5_.next;
                                       _loc7_ = _loc5_;
                                       _loc5_ = _loc5_.next;
                                       while(_loc5_ != null)
                                       {
                                          _loc8_ = _loc5_;
                                          _loc4_ += _loc7_.x * (_loc8_.y - _loc6_.y);
                                          _loc9_ = _loc8_.y * _loc7_.x - _loc8_.x * _loc7_.y;
                                          _loc3_.localCOMx += (_loc7_.x + _loc8_.x) * _loc9_;
                                          _loc3_.localCOMy += (_loc7_.y + _loc8_.y) * _loc9_;
                                          _loc6_ = _loc7_;
                                          _loc7_ = _loc8_;
                                          _loc5_ = _loc5_.next;
                                       }
                                       _loc5_ = _loc3_.lverts.next;
                                       _loc8_ = _loc5_;
                                       _loc4_ += _loc7_.x * (_loc8_.y - _loc6_.y);
                                       _loc9_ = _loc8_.y * _loc7_.x - _loc8_.x * _loc7_.y;
                                       _loc3_.localCOMx += (_loc7_.x + _loc8_.x) * _loc9_;
                                       _loc3_.localCOMy += (_loc7_.y + _loc8_.y) * _loc9_;
                                       _loc6_ = _loc7_;
                                       _loc7_ = _loc8_;
                                       _loc5_ = _loc5_.next;
                                       _loc10_ = _loc5_;
                                       _loc4_ += _loc7_.x * (_loc10_.y - _loc6_.y);
                                       _loc9_ = _loc10_.y * _loc7_.x - _loc10_.x * _loc7_.y;
                                       _loc3_.localCOMx += (_loc7_.x + _loc10_.x) * _loc9_;
                                       _loc3_.localCOMy += (_loc7_.y + _loc10_.y) * _loc9_;
                                       _loc4_ = 1 / (3 * _loc4_);
                                       _loc9_ = _loc4_;
                                       _loc3_.localCOMx *= _loc9_;
                                       _loc3_.localCOMy *= _loc9_;
                                    }
                                 }
                              }
                              _loc11_ = _loc2_.body;
                              if(_loc11_.zip_axis)
                              {
                                 _loc11_.zip_axis = false;
                                 _loc11_.axisx = Math.sin(_loc11_.rot);
                                 _loc11_.axisy = Math.cos(_loc11_.rot);
                              }
                              _loc2_.worldCOMx = _loc2_.body.posx + (_loc2_.body.axisy * _loc2_.localCOMx - _loc2_.body.axisx * _loc2_.localCOMy);
                              _loc2_.worldCOMy = _loc2_.body.posy + (_loc2_.localCOMx * _loc2_.body.axisx + _loc2_.localCOMy * _loc2_.body.axisy);
                           }
                        }
                        _loc4_ = _loc2_.radius;
                        _loc9_ = _loc2_.radius;
                        _loc2_.aabb.minx = _loc2_.worldCOMx - _loc4_;
                        _loc2_.aabb.miny = _loc2_.worldCOMy - _loc9_;
                        _loc2_.aabb.maxx = _loc2_.worldCOMx + _loc4_;
                        _loc2_.aabb.maxy = _loc2_.worldCOMy + _loc9_;
                     }
                     else
                     {
                        _loc3_ = param1.polygon;
                        if(_loc3_.zip_gverts)
                        {
                           if(_loc3_.body != null)
                           {
                              _loc3_.zip_gverts = false;
                              _loc3_.validate_lverts();
                              _loc11_ = _loc3_.body;
                              if(_loc11_.zip_axis)
                              {
                                 _loc11_.zip_axis = false;
                                 _loc11_.axisx = Math.sin(_loc11_.rot);
                                 _loc11_.axisy = Math.cos(_loc11_.rot);
                              }
                              _loc5_ = _loc3_.lverts.next;
                              _loc6_ = _loc3_.gverts.next;
                              while(_loc6_ != null)
                              {
                                 _loc7_ = _loc6_;
                                 _loc8_ = _loc5_;
                                 _loc5_ = _loc5_.next;
                                 _loc7_.x = _loc3_.body.posx + (_loc3_.body.axisy * _loc8_.x - _loc3_.body.axisx * _loc8_.y);
                                 _loc7_.y = _loc3_.body.posy + (_loc8_.x * _loc3_.body.axisx + _loc8_.y * _loc3_.body.axisy);
                                 _loc6_ = _loc6_.next;
                              }
                           }
                        }
                        if(_loc3_.lverts.next == null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: An empty polygon has no meaningful bounds";
                        }
                        _loc5_ = _loc3_.gverts.next;
                        _loc3_.aabb.minx = _loc5_.x;
                        _loc3_.aabb.miny = _loc5_.y;
                        _loc3_.aabb.maxx = _loc5_.x;
                        _loc3_.aabb.maxy = _loc5_.y;
                        _loc6_ = _loc3_.gverts.next.next;
                        while(_loc6_ != null)
                        {
                           _loc7_ = _loc6_;
                           if(_loc7_.x < _loc3_.aabb.minx)
                           {
                              _loc3_.aabb.minx = _loc7_.x;
                           }
                           if(_loc7_.x > _loc3_.aabb.maxx)
                           {
                              _loc3_.aabb.maxx = _loc7_.x;
                           }
                           if(_loc7_.y < _loc3_.aabb.miny)
                           {
                              _loc3_.aabb.miny = _loc7_.y;
                           }
                           if(_loc7_.y > _loc3_.aabb.maxy)
                           {
                              _loc3_.aabb.maxy = _loc7_.y;
                           }
                           _loc6_ = _loc6_.next;
                        }
                     }
                  }
               }
            }
         }
         else
         {
            _loc12_ = dynab;
            _loc13_ = param1.node;
            if(!_loc13_.synced)
            {
               if(!_loc12_.space.continuous)
               {
                  if(param1.zip_aabb)
                  {
                     if(param1.body != null)
                     {
                        param1.zip_aabb = false;
                        if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc2_ = param1.circle;
                           if(_loc2_.zip_worldCOM)
                           {
                              if(_loc2_.body != null)
                              {
                                 _loc2_.zip_worldCOM = false;
                                 if(_loc2_.zip_localCOM)
                                 {
                                    _loc2_.zip_localCOM = false;
                                    if(_loc2_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                       _loc3_ = _loc2_.polygon;
                                       if(_loc3_.lverts.next == null)
                                       {
                                          Boot.lastError = new Error();
                                          throw "Error: An empty polygon has no meaningful localCOM";
                                       }
                                       if(_loc3_.lverts.next.next == null)
                                       {
                                          _loc3_.localCOMx = _loc3_.lverts.next.x;
                                          _loc3_.localCOMy = _loc3_.lverts.next.y;
                                       }
                                       else if(_loc3_.lverts.next.next.next == null)
                                       {
                                          _loc3_.localCOMx = _loc3_.lverts.next.x;
                                          _loc3_.localCOMy = _loc3_.lverts.next.y;
                                          _loc4_ = 1;
                                          _loc3_.localCOMx += _loc3_.lverts.next.next.x * _loc4_;
                                          _loc3_.localCOMy += _loc3_.lverts.next.next.y * _loc4_;
                                          _loc4_ = 0.5;
                                          _loc3_.localCOMx *= _loc4_;
                                          _loc3_.localCOMy *= _loc4_;
                                       }
                                       else
                                       {
                                          _loc3_.localCOMx = 0;
                                          _loc3_.localCOMy = 0;
                                          _loc4_ = 0;
                                          _loc5_ = _loc3_.lverts.next;
                                          _loc6_ = _loc5_;
                                          _loc5_ = _loc5_.next;
                                          _loc7_ = _loc5_;
                                          _loc5_ = _loc5_.next;
                                          while(_loc5_ != null)
                                          {
                                             _loc8_ = _loc5_;
                                             _loc4_ += _loc7_.x * (_loc8_.y - _loc6_.y);
                                             _loc9_ = _loc8_.y * _loc7_.x - _loc8_.x * _loc7_.y;
                                             _loc3_.localCOMx += (_loc7_.x + _loc8_.x) * _loc9_;
                                             _loc3_.localCOMy += (_loc7_.y + _loc8_.y) * _loc9_;
                                             _loc6_ = _loc7_;
                                             _loc7_ = _loc8_;
                                             _loc5_ = _loc5_.next;
                                          }
                                          _loc5_ = _loc3_.lverts.next;
                                          _loc8_ = _loc5_;
                                          _loc4_ += _loc7_.x * (_loc8_.y - _loc6_.y);
                                          _loc9_ = _loc8_.y * _loc7_.x - _loc8_.x * _loc7_.y;
                                          _loc3_.localCOMx += (_loc7_.x + _loc8_.x) * _loc9_;
                                          _loc3_.localCOMy += (_loc7_.y + _loc8_.y) * _loc9_;
                                          _loc6_ = _loc7_;
                                          _loc7_ = _loc8_;
                                          _loc5_ = _loc5_.next;
                                          _loc10_ = _loc5_;
                                          _loc4_ += _loc7_.x * (_loc10_.y - _loc6_.y);
                                          _loc9_ = _loc10_.y * _loc7_.x - _loc10_.x * _loc7_.y;
                                          _loc3_.localCOMx += (_loc7_.x + _loc10_.x) * _loc9_;
                                          _loc3_.localCOMy += (_loc7_.y + _loc10_.y) * _loc9_;
                                          _loc4_ = 1 / (3 * _loc4_);
                                          _loc9_ = _loc4_;
                                          _loc3_.localCOMx *= _loc9_;
                                          _loc3_.localCOMy *= _loc9_;
                                       }
                                    }
                                 }
                                 _loc11_ = _loc2_.body;
                                 if(_loc11_.zip_axis)
                                 {
                                    _loc11_.zip_axis = false;
                                    _loc11_.axisx = Math.sin(_loc11_.rot);
                                    _loc11_.axisy = Math.cos(_loc11_.rot);
                                 }
                                 _loc2_.worldCOMx = _loc2_.body.posx + (_loc2_.body.axisy * _loc2_.localCOMx - _loc2_.body.axisx * _loc2_.localCOMy);
                                 _loc2_.worldCOMy = _loc2_.body.posy + (_loc2_.localCOMx * _loc2_.body.axisx + _loc2_.localCOMy * _loc2_.body.axisy);
                              }
                           }
                           _loc4_ = _loc2_.radius;
                           _loc9_ = _loc2_.radius;
                           _loc2_.aabb.minx = _loc2_.worldCOMx - _loc4_;
                           _loc2_.aabb.miny = _loc2_.worldCOMy - _loc9_;
                           _loc2_.aabb.maxx = _loc2_.worldCOMx + _loc4_;
                           _loc2_.aabb.maxy = _loc2_.worldCOMy + _loc9_;
                        }
                        else
                        {
                           _loc3_ = param1.polygon;
                           if(_loc3_.zip_gverts)
                           {
                              if(_loc3_.body != null)
                              {
                                 _loc3_.zip_gverts = false;
                                 _loc3_.validate_lverts();
                                 _loc11_ = _loc3_.body;
                                 if(_loc11_.zip_axis)
                                 {
                                    _loc11_.zip_axis = false;
                                    _loc11_.axisx = Math.sin(_loc11_.rot);
                                    _loc11_.axisy = Math.cos(_loc11_.rot);
                                 }
                                 _loc5_ = _loc3_.lverts.next;
                                 _loc6_ = _loc3_.gverts.next;
                                 while(_loc6_ != null)
                                 {
                                    _loc7_ = _loc6_;
                                    _loc8_ = _loc5_;
                                    _loc5_ = _loc5_.next;
                                    _loc7_.x = _loc3_.body.posx + (_loc3_.body.axisy * _loc8_.x - _loc3_.body.axisx * _loc8_.y);
                                    _loc7_.y = _loc3_.body.posy + (_loc8_.x * _loc3_.body.axisx + _loc8_.y * _loc3_.body.axisy);
                                    _loc6_ = _loc6_.next;
                                 }
                              }
                           }
                           if(_loc3_.lverts.next == null)
                           {
                              Boot.lastError = new Error();
                              throw "Error: An empty polygon has no meaningful bounds";
                           }
                           _loc5_ = _loc3_.gverts.next;
                           _loc3_.aabb.minx = _loc5_.x;
                           _loc3_.aabb.miny = _loc5_.y;
                           _loc3_.aabb.maxx = _loc5_.x;
                           _loc3_.aabb.maxy = _loc5_.y;
                           _loc6_ = _loc3_.gverts.next.next;
                           while(_loc6_ != null)
                           {
                              _loc7_ = _loc6_;
                              if(_loc7_.x < _loc3_.aabb.minx)
                              {
                                 _loc3_.aabb.minx = _loc7_.x;
                              }
                              if(_loc7_.x > _loc3_.aabb.maxx)
                              {
                                 _loc3_.aabb.maxx = _loc7_.x;
                              }
                              if(_loc7_.y < _loc3_.aabb.miny)
                              {
                                 _loc3_.aabb.miny = _loc7_.y;
                              }
                              if(_loc7_.y > _loc3_.aabb.maxy)
                              {
                                 _loc3_.aabb.maxy = _loc7_.y;
                              }
                              _loc6_ = _loc6_.next;
                           }
                        }
                     }
                  }
               }
               _loc14_ = _loc13_.dyn != (param1.body.type == ZPP_Flags.id_BodyType_STATIC ? false : !param1.body.component.sleeping) || !(_loc16_.minx >= _loc15_.minx && _loc16_.miny >= _loc15_.miny && _loc16_.maxx <= _loc15_.maxx && _loc16_.maxy <= _loc15_.maxy);
               if(_loc14_)
               {
                  _loc13_.synced = true;
                  _loc13_.snext = _loc12_.syncs;
                  _loc12_.syncs = _loc13_;
               }
            }
         }
      }
      
      public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
      {
         return null;
      }
      
      public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
      {
         return null;
      }
      
      public function shapesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:ShapeList) : ShapeList
      {
         return null;
      }
      
      public function shapesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
      {
         return null;
      }
      
      public function remove(param1:ZPP_Shape) : void
      {
         if(is_sweep)
         {
            sweep.__remove(param1);
         }
         else
         {
            dynab.__remove(param1);
         }
      }
      
      public function rayMultiCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter, param4:RayResultList) : RayResultList
      {
         return null;
      }
      
      public function rayCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResult
      {
         return null;
      }
      
      public function insert(param1:ZPP_Shape) : void
      {
         if(is_sweep)
         {
            sweep.__insert(param1);
         }
         else
         {
            dynab.__insert(param1);
         }
      }
      
      public function clear() : void
      {
      }
      
      public function broadphase(param1:ZPP_Space, param2:Boolean) : void
      {
      }
      
      public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
      {
         return null;
      }
      
      public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
      {
         return null;
      }
      
      public function bodiesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:BodyList) : BodyList
      {
         return null;
      }
      
      public function bodiesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
      {
         return null;
      }
   }
}
