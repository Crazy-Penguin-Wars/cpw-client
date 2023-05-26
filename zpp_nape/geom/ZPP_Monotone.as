package zpp_nape.geom
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.geom.Vec2;
   import zpp_nape.util.ZNPList_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPNode_ZPP_PartitionVertex;
   import zpp_nape.util.ZPP_Set_ZPP_PartitionVertex;
   
   public class ZPP_Monotone
   {
      
      public static var sharedPPoly:ZPP_PartitionedPoly;
      
      public static var queue:ZNPList_ZPP_PartitionVertex = null;
      
      public static var edges:ZPP_Set_ZPP_PartitionVertex = null;
       
      
      public function ZPP_Monotone()
      {
      }
      
      public static function bisector(param1:ZPP_PartitionVertex) : ZPP_Vec2
      {
         var _loc10_:* = null as ZPP_Vec2;
         var _loc2_:ZPP_PartitionVertex = param1.prev;
         var _loc3_:ZPP_PartitionVertex = param1.next;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         _loc4_ = param1.x - _loc2_.x;
         _loc5_ = param1.y - _loc2_.y;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         _loc6_ = _loc3_.x - param1.x;
         _loc7_ = _loc3_.y - param1.y;
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
         _loc10_._immutable = false;
         _loc10_.x = -_loc5_ - _loc7_;
         _loc10_.y = _loc4_ + _loc6_;
         var _loc8_:ZPP_Vec2 = _loc10_;
         var _loc11_:Number = _loc8_.x * _loc8_.x + _loc8_.y * _loc8_.y;
         sf32(_loc11_,0);
         si32(1597463007 - (li32(0) >> 1),0);
         var _loc13_:Number = lf32(0);
         var _loc12_:Number = _loc13_ * (1.5 - 0.5 * _loc11_ * _loc13_ * _loc13_);
         _loc13_ = _loc12_;
         _loc8_.x *= _loc13_;
         _loc8_.y *= _loc13_;
         if(_loc7_ * _loc4_ - _loc6_ * _loc5_ < 0)
         {
            _loc8_.x = -_loc8_.x;
            _loc8_.y = -_loc8_.y;
         }
         return _loc8_;
      }
      
      public static function below(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Vec2;
         if(param1.y < param2.y)
         {
            return true;
         }
         if(param1.y > param2.y)
         {
            return false;
         }
         if(param1.x < param2.x)
         {
            return true;
         }
         if(param1.x > param2.x)
         {
            return false;
         }
         _loc3_ = ZPP_Monotone.bisector(param1);
         _loc4_ = ZPP_Monotone.bisector(param2);
         _loc5_ = 1;
         _loc3_.x += param1.x * _loc5_;
         _loc3_.y += param1.y * _loc5_;
         _loc5_ = 1;
         _loc4_.x += param2.x * _loc5_;
         _loc4_.y += param2.y * _loc5_;
         _loc6_ = _loc3_.x < _loc4_.x || _loc3_.x == _loc4_.x && _loc3_.y < _loc4_.y;
         _loc7_ = _loc3_;
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
         _loc7_ = _loc4_;
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
         return _loc6_;
      }
      
      public static function above(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         return ZPP_Monotone.below(param2,param1);
      }
      
      public static function left_vertex(param1:ZPP_PartitionVertex) : Boolean
      {
         var _loc2_:ZPP_PartitionVertex = param1.prev;
         return _loc2_.y > param1.y || _loc2_.y == param1.y && param1.next.y < param1.y;
      }
      
      public static function isMonotone(param1:ZPP_GeomVert) : Boolean
      {
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc2_:ZPP_GeomVert = param1;
         var _loc3_:ZPP_GeomVert = param1;
         var _loc4_:ZPP_GeomVert = param1.next;
         _loc5_ = param1;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_;
            do
            {
               _loc7_ = _loc6_;
               if(_loc7_.y < _loc2_.y)
               {
                  _loc2_ = _loc7_;
               }
               if(_loc7_.y > _loc3_.y)
               {
                  _loc3_ = _loc7_;
               }
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != _loc5_);
            
         }
         var _loc8_:Boolean = true;
         _loc4_ = _loc2_;
         if(_loc3_ != _loc2_.next)
         {
            _loc5_ = _loc2_.next;
            _loc6_ = _loc3_;
            if(_loc5_ != null)
            {
               _loc7_ = _loc5_;
               do
               {
                  _loc9_ = _loc7_;
                  if(_loc9_.y < _loc4_.y)
                  {
                     _loc8_ = false;
                     break;
                  }
                  _loc4_ = _loc9_;
                  _loc7_ = _loc7_.next;
               }
               while(_loc7_ != _loc6_);
               
            }
         }
         if(!_loc8_)
         {
            return false;
         }
         _loc4_ = _loc2_;
         if(_loc3_ != _loc2_.prev)
         {
            _loc5_ = _loc2_.prev;
            _loc6_ = _loc3_;
            if(_loc5_ != null)
            {
               _loc7_ = _loc5_;
               do
               {
                  _loc9_ = _loc7_;
                  if(_loc9_.y < _loc4_.y)
                  {
                     _loc8_ = false;
                     break;
                  }
                  _loc4_ = _loc9_;
                  _loc7_ = _loc7_.prev;
               }
               while(_loc7_ != _loc6_);
               
            }
         }
         return _loc8_;
      }
      
      public static function getShared() : ZPP_PartitionedPoly
      {
         if(ZPP_Monotone.sharedPPoly == null)
         {
            ZPP_Monotone.sharedPPoly = new ZPP_PartitionedPoly();
         }
         return ZPP_Monotone.sharedPPoly;
      }
      
      public static function decompose(param1:ZPP_GeomVert, param2:ZPP_PartitionedPoly = undefined) : ZPP_PartitionedPoly
      {
         var _loc3_:* = null as ZPP_PartitionVertex;
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:* = null as ZPP_PartitionVertex;
         var _loc6_:* = null as ZPP_PartitionVertex;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc13_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc14_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc15_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc16_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc17_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:* = null as ZPP_Set_ZPP_PartitionVertex;
         var _loc23_:* = null as ZPP_PartitionVertex;
         if(param2 == null)
         {
            param2 = new ZPP_PartitionedPoly(param1);
         }
         else
         {
            param2.init(param1);
         }
         if(param2.vertices == null)
         {
            return param2;
         }
         if(ZPP_Monotone.queue == null)
         {
            ZPP_Monotone.queue = new ZNPList_ZPP_PartitionVertex();
         }
         _loc3_ = param2.vertices;
         _loc4_ = param2.vertices;
         if(_loc3_ != null)
         {
            _loc5_ = _loc3_;
            do
            {
               _loc6_ = _loc5_;
               ZPP_Monotone.queue.add(_loc6_);
               _loc7_ = 0;
               _loc8_ = 0;
               _loc7_ = _loc6_.next.x - _loc6_.x;
               _loc8_ = _loc6_.next.y - _loc6_.y;
               _loc9_ = 0;
               _loc10_ = 0;
               _loc9_ = _loc6_.prev.x - _loc6_.x;
               _loc10_ = _loc6_.prev.y - _loc6_.y;
               _loc11_ = _loc10_ * _loc7_ - _loc9_ * _loc8_ > 0;
               _loc6_.type = ZPP_Monotone.below(_loc6_.prev,_loc6_) ? (ZPP_Monotone.below(_loc6_.next,_loc6_) ? (_loc11_ ? 0 : 3) : 4) : (ZPP_Monotone.below(_loc6_,_loc6_.next) ? (_loc11_ ? 1 : 2) : 4);
               _loc5_ = _loc5_.next;
            }
            while(_loc5_ != _loc4_);
            
         }
         var _loc12_:ZNPList_ZPP_PartitionVertex = ZPP_Monotone.queue;
         if(_loc12_.head != null && _loc12_.head.next != null)
         {
            _loc13_ = _loc12_.head;
            _loc14_ = null;
            _loc15_ = null;
            _loc16_ = null;
            _loc17_ = null;
            _loc18_ = 1;
            do
            {
               _loc19_ = 0;
               _loc15_ = _loc13_;
               _loc14_ = _loc13_ = null;
               while(_loc15_ != null)
               {
                  _loc19_++;
                  _loc16_ = _loc15_;
                  _loc20_ = 0;
                  _loc21_ = _loc18_;
                  while(_loc16_ != null && _loc20_ < _loc18_)
                  {
                     _loc20_++;
                     _loc16_ = _loc16_.next;
                  }
                  while(_loc20_ > 0 || _loc21_ > 0 && _loc16_ != null)
                  {
                     if(_loc20_ == 0)
                     {
                        _loc17_ = _loc16_;
                        _loc16_ = _loc16_.next;
                        _loc21_--;
                     }
                     else if(_loc21_ == 0 || _loc16_ == null)
                     {
                        _loc17_ = _loc15_;
                        _loc15_ = _loc15_.next;
                        _loc20_--;
                     }
                     else if(ZPP_Monotone.above(_loc15_.elt,_loc16_.elt))
                     {
                        _loc17_ = _loc15_;
                        _loc15_ = _loc15_.next;
                        _loc20_--;
                     }
                     else
                     {
                        _loc17_ = _loc16_;
                        _loc16_ = _loc16_.next;
                        _loc21_--;
                     }
                     if(_loc14_ != null)
                     {
                        _loc14_.next = _loc17_;
                     }
                     else
                     {
                        _loc13_ = _loc17_;
                     }
                     _loc14_ = _loc17_;
                  }
                  _loc15_ = _loc16_;
               }
               _loc14_.next = null;
               _loc18_ <<= 1;
            }
            while(_loc19_ > 1);
            
            _loc12_.head = _loc13_;
            _loc12_.modified = true;
            _loc12_.pushmod = true;
         }
         if(ZPP_Monotone.edges == null)
         {
            if(ZPP_Set_ZPP_PartitionVertex.zpp_pool == null)
            {
               ZPP_Monotone.edges = new ZPP_Set_ZPP_PartitionVertex();
            }
            else
            {
               ZPP_Monotone.edges = ZPP_Set_ZPP_PartitionVertex.zpp_pool;
               ZPP_Set_ZPP_PartitionVertex.zpp_pool = ZPP_Monotone.edges.next;
               ZPP_Monotone.edges.next = null;
            }
            ZPP_Monotone.edges.lt = ZPP_PartitionVertex.edge_lt;
            ZPP_Monotone.edges.swapped = ZPP_PartitionVertex.edge_swap;
         }
         while(ZPP_Monotone.queue.head != null)
         {
            _loc3_ = ZPP_Monotone.queue.pop_unsafe();
            switch(_loc3_.type)
            {
               case 0:
                  _loc3_.helper = _loc3_;
                  _loc3_.node = ZPP_Monotone.edges.insert(_loc3_);
                  break;
               case 1:
                  _loc4_ = _loc3_.prev;
                  if(_loc4_.helper == null)
                  {
                     Boot.lastError = new Error();
                     throw "Fatal error (1): Polygon is not weakly-simple and clockwise";
                  }
                  if(_loc4_.helper.type == 2)
                  {
                     param2.add_diagonal(_loc3_,_loc4_.helper);
                  }
                  ZPP_Monotone.edges.remove_node(_loc4_.node);
                  _loc4_.helper = null;
                  break;
               case 2:
                  _loc4_ = _loc3_.prev;
                  if(_loc4_.helper == null)
                  {
                     Boot.lastError = new Error();
                     throw "Fatal error (3): Polygon is not weakly-simple and clockwise";
                  }
                  if(_loc4_.helper.type == 2)
                  {
                     param2.add_diagonal(_loc3_,_loc4_.helper);
                  }
                  ZPP_Monotone.edges.remove_node(_loc4_.node);
                  _loc4_.helper = null;
                  _loc6_ = null;
                  if(!ZPP_Monotone.edges.empty())
                  {
                     _loc22_ = ZPP_Monotone.edges.parent;
                     while(_loc22_.prev != null)
                     {
                        _loc22_ = _loc22_.prev;
                     }
                     while(_loc22_ != null)
                     {
                        _loc23_ = _loc22_.data;
                        if(!ZPP_PartitionVertex.vert_lt(_loc23_,_loc3_))
                        {
                           _loc6_ = _loc23_;
                           break;
                        }
                        if(_loc22_.next != null)
                        {
                           _loc22_ = _loc22_.next;
                           while(_loc22_.prev != null)
                           {
                              _loc22_ = _loc22_.prev;
                           }
                        }
                        else
                        {
                           while(_loc22_.parent != null && _loc22_ == _loc22_.parent.next)
                           {
                              _loc22_ = _loc22_.parent;
                           }
                           _loc22_ = _loc22_.parent;
                        }
                     }
                  }
                  _loc5_ = _loc6_;
                  if(_loc5_ != null)
                  {
                     if(_loc5_.helper == null)
                     {
                        Boot.lastError = new Error();
                        throw "Fatal error (4): Polygon is not weakly-simple and clockwise";
                     }
                     if(_loc5_.helper.type == 2)
                     {
                        param2.add_diagonal(_loc3_,_loc5_.helper);
                     }
                     _loc5_.helper = _loc3_;
                  }
                  break;
               case 3:
                  _loc5_ = null;
                  if(!ZPP_Monotone.edges.empty())
                  {
                     _loc22_ = ZPP_Monotone.edges.parent;
                     while(_loc22_.prev != null)
                     {
                        _loc22_ = _loc22_.prev;
                     }
                     while(_loc22_ != null)
                     {
                        _loc6_ = _loc22_.data;
                        if(!ZPP_PartitionVertex.vert_lt(_loc6_,_loc3_))
                        {
                           _loc5_ = _loc6_;
                           break;
                        }
                        if(_loc22_.next != null)
                        {
                           _loc22_ = _loc22_.next;
                           while(_loc22_.prev != null)
                           {
                              _loc22_ = _loc22_.prev;
                           }
                        }
                        else
                        {
                           while(_loc22_.parent != null && _loc22_ == _loc22_.parent.next)
                           {
                              _loc22_ = _loc22_.parent;
                           }
                           _loc22_ = _loc22_.parent;
                        }
                     }
                  }
                  _loc4_ = _loc5_;
                  if(_loc4_ != null)
                  {
                     if(_loc4_.helper == null)
                     {
                        Boot.lastError = new Error();
                        throw "Fatal error (2): Polygon is not weakly-simple and clockwise";
                     }
                     param2.add_diagonal(_loc3_,_loc4_.helper);
                     _loc4_.helper = _loc3_;
                  }
                  _loc3_.node = ZPP_Monotone.edges.insert(_loc3_);
                  _loc3_.helper = _loc3_;
                  break;
               case 4:
                  _loc4_ = _loc3_.prev;
                  if(ZPP_Monotone.left_vertex(_loc3_))
                  {
                     if(_loc4_.helper == null)
                     {
                        Boot.lastError = new Error();
                        throw "Fatal error (5): Polygon is not weakly-simple and clockwise";
                     }
                     if(_loc4_.helper.type == 2)
                     {
                        param2.add_diagonal(_loc3_,_loc4_.helper);
                     }
                     ZPP_Monotone.edges.remove_node(_loc4_.node);
                     _loc4_.helper = null;
                     _loc3_.node = ZPP_Monotone.edges.insert(_loc3_);
                     _loc3_.helper = _loc3_;
                  }
                  else
                  {
                     _loc6_ = null;
                     if(!ZPP_Monotone.edges.empty())
                     {
                        _loc22_ = ZPP_Monotone.edges.parent;
                        while(_loc22_.prev != null)
                        {
                           _loc22_ = _loc22_.prev;
                        }
                        while(_loc22_ != null)
                        {
                           _loc23_ = _loc22_.data;
                           if(!ZPP_PartitionVertex.vert_lt(_loc23_,_loc3_))
                           {
                              _loc6_ = _loc23_;
                              break;
                           }
                           if(_loc22_.next != null)
                           {
                              _loc22_ = _loc22_.next;
                              while(_loc22_.prev != null)
                              {
                                 _loc22_ = _loc22_.prev;
                              }
                           }
                           else
                           {
                              while(_loc22_.parent != null && _loc22_ == _loc22_.parent.next)
                              {
                                 _loc22_ = _loc22_.parent;
                              }
                              _loc22_ = _loc22_.parent;
                           }
                        }
                     }
                     _loc5_ = _loc6_;
                     if(_loc5_ == null || _loc5_.helper == null)
                     {
                        Boot.lastError = new Error();
                        throw "Fatal error (6): Polygon is not weakly-simple and clockwise";
                     }
                     if(_loc5_.helper.type == 2)
                     {
                        param2.add_diagonal(_loc3_,_loc5_.helper);
                     }
                     _loc5_.helper = _loc3_;
                  }
                  break;
            }
         }
         return param2;
      }
   }
}
