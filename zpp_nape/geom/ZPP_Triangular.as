package zpp_nape.geom
{
   import zpp_nape.util.ZNPList_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPNode_ZPP_PartitionVertex;
   import zpp_nape.util.ZPP_Set_ZPP_PartitionPair;
   
   public class ZPP_Triangular
   {
      
      public static var queue:ZNPList_ZPP_PartitionVertex = null;
      
      public static var stack:ZNPList_ZPP_PartitionVertex = null;
      
      public static var edgeSet:ZPP_Set_ZPP_PartitionPair = null;
       
      
      public function ZPP_Triangular()
      {
      }
      
      public static function lt(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         return param1.y < param2.y || param1.y == param2.y && param1.x < param2.x;
      }
      
      public static function right_turn(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex, param3:ZPP_PartitionVertex) : Number
      {
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         _loc4_ = param3.x - param2.x;
         _loc5_ = param3.y - param2.y;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         _loc6_ = param2.x - param1.x;
         _loc7_ = param2.y - param1.y;
         return _loc7_ * _loc4_ - _loc6_ * _loc5_;
      }
      
      public static function delaunay(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex, param3:ZPP_PartitionVertex, param4:ZPP_PartitionVertex) : Boolean
      {
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         _loc5_ = param3.x - param2.x;
         _loc6_ = param3.y - param2.y;
         _loc7_ = param2.x - param1.x;
         _loc8_ = param2.y - param1.y;
         if(_loc8_ * _loc5_ - _loc7_ * _loc6_ >= 0 || _loc8_ * _loc5_ - _loc7_ * _loc6_ >= 0 || _loc8_ * _loc5_ - _loc7_ * _loc6_ >= 0 || _loc8_ * _loc5_ - _loc7_ * _loc6_ >= 0)
         {
            return true;
         }
         return param2.x * (param3.y * param4.mag - param3.mag * param4.y) - param3.x * (param2.y * param4.mag - param2.mag * param4.y) + param4.x * (param2.y * param3.mag - param2.mag * param3.y) - (param1.x * (param3.y * param4.mag - param3.mag * param4.y) - param3.x * (param1.y * param4.mag - param1.mag * param4.y) + param4.x * (param1.y * param3.mag - param1.mag * param3.y)) + (param1.x * (param2.y * param4.mag - param2.mag * param4.y) - param2.x * (param1.y * param4.mag - param1.mag * param4.y) + param4.x * (param1.y * param2.mag - param1.mag * param2.y)) - (param1.x * (param2.y * param3.mag - param2.mag * param3.y) - param2.x * (param1.y * param3.mag - param1.mag * param3.y) + param3.x * (param1.y * param2.mag - param1.mag * param2.y)) > 0;
      }
      
      public static function optimise(param1:ZPP_PartitionedPoly) : void
      {
         var _loc2_:* = null as ZPP_PartitionVertex;
         var _loc3_:* = null as ZPP_PartitionVertex;
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:* = null as ZPP_PartitionVertex;
         var _loc6_:* = null as ZPP_PartitionPair;
         var _loc7_:* = null as ZPP_PartitionVertex;
         var _loc8_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc9_:* = null as ZPP_PartitionVertex;
         var _loc10_:* = null as ZPP_PartitionVertex;
         var _loc11_:* = null as ZPP_PartitionPair;
         var _loc12_:* = null as ZPP_PartitionPair;
         _loc2_ = param1.vertices;
         _loc3_ = param1.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc5_.sort();
               _loc5_.mag = _loc5_.x * _loc5_.x + _loc5_.y * _loc5_.y;
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         if(ZPP_Triangular.edgeSet == null)
         {
            if(ZPP_Set_ZPP_PartitionPair.zpp_pool == null)
            {
               ZPP_Triangular.edgeSet = new ZPP_Set_ZPP_PartitionPair();
            }
            else
            {
               ZPP_Triangular.edgeSet = ZPP_Set_ZPP_PartitionPair.zpp_pool;
               ZPP_Set_ZPP_PartitionPair.zpp_pool = ZPP_Triangular.edgeSet.next;
               ZPP_Triangular.edgeSet.next = null;
            }
            ZPP_Triangular.edgeSet.lt = ZPP_PartitionPair.edge_lt;
            ZPP_Triangular.edgeSet.swapped = ZPP_PartitionPair.edge_swap;
         }
         if(ZPP_PartitionPair.zpp_pool == null)
         {
            _loc6_ = new ZPP_PartitionPair();
         }
         else
         {
            _loc6_ = ZPP_PartitionPair.zpp_pool;
            ZPP_PartitionPair.zpp_pool = _loc6_.next;
            _loc6_.next = null;
         }
         _loc2_ = param1.vertices;
         _loc3_ = param1.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc7_ = _loc5_.next;
               _loc5_.diagonals.reverse();
               _loc8_ = _loc5_.diagonals.head;
               while(_loc8_ != null)
               {
                  _loc9_ = _loc8_.elt;
                  if(_loc9_.id < _loc5_.id)
                  {
                     _loc7_ = _loc9_;
                     _loc8_ = _loc8_.next;
                  }
                  else
                  {
                     _loc10_ = _loc8_.next == null ? _loc5_.prev : _loc8_.next.elt;
                     if(!ZPP_Triangular.delaunay(_loc5_,_loc7_,_loc9_,_loc10_))
                     {
                        if(ZPP_PartitionPair.zpp_pool == null)
                        {
                           _loc12_ = new ZPP_PartitionPair();
                        }
                        else
                        {
                           _loc12_ = ZPP_PartitionPair.zpp_pool;
                           ZPP_PartitionPair.zpp_pool = _loc12_.next;
                           _loc12_.next = null;
                        }
                        _loc12_.a = _loc5_;
                        _loc12_.b = _loc9_;
                        if(_loc5_.id < _loc9_.id)
                        {
                           _loc12_.id = _loc5_.id;
                           _loc12_.di = _loc9_.id;
                        }
                        else
                        {
                           _loc12_.id = _loc9_.id;
                           _loc12_.di = _loc5_.id;
                        }
                        _loc11_ = _loc12_;
                        _loc6_.add(_loc11_);
                        _loc11_.node = ZPP_Triangular.edgeSet.insert(_loc11_);
                     }
                     _loc7_ = _loc9_;
                     _loc8_ = _loc8_.next;
                  }
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         while(_loc6_.next != null)
         {
            _loc11_ = _loc6_.pop_unsafe();
            _loc2_ = _loc11_.a;
            _loc3_ = _loc11_.b;
            _loc4_ = _loc2_.next;
            _loc5_ = null;
            _loc8_ = _loc2_.diagonals.head;
            while(_loc8_ != null)
            {
               _loc7_ = _loc8_.elt;
               if(_loc7_ == _loc3_)
               {
                  _loc8_ = _loc8_.next;
                  _loc5_ = _loc8_ == null ? _loc2_.prev : _loc8_.elt;
                  break;
               }
               _loc4_ = _loc7_;
               _loc8_ = _loc8_.next;
            }
            _loc2_.diagonals.remove(_loc3_);
            _loc3_.diagonals.remove(_loc2_);
            if(_loc3_ == _loc4_.next)
            {
               _loc4_.diagonals.add(_loc5_);
            }
            else
            {
               _loc8_ = _loc4_.diagonals.head;
               while(_loc8_ != null)
               {
                  _loc7_ = _loc8_.elt;
                  if(_loc7_ == _loc3_)
                  {
                     _loc4_.diagonals.insert(_loc8_,_loc5_);
                     break;
                  }
                  _loc8_ = _loc8_.next;
               }
            }
            if(_loc2_ == _loc5_.next)
            {
               _loc5_.diagonals.add(_loc4_);
            }
            else
            {
               _loc8_ = _loc5_.diagonals.head;
               while(_loc8_ != null)
               {
                  _loc7_ = _loc8_.elt;
                  if(_loc7_ == _loc2_)
                  {
                     _loc5_.diagonals.insert(_loc8_,_loc4_);
                     break;
                  }
                  _loc8_ = _loc8_.next;
               }
            }
            ZPP_Triangular.edgeSet.remove_node(_loc11_.node);
            _loc12_ = _loc11_;
            _loc12_.a = _loc12_.b = null;
            _loc12_.node = null;
            _loc12_.next = ZPP_PartitionPair.zpp_pool;
            ZPP_PartitionPair.zpp_pool = _loc12_;
         }
         _loc11_ = _loc6_;
         _loc11_.a = _loc11_.b = null;
         _loc11_.node = null;
         _loc11_.next = ZPP_PartitionPair.zpp_pool;
         ZPP_PartitionPair.zpp_pool = _loc11_;
      }
      
      public static function triangulate(param1:ZPP_PartitionedPoly) : ZPP_PartitionedPoly
      {
         var _loc6_:* = null as ZPP_PartitionVertex;
         var _loc7_:* = null as ZPP_PartitionVertex;
         var _loc8_:* = null as ZPP_PartitionVertex;
         var _loc9_:* = null as ZPP_PartitionVertex;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc2_:ZPP_PartitionVertex = param1.vertices;
         var _loc3_:ZPP_PartitionVertex = param1.vertices;
         var _loc4_:ZPP_PartitionVertex = param1.vertices.next;
         var _loc5_:ZPP_PartitionVertex = param1.vertices;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_;
            do
            {
               _loc7_ = _loc6_;
               if(_loc7_.y < _loc2_.y || _loc7_.y == _loc2_.y && _loc7_.x < _loc2_.x)
               {
                  _loc2_ = _loc7_;
               }
               if(_loc3_.y < _loc7_.y || _loc3_.y == _loc7_.y && _loc3_.x < _loc7_.x)
               {
                  _loc3_ = _loc7_;
               }
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != _loc5_);
            
         }
         if(ZPP_Triangular.queue == null)
         {
            ZPP_Triangular.queue = new ZNPList_ZPP_PartitionVertex();
         }
         _loc4_ = _loc3_.prev;
         _loc5_ = _loc3_.next;
         ZPP_Triangular.queue.add(_loc3_);
         while(_loc4_ != _loc2_ || _loc5_ != _loc2_)
         {
            if(_loc4_ == _loc2_ || _loc5_ != _loc2_ && (_loc4_.y < _loc5_.y || _loc4_.y == _loc5_.y && _loc4_.x < _loc5_.x))
            {
               ZPP_Triangular.queue.add(_loc5_);
               _loc5_.rightchain = false;
               _loc5_ = _loc5_.next;
            }
            else
            {
               ZPP_Triangular.queue.add(_loc4_);
               _loc4_.rightchain = true;
               _loc4_ = _loc4_.prev;
            }
         }
         ZPP_Triangular.queue.add(_loc2_);
         if(ZPP_Triangular.stack == null)
         {
            ZPP_Triangular.stack = new ZNPList_ZPP_PartitionVertex();
         }
         ZPP_Triangular.stack.add(ZPP_Triangular.queue.pop_unsafe());
         _loc6_ = ZPP_Triangular.queue.pop_unsafe();
         ZPP_Triangular.stack.add(_loc6_);
         while(true)
         {
            _loc7_ = ZPP_Triangular.queue.pop_unsafe();
            if(ZPP_Triangular.queue.head == null)
            {
               break;
            }
            if(_loc7_.rightchain != ZPP_Triangular.stack.head.elt.rightchain)
            {
               while(true)
               {
                  _loc8_ = ZPP_Triangular.stack.pop_unsafe();
                  if(ZPP_Triangular.stack.head == null)
                  {
                     break;
                  }
                  param1.add_diagonal(_loc8_,_loc7_);
               }
               ZPP_Triangular.stack.add(_loc6_);
            }
            else
            {
               _loc8_ = ZPP_Triangular.stack.pop_unsafe();
               while(ZPP_Triangular.stack.head != null)
               {
                  _loc9_ = ZPP_Triangular.stack.head.elt;
                  _loc11_ = 0;
                  _loc12_ = 0;
                  _loc11_ = _loc7_.x - _loc8_.x;
                  _loc12_ = _loc7_.y - _loc8_.y;
                  _loc13_ = 0;
                  _loc14_ = 0;
                  _loc13_ = _loc8_.x - _loc9_.x;
                  _loc14_ = _loc8_.y - _loc9_.y;
                  _loc10_ = _loc14_ * _loc11_ - _loc13_ * _loc12_;
                  if(_loc7_.rightchain && _loc10_ >= 0 || !_loc7_.rightchain && _loc10_ <= 0)
                  {
                     break;
                  }
                  param1.add_diagonal(_loc9_,_loc7_);
                  _loc8_ = _loc9_;
                  ZPP_Triangular.stack.pop();
               }
               ZPP_Triangular.stack.add(_loc8_);
            }
            ZPP_Triangular.stack.add(_loc7_);
            _loc6_ = _loc7_;
         }
         if(ZPP_Triangular.stack.head != null)
         {
            ZPP_Triangular.stack.pop();
            while(ZPP_Triangular.stack.head != null)
            {
               _loc7_ = ZPP_Triangular.stack.pop_unsafe();
               if(ZPP_Triangular.stack.head == null)
               {
                  break;
               }
               param1.add_diagonal(_loc3_,_loc7_);
            }
         }
         return param1;
      }
   }
}
