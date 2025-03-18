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
      public static var flowpoly:ZNPList_ZPP_Vec2;
      
      public static var flowsegs:ZNPList_ZPP_Vec2;
      
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
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:* = null as ZPP_Edge;
         var _loc10_:* = null as ZPP_Edge;
         var _loc11_:* = null as ZNPNode_ZPP_Edge;
         var _loc12_:* = null as ZPP_Edge;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as ZPP_Vec2;
         var _loc15_:* = null as ZPP_Vec2;
         var _loc16_:Number = NaN;
         var _loc17_:* = null as ZPP_Polygon;
         var _loc18_:* = null as ZPP_Polygon;
         var _loc19_:* = null as ZPP_Edge;
         var _loc20_:* = null as ZPP_Edge;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:* = null as ZPP_Contact;
         var _loc37_:int = 0;
         var _loc38_:* = null as ZPP_Contact;
         var _loc39_:* = null as ZPP_Contact;
         var _loc40_:* = null as ZPP_Contact;
         var _loc41_:* = null as ZPP_IContact;
         var _loc42_:Number = NaN;
         var _loc43_:* = null as ZPP_Vec2;
         var _loc44_:* = null as ZPP_Vec2;
         var _loc45_:Boolean = false;
         if(param2.type == ZPP_Flags.id_ShapeType_POLYGON)
         {
            if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc5_ = true;
               _loc6_ = -1e+100;
               _loc7_ = -1e+100;
               _loc8_ = -1;
               _loc9_ = null;
               _loc10_ = null;
               _loc11_ = param1.polygon.edges.head;
               while(_loc11_ != null)
               {
                  _loc12_ = _loc11_.elt;
                  _loc13_ = 1e+100;
                  _loc14_ = param2.polygon.gverts.next;
                  while(_loc14_ != null)
                  {
                     _loc15_ = _loc14_;
                     _loc16_ = _loc12_.gnormx * _loc15_.x + _loc12_.gnormy * _loc15_.y;
                     if(_loc16_ < _loc13_)
                     {
                        _loc13_ = _loc16_;
                     }
                     if(_loc13_ - _loc12_.gprojection <= _loc6_)
                     {
                        break;
                     }
                     _loc14_ = _loc14_.next;
                  }
                  _loc13_ -= _loc12_.gprojection;
                  if(_loc13_ >= 0)
                  {
                     _loc5_ = false;
                     break;
                  }
                  if(_loc13_ > _loc6_)
                  {
                     _loc6_ = _loc13_;
                     _loc9_ = _loc12_;
                     _loc8_ = 1;
                  }
                  _loc11_ = _loc11_.next;
               }
               if(_loc5_)
               {
                  _loc11_ = param2.polygon.edges.head;
                  while(_loc11_ != null)
                  {
                     _loc12_ = _loc11_.elt;
                     _loc13_ = 1e+100;
                     _loc14_ = param1.polygon.gverts.next;
                     while(_loc14_ != null)
                     {
                        _loc15_ = _loc14_;
                        _loc16_ = _loc12_.gnormx * _loc15_.x + _loc12_.gnormy * _loc15_.y;
                        if(_loc16_ < _loc13_)
                        {
                           _loc13_ = _loc16_;
                        }
                        if(_loc13_ - _loc12_.gprojection <= _loc6_)
                        {
                           break;
                        }
                        _loc14_ = _loc14_.next;
                     }
                     _loc13_ -= _loc12_.gprojection;
                     if(_loc13_ >= 0)
                     {
                        _loc5_ = false;
                        break;
                     }
                     if(_loc13_ > _loc6_)
                     {
                        _loc6_ = _loc13_;
                        _loc10_ = _loc12_;
                        _loc8_ = 2;
                     }
                     _loc11_ = _loc11_.next;
                  }
                  if(!_loc5_)
                  {
                     return false;
                  }
                  if(_loc8_ == 1)
                  {
                     _loc17_ = param1.polygon;
                     _loc18_ = param2.polygon;
                     _loc12_ = _loc9_;
                     _loc13_ = 1;
                  }
                  else
                  {
                     _loc17_ = param2.polygon;
                     _loc18_ = param1.polygon;
                     _loc12_ = _loc10_;
                     _loc13_ = -1;
                  }
                  _loc19_ = null;
                  _loc16_ = 1e+100;
                  _loc11_ = _loc18_.edges.head;
                  while(_loc11_ != null)
                  {
                     _loc20_ = _loc11_.elt;
                     _loc21_ = _loc12_.gnormx * _loc20_.gnormx + _loc12_.gnormy * _loc20_.gnormy;
                     if(_loc21_ < _loc16_)
                     {
                        _loc16_ = _loc21_;
                        _loc19_ = _loc20_;
                     }
                     _loc11_ = _loc11_.next;
                  }
                  _loc21_ = 0;
                  _loc22_ = 0;
                  _loc21_ = _loc19_.gp0.x;
                  _loc22_ = _loc19_.gp0.y;
                  _loc23_ = 0;
                  _loc24_ = 0;
                  _loc23_ = _loc19_.gp1.x;
                  _loc24_ = _loc19_.gp1.y;
                  _loc25_ = 0;
                  _loc26_ = 0;
                  _loc25_ = _loc23_ - _loc21_;
                  _loc26_ = _loc24_ - _loc22_;
                  _loc27_ = _loc12_.gnormy * _loc21_ - _loc12_.gnormx * _loc22_;
                  _loc28_ = _loc12_.gnormy * _loc23_ - _loc12_.gnormx * _loc24_;
                  _loc29_ = 1 / (_loc28_ - _loc27_);
                  _loc30_ = (-_loc12_.tp1 - _loc27_) * _loc29_;
                  if(_loc30_ > Config.epsilon)
                  {
                     _loc31_ = _loc30_;
                     _loc21_ += _loc25_ * _loc31_;
                     _loc22_ += _loc26_ * _loc31_;
                  }
                  _loc31_ = (-_loc12_.tp0 - _loc28_) * _loc29_;
                  if(_loc31_ < -Config.epsilon)
                  {
                     _loc32_ = _loc31_;
                     _loc23_ += _loc25_ * _loc32_;
                     _loc24_ += _loc26_ * _loc32_;
                  }
                  _loc32_ = 0;
                  _loc33_ = 0;
                  _loc34_ = _loc13_;
                  _loc32_ = _loc12_.gnormx * _loc34_;
                  _loc33_ = _loc12_.gnormy * _loc34_;
                  param3.lnormx = _loc12_.lnormx;
                  param3.lnormy = _loc12_.lnormy;
                  param3.lproj = _loc12_.lprojection;
                  param3.radius = 0;
                  param3.rev = param4 != (_loc13_ == -1);
                  param3.ptype = param3.rev ? 1 : 0;
                  _loc34_ = _loc21_ * _loc12_.gnormx + _loc22_ * _loc12_.gnormy - _loc12_.gprojection;
                  _loc35_ = _loc23_ * _loc12_.gnormx + _loc24_ * _loc12_.gnormy - _loc12_.gprojection;
                  if(_loc34_ > 0 && _loc35_ > 0)
                  {
                     return false;
                  }
                  if(param4)
                  {
                     _loc32_ = -_loc32_;
                     _loc33_ = -_loc33_;
                  }
                  _loc37_ = param3.rev ? 1 : 0;
                  _loc38_ = null;
                  _loc39_ = param3.contacts.next;
                  while(_loc39_ != null)
                  {
                     _loc40_ = _loc39_;
                     if(_loc37_ == _loc40_.hash)
                     {
                        _loc38_ = _loc40_;
                        break;
                     }
                     _loc39_ = _loc39_.next;
                  }
                  if(_loc38_ == null)
                  {
                     if(ZPP_Contact.zpp_pool == null)
                     {
                        _loc38_ = new ZPP_Contact();
                     }
                     else
                     {
                        _loc38_ = ZPP_Contact.zpp_pool;
                        ZPP_Contact.zpp_pool = _loc38_.next;
                        _loc38_.next = null;
                     }
                     null;
                     _loc41_ = _loc38_.inner;
                     _loc41_.jnAcc = _loc41_.jtAcc = 0;
                     _loc38_.hash = _loc37_;
                     _loc38_.fresh = true;
                     _loc38_.arbiter = param3;
                     param3.jrAcc = 0;
                     _loc39_ = param3.contacts;
                     _loc38_._inuse = true;
                     _loc40_ = _loc38_;
                     _loc40_.next = _loc39_.next;
                     _loc39_.next = _loc40_;
                     _loc39_.modified = true;
                     ++_loc39_.length;
                     _loc38_;
                     param3.innards.add(_loc41_);
                  }
                  else
                  {
                     _loc38_.fresh = false;
                  }
                  _loc38_.px = _loc21_ - _loc12_.gnormx * _loc34_ * 0.5;
                  _loc38_.py = _loc22_ - _loc12_.gnormy * _loc34_ * 0.5;
                  param3.nx = _loc32_;
                  param3.ny = _loc33_;
                  _loc38_.dist = _loc34_;
                  _loc38_.stamp = param3.stamp;
                  _loc38_.posOnly = _loc34_ > 0;
                  _loc36_ = _loc38_;
                  _loc42_ = 1;
                  _loc21_ -= _loc18_.body.posx * _loc42_;
                  _loc22_ -= _loc18_.body.posy * _loc42_;
                  _loc36_.inner.lr1x = _loc21_ * _loc18_.body.axisy + _loc22_ * _loc18_.body.axisx;
                  _loc36_.inner.lr1y = _loc22_ * _loc18_.body.axisy - _loc21_ * _loc18_.body.axisx;
                  _loc37_ = param3.rev ? 0 : 1;
                  _loc38_ = null;
                  _loc39_ = param3.contacts.next;
                  while(_loc39_ != null)
                  {
                     _loc40_ = _loc39_;
                     if(_loc37_ == _loc40_.hash)
                     {
                        _loc38_ = _loc40_;
                        break;
                     }
                     _loc39_ = _loc39_.next;
                  }
                  if(_loc38_ == null)
                  {
                     if(ZPP_Contact.zpp_pool == null)
                     {
                        _loc38_ = new ZPP_Contact();
                     }
                     else
                     {
                        _loc38_ = ZPP_Contact.zpp_pool;
                        ZPP_Contact.zpp_pool = _loc38_.next;
                        _loc38_.next = null;
                     }
                     null;
                     _loc41_ = _loc38_.inner;
                     _loc41_.jnAcc = _loc41_.jtAcc = 0;
                     _loc38_.hash = _loc37_;
                     _loc38_.fresh = true;
                     _loc38_.arbiter = param3;
                     param3.jrAcc = 0;
                     _loc39_ = param3.contacts;
                     _loc38_._inuse = true;
                     _loc40_ = _loc38_;
                     _loc40_.next = _loc39_.next;
                     _loc39_.next = _loc40_;
                     _loc39_.modified = true;
                     ++_loc39_.length;
                     _loc38_;
                     param3.innards.add(_loc41_);
                  }
                  else
                  {
                     _loc38_.fresh = false;
                  }
                  _loc38_.px = _loc23_ - _loc12_.gnormx * _loc35_ * 0.5;
                  _loc38_.py = _loc24_ - _loc12_.gnormy * _loc35_ * 0.5;
                  param3.nx = _loc32_;
                  param3.ny = _loc33_;
                  _loc38_.dist = _loc35_;
                  _loc38_.stamp = param3.stamp;
                  _loc38_.posOnly = _loc35_ > 0;
                  _loc36_ = _loc38_;
                  _loc42_ = 1;
                  _loc23_ -= _loc18_.body.posx * _loc42_;
                  _loc24_ -= _loc18_.body.posy * _loc42_;
                  _loc36_.inner.lr1x = _loc23_ * _loc18_.body.axisy + _loc24_ * _loc18_.body.axisx;
                  _loc36_.inner.lr1y = _loc24_ * _loc18_.body.axisy - _loc23_ * _loc18_.body.axisx;
                  if(_loc8_ == 1)
                  {
                     param3.__ref_edge1 = _loc12_;
                     param3.__ref_edge2 = _loc19_;
                  }
                  else
                  {
                     param3.__ref_edge2 = _loc12_;
                     param3.__ref_edge1 = _loc19_;
                  }
                  return true;
               }
               return false;
            }
            _loc6_ = -1e+100;
            _loc7_ = -1e+100;
            _loc5_ = true;
            _loc9_ = null;
            _loc14_ = null;
            _loc15_ = param2.polygon.gverts.next;
            _loc11_ = param2.polygon.edges.head;
            while(_loc11_ != null)
            {
               _loc10_ = _loc11_.elt;
               _loc13_ = _loc10_.gnormx * param1.circle.worldCOMx + _loc10_.gnormy * param1.circle.worldCOMy - _loc10_.gprojection - param1.circle.radius;
               if(_loc13_ > 0)
               {
                  _loc5_ = false;
                  break;
               }
               if(_loc13_ > _loc6_)
               {
                  _loc6_ = _loc13_;
                  _loc9_ = _loc10_;
                  _loc14_ = _loc15_;
               }
               _loc15_ = _loc15_.next;
               _loc11_ = _loc11_.next;
            }
            if(_loc5_)
            {
               _loc43_ = _loc14_;
               _loc44_ = _loc14_.next == null ? param2.polygon.gverts.next : _loc14_.next;
               _loc13_ = param1.circle.worldCOMy * _loc9_.gnormx - param1.circle.worldCOMx * _loc9_.gnormy;
               if(_loc13_ <= _loc43_.y * _loc9_.gnormx - _loc43_.x * _loc9_.gnormy)
               {
                  _loc16_ = param1.circle.radius;
                  _loc21_ = 0;
                  _loc22_ = 0;
                  _loc21_ = _loc43_.x - param1.circle.worldCOMx;
                  _loc22_ = _loc43_.y - param1.circle.worldCOMy;
                  _loc23_ = _loc21_ * _loc21_ + _loc22_ * _loc22_;
                  if(_loc23_ > _loc16_ * _loc16_)
                  {
                     §§push(null);
                  }
                  else if(_loc23_ < Config.epsilon * Config.epsilon)
                  {
                     _loc45_ = false;
                     _loc38_ = null;
                     _loc39_ = param3.contacts.next;
                     while(_loc39_ != null)
                     {
                        _loc40_ = _loc39_;
                        if(0 == _loc40_.hash)
                        {
                           _loc38_ = _loc40_;
                           break;
                        }
                        _loc39_ = _loc39_.next;
                     }
                     if(_loc38_ == null)
                     {
                        if(ZPP_Contact.zpp_pool == null)
                        {
                           _loc38_ = new ZPP_Contact();
                        }
                        else
                        {
                           _loc38_ = ZPP_Contact.zpp_pool;
                           ZPP_Contact.zpp_pool = _loc38_.next;
                           _loc38_.next = null;
                        }
                        null;
                        _loc41_ = _loc38_.inner;
                        _loc41_.jnAcc = _loc41_.jtAcc = 0;
                        _loc38_.hash = 0;
                        _loc38_.fresh = true;
                        _loc38_.arbiter = param3;
                        param3.jrAcc = 0;
                        _loc39_ = param3.contacts;
                        _loc38_._inuse = true;
                        _loc40_ = _loc38_;
                        _loc40_.next = _loc39_.next;
                        _loc39_.next = _loc40_;
                        _loc39_.modified = true;
                        ++_loc39_.length;
                        _loc38_;
                        param3.innards.add(_loc41_);
                     }
                     else
                     {
                        _loc38_.fresh = false;
                     }
                     _loc38_.px = param1.circle.worldCOMx;
                     _loc38_.py = param1.circle.worldCOMy;
                     param3.nx = 1;
                     param3.ny = 0;
                     _loc38_.dist = -_loc16_;
                     _loc38_.stamp = param3.stamp;
                     _loc38_.posOnly = _loc45_;
                     §§push(_loc38_);
                  }
                  else
                  {
                     sf32(_loc23_,0);
                     si32(1597463007 - (li32(0) >> 1),0);
                     _loc25_ = lf32(0);
                     _loc24_ = _loc25_ * (1.5 - 0.5 * _loc23_ * _loc25_ * _loc25_);
                     _loc25_ = _loc24_ < Config.epsilon ? 1e+100 : 1 / _loc24_;
                     _loc26_ = 0.5 + (param1.circle.radius - 0.5 * _loc16_) * _loc24_;
                     if(param4)
                     {
                        _loc45_ = false;
                        _loc38_ = null;
                        _loc39_ = param3.contacts.next;
                        while(_loc39_ != null)
                        {
                           _loc40_ = _loc39_;
                           if(0 == _loc40_.hash)
                           {
                              _loc38_ = _loc40_;
                              break;
                           }
                           _loc39_ = _loc39_.next;
                        }
                        if(_loc38_ == null)
                        {
                           if(ZPP_Contact.zpp_pool == null)
                           {
                              _loc38_ = new ZPP_Contact();
                           }
                           else
                           {
                              _loc38_ = ZPP_Contact.zpp_pool;
                              ZPP_Contact.zpp_pool = _loc38_.next;
                              _loc38_.next = null;
                           }
                           null;
                           _loc41_ = _loc38_.inner;
                           _loc41_.jnAcc = _loc41_.jtAcc = 0;
                           _loc38_.hash = 0;
                           _loc38_.fresh = true;
                           _loc38_.arbiter = param3;
                           param3.jrAcc = 0;
                           _loc39_ = param3.contacts;
                           _loc38_._inuse = true;
                           _loc40_ = _loc38_;
                           _loc40_.next = _loc39_.next;
                           _loc39_.next = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc38_;
                           param3.innards.add(_loc41_);
                        }
                        else
                        {
                           _loc38_.fresh = false;
                        }
                        _loc38_.px = param1.circle.worldCOMx + _loc21_ * _loc26_;
                        _loc38_.py = param1.circle.worldCOMy + _loc22_ * _loc26_;
                        param3.nx = -_loc21_ * _loc24_;
                        param3.ny = -_loc22_ * _loc24_;
                        _loc38_.dist = _loc25_ - _loc16_;
                        _loc38_.stamp = param3.stamp;
                        _loc38_.posOnly = _loc45_;
                        §§push(_loc38_);
                     }
                     else
                     {
                        _loc45_ = false;
                        _loc38_ = null;
                        _loc39_ = param3.contacts.next;
                        while(_loc39_ != null)
                        {
                           _loc40_ = _loc39_;
                           if(0 == _loc40_.hash)
                           {
                              _loc38_ = _loc40_;
                              break;
                           }
                           _loc39_ = _loc39_.next;
                        }
                        if(_loc38_ == null)
                        {
                           if(ZPP_Contact.zpp_pool == null)
                           {
                              _loc38_ = new ZPP_Contact();
                           }
                           else
                           {
                              _loc38_ = ZPP_Contact.zpp_pool;
                              ZPP_Contact.zpp_pool = _loc38_.next;
                              _loc38_.next = null;
                           }
                           null;
                           _loc41_ = _loc38_.inner;
                           _loc41_.jnAcc = _loc41_.jtAcc = 0;
                           _loc38_.hash = 0;
                           _loc38_.fresh = true;
                           _loc38_.arbiter = param3;
                           param3.jrAcc = 0;
                           _loc39_ = param3.contacts;
                           _loc38_._inuse = true;
                           _loc40_ = _loc38_;
                           _loc40_.next = _loc39_.next;
                           _loc39_.next = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc38_;
                           param3.innards.add(_loc41_);
                        }
                        else
                        {
                           _loc38_.fresh = false;
                        }
                        _loc38_.px = param1.circle.worldCOMx + _loc21_ * _loc26_;
                        _loc38_.py = param1.circle.worldCOMy + _loc22_ * _loc26_;
                        param3.nx = _loc21_ * _loc24_;
                        param3.ny = _loc22_ * _loc24_;
                        _loc38_.dist = _loc25_ - _loc16_;
                        _loc38_.stamp = param3.stamp;
                        _loc38_.posOnly = _loc45_;
                        §§push(_loc38_);
                     }
                  }
                  _loc36_ = §§pop();
                  if(_loc36_ != null)
                  {
                     _loc41_ = _loc36_.inner;
                     param3.ptype = 2;
                     _loc16_ = 0;
                     _loc21_ = 0;
                     _loc16_ = _loc43_.x - param2.polygon.body.posx;
                     _loc21_ = _loc43_.y - param2.polygon.body.posy;
                     param3.__ref_edge1 = _loc9_;
                     param3.__ref_vertex = -1;
                     if(param4)
                     {
                        _loc41_.lr1x = _loc16_ * param2.polygon.body.axisy + _loc21_ * param2.polygon.body.axisx;
                        _loc41_.lr1y = _loc21_ * param2.polygon.body.axisy - _loc16_ * param2.polygon.body.axisx;
                        _loc41_.lr2x = param1.circle.localCOMx;
                        _loc41_.lr2y = param1.circle.localCOMy;
                     }
                     else
                     {
                        _loc41_.lr2x = _loc16_ * param2.polygon.body.axisy + _loc21_ * param2.polygon.body.axisx;
                        _loc41_.lr2y = _loc21_ * param2.polygon.body.axisy - _loc16_ * param2.polygon.body.axisx;
                        _loc41_.lr1x = param1.circle.localCOMx;
                        _loc41_.lr1y = param1.circle.localCOMy;
                     }
                     param3.radius = param1.circle.radius;
                  }
                  return _loc36_ != null;
               }
               if(_loc13_ >= _loc44_.y * _loc9_.gnormx - _loc44_.x * _loc9_.gnormy)
               {
                  _loc16_ = param1.circle.radius;
                  _loc21_ = 0;
                  _loc22_ = 0;
                  _loc21_ = _loc44_.x - param1.circle.worldCOMx;
                  _loc22_ = _loc44_.y - param1.circle.worldCOMy;
                  _loc23_ = _loc21_ * _loc21_ + _loc22_ * _loc22_;
                  if(_loc23_ > _loc16_ * _loc16_)
                  {
                     §§push(null);
                  }
                  else if(_loc23_ < Config.epsilon * Config.epsilon)
                  {
                     _loc45_ = false;
                     _loc38_ = null;
                     _loc39_ = param3.contacts.next;
                     while(_loc39_ != null)
                     {
                        _loc40_ = _loc39_;
                        if(0 == _loc40_.hash)
                        {
                           _loc38_ = _loc40_;
                           break;
                        }
                        _loc39_ = _loc39_.next;
                     }
                     if(_loc38_ == null)
                     {
                        if(ZPP_Contact.zpp_pool == null)
                        {
                           _loc38_ = new ZPP_Contact();
                        }
                        else
                        {
                           _loc38_ = ZPP_Contact.zpp_pool;
                           ZPP_Contact.zpp_pool = _loc38_.next;
                           _loc38_.next = null;
                        }
                        null;
                        _loc41_ = _loc38_.inner;
                        _loc41_.jnAcc = _loc41_.jtAcc = 0;
                        _loc38_.hash = 0;
                        _loc38_.fresh = true;
                        _loc38_.arbiter = param3;
                        param3.jrAcc = 0;
                        _loc39_ = param3.contacts;
                        _loc38_._inuse = true;
                        _loc40_ = _loc38_;
                        _loc40_.next = _loc39_.next;
                        _loc39_.next = _loc40_;
                        _loc39_.modified = true;
                        ++_loc39_.length;
                        _loc38_;
                        param3.innards.add(_loc41_);
                     }
                     else
                     {
                        _loc38_.fresh = false;
                     }
                     _loc38_.px = param1.circle.worldCOMx;
                     _loc38_.py = param1.circle.worldCOMy;
                     param3.nx = 1;
                     param3.ny = 0;
                     _loc38_.dist = -_loc16_;
                     _loc38_.stamp = param3.stamp;
                     _loc38_.posOnly = _loc45_;
                     §§push(_loc38_);
                  }
                  else
                  {
                     sf32(_loc23_,0);
                     si32(1597463007 - (li32(0) >> 1),0);
                     _loc25_ = lf32(0);
                     _loc24_ = _loc25_ * (1.5 - 0.5 * _loc23_ * _loc25_ * _loc25_);
                     _loc25_ = _loc24_ < Config.epsilon ? 1e+100 : 1 / _loc24_;
                     _loc26_ = 0.5 + (param1.circle.radius - 0.5 * _loc16_) * _loc24_;
                     if(param4)
                     {
                        _loc45_ = false;
                        _loc38_ = null;
                        _loc39_ = param3.contacts.next;
                        while(_loc39_ != null)
                        {
                           _loc40_ = _loc39_;
                           if(0 == _loc40_.hash)
                           {
                              _loc38_ = _loc40_;
                              break;
                           }
                           _loc39_ = _loc39_.next;
                        }
                        if(_loc38_ == null)
                        {
                           if(ZPP_Contact.zpp_pool == null)
                           {
                              _loc38_ = new ZPP_Contact();
                           }
                           else
                           {
                              _loc38_ = ZPP_Contact.zpp_pool;
                              ZPP_Contact.zpp_pool = _loc38_.next;
                              _loc38_.next = null;
                           }
                           null;
                           _loc41_ = _loc38_.inner;
                           _loc41_.jnAcc = _loc41_.jtAcc = 0;
                           _loc38_.hash = 0;
                           _loc38_.fresh = true;
                           _loc38_.arbiter = param3;
                           param3.jrAcc = 0;
                           _loc39_ = param3.contacts;
                           _loc38_._inuse = true;
                           _loc40_ = _loc38_;
                           _loc40_.next = _loc39_.next;
                           _loc39_.next = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc38_;
                           param3.innards.add(_loc41_);
                        }
                        else
                        {
                           _loc38_.fresh = false;
                        }
                        _loc38_.px = param1.circle.worldCOMx + _loc21_ * _loc26_;
                        _loc38_.py = param1.circle.worldCOMy + _loc22_ * _loc26_;
                        param3.nx = -_loc21_ * _loc24_;
                        param3.ny = -_loc22_ * _loc24_;
                        _loc38_.dist = _loc25_ - _loc16_;
                        _loc38_.stamp = param3.stamp;
                        _loc38_.posOnly = _loc45_;
                        §§push(_loc38_);
                     }
                     else
                     {
                        _loc45_ = false;
                        _loc38_ = null;
                        _loc39_ = param3.contacts.next;
                        while(_loc39_ != null)
                        {
                           _loc40_ = _loc39_;
                           if(0 == _loc40_.hash)
                           {
                              _loc38_ = _loc40_;
                              break;
                           }
                           _loc39_ = _loc39_.next;
                        }
                        if(_loc38_ == null)
                        {
                           if(ZPP_Contact.zpp_pool == null)
                           {
                              _loc38_ = new ZPP_Contact();
                           }
                           else
                           {
                              _loc38_ = ZPP_Contact.zpp_pool;
                              ZPP_Contact.zpp_pool = _loc38_.next;
                              _loc38_.next = null;
                           }
                           null;
                           _loc41_ = _loc38_.inner;
                           _loc41_.jnAcc = _loc41_.jtAcc = 0;
                           _loc38_.hash = 0;
                           _loc38_.fresh = true;
                           _loc38_.arbiter = param3;
                           param3.jrAcc = 0;
                           _loc39_ = param3.contacts;
                           _loc38_._inuse = true;
                           _loc40_ = _loc38_;
                           _loc40_.next = _loc39_.next;
                           _loc39_.next = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc38_;
                           param3.innards.add(_loc41_);
                        }
                        else
                        {
                           _loc38_.fresh = false;
                        }
                        _loc38_.px = param1.circle.worldCOMx + _loc21_ * _loc26_;
                        _loc38_.py = param1.circle.worldCOMy + _loc22_ * _loc26_;
                        param3.nx = _loc21_ * _loc24_;
                        param3.ny = _loc22_ * _loc24_;
                        _loc38_.dist = _loc25_ - _loc16_;
                        _loc38_.stamp = param3.stamp;
                        _loc38_.posOnly = _loc45_;
                        §§push(_loc38_);
                     }
                  }
                  _loc36_ = §§pop();
                  if(_loc36_ != null)
                  {
                     _loc41_ = _loc36_.inner;
                     param3.ptype = 2;
                     _loc16_ = 0;
                     _loc21_ = 0;
                     _loc16_ = _loc44_.x - param2.polygon.body.posx;
                     _loc21_ = _loc44_.y - param2.polygon.body.posy;
                     param3.__ref_edge1 = _loc9_;
                     param3.__ref_vertex = 1;
                     if(param4)
                     {
                        _loc41_.lr1x = _loc16_ * param2.polygon.body.axisy + _loc21_ * param2.polygon.body.axisx;
                        _loc41_.lr1y = _loc21_ * param2.polygon.body.axisy - _loc16_ * param2.polygon.body.axisx;
                        _loc41_.lr2x = param1.circle.localCOMx;
                        _loc41_.lr2y = param1.circle.localCOMy;
                     }
                     else
                     {
                        _loc41_.lr2x = _loc16_ * param2.polygon.body.axisy + _loc21_ * param2.polygon.body.axisx;
                        _loc41_.lr2y = _loc21_ * param2.polygon.body.axisy - _loc16_ * param2.polygon.body.axisx;
                        _loc41_.lr1x = param1.circle.localCOMx;
                        _loc41_.lr1y = param1.circle.localCOMy;
                     }
                     param3.radius = param1.circle.radius;
                  }
                  return _loc36_ != null;
               }
               _loc16_ = 0;
               _loc21_ = 0;
               _loc22_ = param1.circle.radius + _loc6_ * 0.5;
               _loc16_ = _loc9_.gnormx * _loc22_;
               _loc21_ = _loc9_.gnormy * _loc22_;
               _loc22_ = 0;
               _loc23_ = 0;
               _loc22_ = param1.circle.worldCOMx - _loc16_;
               _loc23_ = param1.circle.worldCOMy - _loc21_;
               if(param4)
               {
                  _loc45_ = false;
                  _loc38_ = null;
                  _loc39_ = param3.contacts.next;
                  while(_loc39_ != null)
                  {
                     _loc40_ = _loc39_;
                     if(0 == _loc40_.hash)
                     {
                        _loc38_ = _loc40_;
                        break;
                     }
                     _loc39_ = _loc39_.next;
                  }
                  if(_loc38_ == null)
                  {
                     if(ZPP_Contact.zpp_pool == null)
                     {
                        _loc38_ = new ZPP_Contact();
                     }
                     else
                     {
                        _loc38_ = ZPP_Contact.zpp_pool;
                        ZPP_Contact.zpp_pool = _loc38_.next;
                        _loc38_.next = null;
                     }
                     null;
                     _loc41_ = _loc38_.inner;
                     _loc41_.jnAcc = _loc41_.jtAcc = 0;
                     _loc38_.hash = 0;
                     _loc38_.fresh = true;
                     _loc38_.arbiter = param3;
                     param3.jrAcc = 0;
                     _loc39_ = param3.contacts;
                     _loc38_._inuse = true;
                     _loc40_ = _loc38_;
                     _loc40_.next = _loc39_.next;
                     _loc39_.next = _loc40_;
                     _loc39_.modified = true;
                     ++_loc39_.length;
                     _loc38_;
                     param3.innards.add(_loc41_);
                  }
                  else
                  {
                     _loc38_.fresh = false;
                  }
                  _loc38_.px = _loc22_;
                  _loc38_.py = _loc23_;
                  param3.nx = _loc9_.gnormx;
                  param3.ny = _loc9_.gnormy;
                  _loc38_.dist = _loc6_;
                  _loc38_.stamp = param3.stamp;
                  _loc38_.posOnly = _loc45_;
                  §§push(_loc38_);
               }
               else
               {
                  _loc45_ = false;
                  _loc38_ = null;
                  _loc39_ = param3.contacts.next;
                  while(_loc39_ != null)
                  {
                     _loc40_ = _loc39_;
                     if(0 == _loc40_.hash)
                     {
                        _loc38_ = _loc40_;
                        break;
                     }
                     _loc39_ = _loc39_.next;
                  }
                  if(_loc38_ == null)
                  {
                     if(ZPP_Contact.zpp_pool == null)
                     {
                        _loc38_ = new ZPP_Contact();
                     }
                     else
                     {
                        _loc38_ = ZPP_Contact.zpp_pool;
                        ZPP_Contact.zpp_pool = _loc38_.next;
                        _loc38_.next = null;
                     }
                     null;
                     _loc41_ = _loc38_.inner;
                     _loc41_.jnAcc = _loc41_.jtAcc = 0;
                     _loc38_.hash = 0;
                     _loc38_.fresh = true;
                     _loc38_.arbiter = param3;
                     param3.jrAcc = 0;
                     _loc39_ = param3.contacts;
                     _loc38_._inuse = true;
                     _loc40_ = _loc38_;
                     _loc40_.next = _loc39_.next;
                     _loc39_.next = _loc40_;
                     _loc39_.modified = true;
                     ++_loc39_.length;
                     _loc38_;
                     param3.innards.add(_loc41_);
                  }
                  else
                  {
                     _loc38_.fresh = false;
                  }
                  _loc38_.px = _loc22_;
                  _loc38_.py = _loc23_;
                  param3.nx = -_loc9_.gnormx;
                  param3.ny = -_loc9_.gnormy;
                  _loc38_.dist = _loc6_;
                  _loc38_.stamp = param3.stamp;
                  _loc38_.posOnly = _loc45_;
                  §§push(_loc38_);
               }
               _loc36_ = §§pop();
               param3.ptype = param4 ? 0 : 1;
               param3.lnormx = _loc9_.lnormx;
               param3.lnormy = _loc9_.lnormy;
               param3.rev = !param4;
               param3.lproj = _loc9_.lprojection;
               param3.radius = param1.circle.radius;
               _loc36_.inner.lr1x = param1.circle.localCOMx;
               _loc36_.inner.lr1y = param1.circle.localCOMy;
               param3.__ref_edge1 = _loc9_;
               param3.__ref_vertex = 0;
               return true;
            }
            return false;
         }
         _loc6_ = param1.circle.radius + param2.circle.radius;
         _loc7_ = 0;
         _loc13_ = 0;
         _loc7_ = param2.circle.worldCOMx - param1.circle.worldCOMx;
         _loc13_ = param2.circle.worldCOMy - param1.circle.worldCOMy;
         _loc16_ = _loc7_ * _loc7_ + _loc13_ * _loc13_;
         if(_loc16_ > _loc6_ * _loc6_)
         {
            §§push(null);
         }
         else if(_loc16_ < Config.epsilon * Config.epsilon)
         {
            _loc5_ = false;
            _loc38_ = null;
            _loc39_ = param3.contacts.next;
            while(_loc39_ != null)
            {
               _loc40_ = _loc39_;
               if(0 == _loc40_.hash)
               {
                  _loc38_ = _loc40_;
                  break;
               }
               _loc39_ = _loc39_.next;
            }
            if(_loc38_ == null)
            {
               if(ZPP_Contact.zpp_pool == null)
               {
                  _loc38_ = new ZPP_Contact();
               }
               else
               {
                  _loc38_ = ZPP_Contact.zpp_pool;
                  ZPP_Contact.zpp_pool = _loc38_.next;
                  _loc38_.next = null;
               }
               null;
               _loc41_ = _loc38_.inner;
               _loc41_.jnAcc = _loc41_.jtAcc = 0;
               _loc38_.hash = 0;
               _loc38_.fresh = true;
               _loc38_.arbiter = param3;
               param3.jrAcc = 0;
               _loc39_ = param3.contacts;
               _loc38_._inuse = true;
               _loc40_ = _loc38_;
               _loc40_.next = _loc39_.next;
               _loc39_.next = _loc40_;
               _loc39_.modified = true;
               ++_loc39_.length;
               _loc38_;
               param3.innards.add(_loc41_);
            }
            else
            {
               _loc38_.fresh = false;
            }
            _loc38_.px = param1.circle.worldCOMx;
            _loc38_.py = param1.circle.worldCOMy;
            param3.nx = 1;
            param3.ny = 0;
            _loc38_.dist = -_loc6_;
            _loc38_.stamp = param3.stamp;
            _loc38_.posOnly = _loc5_;
            §§push(_loc38_);
         }
         else
         {
            sf32(_loc16_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc22_ = lf32(0);
            _loc21_ = _loc22_ * (1.5 - 0.5 * _loc16_ * _loc22_ * _loc22_);
            _loc22_ = _loc21_ < Config.epsilon ? 1e+100 : 1 / _loc21_;
            _loc23_ = 0.5 + (param1.circle.radius - 0.5 * _loc6_) * _loc21_;
            if(param4)
            {
               _loc5_ = false;
               _loc38_ = null;
               _loc39_ = param3.contacts.next;
               while(_loc39_ != null)
               {
                  _loc40_ = _loc39_;
                  if(0 == _loc40_.hash)
                  {
                     _loc38_ = _loc40_;
                     break;
                  }
                  _loc39_ = _loc39_.next;
               }
               if(_loc38_ == null)
               {
                  if(ZPP_Contact.zpp_pool == null)
                  {
                     _loc38_ = new ZPP_Contact();
                  }
                  else
                  {
                     _loc38_ = ZPP_Contact.zpp_pool;
                     ZPP_Contact.zpp_pool = _loc38_.next;
                     _loc38_.next = null;
                  }
                  null;
                  _loc41_ = _loc38_.inner;
                  _loc41_.jnAcc = _loc41_.jtAcc = 0;
                  _loc38_.hash = 0;
                  _loc38_.fresh = true;
                  _loc38_.arbiter = param3;
                  param3.jrAcc = 0;
                  _loc39_ = param3.contacts;
                  _loc38_._inuse = true;
                  _loc40_ = _loc38_;
                  _loc40_.next = _loc39_.next;
                  _loc39_.next = _loc40_;
                  _loc39_.modified = true;
                  ++_loc39_.length;
                  _loc38_;
                  param3.innards.add(_loc41_);
               }
               else
               {
                  _loc38_.fresh = false;
               }
               _loc38_.px = param1.circle.worldCOMx + _loc7_ * _loc23_;
               _loc38_.py = param1.circle.worldCOMy + _loc13_ * _loc23_;
               param3.nx = -_loc7_ * _loc21_;
               param3.ny = -_loc13_ * _loc21_;
               _loc38_.dist = _loc22_ - _loc6_;
               _loc38_.stamp = param3.stamp;
               _loc38_.posOnly = _loc5_;
               §§push(_loc38_);
            }
            else
            {
               _loc5_ = false;
               _loc38_ = null;
               _loc39_ = param3.contacts.next;
               while(_loc39_ != null)
               {
                  _loc40_ = _loc39_;
                  if(0 == _loc40_.hash)
                  {
                     _loc38_ = _loc40_;
                     break;
                  }
                  _loc39_ = _loc39_.next;
               }
               if(_loc38_ == null)
               {
                  if(ZPP_Contact.zpp_pool == null)
                  {
                     _loc38_ = new ZPP_Contact();
                  }
                  else
                  {
                     _loc38_ = ZPP_Contact.zpp_pool;
                     ZPP_Contact.zpp_pool = _loc38_.next;
                     _loc38_.next = null;
                  }
                  null;
                  _loc41_ = _loc38_.inner;
                  _loc41_.jnAcc = _loc41_.jtAcc = 0;
                  _loc38_.hash = 0;
                  _loc38_.fresh = true;
                  _loc38_.arbiter = param3;
                  param3.jrAcc = 0;
                  _loc39_ = param3.contacts;
                  _loc38_._inuse = true;
                  _loc40_ = _loc38_;
                  _loc40_.next = _loc39_.next;
                  _loc39_.next = _loc40_;
                  _loc39_.modified = true;
                  ++_loc39_.length;
                  _loc38_;
                  param3.innards.add(_loc41_);
               }
               else
               {
                  _loc38_.fresh = false;
               }
               _loc38_.px = param1.circle.worldCOMx + _loc7_ * _loc23_;
               _loc38_.py = param1.circle.worldCOMy + _loc13_ * _loc23_;
               param3.nx = _loc7_ * _loc21_;
               param3.ny = _loc13_ * _loc21_;
               _loc38_.dist = _loc22_ - _loc6_;
               _loc38_.stamp = param3.stamp;
               _loc38_.posOnly = _loc5_;
               §§push(_loc38_);
            }
         }
         _loc36_ = §§pop();
         if(_loc36_ != null)
         {
            _loc41_ = _loc36_.inner;
            if(param4)
            {
               _loc41_.lr1x = param2.circle.localCOMx;
               _loc41_.lr1y = param2.circle.localCOMy;
               _loc41_.lr2x = param1.circle.localCOMx;
               _loc41_.lr2y = param1.circle.localCOMy;
            }
            else
            {
               _loc41_.lr1x = param1.circle.localCOMx;
               _loc41_.lr1y = param1.circle.localCOMy;
               _loc41_.lr2x = param2.circle.localCOMx;
               _loc41_.lr2y = param2.circle.localCOMy;
            }
            param3.radius = param1.circle.radius + param2.circle.radius;
            param3.ptype = 2;
            return true;
         }
         return false;
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
         var _loc4_:* = null as Array;
         var _loc5_:* = null as Array;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as ZNPNode_ZPP_Edge;
         var _loc9_:* = null as ZPP_Edge;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:Number = NaN;
         var _loc15_:* = null as ZPP_Polygon;
         var _loc16_:* = null as ZPP_Polygon;
         var _loc17_:* = null as ZPP_Vec2;
         var _loc18_:* = null as ZPP_Vec2;
         var _loc19_:* = null as ZPP_Vec2;
         var _loc20_:* = null as ZPP_Body;
         var _loc21_:Boolean = false;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:Boolean = false;
         var _loc27_:* = null as ZPP_Vec2;
         var _loc28_:* = null as ZPP_Vec2;
         var _loc29_:Boolean = false;
         var _loc30_:* = null as ZPP_Vec2;
         var _loc31_:* = null as ZPP_Vec2;
         var _loc32_:* = null as ZPP_Vec2;
         var _loc33_:* = null as ZPP_Vec2;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:* = null as ZPP_Vec2;
         var _loc44_:* = null as ZNPNode_ZPP_Vec2;
         var _loc45_:* = null as ZPP_Edge;
         var _loc46_:Number = NaN;
         var _loc47_:* = null as ZPP_Vec2;
         var _loc48_:Number = NaN;
         var _loc49_:Number = NaN;
         var _loc50_:Number = NaN;
         var _loc51_:Number = NaN;
         var _loc52_:Number = NaN;
         var _loc53_:Number = NaN;
         var _loc54_:* = null as ZPP_Circle;
         var _loc55_:* = null as ZPP_Circle;
         if(param2.type == ZPP_Flags.id_ShapeType_POLYGON)
         {
            if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc4_ = [];
               _loc5_ = [];
               _loc6_ = true;
               _loc7_ = true;
               _loc8_ = param1.polygon.edges.head;
               while(_loc8_ != null)
               {
                  _loc9_ = _loc8_.elt;
                  _loc10_ = 1e+100;
                  _loc11_ = 0;
                  _loc12_ = param2.polygon.gverts.next;
                  while(_loc12_ != null)
                  {
                     _loc13_ = _loc12_;
                     _loc14_ = _loc9_.gnormx * _loc13_.x + _loc9_.gnormy * _loc13_.y;
                     if(_loc14_ < _loc10_)
                     {
                        _loc10_ = _loc14_;
                     }
                     if(_loc14_ >= _loc9_.gprojection + Config.epsilon)
                     {
                        _loc5_[_loc11_] = true;
                        _loc7_ = false;
                     }
                     _loc11_++;
                     _loc12_ = _loc12_.next;
                  }
                  _loc10_ -= _loc9_.gprojection;
                  if(_loc10_ > 0)
                  {
                     _loc6_ = false;
                     break;
                  }
                  _loc8_ = _loc8_.next;
               }
               if(_loc7_)
               {
                  _loc15_ = param2.polygon;
                  if(_loc15_.zip_worldCOM)
                  {
                     if(_loc15_.body != null)
                     {
                        _loc15_.zip_worldCOM = false;
                        if(_loc15_.zip_localCOM)
                        {
                           _loc15_.zip_localCOM = false;
                           if(_loc15_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc16_ = _loc15_.polygon;
                              if(_loc16_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful localCOM";
                              }
                              if(_loc16_.lverts.next.next == null)
                              {
                                 _loc16_.localCOMx = _loc16_.lverts.next.x;
                                 _loc16_.localCOMy = _loc16_.lverts.next.y;
                                 null;
                              }
                              else if(_loc16_.lverts.next.next.next == null)
                              {
                                 _loc16_.localCOMx = _loc16_.lverts.next.x;
                                 _loc16_.localCOMy = _loc16_.lverts.next.y;
                                 _loc10_ = 1;
                                 _loc16_.localCOMx += _loc16_.lverts.next.next.x * _loc10_;
                                 _loc16_.localCOMy += _loc16_.lverts.next.next.y * _loc10_;
                                 _loc10_ = 0.5;
                                 _loc16_.localCOMx *= _loc10_;
                                 _loc16_.localCOMy *= _loc10_;
                              }
                              else
                              {
                                 _loc16_.localCOMx = 0;
                                 _loc16_.localCOMy = 0;
                                 _loc10_ = 0;
                                 _loc12_ = _loc16_.lverts.next;
                                 _loc13_ = _loc12_;
                                 _loc12_ = _loc12_.next;
                                 _loc17_ = _loc12_;
                                 _loc12_ = _loc12_.next;
                                 while(_loc12_ != null)
                                 {
                                    _loc18_ = _loc12_;
                                    _loc10_ += _loc17_.x * (_loc18_.y - _loc13_.y);
                                    _loc14_ = _loc18_.y * _loc17_.x - _loc18_.x * _loc17_.y;
                                    _loc16_.localCOMx += (_loc17_.x + _loc18_.x) * _loc14_;
                                    _loc16_.localCOMy += (_loc17_.y + _loc18_.y) * _loc14_;
                                    _loc13_ = _loc17_;
                                    _loc17_ = _loc18_;
                                    _loc12_ = _loc12_.next;
                                 }
                                 _loc12_ = _loc16_.lverts.next;
                                 _loc18_ = _loc12_;
                                 _loc10_ += _loc17_.x * (_loc18_.y - _loc13_.y);
                                 _loc14_ = _loc18_.y * _loc17_.x - _loc18_.x * _loc17_.y;
                                 _loc16_.localCOMx += (_loc17_.x + _loc18_.x) * _loc14_;
                                 _loc16_.localCOMy += (_loc17_.y + _loc18_.y) * _loc14_;
                                 _loc13_ = _loc17_;
                                 _loc17_ = _loc18_;
                                 _loc12_ = _loc12_.next;
                                 _loc19_ = _loc12_;
                                 _loc10_ += _loc17_.x * (_loc19_.y - _loc13_.y);
                                 _loc14_ = _loc19_.y * _loc17_.x - _loc19_.x * _loc17_.y;
                                 _loc16_.localCOMx += (_loc17_.x + _loc19_.x) * _loc14_;
                                 _loc16_.localCOMy += (_loc17_.y + _loc19_.y) * _loc14_;
                                 _loc10_ = 1 / (3 * _loc10_);
                                 _loc14_ = _loc10_;
                                 _loc16_.localCOMx *= _loc14_;
                                 _loc16_.localCOMy *= _loc14_;
                              }
                           }
                        }
                        _loc20_ = _loc15_.body;
                        if(_loc20_.zip_axis)
                        {
                           _loc20_.zip_axis = false;
                           _loc20_.axisx = Math.sin(_loc20_.rot);
                           _loc20_.axisy = Math.cos(_loc20_.rot);
                           null;
                        }
                        _loc15_.worldCOMx = _loc15_.body.posx + (_loc15_.body.axisy * _loc15_.localCOMx - _loc15_.body.axisx * _loc15_.localCOMy);
                        _loc15_.worldCOMy = _loc15_.body.posy + (_loc15_.localCOMx * _loc15_.body.axisx + _loc15_.localCOMy * _loc15_.body.axisy);
                     }
                  }
                  param3.overlap = param2.polygon.area;
                  param3.centroidx = param2.polygon.worldCOMx;
                  param3.centroidy = param2.polygon.worldCOMy;
                  null;
                  return true;
               }
               else if(_loc6_)
               {
                  _loc7_ = true;
                  _loc8_ = param2.polygon.edges.head;
                  while(_loc8_ != null)
                  {
                     _loc9_ = _loc8_.elt;
                     _loc10_ = 1e+100;
                     _loc11_ = 0;
                     _loc12_ = param1.polygon.gverts.next;
                     while(_loc12_ != null)
                     {
                        _loc13_ = _loc12_;
                        _loc14_ = _loc9_.gnormx * _loc13_.x + _loc9_.gnormy * _loc13_.y;
                        if(_loc14_ < _loc10_)
                        {
                           _loc10_ = _loc14_;
                        }
                        if(_loc14_ >= _loc9_.gprojection + Config.epsilon)
                        {
                           _loc4_[_loc11_] = true;
                           _loc7_ = false;
                        }
                        _loc11_++;
                        _loc12_ = _loc12_.next;
                     }
                     _loc10_ -= _loc9_.gprojection;
                     if(_loc10_ > 0)
                     {
                        _loc6_ = false;
                        break;
                     }
                     _loc8_ = _loc8_.next;
                  }
                  if(_loc7_)
                  {
                     _loc15_ = param1.polygon;
                     if(_loc15_.zip_worldCOM)
                     {
                        if(_loc15_.body != null)
                        {
                           _loc15_.zip_worldCOM = false;
                           if(_loc15_.zip_localCOM)
                           {
                              _loc15_.zip_localCOM = false;
                              if(_loc15_.type == ZPP_Flags.id_ShapeType_POLYGON)
                              {
                                 _loc16_ = _loc15_.polygon;
                                 if(_loc16_.lverts.next == null)
                                 {
                                    Boot.lastError = new Error();
                                    throw "Error: An empty polygon has no meaningful localCOM";
                                 }
                                 if(_loc16_.lverts.next.next == null)
                                 {
                                    _loc16_.localCOMx = _loc16_.lverts.next.x;
                                    _loc16_.localCOMy = _loc16_.lverts.next.y;
                                    null;
                                 }
                                 else if(_loc16_.lverts.next.next.next == null)
                                 {
                                    _loc16_.localCOMx = _loc16_.lverts.next.x;
                                    _loc16_.localCOMy = _loc16_.lverts.next.y;
                                    _loc10_ = 1;
                                    _loc16_.localCOMx += _loc16_.lverts.next.next.x * _loc10_;
                                    _loc16_.localCOMy += _loc16_.lverts.next.next.y * _loc10_;
                                    _loc10_ = 0.5;
                                    _loc16_.localCOMx *= _loc10_;
                                    _loc16_.localCOMy *= _loc10_;
                                 }
                                 else
                                 {
                                    _loc16_.localCOMx = 0;
                                    _loc16_.localCOMy = 0;
                                    _loc10_ = 0;
                                    _loc12_ = _loc16_.lverts.next;
                                    _loc13_ = _loc12_;
                                    _loc12_ = _loc12_.next;
                                    _loc17_ = _loc12_;
                                    _loc12_ = _loc12_.next;
                                    while(_loc12_ != null)
                                    {
                                       _loc18_ = _loc12_;
                                       _loc10_ += _loc17_.x * (_loc18_.y - _loc13_.y);
                                       _loc14_ = _loc18_.y * _loc17_.x - _loc18_.x * _loc17_.y;
                                       _loc16_.localCOMx += (_loc17_.x + _loc18_.x) * _loc14_;
                                       _loc16_.localCOMy += (_loc17_.y + _loc18_.y) * _loc14_;
                                       _loc13_ = _loc17_;
                                       _loc17_ = _loc18_;
                                       _loc12_ = _loc12_.next;
                                    }
                                    _loc12_ = _loc16_.lverts.next;
                                    _loc18_ = _loc12_;
                                    _loc10_ += _loc17_.x * (_loc18_.y - _loc13_.y);
                                    _loc14_ = _loc18_.y * _loc17_.x - _loc18_.x * _loc17_.y;
                                    _loc16_.localCOMx += (_loc17_.x + _loc18_.x) * _loc14_;
                                    _loc16_.localCOMy += (_loc17_.y + _loc18_.y) * _loc14_;
                                    _loc13_ = _loc17_;
                                    _loc17_ = _loc18_;
                                    _loc12_ = _loc12_.next;
                                    _loc19_ = _loc12_;
                                    _loc10_ += _loc17_.x * (_loc19_.y - _loc13_.y);
                                    _loc14_ = _loc19_.y * _loc17_.x - _loc19_.x * _loc17_.y;
                                    _loc16_.localCOMx += (_loc17_.x + _loc19_.x) * _loc14_;
                                    _loc16_.localCOMy += (_loc17_.y + _loc19_.y) * _loc14_;
                                    _loc10_ = 1 / (3 * _loc10_);
                                    _loc14_ = _loc10_;
                                    _loc16_.localCOMx *= _loc14_;
                                    _loc16_.localCOMy *= _loc14_;
                                 }
                              }
                           }
                           _loc20_ = _loc15_.body;
                           if(_loc20_.zip_axis)
                           {
                              _loc20_.zip_axis = false;
                              _loc20_.axisx = Math.sin(_loc20_.rot);
                              _loc20_.axisy = Math.cos(_loc20_.rot);
                              null;
                           }
                           _loc15_.worldCOMx = _loc15_.body.posx + (_loc15_.body.axisy * _loc15_.localCOMx - _loc15_.body.axisx * _loc15_.localCOMy);
                           _loc15_.worldCOMy = _loc15_.body.posy + (_loc15_.localCOMx * _loc15_.body.axisx + _loc15_.localCOMy * _loc15_.body.axisy);
                        }
                     }
                     param3.overlap = param1.polygon.area;
                     param3.centroidx = param1.polygon.worldCOMx;
                     param3.centroidy = param1.polygon.worldCOMy;
                     null;
                     return true;
                  }
                  else if(_loc6_)
                  {
                     while(ZPP_Collide.flowpoly.head != null)
                     {
                        _loc12_ = ZPP_Collide.flowpoly.pop_unsafe();
                        if(!_loc12_._inuse)
                        {
                           _loc13_ = _loc12_;
                           if(_loc13_.outer != null)
                           {
                              _loc13_.outer.zpp_inner = null;
                              _loc13_.outer = null;
                           }
                           _loc13_._isimmutable = null;
                           _loc13_._validate = null;
                           _loc13_._invalidate = null;
                           _loc13_.next = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc13_;
                        }
                     }
                     _loc12_ = null;
                     _loc21_ = false;
                     _loc13_ = param1.polygon.gverts.next;
                     _loc11_ = 0;
                     _loc17_ = param2.polygon.gverts.next;
                     _loc22_ = 0;
                     _loc23_ = 0;
                     _loc24_ = param2.polygon.edgeCnt;
                     while(_loc23_ < _loc24_)
                     {
                        _loc25_ = _loc23_++;
                        if(!Boolean(_loc5_[_loc25_]))
                        {
                           _loc22_ = _loc25_;
                           break;
                        }
                        _loc17_ = _loc17_.next;
                     }
                     if(_loc17_ == null)
                     {
                        _loc17_ = param2.polygon.gverts.next;
                        _loc21_ = true;
                        _loc23_ = 0;
                        _loc24_ = param1.polygon.edgeCnt;
                        while(_loc23_ < _loc24_)
                        {
                           _loc25_ = _loc23_++;
                           if(!Boolean(_loc4_[_loc25_]))
                           {
                              _loc11_ = _loc25_;
                              break;
                           }
                           _loc13_ = _loc13_.next;
                        }
                        if(_loc13_ == null)
                        {
                           _loc13_ = param1.polygon.gverts.next;
                        }
                        else
                        {
                           ZPP_Collide.flowpoly.add(_loc13_);
                           _loc12_ = ZPP_Collide.flowpoly.head.elt;
                        }
                     }
                     else
                     {
                        ZPP_Collide.flowpoly.add(_loc17_);
                        _loc12_ = ZPP_Collide.flowpoly.head.elt;
                     }
                     _loc23_ = 1;
                     if(ZPP_Collide.flowpoly.head == null)
                     {
                        _loc26_ = true;
                        _loc18_ = param1.polygon.gverts.next;
                        _loc19_ = _loc18_;
                        _loc27_ = _loc18_.next;
                        while(_loc27_ != null)
                        {
                           _loc28_ = _loc27_;
                           _loc10_ = 2;
                           _loc29_ = true;
                           _loc30_ = param2.polygon.gverts.next;
                           _loc31_ = _loc30_;
                           _loc32_ = _loc30_.next;
                           while(_loc32_ != null)
                           {
                              _loc33_ = _loc32_;
                              _loc14_ = 0;
                              _loc34_ = 0;
                              _loc35_ = 0;
                              _loc34_ = _loc19_.x - _loc31_.x;
                              _loc35_ = _loc19_.y - _loc31_.y;
                              _loc36_ = 0;
                              _loc37_ = 0;
                              _loc36_ = _loc28_.x - _loc19_.x;
                              _loc37_ = _loc28_.y - _loc19_.y;
                              _loc38_ = 0;
                              _loc39_ = 0;
                              _loc38_ = _loc33_.x - _loc31_.x;
                              _loc39_ = _loc33_.y - _loc31_.y;
                              _loc40_ = _loc37_ * _loc38_ - _loc36_ * _loc39_;
                              if(_loc40_ * _loc40_ > Config.epsilon * Config.epsilon ? (_loc40_ = 1 / _loc40_, _loc41_ = (_loc39_ * _loc34_ - _loc38_ * _loc35_) * _loc40_, _loc41_ > Config.epsilon && _loc41_ < 1 - Config.epsilon ? (_loc42_ = (_loc37_ * _loc34_ - _loc36_ * _loc35_) * _loc40_, _loc42_ > Config.epsilon && _loc42_ < 1 - Config.epsilon ? (_loc14_ = _loc41_, true) : false) : false) : false)
                              {
                                 if(_loc14_ < _loc10_)
                                 {
                                    _loc10_ = _loc14_;
                                    _loc17_ = _loc30_;
                                 }
                              }
                              _loc30_ = _loc32_;
                              _loc31_ = _loc33_;
                              _loc32_ = _loc32_.next;
                           }
                           if(_loc29_)
                           {
                              do
                              {
                                 _loc32_ = param2.polygon.gverts.next;
                                 _loc33_ = _loc32_;
                                 _loc14_ = 0;
                                 _loc34_ = 0;
                                 _loc35_ = 0;
                                 _loc34_ = _loc19_.x - _loc31_.x;
                                 _loc35_ = _loc19_.y - _loc31_.y;
                                 _loc36_ = 0;
                                 _loc37_ = 0;
                                 _loc36_ = _loc28_.x - _loc19_.x;
                                 _loc37_ = _loc28_.y - _loc19_.y;
                                 _loc38_ = 0;
                                 _loc39_ = 0;
                                 _loc38_ = _loc33_.x - _loc31_.x;
                                 _loc39_ = _loc33_.y - _loc31_.y;
                                 _loc40_ = _loc37_ * _loc38_ - _loc36_ * _loc39_;
                                 if(_loc40_ * _loc40_ > Config.epsilon * Config.epsilon ? (_loc40_ = 1 / _loc40_, _loc41_ = (_loc39_ * _loc34_ - _loc38_ * _loc35_) * _loc40_, _loc41_ > Config.epsilon && _loc41_ < 1 - Config.epsilon ? (_loc42_ = (_loc37_ * _loc34_ - _loc36_ * _loc35_) * _loc40_, _loc42_ > Config.epsilon && _loc42_ < 1 - Config.epsilon ? (_loc14_ = _loc41_, true) : false) : false) : false)
                                 {
                                    if(_loc14_ < _loc10_)
                                    {
                                       _loc10_ = _loc14_;
                                       _loc17_ = _loc30_;
                                    }
                                 }
                              }
                              while(false);
                              
                           }
                           if(_loc10_ != 2)
                           {
                              _loc14_ = 0;
                              _loc34_ = 0;
                              _loc35_ = _loc10_;
                              _loc14_ = _loc19_.x + (_loc28_.x - _loc19_.x) * _loc35_;
                              _loc34_ = _loc19_.y + (_loc28_.y - _loc19_.y) * _loc35_;
                              _loc29_ = false;
                              if(ZPP_Vec2.zpp_pool == null)
                              {
                                 _loc30_ = new ZPP_Vec2();
                              }
                              else
                              {
                                 _loc30_ = ZPP_Vec2.zpp_pool;
                                 ZPP_Vec2.zpp_pool = _loc30_.next;
                                 _loc30_.next = null;
                              }
                              _loc30_.weak = false;
                              _loc30_._immutable = _loc29_;
                              _loc30_.x = _loc14_;
                              _loc30_.y = _loc34_;
                              _loc12_ = _loc30_;
                              ZPP_Collide.flowpoly.add(_loc12_);
                              _loc21_ = true;
                              _loc13_ = _loc18_;
                              _loc26_ = false;
                              break;
                           }
                           _loc18_ = _loc27_;
                           _loc19_ = _loc28_;
                           _loc27_ = _loc27_.next;
                        }
                        if(_loc26_)
                        {
                           do
                           {
                              _loc27_ = param1.polygon.gverts.next;
                              _loc28_ = _loc27_;
                              _loc10_ = 2;
                              _loc29_ = true;
                              _loc30_ = param2.polygon.gverts.next;
                              _loc31_ = _loc30_;
                              _loc32_ = _loc30_.next;
                              while(_loc32_ != null)
                              {
                                 _loc33_ = _loc32_;
                                 _loc14_ = 0;
                                 _loc34_ = 0;
                                 _loc35_ = 0;
                                 _loc34_ = _loc19_.x - _loc31_.x;
                                 _loc35_ = _loc19_.y - _loc31_.y;
                                 _loc36_ = 0;
                                 _loc37_ = 0;
                                 _loc36_ = _loc28_.x - _loc19_.x;
                                 _loc37_ = _loc28_.y - _loc19_.y;
                                 _loc38_ = 0;
                                 _loc39_ = 0;
                                 _loc38_ = _loc33_.x - _loc31_.x;
                                 _loc39_ = _loc33_.y - _loc31_.y;
                                 _loc40_ = _loc37_ * _loc38_ - _loc36_ * _loc39_;
                                 if(_loc40_ * _loc40_ > Config.epsilon * Config.epsilon ? (_loc40_ = 1 / _loc40_, _loc41_ = (_loc39_ * _loc34_ - _loc38_ * _loc35_) * _loc40_, _loc41_ > Config.epsilon && _loc41_ < 1 - Config.epsilon ? (_loc42_ = (_loc37_ * _loc34_ - _loc36_ * _loc35_) * _loc40_, _loc42_ > Config.epsilon && _loc42_ < 1 - Config.epsilon ? (_loc14_ = _loc41_, true) : false) : false) : false)
                                 {
                                    if(_loc14_ < _loc10_)
                                    {
                                       _loc10_ = _loc14_;
                                       _loc17_ = _loc30_;
                                    }
                                 }
                                 _loc30_ = _loc32_;
                                 _loc31_ = _loc33_;
                                 _loc32_ = _loc32_.next;
                              }
                              if(_loc29_)
                              {
                                 do
                                 {
                                    _loc32_ = param2.polygon.gverts.next;
                                    _loc33_ = _loc32_;
                                    _loc14_ = 0;
                                    _loc34_ = 0;
                                    _loc35_ = 0;
                                    _loc34_ = _loc19_.x - _loc31_.x;
                                    _loc35_ = _loc19_.y - _loc31_.y;
                                    _loc36_ = 0;
                                    _loc37_ = 0;
                                    _loc36_ = _loc28_.x - _loc19_.x;
                                    _loc37_ = _loc28_.y - _loc19_.y;
                                    _loc38_ = 0;
                                    _loc39_ = 0;
                                    _loc38_ = _loc33_.x - _loc31_.x;
                                    _loc39_ = _loc33_.y - _loc31_.y;
                                    _loc40_ = _loc37_ * _loc38_ - _loc36_ * _loc39_;
                                    if(_loc40_ * _loc40_ > Config.epsilon * Config.epsilon ? (_loc40_ = 1 / _loc40_, _loc41_ = (_loc39_ * _loc34_ - _loc38_ * _loc35_) * _loc40_, _loc41_ > Config.epsilon && _loc41_ < 1 - Config.epsilon ? (_loc42_ = (_loc37_ * _loc34_ - _loc36_ * _loc35_) * _loc40_, _loc42_ > Config.epsilon && _loc42_ < 1 - Config.epsilon ? (_loc14_ = _loc41_, true) : false) : false) : false)
                                    {
                                       if(_loc14_ < _loc10_)
                                       {
                                          _loc10_ = _loc14_;
                                          _loc17_ = _loc30_;
                                       }
                                    }
                                 }
                                 while(false);
                                 
                              }
                              if(_loc10_ != 2)
                              {
                                 _loc14_ = 0;
                                 _loc34_ = 0;
                                 _loc35_ = _loc10_;
                                 _loc14_ = _loc19_.x + (_loc28_.x - _loc19_.x) * _loc35_;
                                 _loc34_ = _loc19_.y + (_loc28_.y - _loc19_.y) * _loc35_;
                                 _loc29_ = false;
                                 if(ZPP_Vec2.zpp_pool == null)
                                 {
                                    _loc30_ = new ZPP_Vec2();
                                 }
                                 else
                                 {
                                    _loc30_ = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc30_.next;
                                    _loc30_.next = null;
                                 }
                                 _loc30_.weak = false;
                                 _loc30_._immutable = _loc29_;
                                 _loc30_.x = _loc14_;
                                 _loc30_.y = _loc34_;
                                 _loc12_ = _loc30_;
                                 ZPP_Collide.flowpoly.add(_loc12_);
                                 _loc21_ = true;
                                 _loc13_ = _loc18_;
                                 break;
                              }
                           }
                           while(false);
                           
                        }
                        _loc23_ = 2;
                     }
                     while(true)
                     {
                        if(_loc21_)
                        {
                           _loc13_ = _loc13_.next;
                           _loc11_++;
                           if(_loc13_ == null)
                           {
                              _loc13_ = param1.polygon.gverts.next;
                              _loc11_ = 0;
                           }
                           if(!Boolean(_loc4_[_loc11_]))
                           {
                              _loc18_ = _loc13_;
                              if(_loc12_ != null && _loc10_ * _loc10_ + _loc14_ * _loc14_ < Config.epsilon)
                              {
                                 break;
                              }
                              ZPP_Collide.flowpoly.add(_loc18_);
                              if(_loc12_ == null)
                              {
                                 _loc12_ = ZPP_Collide.flowpoly.head.elt;
                              }
                              _loc23_ = 1;
                           }
                           else
                           {
                              _loc18_ = ZPP_Collide.flowpoly.head.elt;
                              _loc19_ = _loc13_;
                              _loc27_ = _loc17_;
                              _loc28_ = _loc17_.next;
                              if(_loc28_ == null)
                              {
                                 _loc28_ = param2.polygon.gverts.next;
                              }
                              _loc10_ = -1;
                              _loc30_ = null;
                              _loc24_ = 0;
                              _loc25_ = 0;
                              _loc31_ = _loc28_;
                              _loc32_ = _loc28_;
                              do
                              {
                                 _loc33_ = _loc32_;
                                 _loc14_ = 0;
                                 _loc34_ = 0;
                                 _loc35_ = 0;
                                 _loc34_ = _loc27_.x - _loc18_.x;
                                 _loc35_ = _loc27_.y - _loc18_.y;
                                 _loc36_ = 0;
                                 _loc37_ = 0;
                                 _loc36_ = _loc33_.x - _loc27_.x;
                                 _loc37_ = _loc33_.y - _loc27_.y;
                                 _loc38_ = 0;
                                 _loc39_ = 0;
                                 _loc38_ = _loc19_.x - _loc18_.x;
                                 _loc39_ = _loc19_.y - _loc18_.y;
                                 _loc40_ = _loc37_ * _loc38_ - _loc36_ * _loc39_;
                                 if(_loc40_ * _loc40_ > Config.epsilon * Config.epsilon ? (_loc40_ = 1 / _loc40_, _loc41_ = (_loc39_ * _loc34_ - _loc38_ * _loc35_) * _loc40_, _loc41_ > Config.epsilon && _loc41_ < 1 - Config.epsilon ? (_loc42_ = (_loc37_ * _loc34_ - _loc36_ * _loc35_) * _loc40_, _loc42_ > Config.epsilon && _loc42_ < 1 - Config.epsilon ? (_loc14_ = _loc41_, true) : false) : false) : false)
                                 {
                                    if(_loc14_ >= _loc10_)
                                    {
                                       _loc30_ = _loc17_;
                                       _loc24_ = _loc22_;
                                       _loc25_++;
                                       if(_loc25_ == _loc23_)
                                       {
                                          _loc10_ = _loc14_;
                                          _loc32_ = _loc31_;
                                          break;
                                       }
                                       _loc10_ = _loc14_;
                                    }
                                 }
                                 _loc27_ = _loc33_;
                                 _loc17_ = _loc32_;
                                 _loc22_++;
                                 if(_loc22_ >= param2.polygon.edgeCnt)
                                 {
                                    _loc22_ = 0;
                                 }
                                 _loc32_ = _loc32_.next;
                                 if(_loc32_ == null)
                                 {
                                    _loc32_ = param2.polygon.gverts.next;
                                 }
                              }
                              while(false);
                              
                              while(_loc32_ != _loc31_)
                              {
                                 _loc33_ = _loc32_;
                                 _loc14_ = 0;
                                 _loc34_ = 0;
                                 _loc35_ = 0;
                                 _loc34_ = _loc27_.x - _loc18_.x;
                                 _loc35_ = _loc27_.y - _loc18_.y;
                                 _loc36_ = 0;
                                 _loc37_ = 0;
                                 _loc36_ = _loc33_.x - _loc27_.x;
                                 _loc37_ = _loc33_.y - _loc27_.y;
                                 _loc38_ = 0;
                                 _loc39_ = 0;
                                 _loc38_ = _loc19_.x - _loc18_.x;
                                 _loc39_ = _loc19_.y - _loc18_.y;
                                 _loc40_ = _loc37_ * _loc38_ - _loc36_ * _loc39_;
                                 if(_loc40_ * _loc40_ > Config.epsilon * Config.epsilon ? (_loc40_ = 1 / _loc40_, _loc41_ = (_loc39_ * _loc34_ - _loc38_ * _loc35_) * _loc40_, _loc41_ > Config.epsilon && _loc41_ < 1 - Config.epsilon ? (_loc42_ = (_loc37_ * _loc34_ - _loc36_ * _loc35_) * _loc40_, _loc42_ > Config.epsilon && _loc42_ < 1 - Config.epsilon ? (_loc14_ = _loc41_, true) : false) : false) : false)
                                 {
                                    if(_loc14_ >= _loc10_)
                                    {
                                       _loc30_ = _loc17_;
                                       _loc24_ = _loc22_;
                                       _loc25_++;
                                       if(_loc25_ == _loc23_)
                                       {
                                          _loc10_ = _loc14_;
                                          _loc32_ = _loc31_;
                                          break;
                                       }
                                       _loc10_ = _loc14_;
                                    }
                                 }
                                 _loc27_ = _loc33_;
                                 _loc17_ = _loc32_;
                                 _loc22_++;
                                 if(_loc22_ >= param2.polygon.edgeCnt)
                                 {
                                    _loc22_ = 0;
                                 }
                                 _loc32_ = _loc32_.next;
                                 if(_loc32_ == null)
                                 {
                                    _loc32_ = param2.polygon.gverts.next;
                                 }
                              }
                              if(_loc30_ == null)
                              {
                                 break;
                              }
                              _loc31_ = _loc30_;
                              _loc32_ = _loc30_.next;
                              if(_loc32_ == null)
                              {
                                 _loc32_ = param2.polygon.gverts.next;
                              }
                              _loc33_ = _loc32_;
                              _loc14_ = 0;
                              _loc34_ = 0;
                              _loc35_ = _loc10_;
                              _loc14_ = _loc31_.x + (_loc33_.x - _loc31_.x) * _loc35_;
                              _loc34_ = _loc31_.y + (_loc33_.y - _loc31_.y) * _loc35_;
                              if(_loc12_ != null && _loc35_ * _loc35_ + _loc36_ * _loc36_ < Config.epsilon)
                              {
                                 break;
                              }
                              _loc26_ = false;
                              §§push(ZPP_Collide.flowpoly);
                              if(ZPP_Vec2.zpp_pool == null)
                              {
                                 _loc43_ = new ZPP_Vec2();
                              }
                              else
                              {
                                 _loc43_ = ZPP_Vec2.zpp_pool;
                                 ZPP_Vec2.zpp_pool = _loc43_.next;
                                 _loc43_.next = null;
                              }
                              _loc43_.weak = false;
                              _loc43_._immutable = _loc26_;
                              _loc43_.x = _loc14_;
                              _loc43_.y = _loc34_;
                              §§pop().add(_loc43_);
                              if(_loc12_ == null)
                              {
                                 _loc12_ = ZPP_Collide.flowpoly.head.elt;
                              }
                              _loc17_ = _loc30_;
                              _loc22_ = _loc24_;
                              _loc21_ = !_loc21_;
                              _loc23_ = 2;
                           }
                        }
                        else
                        {
                           _loc17_ = _loc17_.next;
                           _loc22_++;
                           if(_loc17_ == null)
                           {
                              _loc17_ = param2.polygon.gverts.next;
                              _loc22_ = 0;
                           }
                           if(!Boolean(_loc5_[_loc22_]))
                           {
                              _loc18_ = _loc17_;
                              if(_loc12_ != null && _loc10_ * _loc10_ + _loc14_ * _loc14_ < Config.epsilon)
                              {
                                 break;
                              }
                              ZPP_Collide.flowpoly.add(_loc18_);
                              if(_loc12_ == null)
                              {
                                 _loc12_ = ZPP_Collide.flowpoly.head.elt;
                              }
                              _loc23_ = 1;
                           }
                           else
                           {
                              _loc18_ = ZPP_Collide.flowpoly.head.elt;
                              _loc19_ = _loc17_;
                              _loc27_ = _loc13_;
                              _loc28_ = _loc13_.next;
                              if(_loc28_ == null)
                              {
                                 _loc28_ = param1.polygon.gverts.next;
                              }
                              _loc10_ = -1;
                              _loc30_ = null;
                              _loc24_ = 0;
                              _loc25_ = 0;
                              _loc31_ = _loc28_;
                              _loc32_ = _loc28_;
                              do
                              {
                                 _loc33_ = _loc32_;
                                 _loc14_ = 0;
                                 _loc34_ = 0;
                                 _loc35_ = 0;
                                 _loc34_ = _loc27_.x - _loc18_.x;
                                 _loc35_ = _loc27_.y - _loc18_.y;
                                 _loc36_ = 0;
                                 _loc37_ = 0;
                                 _loc36_ = _loc33_.x - _loc27_.x;
                                 _loc37_ = _loc33_.y - _loc27_.y;
                                 _loc38_ = 0;
                                 _loc39_ = 0;
                                 _loc38_ = _loc19_.x - _loc18_.x;
                                 _loc39_ = _loc19_.y - _loc18_.y;
                                 _loc40_ = _loc37_ * _loc38_ - _loc36_ * _loc39_;
                                 if(_loc40_ * _loc40_ > Config.epsilon * Config.epsilon ? (_loc40_ = 1 / _loc40_, _loc41_ = (_loc39_ * _loc34_ - _loc38_ * _loc35_) * _loc40_, _loc41_ > Config.epsilon && _loc41_ < 1 - Config.epsilon ? (_loc42_ = (_loc37_ * _loc34_ - _loc36_ * _loc35_) * _loc40_, _loc42_ > Config.epsilon && _loc42_ < 1 - Config.epsilon ? (_loc14_ = _loc41_, true) : false) : false) : false)
                                 {
                                    if(_loc14_ >= _loc10_)
                                    {
                                       _loc30_ = _loc13_;
                                       _loc24_ = _loc11_;
                                       _loc25_++;
                                       if(_loc25_ == _loc23_)
                                       {
                                          _loc10_ = _loc14_;
                                          _loc32_ = _loc31_;
                                          break;
                                       }
                                       _loc10_ = _loc14_;
                                    }
                                 }
                                 _loc27_ = _loc33_;
                                 _loc13_ = _loc32_;
                                 _loc11_++;
                                 if(_loc11_ >= param1.polygon.edgeCnt)
                                 {
                                    _loc11_ = 0;
                                 }
                                 _loc32_ = _loc32_.next;
                                 if(_loc32_ == null)
                                 {
                                    _loc32_ = param1.polygon.gverts.next;
                                 }
                              }
                              while(false);
                              
                              while(_loc32_ != _loc31_)
                              {
                                 _loc33_ = _loc32_;
                                 _loc14_ = 0;
                                 _loc34_ = 0;
                                 _loc35_ = 0;
                                 _loc34_ = _loc27_.x - _loc18_.x;
                                 _loc35_ = _loc27_.y - _loc18_.y;
                                 _loc36_ = 0;
                                 _loc37_ = 0;
                                 _loc36_ = _loc33_.x - _loc27_.x;
                                 _loc37_ = _loc33_.y - _loc27_.y;
                                 _loc38_ = 0;
                                 _loc39_ = 0;
                                 _loc38_ = _loc19_.x - _loc18_.x;
                                 _loc39_ = _loc19_.y - _loc18_.y;
                                 _loc40_ = _loc37_ * _loc38_ - _loc36_ * _loc39_;
                                 if(_loc40_ * _loc40_ > Config.epsilon * Config.epsilon ? (_loc40_ = 1 / _loc40_, _loc41_ = (_loc39_ * _loc34_ - _loc38_ * _loc35_) * _loc40_, _loc41_ > Config.epsilon && _loc41_ < 1 - Config.epsilon ? (_loc42_ = (_loc37_ * _loc34_ - _loc36_ * _loc35_) * _loc40_, _loc42_ > Config.epsilon && _loc42_ < 1 - Config.epsilon ? (_loc14_ = _loc41_, true) : false) : false) : false)
                                 {
                                    if(_loc14_ >= _loc10_)
                                    {
                                       _loc30_ = _loc13_;
                                       _loc24_ = _loc11_;
                                       _loc25_++;
                                       if(_loc25_ == _loc23_)
                                       {
                                          _loc10_ = _loc14_;
                                          _loc32_ = _loc31_;
                                          break;
                                       }
                                       _loc10_ = _loc14_;
                                    }
                                 }
                                 _loc27_ = _loc33_;
                                 _loc13_ = _loc32_;
                                 _loc11_++;
                                 if(_loc11_ >= param1.polygon.edgeCnt)
                                 {
                                    _loc11_ = 0;
                                 }
                                 _loc32_ = _loc32_.next;
                                 if(_loc32_ == null)
                                 {
                                    _loc32_ = param1.polygon.gverts.next;
                                 }
                              }
                              if(_loc30_ == null)
                              {
                                 break;
                              }
                              _loc31_ = _loc30_;
                              _loc32_ = _loc30_.next;
                              if(_loc32_ == null)
                              {
                                 _loc32_ = param1.polygon.gverts.next;
                              }
                              _loc33_ = _loc32_;
                              _loc14_ = 0;
                              _loc34_ = 0;
                              _loc35_ = _loc10_;
                              _loc14_ = _loc31_.x + (_loc33_.x - _loc31_.x) * _loc35_;
                              _loc34_ = _loc31_.y + (_loc33_.y - _loc31_.y) * _loc35_;
                              if(_loc12_ != null && _loc35_ * _loc35_ + _loc36_ * _loc36_ < Config.epsilon)
                              {
                                 break;
                              }
                              _loc26_ = false;
                              §§push(ZPP_Collide.flowpoly);
                              if(ZPP_Vec2.zpp_pool == null)
                              {
                                 _loc43_ = new ZPP_Vec2();
                              }
                              else
                              {
                                 _loc43_ = ZPP_Vec2.zpp_pool;
                                 ZPP_Vec2.zpp_pool = _loc43_.next;
                                 _loc43_.next = null;
                              }
                              _loc43_.weak = false;
                              _loc43_._immutable = _loc26_;
                              _loc43_.x = _loc14_;
                              _loc43_.y = _loc34_;
                              §§pop().add(_loc43_);
                              if(_loc12_ == null)
                              {
                                 _loc12_ = ZPP_Collide.flowpoly.head.elt;
                              }
                              _loc13_ = _loc30_;
                              _loc11_ = _loc24_;
                              _loc21_ = !_loc21_;
                              _loc23_ = 2;
                           }
                        }
                     }
                     if(ZPP_Collide.flowpoly.head != null && ZPP_Collide.flowpoly.head.next != null && ZPP_Collide.flowpoly.head.next.next != null)
                     {
                        _loc10_ = 0;
                        _loc14_ = 0;
                        _loc34_ = 0;
                        _loc14_ = 0;
                        _loc34_ = 0;
                        _loc10_ = 0;
                        _loc44_ = ZPP_Collide.flowpoly.head;
                        _loc18_ = _loc44_.elt;
                        _loc44_ = _loc44_.next;
                        _loc19_ = _loc44_.elt;
                        _loc44_ = _loc44_.next;
                        while(_loc44_ != null)
                        {
                           _loc27_ = _loc44_.elt;
                           _loc10_ += _loc19_.x * (_loc27_.y - _loc18_.y);
                           _loc35_ = _loc27_.y * _loc19_.x - _loc27_.x * _loc19_.y;
                           _loc14_ += (_loc19_.x + _loc27_.x) * _loc35_;
                           _loc34_ += (_loc19_.y + _loc27_.y) * _loc35_;
                           _loc18_ = _loc19_;
                           _loc19_ = _loc27_;
                           _loc44_ = _loc44_.next;
                        }
                        _loc44_ = ZPP_Collide.flowpoly.head;
                        _loc27_ = _loc44_.elt;
                        _loc10_ += _loc19_.x * (_loc27_.y - _loc18_.y);
                        _loc35_ = _loc27_.y * _loc19_.x - _loc27_.x * _loc19_.y;
                        _loc14_ += (_loc19_.x + _loc27_.x) * _loc35_;
                        _loc34_ += (_loc19_.y + _loc27_.y) * _loc35_;
                        _loc18_ = _loc19_;
                        _loc19_ = _loc27_;
                        _loc44_ = _loc44_.next;
                        _loc28_ = _loc44_.elt;
                        _loc10_ += _loc19_.x * (_loc28_.y - _loc18_.y);
                        _loc35_ = _loc28_.y * _loc19_.x - _loc28_.x * _loc19_.y;
                        _loc14_ += (_loc19_.x + _loc28_.x) * _loc35_;
                        _loc34_ += (_loc19_.y + _loc28_.y) * _loc35_;
                        _loc10_ *= 0.5;
                        _loc35_ = 1 / (6 * _loc10_);
                        _loc36_ = _loc35_;
                        _loc14_ *= _loc36_;
                        _loc34_ *= _loc36_;
                        param3.overlap = -_loc10_;
                        param3.centroidx = _loc14_;
                        param3.centroidy = _loc34_;
                        null;
                        return true;
                     }
                     else
                     {
                        return false;
                     }
                  }
                  else
                  {
                     return false;
                  }
               }
               else
               {
                  return false;
               }
            }
            else
            {
               _loc4_ = [];
               _loc6_ = true;
               _loc9_ = null;
               _loc12_ = null;
               _loc10_ = -1e+100;
               _loc7_ = true;
               _loc13_ = param2.polygon.gverts.next;
               _loc11_ = 0;
               _loc8_ = param2.polygon.edges.head;
               while(_loc8_ != null)
               {
                  _loc45_ = _loc8_.elt;
                  _loc14_ = _loc45_.gnormx * param1.circle.worldCOMx + _loc45_.gnormy * param1.circle.worldCOMy;
                  if(_loc14_ > _loc45_.gprojection + param1.circle.radius)
                  {
                     _loc7_ = false;
                     break;
                  }
                  if(_loc14_ + param1.circle.radius > _loc45_.gprojection + Config.epsilon)
                  {
                     _loc6_ = false;
                     _loc4_[_loc11_] = true;
                  }
                  _loc14_ -= _loc45_.gprojection + param1.circle.radius;
                  if(_loc14_ > _loc10_)
                  {
                     _loc10_ = _loc14_;
                     _loc9_ = _loc45_;
                     _loc12_ = _loc13_;
                  }
                  _loc13_ = _loc13_.next;
                  _loc11_++;
                  _loc8_ = _loc8_.next;
               }
               if(_loc7_)
               {
                  if(_loc6_)
                  {
                     param3.overlap = param1.circle.area;
                     param3.centroidx = param1.circle.worldCOMx;
                     param3.centroidy = param1.circle.worldCOMy;
                     null;
                     return true;
                  }
                  else
                  {
                     _loc17_ = _loc12_;
                     _loc18_ = _loc12_.next == null ? param2.polygon.gverts.next : _loc12_.next;
                     _loc14_ = param1.circle.worldCOMy * _loc9_.gnormx - param1.circle.worldCOMx * _loc9_.gnormy;
                     if(_loc14_ <= _loc17_.y * _loc9_.gnormx - _loc17_.x * _loc9_.gnormy ? (_loc34_ = param1.circle.radius, _loc35_ = 0, _loc36_ = 0, _loc35_ = _loc17_.x - param1.circle.worldCOMx, _loc36_ = _loc17_.y - param1.circle.worldCOMy, _loc37_ = _loc35_ * _loc35_ + _loc36_ * _loc36_, _loc37_ <= _loc34_ * _loc34_) : (_loc14_ >= _loc18_.y * _loc9_.gnormx - _loc18_.x * _loc9_.gnormy ? (_loc34_ = param1.circle.radius, _loc35_ = 0, _loc36_ = 0, _loc35_ = _loc18_.x - param1.circle.worldCOMx, _loc36_ = _loc18_.y - param1.circle.worldCOMy, _loc37_ = _loc35_ * _loc35_ + _loc36_ * _loc36_, _loc37_ <= _loc34_ * _loc34_) : true))
                     {
                        _loc5_ = [];
                        _loc22_ = 0;
                        _loc21_ = true;
                        _loc19_ = null;
                        _loc23_ = 0;
                        _loc27_ = param2.polygon.gverts.next;
                        while(_loc27_ != null)
                        {
                           _loc28_ = _loc27_;
                           _loc35_ = 0;
                           _loc36_ = 0;
                           _loc35_ = _loc28_.x - param1.circle.worldCOMx;
                           _loc36_ = _loc28_.y - param1.circle.worldCOMy;
                           _loc34_ = _loc35_ * _loc35_ + _loc36_ * _loc36_;
                           if(!(_loc5_[_loc22_] = _loc34_ <= param1.circle.radius * param1.circle.radius))
                           {
                              _loc21_ = false;
                           }
                           else
                           {
                              _loc23_ = _loc22_;
                              _loc19_ = _loc27_;
                           }
                           _loc22_++;
                           _loc27_ = _loc27_.next;
                        }
                        if(_loc21_)
                        {
                           _loc15_ = param2.polygon;
                           if(_loc15_.zip_worldCOM)
                           {
                              if(_loc15_.body != null)
                              {
                                 _loc15_.zip_worldCOM = false;
                                 if(_loc15_.zip_localCOM)
                                 {
                                    _loc15_.zip_localCOM = false;
                                    if(_loc15_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                       _loc16_ = _loc15_.polygon;
                                       if(_loc16_.lverts.next == null)
                                       {
                                          Boot.lastError = new Error();
                                          throw "Error: An empty polygon has no meaningful localCOM";
                                       }
                                       if(_loc16_.lverts.next.next == null)
                                       {
                                          _loc16_.localCOMx = _loc16_.lverts.next.x;
                                          _loc16_.localCOMy = _loc16_.lverts.next.y;
                                          null;
                                       }
                                       else if(_loc16_.lverts.next.next.next == null)
                                       {
                                          _loc16_.localCOMx = _loc16_.lverts.next.x;
                                          _loc16_.localCOMy = _loc16_.lverts.next.y;
                                          _loc34_ = 1;
                                          _loc16_.localCOMx += _loc16_.lverts.next.next.x * _loc34_;
                                          _loc16_.localCOMy += _loc16_.lverts.next.next.y * _loc34_;
                                          _loc34_ = 0.5;
                                          _loc16_.localCOMx *= _loc34_;
                                          _loc16_.localCOMy *= _loc34_;
                                       }
                                       else
                                       {
                                          _loc16_.localCOMx = 0;
                                          _loc16_.localCOMy = 0;
                                          _loc34_ = 0;
                                          _loc27_ = _loc16_.lverts.next;
                                          _loc28_ = _loc27_;
                                          _loc27_ = _loc27_.next;
                                          _loc30_ = _loc27_;
                                          _loc27_ = _loc27_.next;
                                          while(_loc27_ != null)
                                          {
                                             _loc31_ = _loc27_;
                                             _loc34_ += _loc30_.x * (_loc31_.y - _loc28_.y);
                                             _loc35_ = _loc31_.y * _loc30_.x - _loc31_.x * _loc30_.y;
                                             _loc16_.localCOMx += (_loc30_.x + _loc31_.x) * _loc35_;
                                             _loc16_.localCOMy += (_loc30_.y + _loc31_.y) * _loc35_;
                                             _loc28_ = _loc30_;
                                             _loc30_ = _loc31_;
                                             _loc27_ = _loc27_.next;
                                          }
                                          _loc27_ = _loc16_.lverts.next;
                                          _loc31_ = _loc27_;
                                          _loc34_ += _loc30_.x * (_loc31_.y - _loc28_.y);
                                          _loc35_ = _loc31_.y * _loc30_.x - _loc31_.x * _loc30_.y;
                                          _loc16_.localCOMx += (_loc30_.x + _loc31_.x) * _loc35_;
                                          _loc16_.localCOMy += (_loc30_.y + _loc31_.y) * _loc35_;
                                          _loc28_ = _loc30_;
                                          _loc30_ = _loc31_;
                                          _loc27_ = _loc27_.next;
                                          _loc32_ = _loc27_;
                                          _loc34_ += _loc30_.x * (_loc32_.y - _loc28_.y);
                                          _loc35_ = _loc32_.y * _loc30_.x - _loc32_.x * _loc30_.y;
                                          _loc16_.localCOMx += (_loc30_.x + _loc32_.x) * _loc35_;
                                          _loc16_.localCOMy += (_loc30_.y + _loc32_.y) * _loc35_;
                                          _loc34_ = 1 / (3 * _loc34_);
                                          _loc35_ = _loc34_;
                                          _loc16_.localCOMx *= _loc35_;
                                          _loc16_.localCOMy *= _loc35_;
                                       }
                                    }
                                 }
                                 _loc20_ = _loc15_.body;
                                 if(_loc20_.zip_axis)
                                 {
                                    _loc20_.zip_axis = false;
                                    _loc20_.axisx = Math.sin(_loc20_.rot);
                                    _loc20_.axisy = Math.cos(_loc20_.rot);
                                    null;
                                 }
                                 _loc15_.worldCOMx = _loc15_.body.posx + (_loc15_.body.axisy * _loc15_.localCOMx - _loc15_.body.axisx * _loc15_.localCOMy);
                                 _loc15_.worldCOMy = _loc15_.body.posy + (_loc15_.localCOMx * _loc15_.body.axisx + _loc15_.localCOMy * _loc15_.body.axisy);
                              }
                           }
                           param3.overlap = param2.polygon.area;
                           param3.centroidx = param2.polygon.worldCOMx;
                           param3.centroidy = param2.polygon.worldCOMy;
                           null;
                           return true;
                        }
                        else
                        {
                           while(ZPP_Collide.flowpoly.head != null)
                           {
                              _loc27_ = ZPP_Collide.flowpoly.pop_unsafe();
                              if(!_loc27_._inuse)
                              {
                                 _loc28_ = _loc27_;
                                 if(_loc28_.outer != null)
                                 {
                                    _loc28_.outer.zpp_inner = null;
                                    _loc28_.outer = null;
                                 }
                                 _loc28_._isimmutable = null;
                                 _loc28_._validate = null;
                                 _loc28_._invalidate = null;
                                 _loc28_.next = ZPP_Vec2.zpp_pool;
                                 ZPP_Vec2.zpp_pool = _loc28_;
                              }
                           }
                           ZPP_Collide.flowsegs.clear();
                           _loc27_ = null;
                           _loc24_ = 1;
                           if(_loc19_ == null)
                           {
                              _loc19_ = param2.polygon.gverts.next;
                              _loc24_ = 2;
                           }
                           else
                           {
                              ZPP_Collide.flowpoly.add(_loc27_ = _loc19_);
                           }
                           while(_loc24_ != 0)
                           {
                              if(_loc24_ == 1)
                              {
                                 _loc19_ = _loc19_.next;
                                 if(_loc19_ == null)
                                 {
                                    _loc19_ = param2.polygon.gverts.next;
                                 }
                                 _loc23_++;
                                 if(_loc23_ >= param2.polygon.edgeCnt)
                                 {
                                    _loc23_ = 0;
                                 }
                                 if(Boolean(_loc5_[_loc23_]))
                                 {
                                    _loc34_ = 0;
                                    _loc35_ = 0;
                                    _loc34_ = _loc27_.x - _loc19_.x;
                                    _loc35_ = _loc27_.y - _loc19_.y;
                                    if(_loc34_ * _loc34_ + _loc35_ * _loc35_ < Config.epsilon)
                                    {
                                       break;
                                    }
                                    ZPP_Collide.flowpoly.add(_loc19_);
                                 }
                                 else
                                 {
                                    _loc28_ = ZPP_Collide.flowpoly.head.elt;
                                    _loc30_ = _loc19_;
                                    _loc35_ = 0;
                                    _loc36_ = 0;
                                    _loc35_ = _loc30_.x - _loc28_.x;
                                    _loc36_ = _loc30_.y - _loc28_.y;
                                    _loc37_ = 0;
                                    _loc38_ = 0;
                                    _loc37_ = _loc28_.x - param1.circle.worldCOMx;
                                    _loc38_ = _loc28_.y - param1.circle.worldCOMy;
                                    _loc39_ = _loc35_ * _loc35_ + _loc36_ * _loc36_;
                                    _loc40_ = 2 * (_loc37_ * _loc35_ + _loc38_ * _loc36_);
                                    _loc41_ = _loc37_ * _loc37_ + _loc38_ * _loc38_ - param1.circle.radius * param1.circle.radius;
                                    _loc42_ = Math.sqrt(_loc40_ * _loc40_ - 4 * _loc39_ * _loc41_);
                                    _loc39_ = 1 / (2 * _loc39_);
                                    _loc46_ = (-_loc40_ - _loc42_) * _loc39_;
                                    _loc34_ = _loc46_ < Config.epsilon ? (-_loc40_ + _loc42_) * _loc39_ : _loc46_;
                                    _loc35_ = 0;
                                    _loc36_ = 0;
                                    _loc37_ = _loc34_;
                                    _loc35_ = _loc28_.x + (_loc30_.x - _loc28_.x) * _loc37_;
                                    _loc36_ = _loc28_.y + (_loc30_.y - _loc28_.y) * _loc37_;
                                    _loc37_ = 0;
                                    _loc38_ = 0;
                                    _loc37_ = _loc27_.x - _loc35_;
                                    _loc38_ = _loc27_.y - _loc36_;
                                    if(_loc37_ * _loc37_ + _loc38_ * _loc38_ < Config.epsilon)
                                    {
                                       break;
                                    }
                                    _loc26_ = false;
                                    §§push(ZPP_Collide.flowpoly);
                                    if(ZPP_Vec2.zpp_pool == null)
                                    {
                                       _loc31_ = new ZPP_Vec2();
                                    }
                                    else
                                    {
                                       _loc31_ = ZPP_Vec2.zpp_pool;
                                       ZPP_Vec2.zpp_pool = _loc31_.next;
                                       _loc31_.next = null;
                                    }
                                    _loc31_.weak = false;
                                    _loc31_._immutable = _loc26_;
                                    _loc31_.x = _loc35_;
                                    _loc31_.y = _loc36_;
                                    §§pop().add(_loc31_);
                                    _loc24_ = 2;
                                 }
                              }
                              else if(_loc24_ == 2)
                              {
                                 _loc28_ = _loc19_.next;
                                 if(_loc28_ == null)
                                 {
                                    _loc28_ = param2.polygon.gverts.next;
                                 }
                                 _loc30_ = _loc19_;
                                 _loc24_ = 0;
                                 _loc31_ = _loc28_;
                                 _loc32_ = _loc28_;
                                 do
                                 {
                                    _loc33_ = _loc32_;
                                    _loc25_ = _loc23_ + 1;
                                    if(_loc25_ == param2.polygon.edgeCnt)
                                    {
                                       _loc25_ = 0;
                                    }
                                    if(Boolean(_loc4_[_loc23_]))
                                    {
                                       if(Boolean(_loc5_[_loc25_]))
                                       {
                                          _loc35_ = 0;
                                          _loc36_ = 0;
                                          _loc35_ = _loc33_.x - _loc30_.x;
                                          _loc36_ = _loc33_.y - _loc30_.y;
                                          _loc37_ = 0;
                                          _loc38_ = 0;
                                          _loc37_ = _loc30_.x - param1.circle.worldCOMx;
                                          _loc38_ = _loc30_.y - param1.circle.worldCOMy;
                                          _loc39_ = _loc35_ * _loc35_ + _loc36_ * _loc36_;
                                          _loc40_ = 2 * (_loc37_ * _loc35_ + _loc38_ * _loc36_);
                                          _loc41_ = _loc37_ * _loc37_ + _loc38_ * _loc38_ - param1.circle.radius * param1.circle.radius;
                                          _loc42_ = Math.sqrt(_loc40_ * _loc40_ - 4 * _loc39_ * _loc41_);
                                          _loc39_ = 1 / (2 * _loc39_);
                                          _loc46_ = (-_loc40_ - _loc42_) * _loc39_;
                                          _loc34_ = _loc46_ < Config.epsilon ? (-_loc40_ + _loc42_) * _loc39_ : _loc46_;
                                          _loc35_ = 0;
                                          _loc36_ = 0;
                                          _loc37_ = _loc34_;
                                          _loc35_ = _loc30_.x + (_loc33_.x - _loc30_.x) * _loc37_;
                                          _loc36_ = _loc30_.y + (_loc33_.y - _loc30_.y) * _loc37_;
                                          _loc37_ = 0;
                                          _loc38_ = 0;
                                          _loc37_ = _loc27_.x - _loc35_;
                                          _loc38_ = _loc27_.y - _loc36_;
                                          if(_loc37_ * _loc37_ + _loc38_ * _loc38_ < Config.epsilon)
                                          {
                                             _loc24_ = 0;
                                             _loc32_ = _loc31_;
                                             break;
                                          }
                                          _loc26_ = false;
                                          if(ZPP_Vec2.zpp_pool == null)
                                          {
                                             _loc47_ = new ZPP_Vec2();
                                          }
                                          else
                                          {
                                             _loc47_ = ZPP_Vec2.zpp_pool;
                                             ZPP_Vec2.zpp_pool = _loc47_.next;
                                             _loc47_.next = null;
                                          }
                                          _loc47_.weak = false;
                                          _loc47_._immutable = _loc26_;
                                          _loc47_.x = _loc35_;
                                          _loc47_.y = _loc36_;
                                          _loc43_ = _loc47_;
                                          ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                          ZPP_Collide.flowsegs.add(_loc43_);
                                          ZPP_Collide.flowpoly.add(_loc43_);
                                          _loc24_ = 1;
                                          _loc32_ = _loc31_;
                                          break;
                                       }
                                       _loc34_ = 0;
                                       _loc35_ = 0;
                                       _loc36_ = 0;
                                       _loc37_ = 0;
                                       _loc36_ = _loc33_.x - _loc30_.x;
                                       _loc37_ = _loc33_.y - _loc30_.y;
                                       _loc38_ = 0;
                                       _loc39_ = 0;
                                       _loc38_ = _loc30_.x - param1.circle.worldCOMx;
                                       _loc39_ = _loc30_.y - param1.circle.worldCOMy;
                                       _loc40_ = _loc36_ * _loc36_ + _loc37_ * _loc37_;
                                       _loc41_ = 2 * (_loc38_ * _loc36_ + _loc39_ * _loc37_);
                                       _loc42_ = _loc38_ * _loc38_ + _loc39_ * _loc39_ - param1.circle.radius * param1.circle.radius;
                                       _loc46_ = _loc41_ * _loc41_ - 4 * _loc40_ * _loc42_;
                                       if(_loc46_ * _loc46_ < Config.epsilon)
                                       {
                                          if(_loc46_ < 0)
                                          {
                                             _loc34_ = 10;
                                          }
                                          else
                                          {
                                             _loc34_ = _loc35_ = -_loc41_ / (2 * _loc40_);
                                          }
                                          §§push(false);
                                       }
                                       else
                                       {
                                          _loc46_ = Math.sqrt(_loc46_);
                                          _loc40_ = 1 / (2 * _loc40_);
                                          _loc34_ = (-_loc41_ - _loc46_) * _loc40_;
                                          _loc35_ = (-_loc41_ + _loc46_) * _loc40_;
                                          §§push(true);
                                       }
                                       _loc26_ = §§pop();
                                       if(_loc34_ < 1 - Config.epsilon && _loc35_ > Config.epsilon)
                                       {
                                          _loc36_ = 0;
                                          _loc37_ = 0;
                                          _loc38_ = _loc34_;
                                          _loc36_ = _loc30_.x + (_loc33_.x - _loc30_.x) * _loc38_;
                                          _loc37_ = _loc30_.y + (_loc33_.y - _loc30_.y) * _loc38_;
                                          if(_loc27_ != null && _loc38_ * _loc38_ + _loc39_ * _loc39_ < Config.epsilon)
                                          {
                                             _loc24_ = 0;
                                             _loc32_ = _loc31_;
                                             break;
                                          }
                                          _loc29_ = false;
                                          if(ZPP_Vec2.zpp_pool == null)
                                          {
                                             _loc47_ = new ZPP_Vec2();
                                          }
                                          else
                                          {
                                             _loc47_ = ZPP_Vec2.zpp_pool;
                                             ZPP_Vec2.zpp_pool = _loc47_.next;
                                             _loc47_.next = null;
                                          }
                                          _loc47_.weak = false;
                                          _loc47_._immutable = _loc29_;
                                          _loc47_.x = _loc36_;
                                          _loc47_.y = _loc37_;
                                          _loc43_ = _loc47_;
                                          if(ZPP_Collide.flowpoly.head != null)
                                          {
                                             ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                             ZPP_Collide.flowsegs.add(_loc43_);
                                          }
                                          ZPP_Collide.flowpoly.add(_loc43_);
                                          if(_loc27_ == null)
                                          {
                                             _loc27_ = ZPP_Collide.flowpoly.head.elt;
                                          }
                                          if(_loc26_)
                                          {
                                             _loc38_ = 0;
                                             _loc39_ = 0;
                                             _loc40_ = _loc35_;
                                             _loc38_ = _loc30_.x + (_loc33_.x - _loc30_.x) * _loc40_;
                                             _loc39_ = _loc30_.y + (_loc33_.y - _loc30_.y) * _loc40_;
                                             _loc29_ = false;
                                             §§push(ZPP_Collide.flowpoly);
                                             if(ZPP_Vec2.zpp_pool == null)
                                             {
                                                _loc47_ = new ZPP_Vec2();
                                             }
                                             else
                                             {
                                                _loc47_ = ZPP_Vec2.zpp_pool;
                                                ZPP_Vec2.zpp_pool = _loc47_.next;
                                                _loc47_.next = null;
                                             }
                                             _loc47_.weak = false;
                                             _loc47_._immutable = _loc29_;
                                             _loc47_.x = _loc38_;
                                             _loc47_.y = _loc39_;
                                             §§pop().add(_loc47_);
                                          }
                                       }
                                    }
                                    _loc30_ = _loc33_;
                                    _loc19_ = _loc32_;
                                    _loc23_ = _loc25_;
                                    _loc32_ = _loc32_.next;
                                    if(_loc32_ == null)
                                    {
                                       _loc32_ = param2.polygon.gverts.next;
                                    }
                                 }
                                 while(false);
                                 
                                 while(_loc32_ != _loc31_)
                                 {
                                    _loc33_ = _loc32_;
                                    _loc25_ = _loc23_ + 1;
                                    if(_loc25_ == param2.polygon.edgeCnt)
                                    {
                                       _loc25_ = 0;
                                    }
                                    if(Boolean(_loc4_[_loc23_]))
                                    {
                                       if(Boolean(_loc5_[_loc25_]))
                                       {
                                          _loc35_ = 0;
                                          _loc36_ = 0;
                                          _loc35_ = _loc33_.x - _loc30_.x;
                                          _loc36_ = _loc33_.y - _loc30_.y;
                                          _loc37_ = 0;
                                          _loc38_ = 0;
                                          _loc37_ = _loc30_.x - param1.circle.worldCOMx;
                                          _loc38_ = _loc30_.y - param1.circle.worldCOMy;
                                          _loc39_ = _loc35_ * _loc35_ + _loc36_ * _loc36_;
                                          _loc40_ = 2 * (_loc37_ * _loc35_ + _loc38_ * _loc36_);
                                          _loc41_ = _loc37_ * _loc37_ + _loc38_ * _loc38_ - param1.circle.radius * param1.circle.radius;
                                          _loc42_ = Math.sqrt(_loc40_ * _loc40_ - 4 * _loc39_ * _loc41_);
                                          _loc39_ = 1 / (2 * _loc39_);
                                          _loc46_ = (-_loc40_ - _loc42_) * _loc39_;
                                          _loc34_ = _loc46_ < Config.epsilon ? (-_loc40_ + _loc42_) * _loc39_ : _loc46_;
                                          _loc35_ = 0;
                                          _loc36_ = 0;
                                          _loc37_ = _loc34_;
                                          _loc35_ = _loc30_.x + (_loc33_.x - _loc30_.x) * _loc37_;
                                          _loc36_ = _loc30_.y + (_loc33_.y - _loc30_.y) * _loc37_;
                                          _loc37_ = 0;
                                          _loc38_ = 0;
                                          _loc37_ = _loc27_.x - _loc35_;
                                          _loc38_ = _loc27_.y - _loc36_;
                                          if(_loc37_ * _loc37_ + _loc38_ * _loc38_ < Config.epsilon)
                                          {
                                             _loc24_ = 0;
                                             _loc32_ = _loc31_;
                                             break;
                                          }
                                          _loc26_ = false;
                                          if(ZPP_Vec2.zpp_pool == null)
                                          {
                                             _loc47_ = new ZPP_Vec2();
                                          }
                                          else
                                          {
                                             _loc47_ = ZPP_Vec2.zpp_pool;
                                             ZPP_Vec2.zpp_pool = _loc47_.next;
                                             _loc47_.next = null;
                                          }
                                          _loc47_.weak = false;
                                          _loc47_._immutable = _loc26_;
                                          _loc47_.x = _loc35_;
                                          _loc47_.y = _loc36_;
                                          _loc43_ = _loc47_;
                                          ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                          ZPP_Collide.flowsegs.add(_loc43_);
                                          ZPP_Collide.flowpoly.add(_loc43_);
                                          _loc24_ = 1;
                                          _loc32_ = _loc31_;
                                          break;
                                       }
                                       _loc34_ = 0;
                                       _loc35_ = 0;
                                       _loc36_ = 0;
                                       _loc37_ = 0;
                                       _loc36_ = _loc33_.x - _loc30_.x;
                                       _loc37_ = _loc33_.y - _loc30_.y;
                                       _loc38_ = 0;
                                       _loc39_ = 0;
                                       _loc38_ = _loc30_.x - param1.circle.worldCOMx;
                                       _loc39_ = _loc30_.y - param1.circle.worldCOMy;
                                       _loc40_ = _loc36_ * _loc36_ + _loc37_ * _loc37_;
                                       _loc41_ = 2 * (_loc38_ * _loc36_ + _loc39_ * _loc37_);
                                       _loc42_ = _loc38_ * _loc38_ + _loc39_ * _loc39_ - param1.circle.radius * param1.circle.radius;
                                       _loc46_ = _loc41_ * _loc41_ - 4 * _loc40_ * _loc42_;
                                       if(_loc46_ * _loc46_ < Config.epsilon)
                                       {
                                          if(_loc46_ < 0)
                                          {
                                             _loc34_ = 10;
                                          }
                                          else
                                          {
                                             _loc34_ = _loc35_ = -_loc41_ / (2 * _loc40_);
                                          }
                                          §§push(false);
                                       }
                                       else
                                       {
                                          _loc46_ = Math.sqrt(_loc46_);
                                          _loc40_ = 1 / (2 * _loc40_);
                                          _loc34_ = (-_loc41_ - _loc46_) * _loc40_;
                                          _loc35_ = (-_loc41_ + _loc46_) * _loc40_;
                                          §§push(true);
                                       }
                                       _loc26_ = §§pop();
                                       if(_loc34_ < 1 - Config.epsilon && _loc35_ > Config.epsilon)
                                       {
                                          _loc36_ = 0;
                                          _loc37_ = 0;
                                          _loc38_ = _loc34_;
                                          _loc36_ = _loc30_.x + (_loc33_.x - _loc30_.x) * _loc38_;
                                          _loc37_ = _loc30_.y + (_loc33_.y - _loc30_.y) * _loc38_;
                                          if(_loc27_ != null && _loc38_ * _loc38_ + _loc39_ * _loc39_ < Config.epsilon)
                                          {
                                             _loc24_ = 0;
                                             _loc32_ = _loc31_;
                                             break;
                                          }
                                          _loc29_ = false;
                                          if(ZPP_Vec2.zpp_pool == null)
                                          {
                                             _loc47_ = new ZPP_Vec2();
                                          }
                                          else
                                          {
                                             _loc47_ = ZPP_Vec2.zpp_pool;
                                             ZPP_Vec2.zpp_pool = _loc47_.next;
                                             _loc47_.next = null;
                                          }
                                          _loc47_.weak = false;
                                          _loc47_._immutable = _loc29_;
                                          _loc47_.x = _loc36_;
                                          _loc47_.y = _loc37_;
                                          _loc43_ = _loc47_;
                                          if(ZPP_Collide.flowpoly.head != null)
                                          {
                                             ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                             ZPP_Collide.flowsegs.add(_loc43_);
                                          }
                                          ZPP_Collide.flowpoly.add(_loc43_);
                                          if(_loc27_ == null)
                                          {
                                             _loc27_ = ZPP_Collide.flowpoly.head.elt;
                                          }
                                          if(_loc26_)
                                          {
                                             _loc38_ = 0;
                                             _loc39_ = 0;
                                             _loc40_ = _loc35_;
                                             _loc38_ = _loc30_.x + (_loc33_.x - _loc30_.x) * _loc40_;
                                             _loc39_ = _loc30_.y + (_loc33_.y - _loc30_.y) * _loc40_;
                                             _loc29_ = false;
                                             §§push(ZPP_Collide.flowpoly);
                                             if(ZPP_Vec2.zpp_pool == null)
                                             {
                                                _loc47_ = new ZPP_Vec2();
                                             }
                                             else
                                             {
                                                _loc47_ = ZPP_Vec2.zpp_pool;
                                                ZPP_Vec2.zpp_pool = _loc47_.next;
                                                _loc47_.next = null;
                                             }
                                             _loc47_.weak = false;
                                             _loc47_._immutable = _loc29_;
                                             _loc47_.x = _loc38_;
                                             _loc47_.y = _loc39_;
                                             §§pop().add(_loc47_);
                                          }
                                       }
                                    }
                                    _loc30_ = _loc33_;
                                    _loc19_ = _loc32_;
                                    _loc23_ = _loc25_;
                                    _loc32_ = _loc32_.next;
                                    if(_loc32_ == null)
                                    {
                                       _loc32_ = param2.polygon.gverts.next;
                                    }
                                 }
                              }
                           }
                           if(ZPP_Collide.flowpoly.head == null)
                           {
                              return false;
                           }
                           else if(ZPP_Collide.flowpoly.head.next == null)
                           {
                              _loc26_ = true;
                              _loc8_ = param2.polygon.edges.head;
                              while(_loc8_ != null)
                              {
                                 _loc45_ = _loc8_.elt;
                                 _loc34_ = _loc45_.gnormx * param1.circle.worldCOMx + _loc45_.gnormy * param1.circle.worldCOMy;
                                 if(_loc34_ > _loc45_.gprojection)
                                 {
                                    _loc26_ = false;
                                    break;
                                 }
                                 _loc8_ = _loc8_.next;
                              }
                              return _loc26_ ? (param3.overlap = param1.circle.area, param3.centroidx = param1.circle.worldCOMx, param3.centroidy = param1.circle.worldCOMy, null, true) : false;
                           }
                           else
                           {
                              _loc34_ = 0;
                              _loc35_ = 0;
                              _loc36_ = 0;
                              if(ZPP_Collide.flowpoly.head.next.next != null)
                              {
                                 _loc37_ = 0;
                                 _loc38_ = 0;
                                 _loc39_ = 0;
                                 _loc38_ = 0;
                                 _loc39_ = 0;
                                 _loc37_ = 0;
                                 _loc44_ = ZPP_Collide.flowpoly.head;
                                 _loc28_ = _loc44_.elt;
                                 _loc44_ = _loc44_.next;
                                 _loc30_ = _loc44_.elt;
                                 _loc44_ = _loc44_.next;
                                 while(_loc44_ != null)
                                 {
                                    _loc31_ = _loc44_.elt;
                                    _loc37_ += _loc30_.x * (_loc31_.y - _loc28_.y);
                                    _loc40_ = _loc31_.y * _loc30_.x - _loc31_.x * _loc30_.y;
                                    _loc38_ += (_loc30_.x + _loc31_.x) * _loc40_;
                                    _loc39_ += (_loc30_.y + _loc31_.y) * _loc40_;
                                    _loc28_ = _loc30_;
                                    _loc30_ = _loc31_;
                                    _loc44_ = _loc44_.next;
                                 }
                                 _loc44_ = ZPP_Collide.flowpoly.head;
                                 _loc31_ = _loc44_.elt;
                                 _loc37_ += _loc30_.x * (_loc31_.y - _loc28_.y);
                                 _loc40_ = _loc31_.y * _loc30_.x - _loc31_.x * _loc30_.y;
                                 _loc38_ += (_loc30_.x + _loc31_.x) * _loc40_;
                                 _loc39_ += (_loc30_.y + _loc31_.y) * _loc40_;
                                 _loc28_ = _loc30_;
                                 _loc30_ = _loc31_;
                                 _loc44_ = _loc44_.next;
                                 _loc32_ = _loc44_.elt;
                                 _loc37_ += _loc30_.x * (_loc32_.y - _loc28_.y);
                                 _loc40_ = _loc32_.y * _loc30_.x - _loc32_.x * _loc30_.y;
                                 _loc38_ += (_loc30_.x + _loc32_.x) * _loc40_;
                                 _loc39_ += (_loc30_.y + _loc32_.y) * _loc40_;
                                 _loc37_ *= 0.5;
                                 _loc40_ = 1 / (6 * _loc37_);
                                 _loc41_ = _loc40_;
                                 _loc38_ *= _loc41_;
                                 _loc39_ *= _loc41_;
                                 _loc40_ = -_loc37_;
                                 _loc34_ += _loc38_ * _loc40_;
                                 _loc35_ += _loc39_ * _loc40_;
                                 _loc36_ -= _loc37_;
                              }
                              else
                              {
                                 ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                 ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.next.elt);
                              }
                              while(ZPP_Collide.flowsegs.head != null)
                              {
                                 _loc28_ = ZPP_Collide.flowsegs.pop_unsafe();
                                 _loc30_ = ZPP_Collide.flowsegs.pop_unsafe();
                                 _loc37_ = 0;
                                 _loc38_ = 0;
                                 _loc37_ = _loc30_.x - _loc28_.x;
                                 _loc38_ = _loc30_.y - _loc28_.y;
                                 _loc39_ = 0;
                                 _loc40_ = 0;
                                 _loc39_ = _loc37_;
                                 _loc40_ = _loc38_;
                                 _loc41_ = _loc39_ * _loc39_ + _loc40_ * _loc40_;
                                 sf32(_loc41_,0);
                                 si32(1597463007 - (li32(0) >> 1),0);
                                 _loc46_ = lf32(0);
                                 _loc42_ = _loc46_ * (1.5 - 0.5 * _loc41_ * _loc46_ * _loc46_);
                                 _loc46_ = _loc42_;
                                 _loc39_ *= _loc46_;
                                 _loc40_ *= _loc46_;
                                 _loc41_ = _loc39_;
                                 _loc39_ = -_loc40_;
                                 _loc40_ = _loc41_;
                                 _loc41_ = 0;
                                 _loc42_ = 0;
                                 _loc41_ = _loc28_.x + _loc30_.x;
                                 _loc42_ = _loc28_.y + _loc30_.y;
                                 _loc46_ = 0.5;
                                 _loc41_ *= _loc46_;
                                 _loc42_ *= _loc46_;
                                 _loc46_ = 1;
                                 _loc41_ -= param1.circle.worldCOMx * _loc46_;
                                 _loc42_ -= param1.circle.worldCOMy * _loc46_;
                                 _loc46_ = _loc39_ * _loc41_ + _loc40_ * _loc42_;
                                 _loc48_ = 0;
                                 _loc49_ = 0;
                                 _loc50_ = _loc46_;
                                 _loc51_ = _loc50_ / param1.circle.radius;
                                 _loc52_ = Math.sqrt(1 - _loc51_ * _loc51_);
                                 _loc53_ = Math.acos(_loc51_);
                                 _loc48_ = param1.circle.radius * (param1.circle.radius * _loc53_ - _loc50_ * _loc52_);
                                 _loc49_ = 2 / 3 * param1.circle.radius * _loc52_ * _loc52_ * _loc52_ / (_loc53_ - _loc51_ * _loc52_);
                                 _loc41_ = param1.circle.worldCOMx;
                                 _loc42_ = param1.circle.worldCOMy;
                                 _loc50_ = _loc49_;
                                 _loc41_ += _loc39_ * _loc50_;
                                 _loc42_ += _loc40_ * _loc50_;
                                 _loc50_ = _loc48_;
                                 _loc34_ += _loc41_ * _loc50_;
                                 _loc35_ += _loc42_ * _loc50_;
                                 _loc36_ += _loc48_;
                              }
                              _loc37_ = 1 / _loc36_;
                              _loc34_ *= _loc37_;
                              _loc35_ *= _loc37_;
                              param3.overlap = _loc36_;
                              param3.centroidx = _loc34_;
                              param3.centroidy = _loc35_;
                              null;
                              return true;
                           }
                        }
                     }
                     else
                     {
                        return false;
                     }
                  }
               }
               else
               {
                  return false;
               }
            }
         }
         _loc54_ = param1.circle;
         _loc55_ = param2.circle;
         _loc10_ = 0;
         _loc14_ = 0;
         _loc10_ = _loc55_.worldCOMx - _loc54_.worldCOMx;
         _loc14_ = _loc55_.worldCOMy - _loc54_.worldCOMy;
         _loc34_ = _loc54_.radius + _loc55_.radius;
         _loc35_ = _loc10_ * _loc10_ + _loc14_ * _loc14_;
         if(_loc35_ > _loc34_ * _loc34_)
         {
            return false;
         }
         else if(_loc35_ < Config.epsilon * Config.epsilon)
         {
            if(_loc54_.radius < _loc55_.radius)
            {
               param3.overlap = _loc54_.area;
               param3.centroidx = _loc54_.worldCOMx;
               param3.centroidy = _loc54_.worldCOMy;
               null;
            }
            else
            {
               param3.overlap = _loc55_.area;
               param3.centroidx = _loc55_.worldCOMx;
               param3.centroidy = _loc55_.worldCOMy;
               null;
            }
            return true;
         }
         else
         {
            _loc36_ = Math.sqrt(_loc35_);
            _loc37_ = 1 / _loc36_;
            _loc38_ = 0.5 * (_loc36_ - (_loc55_.radius * _loc55_.radius - _loc54_.radius * _loc54_.radius) * _loc37_);
            if(_loc38_ <= -_loc54_.radius)
            {
               param3.overlap = _loc54_.area;
               param3.centroidx = _loc54_.worldCOMx;
               param3.centroidy = _loc54_.worldCOMy;
               null;
            }
            else
            {
               _loc39_ = _loc36_ - _loc38_;
               if(_loc39_ <= -_loc55_.radius)
               {
                  param3.overlap = _loc55_.area;
                  param3.centroidx = _loc55_.worldCOMx;
                  param3.centroidy = _loc55_.worldCOMy;
                  null;
               }
               else
               {
                  _loc40_ = 0;
                  _loc41_ = 0;
                  _loc42_ = 0;
                  _loc46_ = 0;
                  _loc48_ = _loc38_;
                  _loc49_ = _loc48_ / _loc54_.radius;
                  _loc50_ = Math.sqrt(1 - _loc49_ * _loc49_);
                  _loc51_ = Math.acos(_loc49_);
                  _loc40_ = _loc54_.radius * (_loc54_.radius * _loc51_ - _loc48_ * _loc50_);
                  _loc41_ = 2 / 3 * _loc54_.radius * _loc50_ * _loc50_ * _loc50_ / (_loc51_ - _loc49_ * _loc50_);
                  _loc48_ = _loc39_;
                  _loc49_ = _loc48_ / _loc55_.radius;
                  _loc50_ = Math.sqrt(1 - _loc49_ * _loc49_);
                  _loc51_ = Math.acos(_loc49_);
                  _loc42_ = _loc55_.radius * (_loc55_.radius * _loc51_ - _loc48_ * _loc50_);
                  _loc46_ = 2 / 3 * _loc55_.radius * _loc50_ * _loc50_ * _loc50_ / (_loc51_ - _loc49_ * _loc50_);
                  _loc48_ = _loc40_ + _loc42_;
                  _loc49_ = (_loc41_ * _loc40_ + (_loc36_ - _loc46_) * _loc42_) / _loc48_ * _loc37_;
                  param3.overlap = _loc48_;
                  param3.centroidx = _loc54_.worldCOMx + _loc10_ * _loc49_;
                  param3.centroidy = _loc54_.worldCOMy + _loc14_ * _loc49_;
                  null;
               }
            }
            return true;
         }
      }
   }
}

import zpp_nape.util.ZNPList_ZPP_Vec2;

