package nape.util
{
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import nape.callbacks.CbTypeIterator;
   import nape.callbacks.ListenerIterator;
   import nape.constraint.ConstraintIterator;
   import nape.dynamics.ArbiterIterator;
   import nape.dynamics.ContactIterator;
   import nape.dynamics.InteractionGroupIterator;
   import nape.geom.AABB;
   import nape.geom.ConvexResultIterator;
   import nape.geom.GeomPoly;
   import nape.geom.GeomPolyIterator;
   import nape.geom.Mat23;
   import nape.geom.RayResultIterator;
   import nape.geom.Vec2;
   import nape.geom.Vec2Iterator;
   import nape.geom.Vec2List;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.phys.BodyIterator;
   import nape.phys.CompoundIterator;
   import nape.phys.InteractorIterator;
   import nape.shape.Circle;
   import nape.shape.EdgeIterator;
   import nape.shape.Polygon;
   import nape.shape.Shape;
   import nape.shape.ShapeIterator;
   import nape.shape.ShapeList;
   import zpp_nape.callbacks.ZPP_Callback;
   import zpp_nape.callbacks.ZPP_CbSet;
   import zpp_nape.callbacks.ZPP_CbSetPair;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.dynamics.ZPP_FluidArbiter;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.dynamics.ZPP_SensorArbiter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_CutInt;
   import zpp_nape.geom.ZPP_CutVert;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_GeomVertexIterator;
   import zpp_nape.geom.ZPP_MarchPair;
   import zpp_nape.geom.ZPP_MarchSpan;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_PartitionPair;
   import zpp_nape.geom.ZPP_PartitionVertex;
   import zpp_nape.geom.ZPP_PartitionedPoly;
   import zpp_nape.geom.ZPP_SimpleEvent;
   import zpp_nape.geom.ZPP_SimpleSeg;
   import zpp_nape.geom.ZPP_SimpleVert;
   import zpp_nape.geom.ZPP_SimplifyP;
   import zpp_nape.geom.ZPP_SimplifyV;
   import zpp_nape.geom.ZPP_ToiEvent;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_FluidProperties;
   import zpp_nape.phys.ZPP_Material;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.space.ZPP_AABBNode;
   import zpp_nape.space.ZPP_AABBPair;
   import zpp_nape.space.ZPP_CallbackSet;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.space.ZPP_Island;
   import zpp_nape.space.ZPP_SweepData;
   import zpp_nape.util.Hashable2_Boolfalse;
   import zpp_nape.util.ZNPNode_ConvexResult;
   import zpp_nape.util.ZNPNode_RayResult;
   import zpp_nape.util.ZNPNode_ZPP_AABBNode;
   import zpp_nape.util.ZNPNode_ZPP_AABBPair;
   import zpp_nape.util.ZNPNode_ZPP_Arbiter;
   import zpp_nape.util.ZNPNode_ZPP_Body;
   import zpp_nape.util.ZNPNode_ZPP_BodyListener;
   import zpp_nape.util.ZNPNode_ZPP_CallbackSet;
   import zpp_nape.util.ZNPNode_ZPP_CbSet;
   import zpp_nape.util.ZNPNode_ZPP_CbSetPair;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZNPNode_ZPP_ColArbiter;
   import zpp_nape.util.ZNPNode_ZPP_Component;
   import zpp_nape.util.ZNPNode_ZPP_Compound;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZNPNode_ZPP_ConstraintListener;
   import zpp_nape.util.ZNPNode_ZPP_CutInt;
   import zpp_nape.util.ZNPNode_ZPP_CutVert;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZNPNode_ZPP_FluidArbiter;
   import zpp_nape.util.ZNPNode_ZPP_GeomPoly;
   import zpp_nape.util.ZNPNode_ZPP_GeomVert;
   import zpp_nape.util.ZNPNode_ZPP_InteractionGroup;
   import zpp_nape.util.ZNPNode_ZPP_InteractionListener;
   import zpp_nape.util.ZNPNode_ZPP_Interactor;
   import zpp_nape.util.ZNPNode_ZPP_Listener;
   import zpp_nape.util.ZNPNode_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPNode_ZPP_PartitionedPoly;
   import zpp_nape.util.ZNPNode_ZPP_SensorArbiter;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_SimpleEvent;
   import zpp_nape.util.ZNPNode_ZPP_SimpleVert;
   import zpp_nape.util.ZNPNode_ZPP_SimplifyP;
   import zpp_nape.util.ZNPNode_ZPP_ToiEvent;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_Debug;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   import zpp_nape.util.ZPP_Set_ZPP_Body;
   import zpp_nape.util.ZPP_Set_ZPP_CbSet;
   import zpp_nape.util.ZPP_Set_ZPP_CbSetPair;
   import zpp_nape.util.ZPP_Set_ZPP_PartitionPair;
   import zpp_nape.util.ZPP_Set_ZPP_PartitionVertex;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleEvent;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleSeg;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleVert;
   
   public class Debug
   {
       
      
      public var zpp_inner:ZPP_Debug;
      
      public var drawShapeDetail:Boolean;
      
      public var drawShapeAngleIndicators:Boolean;
      
      public var drawSensorArbiters:Boolean;
      
      public var drawFluidArbiters:Boolean;
      
      public var drawConstraints:Boolean;
      
      public var drawCollisionArbiters:Boolean;
      
      public var drawBodyDetail:Boolean;
      
      public var drawBodies:Boolean;
      
      public var cullingEnabled:Boolean;
      
      public var colour:Object;
      
      public function Debug()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         cullingEnabled = false;
         colour = null;
         drawConstraints = false;
         drawShapeAngleIndicators = false;
         drawShapeDetail = false;
         drawBodyDetail = false;
         drawBodies = false;
         drawSensorArbiters = false;
         drawFluidArbiters = false;
         drawCollisionArbiters = false;
         zpp_inner = null;
         if(!ZPP_Debug.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate Debug derp! Use ShapeDebug, or BitmapDebug on flash10+";
         }
         drawCollisionArbiters = false;
         drawFluidArbiters = false;
         drawSensorArbiters = false;
         drawBodies = true;
         drawShapeAngleIndicators = true;
         drawBodyDetail = false;
         drawShapeDetail = false;
         drawConstraints = false;
         cullingEnabled = false;
         colour = null;
      }
      
      public static function version() : String
      {
         return "Nape 2.0.3";
      }
      
      public static function clearObjectPools() : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 2232
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      public static function createGraphic(param1:Body) : flash.display.Shape
      {
         var _loc10_:* = null as ShapeList;
         var _loc11_:* = null as nape.shape.Shape;
         var _loc12_:int = 0;
         var _loc13_:* = null as Circle;
         var _loc14_:* = null as Vec2;
         var _loc15_:* = null as ZPP_Vec2;
         var _loc16_:* = null as Polygon;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot create debug graphic for null Body";
         }
         var _loc2_:flash.display.Shape = new flash.display.Shape();
         var _loc3_:Graphics = _loc2_.graphics;
         var _loc4_:int = 16777215 * Math.exp(-param1.zpp_inner_i.id / 1500);
         var _loc5_:Number = ((_loc4_ & 16711680) >> 16) * 0.7;
         var _loc6_:Number = ((_loc4_ & 65280) >> 8) * 0.7;
         var _loc7_:Number = (_loc4_ & 255) * 0.7;
         var _loc8_:int = _loc5_ << 16 | _loc6_ << 8 | _loc7_;
         _loc3_.lineStyle(0.1,_loc8_,1);
         _loc10_ = param1.zpp_inner.wrap_shapes;
         _loc10_.zpp_inner.valmod();
         var _loc9_:ShapeIterator = ShapeIterator.get(_loc10_);
         while(true)
         {
            _loc9_.zpp_inner.zpp_inner.valmod();
            _loc10_ = _loc9_.zpp_inner;
            _loc10_.zpp_inner.valmod();
            if(_loc10_.zpp_inner.zip_length)
            {
               _loc10_.zpp_inner.zip_length = false;
               _loc10_.zpp_inner.user_length = _loc10_.zpp_inner.inner.length;
            }
            _loc12_ = _loc10_.zpp_inner.user_length;
            _loc9_.zpp_critical = true;
            if(!(_loc9_.zpp_i < _loc12_ ? true : (_loc9_.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc9_, _loc9_.zpp_inner = null, false)))
            {
               break;
            }
            _loc9_.zpp_critical = false;
            _loc9_.zpp_i = (_loc12_ = _loc9_.zpp_i) + 1;
            _loc11_ = _loc9_.zpp_inner.at(_loc12_);
            if(_loc11_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc13_ = _loc11_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE ? _loc11_.zpp_inner.circle.outer_zn : null;
               §§push(_loc3_);
               if(_loc13_.zpp_inner.wrap_localCOM == null)
               {
                  if(_loc13_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc13_.zpp_inner.circle.setupLocalCOM();
                  }
                  else
                  {
                     _loc13_.zpp_inner.polygon.setupLocalCOM();
                  }
               }
               _loc14_ = _loc13_.zpp_inner.wrap_localCOM;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§push(_loc14_.zpp_inner.x);
               if(_loc13_.zpp_inner.wrap_localCOM == null)
               {
                  if(_loc13_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc13_.zpp_inner.circle.setupLocalCOM();
                  }
                  else
                  {
                     _loc13_.zpp_inner.polygon.setupLocalCOM();
                  }
               }
               _loc14_ = _loc13_.zpp_inner.wrap_localCOM;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§pop().drawCircle(§§pop(),_loc14_.zpp_inner.y,_loc13_.zpp_inner_zn.radius);
            }
            else
            {
               _loc16_ = _loc11_.zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON ? _loc11_.zpp_inner.polygon.outer_zn : null;
               §§push(_loc3_);
               if(_loc11_.zpp_inner.wrap_localCOM == null)
               {
                  if(_loc11_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc11_.zpp_inner.circle.setupLocalCOM();
                  }
                  else
                  {
                     _loc11_.zpp_inner.polygon.setupLocalCOM();
                  }
               }
               _loc14_ = _loc11_.zpp_inner.wrap_localCOM;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§push(_loc14_.zpp_inner.x);
               if(_loc11_.zpp_inner.wrap_localCOM == null)
               {
                  if(_loc11_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc11_.zpp_inner.circle.setupLocalCOM();
                  }
                  else
                  {
                     _loc11_.zpp_inner.polygon.setupLocalCOM();
                  }
               }
               _loc14_ = _loc11_.zpp_inner.wrap_localCOM;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
               _loc12_ = 0;
               if(_loc16_.zpp_inner_zn.wrap_gverts == null)
               {
                  _loc16_.zpp_inner_zn.getgverts();
               }
               _loc17_ = _loc16_.zpp_inner_zn.wrap_gverts.zpp_gl();
               while(_loc12_ < _loc17_)
               {
                  _loc18_ = _loc12_++;
                  if(_loc16_.zpp_inner_zn.wrap_lverts == null)
                  {
                     _loc16_.zpp_inner_zn.getlverts();
                  }
                  _loc14_ = _loc16_.zpp_inner_zn.wrap_lverts.at(_loc18_);
                  §§push(_loc3_);
                  if(_loc14_ != null && _loc14_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc15_ = _loc14_.zpp_inner;
                  if(_loc15_._validate != null)
                  {
                     _loc15_._validate();
                  }
                  §§push(_loc14_.zpp_inner.x);
                  if(_loc14_ != null && _loc14_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc15_ = _loc14_.zpp_inner;
                  if(_loc15_._validate != null)
                  {
                     _loc15_._validate();
                  }
                  §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
               }
               if(_loc16_.zpp_inner_zn.wrap_lverts == null)
               {
                  _loc16_.zpp_inner_zn.getlverts();
               }
               _loc14_ = _loc16_.zpp_inner_zn.wrap_lverts.at(0);
               §§push(_loc3_);
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§push(_loc14_.zpp_inner.x);
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
            }
            if(_loc11_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc13_ = _loc11_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE ? _loc11_.zpp_inner.circle.outer_zn : null;
               §§push(_loc3_);
               if(_loc13_.zpp_inner.wrap_localCOM == null)
               {
                  if(_loc13_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc13_.zpp_inner.circle.setupLocalCOM();
                  }
                  else
                  {
                     _loc13_.zpp_inner.polygon.setupLocalCOM();
                  }
               }
               _loc14_ = _loc13_.zpp_inner.wrap_localCOM;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§push(_loc14_.zpp_inner.x + _loc13_.zpp_inner_zn.radius * 0.3);
               if(_loc13_.zpp_inner.wrap_localCOM == null)
               {
                  if(_loc13_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc13_.zpp_inner.circle.setupLocalCOM();
                  }
                  else
                  {
                     _loc13_.zpp_inner.polygon.setupLocalCOM();
                  }
               }
               _loc14_ = _loc13_.zpp_inner.wrap_localCOM;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§pop().moveTo(§§pop(),_loc14_.zpp_inner.y);
               §§push(_loc3_);
               if(_loc13_.zpp_inner.wrap_localCOM == null)
               {
                  if(_loc13_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc13_.zpp_inner.circle.setupLocalCOM();
                  }
                  else
                  {
                     _loc13_.zpp_inner.polygon.setupLocalCOM();
                  }
               }
               _loc14_ = _loc13_.zpp_inner.wrap_localCOM;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§push(_loc14_.zpp_inner.x + _loc13_.zpp_inner_zn.radius);
               if(_loc13_.zpp_inner.wrap_localCOM == null)
               {
                  if(_loc13_.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc13_.zpp_inner.circle.setupLocalCOM();
                  }
                  else
                  {
                     _loc13_.zpp_inner.polygon.setupLocalCOM();
                  }
               }
               _loc14_ = _loc13_.zpp_inner.wrap_localCOM;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc15_ = _loc14_.zpp_inner;
               if(_loc15_._validate != null)
               {
                  _loc15_._validate();
               }
               §§pop().lineTo(§§pop(),_loc14_.zpp_inner.y);
            }
         }
         return _loc2_;
      }
      
      public function set transform(param1:Mat23) : Mat23
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set Debug::transform to null";
         }
         if(zpp_inner.xform == null)
         {
            zpp_inner.setform();
         }
         zpp_inner.xform.outer.set(param1);
         if(zpp_inner.xform == null)
         {
            zpp_inner.setform();
         }
         return zpp_inner.xform.outer;
      }
      
      public function set bgColour(param1:int) : int
      {
         if(zpp_inner.isbmp)
         {
            zpp_inner.d_bmp.setbg(param1);
         }
         else
         {
            zpp_inner.d_shape.setbg(param1);
         }
         return zpp_inner.bg_col;
      }
      
      public function get transform() : Mat23
      {
         if(zpp_inner.xform == null)
         {
            zpp_inner.setform();
         }
         return zpp_inner.xform.outer;
      }
      
      public function get display() : DisplayObject
      {
         var _loc1_:* = null as DisplayObject;
         if(zpp_inner.isbmp)
         {
            _loc1_ = zpp_inner.d_bmp.bitmap;
         }
         else
         {
            _loc1_ = zpp_inner.d_shape.shape;
         }
         return _loc1_;
      }
      
      public function get bgColour() : int
      {
         return zpp_inner.bg_col;
      }
      
      public function flush() : void
      {
      }
      
      public function drawSpring(param1:Vec2, param2:Vec2, param3:int, param4:int = 3, param5:Number = 3) : void
      {
      }
      
      public function drawPolygon(param1:*, param2:int) : void
      {
      }
      
      public function drawLine(param1:Vec2, param2:Vec2, param3:int) : void
      {
      }
      
      public function drawFilledTriangle(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
      }
      
      public function drawFilledPolygon(param1:*, param2:int) : void
      {
      }
      
      public function drawFilledCircle(param1:Vec2, param2:Number, param3:int) : void
      {
      }
      
      public function drawCurve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
      }
      
      public function drawCircle(param1:Vec2, param2:Number, param3:int) : void
      {
      }
      
      public function drawAABB(param1:AABB, param2:int) : void
      {
      }
      
      public function draw(param1:*) : void
      {
      }
      
      public function clear() : void
      {
      }
   }
}
