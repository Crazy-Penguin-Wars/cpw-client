package nape.shape
{
   import flash.Boot;
   import nape.geom.Vec2;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   
   public final class Edge
   {
       
      
      public var zpp_inner:ZPP_Edge;
      
      public function Edge()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(!ZPP_Edge.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate an Edge derp!";
         }
      }
      
      public function toString() : String
      {
         var _loc1_:* = null as ZPP_Polygon;
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZNPNode_ZPP_Edge;
         var _loc8_:* = null as ZPP_Edge;
         if(zpp_inner.polygon == null)
         {
            return "Edge(object-pooled)";
         }
         if(zpp_inner.polygon.body == null)
         {
            zpp_inner.polygon.validate_laxi();
            return "{ localNormal : " + ("{ x: " + zpp_inner.lnormx + " y: " + zpp_inner.lnormy + " }") + " }";
         }
         _loc1_ = zpp_inner.polygon;
         if(_loc1_.zip_gaxi)
         {
            if(_loc1_.body != null)
            {
               _loc1_.zip_gaxi = false;
               _loc1_.validate_laxi();
               _loc2_ = _loc1_.body;
               if(_loc2_.zip_axis)
               {
                  _loc2_.zip_axis = false;
                  _loc2_.axisx = Math.sin(_loc2_.rot);
                  _loc2_.axisy = Math.cos(_loc2_.rot);
               }
               if(_loc1_.zip_gverts)
               {
                  if(_loc1_.body != null)
                  {
                     _loc1_.zip_gverts = false;
                     _loc1_.validate_lverts();
                     _loc2_ = _loc1_.body;
                     if(_loc2_.zip_axis)
                     {
                        _loc2_.zip_axis = false;
                        _loc2_.axisx = Math.sin(_loc2_.rot);
                        _loc2_.axisy = Math.cos(_loc2_.rot);
                     }
                     _loc3_ = _loc1_.lverts.next;
                     _loc4_ = _loc1_.gverts.next;
                     while(_loc4_ != null)
                     {
                        _loc5_ = _loc4_;
                        _loc6_ = _loc3_;
                        _loc3_ = _loc3_.next;
                        _loc5_.x = _loc1_.body.posx + (_loc1_.body.axisy * _loc6_.x - _loc1_.body.axisx * _loc6_.y);
                        _loc5_.y = _loc1_.body.posy + (_loc6_.x * _loc1_.body.axisx + _loc6_.y * _loc1_.body.axisy);
                        _loc4_ = _loc4_.next;
                     }
                  }
               }
               _loc7_ = _loc1_.edges.head;
               _loc3_ = _loc1_.gverts.next;
               _loc4_ = _loc3_;
               _loc3_ = _loc3_.next;
               while(_loc3_ != null)
               {
                  _loc5_ = _loc3_;
                  _loc8_ = _loc7_.elt;
                  _loc7_ = _loc7_.next;
                  _loc8_.gp0 = _loc4_;
                  _loc8_.gp1 = _loc5_;
                  _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
                  _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
                  _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
                  if(_loc8_.wrap_gnorm != null)
                  {
                     _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                     _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
                  }
                  _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
                  _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
                  _loc4_ = _loc5_;
                  _loc3_ = _loc3_.next;
               }
               _loc5_ = _loc1_.gverts.next;
               _loc8_ = _loc7_.elt;
               _loc7_ = _loc7_.next;
               _loc8_.gp0 = _loc4_;
               _loc8_.gp1 = _loc5_;
               _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
               _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
               _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
               if(_loc8_.wrap_gnorm != null)
               {
                  _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                  _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
               }
               _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
               _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
            }
         }
         return "{ localNormal : " + ("{ x: " + zpp_inner.lnormx + " y: " + zpp_inner.lnormy + " }") + " worldNormal : " + ("{ x: " + zpp_inner.gnormx + " y: " + zpp_inner.gnormy + " }") + " }";
      }
      
      public function get worldVertex2() : Vec2
      {
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZNPNode_ZPP_Edge;
         var _loc8_:* = null as ZPP_Edge;
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         var _loc1_:ZPP_Polygon = zpp_inner.polygon;
         if(_loc1_.zip_gaxi)
         {
            if(_loc1_.body != null)
            {
               _loc1_.zip_gaxi = false;
               _loc1_.validate_laxi();
               _loc2_ = _loc1_.body;
               if(_loc2_.zip_axis)
               {
                  _loc2_.zip_axis = false;
                  _loc2_.axisx = Math.sin(_loc2_.rot);
                  _loc2_.axisy = Math.cos(_loc2_.rot);
               }
               if(_loc1_.zip_gverts)
               {
                  if(_loc1_.body != null)
                  {
                     _loc1_.zip_gverts = false;
                     _loc1_.validate_lverts();
                     _loc2_ = _loc1_.body;
                     if(_loc2_.zip_axis)
                     {
                        _loc2_.zip_axis = false;
                        _loc2_.axisx = Math.sin(_loc2_.rot);
                        _loc2_.axisy = Math.cos(_loc2_.rot);
                     }
                     _loc3_ = _loc1_.lverts.next;
                     _loc4_ = _loc1_.gverts.next;
                     while(_loc4_ != null)
                     {
                        _loc5_ = _loc4_;
                        _loc6_ = _loc3_;
                        _loc3_ = _loc3_.next;
                        _loc5_.x = _loc1_.body.posx + (_loc1_.body.axisy * _loc6_.x - _loc1_.body.axisx * _loc6_.y);
                        _loc5_.y = _loc1_.body.posy + (_loc6_.x * _loc1_.body.axisx + _loc6_.y * _loc1_.body.axisy);
                        _loc4_ = _loc4_.next;
                     }
                  }
               }
               _loc7_ = _loc1_.edges.head;
               _loc3_ = _loc1_.gverts.next;
               _loc4_ = _loc3_;
               _loc3_ = _loc3_.next;
               while(_loc3_ != null)
               {
                  _loc5_ = _loc3_;
                  _loc8_ = _loc7_.elt;
                  _loc7_ = _loc7_.next;
                  _loc8_.gp0 = _loc4_;
                  _loc8_.gp1 = _loc5_;
                  _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
                  _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
                  _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
                  if(_loc8_.wrap_gnorm != null)
                  {
                     _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                     _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
                  }
                  _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
                  _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
                  _loc4_ = _loc5_;
                  _loc3_ = _loc3_.next;
               }
               _loc5_ = _loc1_.gverts.next;
               _loc8_ = _loc7_.elt;
               _loc7_ = _loc7_.next;
               _loc8_.gp0 = _loc4_;
               _loc8_.gp1 = _loc5_;
               _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
               _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
               _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
               if(_loc8_.wrap_gnorm != null)
               {
                  _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                  _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
               }
               _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
               _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
            }
         }
         _loc3_ = zpp_inner.gp1;
         if(_loc3_.outer == null)
         {
            _loc3_.outer = new Vec2();
            _loc4_ = _loc3_.outer.zpp_inner;
            if(_loc4_.outer != null)
            {
               _loc4_.outer.zpp_inner = null;
               _loc4_.outer = null;
            }
            _loc4_._isimmutable = null;
            _loc4_._validate = null;
            _loc4_._invalidate = null;
            _loc4_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc4_;
            _loc3_.outer.zpp_inner = _loc3_;
         }
         return _loc3_.outer;
      }
      
      public function get worldVertex1() : Vec2
      {
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZNPNode_ZPP_Edge;
         var _loc8_:* = null as ZPP_Edge;
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         var _loc1_:ZPP_Polygon = zpp_inner.polygon;
         if(_loc1_.zip_gaxi)
         {
            if(_loc1_.body != null)
            {
               _loc1_.zip_gaxi = false;
               _loc1_.validate_laxi();
               _loc2_ = _loc1_.body;
               if(_loc2_.zip_axis)
               {
                  _loc2_.zip_axis = false;
                  _loc2_.axisx = Math.sin(_loc2_.rot);
                  _loc2_.axisy = Math.cos(_loc2_.rot);
               }
               if(_loc1_.zip_gverts)
               {
                  if(_loc1_.body != null)
                  {
                     _loc1_.zip_gverts = false;
                     _loc1_.validate_lverts();
                     _loc2_ = _loc1_.body;
                     if(_loc2_.zip_axis)
                     {
                        _loc2_.zip_axis = false;
                        _loc2_.axisx = Math.sin(_loc2_.rot);
                        _loc2_.axisy = Math.cos(_loc2_.rot);
                     }
                     _loc3_ = _loc1_.lverts.next;
                     _loc4_ = _loc1_.gverts.next;
                     while(_loc4_ != null)
                     {
                        _loc5_ = _loc4_;
                        _loc6_ = _loc3_;
                        _loc3_ = _loc3_.next;
                        _loc5_.x = _loc1_.body.posx + (_loc1_.body.axisy * _loc6_.x - _loc1_.body.axisx * _loc6_.y);
                        _loc5_.y = _loc1_.body.posy + (_loc6_.x * _loc1_.body.axisx + _loc6_.y * _loc1_.body.axisy);
                        _loc4_ = _loc4_.next;
                     }
                  }
               }
               _loc7_ = _loc1_.edges.head;
               _loc3_ = _loc1_.gverts.next;
               _loc4_ = _loc3_;
               _loc3_ = _loc3_.next;
               while(_loc3_ != null)
               {
                  _loc5_ = _loc3_;
                  _loc8_ = _loc7_.elt;
                  _loc7_ = _loc7_.next;
                  _loc8_.gp0 = _loc4_;
                  _loc8_.gp1 = _loc5_;
                  _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
                  _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
                  _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
                  if(_loc8_.wrap_gnorm != null)
                  {
                     _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                     _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
                  }
                  _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
                  _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
                  _loc4_ = _loc5_;
                  _loc3_ = _loc3_.next;
               }
               _loc5_ = _loc1_.gverts.next;
               _loc8_ = _loc7_.elt;
               _loc7_ = _loc7_.next;
               _loc8_.gp0 = _loc4_;
               _loc8_.gp1 = _loc5_;
               _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
               _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
               _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
               if(_loc8_.wrap_gnorm != null)
               {
                  _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                  _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
               }
               _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
               _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
            }
         }
         _loc3_ = zpp_inner.gp0;
         if(_loc3_.outer == null)
         {
            _loc3_.outer = new Vec2();
            _loc4_ = _loc3_.outer.zpp_inner;
            if(_loc4_.outer != null)
            {
               _loc4_.outer.zpp_inner = null;
               _loc4_.outer = null;
            }
            _loc4_._isimmutable = null;
            _loc4_._validate = null;
            _loc4_._invalidate = null;
            _loc4_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc4_;
            _loc3_.outer.zpp_inner = _loc3_;
         }
         return _loc3_.outer;
      }
      
      public function get worldProjection() : Number
      {
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZNPNode_ZPP_Edge;
         var _loc8_:* = null as ZPP_Edge;
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         if(zpp_inner.polygon.body == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge world projection only makes sense for Polygons contained within a rigid body";
         }
         var _loc1_:ZPP_Polygon = zpp_inner.polygon;
         if(_loc1_.zip_gaxi)
         {
            if(_loc1_.body != null)
            {
               _loc1_.zip_gaxi = false;
               _loc1_.validate_laxi();
               _loc2_ = _loc1_.body;
               if(_loc2_.zip_axis)
               {
                  _loc2_.zip_axis = false;
                  _loc2_.axisx = Math.sin(_loc2_.rot);
                  _loc2_.axisy = Math.cos(_loc2_.rot);
               }
               if(_loc1_.zip_gverts)
               {
                  if(_loc1_.body != null)
                  {
                     _loc1_.zip_gverts = false;
                     _loc1_.validate_lverts();
                     _loc2_ = _loc1_.body;
                     if(_loc2_.zip_axis)
                     {
                        _loc2_.zip_axis = false;
                        _loc2_.axisx = Math.sin(_loc2_.rot);
                        _loc2_.axisy = Math.cos(_loc2_.rot);
                     }
                     _loc3_ = _loc1_.lverts.next;
                     _loc4_ = _loc1_.gverts.next;
                     while(_loc4_ != null)
                     {
                        _loc5_ = _loc4_;
                        _loc6_ = _loc3_;
                        _loc3_ = _loc3_.next;
                        _loc5_.x = _loc1_.body.posx + (_loc1_.body.axisy * _loc6_.x - _loc1_.body.axisx * _loc6_.y);
                        _loc5_.y = _loc1_.body.posy + (_loc6_.x * _loc1_.body.axisx + _loc6_.y * _loc1_.body.axisy);
                        _loc4_ = _loc4_.next;
                     }
                  }
               }
               _loc7_ = _loc1_.edges.head;
               _loc3_ = _loc1_.gverts.next;
               _loc4_ = _loc3_;
               _loc3_ = _loc3_.next;
               while(_loc3_ != null)
               {
                  _loc5_ = _loc3_;
                  _loc8_ = _loc7_.elt;
                  _loc7_ = _loc7_.next;
                  _loc8_.gp0 = _loc4_;
                  _loc8_.gp1 = _loc5_;
                  _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
                  _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
                  _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
                  if(_loc8_.wrap_gnorm != null)
                  {
                     _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                     _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
                  }
                  _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
                  _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
                  _loc4_ = _loc5_;
                  _loc3_ = _loc3_.next;
               }
               _loc5_ = _loc1_.gverts.next;
               _loc8_ = _loc7_.elt;
               _loc7_ = _loc7_.next;
               _loc8_.gp0 = _loc4_;
               _loc8_.gp1 = _loc5_;
               _loc8_.gnormx = _loc1_.body.axisy * _loc8_.lnormx - _loc1_.body.axisx * _loc8_.lnormy;
               _loc8_.gnormy = _loc8_.lnormx * _loc1_.body.axisx + _loc8_.lnormy * _loc1_.body.axisy;
               _loc8_.gprojection = _loc1_.body.posx * _loc8_.gnormx + _loc1_.body.posy * _loc8_.gnormy + _loc8_.lprojection;
               if(_loc8_.wrap_gnorm != null)
               {
                  _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                  _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
               }
               _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
               _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
            }
         }
         return zpp_inner.gprojection;
      }
      
      public function get worldNormal() : Vec2
      {
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         if(zpp_inner.wrap_gnorm == null)
         {
            zpp_inner.getgnorm();
         }
         return zpp_inner.wrap_gnorm;
      }
      
      public function get polygon() : Polygon
      {
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         return zpp_inner.polygon.outer_zn;
      }
      
      public function get localVertex2() : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         zpp_inner.polygon.validate_laxi();
         var _loc1_:ZPP_Vec2 = zpp_inner.lp1;
         if(_loc1_.outer == null)
         {
            _loc1_.outer = new Vec2();
            _loc2_ = _loc1_.outer.zpp_inner;
            if(_loc2_.outer != null)
            {
               _loc2_.outer.zpp_inner = null;
               _loc2_.outer = null;
            }
            _loc2_._isimmutable = null;
            _loc2_._validate = null;
            _loc2_._invalidate = null;
            _loc2_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc2_;
            _loc1_.outer.zpp_inner = _loc1_;
         }
         return _loc1_.outer;
      }
      
      public function get localVertex1() : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         zpp_inner.polygon.validate_laxi();
         var _loc1_:ZPP_Vec2 = zpp_inner.lp0;
         if(_loc1_.outer == null)
         {
            _loc1_.outer = new Vec2();
            _loc2_ = _loc1_.outer.zpp_inner;
            if(_loc2_.outer != null)
            {
               _loc2_.outer.zpp_inner = null;
               _loc2_.outer = null;
            }
            _loc2_._isimmutable = null;
            _loc2_._validate = null;
            _loc2_._invalidate = null;
            _loc2_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc2_;
            _loc1_.outer.zpp_inner = _loc1_;
         }
         return _loc1_.outer;
      }
      
      public function get localProjection() : Number
      {
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         zpp_inner.polygon.validate_laxi();
         return zpp_inner.lprojection;
      }
      
      public function get localNormal() : Vec2
      {
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         if(zpp_inner.wrap_lnorm == null)
         {
            zpp_inner.getlnorm();
         }
         return zpp_inner.wrap_lnorm;
      }
      
      public function get length() : Number
      {
         if(zpp_inner.polygon == null)
         {
            Boot.lastError = new Error();
            throw "Error: Edge not current in use";
         }
         zpp_inner.polygon.validate_laxi();
         return zpp_inner.length;
      }
   }
}
