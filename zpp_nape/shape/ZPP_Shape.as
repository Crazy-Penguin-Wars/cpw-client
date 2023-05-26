package zpp_nape.shape
{
   import flash.Boot;
   import nape.dynamics.InteractionFilter;
   import nape.geom.Vec2;
   import nape.phys.Material;
   import nape.shape.Shape;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_FluidProperties;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.phys.ZPP_Material;
   import zpp_nape.space.ZPP_AABBNode;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.space.ZPP_SweepData;
   import zpp_nape.util.ZNPList_ZPP_AABBPair;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_Shape extends ZPP_Interactor
   {
       
      
      public var zip_worldCOM:Boolean;
      
      public var zip_sweepRadius:Boolean;
      
      public var zip_localCOM:Boolean;
      
      public var zip_area_inertia:Boolean;
      
      public var zip_angDrag:Boolean;
      
      public var zip_aabb:Boolean;
      
      public var wrap_worldCOM:Vec2;
      
      public var wrap_localCOM:Vec2;
      
      public var worldCOMy:Number;
      
      public var worldCOMx:Number;
      
      public var type:int;
      
      public var sweepRadius:Number;
      
      public var sweepCoef:Number;
      
      public var sweep:ZPP_SweepData;
      
      public var sensorEnabled:Boolean;
      
      public var refmaterial:ZPP_Material;
      
      public var polygon:ZPP_Polygon;
      
      public var pairs:ZNPList_ZPP_AABBPair;
      
      public var outer:Shape;
      
      public var node:ZPP_AABBNode;
      
      public var material:ZPP_Material;
      
      public var localCOMy:Number;
      
      public var localCOMx:Number;
      
      public var inertia:Number;
      
      public var fluidProperties:ZPP_FluidProperties;
      
      public var fluidEnabled:Boolean;
      
      public var filter:ZPP_InteractionFilter;
      
      public var circle:ZPP_Circle;
      
      public var body:ZPP_Body;
      
      public var area:Number;
      
      public var angDrag:Number;
      
      public var aabb:ZPP_AABB;
      
      public function ZPP_Shape(param1:int = 0)
      {
         var _loc2_:* = null as ZPP_AABB;
         if(Boot.skip_constructor)
         {
            return;
         }
         zip_aabb = false;
         aabb = null;
         pairs = null;
         node = null;
         sweep = null;
         sensorEnabled = false;
         fluidEnabled = false;
         fluidProperties = null;
         filter = null;
         material = null;
         refmaterial = null;
         polygon = null;
         circle = null;
         sweepCoef = 0;
         zip_sweepRadius = false;
         sweepRadius = 0;
         wrap_worldCOM = null;
         wrap_localCOM = null;
         zip_worldCOM = false;
         worldCOMy = 0;
         worldCOMx = 0;
         zip_localCOM = false;
         localCOMy = 0;
         localCOMx = 0;
         zip_angDrag = false;
         angDrag = 0;
         inertia = 0;
         zip_area_inertia = false;
         area = 0;
         type = 0;
         body = null;
         outer = null;
         super();
         pairs = new ZNPList_ZPP_AABBPair();
         ishape = this;
         type = param1;
         §§push(§§findproperty(aabb));
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc2_ = new ZPP_AABB();
         }
         else
         {
            _loc2_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         _loc2_.minx = 0;
         _loc2_.miny = 0;
         _loc2_.maxx = 0;
         _loc2_.maxy = 0;
         §§pop().aabb = _loc2_;
         aabb._immutable = true;
         aabb._validate = aabb_validate;
         zip_area_inertia = zip_angDrag = zip_localCOM = zip_sweepRadius = true;
         localCOMx = 0;
         localCOMy = 0;
         worldCOMx = 0;
         worldCOMy = 0;
         fluidEnabled = false;
         sensorEnabled = false;
         fluidProperties = null;
         body = null;
         refmaterial = new ZPP_Material();
         sweepCoef = 0;
         sweepRadius = 0;
      }
      
      public function validate_sweepRadius() : void
      {
         if(zip_sweepRadius)
         {
            zip_sweepRadius = false;
            if(type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               circle.__validate_sweepRadius();
            }
            else
            {
               polygon.__validate_sweepRadius();
            }
         }
      }
      
      public function validate_area_inertia() : void
      {
         if(zip_area_inertia)
         {
            zip_area_inertia = false;
            if(type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               circle.__validate_area_inertia();
            }
            else
            {
               polygon.__validate_area_inertia();
            }
         }
      }
      
      public function validate_angDrag() : void
      {
         if(zip_angDrag || refmaterial.dynamicFriction != material.dynamicFriction)
         {
            zip_angDrag = false;
            refmaterial.dynamicFriction = material.dynamicFriction;
            if(type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               circle.__validate_angDrag();
            }
            else
            {
               polygon.__validate_angDrag();
            }
         }
      }
      
      public function setMaterial(param1:ZPP_Material) : void
      {
         if(material != param1)
         {
            if(body != null && body.space != null)
            {
               if(material != null)
               {
                  material.shapes.remove(this);
               }
            }
            material = param1;
            if(body != null && body.space != null)
            {
               param1.shapes.add(this);
            }
            wake();
            if(body != null)
            {
               body.refreshArbiters();
            }
         }
      }
      
      public function setFluid(param1:ZPP_FluidProperties) : void
      {
         if(fluidProperties != param1)
         {
            if(body != null && body.space != null)
            {
               if(fluidProperties != null)
               {
                  fluidProperties.shapes.remove(this);
               }
            }
            fluidProperties = param1;
            if(body != null && body.space != null)
            {
               param1.shapes.add(this);
            }
            if(fluidEnabled)
            {
               wake();
            }
         }
      }
      
      public function setFilter(param1:ZPP_InteractionFilter) : void
      {
         if(filter != param1)
         {
            if(body != null && body.space != null)
            {
               if(filter != null)
               {
                  filter.shapes.remove(this);
               }
            }
            filter = param1;
            if(body != null && body.space != null)
            {
               param1.shapes.add(this);
            }
            wake();
         }
      }
      
      public function removedFromSpace() : void
      {
         __iremovedFromSpace();
         material.shapes.remove(this);
         filter.shapes.remove(this);
         if(fluidProperties != null)
         {
            fluidProperties.shapes.remove(this);
         }
      }
      
      public function removedFromBody() : void
      {
      }
      
      public function isPolygon() : Boolean
      {
         return type == ZPP_Flags.id_ShapeType_POLYGON;
      }
      
      public function isCircle() : Boolean
      {
         return type == ZPP_Flags.id_ShapeType_CIRCLE;
      }
      
      public function invalidate_worldCOM() : void
      {
         zip_worldCOM = true;
         zip_aabb = true;
         if(body != null)
         {
            body.zip_aabb = true;
         }
      }
      
      public function invalidate_material(param1:int) : void
      {
         var _loc2_:* = null as ZPP_Body;
         if((param1 & ZPP_Material.WAKE) != 0)
         {
            wake();
         }
         if((param1 & ZPP_Material.ARBITERS) != 0)
         {
            if(body != null)
            {
               body.refreshArbiters();
            }
         }
         if((param1 & ZPP_Material.PROPS) != 0)
         {
            if(body != null)
            {
               _loc2_ = body;
               _loc2_.zip_localCOM = true;
               _loc2_.zip_worldCOM = true;
               body.invalidate_mass();
               body.invalidate_inertia();
            }
         }
         if((param1 & ZPP_Material.ANGDRAG) != 0)
         {
            invalidate_angDrag();
         }
         refmaterial.set(material);
      }
      
      public function invalidate_localCOM() : void
      {
         var _loc1_:* = null as ZPP_Body;
         zip_localCOM = true;
         invalidate_area_inertia();
         if(type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            zip_sweepRadius = true;
         }
         invalidate_angDrag();
         invalidate_worldCOM();
         if(body != null)
         {
            _loc1_ = body;
            _loc1_.zip_localCOM = true;
            _loc1_.zip_worldCOM = true;
         }
      }
      
      public function invalidate_fluidprops() : void
      {
         if(fluidEnabled)
         {
            wake();
         }
      }
      
      public function invalidate_filter() : void
      {
         wake();
      }
      
      public function invalidate_area_inertia() : void
      {
         var _loc1_:* = null as ZPP_Body;
         zip_area_inertia = true;
         if(body != null)
         {
            _loc1_ = body;
            _loc1_.zip_localCOM = true;
            _loc1_.zip_worldCOM = true;
            body.invalidate_mass();
            body.invalidate_inertia();
         }
      }
      
      public function invalidate_angDrag() : void
      {
         zip_angDrag = true;
      }
      
      public function getworldCOM() : void
      {
         var _loc1_:* = null as ZPP_Polygon;
         var _loc2_:Number = NaN;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Body;
         if(body == null)
         {
            Boot.lastError = new Error();
            throw "Error: worldCOM only makes sense when Shape belongs to a Body";
         }
         if(zip_worldCOM)
         {
            if(body != null)
            {
               zip_worldCOM = false;
               if(zip_localCOM)
               {
                  zip_localCOM = false;
                  if(type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc1_ = polygon;
                     if(_loc1_.lverts.next == null)
                     {
                        Boot.lastError = new Error();
                        throw "Error: An empty polygon has no meaningful localCOM";
                     }
                     if(_loc1_.lverts.next.next == null)
                     {
                        _loc1_.localCOMx = _loc1_.lverts.next.x;
                        _loc1_.localCOMy = _loc1_.lverts.next.y;
                     }
                     else if(_loc1_.lverts.next.next.next == null)
                     {
                        _loc1_.localCOMx = _loc1_.lverts.next.x;
                        _loc1_.localCOMy = _loc1_.lverts.next.y;
                        _loc2_ = 1;
                        _loc1_.localCOMx += _loc1_.lverts.next.next.x * _loc2_;
                        _loc1_.localCOMy += _loc1_.lverts.next.next.y * _loc2_;
                        _loc2_ = 0.5;
                        _loc1_.localCOMx *= _loc2_;
                        _loc1_.localCOMy *= _loc2_;
                     }
                     else
                     {
                        _loc1_.localCOMx = 0;
                        _loc1_.localCOMy = 0;
                        _loc2_ = 0;
                        _loc3_ = _loc1_.lverts.next;
                        _loc4_ = _loc3_;
                        _loc3_ = _loc3_.next;
                        _loc5_ = _loc3_;
                        _loc3_ = _loc3_.next;
                        while(_loc3_ != null)
                        {
                           _loc6_ = _loc3_;
                           _loc2_ += _loc5_.x * (_loc6_.y - _loc4_.y);
                           _loc7_ = _loc6_.y * _loc5_.x - _loc6_.x * _loc5_.y;
                           _loc1_.localCOMx += (_loc5_.x + _loc6_.x) * _loc7_;
                           _loc1_.localCOMy += (_loc5_.y + _loc6_.y) * _loc7_;
                           _loc4_ = _loc5_;
                           _loc5_ = _loc6_;
                           _loc3_ = _loc3_.next;
                        }
                        _loc3_ = _loc1_.lverts.next;
                        _loc6_ = _loc3_;
                        _loc2_ += _loc5_.x * (_loc6_.y - _loc4_.y);
                        _loc7_ = _loc6_.y * _loc5_.x - _loc6_.x * _loc5_.y;
                        _loc1_.localCOMx += (_loc5_.x + _loc6_.x) * _loc7_;
                        _loc1_.localCOMy += (_loc5_.y + _loc6_.y) * _loc7_;
                        _loc4_ = _loc5_;
                        _loc5_ = _loc6_;
                        _loc3_ = _loc3_.next;
                        _loc8_ = _loc3_;
                        _loc2_ += _loc5_.x * (_loc8_.y - _loc4_.y);
                        _loc7_ = _loc8_.y * _loc5_.x - _loc8_.x * _loc5_.y;
                        _loc1_.localCOMx += (_loc5_.x + _loc8_.x) * _loc7_;
                        _loc1_.localCOMy += (_loc5_.y + _loc8_.y) * _loc7_;
                        _loc2_ = 1 / (3 * _loc2_);
                        _loc7_ = _loc2_;
                        _loc1_.localCOMx *= _loc7_;
                        _loc1_.localCOMy *= _loc7_;
                     }
                  }
               }
               _loc9_ = body;
               if(_loc9_.zip_axis)
               {
                  _loc9_.zip_axis = false;
                  _loc9_.axisx = Math.sin(_loc9_.rot);
                  _loc9_.axisy = Math.cos(_loc9_.rot);
               }
               worldCOMx = body.posx + (body.axisy * localCOMx - body.axisx * localCOMy);
               worldCOMy = body.posy + (localCOMx * body.axisx + localCOMy * body.axisy);
            }
         }
         wrap_worldCOM.zpp_inner.x = worldCOMx;
         wrap_worldCOM.zpp_inner.y = worldCOMy;
      }
      
      public function copy() : Shape
      {
         var _loc1_:ZPP_Shape = null;
         if(type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            _loc1_ = circle.__copy();
         }
         else
         {
            _loc1_ = polygon.__copy();
         }
         if(!zip_area_inertia)
         {
            _loc1_.area = area;
            _loc1_.inertia = inertia;
         }
         else
         {
            _loc1_.invalidate_area_inertia();
         }
         if(!zip_sweepRadius)
         {
            _loc1_.sweepRadius = sweepRadius;
            _loc1_.sweepCoef = sweepCoef;
         }
         else
         {
            _loc1_.zip_sweepRadius = true;
         }
         if(!zip_angDrag)
         {
            _loc1_.angDrag = angDrag;
         }
         else
         {
            _loc1_.invalidate_angDrag();
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
            if(_loc1_.body != null)
            {
               _loc1_.body.zip_aabb = true;
            }
         }
         var _loc2_:ZPP_Material = _loc1_.material;
         _loc2_.outer = null;
         _loc2_.next = ZPP_Material.zpp_pool;
         ZPP_Material.zpp_pool = _loc2_;
         var _loc3_:ZPP_InteractionFilter = _loc1_.filter;
         _loc3_.outer = null;
         _loc3_.next = ZPP_InteractionFilter.zpp_pool;
         ZPP_InteractionFilter.zpp_pool = _loc3_;
         _loc1_.material = material;
         _loc1_.filter = filter;
         if(fluidProperties != null)
         {
            _loc1_.fluidProperties = fluidProperties;
         }
         _loc1_.fluidEnabled = fluidEnabled;
         _loc1_.sensorEnabled = sensorEnabled;
         if(userData != null)
         {
            _loc1_.userData = Reflect.copy(userData);
         }
         copyto(_loc1_.outer);
         return _loc1_.outer;
      }
      
      public function clear() : void
      {
         if(type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            circle.__clear();
         }
         else
         {
            polygon.__clear();
         }
      }
      
      public function addedToSpace() : void
      {
         __iaddedToSpace();
         material.shapes.add(this);
         filter.shapes.add(this);
         if(fluidProperties != null)
         {
            fluidProperties.shapes.add(this);
         }
      }
      
      public function addedToBody() : void
      {
         invalidate_worldCOM();
         zip_aabb = true;
         if(body != null)
         {
            body.zip_aabb = true;
         }
      }
      
      public function aabb_validate() : void
      {
         var _loc1_:* = null as ZPP_Circle;
         var _loc2_:* = null as ZPP_Polygon;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Body;
         if(body == null)
         {
            Boot.lastError = new Error();
            throw "Error: bounds only makes sense when Shape belongs to a Body";
         }
         if(zip_aabb)
         {
            if(body != null)
            {
               zip_aabb = false;
               if(type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc1_ = circle;
                  if(_loc1_.zip_worldCOM)
                  {
                     if(_loc1_.body != null)
                     {
                        _loc1_.zip_worldCOM = false;
                        if(_loc1_.zip_localCOM)
                        {
                           _loc1_.zip_localCOM = false;
                           if(_loc1_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc2_ = _loc1_.polygon;
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
                                 _loc3_ = 1;
                                 _loc2_.localCOMx += _loc2_.lverts.next.next.x * _loc3_;
                                 _loc2_.localCOMy += _loc2_.lverts.next.next.y * _loc3_;
                                 _loc3_ = 0.5;
                                 _loc2_.localCOMx *= _loc3_;
                                 _loc2_.localCOMy *= _loc3_;
                              }
                              else
                              {
                                 _loc2_.localCOMx = 0;
                                 _loc2_.localCOMy = 0;
                                 _loc3_ = 0;
                                 _loc4_ = _loc2_.lverts.next;
                                 _loc5_ = _loc4_;
                                 _loc4_ = _loc4_.next;
                                 _loc6_ = _loc4_;
                                 _loc4_ = _loc4_.next;
                                 while(_loc4_ != null)
                                 {
                                    _loc7_ = _loc4_;
                                    _loc3_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                                    _loc8_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                                    _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc8_;
                                    _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc8_;
                                    _loc5_ = _loc6_;
                                    _loc6_ = _loc7_;
                                    _loc4_ = _loc4_.next;
                                 }
                                 _loc4_ = _loc2_.lverts.next;
                                 _loc7_ = _loc4_;
                                 _loc3_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                                 _loc8_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                                 _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc8_;
                                 _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc8_;
                                 _loc5_ = _loc6_;
                                 _loc6_ = _loc7_;
                                 _loc4_ = _loc4_.next;
                                 _loc9_ = _loc4_;
                                 _loc3_ += _loc6_.x * (_loc9_.y - _loc5_.y);
                                 _loc8_ = _loc9_.y * _loc6_.x - _loc9_.x * _loc6_.y;
                                 _loc2_.localCOMx += (_loc6_.x + _loc9_.x) * _loc8_;
                                 _loc2_.localCOMy += (_loc6_.y + _loc9_.y) * _loc8_;
                                 _loc3_ = 1 / (3 * _loc3_);
                                 _loc8_ = _loc3_;
                                 _loc2_.localCOMx *= _loc8_;
                                 _loc2_.localCOMy *= _loc8_;
                              }
                           }
                        }
                        _loc10_ = _loc1_.body;
                        if(_loc10_.zip_axis)
                        {
                           _loc10_.zip_axis = false;
                           _loc10_.axisx = Math.sin(_loc10_.rot);
                           _loc10_.axisy = Math.cos(_loc10_.rot);
                        }
                        _loc1_.worldCOMx = _loc1_.body.posx + (_loc1_.body.axisy * _loc1_.localCOMx - _loc1_.body.axisx * _loc1_.localCOMy);
                        _loc1_.worldCOMy = _loc1_.body.posy + (_loc1_.localCOMx * _loc1_.body.axisx + _loc1_.localCOMy * _loc1_.body.axisy);
                     }
                  }
                  _loc3_ = _loc1_.radius;
                  _loc8_ = _loc1_.radius;
                  _loc1_.aabb.minx = _loc1_.worldCOMx - _loc3_;
                  _loc1_.aabb.miny = _loc1_.worldCOMy - _loc8_;
                  _loc1_.aabb.maxx = _loc1_.worldCOMx + _loc3_;
                  _loc1_.aabb.maxy = _loc1_.worldCOMy + _loc8_;
               }
               else
               {
                  _loc2_ = polygon;
                  if(_loc2_.zip_gverts)
                  {
                     if(_loc2_.body != null)
                     {
                        _loc2_.zip_gverts = false;
                        _loc2_.validate_lverts();
                        _loc10_ = _loc2_.body;
                        if(_loc10_.zip_axis)
                        {
                           _loc10_.zip_axis = false;
                           _loc10_.axisx = Math.sin(_loc10_.rot);
                           _loc10_.axisy = Math.cos(_loc10_.rot);
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
      }
      
      public function __immutable_midstep(param1:String) : void
      {
         if(body != null && body.space != null && body.space.midstep)
         {
            Boot.lastError = new Error();
            throw "Error: " + param1 + " cannot be set during a space step()";
         }
      }
   }
}
