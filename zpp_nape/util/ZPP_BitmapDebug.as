package zpp_nape.util
{
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import nape.dynamics.Arbiter;
   import nape.dynamics.ArbiterIterator;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.Contact;
   import nape.dynamics.ContactList;
   import nape.dynamics.FluidArbiter;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import nape.space.Space;
   import nape.util.BitmapDebug;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.dynamics.ZPP_SpaceArbiterList;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_Space;
   
   public class ZPP_BitmapDebug extends ZPP_Debug
   {
       
      
      public var transp:Boolean;
      
      public var shapeList:ShapeList;
      
      public var rect:Rectangle;
      
      public var peny:int;
      
      public var penx:int;
      
      public var outer_zn:BitmapDebug;
      
      public var filledXs:Array;
      
      public var filledVertices:Array;
      
      public var compoundstack:ZNPList_ZPP_Compound;
      
      public var colour:int;
      
      public var bytes:ByteArray;
      
      public var bodyList:BodyList;
      
      public var bitmap:Bitmap;
      
      public var bit:BitmapData;
      
      public var bgbytes:ByteArray;
      
      public function ZPP_BitmapDebug(param1:int = 0, param2:int = 0, param3:int = 0, param4:Boolean = false)
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(Boot.skip_constructor)
         {
            return;
         }
         bodyList = null;
         shapeList = null;
         compoundstack = null;
         colour = 0;
         peny = 0;
         penx = 0;
         transp = false;
         bgbytes = null;
         bytes = null;
         bit = null;
         rect = null;
         bitmap = null;
         outer_zn = null;
         super(param1,param2);
         transp = param4;
         filledVertices = [];
         filledXs = [];
         bytes = new ByteArray();
         bytes.length = param1 * param2 << 2;
         bytes.endian = Endian.LITTLE_ENDIAN;
         bit = new BitmapData(param1,param2,param4,param4 ? 0 : param3);
         rect = bit.rect;
         bgbytes = new ByteArray();
         bgbytes.length = bytes.length;
         bgbytes.endian = Endian.LITTLE_ENDIAN;
         setbg(param3);
         if(param4)
         {
            ApplicationDomain.currentDomain.domainMemory = bgbytes;
            _loc5_ = 0;
            _loc6_ = bytes.length >> 3;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               sf64(0,_loc7_ << 3);
            }
            ApplicationDomain.currentDomain.domainMemory = bytes;
         }
         bitmap = new Bitmap(bit,PixelSnapping.NEVER,false);
         isbmp = true;
         d_bmp = this;
      }
      
      public function setpixel(param1:int, param2:int, param3:int) : void
      {
         if(param1 >= 0 && param1 < width && param2 >= 0 && param2 < height)
         {
            si32(param3,param2 * width + param1 << 2);
         }
      }
      
      public function setpix(param1:int, param2:int) : void
      {
         si32(param2,param1 << 2);
      }
      
      public function setbg(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         sup_setbg(param1);
         if(!transp)
         {
            bgbytes.position = 0;
            ApplicationDomain.currentDomain.domainMemory = bgbytes;
            _loc2_ = 0;
            _loc3_ = bytes.length >> 2;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = _loc2_++;
               si32(param1,_loc4_ << 2);
            }
            ApplicationDomain.currentDomain.domainMemory = bytes;
         }
      }
      
      public function prepare() : void
      {
         ApplicationDomain.currentDomain.domainMemory = bytes;
      }
      
      public function flush() : void
      {
         bit.lock();
         bytes.position = 0;
         bit.setPixels(rect,bytes);
         bit.unlock();
      }
      
      public function draw_space(param1:ZPP_Space, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc5_:* = null as BodyList;
         var _loc6_:* = null as BodyList;
         var _loc7_:* = null as Body;
         var _loc8_:* = null as ShapeList;
         var _loc9_:* = null as ShapeList;
         var _loc10_:* = null as Shape;
         var _loc11_:* = null as ZNPNode_ZPP_Body;
         var _loc12_:* = null as ZPP_Body;
         var _loc13_:* = null as ZNPNode_ZPP_Compound;
         var _loc14_:* = null as ZPP_Compound;
         var _loc15_:* = null as ZPP_Compound;
         var _loc16_:* = null as ArbiterIterator;
         var _loc17_:* = null as Space;
         var _loc18_:* = null as ZPP_SpaceArbiterList;
         var _loc19_:* = null as Arbiter;
         var _loc20_:int = 0;
         var _loc21_:* = null as ZNPNode_ZPP_Constraint;
         var _loc22_:* = null as ZPP_Constraint;
         if(outer.cullingEnabled)
         {
            if(outer.drawBodies)
            {
               if(outer.drawBodyDetail)
               {
                  _loc5_ = bodyList = param1.bphase.bodiesInAABB(iport,false,false,null,bodyList);
                  while(_loc5_.zpp_inner.inner.head != null)
                  {
                     _loc7_ = _loc5_.shift();
                     if(_loc7_.debugDraw)
                     {
                        draw_body(_loc7_.zpp_inner,param2,param3,param4);
                     }
                  }
               }
               else
               {
                  _loc8_ = shapeList = param1.bphase.shapesInAABB(iport,false,false,null,shapeList);
                  while(_loc8_.zpp_inner.inner.head != null)
                  {
                     _loc10_ = _loc8_.shift();
                     if((_loc10_.zpp_inner.body != null ? _loc10_.zpp_inner.body.outer : null).debugDraw)
                     {
                        draw_shape(_loc10_.zpp_inner,param2,param3,param4);
                     }
                  }
               }
            }
         }
         else if(outer.drawBodies)
         {
            if(compoundstack == null)
            {
               compoundstack = new ZNPList_ZPP_Compound();
            }
            _loc11_ = param1.bodies.head;
            while(_loc11_ != null)
            {
               _loc12_ = _loc11_.elt;
               if(_loc12_.outer.debugDraw)
               {
                  draw_body(_loc12_,param2,param3,param4);
               }
               _loc11_ = _loc11_.next;
            }
            _loc13_ = param1.compounds.head;
            while(_loc13_ != null)
            {
               _loc14_ = _loc13_.elt;
               compoundstack.add(_loc14_);
               _loc13_ = _loc13_.next;
            }
            while(compoundstack.head != null)
            {
               _loc14_ = compoundstack.pop_unsafe();
               _loc11_ = _loc14_.bodies.head;
               while(_loc11_ != null)
               {
                  _loc12_ = _loc11_.elt;
                  if(_loc12_.outer.debugDraw)
                  {
                     draw_body(_loc12_,param2,param3,param4);
                  }
                  _loc11_ = _loc11_.next;
               }
               _loc13_ = _loc14_.compounds.head;
               while(_loc13_ != null)
               {
                  _loc15_ = _loc13_.elt;
                  compoundstack.add(_loc15_);
                  _loc13_ = _loc13_.next;
               }
            }
         }
         if(outer.drawCollisionArbiters || outer.drawFluidArbiters || outer.drawSensorArbiters)
         {
            _loc17_ = param1.outer;
            if(_loc17_.zpp_inner.wrap_arbiters == null)
            {
               _loc18_ = new ZPP_SpaceArbiterList();
               _loc18_.space = _loc17_.zpp_inner;
               _loc17_.zpp_inner.wrap_arbiters = _loc18_;
            }
            _loc16_ = _loc17_.zpp_inner.wrap_arbiters.iterator();
            while(true)
            {
               _loc16_.zpp_inner.zpp_inner.valmod();
               _loc20_ = _loc16_.zpp_inner.zpp_gl();
               _loc16_.zpp_critical = true;
               if(!(_loc16_.zpp_i < _loc20_ ? true : (_loc16_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc16_, _loc16_.zpp_inner = null, false)))
               {
                  break;
               }
               _loc16_.zpp_critical = false;
               _loc16_.zpp_i = (_loc20_ = _loc16_.zpp_i) + 1;
               _loc19_ = _loc16_.zpp_inner.at(_loc20_);
               draw_arbiter(_loc19_.zpp_inner,param2,param3,param4);
            }
         }
         if(outer.drawConstraints)
         {
            if(compoundstack == null)
            {
               compoundstack = new ZNPList_ZPP_Compound();
            }
            _loc21_ = param1.constraints.head;
            while(_loc21_ != null)
            {
               _loc22_ = _loc21_.elt;
               if(_loc22_.active && _loc22_.outer.debugDraw)
               {
                  _loc22_.draw(outer);
               }
               _loc21_ = _loc21_.next;
            }
            _loc13_ = param1.compounds.head;
            while(_loc13_ != null)
            {
               _loc14_ = _loc13_.elt;
               compoundstack.add(_loc14_);
               _loc13_ = _loc13_.next;
            }
            while(compoundstack.head != null)
            {
               _loc14_ = compoundstack.pop_unsafe();
               _loc21_ = _loc14_.constraints.head;
               while(_loc21_ != null)
               {
                  _loc22_ = _loc21_.elt;
                  if(_loc22_.active && _loc22_.outer.debugDraw)
                  {
                     _loc22_.draw(outer);
                  }
                  _loc21_ = _loc21_.next;
               }
               _loc13_ = _loc14_.compounds.head;
               while(_loc13_ != null)
               {
                  _loc15_ = _loc13_.elt;
                  compoundstack.add(_loc15_);
                  _loc13_ = _loc13_.next;
               }
            }
         }
      }
      
      public function draw_shape(param1:ZPP_Shape, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:* = null as Body;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:* = null as ZPP_Circle;
         var _loc18_:* = null as ZPP_Polygon;
         var _loc19_:* = null as ZPP_Vec2;
         var _loc20_:* = null as ZPP_Vec2;
         var _loc21_:* = null as ZPP_Vec2;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as ZPP_Body;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:* = null as ZPP_Polygon;
         var _loc30_:* = null as ZPP_Vec2;
         var _loc31_:* = null as ZPP_AABB;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         if(outer.colour == null)
         {
            _loc6_ = 16777215 * Math.exp(-(param1.id % 500) / 1500);
         }
         else
         {
            _loc6_ = outer.colour(param1.id);
         }
         _loc7_ = ((_loc6_ & 16711680) >> 16) * 0.7;
         _loc8_ = ((_loc6_ & 65280) >> 8) * 0.7;
         _loc9_ = (_loc6_ & 255) * 0.7;
         var _loc5_:int = -16777216 | _loc7_ << 16 | _loc8_ << 8 | _loc9_;
         var _loc10_:ZPP_Body = param1.body;
         if(_loc10_ != null)
         {
            if(outer.colour == null)
            {
               _loc11_ = 16777215 * Math.exp(-(_loc10_.id % 500) / 1500);
            }
            else
            {
               _loc11_ = outer.colour(_loc10_.id);
            }
            _loc7_ = ((_loc11_ & 16711680) >> 16) * 0.7;
            _loc8_ = ((_loc11_ & 65280) >> 8) * 0.7;
            _loc9_ = (_loc11_ & 255) * 0.7;
            §§push(false);
            if(_loc10_.space != null)
            {
               §§pop();
               _loc12_ = _loc10_.outer;
               if(_loc12_.zpp_inner.space == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: isSleeping makes no sense if the object is not contained within a Space";
               }
               §§push(_loc12_.zpp_inner.component.sleeping);
            }
            if(§§pop())
            {
               _loc7_ = 0.4 * _loc7_ + 0.6 * bg_r;
               _loc8_ = 0.4 * _loc8_ + 0.6 * bg_g;
               _loc9_ = 0.4 * _loc9_ + 0.6 * bg_b;
            }
            _loc6_ = -16777216 | _loc7_ << 16 | _loc8_ << 8 | _loc9_;
            _loc11_ = _loc5_;
            _loc13_ = _loc6_;
            _loc7_ = 0.2;
            _loc14_ = (_loc11_ >> 16 & 255) * _loc7_ + (_loc13_ >> 16 & 255) * (1 - _loc7_);
            _loc15_ = (_loc11_ >> 8 & 255) * _loc7_ + (_loc13_ >> 8 & 255) * (1 - _loc7_);
            _loc16_ = (_loc11_ & 255) * _loc7_ + (_loc13_ & 255) * (1 - _loc7_);
            _loc5_ = -16777216 | _loc14_ << 16 | _loc15_ << 8 | _loc16_;
            colour = _loc5_;
            if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc17_ = param1.circle;
               if(_loc17_.zip_worldCOM)
               {
                  if(_loc17_.body != null)
                  {
                     _loc17_.zip_worldCOM = false;
                     if(_loc17_.zip_localCOM)
                     {
                        _loc17_.zip_localCOM = false;
                        if(_loc17_.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                           _loc18_ = _loc17_.polygon;
                           if(_loc18_.lverts.next == null)
                           {
                              Boot.lastError = new Error();
                              throw "Error: An empty polygon has no meaningful localCOM";
                           }
                           if(_loc18_.lverts.next.next == null)
                           {
                              _loc18_.localCOMx = _loc18_.lverts.next.x;
                              _loc18_.localCOMy = _loc18_.lverts.next.y;
                           }
                           else if(_loc18_.lverts.next.next.next == null)
                           {
                              _loc18_.localCOMx = _loc18_.lverts.next.x;
                              _loc18_.localCOMy = _loc18_.lverts.next.y;
                              _loc7_ = 1;
                              _loc18_.localCOMx += _loc18_.lverts.next.next.x * _loc7_;
                              _loc18_.localCOMy += _loc18_.lverts.next.next.y * _loc7_;
                              _loc7_ = 0.5;
                              _loc18_.localCOMx *= _loc7_;
                              _loc18_.localCOMy *= _loc7_;
                           }
                           else
                           {
                              _loc18_.localCOMx = 0;
                              _loc18_.localCOMy = 0;
                              _loc7_ = 0;
                              _loc19_ = _loc18_.lverts.next;
                              _loc20_ = _loc19_;
                              _loc19_ = _loc19_.next;
                              _loc21_ = _loc19_;
                              _loc19_ = _loc19_.next;
                              while(_loc19_ != null)
                              {
                                 _loc22_ = _loc19_;
                                 _loc7_ += _loc21_.x * (_loc22_.y - _loc20_.y);
                                 _loc8_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                                 _loc18_.localCOMx += (_loc21_.x + _loc22_.x) * _loc8_;
                                 _loc18_.localCOMy += (_loc21_.y + _loc22_.y) * _loc8_;
                                 _loc20_ = _loc21_;
                                 _loc21_ = _loc22_;
                                 _loc19_ = _loc19_.next;
                              }
                              _loc19_ = _loc18_.lverts.next;
                              _loc22_ = _loc19_;
                              _loc7_ += _loc21_.x * (_loc22_.y - _loc20_.y);
                              _loc8_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                              _loc18_.localCOMx += (_loc21_.x + _loc22_.x) * _loc8_;
                              _loc18_.localCOMy += (_loc21_.y + _loc22_.y) * _loc8_;
                              _loc20_ = _loc21_;
                              _loc21_ = _loc22_;
                              _loc19_ = _loc19_.next;
                              _loc23_ = _loc19_;
                              _loc7_ += _loc21_.x * (_loc23_.y - _loc20_.y);
                              _loc8_ = _loc23_.y * _loc21_.x - _loc23_.x * _loc21_.y;
                              _loc18_.localCOMx += (_loc21_.x + _loc23_.x) * _loc8_;
                              _loc18_.localCOMy += (_loc21_.y + _loc23_.y) * _loc8_;
                              _loc7_ = 1 / (3 * _loc7_);
                              _loc8_ = _loc7_;
                              _loc18_.localCOMx *= _loc8_;
                              _loc18_.localCOMy *= _loc8_;
                           }
                        }
                     }
                     _loc24_ = _loc17_.body;
                     if(_loc24_.zip_axis)
                     {
                        _loc24_.zip_axis = false;
                        _loc24_.axisx = Math.sin(_loc24_.rot);
                        _loc24_.axisy = Math.cos(_loc24_.rot);
                     }
                     _loc17_.worldCOMx = _loc17_.body.posx + (_loc17_.body.axisy * _loc17_.localCOMx - _loc17_.body.axisx * _loc17_.localCOMy);
                     _loc17_.worldCOMy = _loc17_.body.posy + (_loc17_.localCOMx * _loc17_.body.axisx + _loc17_.localCOMy * _loc17_.body.axisy);
                  }
               }
               _loc7_ = _loc17_.worldCOMx;
               _loc8_ = _loc17_.worldCOMy;
               if(!param4)
               {
                  _loc9_ = param2.a * _loc7_ + param2.b * _loc8_ + param2.tx;
                  _loc8_ = param2.c * _loc7_ + param2.d * _loc8_ + param2.ty;
                  _loc7_ = _loc9_;
               }
               penx = _loc7_ + 0.5;
               peny = _loc8_ + 0.5;
               __circle(penx,peny,_loc17_.radius * param3 + 0.5,colour);
               if(outer.drawShapeAngleIndicators)
               {
                  _loc9_ = _loc17_.worldCOMx + 0.3 * _loc17_.radius * _loc10_.axisy;
                  _loc25_ = _loc17_.worldCOMy + 0.3 * _loc17_.radius * _loc10_.axisx;
                  _loc26_ = _loc17_.worldCOMx + _loc17_.radius * _loc10_.axisy;
                  _loc27_ = _loc17_.worldCOMy + _loc17_.radius * _loc10_.axisx;
                  if(!param4)
                  {
                     _loc28_ = param2.a * _loc9_ + param2.b * _loc25_ + param2.tx;
                     _loc25_ = param2.c * _loc9_ + param2.d * _loc25_ + param2.ty;
                     _loc9_ = _loc28_;
                  }
                  if(!param4)
                  {
                     _loc28_ = param2.a * _loc26_ + param2.b * _loc27_ + param2.tx;
                     _loc27_ = param2.c * _loc26_ + param2.d * _loc27_ + param2.ty;
                     _loc26_ = _loc28_;
                  }
                  penx = _loc9_ + 0.5;
                  peny = _loc25_ + 0.5;
                  _loc11_ = _loc26_ + 0.5;
                  _loc13_ = _loc27_ + 0.5;
                  __line(penx,peny,_loc11_,_loc13_,colour);
                  penx = _loc11_;
                  peny = _loc13_;
               }
            }
            else
            {
               _loc18_ = param1.polygon;
               if(_loc18_.zip_gverts)
               {
                  if(_loc18_.body != null)
                  {
                     _loc18_.zip_gverts = false;
                     _loc18_.validate_lverts();
                     _loc24_ = _loc18_.body;
                     if(_loc24_.zip_axis)
                     {
                        _loc24_.zip_axis = false;
                        _loc24_.axisx = Math.sin(_loc24_.rot);
                        _loc24_.axisy = Math.cos(_loc24_.rot);
                     }
                     _loc19_ = _loc18_.lverts.next;
                     _loc20_ = _loc18_.gverts.next;
                     while(_loc20_ != null)
                     {
                        _loc21_ = _loc20_;
                        _loc22_ = _loc19_;
                        _loc19_ = _loc19_.next;
                        _loc21_.x = _loc18_.body.posx + (_loc18_.body.axisy * _loc22_.x - _loc18_.body.axisx * _loc22_.y);
                        _loc21_.y = _loc18_.body.posy + (_loc22_.x * _loc18_.body.axisx + _loc22_.y * _loc18_.body.axisy);
                        _loc20_ = _loc20_.next;
                     }
                  }
               }
               _loc19_ = _loc18_.gverts.next;
               _loc7_ = _loc19_.x;
               _loc8_ = _loc19_.y;
               if(!param4)
               {
                  _loc9_ = param2.a * _loc7_ + param2.b * _loc8_ + param2.tx;
                  _loc8_ = param2.c * _loc7_ + param2.d * _loc8_ + param2.ty;
                  _loc7_ = _loc9_;
               }
               penx = _loc7_ + 0.5;
               peny = _loc8_ + 0.5;
               _loc9_ = _loc7_;
               _loc25_ = _loc8_;
               _loc20_ = _loc18_.gverts.next.next;
               while(_loc20_ != null)
               {
                  _loc21_ = _loc20_;
                  _loc7_ = _loc21_.x;
                  _loc8_ = _loc21_.y;
                  if(!param4)
                  {
                     _loc26_ = param2.a * _loc7_ + param2.b * _loc8_ + param2.tx;
                     _loc8_ = param2.c * _loc7_ + param2.d * _loc8_ + param2.ty;
                     _loc7_ = _loc26_;
                  }
                  _loc11_ = _loc7_ + 0.5;
                  _loc13_ = _loc8_ + 0.5;
                  __line(penx,peny,_loc11_,_loc13_,colour);
                  penx = _loc11_;
                  peny = _loc13_;
                  _loc20_ = _loc20_.next;
               }
               _loc11_ = _loc9_ + 0.5;
               _loc13_ = _loc25_ + 0.5;
               __line(penx,peny,_loc11_,_loc13_,colour);
               penx = _loc11_;
               peny = _loc13_;
               if(outer.drawShapeAngleIndicators)
               {
                  if(_loc18_.zip_worldCOM)
                  {
                     if(_loc18_.body != null)
                     {
                        _loc18_.zip_worldCOM = false;
                        if(_loc18_.zip_localCOM)
                        {
                           _loc18_.zip_localCOM = false;
                           if(_loc18_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc29_ = _loc18_.polygon;
                              if(_loc29_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful localCOM";
                              }
                              if(_loc29_.lverts.next.next == null)
                              {
                                 _loc29_.localCOMx = _loc29_.lverts.next.x;
                                 _loc29_.localCOMy = _loc29_.lverts.next.y;
                              }
                              else if(_loc29_.lverts.next.next.next == null)
                              {
                                 _loc29_.localCOMx = _loc29_.lverts.next.x;
                                 _loc29_.localCOMy = _loc29_.lverts.next.y;
                                 _loc26_ = 1;
                                 _loc29_.localCOMx += _loc29_.lverts.next.next.x * _loc26_;
                                 _loc29_.localCOMy += _loc29_.lverts.next.next.y * _loc26_;
                                 _loc26_ = 0.5;
                                 _loc29_.localCOMx *= _loc26_;
                                 _loc29_.localCOMy *= _loc26_;
                              }
                              else
                              {
                                 _loc29_.localCOMx = 0;
                                 _loc29_.localCOMy = 0;
                                 _loc26_ = 0;
                                 _loc20_ = _loc29_.lverts.next;
                                 _loc21_ = _loc20_;
                                 _loc20_ = _loc20_.next;
                                 _loc22_ = _loc20_;
                                 _loc20_ = _loc20_.next;
                                 while(_loc20_ != null)
                                 {
                                    _loc23_ = _loc20_;
                                    _loc26_ += _loc22_.x * (_loc23_.y - _loc21_.y);
                                    _loc27_ = _loc23_.y * _loc22_.x - _loc23_.x * _loc22_.y;
                                    _loc29_.localCOMx += (_loc22_.x + _loc23_.x) * _loc27_;
                                    _loc29_.localCOMy += (_loc22_.y + _loc23_.y) * _loc27_;
                                    _loc21_ = _loc22_;
                                    _loc22_ = _loc23_;
                                    _loc20_ = _loc20_.next;
                                 }
                                 _loc20_ = _loc29_.lverts.next;
                                 _loc23_ = _loc20_;
                                 _loc26_ += _loc22_.x * (_loc23_.y - _loc21_.y);
                                 _loc27_ = _loc23_.y * _loc22_.x - _loc23_.x * _loc22_.y;
                                 _loc29_.localCOMx += (_loc22_.x + _loc23_.x) * _loc27_;
                                 _loc29_.localCOMy += (_loc22_.y + _loc23_.y) * _loc27_;
                                 _loc21_ = _loc22_;
                                 _loc22_ = _loc23_;
                                 _loc20_ = _loc20_.next;
                                 _loc30_ = _loc20_;
                                 _loc26_ += _loc22_.x * (_loc30_.y - _loc21_.y);
                                 _loc27_ = _loc30_.y * _loc22_.x - _loc30_.x * _loc22_.y;
                                 _loc29_.localCOMx += (_loc22_.x + _loc30_.x) * _loc27_;
                                 _loc29_.localCOMy += (_loc22_.y + _loc30_.y) * _loc27_;
                                 _loc26_ = 1 / (3 * _loc26_);
                                 _loc27_ = _loc26_;
                                 _loc29_.localCOMx *= _loc27_;
                                 _loc29_.localCOMy *= _loc27_;
                              }
                           }
                        }
                        _loc24_ = _loc18_.body;
                        if(_loc24_.zip_axis)
                        {
                           _loc24_.zip_axis = false;
                           _loc24_.axisx = Math.sin(_loc24_.rot);
                           _loc24_.axisy = Math.cos(_loc24_.rot);
                        }
                        _loc18_.worldCOMx = _loc18_.body.posx + (_loc18_.body.axisy * _loc18_.localCOMx - _loc18_.body.axisx * _loc18_.localCOMy);
                        _loc18_.worldCOMy = _loc18_.body.posy + (_loc18_.localCOMx * _loc18_.body.axisx + _loc18_.localCOMy * _loc18_.body.axisy);
                     }
                  }
                  if(param4)
                  {
                     _loc7_ = _loc18_.worldCOMx;
                     _loc8_ = _loc18_.worldCOMy;
                  }
                  else
                  {
                     _loc7_ = param2.a * _loc18_.worldCOMx + param2.b * _loc18_.worldCOMy + param2.tx;
                     _loc8_ = param2.c * _loc18_.worldCOMx + param2.d * _loc18_.worldCOMy + param2.ty;
                  }
                  penx = _loc7_ + 0.5;
                  peny = _loc8_ + 0.5;
                  _loc11_ = _loc9_ + 0.5;
                  _loc13_ = _loc25_ + 0.5;
                  __line(penx,peny,_loc11_,_loc13_,colour);
                  penx = _loc11_;
                  peny = _loc13_;
               }
            }
            if(outer.drawShapeDetail)
            {
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
                           _loc18_ = param1.polygon;
                           if(_loc18_.lverts.next == null)
                           {
                              Boot.lastError = new Error();
                              throw "Error: An empty polygon has no meaningful localCOM";
                           }
                           if(_loc18_.lverts.next.next == null)
                           {
                              _loc18_.localCOMx = _loc18_.lverts.next.x;
                              _loc18_.localCOMy = _loc18_.lverts.next.y;
                           }
                           else if(_loc18_.lverts.next.next.next == null)
                           {
                              _loc18_.localCOMx = _loc18_.lverts.next.x;
                              _loc18_.localCOMy = _loc18_.lverts.next.y;
                              _loc7_ = 1;
                              _loc18_.localCOMx += _loc18_.lverts.next.next.x * _loc7_;
                              _loc18_.localCOMy += _loc18_.lverts.next.next.y * _loc7_;
                              _loc7_ = 0.5;
                              _loc18_.localCOMx *= _loc7_;
                              _loc18_.localCOMy *= _loc7_;
                           }
                           else
                           {
                              _loc18_.localCOMx = 0;
                              _loc18_.localCOMy = 0;
                              _loc7_ = 0;
                              _loc19_ = _loc18_.lverts.next;
                              _loc20_ = _loc19_;
                              _loc19_ = _loc19_.next;
                              _loc21_ = _loc19_;
                              _loc19_ = _loc19_.next;
                              while(_loc19_ != null)
                              {
                                 _loc22_ = _loc19_;
                                 _loc7_ += _loc21_.x * (_loc22_.y - _loc20_.y);
                                 _loc8_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                                 _loc18_.localCOMx += (_loc21_.x + _loc22_.x) * _loc8_;
                                 _loc18_.localCOMy += (_loc21_.y + _loc22_.y) * _loc8_;
                                 _loc20_ = _loc21_;
                                 _loc21_ = _loc22_;
                                 _loc19_ = _loc19_.next;
                              }
                              _loc19_ = _loc18_.lverts.next;
                              _loc22_ = _loc19_;
                              _loc7_ += _loc21_.x * (_loc22_.y - _loc20_.y);
                              _loc8_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                              _loc18_.localCOMx += (_loc21_.x + _loc22_.x) * _loc8_;
                              _loc18_.localCOMy += (_loc21_.y + _loc22_.y) * _loc8_;
                              _loc20_ = _loc21_;
                              _loc21_ = _loc22_;
                              _loc19_ = _loc19_.next;
                              _loc23_ = _loc19_;
                              _loc7_ += _loc21_.x * (_loc23_.y - _loc20_.y);
                              _loc8_ = _loc23_.y * _loc21_.x - _loc23_.x * _loc21_.y;
                              _loc18_.localCOMx += (_loc21_.x + _loc23_.x) * _loc8_;
                              _loc18_.localCOMy += (_loc21_.y + _loc23_.y) * _loc8_;
                              _loc7_ = 1 / (3 * _loc7_);
                              _loc8_ = _loc7_;
                              _loc18_.localCOMx *= _loc8_;
                              _loc18_.localCOMy *= _loc8_;
                           }
                        }
                     }
                     _loc24_ = param1.body;
                     if(_loc24_.zip_axis)
                     {
                        _loc24_.zip_axis = false;
                        _loc24_.axisx = Math.sin(_loc24_.rot);
                        _loc24_.axisy = Math.cos(_loc24_.rot);
                     }
                     param1.worldCOMx = param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy);
                     param1.worldCOMy = param1.body.posy + (param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy);
                  }
               }
               _loc11_ = _loc5_;
               _loc13_ = 16711680;
               _loc7_ = 0.8;
               _loc14_ = (_loc11_ >> 16 & 255) * _loc7_ + (_loc13_ >> 16 & 255) * (1 - _loc7_);
               _loc15_ = (_loc11_ >> 8 & 255) * _loc7_ + (_loc13_ >> 8 & 255) * (1 - _loc7_);
               _loc16_ = (_loc11_ & 255) * _loc7_ + (_loc13_ & 255) * (1 - _loc7_);
               colour = -16777216 | _loc14_ << 16 | _loc15_ << 8 | _loc16_;
               _loc7_ = 0;
               _loc8_ = 0;
               if(param4)
               {
                  _loc7_ = param1.worldCOMx;
                  _loc8_ = param1.worldCOMy;
               }
               else
               {
                  _loc7_ = param2.a * param1.worldCOMx + param2.b * param1.worldCOMy + param2.tx;
                  _loc8_ = param2.c * param1.worldCOMx + param2.d * param1.worldCOMy + param2.ty;
               }
               penx = _loc7_ + 0.5;
               peny = _loc8_ + 0.5;
               __circle(penx,peny,1.5,colour);
               if(param1.zip_aabb)
               {
                  if(param1.body != null)
                  {
                     param1.zip_aabb = false;
                     if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc17_ = param1.circle;
                        if(_loc17_.zip_worldCOM)
                        {
                           if(_loc17_.body != null)
                           {
                              _loc17_.zip_worldCOM = false;
                              if(_loc17_.zip_localCOM)
                              {
                                 _loc17_.zip_localCOM = false;
                                 if(_loc17_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc18_ = _loc17_.polygon;
                                    if(_loc18_.lverts.next == null)
                                    {
                                       Boot.lastError = new Error();
                                       throw "Error: An empty polygon has no meaningful localCOM";
                                    }
                                    if(_loc18_.lverts.next.next == null)
                                    {
                                       _loc18_.localCOMx = _loc18_.lverts.next.x;
                                       _loc18_.localCOMy = _loc18_.lverts.next.y;
                                    }
                                    else if(_loc18_.lverts.next.next.next == null)
                                    {
                                       _loc18_.localCOMx = _loc18_.lverts.next.x;
                                       _loc18_.localCOMy = _loc18_.lverts.next.y;
                                       _loc9_ = 1;
                                       _loc18_.localCOMx += _loc18_.lverts.next.next.x * _loc9_;
                                       _loc18_.localCOMy += _loc18_.lverts.next.next.y * _loc9_;
                                       _loc9_ = 0.5;
                                       _loc18_.localCOMx *= _loc9_;
                                       _loc18_.localCOMy *= _loc9_;
                                    }
                                    else
                                    {
                                       _loc18_.localCOMx = 0;
                                       _loc18_.localCOMy = 0;
                                       _loc9_ = 0;
                                       _loc19_ = _loc18_.lverts.next;
                                       _loc20_ = _loc19_;
                                       _loc19_ = _loc19_.next;
                                       _loc21_ = _loc19_;
                                       _loc19_ = _loc19_.next;
                                       while(_loc19_ != null)
                                       {
                                          _loc22_ = _loc19_;
                                          _loc9_ += _loc21_.x * (_loc22_.y - _loc20_.y);
                                          _loc25_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                                          _loc18_.localCOMx += (_loc21_.x + _loc22_.x) * _loc25_;
                                          _loc18_.localCOMy += (_loc21_.y + _loc22_.y) * _loc25_;
                                          _loc20_ = _loc21_;
                                          _loc21_ = _loc22_;
                                          _loc19_ = _loc19_.next;
                                       }
                                       _loc19_ = _loc18_.lverts.next;
                                       _loc22_ = _loc19_;
                                       _loc9_ += _loc21_.x * (_loc22_.y - _loc20_.y);
                                       _loc25_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                                       _loc18_.localCOMx += (_loc21_.x + _loc22_.x) * _loc25_;
                                       _loc18_.localCOMy += (_loc21_.y + _loc22_.y) * _loc25_;
                                       _loc20_ = _loc21_;
                                       _loc21_ = _loc22_;
                                       _loc19_ = _loc19_.next;
                                       _loc23_ = _loc19_;
                                       _loc9_ += _loc21_.x * (_loc23_.y - _loc20_.y);
                                       _loc25_ = _loc23_.y * _loc21_.x - _loc23_.x * _loc21_.y;
                                       _loc18_.localCOMx += (_loc21_.x + _loc23_.x) * _loc25_;
                                       _loc18_.localCOMy += (_loc21_.y + _loc23_.y) * _loc25_;
                                       _loc9_ = 1 / (3 * _loc9_);
                                       _loc25_ = _loc9_;
                                       _loc18_.localCOMx *= _loc25_;
                                       _loc18_.localCOMy *= _loc25_;
                                    }
                                 }
                              }
                              _loc24_ = _loc17_.body;
                              if(_loc24_.zip_axis)
                              {
                                 _loc24_.zip_axis = false;
                                 _loc24_.axisx = Math.sin(_loc24_.rot);
                                 _loc24_.axisy = Math.cos(_loc24_.rot);
                              }
                              _loc17_.worldCOMx = _loc17_.body.posx + (_loc17_.body.axisy * _loc17_.localCOMx - _loc17_.body.axisx * _loc17_.localCOMy);
                              _loc17_.worldCOMy = _loc17_.body.posy + (_loc17_.localCOMx * _loc17_.body.axisx + _loc17_.localCOMy * _loc17_.body.axisy);
                           }
                        }
                        _loc9_ = _loc17_.radius;
                        _loc25_ = _loc17_.radius;
                        _loc17_.aabb.minx = _loc17_.worldCOMx - _loc9_;
                        _loc17_.aabb.miny = _loc17_.worldCOMy - _loc25_;
                        _loc17_.aabb.maxx = _loc17_.worldCOMx + _loc9_;
                        _loc17_.aabb.maxy = _loc17_.worldCOMy + _loc25_;
                     }
                     else
                     {
                        _loc18_ = param1.polygon;
                        if(_loc18_.zip_gverts)
                        {
                           if(_loc18_.body != null)
                           {
                              _loc18_.zip_gverts = false;
                              _loc18_.validate_lverts();
                              _loc24_ = _loc18_.body;
                              if(_loc24_.zip_axis)
                              {
                                 _loc24_.zip_axis = false;
                                 _loc24_.axisx = Math.sin(_loc24_.rot);
                                 _loc24_.axisy = Math.cos(_loc24_.rot);
                              }
                              _loc19_ = _loc18_.lverts.next;
                              _loc20_ = _loc18_.gverts.next;
                              while(_loc20_ != null)
                              {
                                 _loc21_ = _loc20_;
                                 _loc22_ = _loc19_;
                                 _loc19_ = _loc19_.next;
                                 _loc21_.x = _loc18_.body.posx + (_loc18_.body.axisy * _loc22_.x - _loc18_.body.axisx * _loc22_.y);
                                 _loc21_.y = _loc18_.body.posy + (_loc22_.x * _loc18_.body.axisx + _loc22_.y * _loc18_.body.axisy);
                                 _loc20_ = _loc20_.next;
                              }
                           }
                        }
                        if(_loc18_.lverts.next == null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: An empty polygon has no meaningful bounds";
                        }
                        _loc19_ = _loc18_.gverts.next;
                        _loc18_.aabb.minx = _loc19_.x;
                        _loc18_.aabb.miny = _loc19_.y;
                        _loc18_.aabb.maxx = _loc19_.x;
                        _loc18_.aabb.maxy = _loc19_.y;
                        _loc20_ = _loc18_.gverts.next.next;
                        while(_loc20_ != null)
                        {
                           _loc21_ = _loc20_;
                           if(_loc21_.x < _loc18_.aabb.minx)
                           {
                              _loc18_.aabb.minx = _loc21_.x;
                           }
                           if(_loc21_.x > _loc18_.aabb.maxx)
                           {
                              _loc18_.aabb.maxx = _loc21_.x;
                           }
                           if(_loc21_.y < _loc18_.aabb.miny)
                           {
                              _loc18_.aabb.miny = _loc21_.y;
                           }
                           if(_loc21_.y > _loc18_.aabb.maxy)
                           {
                              _loc18_.aabb.maxy = _loc21_.y;
                           }
                           _loc20_ = _loc20_.next;
                        }
                     }
                  }
               }
               if(param4)
               {
                  __aabb(param1.aabb,colour);
               }
               else
               {
                  _loc9_ = 0;
                  _loc25_ = 0;
                  _loc9_ = param2.a * param1.aabb.minx + param2.b * param1.aabb.miny + param2.tx;
                  _loc25_ = param2.c * param1.aabb.minx + param2.d * param1.aabb.miny + param2.ty;
                  _loc31_ = param1.aabb;
                  _loc26_ = _loc31_.maxx - _loc31_.minx;
                  _loc27_ = 0;
                  _loc28_ = param2.a * _loc26_ + param2.b * _loc27_;
                  _loc27_ = param2.c * _loc26_ + param2.d * _loc27_;
                  _loc26_ = _loc28_;
                  _loc28_ = 0;
                  _loc31_ = param1.aabb;
                  _loc32_ = _loc31_.maxy - _loc31_.miny;
                  _loc33_ = param2.a * _loc28_ + param2.b * _loc32_;
                  _loc32_ = param2.c * _loc28_ + param2.d * _loc32_;
                  _loc28_ = _loc33_;
                  penx = _loc9_ + 0.5;
                  peny = _loc25_ + 0.5;
                  _loc11_ = _loc9_ + _loc26_ + 0.5;
                  _loc13_ = _loc25_ + _loc27_ + 0.5;
                  __line(penx,peny,_loc11_,_loc13_,colour);
                  penx = _loc11_;
                  peny = _loc13_;
                  _loc11_ = _loc9_ + _loc26_ + _loc28_ + 0.5;
                  _loc13_ = _loc25_ + _loc27_ + _loc32_ + 0.5;
                  __line(penx,peny,_loc11_,_loc13_,colour);
                  penx = _loc11_;
                  peny = _loc13_;
                  _loc11_ = _loc9_ + _loc28_ + 0.5;
                  _loc13_ = _loc25_ + _loc32_ + 0.5;
                  __line(penx,peny,_loc11_,_loc13_,colour);
                  penx = _loc11_;
                  peny = _loc13_;
                  _loc11_ = _loc9_ + 0.5;
                  _loc13_ = _loc25_ + 0.5;
                  __line(penx,peny,_loc11_,_loc13_,colour);
                  penx = _loc11_;
                  peny = _loc13_;
               }
            }
         }
      }
      
      public function draw_compound(param1:ZPP_Compound, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc6_:* = null as ZPP_Compound;
         var _loc8_:* = null as ZPP_Body;
         var _loc10_:* = null as ZPP_Constraint;
         var _loc5_:ZNPNode_ZPP_Compound = param1.compounds.head;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.elt;
            draw_compound(_loc6_,param2,param3,param4);
            _loc5_ = _loc5_.next;
         }
         var _loc7_:ZNPNode_ZPP_Body = param1.bodies.head;
         while(_loc7_ != null)
         {
            _loc8_ = _loc7_.elt;
            if(_loc8_.outer.debugDraw)
            {
               draw_body(_loc8_,param2,param3,param4);
            }
            _loc7_ = _loc7_.next;
         }
         var _loc9_:ZNPNode_ZPP_Constraint = param1.constraints.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            if(_loc10_.active && _loc10_.outer.debugDraw)
            {
               _loc10_.draw(outer);
            }
            _loc9_ = _loc9_.next;
         }
      }
      
      public function draw_body(param1:ZPP_Body, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc5_:* = null as ZNPNode_ZPP_Shape;
         var _loc6_:* = null as ZPP_Shape;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as Body;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Number = NaN;
         var _loc18_:* = null as ZPP_Circle;
         var _loc19_:* = null as ZPP_Polygon;
         var _loc20_:Number = NaN;
         var _loc21_:* = null as ZPP_Vec2;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as ZPP_Vec2;
         var _loc25_:Number = NaN;
         var _loc26_:* = null as ZPP_Vec2;
         var _loc27_:* = null as ZPP_Body;
         var _loc28_:* = null as ZPP_AABB;
         var _loc29_:* = null as ZPP_AABB;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         _loc5_ = param1.shapes.head;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.elt;
            draw_shape(_loc6_,param2,param3,param4);
            _loc5_ = _loc5_.next;
         }
         if(outer.drawBodyDetail)
         {
            if(outer.colour == null)
            {
               _loc8_ = 16777215 * Math.exp(-(param1.id % 500) / 1500);
            }
            else
            {
               _loc8_ = outer.colour(param1.id);
            }
            _loc9_ = ((_loc8_ & 16711680) >> 16) * 0.7;
            _loc10_ = ((_loc8_ & 65280) >> 8) * 0.7;
            _loc11_ = (_loc8_ & 255) * 0.7;
            §§push(false);
            if(param1.space != null)
            {
               §§pop();
               _loc12_ = param1.outer;
               if(_loc12_.zpp_inner.space == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: isSleeping makes no sense if the object is not contained within a Space";
               }
               §§push(_loc12_.zpp_inner.component.sleeping);
            }
            if(§§pop())
            {
               _loc9_ = 0.4 * _loc9_ + 0.6 * bg_r;
               _loc10_ = 0.4 * _loc10_ + 0.6 * bg_g;
               _loc11_ = 0.4 * _loc11_ + 0.6 * bg_b;
            }
            _loc7_ = -16777216 | _loc9_ << 16 | _loc10_ << 8 | _loc11_;
            _loc8_ = _loc7_;
            _loc13_ = 16711680;
            _loc9_ = 0.8;
            _loc14_ = (_loc8_ >> 16 & 255) * _loc9_ + (_loc13_ >> 16 & 255) * (1 - _loc9_);
            _loc15_ = (_loc8_ >> 8 & 255) * _loc9_ + (_loc13_ >> 8 & 255) * (1 - _loc9_);
            _loc16_ = (_loc8_ & 255) * _loc9_ + (_loc13_ & 255) * (1 - _loc9_);
            colour = -16777216 | _loc14_ << 16 | _loc15_ << 8 | _loc16_;
            _loc9_ = 0;
            _loc10_ = 0;
            _loc11_ = 0;
            _loc17_ = 0;
            if(param1.shapes.head != null)
            {
               param1.validate_worldCOM();
               if(param4)
               {
                  _loc9_ = param1.worldCOMx;
                  _loc10_ = param1.worldCOMy;
               }
               else
               {
                  _loc9_ = param2.a * param1.worldCOMx + param2.b * param1.worldCOMy + param2.tx;
                  _loc10_ = param2.c * param1.worldCOMx + param2.d * param1.worldCOMy + param2.ty;
               }
               penx = _loc9_ + 0.5;
               peny = _loc10_ + 0.5;
               __circle(penx,peny,1.5,colour);
               if(param1.shapes.head == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Body bounds only makes sense if it contains shapes";
               }
               if(param1.zip_aabb)
               {
                  param1.zip_aabb = false;
                  param1.aabb.minx = 1.79e+308;
                  param1.aabb.miny = 1.79e+308;
                  param1.aabb.maxx = -1.79e+308;
                  param1.aabb.maxy = -1.79e+308;
                  _loc5_ = param1.shapes.head;
                  while(_loc5_ != null)
                  {
                     _loc6_ = _loc5_.elt;
                     if(_loc6_.zip_aabb)
                     {
                        if(_loc6_.body != null)
                        {
                           _loc6_.zip_aabb = false;
                           if(_loc6_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              _loc18_ = _loc6_.circle;
                              if(_loc18_.zip_worldCOM)
                              {
                                 if(_loc18_.body != null)
                                 {
                                    _loc18_.zip_worldCOM = false;
                                    if(_loc18_.zip_localCOM)
                                    {
                                       _loc18_.zip_localCOM = false;
                                       if(_loc18_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                       {
                                          _loc19_ = _loc18_.polygon;
                                          if(_loc19_.lverts.next == null)
                                          {
                                             Boot.lastError = new Error();
                                             throw "Error: An empty polygon has no meaningful localCOM";
                                          }
                                          if(_loc19_.lverts.next.next == null)
                                          {
                                             _loc19_.localCOMx = _loc19_.lverts.next.x;
                                             _loc19_.localCOMy = _loc19_.lverts.next.y;
                                          }
                                          else if(_loc19_.lverts.next.next.next == null)
                                          {
                                             _loc19_.localCOMx = _loc19_.lverts.next.x;
                                             _loc19_.localCOMy = _loc19_.lverts.next.y;
                                             _loc20_ = 1;
                                             _loc19_.localCOMx += _loc19_.lverts.next.next.x * _loc20_;
                                             _loc19_.localCOMy += _loc19_.lverts.next.next.y * _loc20_;
                                             _loc20_ = 0.5;
                                             _loc19_.localCOMx *= _loc20_;
                                             _loc19_.localCOMy *= _loc20_;
                                          }
                                          else
                                          {
                                             _loc19_.localCOMx = 0;
                                             _loc19_.localCOMy = 0;
                                             _loc20_ = 0;
                                             _loc21_ = _loc19_.lverts.next;
                                             _loc22_ = _loc21_;
                                             _loc21_ = _loc21_.next;
                                             _loc23_ = _loc21_;
                                             _loc21_ = _loc21_.next;
                                             while(_loc21_ != null)
                                             {
                                                _loc24_ = _loc21_;
                                                _loc20_ += _loc23_.x * (_loc24_.y - _loc22_.y);
                                                _loc25_ = _loc24_.y * _loc23_.x - _loc24_.x * _loc23_.y;
                                                _loc19_.localCOMx += (_loc23_.x + _loc24_.x) * _loc25_;
                                                _loc19_.localCOMy += (_loc23_.y + _loc24_.y) * _loc25_;
                                                _loc22_ = _loc23_;
                                                _loc23_ = _loc24_;
                                                _loc21_ = _loc21_.next;
                                             }
                                             _loc21_ = _loc19_.lverts.next;
                                             _loc24_ = _loc21_;
                                             _loc20_ += _loc23_.x * (_loc24_.y - _loc22_.y);
                                             _loc25_ = _loc24_.y * _loc23_.x - _loc24_.x * _loc23_.y;
                                             _loc19_.localCOMx += (_loc23_.x + _loc24_.x) * _loc25_;
                                             _loc19_.localCOMy += (_loc23_.y + _loc24_.y) * _loc25_;
                                             _loc22_ = _loc23_;
                                             _loc23_ = _loc24_;
                                             _loc21_ = _loc21_.next;
                                             _loc26_ = _loc21_;
                                             _loc20_ += _loc23_.x * (_loc26_.y - _loc22_.y);
                                             _loc25_ = _loc26_.y * _loc23_.x - _loc26_.x * _loc23_.y;
                                             _loc19_.localCOMx += (_loc23_.x + _loc26_.x) * _loc25_;
                                             _loc19_.localCOMy += (_loc23_.y + _loc26_.y) * _loc25_;
                                             _loc20_ = 1 / (3 * _loc20_);
                                             _loc25_ = _loc20_;
                                             _loc19_.localCOMx *= _loc25_;
                                             _loc19_.localCOMy *= _loc25_;
                                          }
                                       }
                                    }
                                    _loc27_ = _loc18_.body;
                                    if(_loc27_.zip_axis)
                                    {
                                       _loc27_.zip_axis = false;
                                       _loc27_.axisx = Math.sin(_loc27_.rot);
                                       _loc27_.axisy = Math.cos(_loc27_.rot);
                                    }
                                    _loc18_.worldCOMx = _loc18_.body.posx + (_loc18_.body.axisy * _loc18_.localCOMx - _loc18_.body.axisx * _loc18_.localCOMy);
                                    _loc18_.worldCOMy = _loc18_.body.posy + (_loc18_.localCOMx * _loc18_.body.axisx + _loc18_.localCOMy * _loc18_.body.axisy);
                                 }
                              }
                              _loc20_ = _loc18_.radius;
                              _loc25_ = _loc18_.radius;
                              _loc18_.aabb.minx = _loc18_.worldCOMx - _loc20_;
                              _loc18_.aabb.miny = _loc18_.worldCOMy - _loc25_;
                              _loc18_.aabb.maxx = _loc18_.worldCOMx + _loc20_;
                              _loc18_.aabb.maxy = _loc18_.worldCOMy + _loc25_;
                           }
                           else
                           {
                              _loc19_ = _loc6_.polygon;
                              if(_loc19_.zip_gverts)
                              {
                                 if(_loc19_.body != null)
                                 {
                                    _loc19_.zip_gverts = false;
                                    _loc19_.validate_lverts();
                                    _loc27_ = _loc19_.body;
                                    if(_loc27_.zip_axis)
                                    {
                                       _loc27_.zip_axis = false;
                                       _loc27_.axisx = Math.sin(_loc27_.rot);
                                       _loc27_.axisy = Math.cos(_loc27_.rot);
                                    }
                                    _loc21_ = _loc19_.lverts.next;
                                    _loc22_ = _loc19_.gverts.next;
                                    while(_loc22_ != null)
                                    {
                                       _loc23_ = _loc22_;
                                       _loc24_ = _loc21_;
                                       _loc21_ = _loc21_.next;
                                       _loc23_.x = _loc19_.body.posx + (_loc19_.body.axisy * _loc24_.x - _loc19_.body.axisx * _loc24_.y);
                                       _loc23_.y = _loc19_.body.posy + (_loc24_.x * _loc19_.body.axisx + _loc24_.y * _loc19_.body.axisy);
                                       _loc22_ = _loc22_.next;
                                    }
                                 }
                              }
                              if(_loc19_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful bounds";
                              }
                              _loc21_ = _loc19_.gverts.next;
                              _loc19_.aabb.minx = _loc21_.x;
                              _loc19_.aabb.miny = _loc21_.y;
                              _loc19_.aabb.maxx = _loc21_.x;
                              _loc19_.aabb.maxy = _loc21_.y;
                              _loc22_ = _loc19_.gverts.next.next;
                              while(_loc22_ != null)
                              {
                                 _loc23_ = _loc22_;
                                 if(_loc23_.x < _loc19_.aabb.minx)
                                 {
                                    _loc19_.aabb.minx = _loc23_.x;
                                 }
                                 if(_loc23_.x > _loc19_.aabb.maxx)
                                 {
                                    _loc19_.aabb.maxx = _loc23_.x;
                                 }
                                 if(_loc23_.y < _loc19_.aabb.miny)
                                 {
                                    _loc19_.aabb.miny = _loc23_.y;
                                 }
                                 if(_loc23_.y > _loc19_.aabb.maxy)
                                 {
                                    _loc19_.aabb.maxy = _loc23_.y;
                                 }
                                 _loc22_ = _loc22_.next;
                              }
                           }
                        }
                     }
                     _loc28_ = param1.aabb;
                     _loc29_ = _loc6_.aabb;
                     if(_loc29_.minx < _loc28_.minx)
                     {
                        _loc28_.minx = _loc29_.minx;
                     }
                     if(_loc29_.maxx > _loc28_.maxx)
                     {
                        _loc28_.maxx = _loc29_.maxx;
                     }
                     if(_loc29_.miny < _loc28_.miny)
                     {
                        _loc28_.miny = _loc29_.miny;
                     }
                     if(_loc29_.maxy > _loc28_.maxy)
                     {
                        _loc28_.maxy = _loc29_.maxy;
                     }
                     _loc5_ = _loc5_.next;
                  }
               }
               if(param4)
               {
                  __aabb(param1.aabb,colour);
               }
               else
               {
                  _loc20_ = 0;
                  _loc25_ = 0;
                  _loc20_ = param2.a * param1.aabb.minx + param2.b * param1.aabb.miny + param2.tx;
                  _loc25_ = param2.c * param1.aabb.minx + param2.d * param1.aabb.miny + param2.ty;
                  _loc28_ = param1.aabb;
                  _loc30_ = _loc28_.maxx - _loc28_.minx;
                  _loc31_ = 0;
                  _loc32_ = param2.a * _loc30_ + param2.b * _loc31_;
                  _loc31_ = param2.c * _loc30_ + param2.d * _loc31_;
                  _loc30_ = _loc32_;
                  _loc32_ = 0;
                  _loc28_ = param1.aabb;
                  _loc33_ = _loc28_.maxy - _loc28_.miny;
                  _loc34_ = param2.a * _loc32_ + param2.b * _loc33_;
                  _loc33_ = param2.c * _loc32_ + param2.d * _loc33_;
                  _loc32_ = _loc34_;
                  penx = _loc20_ + 0.5;
                  peny = _loc25_ + 0.5;
                  _loc8_ = _loc20_ + _loc30_ + 0.5;
                  _loc13_ = _loc25_ + _loc31_ + 0.5;
                  __line(penx,peny,_loc8_,_loc13_,colour);
                  penx = _loc8_;
                  peny = _loc13_;
                  _loc8_ = _loc20_ + _loc30_ + _loc32_ + 0.5;
                  _loc13_ = _loc25_ + _loc31_ + _loc33_ + 0.5;
                  __line(penx,peny,_loc8_,_loc13_,colour);
                  penx = _loc8_;
                  peny = _loc13_;
                  _loc8_ = _loc20_ + _loc32_ + 0.5;
                  _loc13_ = _loc25_ + _loc33_ + 0.5;
                  __line(penx,peny,_loc8_,_loc13_,colour);
                  penx = _loc8_;
                  peny = _loc13_;
                  _loc8_ = _loc20_ + 0.5;
                  _loc13_ = _loc25_ + 0.5;
                  __line(penx,peny,_loc8_,_loc13_,colour);
                  penx = _loc8_;
                  peny = _loc13_;
               }
            }
            if(param4)
            {
               _loc11_ = param1.pre_posx;
               _loc17_ = param1.pre_posy;
            }
            else
            {
               _loc11_ = param2.a * param1.pre_posx + param2.b * param1.pre_posy + param2.tx;
               _loc17_ = param2.c * param1.pre_posx + param2.d * param1.pre_posy + param2.ty;
            }
            if(param4)
            {
               _loc9_ = param1.posx;
               _loc10_ = param1.posy;
            }
            else
            {
               _loc9_ = param2.a * param1.posx + param2.b * param1.posy + param2.tx;
               _loc10_ = param2.c * param1.posx + param2.d * param1.posy + param2.ty;
            }
            penx = _loc11_ + 0.5;
            peny = _loc17_ + 0.5;
            _loc8_ = _loc9_ + 0.5;
            _loc13_ = _loc10_ + 0.5;
            __line(penx,peny,_loc8_,_loc13_,colour);
            penx = _loc8_;
            peny = _loc13_;
            penx = _loc9_ + 0.5;
            peny = _loc10_ + 0.5;
            __circle(penx,peny,1.5,colour);
         }
      }
      
      public function draw_arbiter(param1:ZPP_Arbiter, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 8345
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      public function clear() : void
      {
         bytes.position = 0;
         bgbytes.position = 0;
         bytes.writeBytes(bgbytes);
      }
      
      public function __tri(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc12_:* = null as Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         if(!xnull)
         {
            param1 = xform.outer.transform(param1);
            param2 = xform.outer.transform(param2);
            param3 = xform.outer.transform(param3);
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc5_:int = param1.zpp_inner.x + 0.5;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc7_:int = param1.zpp_inner.y + 0.5;
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc8_:int = param2.zpp_inner.x + 0.5;
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc9_:int = param2.zpp_inner.y + 0.5;
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param3.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc10_:int = param3.zpp_inner.x + 0.5;
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param3.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc11_:int = param3.zpp_inner.y + 0.5;
         if(!xnull)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc12_ = param1;
            _loc12_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc12_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc12_;
            }
            ZPP_PubPool.nextVec2 = _loc12_;
            _loc12_.zpp_disp = true;
            _loc13_ = _loc6_;
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
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(param2.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = param2.zpp_inner;
            param2.zpp_inner.outer = null;
            param2.zpp_inner = null;
            _loc12_ = param2;
            _loc12_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc12_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc12_;
            }
            ZPP_PubPool.nextVec2 = _loc12_;
            _loc12_.zpp_disp = true;
            _loc13_ = _loc6_;
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
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(param3.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = param3.zpp_inner;
            param3.zpp_inner.outer = null;
            param3.zpp_inner = null;
            _loc12_ = param3;
            _loc12_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc12_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc12_;
            }
            ZPP_PubPool.nextVec2 = _loc12_;
            _loc12_.zpp_disp = true;
            _loc13_ = _loc6_;
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
         if(_loc9_ < _loc7_)
         {
            _loc14_ = _loc5_;
            _loc5_ = _loc8_;
            _loc8_ = _loc14_;
            _loc14_ = _loc7_;
            _loc7_ = _loc9_;
            _loc9_ = _loc14_;
         }
         if(_loc11_ < _loc7_)
         {
            _loc14_ = _loc5_;
            _loc15_ = _loc8_;
            _loc5_ = _loc10_;
            _loc8_ = _loc14_;
            _loc10_ = _loc15_;
            _loc16_ = _loc7_;
            _loc17_ = _loc9_;
            _loc7_ = _loc11_;
            _loc9_ = _loc16_;
            _loc11_ = _loc17_;
         }
         else if(_loc11_ < _loc9_)
         {
            _loc14_ = _loc8_;
            _loc8_ = _loc10_;
            _loc10_ = _loc14_;
            _loc14_ = _loc9_;
            _loc9_ = _loc11_;
            _loc11_ = _loc14_;
         }
         if(_loc7_ != _loc11_ && !(_loc5_ == _loc8_ && _loc8_ == _loc10_))
         {
            if((_loc5_ - _loc10_) * (_loc9_ - _loc11_) - (_loc7_ - _loc11_) * (_loc8_ - _loc10_) < 0)
            {
               _loc18_ = (_loc10_ - _loc5_) / (_loc11_ - _loc7_);
               if(_loc7_ != _loc9_)
               {
                  _loc19_ = (_loc8_ - _loc5_) / (_loc9_ - _loc7_);
                  _loc14_ = _loc7_;
                  _loc15_ = _loc9_;
                  if(_loc14_ < 0)
                  {
                     _loc14_ = 0;
                  }
                  if(_loc15_ >= height)
                  {
                     _loc15_ = height - 1;
                  }
                  _loc16_ = _loc14_;
                  while(_loc16_ < _loc15_)
                  {
                     _loc17_ = _loc16_++;
                     _loc20_ = _loc17_ - _loc7_;
                     _loc21_ = _loc5_ + _loc20_ * _loc19_ + 0.5;
                     _loc22_ = _loc5_ + _loc20_ * _loc18_ + 0.5;
                     if(_loc21_ < 0)
                     {
                        _loc21_ = 0;
                     }
                     if(_loc22_ >= width)
                     {
                        _loc22_ = width - 1;
                     }
                     _loc23_ = _loc21_;
                     _loc24_ = _loc22_ + 1;
                     while(_loc23_ < _loc24_)
                     {
                        _loc25_ = _loc23_++;
                        if(_loc25_ >= 0 && _loc25_ < width && _loc17_ >= 0 && _loc17_ < height)
                        {
                           si32(param4,_loc17_ * width + _loc25_ << 2);
                        }
                     }
                  }
               }
               if(_loc9_ != _loc11_)
               {
                  _loc19_ = (_loc10_ - _loc8_) / (_loc11_ - _loc9_);
                  _loc14_ = _loc9_;
                  _loc15_ = _loc11_;
                  if(_loc14_ < 0)
                  {
                     _loc14_ = 0;
                  }
                  if(_loc15_ >= height)
                  {
                     _loc15_ = height - 1;
                  }
                  _loc16_ = _loc14_;
                  _loc17_ = _loc15_ + 1;
                  while(_loc16_ < _loc17_)
                  {
                     _loc20_ = _loc16_++;
                     _loc21_ = _loc8_ + (_loc20_ - _loc9_) * _loc19_ + 0.5;
                     _loc22_ = _loc5_ + (_loc20_ - _loc7_) * _loc18_ + 0.5;
                     if(_loc21_ < 0)
                     {
                        _loc21_ = 0;
                     }
                     if(_loc22_ >= width)
                     {
                        _loc22_ = width - 1;
                     }
                     _loc23_ = _loc21_;
                     _loc24_ = _loc22_ + 1;
                     while(_loc23_ < _loc24_)
                     {
                        _loc25_ = _loc23_++;
                        if(_loc25_ >= 0 && _loc25_ < width && _loc20_ >= 0 && _loc20_ < height)
                        {
                           si32(param4,_loc20_ * width + _loc25_ << 2);
                        }
                     }
                  }
               }
            }
            else
            {
               _loc18_ = (_loc10_ - _loc5_) / (_loc11_ - _loc7_);
               if(_loc7_ != _loc9_)
               {
                  _loc19_ = (_loc8_ - _loc5_) / (_loc9_ - _loc7_);
                  _loc14_ = _loc7_;
                  _loc15_ = _loc9_;
                  if(_loc14_ < 0)
                  {
                     _loc14_ = 0;
                  }
                  if(_loc15_ >= height)
                  {
                     _loc15_ = height - 1;
                  }
                  _loc16_ = _loc14_;
                  while(_loc16_ < _loc15_)
                  {
                     _loc17_ = _loc16_++;
                     _loc20_ = _loc17_ - _loc7_;
                     _loc21_ = _loc5_ + _loc20_ * _loc19_ + 0.5;
                     _loc22_ = _loc5_ + _loc20_ * _loc18_ + 0.5;
                     if(_loc22_ < 0)
                     {
                        _loc22_ = 0;
                     }
                     if(_loc21_ >= width)
                     {
                        _loc21_ = width - 1;
                     }
                     _loc23_ = _loc22_;
                     _loc24_ = _loc21_ + 1;
                     while(_loc23_ < _loc24_)
                     {
                        _loc25_ = _loc23_++;
                        if(_loc25_ >= 0 && _loc25_ < width && _loc17_ >= 0 && _loc17_ < height)
                        {
                           si32(param4,_loc17_ * width + _loc25_ << 2);
                        }
                     }
                  }
               }
               if(_loc9_ != _loc11_)
               {
                  _loc19_ = (_loc10_ - _loc8_) / (_loc11_ - _loc9_);
                  _loc14_ = _loc9_;
                  _loc15_ = _loc11_;
                  if(_loc14_ < 0)
                  {
                     _loc14_ = 0;
                  }
                  if(_loc15_ >= height)
                  {
                     _loc15_ = height - 1;
                  }
                  _loc16_ = _loc14_;
                  _loc17_ = _loc15_ + 1;
                  while(_loc16_ < _loc17_)
                  {
                     _loc20_ = _loc16_++;
                     _loc21_ = _loc8_ + (_loc20_ - _loc9_) * _loc19_ + 0.5;
                     _loc22_ = _loc5_ + (_loc20_ - _loc7_) * _loc18_ + 0.5;
                     if(_loc22_ < 0)
                     {
                        _loc22_ = 0;
                     }
                     if(_loc21_ >= width)
                     {
                        _loc21_ = width - 1;
                     }
                     _loc23_ = _loc22_;
                     _loc24_ = _loc21_ + 1;
                     while(_loc23_ < _loc24_)
                     {
                        _loc25_ = _loc23_++;
                        if(_loc25_ >= 0 && _loc25_ < width && _loc20_ >= 0 && _loc20_ < height)
                        {
                           si32(param4,_loc20_ * width + _loc25_ << 2);
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function __round(param1:Number) : int
      {
         return param1 + 0.5;
      }
      
      public function __line(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(param1 < param3)
         {
            _loc6_ = param3 - param1;
            if(param2 < param4)
            {
               _loc7_ = param4 - param2;
               _loc8_ = width;
               _loc9_ = _loc6_ - _loc7_;
               _loc10_ = param2 * width + param1;
               while(true)
               {
                  if(param1 >= 0 && param1 < width && param2 >= 0 && param2 < height)
                  {
                     si32(param5,_loc10_ << 2);
                  }
                  if(param1 == param3 && param2 == param4)
                  {
                     break;
                  }
                  _loc11_ = _loc9_ << 1;
                  if(_loc11_ > -_loc7_)
                  {
                     _loc9_ -= _loc7_;
                     param1++;
                     _loc10_++;
                  }
                  if(_loc11_ < _loc6_)
                  {
                     _loc9_ += _loc6_;
                     param2++;
                     _loc10_ += _loc8_;
                  }
               }
            }
            else
            {
               _loc7_ = param2 - param4;
               _loc8_ = -width;
               _loc9_ = _loc6_ - _loc7_;
               _loc10_ = param2 * width + param1;
               while(true)
               {
                  if(param1 >= 0 && param1 < width && param2 >= 0 && param2 < height)
                  {
                     si32(param5,_loc10_ << 2);
                  }
                  if(param1 == param3 && param2 == param4)
                  {
                     break;
                  }
                  _loc11_ = _loc9_ << 1;
                  if(_loc11_ > -_loc7_)
                  {
                     _loc9_ -= _loc7_;
                     param1++;
                     _loc10_++;
                  }
                  if(_loc11_ < _loc6_)
                  {
                     _loc9_ += _loc6_;
                     param2--;
                     _loc10_ += _loc8_;
                  }
               }
            }
         }
         else
         {
            _loc6_ = param1 - param3;
            if(param2 < param4)
            {
               _loc7_ = param4 - param2;
               _loc8_ = width;
               _loc9_ = _loc6_ - _loc7_;
               _loc10_ = param2 * width + param1;
               while(true)
               {
                  if(param1 >= 0 && param1 < width && param2 >= 0 && param2 < height)
                  {
                     si32(param5,_loc10_ << 2);
                  }
                  if(param1 == param3 && param2 == param4)
                  {
                     break;
                  }
                  _loc11_ = _loc9_ << 1;
                  if(_loc11_ > -_loc7_)
                  {
                     _loc9_ -= _loc7_;
                     param1--;
                     _loc10_--;
                  }
                  if(_loc11_ < _loc6_)
                  {
                     _loc9_ += _loc6_;
                     param2++;
                     _loc10_ += _loc8_;
                  }
               }
            }
            else
            {
               _loc7_ = param2 - param4;
               _loc8_ = -width;
               _loc9_ = _loc6_ - _loc7_;
               _loc10_ = param2 * width + param1;
               while(true)
               {
                  if(param1 >= 0 && param1 < width && param2 >= 0 && param2 < height)
                  {
                     si32(param5,_loc10_ << 2);
                  }
                  if(param1 == param3 && param2 == param4)
                  {
                     break;
                  }
                  _loc11_ = _loc9_ << 1;
                  if(_loc11_ > -_loc7_)
                  {
                     _loc9_ -= _loc7_;
                     param1--;
                     _loc10_--;
                  }
                  if(_loc11_ < _loc6_)
                  {
                     _loc9_ += _loc6_;
                     param2--;
                     _loc10_ += _loc8_;
                  }
               }
            }
         }
      }
      
      public function __fcircle(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(param3 == 0)
         {
            if(param1 >= 0 && param1 < width && param2 >= 0 && param2 < height)
            {
               si32(param4,param2 * width + param1 << 2);
            }
         }
         else if(param3 == 1)
         {
            _loc5_ = param2 + 1;
            if(param1 >= 0 && param1 < width && _loc5_ >= 0 && _loc5_ < height)
            {
               si32(param4,_loc5_ * width + param1 << 2);
            }
            _loc5_ = param2 - 1;
            if(param1 >= 0 && param1 < width && _loc5_ >= 0 && _loc5_ < height)
            {
               si32(param4,_loc5_ * width + param1 << 2);
            }
            _loc5_ = param1 + 1;
            if(_loc5_ >= 0 && _loc5_ < width && param2 >= 0 && param2 < height)
            {
               si32(param4,param2 * width + _loc5_ << 2);
            }
            _loc5_ = param1 - 1;
            if(_loc5_ >= 0 && _loc5_ < width && param2 >= 0 && param2 < height)
            {
               si32(param4,param2 * width + _loc5_ << 2);
            }
            _loc5_ = param1 - 1;
            _loc6_ = param2 - 1;
            if(_loc5_ >= 0 && _loc5_ < width && _loc6_ >= 0 && _loc6_ < height)
            {
               si32(param4,_loc6_ * width + _loc5_ << 2);
            }
            _loc5_ = param1 - 1;
            _loc6_ = param2 + 1;
            if(_loc5_ >= 0 && _loc5_ < width && _loc6_ >= 0 && _loc6_ < height)
            {
               si32(param4,_loc6_ * width + _loc5_ << 2);
            }
            _loc5_ = param1 + 1;
            _loc6_ = param2 - 1;
            if(_loc5_ >= 0 && _loc5_ < width && _loc6_ >= 0 && _loc6_ < height)
            {
               si32(param4,_loc6_ * width + _loc5_ << 2);
            }
            _loc5_ = param1 + 1;
            _loc6_ = param2 + 1;
            if(_loc5_ >= 0 && _loc5_ < width && _loc6_ >= 0 && _loc6_ < height)
            {
               si32(param4,_loc6_ * width + _loc5_ << 2);
            }
         }
         else
         {
            _loc5_ = 0;
            _loc6_ = param3;
            _loc7_ = 3 - 2 * param3;
            while(_loc6_ >= _loc5_)
            {
               _loc8_ = param1 - _loc5_;
               _loc9_ = param1 + _loc5_ + 1;
               while(_loc8_ < _loc9_)
               {
                  _loc10_ = _loc8_++;
                  _loc11_ = param2 - _loc6_;
                  if(_loc10_ >= 0 && _loc10_ < width && _loc11_ >= 0 && _loc11_ < height)
                  {
                     si32(param4,_loc11_ * width + _loc10_ << 2);
                  }
                  _loc11_ = param2 + _loc6_;
                  if(_loc10_ >= 0 && _loc10_ < width && _loc11_ >= 0 && _loc11_ < height)
                  {
                     si32(param4,_loc11_ * width + _loc10_ << 2);
                  }
               }
               _loc8_ = param1 - _loc6_;
               _loc9_ = param1 + _loc6_ + 1;
               while(_loc8_ < _loc9_)
               {
                  _loc10_ = _loc8_++;
                  _loc11_ = param2 + _loc5_;
                  if(_loc10_ >= 0 && _loc10_ < width && _loc11_ >= 0 && _loc11_ < height)
                  {
                     si32(param4,_loc11_ * width + _loc10_ << 2);
                  }
                  _loc11_ = param2 - _loc5_;
                  if(_loc10_ >= 0 && _loc10_ < width && _loc11_ >= 0 && _loc11_ < height)
                  {
                     si32(param4,_loc11_ * width + _loc10_ << 2);
                  }
               }
               if(_loc7_ < 0)
               {
                  _loc7_ += 6 + (_loc5_++ << 2);
               }
               else
               {
                  _loc7_ += 10 + (_loc5_++ - _loc6_-- << 2);
               }
            }
         }
      }
      
      public function __curve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as Vec2;
         var _loc13_:Boolean = false;
         var _loc14_:* = null as Vec2;
         var _loc15_:Boolean = false;
         var _loc16_:* = null as Vec2;
         var _loc17_:* = null as Vec2;
         var _loc18_:* = null as ZPP_Vec2;
         §§push(0.25);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.x);
         §§push(2);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(§§pop() + §§pop() * param2.zpp_inner.x);
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param3.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc5_:Number = §§pop() * (§§pop() + param3.zpp_inner.x);
         §§push(0.25);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.y);
         §§push(2);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(§§pop() + §§pop() * param2.zpp_inner.y);
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param3.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc7_:Number = §§pop() * (§§pop() + param3.zpp_inner.y);
         §§push(0.5);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.x);
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param3.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc8_:Number = §§pop() * (§§pop() + param3.zpp_inner.x);
         §§push(0.5);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.y);
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param3.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc9_:Number = §§pop() * (§§pop() + param3.zpp_inner.y);
         _loc10_ = 0;
         _loc11_ = 0;
         _loc10_ = _loc5_ - _loc8_;
         _loc11_ = _loc7_ - _loc9_;
         if(_loc10_ * _loc10_ + _loc11_ * _loc11_ < 0.3)
         {
            §§push(§§findproperty(__line));
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param1.zpp_inner.x + 0.5);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param1.zpp_inner.y + 0.5);
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param3.zpp_inner.x + 0.5);
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§pop().__line(§§pop(),§§pop(),§§pop(),param3.zpp_inner.y + 0.5,param4);
         }
         else
         {
            §§push(0.5);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param1.zpp_inner.x);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc10_ = §§pop() * (§§pop() + param2.zpp_inner.x);
            §§push(0.5);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param1.zpp_inner.y);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc11_ = §§pop() * (§§pop() + param2.zpp_inner.y);
            _loc13_ = false;
            if(_loc10_ != _loc10_ || _loc11_ != _loc11_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc14_ = new Vec2();
            }
            else
            {
               _loc14_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc14_.zpp_pool;
               _loc14_.zpp_pool = null;
               _loc14_.zpp_disp = false;
               if(_loc14_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc14_.zpp_inner == null)
            {
               _loc15_ = false;
               §§push(_loc14_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc6_ = new ZPP_Vec2();
               }
               else
               {
                  _loc6_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc6_.next;
                  _loc6_.next = null;
               }
               _loc6_.weak = false;
               _loc6_._immutable = _loc15_;
               _loc6_.x = _loc10_;
               _loc6_.y = _loc11_;
               §§pop().zpp_inner = _loc6_;
               _loc14_.zpp_inner.outer = _loc14_;
            }
            else
            {
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc14_.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(_loc10_ != _loc10_ || _loc11_ != _loc11_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc14_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               if(_loc14_.zpp_inner.x == _loc10_)
               {
                  §§pop();
                  if(_loc14_ != null && _loc14_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc6_ = _loc14_.zpp_inner;
                  if(_loc6_._validate != null)
                  {
                     _loc6_._validate();
                  }
                  §§push(_loc14_.zpp_inner.y == _loc11_);
               }
               if(!§§pop())
               {
                  _loc14_.zpp_inner.x = _loc10_;
                  _loc14_.zpp_inner.y = _loc11_;
                  _loc6_ = _loc14_.zpp_inner;
                  if(_loc6_._invalidate != null)
                  {
                     _loc6_._invalidate(_loc6_);
                  }
               }
               _loc14_;
            }
            _loc14_.zpp_inner.weak = _loc13_;
            _loc12_ = _loc14_;
            §§push(0.5);
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param3.zpp_inner.x);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc10_ = §§pop() * (§§pop() + param2.zpp_inner.x);
            §§push(0.5);
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param3.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(param3.zpp_inner.y);
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc11_ = §§pop() * (§§pop() + param2.zpp_inner.y);
            _loc13_ = false;
            if(_loc10_ != _loc10_ || _loc11_ != _loc11_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc16_ = new Vec2();
            }
            else
            {
               _loc16_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc16_.zpp_pool;
               _loc16_.zpp_pool = null;
               _loc16_.zpp_disp = false;
               if(_loc16_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc16_.zpp_inner == null)
            {
               _loc15_ = false;
               §§push(_loc16_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc6_ = new ZPP_Vec2();
               }
               else
               {
                  _loc6_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc6_.next;
                  _loc6_.next = null;
               }
               _loc6_.weak = false;
               _loc6_._immutable = _loc15_;
               _loc6_.x = _loc10_;
               _loc6_.y = _loc11_;
               §§pop().zpp_inner = _loc6_;
               _loc16_.zpp_inner.outer = _loc16_;
            }
            else
            {
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc16_.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(_loc10_ != _loc10_ || _loc11_ != _loc11_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc16_ != null && _loc16_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc16_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               if(_loc16_.zpp_inner.x == _loc10_)
               {
                  §§pop();
                  if(_loc16_ != null && _loc16_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc6_ = _loc16_.zpp_inner;
                  if(_loc6_._validate != null)
                  {
                     _loc6_._validate();
                  }
                  §§push(_loc16_.zpp_inner.y == _loc11_);
               }
               if(!§§pop())
               {
                  _loc16_.zpp_inner.x = _loc10_;
                  _loc16_.zpp_inner.y = _loc11_;
                  _loc6_ = _loc16_.zpp_inner;
                  if(_loc6_._invalidate != null)
                  {
                     _loc6_._invalidate(_loc6_);
                  }
               }
               _loc16_;
            }
            _loc16_.zpp_inner.weak = _loc13_;
            _loc14_ = _loc16_;
            §§push(0.5);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc12_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc12_.zpp_inner.x);
            if(_loc14_ != null && _loc14_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc14_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc10_ = §§pop() * (§§pop() + _loc14_.zpp_inner.x);
            §§push(0.5);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc12_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc12_.zpp_inner.y);
            if(_loc14_ != null && _loc14_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc14_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc11_ = §§pop() * (§§pop() + _loc14_.zpp_inner.y);
            _loc13_ = false;
            if(_loc10_ != _loc10_ || _loc11_ != _loc11_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc17_ = new Vec2();
            }
            else
            {
               _loc17_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc17_.zpp_pool;
               _loc17_.zpp_pool = null;
               _loc17_.zpp_disp = false;
               if(_loc17_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc17_.zpp_inner == null)
            {
               _loc15_ = false;
               §§push(_loc17_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc6_ = new ZPP_Vec2();
               }
               else
               {
                  _loc6_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc6_.next;
                  _loc6_.next = null;
               }
               _loc6_.weak = false;
               _loc6_._immutable = _loc15_;
               _loc6_.x = _loc10_;
               _loc6_.y = _loc11_;
               §§pop().zpp_inner = _loc6_;
               _loc17_.zpp_inner.outer = _loc17_;
            }
            else
            {
               if(_loc17_ != null && _loc17_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc17_.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(_loc10_ != _loc10_ || _loc11_ != _loc11_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc17_ != null && _loc17_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc17_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               if(_loc17_.zpp_inner.x == _loc10_)
               {
                  §§pop();
                  if(_loc17_ != null && _loc17_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc6_ = _loc17_.zpp_inner;
                  if(_loc6_._validate != null)
                  {
                     _loc6_._validate();
                  }
                  §§push(_loc17_.zpp_inner.y == _loc11_);
               }
               if(!§§pop())
               {
                  _loc17_.zpp_inner.x = _loc10_;
                  _loc17_.zpp_inner.y = _loc11_;
                  _loc6_ = _loc17_.zpp_inner;
                  if(_loc6_._invalidate != null)
                  {
                     _loc6_._invalidate(_loc6_);
                  }
               }
               _loc17_;
            }
            _loc17_.zpp_inner.weak = _loc13_;
            _loc16_ = _loc17_;
            __curve(param1,_loc12_,_loc16_,param4);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc12_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc12_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc12_.zpp_inner;
            _loc12_.zpp_inner.outer = null;
            _loc12_.zpp_inner = null;
            _loc17_ = _loc12_;
            _loc17_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc17_;
            }
            ZPP_PubPool.nextVec2 = _loc17_;
            _loc17_.zpp_disp = true;
            _loc18_ = _loc6_;
            if(_loc18_.outer != null)
            {
               _loc18_.outer.zpp_inner = null;
               _loc18_.outer = null;
            }
            _loc18_._isimmutable = null;
            _loc18_._validate = null;
            _loc18_._invalidate = null;
            _loc18_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc18_;
            __curve(param3,_loc14_,_loc16_,param4);
            if(_loc14_ != null && _loc14_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc14_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc14_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc14_.zpp_inner;
            _loc14_.zpp_inner.outer = null;
            _loc14_.zpp_inner = null;
            _loc17_ = _loc14_;
            _loc17_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc17_;
            }
            ZPP_PubPool.nextVec2 = _loc17_;
            _loc17_.zpp_disp = true;
            _loc18_ = _loc6_;
            if(_loc18_.outer != null)
            {
               _loc18_.outer.zpp_inner = null;
               _loc18_.outer = null;
            }
            _loc18_._isimmutable = null;
            _loc18_._validate = null;
            _loc18_._invalidate = null;
            _loc18_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc18_;
            if(_loc16_ != null && _loc16_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc16_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc16_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = _loc16_.zpp_inner;
            _loc16_.zpp_inner.outer = null;
            _loc16_.zpp_inner = null;
            _loc17_ = _loc16_;
            _loc17_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc17_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc17_;
            }
            ZPP_PubPool.nextVec2 = _loc17_;
            _loc17_.zpp_disp = true;
            _loc18_ = _loc6_;
            if(_loc18_.outer != null)
            {
               _loc18_.outer.zpp_inner = null;
               _loc18_.outer = null;
            }
            _loc18_._isimmutable = null;
            _loc18_._validate = null;
            _loc18_._invalidate = null;
            _loc18_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc18_;
         }
      }
      
      public function __circle(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(param3 == 0)
         {
            if(param1 >= 0 && param1 < width && param2 >= 0 && param2 < height)
            {
               si32(param4,param2 * width + param1 << 2);
            }
         }
         else if(param3 == 1)
         {
            _loc5_ = param2 + 1;
            if(param1 >= 0 && param1 < width && _loc5_ >= 0 && _loc5_ < height)
            {
               si32(param4,_loc5_ * width + param1 << 2);
            }
            _loc5_ = param2 - 1;
            if(param1 >= 0 && param1 < width && _loc5_ >= 0 && _loc5_ < height)
            {
               si32(param4,_loc5_ * width + param1 << 2);
            }
            _loc5_ = param1 + 1;
            if(_loc5_ >= 0 && _loc5_ < width && param2 >= 0 && param2 < height)
            {
               si32(param4,param2 * width + _loc5_ << 2);
            }
            _loc5_ = param1 - 1;
            if(_loc5_ >= 0 && _loc5_ < width && param2 >= 0 && param2 < height)
            {
               si32(param4,param2 * width + _loc5_ << 2);
            }
            _loc5_ = param1 - 1;
            _loc6_ = param2 - 1;
            if(_loc5_ >= 0 && _loc5_ < width && _loc6_ >= 0 && _loc6_ < height)
            {
               si32(param4,_loc6_ * width + _loc5_ << 2);
            }
            _loc5_ = param1 - 1;
            _loc6_ = param2 + 1;
            if(_loc5_ >= 0 && _loc5_ < width && _loc6_ >= 0 && _loc6_ < height)
            {
               si32(param4,_loc6_ * width + _loc5_ << 2);
            }
            _loc5_ = param1 + 1;
            _loc6_ = param2 - 1;
            if(_loc5_ >= 0 && _loc5_ < width && _loc6_ >= 0 && _loc6_ < height)
            {
               si32(param4,_loc6_ * width + _loc5_ << 2);
            }
            _loc5_ = param1 + 1;
            _loc6_ = param2 + 1;
            if(_loc5_ >= 0 && _loc5_ < width && _loc6_ >= 0 && _loc6_ < height)
            {
               si32(param4,_loc6_ * width + _loc5_ << 2);
            }
         }
         else
         {
            _loc5_ = 0;
            _loc6_ = param3;
            _loc7_ = 3 - 2 * param3;
            while(_loc6_ >= _loc5_)
            {
               _loc8_ = param1 + _loc5_;
               _loc9_ = param2 + _loc6_;
               if(_loc8_ >= 0 && _loc8_ < width && _loc9_ >= 0 && _loc9_ < height)
               {
                  si32(param4,_loc9_ * width + _loc8_ << 2);
               }
               _loc8_ = param1 + _loc5_;
               _loc9_ = param2 - _loc6_;
               if(_loc8_ >= 0 && _loc8_ < width && _loc9_ >= 0 && _loc9_ < height)
               {
                  si32(param4,_loc9_ * width + _loc8_ << 2);
               }
               _loc8_ = param1 - _loc5_;
               _loc9_ = param2 + _loc6_;
               if(_loc8_ >= 0 && _loc8_ < width && _loc9_ >= 0 && _loc9_ < height)
               {
                  si32(param4,_loc9_ * width + _loc8_ << 2);
               }
               _loc8_ = param1 - _loc5_;
               _loc9_ = param2 - _loc6_;
               if(_loc8_ >= 0 && _loc8_ < width && _loc9_ >= 0 && _loc9_ < height)
               {
                  si32(param4,_loc9_ * width + _loc8_ << 2);
               }
               _loc8_ = param1 + _loc6_;
               _loc9_ = param2 + _loc5_;
               if(_loc8_ >= 0 && _loc8_ < width && _loc9_ >= 0 && _loc9_ < height)
               {
                  si32(param4,_loc9_ * width + _loc8_ << 2);
               }
               _loc8_ = param1 + _loc6_;
               _loc9_ = param2 - _loc5_;
               if(_loc8_ >= 0 && _loc8_ < width && _loc9_ >= 0 && _loc9_ < height)
               {
                  si32(param4,_loc9_ * width + _loc8_ << 2);
               }
               _loc8_ = param1 - _loc6_;
               _loc9_ = param2 + _loc5_;
               if(_loc8_ >= 0 && _loc8_ < width && _loc9_ >= 0 && _loc9_ < height)
               {
                  si32(param4,_loc9_ * width + _loc8_ << 2);
               }
               _loc8_ = param1 - _loc6_;
               _loc9_ = param2 - _loc5_;
               if(_loc8_ >= 0 && _loc8_ < width && _loc9_ >= 0 && _loc9_ < height)
               {
                  si32(param4,_loc9_ * width + _loc8_ << 2);
               }
               if(_loc7_ < 0)
               {
                  _loc7_ += 6 + (_loc5_++ << 2);
               }
               else
               {
                  _loc7_ += 10 + (_loc5_++ - _loc6_-- << 2);
               }
            }
         }
      }
      
      public function __box(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         param5 |= -16777216;
         __line(param1,param2,param1,param4,param5);
         __line(param1,param4,param3,param4,param5);
         __line(param3,param4,param3,param2,param5);
         __line(param3,param2,param1,param2,param5);
      }
      
      public function __aabb(param1:ZPP_AABB, param2:int) : void
      {
         param2 |= -16777216;
         var _loc3_:Boolean = param1.minx > -1.79e+308;
         var _loc4_:Boolean = param1.maxx < 1.79e+308;
         var _loc5_:Boolean = param1.miny > -1.79e+308;
         var _loc6_:Boolean = param1.maxy < 1.79e+308;
         var _loc7_:int = _loc3_ ? param1.minx + 0.5 : 0;
         var _loc8_:int = _loc4_ ? param1.maxx + 0.5 : width;
         var _loc9_:int = _loc5_ ? param1.miny + 0.5 : 0;
         var _loc10_:int = _loc6_ ? param1.maxy + 0.5 : height;
         if(_loc3_)
         {
            __line(_loc7_,_loc9_,_loc7_,_loc10_,param2);
         }
         if(_loc4_)
         {
            __line(_loc8_,_loc9_,_loc8_,_loc10_,param2);
         }
         if(_loc5_)
         {
            __line(_loc7_,_loc9_,_loc8_,_loc9_,param2);
         }
         if(_loc6_)
         {
            __line(_loc7_,_loc10_,_loc8_,_loc10_,param2);
         }
      }
   }
}
