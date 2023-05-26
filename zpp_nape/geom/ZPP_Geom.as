package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_Geom
   {
       
      
      public function ZPP_Geom()
      {
      }
      
      public static function validateShape(param1:ZPP_Shape) : void
      {
         var _loc2_:* = null as ZPP_Polygon;
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZNPNode_ZPP_Edge;
         var _loc9_:* = null as ZPP_Edge;
         var _loc10_:* = null as ZPP_Circle;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as ZPP_Vec2;
         if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
         {
            _loc2_ = param1.polygon;
            if(_loc2_.zip_gaxi)
            {
               if(_loc2_.body != null)
               {
                  _loc2_.zip_gaxi = false;
                  _loc2_.validate_laxi();
                  _loc3_ = _loc2_.body;
                  if(_loc3_.zip_axis)
                  {
                     _loc3_.zip_axis = false;
                     _loc3_.axisx = Math.sin(_loc3_.rot);
                     _loc3_.axisy = Math.cos(_loc3_.rot);
                  }
                  if(_loc2_.zip_gverts)
                  {
                     if(_loc2_.body != null)
                     {
                        _loc2_.zip_gverts = false;
                        _loc2_.validate_lverts();
                        _loc3_ = _loc2_.body;
                        if(_loc3_.zip_axis)
                        {
                           _loc3_.zip_axis = false;
                           _loc3_.axisx = Math.sin(_loc3_.rot);
                           _loc3_.axisy = Math.cos(_loc3_.rot);
                        }
                        _loc4_ = _loc2_.lverts.next;
                        _loc5_ = _loc2_.gverts.next;
                        while(_loc5_ != null)
                        {
                           _loc6_ = _loc5_;
                           _loc7_ = _loc4_;
                           _loc4_ = _loc4_.next;
                           _loc6_.x = _loc2_.body.posx + (_loc2_.body.axisy * _loc7_.x - _loc2_.body.axisx * _loc7_.y);
                           _loc6_.y = _loc2_.body.posy + (_loc7_.x * _loc2_.body.axisx + _loc7_.y * _loc2_.body.axisy);
                           _loc5_ = _loc5_.next;
                        }
                     }
                  }
                  _loc8_ = _loc2_.edges.head;
                  _loc4_ = _loc2_.gverts.next;
                  _loc5_ = _loc4_;
                  _loc4_ = _loc4_.next;
                  while(_loc4_ != null)
                  {
                     _loc6_ = _loc4_;
                     _loc9_ = _loc8_.elt;
                     _loc8_ = _loc8_.next;
                     _loc9_.gp0 = _loc5_;
                     _loc9_.gp1 = _loc6_;
                     _loc9_.gnormx = _loc2_.body.axisy * _loc9_.lnormx - _loc2_.body.axisx * _loc9_.lnormy;
                     _loc9_.gnormy = _loc9_.lnormx * _loc2_.body.axisx + _loc9_.lnormy * _loc2_.body.axisy;
                     _loc9_.gprojection = _loc2_.body.posx * _loc9_.gnormx + _loc2_.body.posy * _loc9_.gnormy + _loc9_.lprojection;
                     if(_loc9_.wrap_gnorm != null)
                     {
                        _loc9_.wrap_gnorm.zpp_inner.x = _loc9_.gnormx;
                        _loc9_.wrap_gnorm.zpp_inner.y = _loc9_.gnormy;
                     }
                     _loc9_.tp0 = _loc9_.gp0.y * _loc9_.gnormx - _loc9_.gp0.x * _loc9_.gnormy;
                     _loc9_.tp1 = _loc9_.gp1.y * _loc9_.gnormx - _loc9_.gp1.x * _loc9_.gnormy;
                     _loc5_ = _loc6_;
                     _loc4_ = _loc4_.next;
                  }
                  _loc6_ = _loc2_.gverts.next;
                  _loc9_ = _loc8_.elt;
                  _loc8_ = _loc8_.next;
                  _loc9_.gp0 = _loc5_;
                  _loc9_.gp1 = _loc6_;
                  _loc9_.gnormx = _loc2_.body.axisy * _loc9_.lnormx - _loc2_.body.axisx * _loc9_.lnormy;
                  _loc9_.gnormy = _loc9_.lnormx * _loc2_.body.axisx + _loc9_.lnormy * _loc2_.body.axisy;
                  _loc9_.gprojection = _loc2_.body.posx * _loc9_.gnormx + _loc2_.body.posy * _loc9_.gnormy + _loc9_.lprojection;
                  if(_loc9_.wrap_gnorm != null)
                  {
                     _loc9_.wrap_gnorm.zpp_inner.x = _loc9_.gnormx;
                     _loc9_.wrap_gnorm.zpp_inner.y = _loc9_.gnormy;
                  }
                  _loc9_.tp0 = _loc9_.gp0.y * _loc9_.gnormx - _loc9_.gp0.x * _loc9_.gnormy;
                  _loc9_.tp1 = _loc9_.gp1.y * _loc9_.gnormx - _loc9_.gp1.x * _loc9_.gnormy;
               }
            }
         }
         if(param1.zip_aabb)
         {
            if(param1.body != null)
            {
               param1.zip_aabb = false;
               if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc10_ = param1.circle;
                  if(_loc10_.zip_worldCOM)
                  {
                     if(_loc10_.body != null)
                     {
                        _loc10_.zip_worldCOM = false;
                        if(_loc10_.zip_localCOM)
                        {
                           _loc10_.zip_localCOM = false;
                           if(_loc10_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc2_ = _loc10_.polygon;
                              if(_loc2_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful localCOM";
                              }
                              if(_loc2_.lverts.next.next == null)
                              {
                                 _loc2_.localCOMx = _loc2_.lverts.next.x;
                                 _loc2_.localCOMy = _loc2_.lverts.next.y;
                              }
                              else if(_loc2_.lverts.next.next.next == null)
                              {
                                 _loc2_.localCOMx = _loc2_.lverts.next.x;
                                 _loc2_.localCOMy = _loc2_.lverts.next.y;
                                 _loc11_ = 1;
                                 _loc2_.localCOMx += _loc2_.lverts.next.next.x * _loc11_;
                                 _loc2_.localCOMy += _loc2_.lverts.next.next.y * _loc11_;
                                 _loc11_ = 0.5;
                                 _loc2_.localCOMx *= _loc11_;
                                 _loc2_.localCOMy *= _loc11_;
                              }
                              else
                              {
                                 _loc2_.localCOMx = 0;
                                 _loc2_.localCOMy = 0;
                                 _loc11_ = 0;
                                 _loc4_ = _loc2_.lverts.next;
                                 _loc5_ = _loc4_;
                                 _loc4_ = _loc4_.next;
                                 _loc6_ = _loc4_;
                                 _loc4_ = _loc4_.next;
                                 while(_loc4_ != null)
                                 {
                                    _loc7_ = _loc4_;
                                    _loc11_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                                    _loc12_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                                    _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc12_;
                                    _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc12_;
                                    _loc5_ = _loc6_;
                                    _loc6_ = _loc7_;
                                    _loc4_ = _loc4_.next;
                                 }
                                 _loc4_ = _loc2_.lverts.next;
                                 _loc7_ = _loc4_;
                                 _loc11_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                                 _loc12_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                                 _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc12_;
                                 _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc12_;
                                 _loc5_ = _loc6_;
                                 _loc6_ = _loc7_;
                                 _loc4_ = _loc4_.next;
                                 _loc13_ = _loc4_;
                                 _loc11_ += _loc6_.x * (_loc13_.y - _loc5_.y);
                                 _loc12_ = _loc13_.y * _loc6_.x - _loc13_.x * _loc6_.y;
                                 _loc2_.localCOMx += (_loc6_.x + _loc13_.x) * _loc12_;
                                 _loc2_.localCOMy += (_loc6_.y + _loc13_.y) * _loc12_;
                                 _loc11_ = 1 / (3 * _loc11_);
                                 _loc12_ = _loc11_;
                                 _loc2_.localCOMx *= _loc12_;
                                 _loc2_.localCOMy *= _loc12_;
                              }
                           }
                        }
                        _loc3_ = _loc10_.body;
                        if(_loc3_.zip_axis)
                        {
                           _loc3_.zip_axis = false;
                           _loc3_.axisx = Math.sin(_loc3_.rot);
                           _loc3_.axisy = Math.cos(_loc3_.rot);
                        }
                        _loc10_.worldCOMx = _loc10_.body.posx + (_loc10_.body.axisy * _loc10_.localCOMx - _loc10_.body.axisx * _loc10_.localCOMy);
                        _loc10_.worldCOMy = _loc10_.body.posy + (_loc10_.localCOMx * _loc10_.body.axisx + _loc10_.localCOMy * _loc10_.body.axisy);
                     }
                  }
                  _loc11_ = _loc10_.radius;
                  _loc12_ = _loc10_.radius;
                  _loc10_.aabb.minx = _loc10_.worldCOMx - _loc11_;
                  _loc10_.aabb.miny = _loc10_.worldCOMy - _loc12_;
                  _loc10_.aabb.maxx = _loc10_.worldCOMx + _loc11_;
                  _loc10_.aabb.maxy = _loc10_.worldCOMy + _loc12_;
               }
               else
               {
                  _loc2_ = param1.polygon;
                  if(_loc2_.zip_gverts)
                  {
                     if(_loc2_.body != null)
                     {
                        _loc2_.zip_gverts = false;
                        _loc2_.validate_lverts();
                        _loc3_ = _loc2_.body;
                        if(_loc3_.zip_axis)
                        {
                           _loc3_.zip_axis = false;
                           _loc3_.axisx = Math.sin(_loc3_.rot);
                           _loc3_.axisy = Math.cos(_loc3_.rot);
                        }
                        _loc4_ = _loc2_.lverts.next;
                        _loc5_ = _loc2_.gverts.next;
                        while(_loc5_ != null)
                        {
                           _loc6_ = _loc5_;
                           _loc7_ = _loc4_;
                           _loc4_ = _loc4_.next;
                           _loc6_.x = _loc2_.body.posx + (_loc2_.body.axisy * _loc7_.x - _loc2_.body.axisx * _loc7_.y);
                           _loc6_.y = _loc2_.body.posy + (_loc7_.x * _loc2_.body.axisx + _loc7_.y * _loc2_.body.axisy);
                           _loc5_ = _loc5_.next;
                        }
                     }
                  }
                  if(_loc2_.lverts.next == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: An empty polygon has no meaningful bounds";
                  }
                  _loc4_ = _loc2_.gverts.next;
                  _loc2_.aabb.minx = _loc4_.x;
                  _loc2_.aabb.miny = _loc4_.y;
                  _loc2_.aabb.maxx = _loc4_.x;
                  _loc2_.aabb.maxy = _loc4_.y;
                  _loc5_ = _loc2_.gverts.next.next;
                  while(_loc5_ != null)
                  {
                     _loc6_ = _loc5_;
                     if(_loc6_.x < _loc2_.aabb.minx)
                     {
                        _loc2_.aabb.minx = _loc6_.x;
                     }
                     if(_loc6_.x > _loc2_.aabb.maxx)
                     {
                        _loc2_.aabb.maxx = _loc6_.x;
                     }
                     if(_loc6_.y < _loc2_.aabb.miny)
                     {
                        _loc2_.aabb.miny = _loc6_.y;
                     }
                     if(_loc6_.y > _loc2_.aabb.maxy)
                     {
                        _loc2_.aabb.maxy = _loc6_.y;
                     }
                     _loc5_ = _loc5_.next;
                  }
               }
            }
         }
         if(param1.zip_worldCOM)
         {
            if(param1.body != null)
            {
               param1.zip_worldCOM = false;
               if(param1.zip_localCOM)
               {
                  param1.zip_localCOM = false;
                  if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc2_ = param1.polygon;
                     if(_loc2_.lverts.next == null)
                     {
                        Boot.lastError = new Error();
                        throw "Error: An empty polygon has no meaningful localCOM";
                     }
                     if(_loc2_.lverts.next.next == null)
                     {
                        _loc2_.localCOMx = _loc2_.lverts.next.x;
                        _loc2_.localCOMy = _loc2_.lverts.next.y;
                     }
                     else if(_loc2_.lverts.next.next.next == null)
                     {
                        _loc2_.localCOMx = _loc2_.lverts.next.x;
                        _loc2_.localCOMy = _loc2_.lverts.next.y;
                        _loc11_ = 1;
                        _loc2_.localCOMx += _loc2_.lverts.next.next.x * _loc11_;
                        _loc2_.localCOMy += _loc2_.lverts.next.next.y * _loc11_;
                        _loc11_ = 0.5;
                        _loc2_.localCOMx *= _loc11_;
                        _loc2_.localCOMy *= _loc11_;
                     }
                     else
                     {
                        _loc2_.localCOMx = 0;
                        _loc2_.localCOMy = 0;
                        _loc11_ = 0;
                        _loc4_ = _loc2_.lverts.next;
                        _loc5_ = _loc4_;
                        _loc4_ = _loc4_.next;
                        _loc6_ = _loc4_;
                        _loc4_ = _loc4_.next;
                        while(_loc4_ != null)
                        {
                           _loc7_ = _loc4_;
                           _loc11_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                           _loc12_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                           _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc12_;
                           _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc12_;
                           _loc5_ = _loc6_;
                           _loc6_ = _loc7_;
                           _loc4_ = _loc4_.next;
                        }
                        _loc4_ = _loc2_.lverts.next;
                        _loc7_ = _loc4_;
                        _loc11_ += _loc6_.x * (_loc7_.y - _loc5_.y);
                        _loc12_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                        _loc2_.localCOMx += (_loc6_.x + _loc7_.x) * _loc12_;
                        _loc2_.localCOMy += (_loc6_.y + _loc7_.y) * _loc12_;
                        _loc5_ = _loc6_;
                        _loc6_ = _loc7_;
                        _loc4_ = _loc4_.next;
                        _loc13_ = _loc4_;
                        _loc11_ += _loc6_.x * (_loc13_.y - _loc5_.y);
                        _loc12_ = _loc13_.y * _loc6_.x - _loc13_.x * _loc6_.y;
                        _loc2_.localCOMx += (_loc6_.x + _loc13_.x) * _loc12_;
                        _loc2_.localCOMy += (_loc6_.y + _loc13_.y) * _loc12_;
                        _loc11_ = 1 / (3 * _loc11_);
                        _loc12_ = _loc11_;
                        _loc2_.localCOMx *= _loc12_;
                        _loc2_.localCOMy *= _loc12_;
                     }
                  }
               }
               _loc3_ = param1.body;
               if(_loc3_.zip_axis)
               {
                  _loc3_.zip_axis = false;
                  _loc3_.axisx = Math.sin(_loc3_.rot);
                  _loc3_.axisy = Math.cos(_loc3_.rot);
               }
               param1.worldCOMx = param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy);
               param1.worldCOMy = param1.body.posy + (param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy);
            }
         }
      }
   }
}
