package nape.shape
{
   import flash.Boot;
   import nape.Config;
   import nape.dynamics.InteractionFilter;
   import nape.geom.AABB;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.FluidProperties;
   import nape.phys.Interactor;
   import nape.phys.Material;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_FluidProperties;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public class Shape extends Interactor
   {
       
      
      public var zpp_inner:ZPP_Shape;
      
      public function Shape()
      {
         var _loc2_:* = null;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         try
         {
            super();
         }
         catch(_loc_e_:*)
         {
            Boot.lastError = new Error();
            throw "Error: Shape cannot be instantiated derp!";
         }
      }
      
      public function translate(param1:Vec2) : Shape
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc3_:* = null as Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         zpp_inner.immutable_midstep("Shape::translate()");
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.body != null && zpp_inner.body.space != null && zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot displace Shape by null Vec2";
         }
         if(param1.lsq() > 0)
         {
            if(zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               §§push(zpp_inner.circle);
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc2_ = param1.zpp_inner;
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               §§push(param1.zpp_inner.x);
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc2_ = param1.zpp_inner;
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               §§pop().__translate(§§pop(),param1.zpp_inner.y);
            }
            else
            {
               §§push(zpp_inner.polygon);
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc2_ = param1.zpp_inner;
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               §§push(param1.zpp_inner.x);
               if(param1 != null && param1.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc2_ = param1.zpp_inner;
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               §§pop().__translate(§§pop(),param1.zpp_inner.y);
            }
         }
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = param1.zpp_inner;
            if(_loc2_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc2_._isimmutable != null)
            {
               _loc2_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc2_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc3_ = param1;
            _loc3_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc3_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc3_;
            }
            ZPP_PubPool.nextVec2 = _loc3_;
            _loc3_.zpp_disp = true;
            _loc4_ = _loc2_;
            if(_loc4_.outer != null)
            {
               _loc4_.outer.zpp_inner = null;
               _loc4_.outer = null;
            }
            _loc4_._isimmutable = null;
            _loc4_._validate = null;
            _loc4_._invalidate = null;
            _loc4_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc4_;
         }
         return this;
      }
      
      public function transform(param1:Mat23) : Shape
      {
         zpp_inner.immutable_midstep("Shape::transform()");
         if(zpp_inner.body != null && zpp_inner.body.space != null && zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot transform Shape by null matrix";
         }
         if(param1.singular())
         {
            Boot.lastError = new Error();
            throw "Error: Cannot transform Shape by a singular matrix";
         }
         if(zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            if(!param1.equiorthogonal())
            {
               Boot.lastError = new Error();
               throw "Error: Cannot transform Circle by a non equiorthogonal matrix";
            }
            zpp_inner.circle.__transform(param1);
         }
         else
         {
            zpp_inner.polygon.__transform(param1);
         }
         return this;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE ? "Circle" : "Polygon";
         return _loc1_ + "#" + zpp_inner_i.id;
      }
      
      public function set sensorEnabled(param1:Boolean) : Boolean
      {
         zpp_inner.immutable_midstep("Shape::sensorEnabled");
         zpp_inner.sensorEnabled = param1;
         zpp_inner.wake();
         return zpp_inner.sensorEnabled;
      }
      
      public function set material(param1:Material) : Material
      {
         zpp_inner.immutable_midstep("Shape::material");
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null as Shape material";
         }
         zpp_inner.setMaterial(param1.zpp_inner);
         return zpp_inner.material.wrapper();
      }
      
      public function set localCOM(param1:Vec2) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         zpp_inner.immutable_midstep("Body::localCOM");
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.body != null && zpp_inner.body.space != null && zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Shape::localCOM cannot be null";
         }
         if(zpp_inner.wrap_localCOM == null)
         {
            if(zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               zpp_inner.circle.setupLocalCOM();
            }
            else
            {
               zpp_inner.polygon.setupLocalCOM();
            }
         }
         var _loc2_:Vec2 = zpp_inner.wrap_localCOM;
         if(_loc2_ != null && _loc2_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc2_.zpp_inner;
         if(_loc3_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc3_._isimmutable != null)
         {
            _loc3_._isimmutable();
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null Vec2";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = param1.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc5_:Number = param1.zpp_inner.x;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = param1.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc6_:Number = param1.zpp_inner.y;
         if(_loc2_ != null && _loc2_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc2_.zpp_inner;
         if(_loc3_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc3_._isimmutable != null)
         {
            _loc3_._isimmutable();
         }
         if(_loc5_ != _loc5_ || _loc6_ != _loc6_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(false);
         if(_loc2_ != null && _loc2_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc2_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(_loc2_.zpp_inner.x == _loc5_)
         {
            §§pop();
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = _loc2_.zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(_loc2_.zpp_inner.y == _loc6_);
         }
         if(!§§pop())
         {
            _loc2_.zpp_inner.x = _loc5_;
            _loc2_.zpp_inner.y = _loc6_;
            _loc3_ = _loc2_.zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         var _loc4_:Vec2 = _loc2_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = param1.zpp_inner;
            if(_loc3_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc3_._isimmutable != null)
            {
               _loc3_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc3_ = param1.zpp_inner;
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
            _loc8_ = _loc3_;
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
         _loc4_;
         if(zpp_inner.wrap_localCOM == null)
         {
            if(zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               zpp_inner.circle.setupLocalCOM();
            }
            else
            {
               zpp_inner.polygon.setupLocalCOM();
            }
         }
         return zpp_inner.wrap_localCOM;
      }
      
      public function set fluidProperties(param1:FluidProperties) : FluidProperties
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null as Shape fluidProperties, disable fluids by setting fluidEnabled to false";
         }
         zpp_inner.setFluid(param1.zpp_inner);
         zpp_inner.immutable_midstep("Shape::fluidProperties");
         if(zpp_inner.fluidProperties == null)
         {
            zpp_inner.setFluid(new FluidProperties().zpp_inner);
         }
         return zpp_inner.fluidProperties.wrapper();
      }
      
      public function set fluidEnabled(param1:Boolean) : Boolean
      {
         var _loc2_:* = null as FluidProperties;
         zpp_inner.immutable_midstep("Shape::fluidEnabled");
         zpp_inner.fluidEnabled = param1;
         if(param1 && zpp_inner.fluidProperties == null)
         {
            _loc2_ = new FluidProperties();
            if(_loc2_ == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null as Shape fluidProperties, disable fluids by setting fluidEnabled to false";
            }
            zpp_inner.setFluid(_loc2_.zpp_inner);
            zpp_inner.immutable_midstep("Shape::fluidProperties");
            if(zpp_inner.fluidProperties == null)
            {
               zpp_inner.setFluid(new FluidProperties().zpp_inner);
            }
            zpp_inner.fluidProperties.wrapper();
         }
         zpp_inner.wake();
         return zpp_inner.fluidEnabled;
      }
      
      public function set filter(param1:InteractionFilter) : InteractionFilter
      {
         zpp_inner.immutable_midstep("Shape::filter");
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null as Shape filter";
         }
         zpp_inner.setFilter(param1.zpp_inner);
         return zpp_inner.filter.wrapper();
      }
      
      public function set body(param1:Body) : Body
      {
         var _loc2_:* = null as ShapeList;
         zpp_inner.immutable_midstep("Shape::body");
         if((zpp_inner.body != null ? zpp_inner.body.outer : null) != param1)
         {
            if(zpp_inner.body != null)
            {
               (zpp_inner.body != null ? zpp_inner.body.outer : null).zpp_inner.wrap_shapes.remove(this);
            }
            if(param1 != null)
            {
               _loc2_ = param1.zpp_inner.wrap_shapes;
               if(_loc2_.zpp_inner.reverse_flag)
               {
                  _loc2_.push(this);
               }
               else
               {
                  _loc2_.unshift(this);
               }
            }
         }
         return zpp_inner.body != null ? zpp_inner.body.outer : null;
      }
      
      public function scale(param1:Number, param2:Number) : Shape
      {
         var _loc3_:Number = NaN;
         zpp_inner.immutable_midstep("Shape::scale()");
         if(zpp_inner.body != null && zpp_inner.body.space != null && zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
         }
         if(param1 != param1 || param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot scale Shape by NaN";
         }
         if(param1 == 0 || param2 == 0)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot Scale shape by a factor of 0";
         }
         if(zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            _loc3_ = param1 * param1 - param2 * param2;
            if(_loc3_ * _loc3_ >= Config.epsilon * Config.epsilon)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot perform a non equal scaling on a Circle";
            }
            zpp_inner.circle.__scale(param1,param2);
         }
         else
         {
            zpp_inner.polygon.__scale(param1,param2);
         }
         return this;
      }
      
      public function rotate(param1:Number) : Shape
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         zpp_inner.immutable_midstep("Shape::rotate()");
         if(zpp_inner.body != null && zpp_inner.body.space != null && zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot rotate Shape by NaN";
         }
         var _loc2_:Number = param1 % (2 * Math.PI);
         if(_loc2_ != 0)
         {
            _loc3_ = Math.cos(param1);
            _loc4_ = Math.sin(param1);
            if(zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               zpp_inner.circle.__rotate(_loc4_,_loc3_);
            }
            else
            {
               zpp_inner.polygon.__rotate(_loc4_,_loc3_);
            }
         }
         return this;
      }
      
      public function isPolygon() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON;
      }
      
      public function isCircle() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE;
      }
      
      public function get worldCOM() : Vec2
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         if(zpp_inner.wrap_worldCOM == null)
         {
            _loc1_ = zpp_inner.worldCOMx;
            _loc2_ = zpp_inner.worldCOMy;
            _loc3_ = false;
            §§push(zpp_inner);
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
            _loc4_.zpp_inner.weak = _loc3_;
            §§pop().wrap_worldCOM = _loc4_;
            zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
            zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
            zpp_inner.wrap_worldCOM.zpp_inner._validate = zpp_inner.getworldCOM;
         }
         return zpp_inner.wrap_worldCOM;
      }
      
      public function get type() : ShapeType
      {
         if(ZPP_Flags.ShapeType_CIRCLE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ShapeType_CIRCLE = new ShapeType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.ShapeType_CIRCLE);
         if(ZPP_Flags.ShapeType_POLYGON == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ShapeType_POLYGON = new ShapeType();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.type];
      }
      
      public function get sensorEnabled() : Boolean
      {
         return zpp_inner.sensorEnabled;
      }
      
      public function get material() : Material
      {
         return zpp_inner.material.wrapper();
      }
      
      public function get localCOM() : Vec2
      {
         if(zpp_inner.wrap_localCOM == null)
         {
            if(zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               zpp_inner.circle.setupLocalCOM();
            }
            else
            {
               zpp_inner.polygon.setupLocalCOM();
            }
         }
         return zpp_inner.wrap_localCOM;
      }
      
      public function get inertia() : Number
      {
         zpp_inner.validate_area_inertia();
         return zpp_inner.inertia;
      }
      
      public function get fluidProperties() : FluidProperties
      {
         zpp_inner.immutable_midstep("Shape::fluidProperties");
         if(zpp_inner.fluidProperties == null)
         {
            zpp_inner.setFluid(new FluidProperties().zpp_inner);
         }
         return zpp_inner.fluidProperties.wrapper();
      }
      
      public function get fluidEnabled() : Boolean
      {
         return zpp_inner.fluidEnabled;
      }
      
      public function get filter() : InteractionFilter
      {
         return zpp_inner.filter.wrapper();
      }
      
      public function get castPolygon() : Polygon
      {
         return zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON ? zpp_inner.polygon.outer_zn : null;
      }
      
      public function get castCircle() : Circle
      {
         return zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE ? zpp_inner.circle.outer_zn : null;
      }
      
      public function get bounds() : AABB
      {
         return zpp_inner.aabb.wrapper();
      }
      
      public function get body() : Body
      {
         return zpp_inner.body != null ? zpp_inner.body.outer : null;
      }
      
      public function get area() : Number
      {
         zpp_inner.validate_area_inertia();
         return zpp_inner.area;
      }
      
      public function get angDrag() : Number
      {
         zpp_inner.validate_angDrag();
         return zpp_inner.angDrag;
      }
      
      public function copy() : Shape
      {
         return zpp_inner.copy();
      }
      
      public function contains(param1:Vec2) : Boolean
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Cannot check null point for containment";
         }
         Boot.lastError = new Error();
         throw "Error: Shape is not well defined without a Body";
      }
   }
}
