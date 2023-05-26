package zpp_nape.space
{
   import flash.Boot;
   import nape.geom.AABB;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.shape.ShapeList;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Collide;
   import zpp_nape.geom.ZPP_ConvexRayResult;
   import zpp_nape.geom.ZPP_Ray;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_SweepPhase extends ZPP_Broadphase
   {
       
      
      public var list:ZPP_SweepData;
      
      public var failed:BodyList;
      
      public function ZPP_SweepPhase(param1:ZPP_Space = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         failed = null;
         list = null;
         space = param1;
         is_sweep = true;
         sweep = this;
      }
      
      public function sync_broadphase() : void
      {
         var _loc1_:* = null as ZPP_SweepData;
         var _loc2_:* = null as ZPP_SweepData;
         var _loc3_:* = null as ZPP_SweepData;
         var _loc4_:* = null as ZPP_SweepData;
         space.validation();
         if(list != null)
         {
            _loc1_ = list.next;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_.next;
               _loc3_ = _loc1_.prev;
               if(_loc1_.aabb.minx > _loc3_.aabb.minx)
               {
                  _loc1_ = _loc2_;
               }
               else
               {
                  while(_loc3_.prev != null && _loc3_.prev.aabb.minx > _loc1_.aabb.minx)
                  {
                     _loc3_ = _loc3_.prev;
                  }
                  _loc4_ = _loc1_.prev;
                  _loc4_.next = _loc1_.next;
                  if(_loc1_.next != null)
                  {
                     _loc1_.next.prev = _loc4_;
                  }
                  if(_loc3_.prev == null)
                  {
                     _loc1_.prev = null;
                     list = _loc1_;
                     _loc1_.next = _loc3_;
                     _loc3_.prev = _loc1_;
                  }
                  else
                  {
                     _loc1_.prev = _loc3_.prev;
                     _loc3_.prev = _loc1_;
                     _loc1_.prev.next = _loc1_;
                     _loc1_.next = _loc3_;
                  }
                  _loc1_ = _loc2_;
               }
            }
         }
      }
      
      override public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Shape;
         var _loc11_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc7_ = new ZPP_Vec2();
         }
         else
         {
            _loc7_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc7_.next;
            _loc7_.next = null;
         }
         _loc7_.weak = false;
         _loc7_._immutable = false;
         _loc7_.x = param1;
         _loc7_.y = param2;
         var _loc5_:ZPP_Vec2 = _loc7_;
         var _loc8_:ShapeList = param4 == null ? new ShapeList() : param4;
         var _loc9_:ZPP_SweepData = list;
         while(_loc9_ != null && _loc9_.aabb.minx > param1)
         {
            _loc9_ = _loc9_.next;
         }
         while(_loc9_ != null && _loc9_.aabb.minx <= param1)
         {
            if(_loc9_.aabb.maxx >= param1 && _loc9_.aabb.miny <= param2 && _loc9_.aabb.maxy >= param2)
            {
               _loc10_ = _loc9_.shape;
               if(param3 == null || (_loc11_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc11_.collisionGroup) != 0)
               {
                  if(_loc10_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     if(ZPP_Collide.circleContains(_loc10_.circle,_loc5_))
                     {
                        _loc8_.push(_loc10_.outer);
                     }
                  }
                  else if(ZPP_Collide.polyContains(_loc10_.polygon,_loc5_))
                  {
                     _loc8_.push(_loc10_.outer);
                  }
               }
            }
            _loc9_ = _loc9_.next;
         }
         _loc7_ = _loc5_;
         if(_loc7_.outer != null)
         {
            _loc7_.outer.zpp_inner = null;
            _loc7_.outer = null;
         }
         _loc7_._isimmutable = null;
         _loc7_._validate = null;
         _loc7_._invalidate = null;
         _loc7_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc7_;
         return _loc8_;
      }
      
      override public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
      {
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as ZPP_Shape;
         var _loc10_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         validateShape(param1);
         var _loc5_:ZPP_AABB = param1.aabb;
         var _loc6_:ShapeList = param4 == null ? new ShapeList() : param4;
         var _loc7_:ZPP_SweepData = list;
         while(_loc7_ != null && _loc7_.aabb.maxx < _loc5_.minx)
         {
            _loc7_ = _loc7_.next;
         }
         while(_loc7_ != null && _loc7_.aabb.minx <= _loc5_.maxx)
         {
            _loc8_ = _loc7_.aabb;
            if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx)
            {
               _loc9_ = _loc7_.shape;
               if(param3 == null || (_loc10_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc10_.collisionGroup) != 0)
               {
                  if(param2)
                  {
                     if(ZPP_Collide.containTest(param1,_loc9_))
                     {
                        _loc6_.push(_loc9_.outer);
                     }
                  }
                  else if(ZPP_Collide.testCollide_safe(_loc9_,param1))
                  {
                     _loc6_.push(_loc9_.outer);
                  }
               }
            }
            _loc7_ = _loc7_.next;
         }
         return _loc6_;
      }
      
      override public function shapesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:ShapeList) : ShapeList
      {
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as ZPP_Shape;
         var _loc12_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         updateCircShape(param1,param2,param3);
         var _loc7_:ZPP_AABB = circShape.zpp_inner.aabb;
         var _loc8_:ShapeList = param6 == null ? new ShapeList() : param6;
         var _loc9_:ZPP_SweepData = list;
         while(_loc9_ != null && _loc9_.aabb.maxx < _loc7_.minx)
         {
            _loc9_ = _loc9_.next;
         }
         while(_loc9_ != null && _loc9_.aabb.minx <= _loc7_.maxx)
         {
            _loc10_ = _loc9_.aabb;
            if(_loc7_.miny <= _loc10_.maxy && _loc10_.miny <= _loc7_.maxy && _loc7_.minx <= _loc10_.maxx && _loc10_.minx <= _loc7_.maxx)
            {
               _loc11_ = _loc9_.shape;
               if(param5 == null || (_loc12_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc12_.collisionGroup) != 0)
               {
                  if(param4)
                  {
                     if(ZPP_Collide.containTest(circShape.zpp_inner,_loc11_))
                     {
                        _loc8_.push(_loc11_.outer);
                     }
                  }
                  else if(ZPP_Collide.testCollide_safe(_loc11_,circShape.zpp_inner))
                  {
                     _loc8_.push(_loc11_.outer);
                  }
               }
            }
            _loc9_ = _loc9_.next;
         }
         return _loc8_;
      }
      
      override public function shapesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
      {
         var _loc9_:* = null as ZPP_Shape;
         var _loc10_:* = null as ZPP_InteractionFilter;
         var _loc11_:* = null as ZPP_AABB;
         sync_broadphase();
         updateAABBShape(param1);
         var _loc6_:ZPP_AABB = aabbShape.zpp_inner.aabb;
         var _loc7_:ShapeList = param5 == null ? new ShapeList() : param5;
         var _loc8_:ZPP_SweepData = list;
         while(_loc8_ != null && _loc8_.aabb.maxx < _loc6_.minx)
         {
            _loc8_ = _loc8_.next;
         }
         while(_loc8_ != null && _loc8_.aabb.minx <= _loc6_.maxx)
         {
            _loc9_ = _loc8_.shape;
            if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
            {
               if(param2)
               {
                  if(param3)
                  {
                     if(ZPP_Collide.containTest(aabbShape.zpp_inner,_loc9_))
                     {
                        _loc7_.push(_loc9_.outer);
                     }
                  }
                  else
                  {
                     _loc11_ = _loc8_.aabb;
                     if(_loc11_.minx >= _loc6_.minx && _loc11_.miny >= _loc6_.miny && _loc11_.maxx <= _loc6_.maxx && _loc11_.maxy <= _loc6_.maxy)
                     {
                        _loc7_.push(_loc9_.outer);
                     }
                     else
                     {
                        _loc11_ = _loc8_.aabb;
                        if(_loc6_.miny <= _loc11_.maxy && _loc11_.miny <= _loc6_.maxy && _loc6_.minx <= _loc11_.maxx && _loc11_.minx <= _loc6_.maxx)
                        {
                           if(ZPP_Collide.testCollide_safe(_loc9_,aabbShape.zpp_inner))
                           {
                              _loc7_.push(_loc9_.outer);
                           }
                        }
                     }
                  }
               }
               else if(param3 ? (_loc11_ = _loc8_.aabb, _loc11_.minx >= _loc6_.minx && _loc11_.miny >= _loc6_.miny && _loc11_.maxx <= _loc6_.maxx && _loc11_.maxy <= _loc6_.maxy) : (_loc11_ = _loc8_.aabb, _loc6_.miny <= _loc11_.maxy && _loc11_.miny <= _loc6_.maxy && _loc6_.minx <= _loc11_.maxx && _loc11_.minx <= _loc6_.maxx))
               {
                  _loc7_.push(_loc9_.outer);
               }
            }
            _loc8_ = _loc8_.next;
         }
         return _loc7_;
      }
      
      override public function rayMultiCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter, param4:RayResultList) : RayResultList
      {
         var _loc7_:* = null as ZPP_SweepData;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as ZPP_InteractionFilter;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_SweepData;
         sync_broadphase();
         param1.validate_dir();
         var _loc5_:ZPP_AABB = param1.rayAABB();
         var _loc6_:RayResultList = param4 == null ? new RayResultList() : param4;
         if(param1.dirx == 0)
         {
            _loc7_ = list;
            while(_loc7_ != null && _loc7_.aabb.minx <= _loc5_.minx)
            {
               _loc8_ = _loc7_.aabb;
               if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx && (param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0))
               {
                  _loc10_ = param1.aabbsect(_loc7_.aabb);
                  if(_loc10_ >= 0)
                  {
                     if(_loc7_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        param1.circlesect2(_loc7_.shape.circle,param2,_loc6_);
                     }
                     else
                     {
                        param1.polysect2(_loc7_.shape.polygon,param2,_loc6_);
                     }
                  }
               }
               _loc7_ = _loc7_.next;
            }
         }
         else if(param1.dirx < 0)
         {
            _loc7_ = list;
            _loc11_ = null;
            while(_loc7_ != null && _loc7_.aabb.minx <= _loc5_.maxx)
            {
               _loc11_ = _loc7_;
               _loc7_ = _loc7_.next;
            }
            _loc7_ = _loc11_;
            while(_loc7_ != null)
            {
               _loc8_ = _loc7_.aabb;
               if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx && (param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0))
               {
                  _loc10_ = param1.aabbsect(_loc7_.aabb);
                  if(_loc10_ >= 0)
                  {
                     if(_loc7_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        param1.circlesect2(_loc7_.shape.circle,param2,_loc6_);
                     }
                     else
                     {
                        param1.polysect2(_loc7_.shape.polygon,param2,_loc6_);
                     }
                  }
               }
               _loc7_ = _loc7_.prev;
            }
         }
         else
         {
            _loc7_ = list;
            while(_loc7_ != null && _loc7_.aabb.minx <= _loc5_.maxx)
            {
               _loc8_ = _loc7_.aabb;
               if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx && (param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0))
               {
                  _loc10_ = param1.aabbsect(_loc7_.aabb);
                  if(_loc10_ >= 0)
                  {
                     if(_loc7_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        param1.circlesect2(_loc7_.shape.circle,param2,_loc6_);
                     }
                     else
                     {
                        param1.polysect2(_loc7_.shape.polygon,param2,_loc6_);
                     }
                  }
               }
               _loc7_ = _loc7_.next;
            }
         }
         _loc8_ = _loc5_;
         if(_loc8_.outer != null)
         {
            _loc8_.outer.zpp_inner = null;
            _loc8_.outer = null;
         }
         _loc8_.wrap_max = null;
         _loc8_.wrap_min = null;
         _loc8_._invalidate = null;
         _loc8_._validate = null;
         _loc8_.next = ZPP_AABB.zpp_pool;
         ZPP_AABB.zpp_pool = _loc8_;
         return _loc6_;
      }
      
      override public function rayCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResult
      {
         var _loc7_:* = null as ZPP_SweepData;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as ZPP_InteractionFilter;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as RayResult;
         var _loc12_:* = null as ZPP_SweepData;
         sync_broadphase();
         param1.validate_dir();
         var _loc4_:ZPP_AABB = param1.rayAABB();
         var _loc5_:Number = param1.maxdist;
         var _loc6_:RayResult = null;
         if(param1.dirx == 0)
         {
            _loc7_ = list;
            while(_loc7_ != null && _loc7_.aabb.minx <= _loc4_.minx)
            {
               _loc8_ = _loc7_.aabb;
               if(_loc4_.miny <= _loc8_.maxy && _loc8_.miny <= _loc4_.maxy && _loc4_.minx <= _loc8_.maxx && _loc8_.minx <= _loc4_.maxx && (param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0))
               {
                  _loc10_ = param1.aabbsect(_loc7_.aabb);
                  if(_loc10_ >= 0 && _loc10_ < _loc5_)
                  {
                     _loc11_ = _loc7_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE ? param1.circlesect(_loc7_.shape.circle,param2,_loc5_) : param1.polysect(_loc7_.shape.polygon,param2,_loc5_);
                     if(_loc11_ != null)
                     {
                        if(_loc11_.zpp_inner.next != null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This object has been disposed of and cannot be used";
                        }
                        _loc5_ = _loc11_.zpp_inner.toiDistance;
                        if(_loc6_ != null)
                        {
                           if(_loc6_.zpp_inner.next != null)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This object has been disposed of and cannot be used";
                           }
                           _loc6_.zpp_inner.free();
                        }
                        _loc6_ = _loc11_;
                     }
                  }
               }
               _loc7_ = _loc7_.next;
            }
         }
         else if(param1.dirx < 0)
         {
            _loc7_ = list;
            _loc12_ = null;
            while(_loc7_ != null && _loc7_.aabb.minx <= _loc4_.maxx)
            {
               _loc12_ = _loc7_;
               _loc7_ = _loc7_.next;
            }
            _loc7_ = _loc12_;
            while(_loc7_ != null)
            {
               _loc8_ = _loc7_.aabb;
               if(_loc4_.miny <= _loc8_.maxy && _loc8_.miny <= _loc4_.maxy && _loc4_.minx <= _loc8_.maxx && _loc8_.minx <= _loc4_.maxx && (param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0))
               {
                  _loc10_ = param1.aabbsect(_loc7_.aabb);
                  if(_loc10_ >= 0 && _loc10_ < _loc5_)
                  {
                     _loc11_ = _loc7_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE ? param1.circlesect(_loc7_.shape.circle,param2,_loc5_) : param1.polysect(_loc7_.shape.polygon,param2,_loc5_);
                     if(_loc11_ != null)
                     {
                        if(_loc11_.zpp_inner.next != null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This object has been disposed of and cannot be used";
                        }
                        _loc5_ = _loc11_.zpp_inner.toiDistance;
                        if(_loc6_ != null)
                        {
                           if(_loc6_.zpp_inner.next != null)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This object has been disposed of and cannot be used";
                           }
                           _loc6_.zpp_inner.free();
                        }
                        _loc6_ = _loc11_;
                     }
                  }
               }
               _loc7_ = _loc7_.prev;
            }
         }
         else
         {
            _loc7_ = list;
            while(_loc7_ != null && _loc7_.aabb.minx <= _loc4_.maxx && _loc7_.aabb.minx < param1.originx + param1.dirx * _loc5_)
            {
               _loc8_ = _loc7_.aabb;
               if(_loc4_.miny <= _loc8_.maxy && _loc8_.miny <= _loc4_.maxy && _loc4_.minx <= _loc8_.maxx && _loc8_.minx <= _loc4_.maxx && (param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0))
               {
                  _loc10_ = param1.aabbsect(_loc7_.aabb);
                  if(_loc10_ >= 0 && _loc10_ < _loc5_)
                  {
                     _loc11_ = _loc7_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE ? param1.circlesect(_loc7_.shape.circle,param2,_loc5_) : param1.polysect(_loc7_.shape.polygon,param2,_loc5_);
                     if(_loc11_ != null)
                     {
                        if(_loc11_.zpp_inner.next != null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This object has been disposed of and cannot be used";
                        }
                        _loc5_ = _loc11_.zpp_inner.toiDistance;
                        if(_loc6_ != null)
                        {
                           if(_loc6_.zpp_inner.next != null)
                           {
                              Boot.lastError = new Error();
                              throw "Error: This object has been disposed of and cannot be used";
                           }
                           _loc6_.zpp_inner.free();
                        }
                        _loc6_ = _loc11_;
                     }
                  }
               }
               _loc7_ = _loc7_.next;
            }
         }
         _loc8_ = _loc4_;
         if(_loc8_.outer != null)
         {
            _loc8_.outer.zpp_inner = null;
            _loc8_.outer = null;
         }
         _loc8_.wrap_max = null;
         _loc8_.wrap_min = null;
         _loc8_._invalidate = null;
         _loc8_._validate = null;
         _loc8_.next = ZPP_AABB.zpp_pool;
         ZPP_AABB.zpp_pool = _loc8_;
         return _loc6_;
      }
      
      override public function clear() : void
      {
         while(list != null)
         {
            list.shape.removedFromSpace();
            __remove(list.shape);
         }
      }
      
      override public function broadphase(param1:ZPP_Space, param2:Boolean) : void
      {
         var _loc3_:* = null as ZPP_SweepData;
         var _loc4_:* = null as ZPP_SweepData;
         var _loc5_:* = null as ZPP_SweepData;
         var _loc6_:* = null as ZPP_SweepData;
         var _loc7_:* = null as ZPP_Shape;
         var _loc8_:* = null as ZPP_Body;
         var _loc9_:Number = NaN;
         var _loc10_:* = null as ZPP_Shape;
         var _loc11_:* = null as ZPP_Body;
         var _loc12_:* = null as ZPP_AABB;
         var _loc13_:* = null as ZPP_AABB;
         if(list != null)
         {
            _loc3_ = list.next;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.next;
               _loc5_ = _loc3_.prev;
               if(_loc3_.aabb.minx > _loc5_.aabb.minx)
               {
                  _loc3_ = _loc4_;
               }
               else
               {
                  while(_loc5_.prev != null && _loc5_.prev.aabb.minx > _loc3_.aabb.minx)
                  {
                     _loc5_ = _loc5_.prev;
                  }
                  _loc6_ = _loc3_.prev;
                  _loc6_.next = _loc3_.next;
                  if(_loc3_.next != null)
                  {
                     _loc3_.next.prev = _loc6_;
                  }
                  if(_loc5_.prev == null)
                  {
                     _loc3_.prev = null;
                     list = _loc3_;
                     _loc3_.next = _loc5_;
                     _loc5_.prev = _loc3_;
                  }
                  else
                  {
                     _loc3_.prev = _loc5_.prev;
                     _loc5_.prev = _loc3_;
                     _loc3_.prev.next = _loc3_;
                     _loc3_.next = _loc5_;
                  }
                  _loc3_ = _loc4_;
               }
            }
            _loc3_ = list;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.next;
               _loc7_ = _loc3_.shape;
               _loc8_ = _loc7_.body;
               _loc9_ = _loc3_.aabb.maxx;
               while(_loc4_ != null)
               {
                  if(_loc4_.aabb.minx > _loc9_)
                  {
                     break;
                  }
                  _loc10_ = _loc4_.shape;
                  _loc11_ = _loc10_.body;
                  if(_loc11_ == _loc8_)
                  {
                     _loc4_ = _loc4_.next;
                  }
                  else if(_loc8_.type == ZPP_Flags.id_BodyType_STATIC && _loc11_.type == ZPP_Flags.id_BodyType_STATIC)
                  {
                     _loc4_ = _loc4_.next;
                  }
                  else if(_loc8_.component.sleeping && _loc11_.component.sleeping)
                  {
                     _loc4_ = _loc4_.next;
                  }
                  else
                  {
                     _loc12_ = _loc7_.aabb;
                     _loc13_ = _loc10_.aabb;
                     if(!(_loc13_.miny > _loc12_.maxy || _loc12_.miny > _loc13_.maxy))
                     {
                        if(param2)
                        {
                           param1.narrowPhase(_loc7_,_loc10_,_loc8_.type != ZPP_Flags.id_BodyType_DYNAMIC || _loc11_.type != ZPP_Flags.id_BodyType_DYNAMIC,null,false);
                        }
                        else
                        {
                           param1.continuousEvent(_loc7_,_loc10_,_loc8_.type != ZPP_Flags.id_BodyType_DYNAMIC || _loc11_.type != ZPP_Flags.id_BodyType_DYNAMIC,null,false);
                        }
                     }
                     _loc4_ = _loc4_.next;
                  }
               }
               _loc3_ = _loc3_.next;
            }
         }
      }
      
      override public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Shape;
         var _loc11_:* = null as Body;
         var _loc12_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc7_ = new ZPP_Vec2();
         }
         else
         {
            _loc7_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc7_.next;
            _loc7_.next = null;
         }
         _loc7_.weak = false;
         _loc7_._immutable = false;
         _loc7_.x = param1;
         _loc7_.y = param2;
         var _loc5_:ZPP_Vec2 = _loc7_;
         var _loc8_:BodyList = param4 == null ? new BodyList() : param4;
         var _loc9_:ZPP_SweepData = list;
         while(_loc9_ != null && _loc9_.aabb.minx > param1)
         {
            _loc9_ = _loc9_.next;
         }
         while(_loc9_ != null && _loc9_.aabb.minx <= param1)
         {
            if(_loc9_.aabb.maxx >= param1 && _loc9_.aabb.miny <= param2 && _loc9_.aabb.maxy >= param2)
            {
               _loc10_ = _loc9_.shape;
               _loc11_ = _loc10_.body.outer;
               if(!_loc8_.has(_loc11_))
               {
                  if(param3 == null || (_loc12_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc12_.collisionGroup) != 0)
                  {
                     if(_loc10_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        if(ZPP_Collide.circleContains(_loc10_.circle,_loc5_))
                        {
                           _loc8_.push(_loc11_);
                        }
                     }
                     else if(ZPP_Collide.polyContains(_loc10_.polygon,_loc5_))
                     {
                        _loc8_.push(_loc11_);
                     }
                  }
               }
            }
            _loc9_ = _loc9_.next;
         }
         _loc7_ = _loc5_;
         if(_loc7_.outer != null)
         {
            _loc7_.outer.zpp_inner = null;
            _loc7_.outer = null;
         }
         _loc7_._isimmutable = null;
         _loc7_._validate = null;
         _loc7_._invalidate = null;
         _loc7_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc7_;
         return _loc8_;
      }
      
      override public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
      {
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as ZPP_Shape;
         var _loc10_:* = null as Body;
         var _loc11_:* = null as ZPP_InteractionFilter;
         var _loc12_:Boolean = false;
         sync_broadphase();
         validateShape(param1);
         var _loc5_:ZPP_AABB = param1.aabb;
         var _loc6_:BodyList = param4 == null ? new BodyList() : param4;
         if(failed == null)
         {
            failed = new BodyList();
         }
         var _loc7_:ZPP_SweepData = list;
         while(_loc7_ != null && _loc7_.aabb.maxx < _loc5_.minx)
         {
            _loc7_ = _loc7_.next;
         }
         while(_loc7_ != null && _loc7_.aabb.minx <= _loc5_.maxx)
         {
            _loc8_ = _loc7_.aabb;
            if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx)
            {
               _loc9_ = _loc7_.shape;
               _loc10_ = _loc9_.body.outer;
               if(param3 == null || (_loc11_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc11_.collisionGroup) != 0)
               {
                  if(param2)
                  {
                     if(!failed.has(_loc10_))
                     {
                        _loc12_ = ZPP_Collide.containTest(param1,_loc9_);
                        if(!_loc6_.has(_loc10_) && _loc12_)
                        {
                           _loc6_.push(_loc10_);
                        }
                        else if(!_loc12_)
                        {
                           _loc6_.remove(_loc10_);
                           failed.push(_loc10_);
                        }
                     }
                  }
                  else if(!_loc6_.has(_loc10_) && ZPP_Collide.testCollide_safe(param1,_loc9_))
                  {
                     _loc6_.push(_loc10_);
                  }
               }
            }
            _loc7_ = _loc7_.next;
         }
         failed.clear();
         return _loc6_;
      }
      
      override public function bodiesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:BodyList) : BodyList
      {
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as ZPP_Shape;
         var _loc12_:* = null as Body;
         var _loc13_:* = null as ZPP_InteractionFilter;
         var _loc14_:Boolean = false;
         sync_broadphase();
         updateCircShape(param1,param2,param3);
         var _loc7_:ZPP_AABB = circShape.zpp_inner.aabb;
         var _loc8_:BodyList = param6 == null ? new BodyList() : param6;
         if(failed == null)
         {
            failed = new BodyList();
         }
         var _loc9_:ZPP_SweepData = list;
         while(_loc9_ != null && _loc9_.aabb.maxx < _loc7_.minx)
         {
            _loc9_ = _loc9_.next;
         }
         while(_loc9_ != null && _loc9_.aabb.minx <= _loc7_.maxx)
         {
            _loc10_ = _loc9_.aabb;
            if(_loc7_.miny <= _loc10_.maxy && _loc10_.miny <= _loc7_.maxy && _loc7_.minx <= _loc10_.maxx && _loc10_.minx <= _loc7_.maxx)
            {
               _loc11_ = _loc9_.shape;
               _loc12_ = _loc11_.body.outer;
               if(param5 == null || (_loc13_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc13_.collisionGroup) != 0)
               {
                  if(param4)
                  {
                     if(!failed.has(_loc12_))
                     {
                        _loc14_ = ZPP_Collide.containTest(circShape.zpp_inner,_loc11_);
                        if(!_loc8_.has(_loc12_) && _loc14_)
                        {
                           _loc8_.push(_loc12_);
                        }
                        else if(!_loc14_)
                        {
                           _loc8_.remove(_loc12_);
                           failed.push(_loc12_);
                        }
                     }
                  }
                  else if(!_loc8_.has(_loc12_) && ZPP_Collide.testCollide_safe(_loc11_,circShape.zpp_inner))
                  {
                     _loc8_.push(_loc12_);
                  }
               }
            }
            _loc9_ = _loc9_.next;
         }
         failed.clear();
         return _loc8_;
      }
      
      override public function bodiesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
      {
         var _loc9_:* = null as ZPP_Shape;
         var _loc10_:* = null as Body;
         var _loc11_:* = null as ZPP_AABB;
         var _loc12_:* = null as ZPP_InteractionFilter;
         var _loc13_:Boolean = false;
         sync_broadphase();
         updateAABBShape(param1);
         var _loc6_:ZPP_AABB = aabbShape.zpp_inner.aabb;
         var _loc7_:BodyList = param5 == null ? new BodyList() : param5;
         if(failed == null)
         {
            failed = new BodyList();
         }
         var _loc8_:ZPP_SweepData = list;
         while(_loc8_ != null && _loc8_.aabb.maxx < _loc6_.minx)
         {
            _loc8_ = _loc8_.next;
         }
         while(_loc8_ != null && _loc8_.aabb.minx <= _loc6_.maxx)
         {
            _loc9_ = _loc8_.shape;
            _loc10_ = _loc9_.body.outer;
            _loc11_ = _loc8_.aabb;
            if(_loc6_.miny <= _loc11_.maxy && _loc11_.miny <= _loc6_.maxy && _loc6_.minx <= _loc11_.maxx && _loc11_.minx <= _loc6_.maxx)
            {
               if(param4 == null || (_loc12_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc12_.collisionGroup) != 0)
               {
                  if(param2)
                  {
                     if(param3)
                     {
                        if(!failed.has(_loc10_))
                        {
                           _loc13_ = ZPP_Collide.containTest(aabbShape.zpp_inner,_loc9_);
                           if(!_loc7_.has(_loc10_) && _loc13_)
                           {
                              _loc7_.push(_loc10_);
                           }
                           else if(!_loc13_)
                           {
                              _loc7_.remove(_loc10_);
                              failed.push(_loc10_);
                           }
                        }
                     }
                     else if(!_loc7_.has(_loc10_) && ZPP_Collide.testCollide_safe(_loc9_,aabbShape.zpp_inner))
                     {
                        _loc7_.push(_loc10_);
                     }
                  }
                  else if(param3)
                  {
                     if(!failed.has(_loc10_))
                     {
                        _loc11_ = _loc9_.aabb;
                        _loc13_ = _loc11_.minx >= _loc6_.minx && _loc11_.miny >= _loc6_.miny && _loc11_.maxx <= _loc6_.maxx && _loc11_.maxy <= _loc6_.maxy;
                        if(!_loc7_.has(_loc10_) && _loc13_)
                        {
                           _loc7_.push(_loc10_);
                        }
                        else if(!_loc13_)
                        {
                           _loc7_.remove(_loc10_);
                           failed.push(_loc10_);
                        }
                     }
                  }
                  else if(!_loc7_.has(_loc10_) && (_loc11_.minx >= _loc6_.minx && _loc11_.miny >= _loc6_.miny && _loc11_.maxx <= _loc6_.maxx && _loc11_.maxy <= _loc6_.maxy))
                  {
                     _loc7_.push(_loc10_);
                  }
               }
            }
            _loc8_ = _loc8_.next;
         }
         failed.clear();
         return _loc7_;
      }
      
      public function __remove(param1:ZPP_Shape) : void
      {
         var _loc2_:ZPP_SweepData = param1.sweep;
         if(_loc2_.prev == null)
         {
            list = _loc2_.next;
         }
         else
         {
            _loc2_.prev.next = _loc2_.next;
         }
         if(_loc2_.next != null)
         {
            _loc2_.next.prev = _loc2_.prev;
         }
         param1.sweep = null;
         var _loc3_:ZPP_SweepData = _loc2_;
         _loc3_.prev = null;
         _loc3_.shape = null;
         _loc3_.aabb = null;
         _loc3_.next = ZPP_SweepData.zpp_pool;
         ZPP_SweepData.zpp_pool = _loc3_;
      }
      
      public function __insert(param1:ZPP_Shape) : void
      {
         var _loc2_:* = null as ZPP_SweepData;
         if(ZPP_SweepData.zpp_pool == null)
         {
            _loc2_ = new ZPP_SweepData();
         }
         else
         {
            _loc2_ = ZPP_SweepData.zpp_pool;
            ZPP_SweepData.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         param1.sweep = _loc2_;
         _loc2_.shape = param1;
         _loc2_.aabb = param1.aabb;
         _loc2_.next = list;
         if(list != null)
         {
            list.prev = _loc2_;
         }
         list = _loc2_;
      }
   }
}
