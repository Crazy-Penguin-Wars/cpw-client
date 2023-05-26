package zpp_nape.geom
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.Config;
   import nape.geom.Vec2;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.dynamics.ZPP_FluidArbiter;
   import zpp_nape.dynamics.ZPP_IContact;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPList_ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_Collide
   {
      
      public static var flowpoly:ZNPList_ZPP_Vec2 = new ZNPList_ZPP_Vec2();
      
      public static var flowsegs:ZNPList_ZPP_Vec2 = new ZNPList_ZPP_Vec2();
       
      
      public function ZPP_Collide()
      {
      }
      
      public static function circleContains(param1:ZPP_Circle, param2:ZPP_Vec2) : Boolean
      {
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         _loc3_ = param2.x - param1.worldCOMx;
         _loc4_ = param2.y - param1.worldCOMy;
         return _loc3_ * _loc3_ + _loc4_ * _loc4_ < param1.radius * param1.radius;
      }
      
      public static function polyContains(param1:ZPP_Polygon, param2:ZPP_Vec2) : Boolean
      {
         var _loc5_:* = null as ZPP_Edge;
         var _loc3_:Boolean = true;
         var _loc4_:ZNPNode_ZPP_Edge = param1.edges.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            if(_loc5_.gnormx * param2.x + _loc5_.gnormy * param2.y > _loc5_.gprojection)
            {
               _loc3_ = false;
               break;
            }
            _loc4_ = _loc4_.next;
         }
         return _loc3_;
      }
      
      public static function shapeContains(param1:ZPP_Shape, param2:ZPP_Vec2) : Boolean
      {
         return param1.type == ZPP_Flags.id_ShapeType_CIRCLE ? ZPP_Collide.circleContains(param1.circle,param2) : ZPP_Collide.polyContains(param1.polygon,param2);
      }
      
      public static function bodyContains(param1:ZPP_Body, param2:ZPP_Vec2) : Boolean
      {
         var _loc5_:* = null as ZPP_Shape;
         var _loc3_:Boolean = false;
         var _loc4_:ZNPNode_ZPP_Shape = param1.shapes.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            if(ZPP_Collide.shapeContains(_loc5_,param2))
            {
               _loc3_ = true;
               break;
            }
            _loc4_ = _loc4_.next;
         }
         return _loc3_;
      }
      
      public static function containTest(param1:ZPP_Shape, param2:ZPP_Shape) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZNPNode_ZPP_Edge;
         var _loc13_:* = null as ZPP_Edge;
         var _loc3_:ZPP_AABB = param1.aabb;
         var _loc4_:ZPP_AABB = param2.aabb;
         if(_loc4_.minx >= _loc3_.minx && _loc4_.miny >= _loc3_.miny && _loc4_.maxx <= _loc3_.maxx && _loc4_.maxy <= _loc3_.maxy)
         {
            if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               if(param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc5_ = param1.circle.radius + -param2.circle.radius;
                  _loc6_ = 0;
                  _loc7_ = 0;
                  _loc6_ = param2.circle.worldCOMx - param1.circle.worldCOMx;
                  _loc7_ = param2.circle.worldCOMy - param1.circle.worldCOMy;
                  _loc8_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
                  return _loc8_ <= _loc5_ * _loc5_;
               }
               else
               {
                  _loc9_ = true;
                  _loc10_ = param2.polygon.gverts.next;
                  while(_loc10_ != null)
                  {
                     _loc11_ = _loc10_;
                     _loc5_ = param1.circle.radius;
                     _loc6_ = 0;
                     _loc7_ = 0;
                     _loc6_ = _loc11_.x - param1.circle.worldCOMx;
                     _loc7_ = _loc11_.y - param1.circle.worldCOMy;
                     _loc8_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
                     if(_loc8_ > _loc5_ * _loc5_)
                     {
                        _loc9_ = false;
                        break;
                     }
                     _loc10_ = _loc10_.next;
                  }
                  return _loc9_;
               }
            }
            else if(param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc9_ = true;
               _loc12_ = param1.polygon.edges.head;
               while(_loc12_ != null)
               {
                  _loc13_ = _loc12_.elt;
                  if(_loc13_.gnormx * param2.circle.worldCOMx + _loc13_.gnormy * param2.circle.worldCOMy + param2.circle.radius > _loc13_.gprojection)
                  {
                     _loc9_ = false;
                     break;
                  }
                  _loc12_ = _loc12_.next;
               }
               return _loc9_;
            }
            else
            {
               _loc9_ = true;
               _loc12_ = param1.polygon.edges.head;
               while(_loc12_ != null)
               {
                  _loc13_ = _loc12_.elt;
                  _loc5_ = -1e+100;
                  _loc10_ = param2.polygon.gverts.next;
                  while(_loc10_ != null)
                  {
                     _loc11_ = _loc10_;
                     _loc6_ = _loc13_.gnormx * _loc11_.x + _loc13_.gnormy * _loc11_.y;
                     if(_loc6_ > _loc5_)
                     {
                        _loc5_ = _loc6_;
                     }
                     _loc10_ = _loc10_.next;
                  }
                  if(_loc5_ > _loc13_.gprojection)
                  {
                     _loc9_ = false;
                     break;
                  }
                  _loc12_ = _loc12_.next;
               }
               return _loc9_;
            }
         }
         return false;
      }
      
      public static function contactCollide(param1:ZPP_Shape, param2:ZPP_Shape, param3:ZPP_ColArbiter, param4:Boolean) : Boolean
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 3792
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      public static function testCollide_safe(param1:ZPP_Shape, param2:ZPP_Shape) : Boolean
      {
         var _loc3_:* = null as ZPP_Shape;
         if(param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            _loc3_ = param1;
            param1 = param2;
            param2 = _loc3_;
         }
         return ZPP_Collide.testCollide(param1,param2);
      }
      
      public static function testCollide(param1:ZPP_Shape, param2:ZPP_Shape) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:* = null as ZNPNode_ZPP_Edge;
         var _loc5_:* = null as ZPP_Edge;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:Number = NaN;
         var _loc10_:* = null as ZPP_Edge;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         if(param2.type == ZPP_Flags.id_ShapeType_POLYGON)
         {
            if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc3_ = true;
               _loc4_ = param1.polygon.edges.head;
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.elt;
                  _loc6_ = 1e+100;
                  _loc7_ = param2.polygon.gverts.next;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_;
                     _loc9_ = _loc5_.gnormx * _loc8_.x + _loc5_.gnormy * _loc8_.y;
                     if(_loc9_ < _loc6_)
                     {
                        _loc6_ = _loc9_;
                     }
                     _loc7_ = _loc7_.next;
                  }
                  _loc6_ -= _loc5_.gprojection;
                  if(_loc6_ > 0)
                  {
                     _loc3_ = false;
                     break;
                  }
                  _loc4_ = _loc4_.next;
               }
               if(_loc3_)
               {
                  _loc4_ = param2.polygon.edges.head;
                  while(_loc4_ != null)
                  {
                     _loc5_ = _loc4_.elt;
                     _loc6_ = 1e+100;
                     _loc7_ = param1.polygon.gverts.next;
                     while(_loc7_ != null)
                     {
                        _loc8_ = _loc7_;
                        _loc9_ = _loc5_.gnormx * _loc8_.x + _loc5_.gnormy * _loc8_.y;
                        if(_loc9_ < _loc6_)
                        {
                           _loc6_ = _loc9_;
                        }
                        _loc7_ = _loc7_.next;
                     }
                     _loc6_ -= _loc5_.gprojection;
                     if(_loc6_ > 0)
                     {
                        _loc3_ = false;
                        break;
                     }
                     _loc4_ = _loc4_.next;
                  }
                  return _loc3_;
               }
               else
               {
                  return false;
               }
            }
            else
            {
               _loc5_ = null;
               _loc7_ = null;
               _loc3_ = true;
               _loc6_ = -1e+100;
               _loc8_ = param2.polygon.gverts.next;
               _loc4_ = param2.polygon.edges.head;
               while(_loc4_ != null)
               {
                  _loc10_ = _loc4_.elt;
                  _loc9_ = _loc10_.gnormx * param1.circle.worldCOMx + _loc10_.gnormy * param1.circle.worldCOMy - _loc10_.gprojection - param1.circle.radius;
                  if(_loc9_ > 0)
                  {
                     _loc3_ = false;
                     break;
                  }
                  if(_loc9_ > _loc6_)
                  {
                     _loc6_ = _loc9_;
                     _loc5_ = _loc10_;
                     _loc7_ = _loc8_;
                  }
                  _loc8_ = _loc8_.next;
                  _loc4_ = _loc4_.next;
               }
               return _loc3_ ? (_loc11_ = _loc7_, _loc12_ = _loc7_.next == null ? param2.polygon.gverts.next : _loc7_.next, _loc9_ = param1.circle.worldCOMy * _loc5_.gnormx - param1.circle.worldCOMx * _loc5_.gnormy, _loc9_ <= _loc11_.y * _loc5_.gnormx - _loc11_.x * _loc5_.gnormy ? (_loc13_ = param1.circle.radius, _loc14_ = 0, _loc15_ = 0, _loc14_ = _loc11_.x - param1.circle.worldCOMx, _loc15_ = _loc11_.y - param1.circle.worldCOMy, _loc16_ = _loc14_ * _loc14_ + _loc15_ * _loc15_, _loc16_ <= _loc13_ * _loc13_) : (_loc9_ >= _loc12_.y * _loc5_.gnormx - _loc12_.x * _loc5_.gnormy ? (_loc13_ = param1.circle.radius, _loc14_ = 0, _loc15_ = 0, _loc14_ = _loc12_.x - param1.circle.worldCOMx, _loc15_ = _loc12_.y - param1.circle.worldCOMy, _loc16_ = _loc14_ * _loc14_ + _loc15_ * _loc15_, _loc16_ <= _loc13_ * _loc13_) : true)) : false;
            }
         }
         _loc6_ = param1.circle.radius + param2.circle.radius;
         _loc9_ = 0;
         _loc13_ = 0;
         _loc9_ = param2.circle.worldCOMx - param1.circle.worldCOMx;
         _loc13_ = param2.circle.worldCOMy - param1.circle.worldCOMy;
         _loc14_ = _loc9_ * _loc9_ + _loc13_ * _loc13_;
         return _loc14_ <= _loc6_ * _loc6_;
      }
      
      public static function flowCollide(param1:ZPP_Shape, param2:ZPP_Shape, param3:ZPP_FluidArbiter) : Boolean
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 8014
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
   }
}
