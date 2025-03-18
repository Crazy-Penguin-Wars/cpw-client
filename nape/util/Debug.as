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
         var _loc1_:* = null as ConstraintIterator;
         var _loc2_:* = null as InteractorIterator;
         var _loc3_:* = null as BodyIterator;
         var _loc4_:* = null as CompoundIterator;
         var _loc5_:* = null as ListenerIterator;
         var _loc6_:* = null as CbTypeIterator;
         var _loc7_:* = null as ConvexResultIterator;
         var _loc8_:* = null as GeomPolyIterator;
         var _loc9_:* = null as Vec2Iterator;
         var _loc10_:* = null as RayResultIterator;
         var _loc11_:* = null as ShapeIterator;
         var _loc12_:* = null as EdgeIterator;
         var _loc13_:* = null as ContactIterator;
         var _loc14_:* = null as ArbiterIterator;
         var _loc15_:* = null as InteractionGroupIterator;
         var _loc16_:* = null as ZNPNode_ZPP_CbType;
         var _loc17_:* = null as ZNPNode_ZPP_CallbackSet;
         var _loc18_:* = null as ZPP_Material;
         var _loc19_:* = null as ZNPNode_ZPP_Shape;
         var _loc20_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc21_:* = null as ZNPNode_ZPP_Constraint;
         var _loc22_:* = null as ZNPNode_ZPP_Body;
         var _loc23_:* = null as ZPP_Set_ZPP_Body;
         var _loc24_:* = null as ZPP_FluidProperties;
         var _loc25_:* = null as ZNPNode_ZPP_Compound;
         var _loc26_:* = null as ZPP_CbSetPair;
         var _loc27_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc28_:* = null as ZNPNode_ZPP_CbSet;
         var _loc29_:* = null as ZPP_Callback;
         var _loc30_:* = null as ZNPNode_ZPP_Interactor;
         var _loc31_:* = null as ZPP_Set_ZPP_CbSetPair;
         var _loc32_:* = null as ZNPNode_ZPP_BodyListener;
         var _loc33_:* = null as ZPP_CbSet;
         var _loc34_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc35_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc36_:* = null as ZPP_Mat23;
         var _loc37_:* = null as ZPP_GeomVert;
         var _loc38_:* = null as ZPP_CutVert;
         var _loc39_:* = null as ZPP_GeomVertexIterator;
         var _loc40_:* = null as ZPP_CutInt;
         var _loc41_:* = null as ZPP_Vec2;
         var _loc42_:* = null as ZNPNode_ZPP_CutInt;
         var _loc43_:* = null as ZNPNode_ZPP_CutVert;
         var _loc44_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc45_:* = null as ZPP_PartitionVertex;
         var _loc46_:* = null as ZPP_Set_ZPP_PartitionVertex;
         var _loc47_:* = null as ZPP_PartitionPair;
         var _loc48_:* = null as ZPP_PartitionedPoly;
         var _loc49_:* = null as ZNPNode_ZPP_PartitionedPoly;
         var _loc50_:* = null as ZPP_Set_ZPP_PartitionPair;
         var _loc51_:* = null as ZNPNode_ZPP_GeomVert;
         var _loc52_:* = null as ZPP_SimplifyV;
         var _loc53_:* = null as ZPP_SimplifyP;
         var _loc54_:* = null as ZNPNode_ZPP_SimplifyP;
         var _loc55_:* = null as ZPP_AABB;
         var _loc56_:* = null as ZPP_Set_ZPP_SimpleVert;
         var _loc57_:* = null as ZPP_SimpleVert;
         var _loc58_:* = null as ZPP_SimpleSeg;
         var _loc59_:* = null as ZPP_Set_ZPP_SimpleSeg;
         var _loc60_:* = null as ZPP_Set_ZPP_SimpleEvent;
         var _loc61_:* = null as ZPP_SimpleEvent;
         var _loc62_:* = null as Hashable2_Boolfalse;
         var _loc63_:* = null as ZPP_ToiEvent;
         var _loc64_:* = null as ZNPNode_ZPP_SimpleVert;
         var _loc65_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc66_:* = null as ZPP_MarchSpan;
         var _loc67_:* = null as ZPP_MarchPair;
         var _loc68_:* = null as ZNPNode_ZPP_Vec2;
         var _loc69_:* = null as ZPP_Edge;
         var _loc70_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc71_:* = null as ZNPNode_ZPP_Edge;
         var _loc72_:* = null as ZPP_SweepData;
         var _loc73_:* = null as ZPP_AABBNode;
         var _loc74_:* = null as ZPP_AABBPair;
         var _loc75_:* = null as ZPP_Contact;
         var _loc76_:* = null as ZNPNode_ZPP_AABBNode;
         var _loc77_:* = null as ZNPNode_ZPP_Component;
         var _loc78_:* = null as ZPP_Island;
         var _loc79_:* = null as ZPP_Component;
         var _loc80_:* = null as ZPP_CallbackSet;
         var _loc81_:* = null as ZNPNode_ZPP_InteractionGroup;
         var _loc82_:* = null as ZPP_Set_ZPP_CbSet;
         var _loc83_:* = null as ZPP_InteractionFilter;
         var _loc84_:* = null as ZPP_SensorArbiter;
         var _loc85_:* = null as ZPP_FluidArbiter;
         var _loc86_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc87_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc88_:* = null as ZNPNode_ZPP_Listener;
         var _loc89_:* = null as ZPP_ColArbiter;
         var _loc90_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc91_:* = null as ZNPNode_ZPP_ToiEvent;
         var _loc92_:* = null as ZNPNode_ConvexResult;
         var _loc93_:* = null as ZNPNode_ZPP_GeomPoly;
         var _loc94_:* = null as ZNPNode_RayResult;
         var _loc95_:* = null as GeomPoly;
         var _loc96_:* = null as Vec2;
         var _loc97_:* = null as Vec3;
         while(ConstraintIterator.zpp_pool != null)
         {
            _loc1_ = ConstraintIterator.zpp_pool.zpp_next;
            ConstraintIterator.zpp_pool.zpp_next = null;
            ConstraintIterator.zpp_pool = _loc1_;
         }
         while(InteractorIterator.zpp_pool != null)
         {
            _loc2_ = InteractorIterator.zpp_pool.zpp_next;
            InteractorIterator.zpp_pool.zpp_next = null;
            InteractorIterator.zpp_pool = _loc2_;
         }
         while(BodyIterator.zpp_pool != null)
         {
            _loc3_ = BodyIterator.zpp_pool.zpp_next;
            BodyIterator.zpp_pool.zpp_next = null;
            BodyIterator.zpp_pool = _loc3_;
         }
         while(CompoundIterator.zpp_pool != null)
         {
            _loc4_ = CompoundIterator.zpp_pool.zpp_next;
            CompoundIterator.zpp_pool.zpp_next = null;
            CompoundIterator.zpp_pool = _loc4_;
         }
         while(ListenerIterator.zpp_pool != null)
         {
            _loc5_ = ListenerIterator.zpp_pool.zpp_next;
            ListenerIterator.zpp_pool.zpp_next = null;
            ListenerIterator.zpp_pool = _loc5_;
         }
         while(CbTypeIterator.zpp_pool != null)
         {
            _loc6_ = CbTypeIterator.zpp_pool.zpp_next;
            CbTypeIterator.zpp_pool.zpp_next = null;
            CbTypeIterator.zpp_pool = _loc6_;
         }
         while(ConvexResultIterator.zpp_pool != null)
         {
            _loc7_ = ConvexResultIterator.zpp_pool.zpp_next;
            ConvexResultIterator.zpp_pool.zpp_next = null;
            ConvexResultIterator.zpp_pool = _loc7_;
         }
         while(GeomPolyIterator.zpp_pool != null)
         {
            _loc8_ = GeomPolyIterator.zpp_pool.zpp_next;
            GeomPolyIterator.zpp_pool.zpp_next = null;
            GeomPolyIterator.zpp_pool = _loc8_;
         }
         while(Vec2Iterator.zpp_pool != null)
         {
            _loc9_ = Vec2Iterator.zpp_pool.zpp_next;
            Vec2Iterator.zpp_pool.zpp_next = null;
            Vec2Iterator.zpp_pool = _loc9_;
         }
         while(RayResultIterator.zpp_pool != null)
         {
            _loc10_ = RayResultIterator.zpp_pool.zpp_next;
            RayResultIterator.zpp_pool.zpp_next = null;
            RayResultIterator.zpp_pool = _loc10_;
         }
         while(ShapeIterator.zpp_pool != null)
         {
            _loc11_ = ShapeIterator.zpp_pool.zpp_next;
            ShapeIterator.zpp_pool.zpp_next = null;
            ShapeIterator.zpp_pool = _loc11_;
         }
         while(EdgeIterator.zpp_pool != null)
         {
            _loc12_ = EdgeIterator.zpp_pool.zpp_next;
            EdgeIterator.zpp_pool.zpp_next = null;
            EdgeIterator.zpp_pool = _loc12_;
         }
         while(ContactIterator.zpp_pool != null)
         {
            _loc13_ = ContactIterator.zpp_pool.zpp_next;
            ContactIterator.zpp_pool.zpp_next = null;
            ContactIterator.zpp_pool = _loc13_;
         }
         while(ArbiterIterator.zpp_pool != null)
         {
            _loc14_ = ArbiterIterator.zpp_pool.zpp_next;
            ArbiterIterator.zpp_pool.zpp_next = null;
            ArbiterIterator.zpp_pool = _loc14_;
         }
         while(InteractionGroupIterator.zpp_pool != null)
         {
            _loc15_ = InteractionGroupIterator.zpp_pool.zpp_next;
            InteractionGroupIterator.zpp_pool.zpp_next = null;
            InteractionGroupIterator.zpp_pool = _loc15_;
         }
         while(ZNPNode_ZPP_CbType.zpp_pool != null)
         {
            _loc16_ = ZNPNode_ZPP_CbType.zpp_pool.next;
            ZNPNode_ZPP_CbType.zpp_pool.next = null;
            ZNPNode_ZPP_CbType.zpp_pool = _loc16_;
         }
         while(ZNPNode_ZPP_CallbackSet.zpp_pool != null)
         {
            _loc17_ = ZNPNode_ZPP_CallbackSet.zpp_pool.next;
            ZNPNode_ZPP_CallbackSet.zpp_pool.next = null;
            ZNPNode_ZPP_CallbackSet.zpp_pool = _loc17_;
         }
         while(ZPP_Material.zpp_pool != null)
         {
            _loc18_ = ZPP_Material.zpp_pool.next;
            ZPP_Material.zpp_pool.next = null;
            ZPP_Material.zpp_pool = _loc18_;
         }
         while(ZNPNode_ZPP_Shape.zpp_pool != null)
         {
            _loc19_ = ZNPNode_ZPP_Shape.zpp_pool.next;
            ZNPNode_ZPP_Shape.zpp_pool.next = null;
            ZNPNode_ZPP_Shape.zpp_pool = _loc19_;
         }
         while(ZNPNode_ZPP_Arbiter.zpp_pool != null)
         {
            _loc20_ = ZNPNode_ZPP_Arbiter.zpp_pool.next;
            ZNPNode_ZPP_Arbiter.zpp_pool.next = null;
            ZNPNode_ZPP_Arbiter.zpp_pool = _loc20_;
         }
         while(ZNPNode_ZPP_Constraint.zpp_pool != null)
         {
            _loc21_ = ZNPNode_ZPP_Constraint.zpp_pool.next;
            ZNPNode_ZPP_Constraint.zpp_pool.next = null;
            ZNPNode_ZPP_Constraint.zpp_pool = _loc21_;
         }
         while(ZNPNode_ZPP_Body.zpp_pool != null)
         {
            _loc22_ = ZNPNode_ZPP_Body.zpp_pool.next;
            ZNPNode_ZPP_Body.zpp_pool.next = null;
            ZNPNode_ZPP_Body.zpp_pool = _loc22_;
         }
         while(ZPP_Set_ZPP_Body.zpp_pool != null)
         {
            _loc23_ = ZPP_Set_ZPP_Body.zpp_pool.next;
            ZPP_Set_ZPP_Body.zpp_pool.next = null;
            ZPP_Set_ZPP_Body.zpp_pool = _loc23_;
         }
         while(ZPP_FluidProperties.zpp_pool != null)
         {
            _loc24_ = ZPP_FluidProperties.zpp_pool.next;
            ZPP_FluidProperties.zpp_pool.next = null;
            ZPP_FluidProperties.zpp_pool = _loc24_;
         }
         while(ZNPNode_ZPP_Compound.zpp_pool != null)
         {
            _loc25_ = ZNPNode_ZPP_Compound.zpp_pool.next;
            ZNPNode_ZPP_Compound.zpp_pool.next = null;
            ZNPNode_ZPP_Compound.zpp_pool = _loc25_;
         }
         while(ZPP_CbSetPair.zpp_pool != null)
         {
            _loc26_ = ZPP_CbSetPair.zpp_pool.next;
            ZPP_CbSetPair.zpp_pool.next = null;
            ZPP_CbSetPair.zpp_pool = _loc26_;
         }
         while(ZNPNode_ZPP_InteractionListener.zpp_pool != null)
         {
            _loc27_ = ZNPNode_ZPP_InteractionListener.zpp_pool.next;
            ZNPNode_ZPP_InteractionListener.zpp_pool.next = null;
            ZNPNode_ZPP_InteractionListener.zpp_pool = _loc27_;
         }
         while(ZNPNode_ZPP_CbSet.zpp_pool != null)
         {
            _loc28_ = ZNPNode_ZPP_CbSet.zpp_pool.next;
            ZNPNode_ZPP_CbSet.zpp_pool.next = null;
            ZNPNode_ZPP_CbSet.zpp_pool = _loc28_;
         }
         while(ZPP_Callback.zpp_pool != null)
         {
            _loc29_ = ZPP_Callback.zpp_pool.next;
            ZPP_Callback.zpp_pool.next = null;
            ZPP_Callback.zpp_pool = _loc29_;
         }
         while(ZNPNode_ZPP_Interactor.zpp_pool != null)
         {
            _loc30_ = ZNPNode_ZPP_Interactor.zpp_pool.next;
            ZNPNode_ZPP_Interactor.zpp_pool.next = null;
            ZNPNode_ZPP_Interactor.zpp_pool = _loc30_;
         }
         while(ZPP_Set_ZPP_CbSetPair.zpp_pool != null)
         {
            _loc31_ = ZPP_Set_ZPP_CbSetPair.zpp_pool.next;
            ZPP_Set_ZPP_CbSetPair.zpp_pool.next = null;
            ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc31_;
         }
         while(ZNPNode_ZPP_BodyListener.zpp_pool != null)
         {
            _loc32_ = ZNPNode_ZPP_BodyListener.zpp_pool.next;
            ZNPNode_ZPP_BodyListener.zpp_pool.next = null;
            ZNPNode_ZPP_BodyListener.zpp_pool = _loc32_;
         }
         while(ZPP_CbSet.zpp_pool != null)
         {
            _loc33_ = ZPP_CbSet.zpp_pool.next;
            ZPP_CbSet.zpp_pool.next = null;
            ZPP_CbSet.zpp_pool = _loc33_;
         }
         while(ZNPNode_ZPP_CbSetPair.zpp_pool != null)
         {
            _loc34_ = ZNPNode_ZPP_CbSetPair.zpp_pool.next;
            ZNPNode_ZPP_CbSetPair.zpp_pool.next = null;
            ZNPNode_ZPP_CbSetPair.zpp_pool = _loc34_;
         }
         while(ZNPNode_ZPP_ConstraintListener.zpp_pool != null)
         {
            _loc35_ = ZNPNode_ZPP_ConstraintListener.zpp_pool.next;
            ZNPNode_ZPP_ConstraintListener.zpp_pool.next = null;
            ZNPNode_ZPP_ConstraintListener.zpp_pool = _loc35_;
         }
         while(ZPP_Mat23.zpp_pool != null)
         {
            _loc36_ = ZPP_Mat23.zpp_pool.next;
            ZPP_Mat23.zpp_pool.next = null;
            ZPP_Mat23.zpp_pool = _loc36_;
         }
         while(ZPP_GeomVert.zpp_pool != null)
         {
            _loc37_ = ZPP_GeomVert.zpp_pool.next;
            ZPP_GeomVert.zpp_pool.next = null;
            ZPP_GeomVert.zpp_pool = _loc37_;
         }
         while(ZPP_CutVert.zpp_pool != null)
         {
            _loc38_ = ZPP_CutVert.zpp_pool.next;
            ZPP_CutVert.zpp_pool.next = null;
            ZPP_CutVert.zpp_pool = _loc38_;
         }
         while(ZPP_GeomVertexIterator.zpp_pool != null)
         {
            _loc39_ = ZPP_GeomVertexIterator.zpp_pool.next;
            ZPP_GeomVertexIterator.zpp_pool.next = null;
            ZPP_GeomVertexIterator.zpp_pool = _loc39_;
         }
         while(ZPP_CutInt.zpp_pool != null)
         {
            _loc40_ = ZPP_CutInt.zpp_pool.next;
            ZPP_CutInt.zpp_pool.next = null;
            ZPP_CutInt.zpp_pool = _loc40_;
         }
         while(ZPP_Vec2.zpp_pool != null)
         {
            _loc41_ = ZPP_Vec2.zpp_pool.next;
            ZPP_Vec2.zpp_pool.next = null;
            ZPP_Vec2.zpp_pool = _loc41_;
         }
         while(ZNPNode_ZPP_CutInt.zpp_pool != null)
         {
            _loc42_ = ZNPNode_ZPP_CutInt.zpp_pool.next;
            ZNPNode_ZPP_CutInt.zpp_pool.next = null;
            ZNPNode_ZPP_CutInt.zpp_pool = _loc42_;
         }
         while(ZNPNode_ZPP_CutVert.zpp_pool != null)
         {
            _loc43_ = ZNPNode_ZPP_CutVert.zpp_pool.next;
            ZNPNode_ZPP_CutVert.zpp_pool.next = null;
            ZNPNode_ZPP_CutVert.zpp_pool = _loc43_;
         }
         while(ZNPNode_ZPP_PartitionVertex.zpp_pool != null)
         {
            _loc44_ = ZNPNode_ZPP_PartitionVertex.zpp_pool.next;
            ZNPNode_ZPP_PartitionVertex.zpp_pool.next = null;
            ZNPNode_ZPP_PartitionVertex.zpp_pool = _loc44_;
         }
         while(ZPP_PartitionVertex.zpp_pool != null)
         {
            _loc45_ = ZPP_PartitionVertex.zpp_pool.next;
            ZPP_PartitionVertex.zpp_pool.next = null;
            ZPP_PartitionVertex.zpp_pool = _loc45_;
         }
         while(ZPP_Set_ZPP_PartitionVertex.zpp_pool != null)
         {
            _loc46_ = ZPP_Set_ZPP_PartitionVertex.zpp_pool.next;
            ZPP_Set_ZPP_PartitionVertex.zpp_pool.next = null;
            ZPP_Set_ZPP_PartitionVertex.zpp_pool = _loc46_;
         }
         while(ZPP_PartitionPair.zpp_pool != null)
         {
            _loc47_ = ZPP_PartitionPair.zpp_pool.next;
            ZPP_PartitionPair.zpp_pool.next = null;
            ZPP_PartitionPair.zpp_pool = _loc47_;
         }
         while(ZPP_PartitionedPoly.zpp_pool != null)
         {
            _loc48_ = ZPP_PartitionedPoly.zpp_pool.next;
            ZPP_PartitionedPoly.zpp_pool.next = null;
            ZPP_PartitionedPoly.zpp_pool = _loc48_;
         }
         while(ZNPNode_ZPP_PartitionedPoly.zpp_pool != null)
         {
            _loc49_ = ZNPNode_ZPP_PartitionedPoly.zpp_pool.next;
            ZNPNode_ZPP_PartitionedPoly.zpp_pool.next = null;
            ZNPNode_ZPP_PartitionedPoly.zpp_pool = _loc49_;
         }
         while(ZPP_Set_ZPP_PartitionPair.zpp_pool != null)
         {
            _loc50_ = ZPP_Set_ZPP_PartitionPair.zpp_pool.next;
            ZPP_Set_ZPP_PartitionPair.zpp_pool.next = null;
            ZPP_Set_ZPP_PartitionPair.zpp_pool = _loc50_;
         }
         while(ZNPNode_ZPP_GeomVert.zpp_pool != null)
         {
            _loc51_ = ZNPNode_ZPP_GeomVert.zpp_pool.next;
            ZNPNode_ZPP_GeomVert.zpp_pool.next = null;
            ZNPNode_ZPP_GeomVert.zpp_pool = _loc51_;
         }
         while(ZPP_SimplifyV.zpp_pool != null)
         {
            _loc52_ = ZPP_SimplifyV.zpp_pool.next;
            ZPP_SimplifyV.zpp_pool.next = null;
            ZPP_SimplifyV.zpp_pool = _loc52_;
         }
         while(ZPP_SimplifyP.zpp_pool != null)
         {
            _loc53_ = ZPP_SimplifyP.zpp_pool.next;
            ZPP_SimplifyP.zpp_pool.next = null;
            ZPP_SimplifyP.zpp_pool = _loc53_;
         }
         while(ZNPNode_ZPP_SimplifyP.zpp_pool != null)
         {
            _loc54_ = ZNPNode_ZPP_SimplifyP.zpp_pool.next;
            ZNPNode_ZPP_SimplifyP.zpp_pool.next = null;
            ZNPNode_ZPP_SimplifyP.zpp_pool = _loc54_;
         }
         while(ZPP_AABB.zpp_pool != null)
         {
            _loc55_ = ZPP_AABB.zpp_pool.next;
            ZPP_AABB.zpp_pool.next = null;
            ZPP_AABB.zpp_pool = _loc55_;
         }
         while(ZPP_Set_ZPP_SimpleVert.zpp_pool != null)
         {
            _loc56_ = ZPP_Set_ZPP_SimpleVert.zpp_pool.next;
            ZPP_Set_ZPP_SimpleVert.zpp_pool.next = null;
            ZPP_Set_ZPP_SimpleVert.zpp_pool = _loc56_;
         }
         while(ZPP_SimpleVert.zpp_pool != null)
         {
            _loc57_ = ZPP_SimpleVert.zpp_pool.next;
            ZPP_SimpleVert.zpp_pool.next = null;
            ZPP_SimpleVert.zpp_pool = _loc57_;
         }
         while(ZPP_SimpleSeg.zpp_pool != null)
         {
            _loc58_ = ZPP_SimpleSeg.zpp_pool.next;
            ZPP_SimpleSeg.zpp_pool.next = null;
            ZPP_SimpleSeg.zpp_pool = _loc58_;
         }
         while(ZPP_Set_ZPP_SimpleSeg.zpp_pool != null)
         {
            _loc59_ = ZPP_Set_ZPP_SimpleSeg.zpp_pool.next;
            ZPP_Set_ZPP_SimpleSeg.zpp_pool.next = null;
            ZPP_Set_ZPP_SimpleSeg.zpp_pool = _loc59_;
         }
         while(ZPP_Set_ZPP_SimpleEvent.zpp_pool != null)
         {
            _loc60_ = ZPP_Set_ZPP_SimpleEvent.zpp_pool.next;
            ZPP_Set_ZPP_SimpleEvent.zpp_pool.next = null;
            ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc60_;
         }
         while(ZPP_SimpleEvent.zpp_pool != null)
         {
            _loc61_ = ZPP_SimpleEvent.zpp_pool.next;
            ZPP_SimpleEvent.zpp_pool.next = null;
            ZPP_SimpleEvent.zpp_pool = _loc61_;
         }
         while(Hashable2_Boolfalse.zpp_pool != null)
         {
            _loc62_ = Hashable2_Boolfalse.zpp_pool.next;
            Hashable2_Boolfalse.zpp_pool.next = null;
            Hashable2_Boolfalse.zpp_pool = _loc62_;
         }
         while(ZPP_ToiEvent.zpp_pool != null)
         {
            _loc63_ = ZPP_ToiEvent.zpp_pool.next;
            ZPP_ToiEvent.zpp_pool.next = null;
            ZPP_ToiEvent.zpp_pool = _loc63_;
         }
         while(ZNPNode_ZPP_SimpleVert.zpp_pool != null)
         {
            _loc64_ = ZNPNode_ZPP_SimpleVert.zpp_pool.next;
            ZNPNode_ZPP_SimpleVert.zpp_pool.next = null;
            ZNPNode_ZPP_SimpleVert.zpp_pool = _loc64_;
         }
         while(ZNPNode_ZPP_SimpleEvent.zpp_pool != null)
         {
            _loc65_ = ZNPNode_ZPP_SimpleEvent.zpp_pool.next;
            ZNPNode_ZPP_SimpleEvent.zpp_pool.next = null;
            ZNPNode_ZPP_SimpleEvent.zpp_pool = _loc65_;
         }
         while(ZPP_MarchSpan.zpp_pool != null)
         {
            _loc66_ = ZPP_MarchSpan.zpp_pool.next;
            ZPP_MarchSpan.zpp_pool.next = null;
            ZPP_MarchSpan.zpp_pool = _loc66_;
         }
         while(ZPP_MarchPair.zpp_pool != null)
         {
            _loc67_ = ZPP_MarchPair.zpp_pool.next;
            ZPP_MarchPair.zpp_pool.next = null;
            ZPP_MarchPair.zpp_pool = _loc67_;
         }
         while(ZNPNode_ZPP_Vec2.zpp_pool != null)
         {
            _loc68_ = ZNPNode_ZPP_Vec2.zpp_pool.next;
            ZNPNode_ZPP_Vec2.zpp_pool.next = null;
            ZNPNode_ZPP_Vec2.zpp_pool = _loc68_;
         }
         while(ZPP_Edge.zpp_pool != null)
         {
            _loc69_ = ZPP_Edge.zpp_pool.next;
            ZPP_Edge.zpp_pool.next = null;
            ZPP_Edge.zpp_pool = _loc69_;
         }
         while(ZNPNode_ZPP_AABBPair.zpp_pool != null)
         {
            _loc70_ = ZNPNode_ZPP_AABBPair.zpp_pool.next;
            ZNPNode_ZPP_AABBPair.zpp_pool.next = null;
            ZNPNode_ZPP_AABBPair.zpp_pool = _loc70_;
         }
         while(ZNPNode_ZPP_Edge.zpp_pool != null)
         {
            _loc71_ = ZNPNode_ZPP_Edge.zpp_pool.next;
            ZNPNode_ZPP_Edge.zpp_pool.next = null;
            ZNPNode_ZPP_Edge.zpp_pool = _loc71_;
         }
         while(ZPP_SweepData.zpp_pool != null)
         {
            _loc72_ = ZPP_SweepData.zpp_pool.next;
            ZPP_SweepData.zpp_pool.next = null;
            ZPP_SweepData.zpp_pool = _loc72_;
         }
         while(ZPP_AABBNode.zpp_pool != null)
         {
            _loc73_ = ZPP_AABBNode.zpp_pool.next;
            ZPP_AABBNode.zpp_pool.next = null;
            ZPP_AABBNode.zpp_pool = _loc73_;
         }
         while(ZPP_AABBPair.zpp_pool != null)
         {
            _loc74_ = ZPP_AABBPair.zpp_pool.next;
            ZPP_AABBPair.zpp_pool.next = null;
            ZPP_AABBPair.zpp_pool = _loc74_;
         }
         while(ZPP_Contact.zpp_pool != null)
         {
            _loc75_ = ZPP_Contact.zpp_pool.next;
            ZPP_Contact.zpp_pool.next = null;
            ZPP_Contact.zpp_pool = _loc75_;
         }
         while(ZNPNode_ZPP_AABBNode.zpp_pool != null)
         {
            _loc76_ = ZNPNode_ZPP_AABBNode.zpp_pool.next;
            ZNPNode_ZPP_AABBNode.zpp_pool.next = null;
            ZNPNode_ZPP_AABBNode.zpp_pool = _loc76_;
         }
         while(ZNPNode_ZPP_Component.zpp_pool != null)
         {
            _loc77_ = ZNPNode_ZPP_Component.zpp_pool.next;
            ZNPNode_ZPP_Component.zpp_pool.next = null;
            ZNPNode_ZPP_Component.zpp_pool = _loc77_;
         }
         while(ZPP_Island.zpp_pool != null)
         {
            _loc78_ = ZPP_Island.zpp_pool.next;
            ZPP_Island.zpp_pool.next = null;
            ZPP_Island.zpp_pool = _loc78_;
         }
         while(ZPP_Component.zpp_pool != null)
         {
            _loc79_ = ZPP_Component.zpp_pool.next;
            ZPP_Component.zpp_pool.next = null;
            ZPP_Component.zpp_pool = _loc79_;
         }
         while(ZPP_CallbackSet.zpp_pool != null)
         {
            _loc80_ = ZPP_CallbackSet.zpp_pool.next;
            ZPP_CallbackSet.zpp_pool.next = null;
            ZPP_CallbackSet.zpp_pool = _loc80_;
         }
         while(ZNPNode_ZPP_InteractionGroup.zpp_pool != null)
         {
            _loc81_ = ZNPNode_ZPP_InteractionGroup.zpp_pool.next;
            ZNPNode_ZPP_InteractionGroup.zpp_pool.next = null;
            ZNPNode_ZPP_InteractionGroup.zpp_pool = _loc81_;
         }
         while(ZPP_Set_ZPP_CbSet.zpp_pool != null)
         {
            _loc82_ = ZPP_Set_ZPP_CbSet.zpp_pool.next;
            ZPP_Set_ZPP_CbSet.zpp_pool.next = null;
            ZPP_Set_ZPP_CbSet.zpp_pool = _loc82_;
         }
         while(ZPP_InteractionFilter.zpp_pool != null)
         {
            _loc83_ = ZPP_InteractionFilter.zpp_pool.next;
            ZPP_InteractionFilter.zpp_pool.next = null;
            ZPP_InteractionFilter.zpp_pool = _loc83_;
         }
         while(ZPP_SensorArbiter.zpp_pool != null)
         {
            _loc84_ = ZPP_SensorArbiter.zpp_pool.next;
            ZPP_SensorArbiter.zpp_pool.next = null;
            ZPP_SensorArbiter.zpp_pool = _loc84_;
         }
         while(ZPP_FluidArbiter.zpp_pool != null)
         {
            _loc85_ = ZPP_FluidArbiter.zpp_pool.next;
            ZPP_FluidArbiter.zpp_pool.next = null;
            ZPP_FluidArbiter.zpp_pool = _loc85_;
         }
         while(ZNPNode_ZPP_FluidArbiter.zpp_pool != null)
         {
            _loc86_ = ZNPNode_ZPP_FluidArbiter.zpp_pool.next;
            ZNPNode_ZPP_FluidArbiter.zpp_pool.next = null;
            ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc86_;
         }
         while(ZNPNode_ZPP_SensorArbiter.zpp_pool != null)
         {
            _loc87_ = ZNPNode_ZPP_SensorArbiter.zpp_pool.next;
            ZNPNode_ZPP_SensorArbiter.zpp_pool.next = null;
            ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc87_;
         }
         while(ZNPNode_ZPP_Listener.zpp_pool != null)
         {
            _loc88_ = ZNPNode_ZPP_Listener.zpp_pool.next;
            ZNPNode_ZPP_Listener.zpp_pool.next = null;
            ZNPNode_ZPP_Listener.zpp_pool = _loc88_;
         }
         while(ZPP_ColArbiter.zpp_pool != null)
         {
            _loc89_ = ZPP_ColArbiter.zpp_pool.next;
            ZPP_ColArbiter.zpp_pool.next = null;
            ZPP_ColArbiter.zpp_pool = _loc89_;
         }
         while(ZNPNode_ZPP_ColArbiter.zpp_pool != null)
         {
            _loc90_ = ZNPNode_ZPP_ColArbiter.zpp_pool.next;
            ZNPNode_ZPP_ColArbiter.zpp_pool.next = null;
            ZNPNode_ZPP_ColArbiter.zpp_pool = _loc90_;
         }
         while(ZNPNode_ZPP_ToiEvent.zpp_pool != null)
         {
            _loc91_ = ZNPNode_ZPP_ToiEvent.zpp_pool.next;
            ZNPNode_ZPP_ToiEvent.zpp_pool.next = null;
            ZNPNode_ZPP_ToiEvent.zpp_pool = _loc91_;
         }
         while(ZNPNode_ConvexResult.zpp_pool != null)
         {
            _loc92_ = ZNPNode_ConvexResult.zpp_pool.next;
            ZNPNode_ConvexResult.zpp_pool.next = null;
            ZNPNode_ConvexResult.zpp_pool = _loc92_;
         }
         while(ZNPNode_ZPP_GeomPoly.zpp_pool != null)
         {
            _loc93_ = ZNPNode_ZPP_GeomPoly.zpp_pool.next;
            ZNPNode_ZPP_GeomPoly.zpp_pool.next = null;
            ZNPNode_ZPP_GeomPoly.zpp_pool = _loc93_;
         }
         while(ZNPNode_RayResult.zpp_pool != null)
         {
            _loc94_ = ZNPNode_RayResult.zpp_pool.next;
            ZNPNode_RayResult.zpp_pool.next = null;
            ZNPNode_RayResult.zpp_pool = _loc94_;
         }
         while(ZPP_PubPool.poolGeomPoly != null)
         {
            _loc95_ = ZPP_PubPool.poolGeomPoly.zpp_pool;
            ZPP_PubPool.poolGeomPoly.zpp_pool = null;
            ZPP_PubPool.poolGeomPoly = _loc95_;
         }
         while(ZPP_PubPool.poolVec2 != null)
         {
            _loc96_ = ZPP_PubPool.poolVec2.zpp_pool;
            ZPP_PubPool.poolVec2.zpp_pool = null;
            ZPP_PubPool.poolVec2 = _loc96_;
         }
         while(ZPP_PubPool.poolVec3 != null)
         {
            _loc97_ = ZPP_PubPool.poolVec3.zpp_pool;
            ZPP_PubPool.poolVec3.zpp_pool = null;
            ZPP_PubPool.poolVec3 = _loc97_;
         }
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
         var _loc4_:int = int(16777215 * Math.exp(-param1.zpp_inner_i.id / 1500));
         var _loc5_:Number = ((_loc4_ & 0xFF0000) >> 16) * 0.7;
         var _loc6_:Number = ((_loc4_ & 0xFF00) >> 8) * 0.7;
         var _loc7_:Number = (_loc4_ & 0xFF) * 0.7;
         var _loc8_:int = int(_loc5_) << 16 | int(_loc6_) << 8 | int(_loc7_);
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

