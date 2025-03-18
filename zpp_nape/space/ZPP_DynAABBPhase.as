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
         var _loc1_:* = null as ZPP_AABBNode;
         var _loc2_:* = null as ZPP_Shape;
         var _loc3_:* = null as ZPP_AABBTree;
         var _loc4_:* = null as ZPP_AABBNode;
         var _loc5_:* = null as ZPP_AABBNode;
         var _loc6_:* = null as ZPP_AABBNode;
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_AABBNode;
         var _loc11_:* = null as ZPP_AABBNode;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_AABBNode;
         var _loc14_:* = null as ZPP_AABBNode;
         var _loc15_:* = null as ZPP_AABB;
         var _loc16_:* = null as ZPP_AABB;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:* = null as ZPP_Circle;
         var _loc20_:* = null as ZPP_Polygon;
         var _loc21_:Number = NaN;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as ZPP_Vec2;
         var _loc25_:* = null as ZPP_Vec2;
         var _loc26_:Number = NaN;
         var _loc27_:* = null as ZPP_Vec2;
         var _loc28_:* = null as ZPP_Body;
         var _loc29_:Boolean = false;
         var _loc30_:* = null as ZPP_AABB;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:* = null as ZPP_AABB;
         space.validation();
         if(syncs != null)
         {
            if(moves == null)
            {
               _loc1_ = syncs;
               while(_loc1_ != null)
               {
                  _loc2_ = _loc1_.shape;
                  if(!_loc1_.first_sync)
                  {
                     _loc3_ = _loc1_.dyn ? dtree : stree;
                     if(_loc1_ == _loc3_.root)
                     {
                        _loc3_.root = null;
                        null;
                     }
                     else
                     {
                        _loc4_ = _loc1_.parent;
                        _loc5_ = _loc4_.parent;
                        _loc6_ = _loc4_.child1 == _loc1_ ? _loc4_.child2 : _loc4_.child1;
                        if(_loc5_ != null)
                        {
                           if(_loc5_.child1 == _loc4_)
                           {
                              _loc5_.child1 = _loc6_;
                           }
                           else
                           {
                              _loc5_.child2 = _loc6_;
                           }
                           _loc6_.parent = _loc5_;
                           _loc7_ = _loc4_;
                           _loc7_.height = -1;
                           _loc8_ = _loc7_.aabb;
                           if(_loc8_.outer != null)
                           {
                              _loc8_.outer.zpp_inner = null;
                              _loc8_.outer = null;
                           }
                           _loc8_.wrap_min = _loc8_.wrap_max = null;
                           _loc8_._invalidate = null;
                           _loc8_._validate = null;
                           _loc8_.next = ZPP_AABB.zpp_pool;
                           ZPP_AABB.zpp_pool = _loc8_;
                           _loc7_.child1 = _loc7_.child2 = _loc7_.parent = null;
                           _loc7_.next = null;
                           _loc7_.snext = null;
                           _loc7_.mnext = null;
                           _loc7_.next = ZPP_AABBNode.zpp_pool;
                           ZPP_AABBNode.zpp_pool = _loc7_;
                           _loc7_ = _loc5_;
                           while(_loc7_ != null)
                           {
                              if(_loc7_.child1 == null || _loc7_.height < 2)
                              {
                                 §§push(_loc7_);
                              }
                              else
                              {
                                 _loc10_ = _loc7_.child1;
                                 _loc11_ = _loc7_.child2;
                                 _loc12_ = _loc11_.height - _loc10_.height;
                                 if(_loc12_ > 1)
                                 {
                                    _loc13_ = _loc11_.child1;
                                    _loc14_ = _loc11_.child2;
                                    _loc11_.child1 = _loc7_;
                                    _loc11_.parent = _loc7_.parent;
                                    _loc7_.parent = _loc11_;
                                    if(_loc11_.parent != null)
                                    {
                                       if(_loc11_.parent.child1 == _loc7_)
                                       {
                                          _loc11_.parent.child1 = _loc11_;
                                       }
                                       else
                                       {
                                          _loc11_.parent.child2 = _loc11_;
                                       }
                                    }
                                    else
                                    {
                                       _loc3_.root = _loc11_;
                                    }
                                    if(_loc13_.height > _loc14_.height)
                                    {
                                       _loc11_.child2 = _loc13_;
                                       _loc7_.child2 = _loc14_;
                                       _loc14_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc10_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc8_ = _loc11_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc17_ = _loc10_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc11_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                    }
                                    else
                                    {
                                       _loc11_.child2 = _loc14_;
                                       _loc7_.child2 = _loc13_;
                                       _loc13_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc10_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc8_ = _loc11_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc17_ = _loc10_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc11_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                    }
                                    §§push(_loc11_);
                                 }
                                 else if(_loc12_ < -1)
                                 {
                                    _loc13_ = _loc10_.child1;
                                    _loc14_ = _loc10_.child2;
                                    _loc10_.child1 = _loc7_;
                                    _loc10_.parent = _loc7_.parent;
                                    _loc7_.parent = _loc10_;
                                    if(_loc10_.parent != null)
                                    {
                                       if(_loc10_.parent.child1 == _loc7_)
                                       {
                                          _loc10_.parent.child1 = _loc10_;
                                       }
                                       else
                                       {
                                          _loc10_.parent.child2 = _loc10_;
                                       }
                                    }
                                    else
                                    {
                                       _loc3_.root = _loc10_;
                                    }
                                    if(_loc13_.height > _loc14_.height)
                                    {
                                       _loc10_.child2 = _loc13_;
                                       _loc7_.child1 = _loc14_;
                                       _loc14_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc11_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc8_ = _loc10_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc17_ = _loc11_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc10_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                    }
                                    else
                                    {
                                       _loc10_.child2 = _loc14_;
                                       _loc7_.child1 = _loc13_;
                                       _loc13_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc11_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc8_ = _loc10_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc17_ = _loc11_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc10_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                    }
                                    §§push(_loc10_);
                                 }
                                 else
                                 {
                                    §§push(_loc7_);
                                 }
                              }
                              _loc7_ = §§pop();
                              _loc10_ = _loc7_.child1;
                              _loc11_ = _loc7_.child2;
                              _loc8_ = _loc7_.aabb;
                              _loc15_ = _loc10_.aabb;
                              _loc16_ = _loc11_.aabb;
                              _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                              _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                              _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                              _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                              _loc12_ = _loc10_.height;
                              _loc17_ = _loc11_.height;
                              _loc7_.height = 1 + (_loc12_ > _loc17_ ? _loc12_ : _loc17_);
                              _loc7_ = _loc7_.parent;
                           }
                        }
                        else
                        {
                           _loc3_.root = _loc6_;
                           _loc6_.parent = null;
                           _loc7_ = _loc4_;
                           _loc7_.height = -1;
                           _loc8_ = _loc7_.aabb;
                           if(_loc8_.outer != null)
                           {
                              _loc8_.outer.zpp_inner = null;
                              _loc8_.outer = null;
                           }
                           _loc8_.wrap_min = _loc8_.wrap_max = null;
                           _loc8_._invalidate = null;
                           _loc8_._validate = null;
                           _loc8_.next = ZPP_AABB.zpp_pool;
                           ZPP_AABB.zpp_pool = _loc8_;
                           _loc7_.child1 = _loc7_.child2 = _loc7_.parent = null;
                           _loc7_.next = null;
                           _loc7_.snext = null;
                           _loc7_.mnext = null;
                           _loc7_.next = ZPP_AABBNode.zpp_pool;
                           ZPP_AABBNode.zpp_pool = _loc7_;
                        }
                     }
                  }
                  else
                  {
                     _loc1_.first_sync = false;
                  }
                  _loc8_ = _loc1_.aabb;
                  if(!space.continuous)
                  {
                     if(_loc2_.zip_aabb)
                     {
                        if(_loc2_.body != null)
                        {
                           _loc2_.zip_aabb = false;
                           if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              _loc19_ = _loc2_.circle;
                              if(_loc19_.zip_worldCOM)
                              {
                                 if(_loc19_.body != null)
                                 {
                                    _loc19_.zip_worldCOM = false;
                                    if(_loc19_.zip_localCOM)
                                    {
                                       _loc19_.zip_localCOM = false;
                                       if(_loc19_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                       {
                                          _loc20_ = _loc19_.polygon;
                                          if(_loc20_.lverts.next == null)
                                          {
                                             Boot.lastError = new Error();
                                             throw "Error: An empty polygon has no meaningful localCOM";
                                          }
                                          if(_loc20_.lverts.next.next == null)
                                          {
                                             _loc20_.localCOMx = _loc20_.lverts.next.x;
                                             _loc20_.localCOMy = _loc20_.lverts.next.y;
                                             null;
                                          }
                                          else if(_loc20_.lverts.next.next.next == null)
                                          {
                                             _loc20_.localCOMx = _loc20_.lverts.next.x;
                                             _loc20_.localCOMy = _loc20_.lverts.next.y;
                                             _loc21_ = 1;
                                             _loc20_.localCOMx += _loc20_.lverts.next.next.x * _loc21_;
                                             _loc20_.localCOMy += _loc20_.lverts.next.next.y * _loc21_;
                                             _loc21_ = 0.5;
                                             _loc20_.localCOMx *= _loc21_;
                                             _loc20_.localCOMy *= _loc21_;
                                          }
                                          else
                                          {
                                             _loc20_.localCOMx = 0;
                                             _loc20_.localCOMy = 0;
                                             _loc21_ = 0;
                                             _loc22_ = _loc20_.lverts.next;
                                             _loc23_ = _loc22_;
                                             _loc22_ = _loc22_.next;
                                             _loc24_ = _loc22_;
                                             _loc22_ = _loc22_.next;
                                             while(_loc22_ != null)
                                             {
                                                _loc25_ = _loc22_;
                                                _loc21_ += _loc24_.x * (_loc25_.y - _loc23_.y);
                                                _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                                _loc20_.localCOMx += (_loc24_.x + _loc25_.x) * _loc26_;
                                                _loc20_.localCOMy += (_loc24_.y + _loc25_.y) * _loc26_;
                                                _loc23_ = _loc24_;
                                                _loc24_ = _loc25_;
                                                _loc22_ = _loc22_.next;
                                             }
                                             _loc22_ = _loc20_.lverts.next;
                                             _loc25_ = _loc22_;
                                             _loc21_ += _loc24_.x * (_loc25_.y - _loc23_.y);
                                             _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                             _loc20_.localCOMx += (_loc24_.x + _loc25_.x) * _loc26_;
                                             _loc20_.localCOMy += (_loc24_.y + _loc25_.y) * _loc26_;
                                             _loc23_ = _loc24_;
                                             _loc24_ = _loc25_;
                                             _loc22_ = _loc22_.next;
                                             _loc27_ = _loc22_;
                                             _loc21_ += _loc24_.x * (_loc27_.y - _loc23_.y);
                                             _loc26_ = _loc27_.y * _loc24_.x - _loc27_.x * _loc24_.y;
                                             _loc20_.localCOMx += (_loc24_.x + _loc27_.x) * _loc26_;
                                             _loc20_.localCOMy += (_loc24_.y + _loc27_.y) * _loc26_;
                                             _loc21_ = 1 / (3 * _loc21_);
                                             _loc26_ = _loc21_;
                                             _loc20_.localCOMx *= _loc26_;
                                             _loc20_.localCOMy *= _loc26_;
                                          }
                                       }
                                    }
                                    _loc28_ = _loc19_.body;
                                    if(_loc28_.zip_axis)
                                    {
                                       _loc28_.zip_axis = false;
                                       _loc28_.axisx = Math.sin(_loc28_.rot);
                                       _loc28_.axisy = Math.cos(_loc28_.rot);
                                       null;
                                    }
                                    _loc19_.worldCOMx = _loc19_.body.posx + (_loc19_.body.axisy * _loc19_.localCOMx - _loc19_.body.axisx * _loc19_.localCOMy);
                                    _loc19_.worldCOMy = _loc19_.body.posy + (_loc19_.localCOMx * _loc19_.body.axisx + _loc19_.localCOMy * _loc19_.body.axisy);
                                 }
                              }
                              _loc21_ = _loc19_.radius;
                              _loc26_ = _loc19_.radius;
                              _loc19_.aabb.minx = _loc19_.worldCOMx - _loc21_;
                              _loc19_.aabb.miny = _loc19_.worldCOMy - _loc26_;
                              _loc19_.aabb.maxx = _loc19_.worldCOMx + _loc21_;
                              _loc19_.aabb.maxy = _loc19_.worldCOMy + _loc26_;
                           }
                           else
                           {
                              _loc20_ = _loc2_.polygon;
                              if(_loc20_.zip_gverts)
                              {
                                 if(_loc20_.body != null)
                                 {
                                    _loc20_.zip_gverts = false;
                                    _loc20_.validate_lverts();
                                    _loc28_ = _loc20_.body;
                                    if(_loc28_.zip_axis)
                                    {
                                       _loc28_.zip_axis = false;
                                       _loc28_.axisx = Math.sin(_loc28_.rot);
                                       _loc28_.axisy = Math.cos(_loc28_.rot);
                                       null;
                                    }
                                    _loc22_ = _loc20_.lverts.next;
                                    _loc23_ = _loc20_.gverts.next;
                                    while(_loc23_ != null)
                                    {
                                       _loc24_ = _loc23_;
                                       _loc25_ = _loc22_;
                                       _loc22_ = _loc22_.next;
                                       _loc24_.x = _loc20_.body.posx + (_loc20_.body.axisy * _loc25_.x - _loc20_.body.axisx * _loc25_.y);
                                       _loc24_.y = _loc20_.body.posy + (_loc25_.x * _loc20_.body.axisx + _loc25_.y * _loc20_.body.axisy);
                                       _loc23_ = _loc23_.next;
                                    }
                                 }
                              }
                              if(_loc20_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful bounds";
                              }
                              _loc22_ = _loc20_.gverts.next;
                              _loc20_.aabb.minx = _loc22_.x;
                              _loc20_.aabb.miny = _loc22_.y;
                              _loc20_.aabb.maxx = _loc22_.x;
                              _loc20_.aabb.maxy = _loc22_.y;
                              _loc23_ = _loc20_.gverts.next.next;
                              while(_loc23_ != null)
                              {
                                 _loc24_ = _loc23_;
                                 if(_loc24_.x < _loc20_.aabb.minx)
                                 {
                                    _loc20_.aabb.minx = _loc24_.x;
                                 }
                                 if(_loc24_.x > _loc20_.aabb.maxx)
                                 {
                                    _loc20_.aabb.maxx = _loc24_.x;
                                 }
                                 if(_loc24_.y < _loc20_.aabb.miny)
                                 {
                                    _loc20_.aabb.miny = _loc24_.y;
                                 }
                                 if(_loc24_.y > _loc20_.aabb.maxy)
                                 {
                                    _loc20_.aabb.maxy = _loc24_.y;
                                 }
                                 _loc23_ = _loc23_.next;
                              }
                           }
                        }
                     }
                  }
                  _loc15_ = _loc2_.aabb;
                  _loc8_.minx = _loc15_.minx - 3;
                  _loc8_.miny = _loc15_.miny - 3;
                  _loc8_.maxx = _loc15_.maxx + 3;
                  _loc8_.maxy = _loc15_.maxy + 3;
                  _loc3_ = !!(_loc1_.dyn = _loc2_.body.type == ZPP_Flags.id_BodyType_STATIC ? false : !_loc2_.body.component.sleeping) ? dtree : stree;
                  if(_loc3_.root == null)
                  {
                     _loc3_.root = _loc1_;
                     _loc3_.root.parent = null;
                  }
                  else
                  {
                     _loc15_ = _loc1_.aabb;
                     _loc4_ = _loc3_.root;
                     while(_loc4_.child1 != null)
                     {
                        _loc5_ = _loc4_.child1;
                        _loc6_ = _loc4_.child2;
                        _loc16_ = _loc4_.aabb;
                        _loc21_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc4_.aabb;
                        _loc16_.minx = _loc30_.minx < _loc15_.minx ? _loc30_.minx : _loc15_.minx;
                        _loc16_.miny = _loc30_.miny < _loc15_.miny ? _loc30_.miny : _loc15_.miny;
                        _loc16_.maxx = _loc30_.maxx > _loc15_.maxx ? _loc30_.maxx : _loc15_.maxx;
                        _loc16_.maxy = _loc30_.maxy > _loc15_.maxy ? _loc30_.maxy : _loc15_.maxy;
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc26_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                        _loc31_ = 2 * _loc26_;
                        _loc32_ = 2 * (_loc26_ - _loc21_);
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc5_.aabb;
                        _loc16_.minx = _loc15_.minx < _loc30_.minx ? _loc15_.minx : _loc30_.minx;
                        _loc16_.miny = _loc15_.miny < _loc30_.miny ? _loc15_.miny : _loc30_.miny;
                        _loc16_.maxx = _loc15_.maxx > _loc30_.maxx ? _loc15_.maxx : _loc30_.maxx;
                        _loc16_.maxy = _loc15_.maxy > _loc30_.maxy ? _loc15_.maxy : _loc30_.maxy;
                        _loc33_ = _loc5_.child1 == null ? (_loc16_ = ZPP_AABBTree.tmpaabb, (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_) : (_loc16_ = _loc5_.aabb, _loc34_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2, _loc16_ = ZPP_AABBTree.tmpaabb, _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2, _loc35_ - _loc34_ + _loc32_);
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc6_.aabb;
                        _loc16_.minx = _loc15_.minx < _loc30_.minx ? _loc15_.minx : _loc30_.minx;
                        _loc16_.miny = _loc15_.miny < _loc30_.miny ? _loc15_.miny : _loc30_.miny;
                        _loc16_.maxx = _loc15_.maxx > _loc30_.maxx ? _loc15_.maxx : _loc30_.maxx;
                        _loc16_.maxy = _loc15_.maxy > _loc30_.maxy ? _loc15_.maxy : _loc30_.maxy;
                        _loc34_ = _loc6_.child1 == null ? (_loc16_ = ZPP_AABBTree.tmpaabb, (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_) : (_loc16_ = _loc6_.aabb, _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2, _loc16_ = ZPP_AABBTree.tmpaabb, _loc36_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2, _loc36_ - _loc35_ + _loc32_);
                        if(_loc31_ < _loc33_ && _loc31_ < _loc34_)
                        {
                           break;
                        }
                        _loc4_ = _loc33_ < _loc34_ ? _loc5_ : _loc6_;
                     }
                     _loc5_ = _loc4_;
                     _loc6_ = _loc5_.parent;
                     if(ZPP_AABBNode.zpp_pool == null)
                     {
                        _loc7_ = new ZPP_AABBNode();
                     }
                     else
                     {
                        _loc7_ = ZPP_AABBNode.zpp_pool;
                        ZPP_AABBNode.zpp_pool = _loc7_.next;
                        _loc7_.next = null;
                     }
                     if(ZPP_AABB.zpp_pool == null)
                     {
                        _loc7_.aabb = new ZPP_AABB();
                     }
                     else
                     {
                        _loc7_.aabb = ZPP_AABB.zpp_pool;
                        ZPP_AABB.zpp_pool = _loc7_.aabb.next;
                        _loc7_.aabb.next = null;
                     }
                     null;
                     _loc7_.moved = false;
                     _loc7_.synced = false;
                     _loc7_.first_sync = false;
                     _loc7_.parent = _loc6_;
                     _loc16_ = _loc7_.aabb;
                     _loc30_ = _loc5_.aabb;
                     _loc16_.minx = _loc15_.minx < _loc30_.minx ? _loc15_.minx : _loc30_.minx;
                     _loc16_.miny = _loc15_.miny < _loc30_.miny ? _loc15_.miny : _loc30_.miny;
                     _loc16_.maxx = _loc15_.maxx > _loc30_.maxx ? _loc15_.maxx : _loc30_.maxx;
                     _loc16_.maxy = _loc15_.maxy > _loc30_.maxy ? _loc15_.maxy : _loc30_.maxy;
                     _loc7_.height = _loc5_.height + 1;
                     if(_loc6_ != null)
                     {
                        if(_loc6_.child1 == _loc5_)
                        {
                           _loc6_.child1 = _loc7_;
                        }
                        else
                        {
                           _loc6_.child2 = _loc7_;
                        }
                        _loc7_.child1 = _loc5_;
                        _loc7_.child2 = _loc1_;
                        _loc5_.parent = _loc7_;
                        _loc1_.parent = _loc7_;
                     }
                     else
                     {
                        _loc7_.child1 = _loc5_;
                        _loc7_.child2 = _loc1_;
                        _loc5_.parent = _loc7_;
                        _loc1_.parent = _loc7_;
                        _loc3_.root = _loc7_;
                     }
                     _loc4_ = _loc1_.parent;
                     while(_loc4_ != null)
                     {
                        if(_loc4_.child1 == null || _loc4_.height < 2)
                        {
                           §§push(_loc4_);
                        }
                        else
                        {
                           _loc10_ = _loc4_.child1;
                           _loc11_ = _loc4_.child2;
                           _loc12_ = _loc11_.height - _loc10_.height;
                           if(_loc12_ > 1)
                           {
                              _loc13_ = _loc11_.child1;
                              _loc14_ = _loc11_.child2;
                              _loc11_.child1 = _loc4_;
                              _loc11_.parent = _loc4_.parent;
                              _loc4_.parent = _loc11_;
                              if(_loc11_.parent != null)
                              {
                                 if(_loc11_.parent.child1 == _loc4_)
                                 {
                                    _loc11_.parent.child1 = _loc11_;
                                 }
                                 else
                                 {
                                    _loc11_.parent.child2 = _loc11_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc11_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc11_.child2 = _loc13_;
                                 _loc4_.child2 = _loc14_;
                                 _loc14_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc10_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc16_ = _loc11_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                              }
                              else
                              {
                                 _loc11_.child2 = _loc14_;
                                 _loc4_.child2 = _loc13_;
                                 _loc13_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc10_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc16_ = _loc11_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                              }
                              §§push(_loc11_);
                           }
                           else if(_loc12_ < -1)
                           {
                              _loc13_ = _loc10_.child1;
                              _loc14_ = _loc10_.child2;
                              _loc10_.child1 = _loc4_;
                              _loc10_.parent = _loc4_.parent;
                              _loc4_.parent = _loc10_;
                              if(_loc10_.parent != null)
                              {
                                 if(_loc10_.parent.child1 == _loc4_)
                                 {
                                    _loc10_.parent.child1 = _loc10_;
                                 }
                                 else
                                 {
                                    _loc10_.parent.child2 = _loc10_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc10_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc10_.child2 = _loc13_;
                                 _loc4_.child1 = _loc14_;
                                 _loc14_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc11_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc16_ = _loc10_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                              }
                              else
                              {
                                 _loc10_.child2 = _loc14_;
                                 _loc4_.child1 = _loc13_;
                                 _loc13_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc11_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc16_ = _loc10_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                              }
                              §§push(_loc10_);
                           }
                           else
                           {
                              §§push(_loc4_);
                           }
                        }
                        _loc4_ = §§pop();
                        _loc10_ = _loc4_.child1;
                        _loc11_ = _loc4_.child2;
                        _loc12_ = _loc10_.height;
                        _loc17_ = _loc11_.height;
                        _loc4_.height = 1 + (_loc12_ > _loc17_ ? _loc12_ : _loc17_);
                        _loc16_ = _loc4_.aabb;
                        _loc30_ = _loc10_.aabb;
                        _loc37_ = _loc11_.aabb;
                        _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                        _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                        _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                        _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                        _loc4_ = _loc4_.parent;
                     }
                  }
                  _loc1_.synced = false;
                  _loc1_.moved = true;
                  _loc1_.mnext = _loc1_.snext;
                  _loc1_.snext = null;
                  _loc1_ = _loc1_.mnext;
               }
               _loc4_ = syncs;
               syncs = moves;
               moves = _loc4_;
            }
            else
            {
               while(syncs != null)
               {
                  _loc4_ = syncs;
                  syncs = _loc4_.snext;
                  _loc4_.snext = null;
                  _loc1_ = _loc4_;
                  _loc2_ = _loc1_.shape;
                  if(!_loc1_.first_sync)
                  {
                     _loc3_ = _loc1_.dyn ? dtree : stree;
                     if(_loc1_ == _loc3_.root)
                     {
                        _loc3_.root = null;
                        null;
                     }
                     else
                     {
                        _loc4_ = _loc1_.parent;
                        _loc5_ = _loc4_.parent;
                        _loc6_ = _loc4_.child1 == _loc1_ ? _loc4_.child2 : _loc4_.child1;
                        if(_loc5_ != null)
                        {
                           if(_loc5_.child1 == _loc4_)
                           {
                              _loc5_.child1 = _loc6_;
                           }
                           else
                           {
                              _loc5_.child2 = _loc6_;
                           }
                           _loc6_.parent = _loc5_;
                           _loc7_ = _loc4_;
                           _loc7_.height = -1;
                           _loc8_ = _loc7_.aabb;
                           if(_loc8_.outer != null)
                           {
                              _loc8_.outer.zpp_inner = null;
                              _loc8_.outer = null;
                           }
                           _loc8_.wrap_min = _loc8_.wrap_max = null;
                           _loc8_._invalidate = null;
                           _loc8_._validate = null;
                           _loc8_.next = ZPP_AABB.zpp_pool;
                           ZPP_AABB.zpp_pool = _loc8_;
                           _loc7_.child1 = _loc7_.child2 = _loc7_.parent = null;
                           _loc7_.next = null;
                           _loc7_.snext = null;
                           _loc7_.mnext = null;
                           _loc7_.next = ZPP_AABBNode.zpp_pool;
                           ZPP_AABBNode.zpp_pool = _loc7_;
                           _loc7_ = _loc5_;
                           while(_loc7_ != null)
                           {
                              if(_loc7_.child1 == null || _loc7_.height < 2)
                              {
                                 §§push(_loc7_);
                              }
                              else
                              {
                                 _loc10_ = _loc7_.child1;
                                 _loc11_ = _loc7_.child2;
                                 _loc12_ = _loc11_.height - _loc10_.height;
                                 if(_loc12_ > 1)
                                 {
                                    _loc13_ = _loc11_.child1;
                                    _loc14_ = _loc11_.child2;
                                    _loc11_.child1 = _loc7_;
                                    _loc11_.parent = _loc7_.parent;
                                    _loc7_.parent = _loc11_;
                                    if(_loc11_.parent != null)
                                    {
                                       if(_loc11_.parent.child1 == _loc7_)
                                       {
                                          _loc11_.parent.child1 = _loc11_;
                                       }
                                       else
                                       {
                                          _loc11_.parent.child2 = _loc11_;
                                       }
                                    }
                                    else
                                    {
                                       _loc3_.root = _loc11_;
                                    }
                                    if(_loc13_.height > _loc14_.height)
                                    {
                                       _loc11_.child2 = _loc13_;
                                       _loc7_.child2 = _loc14_;
                                       _loc14_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc10_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc8_ = _loc11_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc17_ = _loc10_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc11_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                    }
                                    else
                                    {
                                       _loc11_.child2 = _loc14_;
                                       _loc7_.child2 = _loc13_;
                                       _loc13_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc10_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc8_ = _loc11_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc17_ = _loc10_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc11_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                    }
                                    §§push(_loc11_);
                                 }
                                 else if(_loc12_ < -1)
                                 {
                                    _loc13_ = _loc10_.child1;
                                    _loc14_ = _loc10_.child2;
                                    _loc10_.child1 = _loc7_;
                                    _loc10_.parent = _loc7_.parent;
                                    _loc7_.parent = _loc10_;
                                    if(_loc10_.parent != null)
                                    {
                                       if(_loc10_.parent.child1 == _loc7_)
                                       {
                                          _loc10_.parent.child1 = _loc10_;
                                       }
                                       else
                                       {
                                          _loc10_.parent.child2 = _loc10_;
                                       }
                                    }
                                    else
                                    {
                                       _loc3_.root = _loc10_;
                                    }
                                    if(_loc13_.height > _loc14_.height)
                                    {
                                       _loc10_.child2 = _loc13_;
                                       _loc7_.child1 = _loc14_;
                                       _loc14_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc11_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc8_ = _loc10_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc17_ = _loc11_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc10_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                    }
                                    else
                                    {
                                       _loc10_.child2 = _loc14_;
                                       _loc7_.child1 = _loc13_;
                                       _loc13_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc11_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc8_ = _loc10_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                                       _loc17_ = _loc11_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc10_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                    }
                                    §§push(_loc10_);
                                 }
                                 else
                                 {
                                    §§push(_loc7_);
                                 }
                              }
                              _loc7_ = §§pop();
                              _loc10_ = _loc7_.child1;
                              _loc11_ = _loc7_.child2;
                              _loc8_ = _loc7_.aabb;
                              _loc15_ = _loc10_.aabb;
                              _loc16_ = _loc11_.aabb;
                              _loc8_.minx = _loc15_.minx < _loc16_.minx ? _loc15_.minx : _loc16_.minx;
                              _loc8_.miny = _loc15_.miny < _loc16_.miny ? _loc15_.miny : _loc16_.miny;
                              _loc8_.maxx = _loc15_.maxx > _loc16_.maxx ? _loc15_.maxx : _loc16_.maxx;
                              _loc8_.maxy = _loc15_.maxy > _loc16_.maxy ? _loc15_.maxy : _loc16_.maxy;
                              _loc12_ = _loc10_.height;
                              _loc17_ = _loc11_.height;
                              _loc7_.height = 1 + (_loc12_ > _loc17_ ? _loc12_ : _loc17_);
                              _loc7_ = _loc7_.parent;
                           }
                        }
                        else
                        {
                           _loc3_.root = _loc6_;
                           _loc6_.parent = null;
                           _loc7_ = _loc4_;
                           _loc7_.height = -1;
                           _loc8_ = _loc7_.aabb;
                           if(_loc8_.outer != null)
                           {
                              _loc8_.outer.zpp_inner = null;
                              _loc8_.outer = null;
                           }
                           _loc8_.wrap_min = _loc8_.wrap_max = null;
                           _loc8_._invalidate = null;
                           _loc8_._validate = null;
                           _loc8_.next = ZPP_AABB.zpp_pool;
                           ZPP_AABB.zpp_pool = _loc8_;
                           _loc7_.child1 = _loc7_.child2 = _loc7_.parent = null;
                           _loc7_.next = null;
                           _loc7_.snext = null;
                           _loc7_.mnext = null;
                           _loc7_.next = ZPP_AABBNode.zpp_pool;
                           ZPP_AABBNode.zpp_pool = _loc7_;
                        }
                     }
                  }
                  else
                  {
                     _loc1_.first_sync = false;
                  }
                  _loc8_ = _loc1_.aabb;
                  if(!space.continuous)
                  {
                     if(_loc2_.zip_aabb)
                     {
                        if(_loc2_.body != null)
                        {
                           _loc2_.zip_aabb = false;
                           if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              _loc19_ = _loc2_.circle;
                              if(_loc19_.zip_worldCOM)
                              {
                                 if(_loc19_.body != null)
                                 {
                                    _loc19_.zip_worldCOM = false;
                                    if(_loc19_.zip_localCOM)
                                    {
                                       _loc19_.zip_localCOM = false;
                                       if(_loc19_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                       {
                                          _loc20_ = _loc19_.polygon;
                                          if(_loc20_.lverts.next == null)
                                          {
                                             Boot.lastError = new Error();
                                             throw "Error: An empty polygon has no meaningful localCOM";
                                          }
                                          if(_loc20_.lverts.next.next == null)
                                          {
                                             _loc20_.localCOMx = _loc20_.lverts.next.x;
                                             _loc20_.localCOMy = _loc20_.lverts.next.y;
                                             null;
                                          }
                                          else if(_loc20_.lverts.next.next.next == null)
                                          {
                                             _loc20_.localCOMx = _loc20_.lverts.next.x;
                                             _loc20_.localCOMy = _loc20_.lverts.next.y;
                                             _loc21_ = 1;
                                             _loc20_.localCOMx += _loc20_.lverts.next.next.x * _loc21_;
                                             _loc20_.localCOMy += _loc20_.lverts.next.next.y * _loc21_;
                                             _loc21_ = 0.5;
                                             _loc20_.localCOMx *= _loc21_;
                                             _loc20_.localCOMy *= _loc21_;
                                          }
                                          else
                                          {
                                             _loc20_.localCOMx = 0;
                                             _loc20_.localCOMy = 0;
                                             _loc21_ = 0;
                                             _loc22_ = _loc20_.lverts.next;
                                             _loc23_ = _loc22_;
                                             _loc22_ = _loc22_.next;
                                             _loc24_ = _loc22_;
                                             _loc22_ = _loc22_.next;
                                             while(_loc22_ != null)
                                             {
                                                _loc25_ = _loc22_;
                                                _loc21_ += _loc24_.x * (_loc25_.y - _loc23_.y);
                                                _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                                _loc20_.localCOMx += (_loc24_.x + _loc25_.x) * _loc26_;
                                                _loc20_.localCOMy += (_loc24_.y + _loc25_.y) * _loc26_;
                                                _loc23_ = _loc24_;
                                                _loc24_ = _loc25_;
                                                _loc22_ = _loc22_.next;
                                             }
                                             _loc22_ = _loc20_.lverts.next;
                                             _loc25_ = _loc22_;
                                             _loc21_ += _loc24_.x * (_loc25_.y - _loc23_.y);
                                             _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                             _loc20_.localCOMx += (_loc24_.x + _loc25_.x) * _loc26_;
                                             _loc20_.localCOMy += (_loc24_.y + _loc25_.y) * _loc26_;
                                             _loc23_ = _loc24_;
                                             _loc24_ = _loc25_;
                                             _loc22_ = _loc22_.next;
                                             _loc27_ = _loc22_;
                                             _loc21_ += _loc24_.x * (_loc27_.y - _loc23_.y);
                                             _loc26_ = _loc27_.y * _loc24_.x - _loc27_.x * _loc24_.y;
                                             _loc20_.localCOMx += (_loc24_.x + _loc27_.x) * _loc26_;
                                             _loc20_.localCOMy += (_loc24_.y + _loc27_.y) * _loc26_;
                                             _loc21_ = 1 / (3 * _loc21_);
                                             _loc26_ = _loc21_;
                                             _loc20_.localCOMx *= _loc26_;
                                             _loc20_.localCOMy *= _loc26_;
                                          }
                                       }
                                    }
                                    _loc28_ = _loc19_.body;
                                    if(_loc28_.zip_axis)
                                    {
                                       _loc28_.zip_axis = false;
                                       _loc28_.axisx = Math.sin(_loc28_.rot);
                                       _loc28_.axisy = Math.cos(_loc28_.rot);
                                       null;
                                    }
                                    _loc19_.worldCOMx = _loc19_.body.posx + (_loc19_.body.axisy * _loc19_.localCOMx - _loc19_.body.axisx * _loc19_.localCOMy);
                                    _loc19_.worldCOMy = _loc19_.body.posy + (_loc19_.localCOMx * _loc19_.body.axisx + _loc19_.localCOMy * _loc19_.body.axisy);
                                 }
                              }
                              _loc21_ = _loc19_.radius;
                              _loc26_ = _loc19_.radius;
                              _loc19_.aabb.minx = _loc19_.worldCOMx - _loc21_;
                              _loc19_.aabb.miny = _loc19_.worldCOMy - _loc26_;
                              _loc19_.aabb.maxx = _loc19_.worldCOMx + _loc21_;
                              _loc19_.aabb.maxy = _loc19_.worldCOMy + _loc26_;
                           }
                           else
                           {
                              _loc20_ = _loc2_.polygon;
                              if(_loc20_.zip_gverts)
                              {
                                 if(_loc20_.body != null)
                                 {
                                    _loc20_.zip_gverts = false;
                                    _loc20_.validate_lverts();
                                    _loc28_ = _loc20_.body;
                                    if(_loc28_.zip_axis)
                                    {
                                       _loc28_.zip_axis = false;
                                       _loc28_.axisx = Math.sin(_loc28_.rot);
                                       _loc28_.axisy = Math.cos(_loc28_.rot);
                                       null;
                                    }
                                    _loc22_ = _loc20_.lverts.next;
                                    _loc23_ = _loc20_.gverts.next;
                                    while(_loc23_ != null)
                                    {
                                       _loc24_ = _loc23_;
                                       _loc25_ = _loc22_;
                                       _loc22_ = _loc22_.next;
                                       _loc24_.x = _loc20_.body.posx + (_loc20_.body.axisy * _loc25_.x - _loc20_.body.axisx * _loc25_.y);
                                       _loc24_.y = _loc20_.body.posy + (_loc25_.x * _loc20_.body.axisx + _loc25_.y * _loc20_.body.axisy);
                                       _loc23_ = _loc23_.next;
                                    }
                                 }
                              }
                              if(_loc20_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful bounds";
                              }
                              _loc22_ = _loc20_.gverts.next;
                              _loc20_.aabb.minx = _loc22_.x;
                              _loc20_.aabb.miny = _loc22_.y;
                              _loc20_.aabb.maxx = _loc22_.x;
                              _loc20_.aabb.maxy = _loc22_.y;
                              _loc23_ = _loc20_.gverts.next.next;
                              while(_loc23_ != null)
                              {
                                 _loc24_ = _loc23_;
                                 if(_loc24_.x < _loc20_.aabb.minx)
                                 {
                                    _loc20_.aabb.minx = _loc24_.x;
                                 }
                                 if(_loc24_.x > _loc20_.aabb.maxx)
                                 {
                                    _loc20_.aabb.maxx = _loc24_.x;
                                 }
                                 if(_loc24_.y < _loc20_.aabb.miny)
                                 {
                                    _loc20_.aabb.miny = _loc24_.y;
                                 }
                                 if(_loc24_.y > _loc20_.aabb.maxy)
                                 {
                                    _loc20_.aabb.maxy = _loc24_.y;
                                 }
                                 _loc23_ = _loc23_.next;
                              }
                           }
                        }
                     }
                  }
                  _loc15_ = _loc2_.aabb;
                  _loc8_.minx = _loc15_.minx - 3;
                  _loc8_.miny = _loc15_.miny - 3;
                  _loc8_.maxx = _loc15_.maxx + 3;
                  _loc8_.maxy = _loc15_.maxy + 3;
                  _loc3_ = !!(_loc1_.dyn = _loc2_.body.type == ZPP_Flags.id_BodyType_STATIC ? false : !_loc2_.body.component.sleeping) ? dtree : stree;
                  if(_loc3_.root == null)
                  {
                     _loc3_.root = _loc1_;
                     _loc3_.root.parent = null;
                  }
                  else
                  {
                     _loc15_ = _loc1_.aabb;
                     _loc4_ = _loc3_.root;
                     while(_loc4_.child1 != null)
                     {
                        _loc5_ = _loc4_.child1;
                        _loc6_ = _loc4_.child2;
                        _loc16_ = _loc4_.aabb;
                        _loc21_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc4_.aabb;
                        _loc16_.minx = _loc30_.minx < _loc15_.minx ? _loc30_.minx : _loc15_.minx;
                        _loc16_.miny = _loc30_.miny < _loc15_.miny ? _loc30_.miny : _loc15_.miny;
                        _loc16_.maxx = _loc30_.maxx > _loc15_.maxx ? _loc30_.maxx : _loc15_.maxx;
                        _loc16_.maxy = _loc30_.maxy > _loc15_.maxy ? _loc30_.maxy : _loc15_.maxy;
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc26_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                        _loc31_ = 2 * _loc26_;
                        _loc32_ = 2 * (_loc26_ - _loc21_);
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc5_.aabb;
                        _loc16_.minx = _loc15_.minx < _loc30_.minx ? _loc15_.minx : _loc30_.minx;
                        _loc16_.miny = _loc15_.miny < _loc30_.miny ? _loc15_.miny : _loc30_.miny;
                        _loc16_.maxx = _loc15_.maxx > _loc30_.maxx ? _loc15_.maxx : _loc30_.maxx;
                        _loc16_.maxy = _loc15_.maxy > _loc30_.maxy ? _loc15_.maxy : _loc30_.maxy;
                        _loc33_ = _loc5_.child1 == null ? (_loc16_ = ZPP_AABBTree.tmpaabb, (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_) : (_loc16_ = _loc5_.aabb, _loc34_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2, _loc16_ = ZPP_AABBTree.tmpaabb, _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2, _loc35_ - _loc34_ + _loc32_);
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc6_.aabb;
                        _loc16_.minx = _loc15_.minx < _loc30_.minx ? _loc15_.minx : _loc30_.minx;
                        _loc16_.miny = _loc15_.miny < _loc30_.miny ? _loc15_.miny : _loc30_.miny;
                        _loc16_.maxx = _loc15_.maxx > _loc30_.maxx ? _loc15_.maxx : _loc30_.maxx;
                        _loc16_.maxy = _loc15_.maxy > _loc30_.maxy ? _loc15_.maxy : _loc30_.maxy;
                        _loc34_ = _loc6_.child1 == null ? (_loc16_ = ZPP_AABBTree.tmpaabb, (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_) : (_loc16_ = _loc6_.aabb, _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2, _loc16_ = ZPP_AABBTree.tmpaabb, _loc36_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2, _loc36_ - _loc35_ + _loc32_);
                        if(_loc31_ < _loc33_ && _loc31_ < _loc34_)
                        {
                           break;
                        }
                        _loc4_ = _loc33_ < _loc34_ ? _loc5_ : _loc6_;
                     }
                     _loc5_ = _loc4_;
                     _loc6_ = _loc5_.parent;
                     if(ZPP_AABBNode.zpp_pool == null)
                     {
                        _loc7_ = new ZPP_AABBNode();
                     }
                     else
                     {
                        _loc7_ = ZPP_AABBNode.zpp_pool;
                        ZPP_AABBNode.zpp_pool = _loc7_.next;
                        _loc7_.next = null;
                     }
                     if(ZPP_AABB.zpp_pool == null)
                     {
                        _loc7_.aabb = new ZPP_AABB();
                     }
                     else
                     {
                        _loc7_.aabb = ZPP_AABB.zpp_pool;
                        ZPP_AABB.zpp_pool = _loc7_.aabb.next;
                        _loc7_.aabb.next = null;
                     }
                     null;
                     _loc7_.moved = false;
                     _loc7_.synced = false;
                     _loc7_.first_sync = false;
                     _loc7_.parent = _loc6_;
                     _loc16_ = _loc7_.aabb;
                     _loc30_ = _loc5_.aabb;
                     _loc16_.minx = _loc15_.minx < _loc30_.minx ? _loc15_.minx : _loc30_.minx;
                     _loc16_.miny = _loc15_.miny < _loc30_.miny ? _loc15_.miny : _loc30_.miny;
                     _loc16_.maxx = _loc15_.maxx > _loc30_.maxx ? _loc15_.maxx : _loc30_.maxx;
                     _loc16_.maxy = _loc15_.maxy > _loc30_.maxy ? _loc15_.maxy : _loc30_.maxy;
                     _loc7_.height = _loc5_.height + 1;
                     if(_loc6_ != null)
                     {
                        if(_loc6_.child1 == _loc5_)
                        {
                           _loc6_.child1 = _loc7_;
                        }
                        else
                        {
                           _loc6_.child2 = _loc7_;
                        }
                        _loc7_.child1 = _loc5_;
                        _loc7_.child2 = _loc1_;
                        _loc5_.parent = _loc7_;
                        _loc1_.parent = _loc7_;
                     }
                     else
                     {
                        _loc7_.child1 = _loc5_;
                        _loc7_.child2 = _loc1_;
                        _loc5_.parent = _loc7_;
                        _loc1_.parent = _loc7_;
                        _loc3_.root = _loc7_;
                     }
                     _loc4_ = _loc1_.parent;
                     while(_loc4_ != null)
                     {
                        if(_loc4_.child1 == null || _loc4_.height < 2)
                        {
                           §§push(_loc4_);
                        }
                        else
                        {
                           _loc10_ = _loc4_.child1;
                           _loc11_ = _loc4_.child2;
                           _loc12_ = _loc11_.height - _loc10_.height;
                           if(_loc12_ > 1)
                           {
                              _loc13_ = _loc11_.child1;
                              _loc14_ = _loc11_.child2;
                              _loc11_.child1 = _loc4_;
                              _loc11_.parent = _loc4_.parent;
                              _loc4_.parent = _loc11_;
                              if(_loc11_.parent != null)
                              {
                                 if(_loc11_.parent.child1 == _loc4_)
                                 {
                                    _loc11_.parent.child1 = _loc11_;
                                 }
                                 else
                                 {
                                    _loc11_.parent.child2 = _loc11_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc11_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc11_.child2 = _loc13_;
                                 _loc4_.child2 = _loc14_;
                                 _loc14_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc10_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc16_ = _loc11_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                              }
                              else
                              {
                                 _loc11_.child2 = _loc14_;
                                 _loc4_.child2 = _loc13_;
                                 _loc13_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc10_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc16_ = _loc11_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                              }
                              §§push(_loc11_);
                           }
                           else if(_loc12_ < -1)
                           {
                              _loc13_ = _loc10_.child1;
                              _loc14_ = _loc10_.child2;
                              _loc10_.child1 = _loc4_;
                              _loc10_.parent = _loc4_.parent;
                              _loc4_.parent = _loc10_;
                              if(_loc10_.parent != null)
                              {
                                 if(_loc10_.parent.child1 == _loc4_)
                                 {
                                    _loc10_.parent.child1 = _loc10_;
                                 }
                                 else
                                 {
                                    _loc10_.parent.child2 = _loc10_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc10_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc10_.child2 = _loc13_;
                                 _loc4_.child1 = _loc14_;
                                 _loc14_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc11_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc16_ = _loc10_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                              }
                              else
                              {
                                 _loc10_.child2 = _loc14_;
                                 _loc4_.child1 = _loc13_;
                                 _loc13_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc11_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc16_ = _loc10_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_ ? _loc17_ : _loc18_);
                              }
                              §§push(_loc10_);
                           }
                           else
                           {
                              §§push(_loc4_);
                           }
                        }
                        _loc4_ = §§pop();
                        _loc10_ = _loc4_.child1;
                        _loc11_ = _loc4_.child2;
                        _loc12_ = _loc10_.height;
                        _loc17_ = _loc11_.height;
                        _loc4_.height = 1 + (_loc12_ > _loc17_ ? _loc12_ : _loc17_);
                        _loc16_ = _loc4_.aabb;
                        _loc30_ = _loc10_.aabb;
                        _loc37_ = _loc11_.aabb;
                        _loc16_.minx = _loc30_.minx < _loc37_.minx ? _loc30_.minx : _loc37_.minx;
                        _loc16_.miny = _loc30_.miny < _loc37_.miny ? _loc30_.miny : _loc37_.miny;
                        _loc16_.maxx = _loc30_.maxx > _loc37_.maxx ? _loc30_.maxx : _loc37_.maxx;
                        _loc16_.maxy = _loc30_.maxy > _loc37_.maxy ? _loc30_.maxy : _loc37_.maxy;
                        _loc4_ = _loc4_.parent;
                     }
                  }
                  _loc1_.synced = false;
                  if(!_loc1_.moved)
                  {
                     _loc1_.moved = true;
                     _loc1_.mnext = moves;
                     moves = _loc1_;
                  }
               }
            }
         }
      }
      
      override public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         var _loc6_:Boolean = false;
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
         _loc7_._immutable = _loc6_;
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
                  null;
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
                  ++_loc9_.length;
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
                  null;
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
                  ++_loc9_.length;
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
                        null;
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
                        ++_loc9_.length;
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
                        null;
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
                        ++_loc9_.length;
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
                  --_loc3_.length;
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
                  --_loc3_.length;
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
         var _loc4_:* = null as ZPP_Shape;
         var _loc5_:* = null as ZPP_AABBTree;
         var _loc6_:* = null as ZPP_AABBNode;
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as Vec2;
         var _loc12_:* = null as ZPP_AABBNode;
         var _loc13_:* = null as ZPP_AABBNode;
         var _loc14_:int = 0;
         var _loc15_:* = null as ZPP_AABBNode;
         var _loc16_:* = null as ZPP_AABBNode;
         var _loc17_:* = null as ZPP_AABB;
         var _loc18_:* = null as ZPP_AABB;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:* = null as ZPP_Circle;
         var _loc22_:* = null as ZPP_Polygon;
         var _loc23_:Number = NaN;
         var _loc24_:* = null as ZPP_Vec2;
         var _loc25_:* = null as ZPP_Vec2;
         var _loc26_:* = null as ZPP_Vec2;
         var _loc27_:* = null as ZPP_Vec2;
         var _loc28_:Number = NaN;
         var _loc29_:* = null as ZPP_Vec2;
         var _loc30_:* = null as ZPP_Body;
         var _loc31_:Boolean = false;
         var _loc32_:* = null as ZPP_AABB;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:* = null as ZPP_AABB;
         var _loc40_:* = null as ZPP_Shape;
         var _loc41_:* = null as ZPP_Shape;
         var _loc42_:* = null as ZPP_AABBPair;
         var _loc43_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc44_:* = null as ZPP_AABBPair;
         var _loc45_:* = null as ZNPList_ZPP_AABBPair;
         var _loc46_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc47_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc48_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc49_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc50_:* = null as ZPP_AABBPair;
         var _loc51_:* = null as ZPP_AABBPair;
         var _loc52_:* = null as ZPP_Body;
         var _loc53_:* = null as ZPP_Arbiter;
         var _loc3_:ZPP_AABBNode = syncs;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.shape;
            if(!_loc3_.first_sync)
            {
               _loc5_ = _loc3_.dyn ? dtree : stree;
               if(_loc3_ == _loc5_.root)
               {
                  _loc5_.root = null;
                  null;
               }
               else
               {
                  _loc6_ = _loc3_.parent;
                  _loc7_ = _loc6_.parent;
                  _loc8_ = _loc6_.child1 == _loc3_ ? _loc6_.child2 : _loc6_.child1;
                  if(_loc7_ != null)
                  {
                     if(_loc7_.child1 == _loc6_)
                     {
                        _loc7_.child1 = _loc8_;
                     }
                     else
                     {
                        _loc7_.child2 = _loc8_;
                     }
                     _loc8_.parent = _loc7_;
                     _loc9_ = _loc6_;
                     _loc9_.height = -1;
                     _loc10_ = _loc9_.aabb;
                     if(_loc10_.outer != null)
                     {
                        _loc10_.outer.zpp_inner = null;
                        _loc10_.outer = null;
                     }
                     _loc10_.wrap_min = _loc10_.wrap_max = null;
                     _loc10_._invalidate = null;
                     _loc10_._validate = null;
                     _loc10_.next = ZPP_AABB.zpp_pool;
                     ZPP_AABB.zpp_pool = _loc10_;
                     _loc9_.child1 = _loc9_.child2 = _loc9_.parent = null;
                     _loc9_.next = null;
                     _loc9_.snext = null;
                     _loc9_.mnext = null;
                     _loc9_.next = ZPP_AABBNode.zpp_pool;
                     ZPP_AABBNode.zpp_pool = _loc9_;
                     _loc9_ = _loc7_;
                     while(_loc9_ != null)
                     {
                        if(_loc9_.child1 == null || _loc9_.height < 2)
                        {
                           §§push(_loc9_);
                        }
                        else
                        {
                           _loc12_ = _loc9_.child1;
                           _loc13_ = _loc9_.child2;
                           _loc14_ = _loc13_.height - _loc12_.height;
                           if(_loc14_ > 1)
                           {
                              _loc15_ = _loc13_.child1;
                              _loc16_ = _loc13_.child2;
                              _loc13_.child1 = _loc9_;
                              _loc13_.parent = _loc9_.parent;
                              _loc9_.parent = _loc13_;
                              if(_loc13_.parent != null)
                              {
                                 if(_loc13_.parent.child1 == _loc9_)
                                 {
                                    _loc13_.parent.child1 = _loc13_;
                                 }
                                 else
                                 {
                                    _loc13_.parent.child2 = _loc13_;
                                 }
                              }
                              else
                              {
                                 _loc5_.root = _loc13_;
                              }
                              if(_loc15_.height > _loc16_.height)
                              {
                                 _loc13_.child2 = _loc15_;
                                 _loc9_.child2 = _loc16_;
                                 _loc16_.parent = _loc9_;
                                 _loc10_ = _loc9_.aabb;
                                 _loc17_ = _loc12_.aabb;
                                 _loc18_ = _loc16_.aabb;
                                 _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                                 _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                                 _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                                 _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                                 _loc10_ = _loc13_.aabb;
                                 _loc17_ = _loc9_.aabb;
                                 _loc18_ = _loc15_.aabb;
                                 _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                                 _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                                 _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                                 _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                                 _loc19_ = _loc12_.height;
                                 _loc20_ = _loc16_.height;
                                 _loc9_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                                 _loc19_ = _loc9_.height;
                                 _loc20_ = _loc15_.height;
                                 _loc13_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                              }
                              else
                              {
                                 _loc13_.child2 = _loc16_;
                                 _loc9_.child2 = _loc15_;
                                 _loc15_.parent = _loc9_;
                                 _loc10_ = _loc9_.aabb;
                                 _loc17_ = _loc12_.aabb;
                                 _loc18_ = _loc15_.aabb;
                                 _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                                 _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                                 _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                                 _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                                 _loc10_ = _loc13_.aabb;
                                 _loc17_ = _loc9_.aabb;
                                 _loc18_ = _loc16_.aabb;
                                 _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                                 _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                                 _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                                 _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                                 _loc19_ = _loc12_.height;
                                 _loc20_ = _loc15_.height;
                                 _loc9_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                                 _loc19_ = _loc9_.height;
                                 _loc20_ = _loc16_.height;
                                 _loc13_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                              }
                              §§push(_loc13_);
                           }
                           else if(_loc14_ < -1)
                           {
                              _loc15_ = _loc12_.child1;
                              _loc16_ = _loc12_.child2;
                              _loc12_.child1 = _loc9_;
                              _loc12_.parent = _loc9_.parent;
                              _loc9_.parent = _loc12_;
                              if(_loc12_.parent != null)
                              {
                                 if(_loc12_.parent.child1 == _loc9_)
                                 {
                                    _loc12_.parent.child1 = _loc12_;
                                 }
                                 else
                                 {
                                    _loc12_.parent.child2 = _loc12_;
                                 }
                              }
                              else
                              {
                                 _loc5_.root = _loc12_;
                              }
                              if(_loc15_.height > _loc16_.height)
                              {
                                 _loc12_.child2 = _loc15_;
                                 _loc9_.child1 = _loc16_;
                                 _loc16_.parent = _loc9_;
                                 _loc10_ = _loc9_.aabb;
                                 _loc17_ = _loc13_.aabb;
                                 _loc18_ = _loc16_.aabb;
                                 _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                                 _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                                 _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                                 _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                                 _loc10_ = _loc12_.aabb;
                                 _loc17_ = _loc9_.aabb;
                                 _loc18_ = _loc15_.aabb;
                                 _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                                 _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                                 _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                                 _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                                 _loc19_ = _loc13_.height;
                                 _loc20_ = _loc16_.height;
                                 _loc9_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                                 _loc19_ = _loc9_.height;
                                 _loc20_ = _loc15_.height;
                                 _loc12_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                              }
                              else
                              {
                                 _loc12_.child2 = _loc16_;
                                 _loc9_.child1 = _loc15_;
                                 _loc15_.parent = _loc9_;
                                 _loc10_ = _loc9_.aabb;
                                 _loc17_ = _loc13_.aabb;
                                 _loc18_ = _loc15_.aabb;
                                 _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                                 _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                                 _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                                 _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                                 _loc10_ = _loc12_.aabb;
                                 _loc17_ = _loc9_.aabb;
                                 _loc18_ = _loc16_.aabb;
                                 _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                                 _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                                 _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                                 _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                                 _loc19_ = _loc13_.height;
                                 _loc20_ = _loc15_.height;
                                 _loc9_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                                 _loc19_ = _loc9_.height;
                                 _loc20_ = _loc16_.height;
                                 _loc12_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                              }
                              §§push(_loc12_);
                           }
                           else
                           {
                              §§push(_loc9_);
                           }
                        }
                        _loc9_ = §§pop();
                        _loc12_ = _loc9_.child1;
                        _loc13_ = _loc9_.child2;
                        _loc10_ = _loc9_.aabb;
                        _loc17_ = _loc12_.aabb;
                        _loc18_ = _loc13_.aabb;
                        _loc10_.minx = _loc17_.minx < _loc18_.minx ? _loc17_.minx : _loc18_.minx;
                        _loc10_.miny = _loc17_.miny < _loc18_.miny ? _loc17_.miny : _loc18_.miny;
                        _loc10_.maxx = _loc17_.maxx > _loc18_.maxx ? _loc17_.maxx : _loc18_.maxx;
                        _loc10_.maxy = _loc17_.maxy > _loc18_.maxy ? _loc17_.maxy : _loc18_.maxy;
                        _loc14_ = _loc12_.height;
                        _loc19_ = _loc13_.height;
                        _loc9_.height = 1 + (_loc14_ > _loc19_ ? _loc14_ : _loc19_);
                        _loc9_ = _loc9_.parent;
                     }
                  }
                  else
                  {
                     _loc5_.root = _loc8_;
                     _loc8_.parent = null;
                     _loc9_ = _loc6_;
                     _loc9_.height = -1;
                     _loc10_ = _loc9_.aabb;
                     if(_loc10_.outer != null)
                     {
                        _loc10_.outer.zpp_inner = null;
                        _loc10_.outer = null;
                     }
                     _loc10_.wrap_min = _loc10_.wrap_max = null;
                     _loc10_._invalidate = null;
                     _loc10_._validate = null;
                     _loc10_.next = ZPP_AABB.zpp_pool;
                     ZPP_AABB.zpp_pool = _loc10_;
                     _loc9_.child1 = _loc9_.child2 = _loc9_.parent = null;
                     _loc9_.next = null;
                     _loc9_.snext = null;
                     _loc9_.mnext = null;
                     _loc9_.next = ZPP_AABBNode.zpp_pool;
                     ZPP_AABBNode.zpp_pool = _loc9_;
                  }
               }
            }
            else
            {
               _loc3_.first_sync = false;
            }
            _loc10_ = _loc3_.aabb;
            if(!param1.continuous)
            {
               if(_loc4_.zip_aabb)
               {
                  if(_loc4_.body != null)
                  {
                     _loc4_.zip_aabb = false;
                     if(_loc4_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc21_ = _loc4_.circle;
                        if(_loc21_.zip_worldCOM)
                        {
                           if(_loc21_.body != null)
                           {
                              _loc21_.zip_worldCOM = false;
                              if(_loc21_.zip_localCOM)
                              {
                                 _loc21_.zip_localCOM = false;
                                 if(_loc21_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc22_ = _loc21_.polygon;
                                    if(_loc22_.lverts.next == null)
                                    {
                                       Boot.lastError = new Error();
                                       throw "Error: An empty polygon has no meaningful localCOM";
                                    }
                                    if(_loc22_.lverts.next.next == null)
                                    {
                                       _loc22_.localCOMx = _loc22_.lverts.next.x;
                                       _loc22_.localCOMy = _loc22_.lverts.next.y;
                                       null;
                                    }
                                    else if(_loc22_.lverts.next.next.next == null)
                                    {
                                       _loc22_.localCOMx = _loc22_.lverts.next.x;
                                       _loc22_.localCOMy = _loc22_.lverts.next.y;
                                       _loc23_ = 1;
                                       _loc22_.localCOMx += _loc22_.lverts.next.next.x * _loc23_;
                                       _loc22_.localCOMy += _loc22_.lverts.next.next.y * _loc23_;
                                       _loc23_ = 0.5;
                                       _loc22_.localCOMx *= _loc23_;
                                       _loc22_.localCOMy *= _loc23_;
                                    }
                                    else
                                    {
                                       _loc22_.localCOMx = 0;
                                       _loc22_.localCOMy = 0;
                                       _loc23_ = 0;
                                       _loc24_ = _loc22_.lverts.next;
                                       _loc25_ = _loc24_;
                                       _loc24_ = _loc24_.next;
                                       _loc26_ = _loc24_;
                                       _loc24_ = _loc24_.next;
                                       while(_loc24_ != null)
                                       {
                                          _loc27_ = _loc24_;
                                          _loc23_ += _loc26_.x * (_loc27_.y - _loc25_.y);
                                          _loc28_ = _loc27_.y * _loc26_.x - _loc27_.x * _loc26_.y;
                                          _loc22_.localCOMx += (_loc26_.x + _loc27_.x) * _loc28_;
                                          _loc22_.localCOMy += (_loc26_.y + _loc27_.y) * _loc28_;
                                          _loc25_ = _loc26_;
                                          _loc26_ = _loc27_;
                                          _loc24_ = _loc24_.next;
                                       }
                                       _loc24_ = _loc22_.lverts.next;
                                       _loc27_ = _loc24_;
                                       _loc23_ += _loc26_.x * (_loc27_.y - _loc25_.y);
                                       _loc28_ = _loc27_.y * _loc26_.x - _loc27_.x * _loc26_.y;
                                       _loc22_.localCOMx += (_loc26_.x + _loc27_.x) * _loc28_;
                                       _loc22_.localCOMy += (_loc26_.y + _loc27_.y) * _loc28_;
                                       _loc25_ = _loc26_;
                                       _loc26_ = _loc27_;
                                       _loc24_ = _loc24_.next;
                                       _loc29_ = _loc24_;
                                       _loc23_ += _loc26_.x * (_loc29_.y - _loc25_.y);
                                       _loc28_ = _loc29_.y * _loc26_.x - _loc29_.x * _loc26_.y;
                                       _loc22_.localCOMx += (_loc26_.x + _loc29_.x) * _loc28_;
                                       _loc22_.localCOMy += (_loc26_.y + _loc29_.y) * _loc28_;
                                       _loc23_ = 1 / (3 * _loc23_);
                                       _loc28_ = _loc23_;
                                       _loc22_.localCOMx *= _loc28_;
                                       _loc22_.localCOMy *= _loc28_;
                                    }
                                 }
                              }
                              _loc30_ = _loc21_.body;
                              if(_loc30_.zip_axis)
                              {
                                 _loc30_.zip_axis = false;
                                 _loc30_.axisx = Math.sin(_loc30_.rot);
                                 _loc30_.axisy = Math.cos(_loc30_.rot);
                                 null;
                              }
                              _loc21_.worldCOMx = _loc21_.body.posx + (_loc21_.body.axisy * _loc21_.localCOMx - _loc21_.body.axisx * _loc21_.localCOMy);
                              _loc21_.worldCOMy = _loc21_.body.posy + (_loc21_.localCOMx * _loc21_.body.axisx + _loc21_.localCOMy * _loc21_.body.axisy);
                           }
                        }
                        _loc23_ = _loc21_.radius;
                        _loc28_ = _loc21_.radius;
                        _loc21_.aabb.minx = _loc21_.worldCOMx - _loc23_;
                        _loc21_.aabb.miny = _loc21_.worldCOMy - _loc28_;
                        _loc21_.aabb.maxx = _loc21_.worldCOMx + _loc23_;
                        _loc21_.aabb.maxy = _loc21_.worldCOMy + _loc28_;
                     }
                     else
                     {
                        _loc22_ = _loc4_.polygon;
                        if(_loc22_.zip_gverts)
                        {
                           if(_loc22_.body != null)
                           {
                              _loc22_.zip_gverts = false;
                              _loc22_.validate_lverts();
                              _loc30_ = _loc22_.body;
                              if(_loc30_.zip_axis)
                              {
                                 _loc30_.zip_axis = false;
                                 _loc30_.axisx = Math.sin(_loc30_.rot);
                                 _loc30_.axisy = Math.cos(_loc30_.rot);
                                 null;
                              }
                              _loc24_ = _loc22_.lverts.next;
                              _loc25_ = _loc22_.gverts.next;
                              while(_loc25_ != null)
                              {
                                 _loc26_ = _loc25_;
                                 _loc27_ = _loc24_;
                                 _loc24_ = _loc24_.next;
                                 _loc26_.x = _loc22_.body.posx + (_loc22_.body.axisy * _loc27_.x - _loc22_.body.axisx * _loc27_.y);
                                 _loc26_.y = _loc22_.body.posy + (_loc27_.x * _loc22_.body.axisx + _loc27_.y * _loc22_.body.axisy);
                                 _loc25_ = _loc25_.next;
                              }
                           }
                        }
                        if(_loc22_.lverts.next == null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: An empty polygon has no meaningful bounds";
                        }
                        _loc24_ = _loc22_.gverts.next;
                        _loc22_.aabb.minx = _loc24_.x;
                        _loc22_.aabb.miny = _loc24_.y;
                        _loc22_.aabb.maxx = _loc24_.x;
                        _loc22_.aabb.maxy = _loc24_.y;
                        _loc25_ = _loc22_.gverts.next.next;
                        while(_loc25_ != null)
                        {
                           _loc26_ = _loc25_;
                           if(_loc26_.x < _loc22_.aabb.minx)
                           {
                              _loc22_.aabb.minx = _loc26_.x;
                           }
                           if(_loc26_.x > _loc22_.aabb.maxx)
                           {
                              _loc22_.aabb.maxx = _loc26_.x;
                           }
                           if(_loc26_.y < _loc22_.aabb.miny)
                           {
                              _loc22_.aabb.miny = _loc26_.y;
                           }
                           if(_loc26_.y > _loc22_.aabb.maxy)
                           {
                              _loc22_.aabb.maxy = _loc26_.y;
                           }
                           _loc25_ = _loc25_.next;
                        }
                     }
                  }
               }
            }
            _loc17_ = _loc4_.aabb;
            _loc10_.minx = _loc17_.minx - 3;
            _loc10_.miny = _loc17_.miny - 3;
            _loc10_.maxx = _loc17_.maxx + 3;
            _loc10_.maxy = _loc17_.maxy + 3;
            _loc5_ = !!(_loc3_.dyn = _loc4_.body.type == ZPP_Flags.id_BodyType_STATIC ? false : !_loc4_.body.component.sleeping) ? dtree : stree;
            if(_loc5_.root == null)
            {
               _loc5_.root = _loc3_;
               _loc5_.root.parent = null;
            }
            else
            {
               _loc17_ = _loc3_.aabb;
               _loc6_ = _loc5_.root;
               while(_loc6_.child1 != null)
               {
                  _loc7_ = _loc6_.child1;
                  _loc8_ = _loc6_.child2;
                  _loc18_ = _loc6_.aabb;
                  _loc23_ = (_loc18_.maxx - _loc18_.minx + (_loc18_.maxy - _loc18_.miny)) * 2;
                  _loc18_ = ZPP_AABBTree.tmpaabb;
                  _loc32_ = _loc6_.aabb;
                  _loc18_.minx = _loc32_.minx < _loc17_.minx ? _loc32_.minx : _loc17_.minx;
                  _loc18_.miny = _loc32_.miny < _loc17_.miny ? _loc32_.miny : _loc17_.miny;
                  _loc18_.maxx = _loc32_.maxx > _loc17_.maxx ? _loc32_.maxx : _loc17_.maxx;
                  _loc18_.maxy = _loc32_.maxy > _loc17_.maxy ? _loc32_.maxy : _loc17_.maxy;
                  _loc18_ = ZPP_AABBTree.tmpaabb;
                  _loc28_ = (_loc18_.maxx - _loc18_.minx + (_loc18_.maxy - _loc18_.miny)) * 2;
                  _loc33_ = 2 * _loc28_;
                  _loc34_ = 2 * (_loc28_ - _loc23_);
                  _loc18_ = ZPP_AABBTree.tmpaabb;
                  _loc32_ = _loc7_.aabb;
                  _loc18_.minx = _loc17_.minx < _loc32_.minx ? _loc17_.minx : _loc32_.minx;
                  _loc18_.miny = _loc17_.miny < _loc32_.miny ? _loc17_.miny : _loc32_.miny;
                  _loc18_.maxx = _loc17_.maxx > _loc32_.maxx ? _loc17_.maxx : _loc32_.maxx;
                  _loc18_.maxy = _loc17_.maxy > _loc32_.maxy ? _loc17_.maxy : _loc32_.maxy;
                  _loc35_ = _loc7_.child1 == null ? (_loc18_ = ZPP_AABBTree.tmpaabb, (_loc18_.maxx - _loc18_.minx + (_loc18_.maxy - _loc18_.miny)) * 2 + _loc34_) : (_loc18_ = _loc7_.aabb, _loc36_ = (_loc18_.maxx - _loc18_.minx + (_loc18_.maxy - _loc18_.miny)) * 2, _loc18_ = ZPP_AABBTree.tmpaabb, _loc37_ = (_loc18_.maxx - _loc18_.minx + (_loc18_.maxy - _loc18_.miny)) * 2, _loc37_ - _loc36_ + _loc34_);
                  _loc18_ = ZPP_AABBTree.tmpaabb;
                  _loc32_ = _loc8_.aabb;
                  _loc18_.minx = _loc17_.minx < _loc32_.minx ? _loc17_.minx : _loc32_.minx;
                  _loc18_.miny = _loc17_.miny < _loc32_.miny ? _loc17_.miny : _loc32_.miny;
                  _loc18_.maxx = _loc17_.maxx > _loc32_.maxx ? _loc17_.maxx : _loc32_.maxx;
                  _loc18_.maxy = _loc17_.maxy > _loc32_.maxy ? _loc17_.maxy : _loc32_.maxy;
                  _loc36_ = _loc8_.child1 == null ? (_loc18_ = ZPP_AABBTree.tmpaabb, (_loc18_.maxx - _loc18_.minx + (_loc18_.maxy - _loc18_.miny)) * 2 + _loc34_) : (_loc18_ = _loc8_.aabb, _loc37_ = (_loc18_.maxx - _loc18_.minx + (_loc18_.maxy - _loc18_.miny)) * 2, _loc18_ = ZPP_AABBTree.tmpaabb, _loc38_ = (_loc18_.maxx - _loc18_.minx + (_loc18_.maxy - _loc18_.miny)) * 2, _loc38_ - _loc37_ + _loc34_);
                  if(_loc33_ < _loc35_ && _loc33_ < _loc36_)
                  {
                     break;
                  }
                  _loc6_ = _loc35_ < _loc36_ ? _loc7_ : _loc8_;
               }
               _loc7_ = _loc6_;
               _loc8_ = _loc7_.parent;
               if(ZPP_AABBNode.zpp_pool == null)
               {
                  _loc9_ = new ZPP_AABBNode();
               }
               else
               {
                  _loc9_ = ZPP_AABBNode.zpp_pool;
                  ZPP_AABBNode.zpp_pool = _loc9_.next;
                  _loc9_.next = null;
               }
               if(ZPP_AABB.zpp_pool == null)
               {
                  _loc9_.aabb = new ZPP_AABB();
               }
               else
               {
                  _loc9_.aabb = ZPP_AABB.zpp_pool;
                  ZPP_AABB.zpp_pool = _loc9_.aabb.next;
                  _loc9_.aabb.next = null;
               }
               null;
               _loc9_.moved = false;
               _loc9_.synced = false;
               _loc9_.first_sync = false;
               _loc9_.parent = _loc8_;
               _loc18_ = _loc9_.aabb;
               _loc32_ = _loc7_.aabb;
               _loc18_.minx = _loc17_.minx < _loc32_.minx ? _loc17_.minx : _loc32_.minx;
               _loc18_.miny = _loc17_.miny < _loc32_.miny ? _loc17_.miny : _loc32_.miny;
               _loc18_.maxx = _loc17_.maxx > _loc32_.maxx ? _loc17_.maxx : _loc32_.maxx;
               _loc18_.maxy = _loc17_.maxy > _loc32_.maxy ? _loc17_.maxy : _loc32_.maxy;
               _loc9_.height = _loc7_.height + 1;
               if(_loc8_ != null)
               {
                  if(_loc8_.child1 == _loc7_)
                  {
                     _loc8_.child1 = _loc9_;
                  }
                  else
                  {
                     _loc8_.child2 = _loc9_;
                  }
                  _loc9_.child1 = _loc7_;
                  _loc9_.child2 = _loc3_;
                  _loc7_.parent = _loc9_;
                  _loc3_.parent = _loc9_;
               }
               else
               {
                  _loc9_.child1 = _loc7_;
                  _loc9_.child2 = _loc3_;
                  _loc7_.parent = _loc9_;
                  _loc3_.parent = _loc9_;
                  _loc5_.root = _loc9_;
               }
               _loc6_ = _loc3_.parent;
               while(_loc6_ != null)
               {
                  if(_loc6_.child1 == null || _loc6_.height < 2)
                  {
                     §§push(_loc6_);
                  }
                  else
                  {
                     _loc12_ = _loc6_.child1;
                     _loc13_ = _loc6_.child2;
                     _loc14_ = _loc13_.height - _loc12_.height;
                     if(_loc14_ > 1)
                     {
                        _loc15_ = _loc13_.child1;
                        _loc16_ = _loc13_.child2;
                        _loc13_.child1 = _loc6_;
                        _loc13_.parent = _loc6_.parent;
                        _loc6_.parent = _loc13_;
                        if(_loc13_.parent != null)
                        {
                           if(_loc13_.parent.child1 == _loc6_)
                           {
                              _loc13_.parent.child1 = _loc13_;
                           }
                           else
                           {
                              _loc13_.parent.child2 = _loc13_;
                           }
                        }
                        else
                        {
                           _loc5_.root = _loc13_;
                        }
                        if(_loc15_.height > _loc16_.height)
                        {
                           _loc13_.child2 = _loc15_;
                           _loc6_.child2 = _loc16_;
                           _loc16_.parent = _loc6_;
                           _loc18_ = _loc6_.aabb;
                           _loc32_ = _loc12_.aabb;
                           _loc39_ = _loc16_.aabb;
                           _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                           _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                           _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                           _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                           _loc18_ = _loc13_.aabb;
                           _loc32_ = _loc6_.aabb;
                           _loc39_ = _loc15_.aabb;
                           _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                           _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                           _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                           _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                           _loc19_ = _loc12_.height;
                           _loc20_ = _loc16_.height;
                           _loc6_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                           _loc19_ = _loc6_.height;
                           _loc20_ = _loc15_.height;
                           _loc13_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                        }
                        else
                        {
                           _loc13_.child2 = _loc16_;
                           _loc6_.child2 = _loc15_;
                           _loc15_.parent = _loc6_;
                           _loc18_ = _loc6_.aabb;
                           _loc32_ = _loc12_.aabb;
                           _loc39_ = _loc15_.aabb;
                           _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                           _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                           _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                           _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                           _loc18_ = _loc13_.aabb;
                           _loc32_ = _loc6_.aabb;
                           _loc39_ = _loc16_.aabb;
                           _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                           _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                           _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                           _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                           _loc19_ = _loc12_.height;
                           _loc20_ = _loc15_.height;
                           _loc6_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                           _loc19_ = _loc6_.height;
                           _loc20_ = _loc16_.height;
                           _loc13_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                        }
                        §§push(_loc13_);
                     }
                     else if(_loc14_ < -1)
                     {
                        _loc15_ = _loc12_.child1;
                        _loc16_ = _loc12_.child2;
                        _loc12_.child1 = _loc6_;
                        _loc12_.parent = _loc6_.parent;
                        _loc6_.parent = _loc12_;
                        if(_loc12_.parent != null)
                        {
                           if(_loc12_.parent.child1 == _loc6_)
                           {
                              _loc12_.parent.child1 = _loc12_;
                           }
                           else
                           {
                              _loc12_.parent.child2 = _loc12_;
                           }
                        }
                        else
                        {
                           _loc5_.root = _loc12_;
                        }
                        if(_loc15_.height > _loc16_.height)
                        {
                           _loc12_.child2 = _loc15_;
                           _loc6_.child1 = _loc16_;
                           _loc16_.parent = _loc6_;
                           _loc18_ = _loc6_.aabb;
                           _loc32_ = _loc13_.aabb;
                           _loc39_ = _loc16_.aabb;
                           _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                           _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                           _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                           _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                           _loc18_ = _loc12_.aabb;
                           _loc32_ = _loc6_.aabb;
                           _loc39_ = _loc15_.aabb;
                           _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                           _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                           _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                           _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                           _loc19_ = _loc13_.height;
                           _loc20_ = _loc16_.height;
                           _loc6_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                           _loc19_ = _loc6_.height;
                           _loc20_ = _loc15_.height;
                           _loc12_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                        }
                        else
                        {
                           _loc12_.child2 = _loc16_;
                           _loc6_.child1 = _loc15_;
                           _loc15_.parent = _loc6_;
                           _loc18_ = _loc6_.aabb;
                           _loc32_ = _loc13_.aabb;
                           _loc39_ = _loc15_.aabb;
                           _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                           _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                           _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                           _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                           _loc18_ = _loc12_.aabb;
                           _loc32_ = _loc6_.aabb;
                           _loc39_ = _loc16_.aabb;
                           _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                           _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                           _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                           _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                           _loc19_ = _loc13_.height;
                           _loc20_ = _loc15_.height;
                           _loc6_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                           _loc19_ = _loc6_.height;
                           _loc20_ = _loc16_.height;
                           _loc12_.height = 1 + (_loc19_ > _loc20_ ? _loc19_ : _loc20_);
                        }
                        §§push(_loc12_);
                     }
                     else
                     {
                        §§push(_loc6_);
                     }
                  }
                  _loc6_ = §§pop();
                  _loc12_ = _loc6_.child1;
                  _loc13_ = _loc6_.child2;
                  _loc14_ = _loc12_.height;
                  _loc19_ = _loc13_.height;
                  _loc6_.height = 1 + (_loc14_ > _loc19_ ? _loc14_ : _loc19_);
                  _loc18_ = _loc6_.aabb;
                  _loc32_ = _loc12_.aabb;
                  _loc39_ = _loc13_.aabb;
                  _loc18_.minx = _loc32_.minx < _loc39_.minx ? _loc32_.minx : _loc39_.minx;
                  _loc18_.miny = _loc32_.miny < _loc39_.miny ? _loc32_.miny : _loc39_.miny;
                  _loc18_.maxx = _loc32_.maxx > _loc39_.maxx ? _loc32_.maxx : _loc39_.maxx;
                  _loc18_.maxy = _loc32_.maxy > _loc39_.maxy ? _loc32_.maxy : _loc39_.maxy;
                  _loc6_ = _loc6_.parent;
               }
            }
            _loc3_.synced = false;
            _loc3_ = _loc3_.snext;
         }
         while(syncs != null)
         {
            _loc7_ = syncs;
            syncs = _loc7_.snext;
            _loc7_.snext = null;
            _loc6_ = _loc7_;
            if(!_loc6_.moved)
            {
               _loc6_.moved = false;
               _loc4_ = _loc6_.shape;
               _loc30_ = _loc4_.body;
               if(!_loc30_.component.sleeping)
               {
                  _loc10_ = _loc6_.aabb;
                  _loc7_ = null;
                  if(dtree.root != null)
                  {
                     dtree.root.next = _loc7_;
                     _loc7_ = dtree.root;
                  }
                  while(_loc7_ != null)
                  {
                     _loc9_ = _loc7_;
                     _loc7_ = _loc9_.next;
                     _loc9_.next = null;
                     _loc8_ = _loc9_;
                     if(_loc8_ != _loc6_)
                     {
                        if(_loc8_.child1 == null)
                        {
                           _loc40_ = _loc8_.shape;
                           if(_loc40_.body != _loc4_.body && !(_loc40_.body.type == ZPP_Flags.id_BodyType_STATIC && _loc4_.body.type == ZPP_Flags.id_BodyType_STATIC))
                           {
                              _loc17_ = _loc8_.aabb;
                              if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
                              {
                                 if(_loc4_.id < _loc40_.id)
                                 {
                                    _loc14_ = _loc4_.id;
                                    _loc19_ = _loc40_.id;
                                 }
                                 else
                                 {
                                    _loc14_ = _loc40_.id;
                                    _loc19_ = _loc4_.id;
                                 }
                                 _loc41_ = _loc4_.pairs.length < _loc40_.pairs.length ? _loc4_ : _loc40_;
                                 _loc42_ = null;
                                 _loc43_ = _loc41_.pairs.head;
                                 while(_loc43_ != null)
                                 {
                                    _loc44_ = _loc43_.elt;
                                    if(_loc44_.id == _loc14_ && _loc44_.di == _loc19_)
                                    {
                                       _loc42_ = _loc44_;
                                       break;
                                    }
                                    _loc43_ = _loc43_.next;
                                 }
                                 if(_loc42_ != null)
                                 {
                                    if(_loc42_.sleeping)
                                    {
                                       _loc42_.sleeping = false;
                                       _loc42_.next = pairs;
                                       pairs = _loc42_;
                                       _loc42_.first = true;
                                    }
                                    continue;
                                 }
                                 if(ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc42_ = new ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc42_ = ZPP_AABBPair.zpp_pool;
                                    ZPP_AABBPair.zpp_pool = _loc42_.next;
                                    _loc42_.next = null;
                                 }
                                 null;
                                 _loc42_.n1 = _loc6_;
                                 _loc42_.n2 = _loc8_;
                                 _loc42_.id = _loc14_;
                                 _loc42_.di = _loc19_;
                                 _loc42_.next = pairs;
                                 pairs = _loc42_;
                                 _loc42_.first = true;
                                 _loc45_ = _loc4_.pairs;
                                 if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc46_ = new ZNPNode_ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc46_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc46_.next;
                                    _loc46_.next = null;
                                 }
                                 null;
                                 _loc46_.elt = _loc42_;
                                 _loc43_ = _loc46_;
                                 _loc43_.next = _loc45_.head;
                                 _loc45_.head = _loc43_;
                                 _loc45_.modified = true;
                                 ++_loc45_.length;
                                 _loc42_;
                                 _loc45_ = _loc40_.pairs;
                                 if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc46_ = new ZNPNode_ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc46_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc46_.next;
                                    _loc46_.next = null;
                                 }
                                 null;
                                 _loc46_.elt = _loc42_;
                                 _loc43_ = _loc46_;
                                 _loc43_.next = _loc45_.head;
                                 _loc45_.head = _loc43_;
                                 _loc45_.modified = true;
                                 ++_loc45_.length;
                                 _loc42_;
                              }
                           }
                        }
                        else
                        {
                           _loc17_ = _loc8_.aabb;
                           if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
                           {
                              if(_loc8_.child1 != null)
                              {
                                 _loc8_.child1.next = _loc7_;
                                 _loc7_ = _loc8_.child1;
                              }
                              if(_loc8_.child2 != null)
                              {
                                 _loc8_.child2.next = _loc7_;
                                 _loc7_ = _loc8_.child2;
                              }
                           }
                        }
                     }
                  }
                  if(stree.root != null)
                  {
                     stree.root.next = _loc7_;
                     _loc7_ = stree.root;
                  }
                  while(_loc7_ != null)
                  {
                     _loc9_ = _loc7_;
                     _loc7_ = _loc9_.next;
                     _loc9_.next = null;
                     _loc8_ = _loc9_;
                     if(_loc8_ != _loc6_)
                     {
                        if(_loc8_.child1 == null)
                        {
                           _loc40_ = _loc8_.shape;
                           if(_loc40_.body != _loc4_.body && !(_loc40_.body.type == ZPP_Flags.id_BodyType_STATIC && _loc4_.body.type == ZPP_Flags.id_BodyType_STATIC))
                           {
                              _loc17_ = _loc8_.aabb;
                              if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
                              {
                                 if(_loc4_.id < _loc40_.id)
                                 {
                                    _loc14_ = _loc4_.id;
                                    _loc19_ = _loc40_.id;
                                 }
                                 else
                                 {
                                    _loc14_ = _loc40_.id;
                                    _loc19_ = _loc4_.id;
                                 }
                                 _loc41_ = _loc4_.pairs.length < _loc40_.pairs.length ? _loc4_ : _loc40_;
                                 _loc42_ = null;
                                 _loc43_ = _loc41_.pairs.head;
                                 while(_loc43_ != null)
                                 {
                                    _loc44_ = _loc43_.elt;
                                    if(_loc44_.id == _loc14_ && _loc44_.di == _loc19_)
                                    {
                                       _loc42_ = _loc44_;
                                       break;
                                    }
                                    _loc43_ = _loc43_.next;
                                 }
                                 if(_loc42_ != null)
                                 {
                                    if(_loc42_.sleeping)
                                    {
                                       _loc42_.sleeping = false;
                                       _loc42_.next = pairs;
                                       pairs = _loc42_;
                                       _loc42_.first = true;
                                    }
                                    continue;
                                 }
                                 if(ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc42_ = new ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc42_ = ZPP_AABBPair.zpp_pool;
                                    ZPP_AABBPair.zpp_pool = _loc42_.next;
                                    _loc42_.next = null;
                                 }
                                 null;
                                 _loc42_.n1 = _loc6_;
                                 _loc42_.n2 = _loc8_;
                                 _loc42_.id = _loc14_;
                                 _loc42_.di = _loc19_;
                                 _loc42_.next = pairs;
                                 pairs = _loc42_;
                                 _loc42_.first = true;
                                 _loc45_ = _loc4_.pairs;
                                 if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc46_ = new ZNPNode_ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc46_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc46_.next;
                                    _loc46_.next = null;
                                 }
                                 null;
                                 _loc46_.elt = _loc42_;
                                 _loc43_ = _loc46_;
                                 _loc43_.next = _loc45_.head;
                                 _loc45_.head = _loc43_;
                                 _loc45_.modified = true;
                                 ++_loc45_.length;
                                 _loc42_;
                                 _loc45_ = _loc40_.pairs;
                                 if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc46_ = new ZNPNode_ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc46_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc46_.next;
                                    _loc46_.next = null;
                                 }
                                 null;
                                 _loc46_.elt = _loc42_;
                                 _loc43_ = _loc46_;
                                 _loc43_.next = _loc45_.head;
                                 _loc45_.head = _loc43_;
                                 _loc45_.modified = true;
                                 ++_loc45_.length;
                                 _loc42_;
                              }
                           }
                        }
                        else
                        {
                           _loc17_ = _loc8_.aabb;
                           if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
                           {
                              if(_loc8_.child1 != null)
                              {
                                 _loc8_.child1.next = _loc7_;
                                 _loc7_ = _loc8_.child1;
                              }
                              if(_loc8_.child2 != null)
                              {
                                 _loc8_.child2.next = _loc7_;
                                 _loc7_ = _loc8_.child2;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         while(moves != null)
         {
            _loc7_ = moves;
            moves = _loc7_.mnext;
            _loc7_.mnext = null;
            _loc6_ = _loc7_;
            _loc6_.moved = false;
            _loc4_ = _loc6_.shape;
            _loc30_ = _loc4_.body;
            if(!_loc30_.component.sleeping)
            {
               _loc10_ = _loc6_.aabb;
               _loc7_ = null;
               if(dtree.root != null)
               {
                  dtree.root.next = _loc7_;
                  _loc7_ = dtree.root;
               }
               while(_loc7_ != null)
               {
                  _loc9_ = _loc7_;
                  _loc7_ = _loc9_.next;
                  _loc9_.next = null;
                  _loc8_ = _loc9_;
                  if(_loc8_ != _loc6_)
                  {
                     if(_loc8_.child1 == null)
                     {
                        _loc40_ = _loc8_.shape;
                        if(_loc40_.body != _loc4_.body && !(_loc40_.body.type == ZPP_Flags.id_BodyType_STATIC && _loc4_.body.type == ZPP_Flags.id_BodyType_STATIC))
                        {
                           _loc17_ = _loc8_.aabb;
                           if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
                           {
                              if(_loc4_.id < _loc40_.id)
                              {
                                 _loc14_ = _loc4_.id;
                                 _loc19_ = _loc40_.id;
                              }
                              else
                              {
                                 _loc14_ = _loc40_.id;
                                 _loc19_ = _loc4_.id;
                              }
                              _loc41_ = _loc4_.pairs.length < _loc40_.pairs.length ? _loc4_ : _loc40_;
                              _loc42_ = null;
                              _loc43_ = _loc41_.pairs.head;
                              while(_loc43_ != null)
                              {
                                 _loc44_ = _loc43_.elt;
                                 if(_loc44_.id == _loc14_ && _loc44_.di == _loc19_)
                                 {
                                    _loc42_ = _loc44_;
                                    break;
                                 }
                                 _loc43_ = _loc43_.next;
                              }
                              if(_loc42_ != null)
                              {
                                 if(_loc42_.sleeping)
                                 {
                                    _loc42_.sleeping = false;
                                    _loc42_.next = pairs;
                                    pairs = _loc42_;
                                    _loc42_.first = true;
                                 }
                                 continue;
                              }
                              if(ZPP_AABBPair.zpp_pool == null)
                              {
                                 _loc42_ = new ZPP_AABBPair();
                              }
                              else
                              {
                                 _loc42_ = ZPP_AABBPair.zpp_pool;
                                 ZPP_AABBPair.zpp_pool = _loc42_.next;
                                 _loc42_.next = null;
                              }
                              null;
                              _loc42_.n1 = _loc6_;
                              _loc42_.n2 = _loc8_;
                              _loc42_.id = _loc14_;
                              _loc42_.di = _loc19_;
                              _loc42_.next = pairs;
                              pairs = _loc42_;
                              _loc42_.first = true;
                              _loc45_ = _loc4_.pairs;
                              if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                              {
                                 _loc46_ = new ZNPNode_ZPP_AABBPair();
                              }
                              else
                              {
                                 _loc46_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                 ZNPNode_ZPP_AABBPair.zpp_pool = _loc46_.next;
                                 _loc46_.next = null;
                              }
                              null;
                              _loc46_.elt = _loc42_;
                              _loc43_ = _loc46_;
                              _loc43_.next = _loc45_.head;
                              _loc45_.head = _loc43_;
                              _loc45_.modified = true;
                              ++_loc45_.length;
                              _loc42_;
                              _loc45_ = _loc40_.pairs;
                              if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                              {
                                 _loc46_ = new ZNPNode_ZPP_AABBPair();
                              }
                              else
                              {
                                 _loc46_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                 ZNPNode_ZPP_AABBPair.zpp_pool = _loc46_.next;
                                 _loc46_.next = null;
                              }
                              null;
                              _loc46_.elt = _loc42_;
                              _loc43_ = _loc46_;
                              _loc43_.next = _loc45_.head;
                              _loc45_.head = _loc43_;
                              _loc45_.modified = true;
                              ++_loc45_.length;
                              _loc42_;
                           }
                        }
                     }
                     else
                     {
                        _loc17_ = _loc8_.aabb;
                        if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
                        {
                           if(_loc8_.child1 != null)
                           {
                              _loc8_.child1.next = _loc7_;
                              _loc7_ = _loc8_.child1;
                           }
                           if(_loc8_.child2 != null)
                           {
                              _loc8_.child2.next = _loc7_;
                              _loc7_ = _loc8_.child2;
                           }
                        }
                     }
                  }
               }
               if(stree.root != null)
               {
                  stree.root.next = _loc7_;
                  _loc7_ = stree.root;
               }
               while(_loc7_ != null)
               {
                  _loc9_ = _loc7_;
                  _loc7_ = _loc9_.next;
                  _loc9_.next = null;
                  _loc8_ = _loc9_;
                  if(_loc8_ != _loc6_)
                  {
                     if(_loc8_.child1 == null)
                     {
                        _loc40_ = _loc8_.shape;
                        if(_loc40_.body != _loc4_.body && !(_loc40_.body.type == ZPP_Flags.id_BodyType_STATIC && _loc4_.body.type == ZPP_Flags.id_BodyType_STATIC))
                        {
                           _loc17_ = _loc8_.aabb;
                           if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
                           {
                              if(_loc4_.id < _loc40_.id)
                              {
                                 _loc14_ = _loc4_.id;
                                 _loc19_ = _loc40_.id;
                              }
                              else
                              {
                                 _loc14_ = _loc40_.id;
                                 _loc19_ = _loc4_.id;
                              }
                              _loc41_ = _loc4_.pairs.length < _loc40_.pairs.length ? _loc4_ : _loc40_;
                              _loc42_ = null;
                              _loc43_ = _loc41_.pairs.head;
                              while(_loc43_ != null)
                              {
                                 _loc44_ = _loc43_.elt;
                                 if(_loc44_.id == _loc14_ && _loc44_.di == _loc19_)
                                 {
                                    _loc42_ = _loc44_;
                                    break;
                                 }
                                 _loc43_ = _loc43_.next;
                              }
                              if(_loc42_ != null)
                              {
                                 if(_loc42_.sleeping)
                                 {
                                    _loc42_.sleeping = false;
                                    _loc42_.next = pairs;
                                    pairs = _loc42_;
                                    _loc42_.first = true;
                                 }
                                 continue;
                              }
                              if(ZPP_AABBPair.zpp_pool == null)
                              {
                                 _loc42_ = new ZPP_AABBPair();
                              }
                              else
                              {
                                 _loc42_ = ZPP_AABBPair.zpp_pool;
                                 ZPP_AABBPair.zpp_pool = _loc42_.next;
                                 _loc42_.next = null;
                              }
                              null;
                              _loc42_.n1 = _loc6_;
                              _loc42_.n2 = _loc8_;
                              _loc42_.id = _loc14_;
                              _loc42_.di = _loc19_;
                              _loc42_.next = pairs;
                              pairs = _loc42_;
                              _loc42_.first = true;
                              _loc45_ = _loc4_.pairs;
                              if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                              {
                                 _loc46_ = new ZNPNode_ZPP_AABBPair();
                              }
                              else
                              {
                                 _loc46_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                 ZNPNode_ZPP_AABBPair.zpp_pool = _loc46_.next;
                                 _loc46_.next = null;
                              }
                              null;
                              _loc46_.elt = _loc42_;
                              _loc43_ = _loc46_;
                              _loc43_.next = _loc45_.head;
                              _loc45_.head = _loc43_;
                              _loc45_.modified = true;
                              ++_loc45_.length;
                              _loc42_;
                              _loc45_ = _loc40_.pairs;
                              if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                              {
                                 _loc46_ = new ZNPNode_ZPP_AABBPair();
                              }
                              else
                              {
                                 _loc46_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                 ZNPNode_ZPP_AABBPair.zpp_pool = _loc46_.next;
                                 _loc46_.next = null;
                              }
                              null;
                              _loc46_.elt = _loc42_;
                              _loc43_ = _loc46_;
                              _loc43_.next = _loc45_.head;
                              _loc45_.head = _loc43_;
                              _loc45_.modified = true;
                              ++_loc45_.length;
                              _loc42_;
                           }
                        }
                     }
                     else
                     {
                        _loc17_ = _loc8_.aabb;
                        if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
                        {
                           if(_loc8_.child1 != null)
                           {
                              _loc8_.child1.next = _loc7_;
                              _loc7_ = _loc8_.child1;
                           }
                           if(_loc8_.child2 != null)
                           {
                              _loc8_.child2.next = _loc7_;
                              _loc7_ = _loc8_.child2;
                           }
                        }
                     }
                  }
               }
            }
         }
         _loc42_ = null;
         _loc44_ = pairs;
         while(_loc44_ != null)
         {
            if(!_loc44_.first && !(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx))
            {
               if(_loc42_ == null)
               {
                  pairs = _loc44_.next;
               }
               else
               {
                  _loc42_.next = _loc44_.next;
               }
               _loc45_ = _loc44_.n1.shape.pairs;
               _loc43_ = null;
               _loc46_ = _loc45_.head;
               _loc31_ = false;
               while(_loc46_ != null)
               {
                  if(_loc46_.elt == _loc44_)
                  {
                     if(_loc43_ == null)
                     {
                        _loc47_ = _loc45_.head;
                        _loc48_ = _loc47_.next;
                        _loc45_.head = _loc48_;
                        if(_loc45_.head == null)
                        {
                           _loc45_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc47_ = _loc43_.next;
                        _loc48_ = _loc47_.next;
                        _loc43_.next = _loc48_;
                        if(_loc48_ == null)
                        {
                           _loc45_.pushmod = true;
                        }
                     }
                     _loc49_ = _loc47_;
                     _loc49_.elt = null;
                     _loc49_.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                     ZNPNode_ZPP_AABBPair.zpp_pool = _loc49_;
                     _loc45_.modified = true;
                     --_loc45_.length;
                     _loc45_.pushmod = true;
                     _loc48_;
                     _loc31_ = true;
                     break;
                  }
                  _loc43_ = _loc46_;
                  _loc46_ = _loc46_.next;
               }
               _loc31_;
               _loc45_ = _loc44_.n2.shape.pairs;
               _loc43_ = null;
               _loc46_ = _loc45_.head;
               _loc31_ = false;
               while(_loc46_ != null)
               {
                  if(_loc46_.elt == _loc44_)
                  {
                     if(_loc43_ == null)
                     {
                        _loc47_ = _loc45_.head;
                        _loc48_ = _loc47_.next;
                        _loc45_.head = _loc48_;
                        if(_loc45_.head == null)
                        {
                           _loc45_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc47_ = _loc43_.next;
                        _loc48_ = _loc47_.next;
                        _loc43_.next = _loc48_;
                        if(_loc48_ == null)
                        {
                           _loc45_.pushmod = true;
                        }
                     }
                     _loc49_ = _loc47_;
                     _loc49_.elt = null;
                     _loc49_.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                     ZNPNode_ZPP_AABBPair.zpp_pool = _loc49_;
                     _loc45_.modified = true;
                     --_loc45_.length;
                     _loc45_.pushmod = true;
                     _loc48_;
                     _loc31_ = true;
                     break;
                  }
                  _loc43_ = _loc46_;
                  _loc46_ = _loc46_.next;
               }
               _loc31_;
               _loc50_ = _loc44_.next;
               if(_loc44_.arb != null)
               {
                  _loc44_.arb.pair = null;
               }
               _loc44_.arb = null;
               _loc51_ = _loc44_;
               _loc51_.n1 = _loc51_.n2 = null;
               _loc51_.sleeping = false;
               _loc51_.next = ZPP_AABBPair.zpp_pool;
               ZPP_AABBPair.zpp_pool = _loc51_;
               _loc44_ = _loc50_;
            }
            else
            {
               _loc4_ = _loc44_.n1.shape;
               _loc30_ = _loc4_.body;
               _loc40_ = _loc44_.n2.shape;
               _loc52_ = _loc40_.body;
               if(!_loc44_.first)
               {
                  if((_loc30_.component.sleeping || _loc30_.type == ZPP_Flags.id_BodyType_STATIC) && (_loc52_.component.sleeping || _loc52_.type == ZPP_Flags.id_BodyType_STATIC))
                  {
                     _loc44_.sleeping = true;
                     if(_loc42_ == null)
                     {
                        pairs = _loc44_.next;
                     }
                     else
                     {
                        _loc42_.next = _loc44_.next;
                     }
                     _loc44_ = _loc44_.next;
                     continue;
                  }
               }
               _loc44_.first = false;
               _loc10_ = _loc4_.aabb;
               _loc17_ = _loc40_.aabb;
               if(_loc17_.miny <= _loc10_.maxy && _loc10_.miny <= _loc17_.maxy && _loc17_.minx <= _loc10_.maxx && _loc10_.minx <= _loc17_.maxx)
               {
                  _loc53_ = _loc44_.arb;
                  if(param2)
                  {
                     _loc44_.arb = param1.narrowPhase(_loc4_,_loc40_,_loc30_.type != ZPP_Flags.id_BodyType_DYNAMIC || _loc52_.type != ZPP_Flags.id_BodyType_DYNAMIC,_loc44_.arb,false);
                  }
                  else
                  {
                     _loc44_.arb = param1.continuousEvent(_loc4_,_loc40_,_loc30_.type != ZPP_Flags.id_BodyType_DYNAMIC || _loc52_.type != ZPP_Flags.id_BodyType_DYNAMIC,_loc44_.arb,false);
                  }
                  if(_loc44_.arb == null)
                  {
                     if(_loc53_ != null)
                     {
                        _loc53_.pair = null;
                     }
                  }
                  else
                  {
                     _loc44_.arb.pair = _loc44_;
                  }
               }
               _loc42_ = _loc44_;
               _loc44_ = _loc44_.next;
            }
         }
      }
      
      override public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as Body;
         var _loc12_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         var _loc6_:Boolean = false;
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
         _loc7_._immutable = _loc6_;
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
         _loc9_.wrap_min = _loc9_.wrap_max = null;
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
         null;
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

