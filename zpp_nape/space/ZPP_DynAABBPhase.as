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
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPList_ZPP_AABBNode;
   import zpp_nape.util.ZNPList_ZPP_AABBPair;
   import zpp_nape.util.ZNPNode_ZPP_AABBNode;
   import zpp_nape.util.ZNPNode_ZPP_AABBPair;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_DynAABBPhase extends ZPP_Broadphase
   {
       
      
      public var treeStack2:ZNPList_ZPP_AABBNode;
      
      public var treeStack:ZNPList_ZPP_AABBNode;
      
      public var syncs:ZPP_AABBNode;
      
      public var stree:ZPP_AABBTree;
      
      public var pairs:ZPP_AABBPair;
      
      public var openlist:ZNPList_ZPP_AABBNode;
      
      public var moves:ZPP_AABBNode;
      
      public var failed:BodyList;
      
      public var dtree:ZPP_AABBTree;
      
      public function ZPP_DynAABBPhase(param1:ZPP_Space = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         openlist = null;
         failed = null;
         treeStack2 = null;
         treeStack = null;
         moves = null;
         syncs = null;
         pairs = null;
         dtree = null;
         stree = null;
         space = param1;
         is_sweep = false;
         dynab = this;
         stree = new ZPP_AABBTree();
         dtree = new ZPP_AABBTree();
      }
      
      public function sync_broadphase() : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 7050
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      override public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
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
         if(stree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(stree.root);
            while(treeStack.head != null)
            {
               _loc9_ = treeStack.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc5_.x >= _loc10_.minx && _loc5_.x <= _loc10_.maxx && _loc5_.y >= _loc10_.miny && _loc5_.y <= _loc10_.maxy)
               {
                  if(_loc9_.child1 == null)
                  {
                     if(param3 == null || (_loc11_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc11_.collisionGroup) != 0)
                     {
                        if(_loc9_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           if(ZPP_Collide.circleContains(_loc9_.shape.circle,_loc5_))
                           {
                              _loc8_.push(_loc9_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.polyContains(_loc9_.shape.polygon,_loc5_))
                        {
                           _loc8_.push(_loc9_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        treeStack.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        treeStack.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(dtree.root);
            while(treeStack.head != null)
            {
               _loc9_ = treeStack.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc5_.x >= _loc10_.minx && _loc5_.x <= _loc10_.maxx && _loc5_.y >= _loc10_.miny && _loc5_.y <= _loc10_.maxy)
               {
                  if(_loc9_.child1 == null)
                  {
                     if(param3 == null || (_loc11_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc11_.collisionGroup) != 0)
                     {
                        if(_loc9_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           if(ZPP_Collide.circleContains(_loc9_.shape.circle,_loc5_))
                           {
                              _loc8_.push(_loc9_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.polyContains(_loc9_.shape.polygon,_loc5_))
                        {
                           _loc8_.push(_loc9_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        treeStack.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        treeStack.add(_loc9_.child2);
                     }
                  }
               }
            }
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
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         validateShape(param1);
         var _loc5_:ZPP_AABB = param1.aabb;
         var _loc6_:ShapeList = param4 == null ? new ShapeList() : param4;
         if(stree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(stree.root);
            while(treeStack.head != null)
            {
               _loc7_ = treeStack.pop_unsafe();
               _loc8_ = _loc7_.aabb;
               if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx)
               {
                  if(_loc7_.child1 == null)
                  {
                     if(param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0)
                     {
                        if(param2)
                        {
                           if(ZPP_Collide.containTest(param1,_loc7_.shape))
                           {
                              _loc6_.push(_loc7_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.testCollide_safe(_loc7_.shape,param1))
                        {
                           _loc6_.push(_loc7_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_.child1 != null)
                     {
                        treeStack.add(_loc7_.child1);
                     }
                     if(_loc7_.child2 != null)
                     {
                        treeStack.add(_loc7_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(dtree.root);
            while(treeStack.head != null)
            {
               _loc7_ = treeStack.pop_unsafe();
               _loc8_ = _loc7_.aabb;
               if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx)
               {
                  if(_loc7_.child1 == null)
                  {
                     if(param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0)
                     {
                        if(param2)
                        {
                           if(ZPP_Collide.containTest(param1,_loc7_.shape))
                           {
                              _loc6_.push(_loc7_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.testCollide_safe(_loc7_.shape,param1))
                        {
                           _loc6_.push(_loc7_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_.child1 != null)
                     {
                        treeStack.add(_loc7_.child1);
                     }
                     if(_loc7_.child2 != null)
                     {
                        treeStack.add(_loc7_.child2);
                     }
                  }
               }
            }
         }
         return _loc6_;
      }
      
      override public function shapesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:ShapeList) : ShapeList
      {
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         updateCircShape(param1,param2,param3);
         var _loc7_:ZPP_AABB = circShape.zpp_inner.aabb;
         var _loc8_:ShapeList = param6 == null ? new ShapeList() : param6;
         if(stree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(stree.root);
            while(treeStack.head != null)
            {
               _loc9_ = treeStack.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc7_.miny <= _loc10_.maxy && _loc10_.miny <= _loc7_.maxy && _loc7_.minx <= _loc10_.maxx && _loc10_.minx <= _loc7_.maxx)
               {
                  if(_loc9_.child1 == null)
                  {
                     if(param5 == null || (_loc11_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc11_.collisionGroup) != 0)
                     {
                        if(param4)
                        {
                           if(ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape))
                           {
                              _loc8_.push(_loc9_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.testCollide_safe(_loc9_.shape,circShape.zpp_inner))
                        {
                           _loc8_.push(_loc9_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        treeStack.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        treeStack.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(dtree.root);
            while(treeStack.head != null)
            {
               _loc9_ = treeStack.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc7_.miny <= _loc10_.maxy && _loc10_.miny <= _loc7_.maxy && _loc7_.minx <= _loc10_.maxx && _loc10_.minx <= _loc7_.maxx)
               {
                  if(_loc9_.child1 == null)
                  {
                     if(param5 == null || (_loc11_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc11_.collisionGroup) != 0)
                     {
                        if(param4)
                        {
                           if(ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape))
                           {
                              _loc8_.push(_loc9_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.testCollide_safe(_loc9_.shape,circShape.zpp_inner))
                        {
                           _loc8_.push(_loc9_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        treeStack.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        treeStack.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         return _loc8_;
      }
      
      override public function shapesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
      {
         var _loc8_:* = null as ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABB;
         var _loc10_:* = null as ZPP_InteractionFilter;
         var _loc11_:* = null as ZPP_AABBNode;
         sync_broadphase();
         updateAABBShape(param1);
         var _loc6_:ZPP_AABB = aabbShape.zpp_inner.aabb;
         var _loc7_:ShapeList = param5 == null ? new ShapeList() : param5;
         if(stree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(stree.root);
            while(treeStack.head != null)
            {
               _loc8_ = treeStack.pop_unsafe();
               _loc9_ = _loc8_.aabb;
               if(_loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy)
               {
                  if(_loc8_.child1 == null)
                  {
                     if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                     {
                        _loc7_.push(_loc8_.shape.outer);
                     }
                  }
                  else
                  {
                     if(treeStack2 == null)
                     {
                        treeStack2 = new ZNPList_ZPP_AABBNode();
                     }
                     treeStack2.add(_loc8_);
                     while(treeStack2.head != null)
                     {
                        _loc11_ = treeStack2.pop_unsafe();
                        if(_loc11_.child1 == null)
                        {
                           if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                           {
                              _loc7_.push(_loc11_.shape.outer);
                           }
                        }
                        else
                        {
                           if(_loc11_.child1 != null)
                           {
                              treeStack2.add(_loc11_.child1);
                           }
                           if(_loc11_.child2 != null)
                           {
                              treeStack2.add(_loc11_.child2);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.aabb;
                  if(_loc6_.miny <= _loc9_.maxy && _loc9_.miny <= _loc6_.maxy && _loc6_.minx <= _loc9_.maxx && _loc9_.minx <= _loc6_.maxx)
                  {
                     if(_loc8_.child1 == null)
                     {
                        if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                        {
                           if(param2)
                           {
                              if(param3)
                              {
                                 if(ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape))
                                 {
                                    _loc7_.push(_loc8_.shape.outer);
                                 }
                              }
                              else
                              {
                                 _loc9_ = _loc8_.shape.aabb;
                                 if(_loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy)
                                 {
                                    _loc7_.push(_loc8_.shape.outer);
                                 }
                                 else if(ZPP_Collide.testCollide_safe(_loc8_.shape,aabbShape.zpp_inner))
                                 {
                                    _loc7_.push(_loc8_.shape.outer);
                                 }
                              }
                           }
                           else if(!param3 || _loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy)
                           {
                              _loc7_.push(_loc8_.shape.outer);
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_.child1 != null)
                        {
                           treeStack.add(_loc8_.child1);
                        }
                        if(_loc8_.child2 != null)
                        {
                           treeStack.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(dtree.root);
            while(treeStack.head != null)
            {
               _loc8_ = treeStack.pop_unsafe();
               _loc9_ = _loc8_.aabb;
               if(_loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy)
               {
                  if(_loc8_.child1 == null)
                  {
                     if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                     {
                        _loc7_.push(_loc8_.shape.outer);
                     }
                  }
                  else
                  {
                     if(treeStack2 == null)
                     {
                        treeStack2 = new ZNPList_ZPP_AABBNode();
                     }
                     treeStack2.add(_loc8_);
                     while(treeStack2.head != null)
                     {
                        _loc11_ = treeStack2.pop_unsafe();
                        if(_loc11_.child1 == null)
                        {
                           if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                           {
                              _loc7_.push(_loc11_.shape.outer);
                           }
                        }
                        else
                        {
                           if(_loc11_.child1 != null)
                           {
                              treeStack2.add(_loc11_.child1);
                           }
                           if(_loc11_.child2 != null)
                           {
                              treeStack2.add(_loc11_.child2);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.aabb;
                  if(_loc6_.miny <= _loc9_.maxy && _loc9_.miny <= _loc6_.maxy && _loc6_.minx <= _loc9_.maxx && _loc9_.minx <= _loc6_.maxx)
                  {
                     if(_loc8_.child1 == null)
                     {
                        if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                        {
                           if(param2)
                           {
                              if(param3)
                              {
                                 if(ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape))
                                 {
                                    _loc7_.push(_loc8_.shape.outer);
                                 }
                              }
                              else
                              {
                                 _loc9_ = _loc8_.shape.aabb;
                                 if(_loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy)
                                 {
                                    _loc7_.push(_loc8_.shape.outer);
                                 }
                                 else if(ZPP_Collide.testCollide_safe(_loc8_.shape,aabbShape.zpp_inner))
                                 {
                                    _loc7_.push(_loc8_.shape.outer);
                                 }
                              }
                           }
                           else if(!param3 || _loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy)
                           {
                              _loc7_.push(_loc8_.shape.outer);
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_.child1 != null)
                        {
                           treeStack.add(_loc8_.child1);
                        }
                        if(_loc8_.child2 != null)
                        {
                           treeStack.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         return _loc7_;
      }
      
      override public function rayMultiCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter, param4:RayResultList) : RayResultList
      {
         var _loc7_:Number = NaN;
         var _loc8_:* = null as ZPP_AABBNode;
         var _loc9_:* = null as ZPP_Shape;
         var _loc10_:* = null as ZPP_InteractionFilter;
         if(openlist == null)
         {
            openlist = new ZNPList_ZPP_AABBNode();
         }
         sync_broadphase();
         param1.validate_dir();
         var _loc5_:Boolean = param1.maxdist >= 1.79e+308;
         var _loc6_:RayResultList = param4 == null ? new RayResultList() : param4;
         if(dtree.root != null)
         {
            if(param1.aabbtest(dtree.root.aabb))
            {
               if(_loc5_)
               {
                  openlist.add(dtree.root);
               }
               else
               {
                  _loc7_ = param1.aabbsect(dtree.root.aabb);
                  if(_loc7_ >= 0 && _loc7_ < param1.maxdist)
                  {
                     openlist.add(dtree.root);
                  }
               }
            }
         }
         if(stree.root != null)
         {
            if(param1.aabbtest(stree.root.aabb))
            {
               if(_loc5_)
               {
                  openlist.add(stree.root);
               }
               else
               {
                  _loc7_ = param1.aabbsect(stree.root.aabb);
                  if(_loc7_ >= 0 && _loc7_ < param1.maxdist)
                  {
                     openlist.add(stree.root);
                  }
               }
            }
         }
         while(openlist.head != null)
         {
            _loc8_ = openlist.pop_unsafe();
            if(_loc8_.child1 == null)
            {
               _loc9_ = _loc8_.shape;
               if(param3 == null || (_loc10_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc10_.collisionGroup) != 0)
               {
                  if(_loc9_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     param1.circlesect2(_loc9_.circle,param2,_loc6_);
                  }
                  else if(param1.aabbtest(_loc9_.aabb))
                  {
                     param1.polysect2(_loc9_.polygon,param2,_loc6_);
                  }
               }
            }
            else
            {
               if(_loc8_.child1 != null)
               {
                  if(param1.aabbtest(_loc8_.child1.aabb))
                  {
                     if(_loc5_)
                     {
                        openlist.add(_loc8_.child1);
                     }
                     else
                     {
                        _loc7_ = param1.aabbsect(_loc8_.child1.aabb);
                        if(_loc7_ >= 0 && _loc7_ < param1.maxdist)
                        {
                           openlist.add(_loc8_.child1);
                        }
                     }
                  }
               }
               if(_loc8_.child2 != null)
               {
                  if(param1.aabbtest(_loc8_.child2.aabb))
                  {
                     if(_loc5_)
                     {
                        openlist.add(_loc8_.child2);
                     }
                     else
                     {
                        _loc7_ = param1.aabbsect(_loc8_.child2.aabb);
                        if(_loc7_ >= 0 && _loc7_ < param1.maxdist)
                        {
                           openlist.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         openlist.clear();
         return _loc6_;
      }
      
      override public function rayCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResult
      {
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZNPNode_ZPP_AABBNode;
         var _loc7_:* = null as ZNPNode_ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABBNode;
         var _loc9_:* = null as ZNPList_ZPP_AABBNode;
         var _loc10_:* = null as ZNPNode_ZPP_AABBNode;
         var _loc11_:Boolean = false;
         var _loc13_:* = null as ZPP_Shape;
         var _loc14_:* = null as ZPP_InteractionFilter;
         var _loc15_:* = null as RayResult;
         var _loc16_:* = null as ZPP_AABBNode;
         if(openlist == null)
         {
            openlist = new ZNPList_ZPP_AABBNode();
         }
         sync_broadphase();
         param1.validate_dir();
         var _loc4_:Number = param1.maxdist;
         if(dtree.root != null)
         {
            if(param1.aabbtest(dtree.root.aabb))
            {
               _loc5_ = param1.aabbsect(dtree.root.aabb);
               if(_loc5_ >= 0 && _loc5_ < _loc4_)
               {
                  dtree.root.rayt = _loc5_;
                  _loc6_ = null;
                  _loc7_ = openlist.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     if(dtree.root.rayt < _loc8_.rayt)
                     {
                        break;
                     }
                     _loc6_ = _loc7_;
                     _loc7_ = _loc7_.next;
                  }
                  _loc9_ = openlist;
                  if(ZNPNode_ZPP_AABBNode.zpp_pool == null)
                  {
                     _loc10_ = new ZNPNode_ZPP_AABBNode();
                  }
                  else
                  {
                     _loc10_ = ZNPNode_ZPP_AABBNode.zpp_pool;
                     ZNPNode_ZPP_AABBNode.zpp_pool = _loc10_.next;
                     _loc10_.next = null;
                  }
                  _loc10_.elt = dtree.root;
                  _loc7_ = _loc10_;
                  if(_loc6_ == null)
                  {
                     _loc7_.next = _loc9_.head;
                     _loc9_.head = _loc7_;
                  }
                  else
                  {
                     _loc7_.next = _loc6_.next;
                     _loc6_.next = _loc7_;
                  }
                  _loc9_.pushmod = _loc9_.modified = true;
                  _loc9_.length = _loc9_.length + 1;
                  _loc7_;
               }
            }
         }
         if(stree.root != null)
         {
            if(param1.aabbtest(stree.root.aabb))
            {
               _loc5_ = param1.aabbsect(stree.root.aabb);
               if(_loc5_ >= 0 && _loc5_ < _loc4_)
               {
                  stree.root.rayt = _loc5_;
                  _loc6_ = null;
                  _loc7_ = openlist.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     if(stree.root.rayt < _loc8_.rayt)
                     {
                        break;
                     }
                     _loc6_ = _loc7_;
                     _loc7_ = _loc7_.next;
                  }
                  _loc9_ = openlist;
                  if(ZNPNode_ZPP_AABBNode.zpp_pool == null)
                  {
                     _loc10_ = new ZNPNode_ZPP_AABBNode();
                  }
                  else
                  {
                     _loc10_ = ZNPNode_ZPP_AABBNode.zpp_pool;
                     ZNPNode_ZPP_AABBNode.zpp_pool = _loc10_.next;
                     _loc10_.next = null;
                  }
                  _loc10_.elt = stree.root;
                  _loc7_ = _loc10_;
                  if(_loc6_ == null)
                  {
                     _loc7_.next = _loc9_.head;
                     _loc9_.head = _loc7_;
                  }
                  else
                  {
                     _loc7_.next = _loc6_.next;
                     _loc6_.next = _loc7_;
                  }
                  _loc9_.pushmod = _loc9_.modified = true;
                  _loc9_.length = _loc9_.length + 1;
                  _loc7_;
               }
            }
         }
         var _loc12_:RayResult = null;
         while(openlist.head != null)
         {
            _loc8_ = openlist.pop_unsafe();
            if(_loc8_.rayt >= _loc4_)
            {
               break;
            }
            if(_loc8_.child1 == null)
            {
               _loc13_ = _loc8_.shape;
               if(param3 == null || (_loc14_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc14_.collisionGroup) != 0)
               {
                  _loc15_ = _loc13_.type == ZPP_Flags.id_ShapeType_CIRCLE ? param1.circlesect(_loc13_.circle,param2,_loc4_) : (param1.aabbtest(_loc13_.aabb) ? param1.polysect(_loc13_.polygon,param2,_loc4_) : null);
                  if(_loc15_ != null)
                  {
                     if(_loc15_.zpp_inner.next != null)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This object has been disposed of and cannot be used";
                     }
                     _loc4_ = _loc15_.zpp_inner.toiDistance;
                     if(_loc12_ != null)
                     {
                        if(_loc12_.zpp_inner.next != null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This object has been disposed of and cannot be used";
                        }
                        _loc12_.zpp_inner.free();
                     }
                     _loc12_ = _loc15_;
                  }
               }
            }
            else
            {
               if(_loc8_.child1 != null)
               {
                  if(param1.aabbtest(_loc8_.child1.aabb))
                  {
                     _loc5_ = param1.aabbsect(_loc8_.child1.aabb);
                     if(_loc5_ >= 0 && _loc5_ < _loc4_)
                     {
                        _loc8_.child1.rayt = _loc5_;
                        _loc6_ = null;
                        _loc7_ = openlist.head;
                        while(_loc7_ != null)
                        {
                           _loc16_ = _loc7_.elt;
                           if(_loc8_.child1.rayt < _loc16_.rayt)
                           {
                              break;
                           }
                           _loc6_ = _loc7_;
                           _loc7_ = _loc7_.next;
                        }
                        _loc9_ = openlist;
                        if(ZNPNode_ZPP_AABBNode.zpp_pool == null)
                        {
                           _loc10_ = new ZNPNode_ZPP_AABBNode();
                        }
                        else
                        {
                           _loc10_ = ZNPNode_ZPP_AABBNode.zpp_pool;
                           ZNPNode_ZPP_AABBNode.zpp_pool = _loc10_.next;
                           _loc10_.next = null;
                        }
                        _loc10_.elt = _loc8_.child1;
                        _loc7_ = _loc10_;
                        if(_loc6_ == null)
                        {
                           _loc7_.next = _loc9_.head;
                           _loc9_.head = _loc7_;
                        }
                        else
                        {
                           _loc7_.next = _loc6_.next;
                           _loc6_.next = _loc7_;
                        }
                        _loc9_.pushmod = _loc9_.modified = true;
                        _loc9_.length = _loc9_.length + 1;
                        _loc7_;
                     }
                  }
               }
               if(_loc8_.child2 != null)
               {
                  if(param1.aabbtest(_loc8_.child2.aabb))
                  {
                     _loc5_ = param1.aabbsect(_loc8_.child2.aabb);
                     if(_loc5_ >= 0 && _loc5_ < _loc4_)
                     {
                        _loc8_.child2.rayt = _loc5_;
                        _loc6_ = null;
                        _loc7_ = openlist.head;
                        while(_loc7_ != null)
                        {
                           _loc16_ = _loc7_.elt;
                           if(_loc8_.child2.rayt < _loc16_.rayt)
                           {
                              break;
                           }
                           _loc6_ = _loc7_;
                           _loc7_ = _loc7_.next;
                        }
                        _loc9_ = openlist;
                        if(ZNPNode_ZPP_AABBNode.zpp_pool == null)
                        {
                           _loc10_ = new ZNPNode_ZPP_AABBNode();
                        }
                        else
                        {
                           _loc10_ = ZNPNode_ZPP_AABBNode.zpp_pool;
                           ZNPNode_ZPP_AABBNode.zpp_pool = _loc10_.next;
                           _loc10_.next = null;
                        }
                        _loc10_.elt = _loc8_.child2;
                        _loc7_ = _loc10_;
                        if(_loc6_ == null)
                        {
                           _loc7_.next = _loc9_.head;
                           _loc9_.head = _loc7_;
                        }
                        else
                        {
                           _loc7_.next = _loc6_.next;
                           _loc6_.next = _loc7_;
                        }
                        _loc9_.pushmod = _loc9_.modified = true;
                        _loc9_.length = _loc9_.length + 1;
                        _loc7_;
                     }
                  }
               }
            }
         }
         openlist.clear();
         return _loc12_;
      }
      
      override public function clear() : void
      {
         var _loc1_:* = null as ZPP_AABBNode;
         var _loc2_:* = null as ZPP_AABBPair;
         var _loc3_:* = null as ZNPList_ZPP_AABBPair;
         var _loc4_:* = null as ZPP_AABBPair;
         var _loc5_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc6_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc9_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc10_:* = null as ZNPNode_ZPP_AABBPair;
         while(syncs != null)
         {
            _loc1_ = syncs.snext;
            syncs.snext = null;
            if(syncs.first_sync)
            {
               syncs.shape.node = null;
               syncs.shape.removedFromSpace();
               syncs.shape = null;
            }
            syncs = _loc1_;
         }
         while(moves != null)
         {
            _loc1_ = moves.mnext;
            moves.mnext = null;
            if(moves.first_sync)
            {
               moves.shape.node = null;
               moves.shape.removedFromSpace();
               moves.shape = null;
            }
            moves = _loc1_;
         }
         while(pairs != null)
         {
            _loc2_ = pairs.next;
            if(pairs.arb != null)
            {
               pairs.arb.pair = null;
            }
            pairs.arb = null;
            _loc3_ = pairs.n1.shape.pairs;
            _loc4_ = pairs;
            _loc5_ = null;
            _loc6_ = _loc3_.head;
            _loc7_ = false;
            while(_loc6_ != null)
            {
               if(_loc6_.elt == _loc4_)
               {
                  if(_loc5_ == null)
                  {
                     _loc8_ = _loc3_.head;
                     _loc9_ = _loc8_.next;
                     _loc3_.head = _loc9_;
                     if(_loc3_.head == null)
                     {
                        _loc3_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc8_ = _loc5_.next;
                     _loc9_ = _loc8_.next;
                     _loc5_.next = _loc9_;
                     if(_loc9_ == null)
                     {
                        _loc3_.pushmod = true;
                     }
                  }
                  _loc10_ = _loc8_;
                  _loc10_.elt = null;
                  _loc10_.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                  ZNPNode_ZPP_AABBPair.zpp_pool = _loc10_;
                  _loc3_.modified = true;
                  _loc3_.length = _loc3_.length - 1;
                  _loc3_.pushmod = true;
                  _loc9_;
                  _loc7_ = true;
                  break;
               }
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.next;
            }
            _loc7_;
            _loc3_ = pairs.n2.shape.pairs;
            _loc4_ = pairs;
            _loc5_ = null;
            _loc6_ = _loc3_.head;
            _loc7_ = false;
            while(_loc6_ != null)
            {
               if(_loc6_.elt == _loc4_)
               {
                  if(_loc5_ == null)
                  {
                     _loc8_ = _loc3_.head;
                     _loc9_ = _loc8_.next;
                     _loc3_.head = _loc9_;
                     if(_loc3_.head == null)
                     {
                        _loc3_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc8_ = _loc5_.next;
                     _loc9_ = _loc8_.next;
                     _loc5_.next = _loc9_;
                     if(_loc9_ == null)
                     {
                        _loc3_.pushmod = true;
                     }
                  }
                  _loc10_ = _loc8_;
                  _loc10_.elt = null;
                  _loc10_.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                  ZNPNode_ZPP_AABBPair.zpp_pool = _loc10_;
                  _loc3_.modified = true;
                  _loc3_.length = _loc3_.length - 1;
                  _loc3_.pushmod = true;
                  _loc9_;
                  _loc7_ = true;
                  break;
               }
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.next;
            }
            _loc7_;
            _loc4_ = pairs;
            _loc4_.n1 = _loc4_.n2 = null;
            _loc4_.sleeping = false;
            _loc4_.next = ZPP_AABBPair.zpp_pool;
            ZPP_AABBPair.zpp_pool = _loc4_;
            pairs = _loc2_;
         }
         dtree.clear();
         stree.clear();
      }
      
      override public function broadphase(param1:ZPP_Space, param2:Boolean) : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 5892
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      override public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
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
         if(stree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(stree.root);
            while(treeStack.head != null)
            {
               _loc9_ = treeStack.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc5_.x >= _loc10_.minx && _loc5_.x <= _loc10_.maxx && _loc5_.y >= _loc10_.miny && _loc5_.y <= _loc10_.maxy)
               {
                  if(_loc9_.child1 == null)
                  {
                     _loc11_ = _loc9_.shape.body.outer;
                     if(!_loc8_.has(_loc11_))
                     {
                        if(param3 == null || (_loc12_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc12_.collisionGroup) != 0)
                        {
                           if(_loc9_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              if(ZPP_Collide.circleContains(_loc9_.shape.circle,_loc5_))
                              {
                                 _loc8_.push(_loc11_);
                              }
                           }
                           else if(ZPP_Collide.polyContains(_loc9_.shape.polygon,_loc5_))
                           {
                              _loc8_.push(_loc11_);
                           }
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        treeStack.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        treeStack.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(dtree.root);
            while(treeStack.head != null)
            {
               _loc9_ = treeStack.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc5_.x >= _loc10_.minx && _loc5_.x <= _loc10_.maxx && _loc5_.y >= _loc10_.miny && _loc5_.y <= _loc10_.maxy)
               {
                  if(_loc9_.child1 == null)
                  {
                     _loc11_ = _loc9_.shape.body.outer;
                     if(!_loc8_.has(_loc11_))
                     {
                        if(param3 == null || (_loc12_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc12_.collisionGroup) != 0)
                        {
                           if(_loc9_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              if(ZPP_Collide.circleContains(_loc9_.shape.circle,_loc5_))
                              {
                                 _loc8_.push(_loc11_);
                              }
                           }
                           else if(ZPP_Collide.polyContains(_loc9_.shape.polygon,_loc5_))
                           {
                              _loc8_.push(_loc11_);
                           }
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        treeStack.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        treeStack.add(_loc9_.child2);
                     }
                  }
               }
            }
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
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as Body;
         var _loc10_:* = null as ZPP_InteractionFilter;
         var _loc11_:Boolean = false;
         sync_broadphase();
         validateShape(param1);
         var _loc5_:ZPP_AABB = param1.aabb;
         var _loc6_:BodyList = param4 == null ? new BodyList() : param4;
         if(failed == null)
         {
            failed = new BodyList();
         }
         if(stree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(stree.root);
            while(treeStack.head != null)
            {
               _loc7_ = treeStack.pop_unsafe();
               _loc8_ = _loc7_.aabb;
               if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx)
               {
                  if(_loc7_.child1 == null)
                  {
                     _loc9_ = _loc7_.shape.body.outer;
                     if(param3 == null || (_loc10_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc10_.collisionGroup) != 0)
                     {
                        if(param2)
                        {
                           if(!failed.has(_loc9_))
                           {
                              _loc11_ = ZPP_Collide.containTest(param1,_loc7_.shape);
                              if(!_loc6_.has(_loc9_) && _loc11_)
                              {
                                 _loc6_.push(_loc9_);
                              }
                              else if(!_loc11_)
                              {
                                 _loc6_.remove(_loc9_);
                                 failed.push(_loc9_);
                              }
                           }
                        }
                        else if(!_loc6_.has(_loc9_) && ZPP_Collide.testCollide_safe(_loc7_.shape,param1))
                        {
                           _loc6_.push(_loc9_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_.child1 != null)
                     {
                        treeStack.add(_loc7_.child1);
                     }
                     if(_loc7_.child2 != null)
                     {
                        treeStack.add(_loc7_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(dtree.root);
            while(treeStack.head != null)
            {
               _loc7_ = treeStack.pop_unsafe();
               _loc8_ = _loc7_.aabb;
               if(_loc5_.miny <= _loc8_.maxy && _loc8_.miny <= _loc5_.maxy && _loc5_.minx <= _loc8_.maxx && _loc8_.minx <= _loc5_.maxx)
               {
                  if(_loc7_.child1 == null)
                  {
                     _loc9_ = _loc7_.shape.body.outer;
                     if(param3 == null || (_loc10_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc10_.collisionGroup) != 0)
                     {
                        if(param2)
                        {
                           if(!failed.has(_loc9_))
                           {
                              _loc11_ = ZPP_Collide.containTest(param1,_loc7_.shape);
                              if(!_loc6_.has(_loc9_) && _loc11_)
                              {
                                 _loc6_.push(_loc9_);
                              }
                              else if(!_loc11_)
                              {
                                 _loc6_.remove(_loc9_);
                                 failed.push(_loc9_);
                              }
                           }
                        }
                        else if(!_loc6_.has(_loc9_) && ZPP_Collide.testCollide_safe(_loc7_.shape,param1))
                        {
                           _loc6_.push(_loc9_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_.child1 != null)
                     {
                        treeStack.add(_loc7_.child1);
                     }
                     if(_loc7_.child2 != null)
                     {
                        treeStack.add(_loc7_.child2);
                     }
                  }
               }
            }
         }
         failed.clear();
         return _loc6_;
      }
      
      override public function bodiesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:BodyList) : BodyList
      {
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as Body;
         var _loc12_:* = null as ZPP_InteractionFilter;
         var _loc13_:Boolean = false;
         sync_broadphase();
         updateCircShape(param1,param2,param3);
         var _loc7_:ZPP_AABB = circShape.zpp_inner.aabb;
         var _loc8_:BodyList = param6 == null ? new BodyList() : param6;
         if(failed == null)
         {
            failed = new BodyList();
         }
         if(stree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(stree.root);
            while(treeStack.head != null)
            {
               _loc9_ = treeStack.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc7_.miny <= _loc10_.maxy && _loc10_.miny <= _loc7_.maxy && _loc7_.minx <= _loc10_.maxx && _loc10_.minx <= _loc7_.maxx)
               {
                  if(_loc9_.child1 == null)
                  {
                     _loc11_ = _loc9_.shape.body.outer;
                     if(param5 == null || (_loc12_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc12_.collisionGroup) != 0)
                     {
                        if(param4)
                        {
                           if(!failed.has(_loc11_))
                           {
                              _loc13_ = ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape);
                              if(!_loc8_.has(_loc11_) && _loc13_)
                              {
                                 _loc8_.push(_loc11_);
                              }
                              else if(!_loc13_)
                              {
                                 _loc8_.remove(_loc11_);
                                 failed.push(_loc11_);
                              }
                           }
                        }
                        else if(!_loc8_.has(_loc11_) && ZPP_Collide.testCollide_safe(_loc9_.shape,circShape.zpp_inner))
                        {
                           _loc8_.push(_loc11_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        treeStack.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        treeStack.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(dtree.root);
            while(treeStack.head != null)
            {
               _loc9_ = treeStack.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc7_.miny <= _loc10_.maxy && _loc10_.miny <= _loc7_.maxy && _loc7_.minx <= _loc10_.maxx && _loc10_.minx <= _loc7_.maxx)
               {
                  if(_loc9_.child1 == null)
                  {
                     _loc11_ = _loc9_.shape.body.outer;
                     if(param5 == null || (_loc12_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc12_.collisionGroup) != 0)
                     {
                        if(param4)
                        {
                           if(!failed.has(_loc11_))
                           {
                              _loc13_ = ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape);
                              if(!_loc8_.has(_loc11_) && _loc13_)
                              {
                                 _loc8_.push(_loc11_);
                              }
                              else if(!_loc13_)
                              {
                                 _loc8_.remove(_loc11_);
                                 failed.push(_loc11_);
                              }
                           }
                        }
                        else if(!_loc8_.has(_loc11_) && ZPP_Collide.testCollide_safe(_loc9_.shape,circShape.zpp_inner))
                        {
                           _loc8_.push(_loc11_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        treeStack.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        treeStack.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         failed.clear();
         return _loc8_;
      }
      
      override public function bodiesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
      {
         var _loc8_:* = null as ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABB;
         var _loc10_:* = null as ZPP_InteractionFilter;
         var _loc11_:* = null as Body;
         var _loc12_:* = null as ZPP_AABBNode;
         var _loc13_:Boolean = false;
         sync_broadphase();
         updateAABBShape(param1);
         var _loc6_:ZPP_AABB = aabbShape.zpp_inner.aabb;
         var _loc7_:BodyList = param5 == null ? new BodyList() : param5;
         if(failed == null)
         {
            failed = new BodyList();
         }
         if(stree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(stree.root);
            while(treeStack.head != null)
            {
               _loc8_ = treeStack.pop_unsafe();
               _loc9_ = _loc8_.aabb;
               if(_loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy)
               {
                  if(_loc8_.child1 == null)
                  {
                     if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                     {
                        _loc11_ = _loc8_.shape.body.outer;
                        if(!_loc7_.has(_loc11_))
                        {
                           _loc7_.push(_loc11_);
                        }
                     }
                  }
                  else
                  {
                     if(treeStack2 == null)
                     {
                        treeStack2 = new ZNPList_ZPP_AABBNode();
                     }
                     treeStack2.add(_loc8_);
                     while(treeStack2.head != null)
                     {
                        _loc12_ = treeStack2.pop_unsafe();
                        if(_loc12_.child1 == null)
                        {
                           if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                           {
                              _loc11_ = _loc12_.shape.body.outer;
                              if(!_loc7_.has(_loc11_))
                              {
                                 _loc7_.push(_loc11_);
                              }
                           }
                        }
                        else
                        {
                           if(_loc12_.child1 != null)
                           {
                              treeStack2.add(_loc12_.child1);
                           }
                           if(_loc12_.child2 != null)
                           {
                              treeStack2.add(_loc12_.child2);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.aabb;
                  if(_loc6_.miny <= _loc9_.maxy && _loc9_.miny <= _loc6_.maxy && _loc6_.minx <= _loc9_.maxx && _loc9_.minx <= _loc6_.maxx)
                  {
                     if(_loc8_.child1 == null)
                     {
                        _loc11_ = _loc8_.shape.body.outer;
                        if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                        {
                           if(param2)
                           {
                              if(param3)
                              {
                                 if(!failed.has(_loc11_))
                                 {
                                    _loc13_ = ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape);
                                    if(!_loc7_.has(_loc11_) && _loc13_)
                                    {
                                       _loc7_.push(_loc11_);
                                    }
                                    else if(!_loc13_)
                                    {
                                       _loc7_.remove(_loc11_);
                                       failed.push(_loc11_);
                                    }
                                 }
                              }
                              else if(!_loc7_.has(_loc11_) && ZPP_Collide.testCollide_safe(_loc8_.shape,aabbShape.zpp_inner))
                              {
                                 _loc7_.push(_loc11_);
                              }
                           }
                           else if(param3)
                           {
                              if(!failed.has(_loc11_))
                              {
                                 _loc9_ = _loc8_.shape.aabb;
                                 _loc13_ = _loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy;
                                 if(!_loc7_.has(_loc11_) && _loc13_)
                                 {
                                    _loc7_.push(_loc11_);
                                 }
                                 else if(!_loc13_)
                                 {
                                    _loc7_.remove(_loc11_);
                                    failed.push(_loc11_);
                                 }
                              }
                           }
                           else if(!_loc7_.has(_loc11_) && (_loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy))
                           {
                              _loc7_.push(_loc11_);
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_.child1 != null)
                        {
                           treeStack.add(_loc8_.child1);
                        }
                        if(_loc8_.child2 != null)
                        {
                           treeStack.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            if(treeStack == null)
            {
               treeStack = new ZNPList_ZPP_AABBNode();
            }
            treeStack.add(dtree.root);
            while(treeStack.head != null)
            {
               _loc8_ = treeStack.pop_unsafe();
               _loc9_ = _loc8_.aabb;
               if(_loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy)
               {
                  if(_loc8_.child1 == null)
                  {
                     if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                     {
                        _loc11_ = _loc8_.shape.body.outer;
                        if(!_loc7_.has(_loc11_))
                        {
                           _loc7_.push(_loc11_);
                        }
                     }
                  }
                  else
                  {
                     if(treeStack2 == null)
                     {
                        treeStack2 = new ZNPList_ZPP_AABBNode();
                     }
                     treeStack2.add(_loc8_);
                     while(treeStack2.head != null)
                     {
                        _loc12_ = treeStack2.pop_unsafe();
                        if(_loc12_.child1 == null)
                        {
                           if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                           {
                              _loc11_ = _loc12_.shape.body.outer;
                              if(!_loc7_.has(_loc11_))
                              {
                                 _loc7_.push(_loc11_);
                              }
                           }
                        }
                        else
                        {
                           if(_loc12_.child1 != null)
                           {
                              treeStack2.add(_loc12_.child1);
                           }
                           if(_loc12_.child2 != null)
                           {
                              treeStack2.add(_loc12_.child2);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.aabb;
                  if(_loc6_.miny <= _loc9_.maxy && _loc9_.miny <= _loc6_.maxy && _loc6_.minx <= _loc9_.maxx && _loc9_.minx <= _loc6_.maxx)
                  {
                     if(_loc8_.child1 == null)
                     {
                        _loc11_ = _loc8_.shape.body.outer;
                        if(param4 == null || (_loc10_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc10_.collisionGroup) != 0)
                        {
                           if(param2)
                           {
                              if(param3)
                              {
                                 if(!failed.has(_loc11_))
                                 {
                                    _loc13_ = ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape);
                                    if(!_loc7_.has(_loc11_) && _loc13_)
                                    {
                                       _loc7_.push(_loc11_);
                                    }
                                    else if(!_loc13_)
                                    {
                                       _loc7_.remove(_loc11_);
                                       failed.push(_loc11_);
                                    }
                                 }
                              }
                              else if(!_loc7_.has(_loc11_) && ZPP_Collide.testCollide_safe(_loc8_.shape,aabbShape.zpp_inner))
                              {
                                 _loc7_.push(_loc11_);
                              }
                           }
                           else if(param3)
                           {
                              if(!failed.has(_loc11_))
                              {
                                 _loc9_ = _loc8_.shape.aabb;
                                 _loc13_ = _loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy;
                                 if(!_loc7_.has(_loc11_) && _loc13_)
                                 {
                                    _loc7_.push(_loc11_);
                                 }
                                 else if(!_loc13_)
                                 {
                                    _loc7_.remove(_loc11_);
                                    failed.push(_loc11_);
                                 }
                              }
                           }
                           else if(!_loc7_.has(_loc11_) && (_loc9_.minx >= _loc6_.minx && _loc9_.miny >= _loc6_.miny && _loc9_.maxx <= _loc6_.maxx && _loc9_.maxy <= _loc6_.maxy))
                           {
                              _loc7_.push(_loc11_);
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_.child1 != null)
                        {
                           treeStack.add(_loc8_.child1);
                        }
                        if(_loc8_.child2 != null)
                        {
                           treeStack.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         failed.clear();
         return _loc7_;
      }
      
      public function __remove(param1:ZPP_Shape) : void
      {
         var _loc3_:* = null as ZPP_AABBNode;
         var _loc4_:* = null as ZPP_AABBNode;
         var _loc7_:* = null as ZPP_AABBPair;
         var _loc8_:* = null as ZPP_AABBPair;
         var _loc2_:ZPP_AABBNode = param1.node;
         if(!_loc2_.first_sync)
         {
            if(_loc2_.dyn)
            {
               dtree.removeLeaf(_loc2_);
            }
            else
            {
               stree.removeLeaf(_loc2_);
            }
         }
         param1.node = null;
         if(_loc2_.synced)
         {
            _loc3_ = null;
            _loc4_ = syncs;
            while(_loc4_ != null)
            {
               if(_loc4_ == _loc2_)
               {
                  break;
               }
               _loc3_ = _loc4_;
               _loc4_ = _loc4_.snext;
            }
            if(_loc3_ == null)
            {
               syncs = _loc4_.snext;
            }
            else
            {
               _loc3_.snext = _loc4_.snext;
            }
            _loc4_.snext = null;
            _loc2_.synced = false;
         }
         if(_loc2_.moved)
         {
            _loc3_ = null;
            _loc4_ = moves;
            while(_loc4_ != null)
            {
               if(_loc4_ == _loc2_)
               {
                  break;
               }
               _loc3_ = _loc4_;
               _loc4_ = _loc4_.mnext;
            }
            if(_loc3_ == null)
            {
               moves = _loc4_.mnext;
            }
            else
            {
               _loc3_.mnext = _loc4_.mnext;
            }
            _loc4_.mnext = null;
            _loc2_.moved = false;
         }
         var _loc5_:* = null;
         var _loc6_:ZPP_AABBPair = pairs;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.next;
            if(_loc6_.n1 == _loc2_ || _loc6_.n2 == _loc2_)
            {
               if(_loc5_ == null)
               {
                  pairs = _loc7_;
               }
               else
               {
                  _loc5_.next = _loc7_;
               }
               if(_loc6_.arb != null)
               {
                  _loc6_.arb.pair = null;
               }
               _loc6_.arb = null;
               _loc6_.n1.shape.pairs.remove(_loc6_);
               _loc6_.n2.shape.pairs.remove(_loc6_);
               _loc8_ = _loc6_;
               _loc8_.n1 = _loc8_.n2 = null;
               _loc8_.sleeping = false;
               _loc8_.next = ZPP_AABBPair.zpp_pool;
               ZPP_AABBPair.zpp_pool = _loc8_;
               _loc6_ = _loc7_;
            }
            else
            {
               _loc5_ = _loc6_;
               _loc6_ = _loc7_;
            }
         }
         while(param1.pairs.head != null)
         {
            _loc7_ = param1.pairs.pop_unsafe();
            if(_loc7_.n1 == _loc2_)
            {
               _loc7_.n2.shape.pairs.remove(_loc7_);
            }
            else
            {
               _loc7_.n1.shape.pairs.remove(_loc7_);
            }
            if(_loc7_.arb != null)
            {
               _loc7_.arb.pair = null;
            }
            _loc7_.arb = null;
            _loc8_ = _loc7_;
            _loc8_.n1 = _loc8_.n2 = null;
            _loc8_.sleeping = false;
            _loc8_.next = ZPP_AABBPair.zpp_pool;
            ZPP_AABBPair.zpp_pool = _loc8_;
         }
         _loc3_ = _loc2_;
         _loc3_.height = -1;
         var _loc9_:ZPP_AABB = _loc3_.aabb;
         if(_loc9_.outer != null)
         {
            _loc9_.outer.zpp_inner = null;
            _loc9_.outer = null;
         }
         _loc9_.wrap_max = null;
         _loc9_.wrap_min = null;
         _loc9_._invalidate = null;
         _loc9_._validate = null;
         _loc9_.next = ZPP_AABB.zpp_pool;
         ZPP_AABB.zpp_pool = _loc9_;
         _loc3_.child1 = _loc3_.child2 = _loc3_.parent = null;
         _loc3_.next = null;
         _loc3_.snext = null;
         _loc3_.mnext = null;
         _loc3_.next = ZPP_AABBNode.zpp_pool;
         ZPP_AABBNode.zpp_pool = _loc3_;
      }
      
      public function __insert(param1:ZPP_Shape) : void
      {
         var _loc2_:* = null as ZPP_AABBNode;
         if(ZPP_AABBNode.zpp_pool == null)
         {
            _loc2_ = new ZPP_AABBNode();
         }
         else
         {
            _loc2_ = ZPP_AABBNode.zpp_pool;
            ZPP_AABBNode.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc2_.aabb = new ZPP_AABB();
         }
         else
         {
            _loc2_.aabb = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc2_.aabb.next;
            _loc2_.aabb.next = null;
         }
         _loc2_.moved = false;
         _loc2_.synced = false;
         _loc2_.first_sync = false;
         _loc2_.shape = param1;
         param1.node = _loc2_;
         _loc2_.synced = true;
         _loc2_.first_sync = true;
         _loc2_.snext = syncs;
         syncs = _loc2_;
      }
   }
}
