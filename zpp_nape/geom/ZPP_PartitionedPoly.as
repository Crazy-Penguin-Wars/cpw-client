package zpp_nape.geom
{
   import flash.Boot;
   import nape.Config;
   import zpp_nape.util.ZNPList_ZPP_GeomVert;
   import zpp_nape.util.ZNPList_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPList_ZPP_PartitionedPoly;
   import zpp_nape.util.ZNPNode_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPNode_ZPP_PartitionedPoly;
   
   public class ZPP_PartitionedPoly
   {
      
      public static var zpp_pool:ZPP_PartitionedPoly = null;
      
      public static var sharedPPList:ZNPList_ZPP_PartitionedPoly;
      
      public static var sharedGVList:ZNPList_ZPP_GeomVert;
       
      
      public var vertices:ZPP_PartitionVertex;
      
      public var next:ZPP_PartitionedPoly;
      
      public function ZPP_PartitionedPoly(param1:ZPP_GeomVert = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         next = null;
         vertices = null;
         init(param1);
      }
      
      public static function getSharedPP() : ZNPList_ZPP_PartitionedPoly
      {
         if(ZPP_PartitionedPoly.sharedPPList == null)
         {
            ZPP_PartitionedPoly.sharedPPList = new ZNPList_ZPP_PartitionedPoly();
         }
         return ZPP_PartitionedPoly.sharedPPList;
      }
      
      public static function getShared() : ZNPList_ZPP_GeomVert
      {
         if(ZPP_PartitionedPoly.sharedGVList == null)
         {
            ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
         }
         return ZPP_PartitionedPoly.sharedGVList;
      }
      
      public function remove_collinear_vertices() : Boolean
      {
         var _loc3_:* = null as ZPP_PartitionVertex;
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_PartitionVertex;
         var _loc1_:ZPP_PartitionVertex = vertices;
         var _loc2_:Boolean = true;
         while(_loc2_ || _loc1_ != vertices)
         {
            _loc2_ = false;
            if(eq(_loc1_,_loc1_.next))
            {
               if(_loc1_ == vertices)
               {
                  vertices = _loc1_.next;
                  _loc2_ = true;
               }
               if(_loc1_.forced)
               {
                  _loc1_.next.forced = true;
               }
               _loc1_ = _loc1_ != null && _loc1_.prev == _loc1_ ? (_loc1_.next = _loc1_.prev = null, _loc3_ = _loc1_, _loc3_.helper = null, _loc3_.next = ZPP_PartitionVertex.zpp_pool, ZPP_PartitionVertex.zpp_pool = _loc3_, _loc1_ = null) : (_loc3_ = _loc1_.next, _loc1_.prev.next = _loc1_.next, _loc1_.next.prev = _loc1_.prev, _loc1_.next = _loc1_.prev = null, _loc4_ = _loc1_, _loc4_.helper = null, _loc4_.next = ZPP_PartitionVertex.zpp_pool, ZPP_PartitionVertex.zpp_pool = _loc4_, _loc1_ = null, _loc3_);
               if(_loc1_ == null)
               {
                  vertices = null;
                  break;
               }
            }
            else
            {
               _loc1_ = _loc1_.next;
            }
         }
         if(vertices == null)
         {
            return true;
         }
         do
         {
            _loc5_ = false;
            _loc1_ = vertices;
            _loc2_ = true;
            while(_loc2_ || _loc1_ != vertices)
            {
               _loc2_ = false;
               _loc3_ = _loc1_.prev;
               _loc6_ = 0;
               _loc7_ = 0;
               _loc6_ = _loc1_.x - _loc3_.x;
               _loc7_ = _loc1_.y - _loc3_.y;
               _loc8_ = 0;
               _loc9_ = 0;
               _loc8_ = _loc1_.next.x - _loc1_.x;
               _loc9_ = _loc1_.next.y - _loc1_.y;
               _loc10_ = _loc9_ * _loc6_ - _loc8_ * _loc7_;
               if(_loc10_ * _loc10_ >= Config.epsilon * Config.epsilon)
               {
                  _loc1_ = _loc1_.next;
               }
               else
               {
                  if(_loc1_ == vertices)
                  {
                     vertices = _loc1_.next;
                     _loc2_ = true;
                  }
                  _loc1_ = _loc1_ != null && _loc1_.prev == _loc1_ ? (_loc1_.next = _loc1_.prev = null, _loc4_ = _loc1_, _loc4_.helper = null, _loc4_.next = ZPP_PartitionVertex.zpp_pool, ZPP_PartitionVertex.zpp_pool = _loc4_, _loc1_ = null) : (_loc4_ = _loc1_.next, _loc1_.prev.next = _loc1_.next, _loc1_.next.prev = _loc1_.prev, _loc1_.next = _loc1_.prev = null, _loc11_ = _loc1_, _loc11_.helper = null, _loc11_.next = ZPP_PartitionVertex.zpp_pool, ZPP_PartitionVertex.zpp_pool = _loc11_, _loc1_ = null, _loc4_);
                  _loc5_ = true;
                  if(_loc1_ == null)
                  {
                     _loc5_ = false;
                     vertices = null;
                     break;
                  }
               }
            }
         }
         while(_loc5_);
         
         return vertices == null;
      }
      
      public function pull_partitions(param1:ZPP_PartitionVertex, param2:ZNPList_ZPP_PartitionedPoly) : ZPP_PartitionVertex
      {
         var _loc3_:* = null as ZPP_PartitionedPoly;
         var _loc5_:* = null as ZPP_PartitionVertex;
         var _loc6_:* = null as ZPP_PartitionVertex;
         var _loc7_:* = null as ZNPList_ZPP_PartitionVertex;
         var _loc9_:* = null as ZPP_PartitionVertex;
         var _loc10_:* = null as ZPP_PartitionVertex;
         if(ZPP_PartitionedPoly.zpp_pool == null)
         {
            _loc3_ = new ZPP_PartitionedPoly();
         }
         else
         {
            _loc3_ = ZPP_PartitionedPoly.zpp_pool;
            ZPP_PartitionedPoly.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         var _loc4_:ZPP_PartitionVertex = param1;
         do
         {
            §§push(_loc3_);
            if(ZPP_PartitionVertex.zpp_pool == null)
            {
               _loc6_ = new ZPP_PartitionVertex();
            }
            else
            {
               _loc6_ = ZPP_PartitionVertex.zpp_pool;
               ZPP_PartitionVertex.zpp_pool = _loc6_.next;
               _loc6_.next = null;
            }
            _loc6_.x = _loc4_.x;
            _loc6_.y = _loc4_.y;
            _loc6_.forced = _loc4_.forced;
            _loc5_ = _loc6_;
            if(_loc3_.vertices == null)
            {
               _loc3_.vertices = _loc5_.prev = _loc5_.next = _loc5_;
            }
            else
            {
               _loc5_.prev = _loc3_.vertices;
               _loc5_.next = _loc3_.vertices.next;
               _loc3_.vertices.next.prev = _loc5_;
               _loc3_.vertices.next = _loc5_;
            }
            §§pop().vertices = _loc5_;
            _loc3_.vertices.forced = _loc4_.forced;
            if(_loc4_.diagonals.head != null)
            {
               _loc7_ = _loc4_.diagonals;
               _loc6_ = _loc7_.head.elt;
               _loc7_.pop();
               _loc5_ = _loc6_;
               if(_loc5_ == param1)
               {
                  break;
               }
               _loc4_ = pull_partitions(_loc4_,param2);
            }
            else
            {
               _loc4_ = _loc4_.next;
            }
         }
         while(_loc4_ != param1);
         
         var _loc8_:Number = 0;
         _loc5_ = _loc3_.vertices;
         _loc6_ = _loc3_.vertices;
         if(_loc5_ != null)
         {
            _loc9_ = _loc5_;
            do
            {
               _loc10_ = _loc9_;
               _loc8_ += _loc10_.x * (_loc10_.next.y - _loc10_.prev.y);
               _loc9_ = _loc9_.next;
            }
            while(_loc9_ != _loc6_);
            
         }
         if(_loc8_ * 0.5 != 0)
         {
            param2.add(_loc3_);
         }
         return _loc4_;
      }
      
      public function pull(param1:ZPP_PartitionVertex, param2:ZNPList_ZPP_GeomVert) : ZPP_PartitionVertex
      {
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_PartitionVertex;
         var _loc8_:* = null as ZNPList_ZPP_PartitionVertex;
         var _loc9_:* = null as ZPP_PartitionVertex;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as ZPP_GeomVert;
         var _loc13_:* = null as ZPP_GeomVert;
         var _loc14_:Boolean = false;
         var _loc15_:Number = NaN;
         var _loc16_:Boolean = false;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc3_:ZPP_GeomVert = null;
         var _loc4_:ZPP_PartitionVertex = param1;
         do
         {
            if(ZPP_GeomVert.zpp_pool == null)
            {
               _loc6_ = new ZPP_GeomVert();
            }
            else
            {
               _loc6_ = ZPP_GeomVert.zpp_pool;
               ZPP_GeomVert.zpp_pool = _loc6_.next;
               _loc6_.next = null;
            }
            _loc6_.forced = false;
            _loc6_.x = _loc4_.x;
            _loc6_.y = _loc4_.y;
            _loc5_ = _loc6_;
            if(_loc3_ == null)
            {
               _loc3_ = _loc5_.prev = _loc5_.next = _loc5_;
            }
            else
            {
               _loc5_.prev = _loc3_;
               _loc5_.next = _loc3_.next;
               _loc3_.next.prev = _loc5_;
               _loc3_.next = _loc5_;
            }
            _loc3_ = _loc5_;
            _loc3_.forced = _loc4_.forced;
            if(_loc4_.diagonals.head != null)
            {
               _loc8_ = _loc4_.diagonals;
               _loc9_ = _loc8_.head.elt;
               _loc8_.pop();
               _loc7_ = _loc9_;
               if(_loc7_ == param1)
               {
                  break;
               }
               _loc4_ = pull(_loc4_,param2);
            }
            else
            {
               _loc4_ = _loc4_.next;
            }
         }
         while(_loc4_ != param1);
         
         _loc11_ = 0;
         _loc5_ = _loc3_;
         _loc6_ = _loc3_;
         if(_loc5_ != null)
         {
            _loc12_ = _loc5_;
            do
            {
               _loc13_ = _loc12_;
               _loc11_ += _loc13_.x * (_loc13_.next.y - _loc13_.prev.y);
               _loc12_ = _loc12_.next;
            }
            while(_loc12_ != _loc6_);
            
         }
         var _loc10_:Number = _loc11_ * 0.5;
         if(_loc10_ * _loc10_ >= Config.epsilon * Config.epsilon)
         {
            _loc5_ = _loc3_;
            _loc14_ = true;
            while(_loc14_ || _loc5_ != _loc3_)
            {
               _loc14_ = false;
               _loc11_ = 0;
               _loc15_ = 0;
               _loc11_ = _loc5_.x - _loc5_.next.x;
               _loc15_ = _loc5_.y - _loc5_.next.y;
               if(_loc11_ * _loc11_ + _loc15_ * _loc15_ < Config.epsilon * Config.epsilon)
               {
                  if(_loc5_ == _loc3_)
                  {
                     _loc3_ = _loc5_.next;
                     _loc14_ = true;
                  }
                  if(_loc5_.forced)
                  {
                     _loc5_.next.forced = true;
                  }
                  _loc5_ = _loc5_ != null && _loc5_.prev == _loc5_ ? (_loc5_.next = _loc5_.prev = null, _loc5_ = null) : (_loc6_ = _loc5_.next, _loc5_.prev.next = _loc5_.next, _loc5_.next.prev = _loc5_.prev, _loc5_.next = _loc5_.prev = null, _loc5_ = null, _loc6_);
                  if(_loc5_ == null)
                  {
                     _loc3_ = null;
                     break;
                  }
               }
               else
               {
                  _loc5_ = _loc5_.next;
               }
            }
            if(_loc3_ != null)
            {
               do
               {
                  _loc16_ = false;
                  _loc5_ = _loc3_;
                  _loc14_ = true;
                  while(_loc14_ || _loc5_ != _loc3_)
                  {
                     _loc14_ = false;
                     _loc6_ = _loc5_.prev;
                     _loc11_ = 0;
                     _loc15_ = 0;
                     _loc11_ = _loc5_.x - _loc6_.x;
                     _loc15_ = _loc5_.y - _loc6_.y;
                     _loc17_ = 0;
                     _loc18_ = 0;
                     _loc17_ = _loc5_.next.x - _loc5_.x;
                     _loc18_ = _loc5_.next.y - _loc5_.y;
                     _loc19_ = _loc18_ * _loc11_ - _loc17_ * _loc15_;
                     if(_loc19_ * _loc19_ >= Config.epsilon * Config.epsilon)
                     {
                        _loc5_ = _loc5_.next;
                     }
                     else
                     {
                        if(_loc5_ == _loc3_)
                        {
                           _loc3_ = _loc5_.next;
                           _loc14_ = true;
                        }
                        _loc5_ = _loc5_ != null && _loc5_.prev == _loc5_ ? (_loc5_.next = _loc5_.prev = null, _loc5_ = null) : (_loc12_ = _loc5_.next, _loc5_.prev.next = _loc5_.next, _loc5_.next.prev = _loc5_.prev, _loc5_.next = _loc5_.prev = null, _loc5_ = null, _loc12_);
                        _loc16_ = true;
                        if(_loc5_ == null)
                        {
                           _loc16_ = false;
                           _loc3_ = null;
                           break;
                        }
                     }
                  }
               }
               while(_loc16_);
               
            }
            if(_loc3_ != null)
            {
               param2.add(_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function init(param1:ZPP_GeomVert = undefined) : void
      {
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_PartitionVertex;
         var _loc9_:* = null as ZPP_PartitionVertex;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Number = 0;
         var _loc4_:ZPP_GeomVert = param1;
         var _loc5_:ZPP_GeomVert = param1;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_;
            do
            {
               _loc7_ = _loc6_;
               _loc3_ += _loc7_.x * (_loc7_.next.y - _loc7_.prev.y);
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != _loc5_);
            
         }
         var _loc2_:Boolean = _loc3_ * 0.5 > 0;
         _loc4_ = param1;
         do
         {
            §§push(§§findproperty(vertices));
            if(_loc2_)
            {
               if(ZPP_PartitionVertex.zpp_pool == null)
               {
                  _loc9_ = new ZPP_PartitionVertex();
               }
               else
               {
                  _loc9_ = ZPP_PartitionVertex.zpp_pool;
                  ZPP_PartitionVertex.zpp_pool = _loc9_.next;
                  _loc9_.next = null;
               }
               _loc9_.x = _loc4_.x;
               _loc9_.y = _loc4_.y;
               _loc8_ = _loc9_;
               if(vertices == null)
               {
                  vertices = _loc8_.prev = _loc8_.next = _loc8_;
               }
               else
               {
                  _loc8_.prev = vertices;
                  _loc8_.next = vertices.next;
                  vertices.next.prev = _loc8_;
                  vertices.next = _loc8_;
               }
               §§push(_loc8_);
            }
            else
            {
               if(ZPP_PartitionVertex.zpp_pool == null)
               {
                  _loc9_ = new ZPP_PartitionVertex();
               }
               else
               {
                  _loc9_ = ZPP_PartitionVertex.zpp_pool;
                  ZPP_PartitionVertex.zpp_pool = _loc9_.next;
                  _loc9_.next = null;
               }
               _loc9_.x = _loc4_.x;
               _loc9_.y = _loc4_.y;
               _loc8_ = _loc9_;
               if(vertices == null)
               {
                  vertices = _loc8_.prev = _loc8_.next = _loc8_;
               }
               else
               {
                  _loc8_.next = vertices;
                  _loc8_.prev = vertices.prev;
                  vertices.prev.next = _loc8_;
                  vertices.prev = _loc8_;
               }
               §§push(_loc8_);
            }
            §§pop().vertices = §§pop();
            vertices.forced = _loc4_.forced;
            _loc4_ = _loc4_.next;
         }
         while(_loc4_ != param1);
         
         remove_collinear_vertices();
      }
      
      public function free() : void
      {
      }
      
      public function extract_partitions(param1:ZNPList_ZPP_PartitionedPoly = undefined) : ZNPList_ZPP_PartitionedPoly
      {
         var _loc2_:* = null as ZPP_PartitionVertex;
         var _loc3_:* = null as ZPP_PartitionVertex;
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:* = null as ZPP_PartitionVertex;
         var _loc6_:* = null as ZNPNode_ZPP_PartitionedPoly;
         var _loc7_:* = null as ZNPNode_ZPP_PartitionedPoly;
         var _loc8_:* = null as ZPP_PartitionedPoly;
         if(param1 == null)
         {
            param1 = new ZNPList_ZPP_PartitionedPoly();
         }
         if(vertices != null)
         {
            _loc2_ = vertices;
            _loc3_ = vertices;
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_;
               do
               {
                  _loc5_ = _loc4_;
                  _loc5_.sort();
                  _loc4_ = _loc4_.next;
               }
               while(_loc4_ != _loc3_);
               
            }
            pull_partitions(vertices,param1);
            while(vertices != null)
            {
               vertices = vertices != null && vertices.prev == vertices ? (vertices.next = vertices.prev = null, _loc2_ = vertices, _loc2_.helper = null, _loc2_.next = ZPP_PartitionVertex.zpp_pool, ZPP_PartitionVertex.zpp_pool = _loc2_, vertices = null) : (_loc2_ = vertices.next, vertices.prev.next = vertices.next, vertices.next.prev = vertices.prev, vertices.next = vertices.prev = null, _loc3_ = vertices, _loc3_.helper = null, _loc3_.next = ZPP_PartitionVertex.zpp_pool, ZPP_PartitionVertex.zpp_pool = _loc3_, vertices = null, _loc2_);
            }
            _loc6_ = null;
            _loc7_ = param1.head;
            while(_loc7_ != null)
            {
               _loc8_ = _loc7_.elt;
               if(_loc8_.remove_collinear_vertices())
               {
                  param1.erase(_loc6_);
               }
               else
               {
                  _loc6_ = _loc7_;
                  _loc7_ = _loc7_.next;
               }
            }
         }
         return param1;
      }
      
      public function extract(param1:ZNPList_ZPP_GeomVert = undefined) : ZNPList_ZPP_GeomVert
      {
         var _loc2_:* = null as ZPP_PartitionVertex;
         var _loc3_:* = null as ZPP_PartitionVertex;
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:* = null as ZPP_PartitionVertex;
         if(param1 == null)
         {
            param1 = new ZNPList_ZPP_GeomVert();
         }
         if(vertices != null)
         {
            _loc2_ = vertices;
            _loc3_ = vertices;
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_;
               do
               {
                  _loc5_ = _loc4_;
                  _loc5_.sort();
                  _loc4_ = _loc4_.next;
               }
               while(_loc4_ != _loc3_);
               
            }
            pull(vertices,param1);
            while(vertices != null)
            {
               vertices = vertices != null && vertices.prev == vertices ? (vertices.next = vertices.prev = null, _loc2_ = vertices, _loc2_.helper = null, _loc2_.next = ZPP_PartitionVertex.zpp_pool, ZPP_PartitionVertex.zpp_pool = _loc2_, vertices = null) : (_loc2_ = vertices.next, vertices.prev.next = vertices.next, vertices.next.prev = vertices.prev, vertices.next = vertices.prev = null, _loc3_ = vertices, _loc3_.helper = null, _loc3_.next = ZPP_PartitionVertex.zpp_pool, ZPP_PartitionVertex.zpp_pool = _loc3_, vertices = null, _loc2_);
            }
         }
         return param1;
      }
      
      public function eq(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         _loc3_ = param1.x - param2.x;
         _loc4_ = param1.y - param2.y;
         return _loc3_ * _loc3_ + _loc4_ * _loc4_ < Config.epsilon * Config.epsilon;
      }
      
      public function alloc() : void
      {
      }
      
      public function add_diagonal(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : void
      {
         param1.diagonals.add(param2);
         param2.diagonals.add(param1);
         param2.forced = true;
         param1.forced = true;
      }
   }
}
