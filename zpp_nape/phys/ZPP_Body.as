package zpp_nape.phys
{
   import flash.Boot;
   import nape.Config;
   import nape.constraint.ConstraintList;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.phys.BodyType;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_AABBPair;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_Arbiter;
   import zpp_nape.util.ZNPList_ZPP_Body;
   import zpp_nape.util.ZNPList_ZPP_Constraint;
   import zpp_nape.util.ZNPList_ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Arbiter;
   import zpp_nape.util.ZNPNode_ZPP_Body;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   import zpp_nape.util.ZPP_Set_ZPP_Body;
   import zpp_nape.util.ZPP_ShapeList;
   
   public class ZPP_Body extends ZPP_Interactor
   {
      
      public static var bodystack:ZNPList_ZPP_Body = null;
      
      public static var bodyset:ZPP_Set_ZPP_Body = null;
      
      public static var cur_graph_depth:int = 0;
       
      
      public var zip_worldCOM:Boolean;
      
      public var zip_mass:Boolean;
      
      public var zip_localCOM:Boolean;
      
      public var zip_inertia:Boolean;
      
      public var zip_gravMassScale:Boolean;
      
      public var zip_gravMass:Boolean;
      
      public var zip_axis:Boolean;
      
      public var zip_aabb:Boolean;
      
      public var wrapcvel:Vec3;
      
      public var wrap_worldCOM:Vec2;
      
      public var wrap_vel:Vec2;
      
      public var wrap_svel:Vec2;
      
      public var wrap_shapes:ShapeList;
      
      public var wrap_pos:Vec2;
      
      public var wrap_localCOM:Vec2;
      
      public var wrap_kinvel:Vec2;
      
      public var wrap_force:Vec2;
      
      public var wrap_constraints:ConstraintList;
      
      public var wrap_arbiters:ArbiterList;
      
      public var worldCOMy:Number;
      
      public var worldCOMx:Number;
      
      public var world:Boolean;
      
      public var vely:Number;
      
      public var velx:Number;
      
      public var type:int;
      
      public var torque:Number;
      
      public var sweep_angvel:Number;
      
      public var sweepTime:Number;
      
      public var sweepRadius:Number;
      
      public var sweepFrozen:Boolean;
      
      public var svely:Number;
      
      public var svelx:Number;
      
      public var space:ZPP_Space;
      
      public var smass:Number;
      
      public var sinertia:Number;
      
      public var shapes:ZNPList_ZPP_Shape;
      
      public var rot:Number;
      
      public var pre_rot:Number;
      
      public var pre_posy:Number;
      
      public var pre_posx:Number;
      
      public var posy:Number;
      
      public var posx:Number;
      
      public var outer:Body;
      
      public var norotate:Boolean;
      
      public var nomove:Boolean;
      
      public var massMode:int;
      
      public var mass:Number;
      
      public var localCOMy:Number;
      
      public var localCOMx:Number;
      
      public var kinvely:Number;
      
      public var kinvelx:Number;
      
      public var kinangvel:Number;
      
      public var inertiaMode:int;
      
      public var inertia:Number;
      
      public var imass:Number;
      
      public var iinertia:Number;
      
      public var gravMassScale:Number;
      
      public var gravMassMode:int;
      
      public var gravMass:Number;
      
      public var graph_depth:int;
      
      public var forcey:Number;
      
      public var forcex:Number;
      
      public var disableCCD:Boolean;
      
      public var constraints:ZNPList_ZPP_Constraint;
      
      public var compound:ZPP_Compound;
      
      public var component:ZPP_Component;
      
      public var cmass:Number;
      
      public var cinertia:Number;
      
      public var bulletEnabled:Boolean;
      
      public var bullet:Boolean;
      
      public var axisy:Number;
      
      public var axisx:Number;
      
      public var arbiters:ZNPList_ZPP_Arbiter;
      
      public var angvel:Number;
      
      public var aabb:ZPP_AABB;
      
      public function ZPP_Body()
      {
         var _loc3_:* = null as ZPP_AABB;
         if(Boot.skip_constructor)
         {
            return;
         }
         wrap_worldCOM = null;
         wrap_localCOM = null;
         zip_worldCOM = false;
         worldCOMy = 0;
         worldCOMx = 0;
         zip_localCOM = false;
         localCOMy = 0;
         localCOMx = 0;
         zip_aabb = false;
         aabb = null;
         norotate = false;
         sinertia = 0;
         iinertia = 0;
         cinertia = 0;
         zip_inertia = false;
         inertia = 0;
         inertiaMode = 0;
         zip_gravMassScale = false;
         gravMassScale = 0;
         gravMassMode = 0;
         zip_gravMass = false;
         gravMass = 0;
         nomove = false;
         cmass = 0;
         smass = 0;
         imass = 0;
         massMode = 0;
         zip_mass = false;
         mass = 0;
         zip_axis = false;
         axisy = 0;
         axisx = 0;
         rot = 0;
         pre_rot = 0;
         kinangvel = 0;
         torque = 0;
         angvel = 0;
         wrapcvel = null;
         wrap_svel = null;
         svely = 0;
         svelx = 0;
         wrap_kinvel = null;
         kinvely = 0;
         kinvelx = 0;
         wrap_force = null;
         forcey = 0;
         forcex = 0;
         wrap_vel = null;
         vely = 0;
         velx = 0;
         wrap_pos = null;
         posy = 0;
         posx = 0;
         pre_posy = 0;
         pre_posx = 0;
         disableCCD = false;
         bulletEnabled = false;
         bullet = false;
         sweepRadius = 0;
         sweepFrozen = false;
         sweep_angvel = 0;
         sweepTime = 0;
         graph_depth = 0;
         component = null;
         wrap_constraints = null;
         constraints = null;
         wrap_arbiters = null;
         arbiters = null;
         space = null;
         wrap_shapes = null;
         shapes = null;
         compound = null;
         type = 0;
         world = false;
         outer = null;
         super();
         ibody = this;
         world = false;
         bulletEnabled = false;
         sweepTime = 0;
         sweep_angvel = 0;
         nomove = false;
         norotate = false;
         disableCCD = false;
         posx = 0;
         posy = 0;
         rot = 0;
         axisx = 0;
         axisy = 1;
         svelx = 0;
         svely = 0;
         velx = 0;
         vely = 0;
         kinvelx = 0;
         kinvely = 0;
         forcex = 0;
         forcey = 0;
         torque = angvel = kinangvel = 0;
         pre_posx = 1.79e+308;
         pre_posy = 1.79e+308;
         pre_rot = 1.79e+308;
         localCOMx = 0;
         localCOMy = 0;
         worldCOMx = 0;
         worldCOMy = 0;
         zip_aabb = true;
         §§push(§§findproperty(aabb));
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc3_ = new ZPP_AABB();
         }
         else
         {
            _loc3_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.minx = 0;
         _loc3_.miny = 0;
         _loc3_.maxx = 0;
         _loc3_.maxy = 0;
         §§pop().aabb = _loc3_;
         aabb._immutable = true;
         aabb._validate = aabb_validate;
         massMode = ZPP_Flags.id_MassMode_DEFAULT;
         gravMassMode = ZPP_Flags.id_GravMassMode_DEFAULT;
         gravMassScale = 1;
         inertiaMode = ZPP_Flags.id_InertiaMode_DEFAULT;
         arbiters = new ZNPList_ZPP_Arbiter();
         constraints = new ZNPList_ZPP_Constraint();
         shapes = new ZNPList_ZPP_Shape();
         wrap_shapes = ZPP_ShapeList.get(shapes);
         wrap_shapes.zpp_inner.adder = shapes_adder;
         wrap_shapes.zpp_inner.subber = shapes_subber;
         wrap_shapes.zpp_inner._invalidate = shapes_invalidate;
         wrap_shapes.zpp_inner._modifiable = shapes_modifiable;
      }
      
      public static function bodysetlt(param1:ZPP_Body, param2:ZPP_Body) : Boolean
      {
         return param1.id < param2.id;
      }
      
      public static function __static() : Body
      {
         §§push(§§findproperty(Body));
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         var _loc1_:Body = new §§pop().Body(ZPP_Flags.BodyType_STATIC);
         var _loc2_:ZPP_Body = _loc1_.zpp_inner;
         _loc2_.world = true;
         _loc2_.wrap_shapes.zpp_inner.immutable = true;
         _loc2_.smass = _loc2_.imass = _loc2_.cmass = _loc2_.mass = _loc2_.gravMass = 0;
         _loc2_.sinertia = _loc2_.iinertia = _loc2_.cinertia = _loc2_.inertia = 0;
         _loc2_.cbTypes.clear();
         return _loc1_;
      }
      
      public function vel_validate() : void
      {
         wrap_vel.zpp_inner.x = velx;
         wrap_vel.zpp_inner.y = vely;
      }
      
      public function vel_invalidate(param1:ZPP_Vec2) : void
      {
         if(type == ZPP_Flags.id_BodyType_STATIC)
         {
            Boot.lastError = new Error();
            throw "Error: Static body cannot have its velocity set.";
         }
         velx = param1.x;
         vely = param1.y;
         wake();
      }
      
      public function validate_worldCOM() : void
      {
         if(zip_worldCOM)
         {
            zip_worldCOM = false;
            validate_localCOM();
            if(zip_axis)
            {
               zip_axis = false;
               axisx = Math.sin(rot);
               axisy = Math.cos(rot);
            }
            worldCOMx = posx + (axisy * localCOMx - axisx * localCOMy);
            worldCOMy = posy + (localCOMx * axisx + localCOMy * axisy);
            if(wrap_worldCOM != null)
            {
               wrap_worldCOM.zpp_inner.x = worldCOMx;
               wrap_worldCOM.zpp_inner.y = worldCOMy;
            }
         }
      }
      
      public function validate_mass() : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:Number = NaN;
         if(zip_mass || massMode == ZPP_Flags.id_MassMode_DEFAULT && false)
         {
            zip_mass = false;
            if(massMode == ZPP_Flags.id_MassMode_DEFAULT)
            {
               cmass = 0;
               _loc2_ = shapes.head;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_.elt;
                  _loc3_.refmaterial.density = _loc3_.material.density;
                  _loc3_.validate_area_inertia();
                  cmass += _loc3_.area * _loc3_.material.density;
                  _loc2_ = _loc2_.next;
               }
            }
            if(type == ZPP_Flags.id_BodyType_DYNAMIC && !nomove)
            {
               mass = cmass;
               imass = smass = 1 / mass;
            }
            else
            {
               mass = 1.79e+308;
               imass = smass = 0;
            }
         }
      }
      
      public function validate_localCOM() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZNPNode_ZPP_Shape;
         var _loc5_:* = null as ZPP_Shape;
         var _loc6_:* = null as ZPP_Polygon;
         var _loc7_:Number = NaN;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as ZPP_Vec2;
         if(zip_localCOM)
         {
            zip_localCOM = false;
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = shapes.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               if(_loc5_.zip_localCOM)
               {
                  _loc5_.zip_localCOM = false;
                  if(_loc5_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc6_ = _loc5_.polygon;
                     if(_loc6_.lverts.next == null)
                     {
                        Boot.lastError = new Error();
                        throw "Error: An empty polygon has no meaningful localCOM";
                     }
                     if(_loc6_.lverts.next.next == null)
                     {
                        _loc6_.localCOMx = _loc6_.lverts.next.x;
                        _loc6_.localCOMy = _loc6_.lverts.next.y;
                     }
                     else if(_loc6_.lverts.next.next.next == null)
                     {
                        _loc6_.localCOMx = _loc6_.lverts.next.x;
                        _loc6_.localCOMy = _loc6_.lverts.next.y;
                        _loc7_ = 1;
                        _loc6_.localCOMx += _loc6_.lverts.next.next.x * _loc7_;
                        _loc6_.localCOMy += _loc6_.lverts.next.next.y * _loc7_;
                        _loc7_ = 0.5;
                        _loc6_.localCOMx *= _loc7_;
                        _loc6_.localCOMy *= _loc7_;
                     }
                     else
                     {
                        _loc6_.localCOMx = 0;
                        _loc6_.localCOMy = 0;
                        _loc7_ = 0;
                        _loc8_ = _loc6_.lverts.next;
                        _loc9_ = _loc8_;
                        _loc8_ = _loc8_.next;
                        _loc10_ = _loc8_;
                        _loc8_ = _loc8_.next;
                        while(_loc8_ != null)
                        {
                           _loc11_ = _loc8_;
                           _loc7_ += _loc10_.x * (_loc11_.y - _loc9_.y);
                           _loc12_ = _loc11_.y * _loc10_.x - _loc11_.x * _loc10_.y;
                           _loc6_.localCOMx += (_loc10_.x + _loc11_.x) * _loc12_;
                           _loc6_.localCOMy += (_loc10_.y + _loc11_.y) * _loc12_;
                           _loc9_ = _loc10_;
                           _loc10_ = _loc11_;
                           _loc8_ = _loc8_.next;
                        }
                        _loc8_ = _loc6_.lverts.next;
                        _loc11_ = _loc8_;
                        _loc7_ += _loc10_.x * (_loc11_.y - _loc9_.y);
                        _loc12_ = _loc11_.y * _loc10_.x - _loc11_.x * _loc10_.y;
                        _loc6_.localCOMx += (_loc10_.x + _loc11_.x) * _loc12_;
                        _loc6_.localCOMy += (_loc10_.y + _loc11_.y) * _loc12_;
                        _loc9_ = _loc10_;
                        _loc10_ = _loc11_;
                        _loc8_ = _loc8_.next;
                        _loc13_ = _loc8_;
                        _loc7_ += _loc10_.x * (_loc13_.y - _loc9_.y);
                        _loc12_ = _loc13_.y * _loc10_.x - _loc13_.x * _loc10_.y;
                        _loc6_.localCOMx += (_loc10_.x + _loc13_.x) * _loc12_;
                        _loc6_.localCOMy += (_loc10_.y + _loc13_.y) * _loc12_;
                        _loc7_ = 1 / (3 * _loc7_);
                        _loc12_ = _loc7_;
                        _loc6_.localCOMx *= _loc12_;
                        _loc6_.localCOMy *= _loc12_;
                     }
                  }
               }
               _loc5_.validate_area_inertia();
               _loc7_ = _loc5_.area * _loc5_.material.density;
               _loc1_ += _loc5_.localCOMx * _loc7_;
               _loc2_ += _loc5_.localCOMy * _loc7_;
               _loc3_ += _loc5_.area * _loc5_.material.density;
               _loc4_ = _loc4_.next;
            }
            if(_loc3_ != 0)
            {
               _loc7_ = 1 / _loc3_;
               localCOMx = _loc1_ * _loc7_;
               localCOMy = _loc2_ * _loc7_;
            }
            if(wrap_localCOM != null)
            {
               wrap_localCOM.zpp_inner.x = localCOMx;
               wrap_localCOM.zpp_inner.y = localCOMy;
            }
            if(zip_mass && massMode == ZPP_Flags.id_MassMode_DEFAULT)
            {
               zip_mass = false;
               cmass = _loc3_;
               if(type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  mass = cmass;
                  imass = smass = 1 / mass;
               }
               else
               {
                  mass = 1.79e+308;
                  imass = smass = 0;
               }
            }
         }
      }
      
      public function validate_inertia() : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:Number = NaN;
         if(zip_inertia || inertiaMode == ZPP_Flags.id_InertiaMode_DEFAULT && false)
         {
            zip_inertia = false;
            if(inertiaMode == ZPP_Flags.id_InertiaMode_DEFAULT)
            {
               cinertia = 0;
               _loc2_ = shapes.head;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_.elt;
                  _loc3_.refmaterial.density = _loc3_.material.density;
                  _loc3_.validate_area_inertia();
                  cinertia += _loc3_.inertia * _loc3_.area * _loc3_.material.density;
                  _loc2_ = _loc2_.next;
               }
            }
            if(type == ZPP_Flags.id_BodyType_DYNAMIC && !norotate)
            {
               inertia = cinertia;
               sinertia = iinertia = 1 / inertia;
            }
            else
            {
               inertia = 1.79e+308;
               sinertia = iinertia = 0;
            }
         }
      }
      
      public function validate_gravMassScale() : void
      {
         if(zip_gravMassScale)
         {
            zip_gravMassScale = false;
            if(gravMassMode == ZPP_Flags.id_GravMassMode_DEFAULT)
            {
               gravMassScale = 1;
            }
            else if(gravMassMode == ZPP_Flags.id_GravMassMode_FIXED)
            {
               validate_mass();
               gravMassScale = gravMass / cmass;
            }
         }
      }
      
      public function validate_gravMass() : void
      {
         if(zip_gravMass)
         {
            zip_gravMass = false;
            validate_mass();
            if(gravMassMode == ZPP_Flags.id_GravMassMode_DEFAULT)
            {
               validate_mass();
               gravMass = cmass;
            }
            else if(gravMassMode == ZPP_Flags.id_GravMassMode_SCALED)
            {
               validate_mass();
               gravMass = cmass * gravMassScale;
            }
         }
      }
      
      public function validate_axis() : void
      {
         if(zip_axis)
         {
            zip_axis = false;
            axisx = Math.sin(rot);
            axisy = Math.cos(rot);
         }
      }
      
      public function validate_aabb() : void
      {
         var _loc1_:* = null as ZNPNode_ZPP_Shape;
         var _loc2_:* = null as ZPP_Shape;
         var _loc3_:* = null as ZPP_Circle;
         var _loc4_:* = null as ZPP_Polygon;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Body;
         var _loc13_:* = null as ZPP_AABB;
         var _loc14_:* = null as ZPP_AABB;
         if(shapes.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Body bounds only makes sense if it contains shapes";
         }
         if(zip_aabb)
         {
            zip_aabb = false;
            aabb.minx = 1.79e+308;
            aabb.miny = 1.79e+308;
            aabb.maxx = -1.79e+308;
            aabb.maxy = -1.79e+308;
            _loc1_ = shapes.head;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_.elt;
               if(_loc2_.zip_aabb)
               {
                  if(_loc2_.body != null)
                  {
                     _loc2_.zip_aabb = false;
                     if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc3_ = _loc2_.circle;
                        if(_loc3_.zip_worldCOM)
                        {
                           if(_loc3_.body != null)
                           {
                              _loc3_.zip_worldCOM = false;
                              if(_loc3_.zip_localCOM)
                              {
                                 _loc3_.zip_localCOM = false;
                                 if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc4_ = _loc3_.polygon;
                                    if(_loc4_.lverts.next == null)
                                    {
                                       Boot.lastError = new Error();
                                       throw "Error: An empty polygon has no meaningful localCOM";
                                    }
                                    if(_loc4_.lverts.next.next == null)
                                    {
                                       _loc4_.localCOMx = _loc4_.lverts.next.x;
                                       _loc4_.localCOMy = _loc4_.lverts.next.y;
                                    }
                                    else if(_loc4_.lverts.next.next.next == null)
                                    {
                                       _loc4_.localCOMx = _loc4_.lverts.next.x;
                                       _loc4_.localCOMy = _loc4_.lverts.next.y;
                                       _loc5_ = 1;
                                       _loc4_.localCOMx += _loc4_.lverts.next.next.x * _loc5_;
                                       _loc4_.localCOMy += _loc4_.lverts.next.next.y * _loc5_;
                                       _loc5_ = 0.5;
                                       _loc4_.localCOMx *= _loc5_;
                                       _loc4_.localCOMy *= _loc5_;
                                    }
                                    else
                                    {
                                       _loc4_.localCOMx = 0;
                                       _loc4_.localCOMy = 0;
                                       _loc5_ = 0;
                                       _loc6_ = _loc4_.lverts.next;
                                       _loc7_ = _loc6_;
                                       _loc6_ = _loc6_.next;
                                       _loc8_ = _loc6_;
                                       _loc6_ = _loc6_.next;
                                       while(_loc6_ != null)
                                       {
                                          _loc9_ = _loc6_;
                                          _loc5_ += _loc8_.x * (_loc9_.y - _loc7_.y);
                                          _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                                          _loc4_.localCOMx += (_loc8_.x + _loc9_.x) * _loc10_;
                                          _loc4_.localCOMy += (_loc8_.y + _loc9_.y) * _loc10_;
                                          _loc7_ = _loc8_;
                                          _loc8_ = _loc9_;
                                          _loc6_ = _loc6_.next;
                                       }
                                       _loc6_ = _loc4_.lverts.next;
                                       _loc9_ = _loc6_;
                                       _loc5_ += _loc8_.x * (_loc9_.y - _loc7_.y);
                                       _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                                       _loc4_.localCOMx += (_loc8_.x + _loc9_.x) * _loc10_;
                                       _loc4_.localCOMy += (_loc8_.y + _loc9_.y) * _loc10_;
                                       _loc7_ = _loc8_;
                                       _loc8_ = _loc9_;
                                       _loc6_ = _loc6_.next;
                                       _loc11_ = _loc6_;
                                       _loc5_ += _loc8_.x * (_loc11_.y - _loc7_.y);
                                       _loc10_ = _loc11_.y * _loc8_.x - _loc11_.x * _loc8_.y;
                                       _loc4_.localCOMx += (_loc8_.x + _loc11_.x) * _loc10_;
                                       _loc4_.localCOMy += (_loc8_.y + _loc11_.y) * _loc10_;
                                       _loc5_ = 1 / (3 * _loc5_);
                                       _loc10_ = _loc5_;
                                       _loc4_.localCOMx *= _loc10_;
                                       _loc4_.localCOMy *= _loc10_;
                                    }
                                 }
                              }
                              _loc12_ = _loc3_.body;
                              if(_loc12_.zip_axis)
                              {
                                 _loc12_.zip_axis = false;
                                 _loc12_.axisx = Math.sin(_loc12_.rot);
                                 _loc12_.axisy = Math.cos(_loc12_.rot);
                              }
                              _loc3_.worldCOMx = _loc3_.body.posx + (_loc3_.body.axisy * _loc3_.localCOMx - _loc3_.body.axisx * _loc3_.localCOMy);
                              _loc3_.worldCOMy = _loc3_.body.posy + (_loc3_.localCOMx * _loc3_.body.axisx + _loc3_.localCOMy * _loc3_.body.axisy);
                           }
                        }
                        _loc5_ = _loc3_.radius;
                        _loc10_ = _loc3_.radius;
                        _loc3_.aabb.minx = _loc3_.worldCOMx - _loc5_;
                        _loc3_.aabb.miny = _loc3_.worldCOMy - _loc10_;
                        _loc3_.aabb.maxx = _loc3_.worldCOMx + _loc5_;
                        _loc3_.aabb.maxy = _loc3_.worldCOMy + _loc10_;
                     }
                     else
                     {
                        _loc4_ = _loc2_.polygon;
                        if(_loc4_.zip_gverts)
                        {
                           if(_loc4_.body != null)
                           {
                              _loc4_.zip_gverts = false;
                              _loc4_.validate_lverts();
                              _loc12_ = _loc4_.body;
                              if(_loc12_.zip_axis)
                              {
                                 _loc12_.zip_axis = false;
                                 _loc12_.axisx = Math.sin(_loc12_.rot);
                                 _loc12_.axisy = Math.cos(_loc12_.rot);
                              }
                              _loc6_ = _loc4_.lverts.next;
                              _loc7_ = _loc4_.gverts.next;
                              while(_loc7_ != null)
                              {
                                 _loc8_ = _loc7_;
                                 _loc9_ = _loc6_;
                                 _loc6_ = _loc6_.next;
                                 _loc8_.x = _loc4_.body.posx + (_loc4_.body.axisy * _loc9_.x - _loc4_.body.axisx * _loc9_.y);
                                 _loc8_.y = _loc4_.body.posy + (_loc9_.x * _loc4_.body.axisx + _loc9_.y * _loc4_.body.axisy);
                                 _loc7_ = _loc7_.next;
                              }
                           }
                        }
                        if(_loc4_.lverts.next == null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: An empty polygon has no meaningful bounds";
                        }
                        _loc6_ = _loc4_.gverts.next;
                        _loc4_.aabb.minx = _loc6_.x;
                        _loc4_.aabb.miny = _loc6_.y;
                        _loc4_.aabb.maxx = _loc6_.x;
                        _loc4_.aabb.maxy = _loc6_.y;
                        _loc7_ = _loc4_.gverts.next.next;
                        while(_loc7_ != null)
                        {
                           _loc8_ = _loc7_;
                           if(_loc8_.x < _loc4_.aabb.minx)
                           {
                              _loc4_.aabb.minx = _loc8_.x;
                           }
                           if(_loc8_.x > _loc4_.aabb.maxx)
                           {
                              _loc4_.aabb.maxx = _loc8_.x;
                           }
                           if(_loc8_.y < _loc4_.aabb.miny)
                           {
                              _loc4_.aabb.miny = _loc8_.y;
                           }
                           if(_loc8_.y > _loc4_.aabb.maxy)
                           {
                              _loc4_.aabb.maxy = _loc8_.y;
                           }
                           _loc7_ = _loc7_.next;
                        }
                     }
                  }
               }
               _loc13_ = aabb;
               _loc14_ = _loc2_.aabb;
               if(_loc14_.minx < _loc13_.minx)
               {
                  _loc13_.minx = _loc14_.minx;
               }
               if(_loc14_.maxx > _loc13_.maxx)
               {
                  _loc13_.maxx = _loc14_.maxx;
               }
               if(_loc14_.miny < _loc13_.miny)
               {
                  _loc13_.miny = _loc14_.miny;
               }
               if(_loc14_.maxy > _loc13_.maxy)
               {
                  _loc13_.maxy = _loc14_.maxy;
               }
               _loc1_ = _loc1_.next;
            }
         }
      }
      
      public function svel_validate() : void
      {
         wrap_svel.zpp_inner.x = svelx;
         wrap_svel.zpp_inner.y = svely;
      }
      
      public function svel_invalidate(param1:ZPP_Vec2) : void
      {
         svelx = param1.x;
         svely = param1.y;
         wake();
      }
      
      public function shapes_subber(param1:Shape) : void
      {
         if(space != null)
         {
            space.removed_shape(param1.zpp_inner);
         }
         param1.zpp_inner.body = null;
         param1.zpp_inner.removedFromBody();
      }
      
      public function shapes_modifiable() : void
      {
         immutable_midstep("Body::shapes");
         if(type == ZPP_Flags.id_BodyType_STATIC && space != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot modifiy shapes of static object once added to Space";
         }
      }
      
      public function shapes_invalidate(param1:ZPP_ShapeList) : void
      {
         invalidate_shapes();
      }
      
      public function shapes_adder(param1:Shape) : Boolean
      {
         var _loc2_:* = null as ZPP_Space;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:Boolean = false;
         var _loc5_:* = null as ZPP_Body;
         if(param1.zpp_inner.body != this)
         {
            if(param1.zpp_inner.body != null)
            {
               param1.zpp_inner.body.wrap_shapes.remove(param1);
            }
            param1.zpp_inner.body = this;
            param1.zpp_inner.addedToBody();
            if(space != null)
            {
               _loc2_ = space;
               _loc3_ = param1.zpp_inner;
               _loc4_ = false;
               if(!_loc4_)
               {
                  _loc5_ = _loc3_.body;
                  if(!_loc5_.world)
                  {
                     _loc5_.component.waket = _loc2_.stamp + (_loc2_.midstep ? 0 : 1);
                     if(_loc5_.component.sleeping)
                     {
                        _loc2_.really_wake(_loc5_,false);
                     }
                  }
               }
               _loc2_.bphase.insert(_loc3_);
               _loc3_.addedToSpace();
            }
            if(param1.zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               param1.zpp_inner.polygon.invalidate_gaxi();
               param1.zpp_inner.polygon.invalidate_gverts();
            }
            return true;
         }
         return false;
      }
      
      public function setupsvel() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = svelx;
         var _loc2_:Number = svely;
         §§push(§§findproperty(wrap_svel));
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
         §§pop().wrap_svel = _loc4_;
         wrap_svel.zpp_inner._inuse = true;
         if(world)
         {
            wrap_svel.zpp_inner._immutable = true;
         }
         else
         {
            wrap_svel.zpp_inner._invalidate = svel_invalidate;
            wrap_svel.zpp_inner._validate = svel_validate;
         }
      }
      
      public function setupkinvel() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = kinvelx;
         var _loc2_:Number = kinvely;
         §§push(§§findproperty(wrap_kinvel));
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
         §§pop().wrap_kinvel = _loc4_;
         wrap_kinvel.zpp_inner._inuse = true;
         if(world)
         {
            wrap_kinvel.zpp_inner._immutable = true;
         }
         else
         {
            wrap_kinvel.zpp_inner._invalidate = kinvel_invalidate;
            wrap_kinvel.zpp_inner._validate = kinvel_validate;
         }
      }
      
      public function setup_cvel() : void
      {
         wrapcvel = Vec3.get();
         wrapcvel.zpp_inner.immutable = true;
         wrapcvel.zpp_inner._validate = cvel_validate;
      }
      
      public function setupVelocity() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = velx;
         var _loc2_:Number = vely;
         §§push(§§findproperty(wrap_vel));
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
         §§pop().wrap_vel = _loc4_;
         wrap_vel.zpp_inner._inuse = true;
         if(world)
         {
            wrap_vel.zpp_inner._immutable = true;
         }
         else
         {
            wrap_vel.zpp_inner._invalidate = vel_invalidate;
            wrap_vel.zpp_inner._validate = vel_validate;
         }
      }
      
      public function setupPosition() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = posx;
         var _loc2_:Number = posy;
         §§push(§§findproperty(wrap_pos));
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
         §§pop().wrap_pos = _loc4_;
         wrap_pos.zpp_inner._inuse = true;
         if(world)
         {
            wrap_pos.zpp_inner._immutable = true;
         }
         else
         {
            wrap_pos.zpp_inner._invalidate = pos_invalidate;
            wrap_pos.zpp_inner._validate = pos_validate;
         }
      }
      
      public function setupForce() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = forcex;
         var _loc2_:Number = forcey;
         §§push(§§findproperty(wrap_force));
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
         §§pop().wrap_force = _loc4_;
         wrap_force.zpp_inner._inuse = true;
         if(world)
         {
            wrap_force.zpp_inner._immutable = true;
         }
         else
         {
            wrap_force.zpp_inner._invalidate = force_invalidate;
            wrap_force.zpp_inner._validate = force_validate;
         }
      }
      
      public function removedFromSpace() : void
      {
         var _loc1_:* = null as ZPP_Arbiter;
         var _loc2_:* = null as ZNPList_ZPP_Arbiter;
         var _loc3_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc4_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc7_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc8_:* = null as ZNPNode_ZPP_Arbiter;
         while(arbiters.head != null)
         {
            _loc1_ = arbiters.pop_unsafe();
            _loc1_.cleared = true;
            if(_loc1_.b2 == this)
            {
               _loc2_ = _loc1_.b1.arbiters;
               _loc3_ = null;
               _loc4_ = _loc2_.head;
               _loc5_ = false;
               while(_loc4_ != null)
               {
                  if(_loc4_.elt == _loc1_)
                  {
                     if(_loc3_ == null)
                     {
                        _loc6_ = _loc2_.head;
                        _loc7_ = _loc6_.next;
                        _loc2_.head = _loc7_;
                        if(_loc2_.head == null)
                        {
                           _loc2_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc6_ = _loc3_.next;
                        _loc7_ = _loc6_.next;
                        _loc3_.next = _loc7_;
                        if(_loc7_ == null)
                        {
                           _loc2_.pushmod = true;
                        }
                     }
                     _loc8_ = _loc6_;
                     _loc8_.elt = null;
                     _loc8_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc8_;
                     _loc2_.modified = true;
                     _loc2_.length = _loc2_.length - 1;
                     _loc2_.pushmod = true;
                     _loc7_;
                     _loc5_ = true;
                     break;
                  }
                  _loc3_ = _loc4_;
                  _loc4_ = _loc4_.next;
               }
               _loc5_;
            }
            if(_loc1_.b1 == this)
            {
               _loc2_ = _loc1_.b2.arbiters;
               _loc3_ = null;
               _loc4_ = _loc2_.head;
               _loc5_ = false;
               while(_loc4_ != null)
               {
                  if(_loc4_.elt == _loc1_)
                  {
                     if(_loc3_ == null)
                     {
                        _loc6_ = _loc2_.head;
                        _loc7_ = _loc6_.next;
                        _loc2_.head = _loc7_;
                        if(_loc2_.head == null)
                        {
                           _loc2_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc6_ = _loc3_.next;
                        _loc7_ = _loc6_.next;
                        _loc3_.next = _loc7_;
                        if(_loc7_ == null)
                        {
                           _loc2_.pushmod = true;
                        }
                     }
                     _loc8_ = _loc6_;
                     _loc8_.elt = null;
                     _loc8_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc8_;
                     _loc2_.modified = true;
                     _loc2_.length = _loc2_.length - 1;
                     _loc2_.pushmod = true;
                     _loc7_;
                     _loc5_ = true;
                     break;
                  }
                  _loc3_ = _loc4_;
                  _loc4_ = _loc4_.next;
               }
               _loc5_;
            }
            if(_loc1_.pair != null)
            {
               _loc1_.pair.arb = null;
               _loc1_.pair = null;
            }
            _loc1_.active = false;
            space.f_arbiters.modified = true;
         }
         var _loc9_:ZPP_Component = component;
         _loc9_.body = null;
         _loc9_.constraint = null;
         _loc9_.next = ZPP_Component.zpp_pool;
         ZPP_Component.zpp_pool = _loc9_;
         component = null;
         __iremovedFromSpace();
      }
      
      public function refreshArbiters() : void
      {
         var _loc2_:* = null as ZPP_Arbiter;
         var _loc1_:ZNPNode_ZPP_Arbiter = arbiters.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.invalidated = true;
            _loc1_ = _loc1_.next;
         }
      }
      
      public function pos_validate() : void
      {
         wrap_pos.zpp_inner.x = posx;
         wrap_pos.zpp_inner.y = posy;
      }
      
      public function pos_invalidate(param1:ZPP_Vec2) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         immutable_midstep("Body::position");
         if(type == ZPP_Flags.id_BodyType_STATIC && space != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot move a static object once inside a Space";
         }
         if(!(posx == param1.x && posy == param1.y))
         {
            posx = param1.x;
            posy = param1.y;
            _loc2_ = shapes.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc3_.polygon.invalidate_gverts();
                  _loc3_.polygon.invalidate_gaxi();
               }
               _loc3_.invalidate_worldCOM();
               _loc2_ = _loc2_.next;
            }
            zip_worldCOM = true;
            wake();
         }
      }
      
      public function kinvel_validate() : void
      {
         wrap_kinvel.zpp_inner.x = kinvelx;
         wrap_kinvel.zpp_inner.y = kinvely;
      }
      
      public function kinvel_invalidate(param1:ZPP_Vec2) : void
      {
         kinvelx = param1.x;
         kinvely = param1.y;
         wake();
      }
      
      public function isKinematic() : Boolean
      {
         return type == ZPP_Flags.id_BodyType_KINEMATIC;
      }
      
      public function isDynamic() : Boolean
      {
         return type == ZPP_Flags.id_BodyType_DYNAMIC;
      }
      
      public function invalidate_type() : void
      {
         invalidate_mass();
         invalidate_inertia();
      }
      
      public function invalidate_shapes() : void
      {
         zip_aabb = true;
         zip_localCOM = true;
         zip_worldCOM = true;
         invalidate_mass();
         invalidate_inertia();
      }
      
      public function invalidate_mass() : void
      {
         if(massMode == ZPP_Flags.id_MassMode_DEFAULT)
         {
            zip_mass = true;
         }
         invalidate_gravMass();
      }
      
      public function invalidate_inertia() : void
      {
         if(inertiaMode != ZPP_Flags.id_InertiaMode_FIXED)
         {
            zip_inertia = true;
         }
         wake();
      }
      
      public function invalidate_gravMassScale() : void
      {
         if(gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
         {
            zip_gravMassScale = true;
         }
         else
         {
            invalidate_gravMass();
         }
      }
      
      public function invalidate_gravMass() : void
      {
         if(gravMassMode != ZPP_Flags.id_GravMassMode_FIXED)
         {
            zip_gravMass = true;
         }
         if(gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
         {
            zip_gravMassScale = true;
         }
         wake();
      }
      
      public function interactingBodies(param1:int, param2:int, param3:BodyList) : BodyList
      {
         var _loc6_:* = null as ZPP_Body;
         var _loc7_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc8_:* = null as ZPP_Arbiter;
         var _loc9_:* = null as ZPP_Body;
         var _loc11_:* = null as ZPP_Set_ZPP_Body;
         var _loc12_:* = null as Body;
         var _loc13_:* = null as ZPP_Set_ZPP_Body;
         var _loc14_:* = null as ZPP_Set_ZPP_Body;
         var _loc4_:ZPP_Body = this;
         if(ZPP_Body.bodyset == null)
         {
            ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
            ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
            ZPP_Body.bodystack = new ZNPList_ZPP_Body();
         }
         var _loc5_:BodyList = param3 == null ? new BodyList() : param3;
         ZPP_Body.bodyset.insert(this);
         ZPP_Body.bodystack.add(this);
         graph_depth = 0;
         while(ZPP_Body.bodystack.head != null)
         {
            _loc6_ = ZPP_Body.bodystack.pop_unsafe();
            if(_loc6_.graph_depth != param2)
            {
               _loc7_ = _loc6_.arbiters.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  if((_loc8_.type & param1) != 0)
                  {
                     _loc9_ = _loc8_.b1 == _loc6_ ? _loc8_.b2 : _loc8_.b1;
                     if(ZPP_Body.bodyset.try_insert_bool(_loc9_))
                     {
                        ZPP_Body.bodystack.add(_loc9_);
                        _loc9_.graph_depth = _loc6_.graph_depth + 1;
                     }
                  }
                  _loc7_ = _loc7_.next;
               }
            }
         }
         var _loc10_:ZPP_Set_ZPP_Body = ZPP_Body.bodyset;
         if(_loc10_.parent != null)
         {
            _loc11_ = _loc10_.parent;
            while(_loc11_ != null)
            {
               if(_loc11_.prev != null)
               {
                  §§push(_loc11_.prev);
               }
               else if(_loc11_.next != null)
               {
                  §§push(_loc11_.next);
               }
               else
               {
                  _loc6_ = _loc11_.data;
                  if(_loc6_ != _loc4_)
                  {
                     _loc12_ = _loc6_.outer;
                     if(_loc5_.zpp_inner.reverse_flag)
                     {
                        _loc5_.push(_loc12_);
                     }
                     else
                     {
                        _loc5_.unshift(_loc12_);
                     }
                  }
                  _loc13_ = _loc11_.parent;
                  if(_loc13_ != null)
                  {
                     if(_loc11_ == _loc13_.prev)
                     {
                        _loc13_.prev = null;
                     }
                     else
                     {
                        _loc13_.next = null;
                     }
                     _loc11_.parent = null;
                  }
                  _loc14_ = _loc11_;
                  _loc14_.data = null;
                  _loc14_.lt = null;
                  _loc14_.swapped = null;
                  _loc14_.next = ZPP_Set_ZPP_Body.zpp_pool;
                  ZPP_Set_ZPP_Body.zpp_pool = _loc14_;
                  §§push(_loc13_);
               }
               _loc11_ = §§pop();
            }
            _loc10_.parent = null;
         }
         return _loc5_;
      }
      
      public function init_bodysetlist() : void
      {
         if(ZPP_Body.bodyset == null)
         {
            ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
            ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
            ZPP_Body.bodystack = new ZNPList_ZPP_Body();
         }
      }
      
      public function getworldCOM() : void
      {
         if(shapes.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: worldCOM only makes sense when Body has Shapes";
         }
         validate_worldCOM();
      }
      
      public function getlocalCOM() : void
      {
         if(shapes.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: localCOM only makes sense when Body has Shapes";
         }
         validate_localCOM();
      }
      
      public function force_validate() : void
      {
         wrap_force.zpp_inner.x = forcex;
         wrap_force.zpp_inner.y = forcey;
      }
      
      public function force_invalidate(param1:ZPP_Vec2) : void
      {
         if(type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            Boot.lastError = new Error();
            throw "Error: Non-dynamic body cannot have force applied.";
         }
         forcex = param1.x;
         forcey = param1.y;
         wake();
      }
      
      public function cvel_validate() : void
      {
         wrapcvel.zpp_inner.x = velx + kinvelx;
         wrapcvel.zpp_inner.y = vely + kinvely;
         wrapcvel.zpp_inner.z = angvel + kinangvel;
      }
      
      public function copy() : Body
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as ShapeList;
         var _loc5_:* = null as Shape;
         var _loc1_:ZPP_Body = new Body().zpp_inner;
         _loc1_.type = type;
         _loc1_.bulletEnabled = bulletEnabled;
         _loc1_.disableCCD = disableCCD;
         _loc2_ = shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc1_.outer.zpp_inner.wrap_shapes;
            _loc5_ = _loc3_.outer.copy();
            if(_loc4_.zpp_inner.reverse_flag)
            {
               _loc4_.push(_loc5_);
            }
            else
            {
               _loc4_.unshift(_loc5_);
            }
            _loc2_ = _loc2_.next;
         }
         _loc1_.posx = posx;
         _loc1_.posy = posy;
         _loc1_.velx = velx;
         _loc1_.vely = vely;
         _loc1_.forcex = forcex;
         _loc1_.forcey = forcey;
         _loc1_.rot = rot;
         _loc1_.angvel = angvel;
         _loc1_.torque = torque;
         _loc1_.kinvelx = kinvelx;
         _loc1_.kinvely = kinvely;
         _loc1_.kinangvel = kinangvel;
         _loc1_.svelx = svelx;
         _loc1_.svely = svely;
         if(!zip_axis)
         {
            _loc1_.axisx = axisx;
            _loc1_.axisy = axisy;
         }
         else
         {
            _loc1_.zip_axis = true;
            _loc2_ = _loc1_.shapes.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc3_.polygon.invalidate_gverts();
                  _loc3_.polygon.invalidate_gaxi();
               }
               _loc3_.invalidate_worldCOM();
               _loc2_ = _loc2_.next;
            }
            _loc1_.zip_worldCOM = true;
         }
         _loc1_.rot = rot;
         _loc1_.massMode = massMode;
         _loc1_.gravMassMode = gravMassMode;
         _loc1_.inertiaMode = inertiaMode;
         if(!zip_mass)
         {
            _loc1_.mass = mass;
         }
         else
         {
            _loc1_.invalidate_mass();
         }
         if(!zip_gravMass)
         {
            _loc1_.gravMass = gravMass;
         }
         else
         {
            _loc1_.invalidate_gravMass();
         }
         if(!zip_gravMassScale)
         {
            _loc1_.gravMassScale = gravMassScale;
         }
         else
         {
            _loc1_.invalidate_gravMassScale();
         }
         if(!zip_inertia)
         {
            _loc1_.inertia = inertia;
         }
         else
         {
            _loc1_.invalidate_inertia();
         }
         if(!zip_aabb)
         {
            _loc1_.aabb.minx = aabb.minx;
            _loc1_.aabb.miny = aabb.miny;
            _loc1_.aabb.maxx = aabb.maxx;
            _loc1_.aabb.maxy = aabb.maxy;
         }
         else
         {
            _loc1_.zip_aabb = true;
         }
         if(!zip_localCOM)
         {
            _loc1_.localCOMx = localCOMx;
            _loc1_.localCOMy = localCOMy;
         }
         else
         {
            _loc1_.zip_localCOM = true;
            _loc1_.zip_worldCOM = true;
         }
         if(!zip_worldCOM)
         {
            _loc1_.worldCOMx = worldCOMx;
            _loc1_.worldCOMy = worldCOMy;
         }
         else
         {
            _loc1_.zip_worldCOM = true;
         }
         copyto(_loc1_.outer);
         return _loc1_.outer;
      }
      
      public function connectedBodies_cont(param1:Body) : void
      {
         if(ZPP_Body.bodyset.try_insert_bool(param1.zpp_inner))
         {
            ZPP_Body.bodystack.add(param1.zpp_inner);
            param1.zpp_inner.graph_depth = ZPP_Body.cur_graph_depth + 1;
         }
      }
      
      public function connectedBodies(param1:int, param2:BodyList) : BodyList
      {
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Constraint;
         var _loc7_:* = null as ZPP_Constraint;
         var _loc9_:* = null as ZPP_Set_ZPP_Body;
         var _loc10_:* = null as Body;
         var _loc11_:* = null as ZPP_Set_ZPP_Body;
         var _loc12_:* = null as ZPP_Set_ZPP_Body;
         var _loc3_:ZPP_Body = this;
         if(ZPP_Body.bodyset == null)
         {
            ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
            ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
            ZPP_Body.bodystack = new ZNPList_ZPP_Body();
         }
         var _loc4_:BodyList = param2 == null ? new BodyList() : param2;
         ZPP_Body.bodystack.add(this);
         ZPP_Body.bodyset.insert(this);
         graph_depth = 0;
         while(ZPP_Body.bodystack.head != null)
         {
            _loc5_ = ZPP_Body.bodystack.pop_unsafe();
            if(_loc5_.graph_depth != param1)
            {
               ZPP_Body.cur_graph_depth = _loc5_.graph_depth;
               _loc6_ = _loc5_.constraints.head;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_.elt;
                  _loc7_.outer.visitBodies(connectedBodies_cont);
                  _loc6_ = _loc6_.next;
               }
            }
         }
         var _loc8_:ZPP_Set_ZPP_Body = ZPP_Body.bodyset;
         if(_loc8_.parent != null)
         {
            _loc9_ = _loc8_.parent;
            while(_loc9_ != null)
            {
               if(_loc9_.prev != null)
               {
                  §§push(_loc9_.prev);
               }
               else if(_loc9_.next != null)
               {
                  §§push(_loc9_.next);
               }
               else
               {
                  _loc5_ = _loc9_.data;
                  if(_loc5_ != _loc3_)
                  {
                     _loc10_ = _loc5_.outer;
                     if(_loc4_.zpp_inner.reverse_flag)
                     {
                        _loc4_.push(_loc10_);
                     }
                     else
                     {
                        _loc4_.unshift(_loc10_);
                     }
                  }
                  _loc11_ = _loc9_.parent;
                  if(_loc11_ != null)
                  {
                     if(_loc9_ == _loc11_.prev)
                     {
                        _loc11_.prev = null;
                     }
                     else
                     {
                        _loc11_.next = null;
                     }
                     _loc9_.parent = null;
                  }
                  _loc12_ = _loc9_;
                  _loc12_.data = null;
                  _loc12_.lt = null;
                  _loc12_.swapped = null;
                  _loc12_.next = ZPP_Set_ZPP_Body.zpp_pool;
                  ZPP_Set_ZPP_Body.zpp_pool = _loc12_;
                  §§push(_loc11_);
               }
               _loc9_ = §§pop();
            }
            _loc8_.parent = null;
         }
         return _loc4_;
      }
      
      public function clear() : void
      {
         var _loc1_:* = null as ZPP_Shape;
         if(space != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot clear a Body if it is currently being used by a Space!";
         }
         if(constraints.head != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot clear a Body if it is currently being used by a constraint!";
         }
         while(shapes.head != null)
         {
            _loc1_ = shapes.pop_unsafe();
            _loc1_.removedFromBody();
            _loc1_.body = null;
         }
         invalidate_shapes();
         pre_posx = 0;
         pre_posy = 0;
         posx = 0;
         posy = 0;
         velx = 0;
         vely = 0;
         forcex = 0;
         forcey = 0;
         kinvelx = 0;
         kinvely = 0;
         svelx = 0;
         svely = 0;
         angvel = torque = kinangvel = pre_rot = rot = 0;
         var _loc3_:ZNPNode_ZPP_Shape = shapes.head;
         while(_loc3_ != null)
         {
            _loc1_ = _loc3_.elt;
            if(_loc1_.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc1_.polygon.invalidate_gverts();
               _loc1_.polygon.invalidate_gaxi();
            }
            _loc1_.invalidate_worldCOM();
            _loc3_ = _loc3_.next;
         }
         zip_worldCOM = true;
         zip_axis = true;
         _loc3_ = shapes.head;
         while(_loc3_ != null)
         {
            _loc1_ = _loc3_.elt;
            if(_loc1_.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc1_.polygon.invalidate_gverts();
               _loc1_.polygon.invalidate_gaxi();
            }
            _loc1_.invalidate_worldCOM();
            _loc3_ = _loc3_.next;
         }
         zip_worldCOM = true;
         axisx = 0;
         axisy = 1;
         zip_axis = false;
         massMode = ZPP_Flags.id_MassMode_DEFAULT;
         gravMassMode = ZPP_Flags.id_GravMassMode_DEFAULT;
         gravMassScale = 1;
         inertiaMode = ZPP_Flags.id_InertiaMode_DEFAULT;
         norotate = false;
         nomove = false;
      }
      
      public function atRest(param1:Number) : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            return component.sleeping;
         }
         _loc2_ = Config.linearSleepThreshold;
         _loc2_ *= _loc2_;
         _loc3_ = velx * velx + vely * vely > _loc2_ ? false : (_loc4_ = 0, _loc5_ = 0, _loc4_ = posx - pre_posx, _loc5_ = posy - pre_posy, _loc4_ * _loc4_ + _loc5_ * _loc5_ > 0.25 * _loc2_ * param1 * param1 ? false : (_loc4_ = 0, _loc5_ = 0, _loc4_ = aabb.maxx - aabb.minx, _loc5_ = aabb.maxy - aabb.miny, _loc6_ = _loc4_ * _loc4_ + _loc5_ * _loc5_, _loc7_ = Config.angularSleepThreshold, _loc7_ *= _loc7_, 4 * angvel * angvel * _loc6_ > _loc7_ ? false : (_loc8_ = rot - pre_rot, _loc8_ * _loc8_ * _loc6_ > _loc7_ * param1 * param1 ? false : true)));
         if(!_loc3_)
         {
            component.waket = space.stamp;
         }
         return component.waket + Config.sleepDelay < space.stamp;
      }
      
      public function addedToSpace() : void
      {
         if(ZPP_Component.zpp_pool == null)
         {
            component = new ZPP_Component();
         }
         else
         {
            component = ZPP_Component.zpp_pool;
            ZPP_Component.zpp_pool = component.next;
            component.next = null;
         }
         component.isBody = true;
         component.body = this;
         __iaddedToSpace();
      }
      
      public function aabb_validate() : void
      {
         var _loc1_:* = null as ZNPNode_ZPP_Shape;
         var _loc2_:* = null as ZPP_Shape;
         var _loc3_:* = null as ZPP_Circle;
         var _loc4_:* = null as ZPP_Polygon;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Body;
         var _loc13_:* = null as ZPP_AABB;
         var _loc14_:* = null as ZPP_AABB;
         if(shapes.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: bounds only makes sense when Body has shapes";
         }
         if(shapes.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Body bounds only makes sense if it contains shapes";
         }
         if(zip_aabb)
         {
            zip_aabb = false;
            aabb.minx = 1.79e+308;
            aabb.miny = 1.79e+308;
            aabb.maxx = -1.79e+308;
            aabb.maxy = -1.79e+308;
            _loc1_ = shapes.head;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_.elt;
               if(_loc2_.zip_aabb)
               {
                  if(_loc2_.body != null)
                  {
                     _loc2_.zip_aabb = false;
                     if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc3_ = _loc2_.circle;
                        if(_loc3_.zip_worldCOM)
                        {
                           if(_loc3_.body != null)
                           {
                              _loc3_.zip_worldCOM = false;
                              if(_loc3_.zip_localCOM)
                              {
                                 _loc3_.zip_localCOM = false;
                                 if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc4_ = _loc3_.polygon;
                                    if(_loc4_.lverts.next == null)
                                    {
                                       Boot.lastError = new Error();
                                       throw "Error: An empty polygon has no meaningful localCOM";
                                    }
                                    if(_loc4_.lverts.next.next == null)
                                    {
                                       _loc4_.localCOMx = _loc4_.lverts.next.x;
                                       _loc4_.localCOMy = _loc4_.lverts.next.y;
                                    }
                                    else if(_loc4_.lverts.next.next.next == null)
                                    {
                                       _loc4_.localCOMx = _loc4_.lverts.next.x;
                                       _loc4_.localCOMy = _loc4_.lverts.next.y;
                                       _loc5_ = 1;
                                       _loc4_.localCOMx += _loc4_.lverts.next.next.x * _loc5_;
                                       _loc4_.localCOMy += _loc4_.lverts.next.next.y * _loc5_;
                                       _loc5_ = 0.5;
                                       _loc4_.localCOMx *= _loc5_;
                                       _loc4_.localCOMy *= _loc5_;
                                    }
                                    else
                                    {
                                       _loc4_.localCOMx = 0;
                                       _loc4_.localCOMy = 0;
                                       _loc5_ = 0;
                                       _loc6_ = _loc4_.lverts.next;
                                       _loc7_ = _loc6_;
                                       _loc6_ = _loc6_.next;
                                       _loc8_ = _loc6_;
                                       _loc6_ = _loc6_.next;
                                       while(_loc6_ != null)
                                       {
                                          _loc9_ = _loc6_;
                                          _loc5_ += _loc8_.x * (_loc9_.y - _loc7_.y);
                                          _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                                          _loc4_.localCOMx += (_loc8_.x + _loc9_.x) * _loc10_;
                                          _loc4_.localCOMy += (_loc8_.y + _loc9_.y) * _loc10_;
                                          _loc7_ = _loc8_;
                                          _loc8_ = _loc9_;
                                          _loc6_ = _loc6_.next;
                                       }
                                       _loc6_ = _loc4_.lverts.next;
                                       _loc9_ = _loc6_;
                                       _loc5_ += _loc8_.x * (_loc9_.y - _loc7_.y);
                                       _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                                       _loc4_.localCOMx += (_loc8_.x + _loc9_.x) * _loc10_;
                                       _loc4_.localCOMy += (_loc8_.y + _loc9_.y) * _loc10_;
                                       _loc7_ = _loc8_;
                                       _loc8_ = _loc9_;
                                       _loc6_ = _loc6_.next;
                                       _loc11_ = _loc6_;
                                       _loc5_ += _loc8_.x * (_loc11_.y - _loc7_.y);
                                       _loc10_ = _loc11_.y * _loc8_.x - _loc11_.x * _loc8_.y;
                                       _loc4_.localCOMx += (_loc8_.x + _loc11_.x) * _loc10_;
                                       _loc4_.localCOMy += (_loc8_.y + _loc11_.y) * _loc10_;
                                       _loc5_ = 1 / (3 * _loc5_);
                                       _loc10_ = _loc5_;
                                       _loc4_.localCOMx *= _loc10_;
                                       _loc4_.localCOMy *= _loc10_;
                                    }
                                 }
                              }
                              _loc12_ = _loc3_.body;
                              if(_loc12_.zip_axis)
                              {
                                 _loc12_.zip_axis = false;
                                 _loc12_.axisx = Math.sin(_loc12_.rot);
                                 _loc12_.axisy = Math.cos(_loc12_.rot);
                              }
                              _loc3_.worldCOMx = _loc3_.body.posx + (_loc3_.body.axisy * _loc3_.localCOMx - _loc3_.body.axisx * _loc3_.localCOMy);
                              _loc3_.worldCOMy = _loc3_.body.posy + (_loc3_.localCOMx * _loc3_.body.axisx + _loc3_.localCOMy * _loc3_.body.axisy);
                           }
                        }
                        _loc5_ = _loc3_.radius;
                        _loc10_ = _loc3_.radius;
                        _loc3_.aabb.minx = _loc3_.worldCOMx - _loc5_;
                        _loc3_.aabb.miny = _loc3_.worldCOMy - _loc10_;
                        _loc3_.aabb.maxx = _loc3_.worldCOMx + _loc5_;
                        _loc3_.aabb.maxy = _loc3_.worldCOMy + _loc10_;
                     }
                     else
                     {
                        _loc4_ = _loc2_.polygon;
                        if(_loc4_.zip_gverts)
                        {
                           if(_loc4_.body != null)
                           {
                              _loc4_.zip_gverts = false;
                              _loc4_.validate_lverts();
                              _loc12_ = _loc4_.body;
                              if(_loc12_.zip_axis)
                              {
                                 _loc12_.zip_axis = false;
                                 _loc12_.axisx = Math.sin(_loc12_.rot);
                                 _loc12_.axisy = Math.cos(_loc12_.rot);
                              }
                              _loc6_ = _loc4_.lverts.next;
                              _loc7_ = _loc4_.gverts.next;
                              while(_loc7_ != null)
                              {
                                 _loc8_ = _loc7_;
                                 _loc9_ = _loc6_;
                                 _loc6_ = _loc6_.next;
                                 _loc8_.x = _loc4_.body.posx + (_loc4_.body.axisy * _loc9_.x - _loc4_.body.axisx * _loc9_.y);
                                 _loc8_.y = _loc4_.body.posy + (_loc9_.x * _loc4_.body.axisx + _loc9_.y * _loc4_.body.axisy);
                                 _loc7_ = _loc7_.next;
                              }
                           }
                        }
                        if(_loc4_.lverts.next == null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: An empty polygon has no meaningful bounds";
                        }
                        _loc6_ = _loc4_.gverts.next;
                        _loc4_.aabb.minx = _loc6_.x;
                        _loc4_.aabb.miny = _loc6_.y;
                        _loc4_.aabb.maxx = _loc6_.x;
                        _loc4_.aabb.maxy = _loc6_.y;
                        _loc7_ = _loc4_.gverts.next.next;
                        while(_loc7_ != null)
                        {
                           _loc8_ = _loc7_;
                           if(_loc8_.x < _loc4_.aabb.minx)
                           {
                              _loc4_.aabb.minx = _loc8_.x;
                           }
                           if(_loc8_.x > _loc4_.aabb.maxx)
                           {
                              _loc4_.aabb.maxx = _loc8_.x;
                           }
                           if(_loc8_.y < _loc4_.aabb.miny)
                           {
                              _loc4_.aabb.miny = _loc8_.y;
                           }
                           if(_loc8_.y > _loc4_.aabb.maxy)
                           {
                              _loc4_.aabb.maxy = _loc8_.y;
                           }
                           _loc7_ = _loc7_.next;
                        }
                     }
                  }
               }
               _loc13_ = aabb;
               _loc14_ = _loc2_.aabb;
               if(_loc14_.minx < _loc13_.minx)
               {
                  _loc13_.minx = _loc14_.minx;
               }
               if(_loc14_.maxx > _loc13_.maxx)
               {
                  _loc13_.maxx = _loc14_.maxx;
               }
               if(_loc14_.miny < _loc13_.miny)
               {
                  _loc13_.miny = _loc14_.miny;
               }
               if(_loc14_.maxy > _loc13_.maxy)
               {
                  _loc13_.maxy = _loc14_.maxy;
               }
               _loc1_ = _loc1_.next;
            }
         }
      }
   }
}
