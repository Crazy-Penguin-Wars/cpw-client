package nape.geom
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.Config;
   import zpp_nape.ZPP_Const;
   import zpp_nape.geom.ZPP_Convex;
   import zpp_nape.geom.ZPP_Cutter;
   import zpp_nape.geom.ZPP_GeomPoly;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_GeomVertexIterator;
   import zpp_nape.geom.ZPP_Monotone;
   import zpp_nape.geom.ZPP_PartitionedPoly;
   import zpp_nape.geom.ZPP_Simple;
   import zpp_nape.geom.ZPP_Simplify;
   import zpp_nape.geom.ZPP_Triangular;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZNPList_ZPP_GeomVert;
   import zpp_nape.util.ZNPList_ZPP_PartitionedPoly;
   import zpp_nape.util.ZNPList_ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_GeomVert;
   import zpp_nape.util.ZNPNode_ZPP_PartitionedPoly;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class GeomPoly
   {
       
      
      public var zpp_pool:GeomPoly;
      
      public var zpp_inner:ZPP_GeomPoly;
      
      public var zpp_disp:Boolean;
      
      public function GeomPoly(param1:* = undefined)
      {
         var _loc2_:* = null as Array;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as Vector.<Vec2>;
         var _loc10_:* = null as Vec2;
         var _loc11_:* = null as Vec2List;
         var _loc12_:* = null as Vec2Iterator;
         var _loc13_:* = null as GeomPoly;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:* = null as ZPP_GeomVert;
         var _loc19_:* = null as ZPP_GeomVert;
         var _loc20_:* = null as ZPP_Vec2;
         var _loc21_:* = null as ZNPList_ZPP_Vec2;
         var _loc22_:* = null as ZNPNode_ZPP_Vec2;
         var _loc23_:* = null as ZNPNode_ZPP_Vec2;
         var _loc24_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         zpp_pool = null;
         zpp_inner = new ZPP_GeomPoly(this);
         if(param1 != null)
         {
            if(param1 is Array)
            {
               _loc2_ = param1;
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc4_ = _loc2_[_loc3_];
                  _loc3_++;
                  if(_loc4_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains null objects";
                  }
                  if(!(_loc4_ is Vec2))
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains non Vec2 objects";
                  }
                  _loc5_ = _loc4_;
                  if(_loc5_ != null && _loc5_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  §§push(zpp_inner);
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc7_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc7_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc7_.next;
                     _loc7_.next = null;
                  }
                  _loc7_.forced = false;
                  §§push(_loc7_);
                  if(_loc5_ != null && _loc5_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc8_ = _loc5_.zpp_inner;
                  if(_loc8_._validate != null)
                  {
                     _loc8_._validate();
                  }
                  §§pop().x = _loc5_.zpp_inner.x;
                  §§push(_loc7_);
                  if(_loc5_ != null && _loc5_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc8_ = _loc5_.zpp_inner;
                  if(_loc8_._validate != null)
                  {
                     _loc8_._validate();
                  }
                  §§pop().y = _loc5_.zpp_inner.y;
                  _loc6_ = _loc7_;
                  if(zpp_inner.vertices == null)
                  {
                     zpp_inner.vertices = _loc6_.prev = _loc6_.next = _loc6_;
                  }
                  else
                  {
                     _loc6_.prev = zpp_inner.vertices;
                     _loc6_.next = zpp_inner.vertices.next;
                     zpp_inner.vertices.next.prev = _loc6_;
                     zpp_inner.vertices.next = _loc6_;
                  }
                  §§pop().vertices = _loc6_;
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc9_ = param1;
               _loc3_ = 0;
               while(_loc3_ < _loc9_.length)
               {
                  _loc5_ = _loc9_[_loc3_];
                  _loc3_++;
                  if(_loc5_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: flash.Vector<Vec2> contains null objects";
                  }
                  _loc10_ = _loc5_;
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  §§push(zpp_inner);
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc7_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc7_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc7_.next;
                     _loc7_.next = null;
                  }
                  _loc7_.forced = false;
                  §§push(_loc7_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc8_ = _loc10_.zpp_inner;
                  if(_loc8_._validate != null)
                  {
                     _loc8_._validate();
                  }
                  §§pop().x = _loc10_.zpp_inner.x;
                  §§push(_loc7_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc8_ = _loc10_.zpp_inner;
                  if(_loc8_._validate != null)
                  {
                     _loc8_._validate();
                  }
                  §§pop().y = _loc10_.zpp_inner.y;
                  _loc6_ = _loc7_;
                  if(zpp_inner.vertices == null)
                  {
                     zpp_inner.vertices = _loc6_.prev = _loc6_.next = _loc6_;
                  }
                  else
                  {
                     _loc6_.prev = zpp_inner.vertices;
                     _loc6_.next = zpp_inner.vertices.next;
                     zpp_inner.vertices.next.prev = _loc6_;
                     zpp_inner.vertices.next = _loc6_;
                  }
                  §§pop().vertices = _loc6_;
               }
            }
            else if(param1 is Vec2List)
            {
               _loc11_ = param1;
               _loc12_ = _loc11_.iterator();
               while(true)
               {
                  _loc12_.zpp_inner.zpp_inner.valmod();
                  _loc3_ = _loc12_.zpp_inner.zpp_gl();
                  _loc12_.zpp_critical = true;
                  if(!(_loc12_.zpp_i < _loc3_ ? true : (_loc12_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc12_, _loc12_.zpp_inner = null, false)))
                  {
                     break;
                  }
                  _loc12_.zpp_critical = false;
                  _loc12_.zpp_i = (_loc3_ = _loc12_.zpp_i) + 1;
                  _loc5_ = _loc12_.zpp_inner.at(_loc3_);
                  if(_loc5_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2List contains null objects";
                  }
                  if(_loc5_ != null && _loc5_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  §§push(zpp_inner);
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc7_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc7_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc7_.next;
                     _loc7_.next = null;
                  }
                  _loc7_.forced = false;
                  §§push(_loc7_);
                  if(_loc5_ != null && _loc5_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc8_ = _loc5_.zpp_inner;
                  if(_loc8_._validate != null)
                  {
                     _loc8_._validate();
                  }
                  §§pop().x = _loc5_.zpp_inner.x;
                  §§push(_loc7_);
                  if(_loc5_ != null && _loc5_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc8_ = _loc5_.zpp_inner;
                  if(_loc8_._validate != null)
                  {
                     _loc8_._validate();
                  }
                  §§pop().y = _loc5_.zpp_inner.y;
                  _loc6_ = _loc7_;
                  if(zpp_inner.vertices == null)
                  {
                     zpp_inner.vertices = _loc6_.prev = _loc6_.next = _loc6_;
                  }
                  else
                  {
                     _loc6_.prev = zpp_inner.vertices;
                     _loc6_.next = zpp_inner.vertices.next;
                     zpp_inner.vertices.next.prev = _loc6_;
                     zpp_inner.vertices.next = _loc6_;
                  }
                  §§pop().vertices = _loc6_;
               }
            }
            else
            {
               if(!(param1 is GeomPoly))
               {
                  Boot.lastError = new Error();
                  throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
               }
               _loc13_ = param1;
               if(_loc13_ != null && _loc13_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc13_.zpp_inner.vertices;
               if(_loc6_ != null)
               {
                  _loc7_ = _loc6_;
                  while(true)
                  {
                     _loc14_ = _loc7_.x;
                     _loc15_ = _loc7_.y;
                     _loc16_ = false;
                     if(_loc14_ != _loc14_ || _loc15_ != _loc15_)
                     {
                        break;
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc10_ = new Vec2();
                     }
                     else
                     {
                        _loc10_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc10_.zpp_pool;
                        _loc10_.zpp_pool = null;
                        _loc10_.zpp_disp = false;
                        if(_loc10_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc10_.zpp_inner == null)
                     {
                        _loc17_ = false;
                        §§push(_loc10_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc8_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc8_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc8_.next;
                           _loc8_.next = null;
                        }
                        _loc8_.weak = false;
                        _loc8_._immutable = _loc17_;
                        _loc8_.x = _loc14_;
                        _loc8_.y = _loc15_;
                        §§pop().zpp_inner = _loc8_;
                        _loc10_.zpp_inner.outer = _loc10_;
                     }
                     else
                     {
                        if(_loc10_ != null && _loc10_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc8_ = _loc10_.zpp_inner;
                        if(_loc8_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc8_._isimmutable != null)
                        {
                           _loc8_._isimmutable();
                        }
                        if(_loc14_ != _loc14_ || _loc15_ != _loc15_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc10_ != null && _loc10_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc8_ = _loc10_.zpp_inner;
                        if(_loc8_._validate != null)
                        {
                           _loc8_._validate();
                        }
                        if(_loc10_.zpp_inner.x == _loc14_)
                        {
                           §§pop();
                           if(_loc10_ != null && _loc10_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc8_ = _loc10_.zpp_inner;
                           if(_loc8_._validate != null)
                           {
                              _loc8_._validate();
                           }
                           §§push(_loc10_.zpp_inner.y == _loc15_);
                        }
                        if(!§§pop())
                        {
                           _loc10_.zpp_inner.x = _loc14_;
                           _loc10_.zpp_inner.y = _loc15_;
                           _loc8_ = _loc10_.zpp_inner;
                           if(_loc8_._invalidate != null)
                           {
                              _loc8_._invalidate(_loc8_);
                           }
                        }
                        _loc10_;
                     }
                     _loc10_.zpp_inner.weak = _loc16_;
                     _loc5_ = _loc10_;
                     _loc7_ = _loc7_.next;
                     §§push(zpp_inner);
                     if(ZPP_GeomVert.zpp_pool == null)
                     {
                        _loc19_ = new ZPP_GeomVert();
                     }
                     else
                     {
                        _loc19_ = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc19_.next;
                        _loc19_.next = null;
                     }
                     _loc19_.forced = false;
                     §§push(_loc19_);
                     if(_loc5_ != null && _loc5_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc8_ = _loc5_.zpp_inner;
                     if(_loc8_._validate != null)
                     {
                        _loc8_._validate();
                     }
                     §§pop().x = _loc5_.zpp_inner.x;
                     §§push(_loc19_);
                     if(_loc5_ != null && _loc5_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc8_ = _loc5_.zpp_inner;
                     if(_loc8_._validate != null)
                     {
                        _loc8_._validate();
                     }
                     §§pop().y = _loc5_.zpp_inner.y;
                     _loc18_ = _loc19_;
                     if(zpp_inner.vertices == null)
                     {
                        zpp_inner.vertices = _loc18_.prev = _loc18_.next = _loc18_;
                     }
                     else
                     {
                        _loc18_.prev = zpp_inner.vertices;
                        _loc18_.next = zpp_inner.vertices.next;
                        zpp_inner.vertices.next.prev = _loc18_;
                        zpp_inner.vertices.next = _loc18_;
                     }
                     §§pop().vertices = _loc18_;
                     if(_loc5_ != null && _loc5_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc8_ = _loc5_.zpp_inner;
                     if(_loc8_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc8_._isimmutable != null)
                     {
                        _loc8_._isimmutable();
                     }
                     if(_loc5_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc8_ = _loc5_.zpp_inner;
                     _loc5_.zpp_inner.outer = null;
                     _loc5_.zpp_inner = null;
                     _loc10_ = _loc5_;
                     _loc10_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc10_;
                     }
                     ZPP_PubPool.nextVec2 = _loc10_;
                     _loc10_.zpp_disp = true;
                     _loc20_ = _loc8_;
                     if(_loc20_.outer != null)
                     {
                        _loc20_.outer.zpp_inner = null;
                        _loc20_.outer = null;
                     }
                     _loc20_._isimmutable = null;
                     _loc20_._validate = null;
                     _loc20_._invalidate = null;
                     _loc20_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc20_;
                     if(_loc7_ != _loc6_)
                     {
                        continue;
                     }
                  }
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
            }
            skipForward(1);
            if(param1 is Array)
            {
               _loc2_ = param1;
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc5_ = _loc2_[_loc3_];
                  if(_loc5_.zpp_inner.weak)
                  {
                     if(_loc5_ != null && _loc5_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc8_ = _loc5_.zpp_inner;
                     if(_loc8_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc8_._isimmutable != null)
                     {
                        _loc8_._isimmutable();
                     }
                     if(_loc5_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc8_ = _loc5_.zpp_inner;
                     _loc5_.zpp_inner.outer = null;
                     _loc5_.zpp_inner = null;
                     _loc10_ = _loc5_;
                     _loc10_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc10_;
                     }
                     ZPP_PubPool.nextVec2 = _loc10_;
                     _loc10_.zpp_disp = true;
                     _loc20_ = _loc8_;
                     if(_loc20_.outer != null)
                     {
                        _loc20_.outer.zpp_inner = null;
                        _loc20_.outer = null;
                     }
                     _loc20_._isimmutable = null;
                     _loc20_._validate = null;
                     _loc20_._invalidate = null;
                     _loc20_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc20_;
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  if(§§pop())
                  {
                     _loc2_.splice(_loc3_,1);
                  }
                  else
                  {
                     _loc3_++;
                  }
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc9_ = param1;
               if(!_loc9_.fixed)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc9_.length)
                  {
                     _loc5_ = _loc9_[_loc3_];
                     if(_loc5_.zpp_inner.weak)
                     {
                        if(_loc5_ != null && _loc5_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc8_ = _loc5_.zpp_inner;
                        if(_loc8_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc8_._isimmutable != null)
                        {
                           _loc8_._isimmutable();
                        }
                        if(_loc5_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc8_ = _loc5_.zpp_inner;
                        _loc5_.zpp_inner.outer = null;
                        _loc5_.zpp_inner = null;
                        _loc10_ = _loc5_;
                        _loc10_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc10_;
                        }
                        ZPP_PubPool.nextVec2 = _loc10_;
                        _loc10_.zpp_disp = true;
                        _loc20_ = _loc8_;
                        if(_loc20_.outer != null)
                        {
                           _loc20_.outer.zpp_inner = null;
                           _loc20_.outer = null;
                        }
                        _loc20_._isimmutable = null;
                        _loc20_._validate = null;
                        _loc20_._invalidate = null;
                        _loc20_.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc20_;
                        §§push(true);
                     }
                     else
                     {
                        §§push(false);
                     }
                     if(§§pop())
                     {
                        _loc9_.splice(_loc3_,1);
                     }
                     else
                     {
                        _loc3_++;
                     }
                  }
               }
            }
            else if(param1 is Vec2List)
            {
               _loc11_ = param1;
               if(_loc11_.zpp_inner._validate != null)
               {
                  _loc11_.zpp_inner._validate();
               }
               _loc21_ = _loc11_.zpp_inner.inner;
               _loc22_ = null;
               _loc23_ = _loc21_.head;
               while(_loc23_ != null)
               {
                  _loc8_ = _loc23_.elt;
                  if(_loc8_.outer.zpp_inner.weak)
                  {
                     _loc23_ = _loc21_.erase(_loc22_);
                     if(_loc8_.outer.zpp_inner.weak)
                     {
                        _loc5_ = _loc8_.outer;
                        if(_loc5_ != null && _loc5_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc20_ = _loc5_.zpp_inner;
                        if(_loc20_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc20_._isimmutable != null)
                        {
                           _loc20_._isimmutable();
                        }
                        if(_loc5_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc20_ = _loc5_.zpp_inner;
                        _loc5_.zpp_inner.outer = null;
                        _loc5_.zpp_inner = null;
                        _loc10_ = _loc5_;
                        _loc10_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc10_;
                        }
                        ZPP_PubPool.nextVec2 = _loc10_;
                        _loc10_.zpp_disp = true;
                        _loc24_ = _loc20_;
                        if(_loc24_.outer != null)
                        {
                           _loc24_.outer.zpp_inner = null;
                           _loc24_.outer = null;
                        }
                        _loc24_._isimmutable = null;
                        _loc24_._validate = null;
                        _loc24_._invalidate = null;
                        _loc24_.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc24_;
                     }
                  }
                  else
                  {
                     _loc22_ = _loc23_;
                     _loc23_ = _loc23_.next;
                  }
               }
            }
         }
      }
      
      public static function get(param1:* = undefined) : GeomPoly
      {
         var _loc2_:* = null as GeomPoly;
         var _loc3_:* = null as Array;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_GeomVert;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as Vector.<Vec2>;
         var _loc11_:* = null as Vec2;
         var _loc12_:* = null as Vec2List;
         var _loc13_:* = null as Vec2Iterator;
         var _loc14_:* = null as GeomPoly;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:* = null as ZPP_GeomVert;
         var _loc20_:* = null as ZPP_GeomVert;
         var _loc21_:* = null as ZPP_Vec2;
         var _loc22_:* = null as ZNPList_ZPP_Vec2;
         var _loc23_:* = null as ZNPNode_ZPP_Vec2;
         var _loc24_:* = null as ZNPNode_ZPP_Vec2;
         var _loc25_:* = null as ZPP_Vec2;
         if(ZPP_PubPool.poolGeomPoly == null)
         {
            _loc2_ = new GeomPoly();
         }
         else
         {
            _loc2_ = ZPP_PubPool.poolGeomPoly;
            ZPP_PubPool.poolGeomPoly = _loc2_.zpp_pool;
            _loc2_.zpp_pool = null;
            _loc2_.zpp_disp = false;
            if(_loc2_ == ZPP_PubPool.nextGeomPoly)
            {
               ZPP_PubPool.nextGeomPoly = null;
            }
         }
         if(param1 != null)
         {
            if(param1 is Array)
            {
               _loc3_ = param1;
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc5_ = _loc3_[_loc4_];
                  _loc4_++;
                  if(_loc5_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains null objects";
                  }
                  if(!(_loc5_ is Vec2))
                  {
                     Boot.lastError = new Error();
                     throw "Error: Array<Vec2> contains non Vec2 objects";
                  }
                  _loc6_ = _loc5_;
                  if(_loc6_ != null && _loc6_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  §§push(_loc2_.zpp_inner);
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc8_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc8_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc8_.next;
                     _loc8_.next = null;
                  }
                  _loc8_.forced = false;
                  §§push(_loc8_);
                  if(_loc6_ != null && _loc6_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc9_ = _loc6_.zpp_inner;
                  if(_loc9_._validate != null)
                  {
                     _loc9_._validate();
                  }
                  §§pop().x = _loc6_.zpp_inner.x;
                  §§push(_loc8_);
                  if(_loc6_ != null && _loc6_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc9_ = _loc6_.zpp_inner;
                  if(_loc9_._validate != null)
                  {
                     _loc9_._validate();
                  }
                  §§pop().y = _loc6_.zpp_inner.y;
                  _loc7_ = _loc8_;
                  if(_loc2_.zpp_inner.vertices == null)
                  {
                     _loc2_.zpp_inner.vertices = _loc7_.prev = _loc7_.next = _loc7_;
                  }
                  else
                  {
                     _loc7_.prev = _loc2_.zpp_inner.vertices;
                     _loc7_.next = _loc2_.zpp_inner.vertices.next;
                     _loc2_.zpp_inner.vertices.next.prev = _loc7_;
                     _loc2_.zpp_inner.vertices.next = _loc7_;
                  }
                  §§pop().vertices = _loc7_;
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc10_ = param1;
               _loc4_ = 0;
               while(_loc4_ < _loc10_.length)
               {
                  _loc6_ = _loc10_[_loc4_];
                  _loc4_++;
                  if(_loc6_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: flash.Vector<Vec2> contains null objects";
                  }
                  _loc11_ = _loc6_;
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  §§push(_loc2_.zpp_inner);
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc8_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc8_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc8_.next;
                     _loc8_.next = null;
                  }
                  _loc8_.forced = false;
                  §§push(_loc8_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc9_ = _loc11_.zpp_inner;
                  if(_loc9_._validate != null)
                  {
                     _loc9_._validate();
                  }
                  §§pop().x = _loc11_.zpp_inner.x;
                  §§push(_loc8_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc9_ = _loc11_.zpp_inner;
                  if(_loc9_._validate != null)
                  {
                     _loc9_._validate();
                  }
                  §§pop().y = _loc11_.zpp_inner.y;
                  _loc7_ = _loc8_;
                  if(_loc2_.zpp_inner.vertices == null)
                  {
                     _loc2_.zpp_inner.vertices = _loc7_.prev = _loc7_.next = _loc7_;
                  }
                  else
                  {
                     _loc7_.prev = _loc2_.zpp_inner.vertices;
                     _loc7_.next = _loc2_.zpp_inner.vertices.next;
                     _loc2_.zpp_inner.vertices.next.prev = _loc7_;
                     _loc2_.zpp_inner.vertices.next = _loc7_;
                  }
                  §§pop().vertices = _loc7_;
               }
            }
            else if(param1 is Vec2List)
            {
               _loc12_ = param1;
               _loc13_ = _loc12_.iterator();
               while(true)
               {
                  _loc13_.zpp_inner.zpp_inner.valmod();
                  _loc4_ = _loc13_.zpp_inner.zpp_gl();
                  _loc13_.zpp_critical = true;
                  if(!(_loc13_.zpp_i < _loc4_ ? true : (_loc13_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc13_, _loc13_.zpp_inner = null, false)))
                  {
                     break;
                  }
                  _loc13_.zpp_critical = false;
                  _loc13_.zpp_i = (_loc4_ = _loc13_.zpp_i) + 1;
                  _loc6_ = _loc13_.zpp_inner.at(_loc4_);
                  if(_loc6_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2List contains null objects";
                  }
                  if(_loc6_ != null && _loc6_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  §§push(_loc2_.zpp_inner);
                  if(ZPP_GeomVert.zpp_pool == null)
                  {
                     _loc8_ = new ZPP_GeomVert();
                  }
                  else
                  {
                     _loc8_ = ZPP_GeomVert.zpp_pool;
                     ZPP_GeomVert.zpp_pool = _loc8_.next;
                     _loc8_.next = null;
                  }
                  _loc8_.forced = false;
                  §§push(_loc8_);
                  if(_loc6_ != null && _loc6_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc9_ = _loc6_.zpp_inner;
                  if(_loc9_._validate != null)
                  {
                     _loc9_._validate();
                  }
                  §§pop().x = _loc6_.zpp_inner.x;
                  §§push(_loc8_);
                  if(_loc6_ != null && _loc6_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc9_ = _loc6_.zpp_inner;
                  if(_loc9_._validate != null)
                  {
                     _loc9_._validate();
                  }
                  §§pop().y = _loc6_.zpp_inner.y;
                  _loc7_ = _loc8_;
                  if(_loc2_.zpp_inner.vertices == null)
                  {
                     _loc2_.zpp_inner.vertices = _loc7_.prev = _loc7_.next = _loc7_;
                  }
                  else
                  {
                     _loc7_.prev = _loc2_.zpp_inner.vertices;
                     _loc7_.next = _loc2_.zpp_inner.vertices.next;
                     _loc2_.zpp_inner.vertices.next.prev = _loc7_;
                     _loc2_.zpp_inner.vertices.next = _loc7_;
                  }
                  §§pop().vertices = _loc7_;
               }
            }
            else
            {
               if(!(param1 is GeomPoly))
               {
                  Boot.lastError = new Error();
                  throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
               }
               _loc14_ = param1;
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc14_.zpp_inner.vertices;
               if(_loc7_ != null)
               {
                  _loc8_ = _loc7_;
                  while(true)
                  {
                     _loc15_ = _loc8_.x;
                     _loc16_ = _loc8_.y;
                     _loc17_ = false;
                     if(_loc15_ != _loc15_ || _loc16_ != _loc16_)
                     {
                        break;
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc11_ = new Vec2();
                     }
                     else
                     {
                        _loc11_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc11_.zpp_pool;
                        _loc11_.zpp_pool = null;
                        _loc11_.zpp_disp = false;
                        if(_loc11_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc11_.zpp_inner == null)
                     {
                        _loc18_ = false;
                        §§push(_loc11_);
                        if(ZPP_Vec2.zpp_pool == null)
                        {
                           _loc9_ = new ZPP_Vec2();
                        }
                        else
                        {
                           _loc9_ = ZPP_Vec2.zpp_pool;
                           ZPP_Vec2.zpp_pool = _loc9_.next;
                           _loc9_.next = null;
                        }
                        _loc9_.weak = false;
                        _loc9_._immutable = _loc18_;
                        _loc9_.x = _loc15_;
                        _loc9_.y = _loc16_;
                        §§pop().zpp_inner = _loc9_;
                        _loc11_.zpp_inner.outer = _loc11_;
                     }
                     else
                     {
                        if(_loc11_ != null && _loc11_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc9_ = _loc11_.zpp_inner;
                        if(_loc9_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc9_._isimmutable != null)
                        {
                           _loc9_._isimmutable();
                        }
                        if(_loc15_ != _loc15_ || _loc16_ != _loc16_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc11_ != null && _loc11_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc9_ = _loc11_.zpp_inner;
                        if(_loc9_._validate != null)
                        {
                           _loc9_._validate();
                        }
                        if(_loc11_.zpp_inner.x == _loc15_)
                        {
                           §§pop();
                           if(_loc11_ != null && _loc11_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc9_ = _loc11_.zpp_inner;
                           if(_loc9_._validate != null)
                           {
                              _loc9_._validate();
                           }
                           §§push(_loc11_.zpp_inner.y == _loc16_);
                        }
                        if(!§§pop())
                        {
                           _loc11_.zpp_inner.x = _loc15_;
                           _loc11_.zpp_inner.y = _loc16_;
                           _loc9_ = _loc11_.zpp_inner;
                           if(_loc9_._invalidate != null)
                           {
                              _loc9_._invalidate(_loc9_);
                           }
                        }
                        _loc11_;
                     }
                     _loc11_.zpp_inner.weak = _loc17_;
                     _loc6_ = _loc11_;
                     _loc8_ = _loc8_.next;
                     §§push(_loc2_.zpp_inner);
                     if(ZPP_GeomVert.zpp_pool == null)
                     {
                        _loc20_ = new ZPP_GeomVert();
                     }
                     else
                     {
                        _loc20_ = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc20_.next;
                        _loc20_.next = null;
                     }
                     _loc20_.forced = false;
                     §§push(_loc20_);
                     if(_loc6_ != null && _loc6_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc9_ = _loc6_.zpp_inner;
                     if(_loc9_._validate != null)
                     {
                        _loc9_._validate();
                     }
                     §§pop().x = _loc6_.zpp_inner.x;
                     §§push(_loc20_);
                     if(_loc6_ != null && _loc6_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc9_ = _loc6_.zpp_inner;
                     if(_loc9_._validate != null)
                     {
                        _loc9_._validate();
                     }
                     §§pop().y = _loc6_.zpp_inner.y;
                     _loc19_ = _loc20_;
                     if(_loc2_.zpp_inner.vertices == null)
                     {
                        _loc2_.zpp_inner.vertices = _loc19_.prev = _loc19_.next = _loc19_;
                     }
                     else
                     {
                        _loc19_.prev = _loc2_.zpp_inner.vertices;
                        _loc19_.next = _loc2_.zpp_inner.vertices.next;
                        _loc2_.zpp_inner.vertices.next.prev = _loc19_;
                        _loc2_.zpp_inner.vertices.next = _loc19_;
                     }
                     §§pop().vertices = _loc19_;
                     if(_loc6_ != null && _loc6_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc9_ = _loc6_.zpp_inner;
                     if(_loc9_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc9_._isimmutable != null)
                     {
                        _loc9_._isimmutable();
                     }
                     if(_loc6_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc9_ = _loc6_.zpp_inner;
                     _loc6_.zpp_inner.outer = null;
                     _loc6_.zpp_inner = null;
                     _loc11_ = _loc6_;
                     _loc11_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc11_;
                     }
                     ZPP_PubPool.nextVec2 = _loc11_;
                     _loc11_.zpp_disp = true;
                     _loc21_ = _loc9_;
                     if(_loc21_.outer != null)
                     {
                        _loc21_.outer.zpp_inner = null;
                        _loc21_.outer = null;
                     }
                     _loc21_._isimmutable = null;
                     _loc21_._validate = null;
                     _loc21_._invalidate = null;
                     _loc21_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc21_;
                     if(_loc8_ != _loc7_)
                     {
                        continue;
                     }
                  }
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
            }
            _loc2_.skipForward(1);
            if(param1 is Array)
            {
               _loc3_ = param1;
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc6_ = _loc3_[_loc4_];
                  if(_loc6_.zpp_inner.weak)
                  {
                     if(_loc6_ != null && _loc6_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc9_ = _loc6_.zpp_inner;
                     if(_loc9_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc9_._isimmutable != null)
                     {
                        _loc9_._isimmutable();
                     }
                     if(_loc6_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc9_ = _loc6_.zpp_inner;
                     _loc6_.zpp_inner.outer = null;
                     _loc6_.zpp_inner = null;
                     _loc11_ = _loc6_;
                     _loc11_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc11_;
                     }
                     ZPP_PubPool.nextVec2 = _loc11_;
                     _loc11_.zpp_disp = true;
                     _loc21_ = _loc9_;
                     if(_loc21_.outer != null)
                     {
                        _loc21_.outer.zpp_inner = null;
                        _loc21_.outer = null;
                     }
                     _loc21_._isimmutable = null;
                     _loc21_._validate = null;
                     _loc21_._invalidate = null;
                     _loc21_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc21_;
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  if(§§pop())
                  {
                     _loc3_.splice(_loc4_,1);
                  }
                  else
                  {
                     _loc4_++;
                  }
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc10_ = param1;
               if(!_loc10_.fixed)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc10_.length)
                  {
                     _loc6_ = _loc10_[_loc4_];
                     if(_loc6_.zpp_inner.weak)
                     {
                        if(_loc6_ != null && _loc6_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc9_ = _loc6_.zpp_inner;
                        if(_loc9_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc9_._isimmutable != null)
                        {
                           _loc9_._isimmutable();
                        }
                        if(_loc6_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc9_ = _loc6_.zpp_inner;
                        _loc6_.zpp_inner.outer = null;
                        _loc6_.zpp_inner = null;
                        _loc11_ = _loc6_;
                        _loc11_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc11_;
                        }
                        ZPP_PubPool.nextVec2 = _loc11_;
                        _loc11_.zpp_disp = true;
                        _loc21_ = _loc9_;
                        if(_loc21_.outer != null)
                        {
                           _loc21_.outer.zpp_inner = null;
                           _loc21_.outer = null;
                        }
                        _loc21_._isimmutable = null;
                        _loc21_._validate = null;
                        _loc21_._invalidate = null;
                        _loc21_.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc21_;
                        §§push(true);
                     }
                     else
                     {
                        §§push(false);
                     }
                     if(§§pop())
                     {
                        _loc10_.splice(_loc4_,1);
                     }
                     else
                     {
                        _loc4_++;
                     }
                  }
               }
            }
            else if(param1 is Vec2List)
            {
               _loc12_ = param1;
               if(_loc12_.zpp_inner._validate != null)
               {
                  _loc12_.zpp_inner._validate();
               }
               _loc22_ = _loc12_.zpp_inner.inner;
               _loc23_ = null;
               _loc24_ = _loc22_.head;
               while(_loc24_ != null)
               {
                  _loc9_ = _loc24_.elt;
                  if(_loc9_.outer.zpp_inner.weak)
                  {
                     _loc24_ = _loc22_.erase(_loc23_);
                     if(_loc9_.outer.zpp_inner.weak)
                     {
                        _loc6_ = _loc9_.outer;
                        if(_loc6_ != null && _loc6_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc21_ = _loc6_.zpp_inner;
                        if(_loc21_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc21_._isimmutable != null)
                        {
                           _loc21_._isimmutable();
                        }
                        if(_loc6_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc21_ = _loc6_.zpp_inner;
                        _loc6_.zpp_inner.outer = null;
                        _loc6_.zpp_inner = null;
                        _loc11_ = _loc6_;
                        _loc11_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc11_;
                        }
                        ZPP_PubPool.nextVec2 = _loc11_;
                        _loc11_.zpp_disp = true;
                        _loc25_ = _loc21_;
                        if(_loc25_.outer != null)
                        {
                           _loc25_.outer.zpp_inner = null;
                           _loc25_.outer = null;
                        }
                        _loc25_._isimmutable = null;
                        _loc25_._validate = null;
                        _loc25_._invalidate = null;
                        _loc25_.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc25_;
                     }
                  }
                  else
                  {
                     _loc23_ = _loc24_;
                     _loc24_ = _loc24_.next;
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function winding() : Winding
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            if(ZPP_Flags.Winding_UNDEFINED == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Winding_UNDEFINED = new Winding();
               ZPP_Flags.§internal§ = false;
            }
            return ZPP_Flags.Winding_UNDEFINED;
         }
         _loc2_ = 0;
         _loc3_ = zpp_inner.vertices;
         _loc4_ = zpp_inner.vertices;
         if(_loc3_ != null)
         {
            _loc5_ = _loc3_;
            do
            {
               _loc6_ = _loc5_;
               _loc2_ += _loc6_.x * (_loc6_.next.y - _loc6_.prev.y);
               _loc5_ = _loc5_.next;
            }
            while(_loc5_ != _loc4_);
            
         }
         _loc1_ = _loc2_ * 0.5;
         if(_loc1_ > 0)
         {
            if(ZPP_Flags.Winding_CLOCKWISE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Winding_CLOCKWISE = new Winding();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Winding_CLOCKWISE);
         }
         else if(_loc1_ == 0)
         {
            if(ZPP_Flags.Winding_UNDEFINED == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Winding_UNDEFINED = new Winding();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Winding_UNDEFINED);
         }
         else
         {
            if(ZPP_Flags.Winding_ANTICLOCKWISE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Winding_ANTICLOCKWISE = new Winding();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Winding_ANTICLOCKWISE);
         }
         return §§pop();
      }
      
      public function unshift(param1:Vec2) : GeomPoly
      {
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot unshift null vertex";
         }
         §§push(zpp_inner);
         if(ZPP_GeomVert.zpp_pool == null)
         {
            _loc3_ = new ZPP_GeomVert();
         }
         else
         {
            _loc3_ = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.forced = false;
         §§push(_loc3_);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().x = param1.zpp_inner.x;
         §§push(_loc3_);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().y = param1.zpp_inner.y;
         var _loc2_:ZPP_GeomVert = _loc3_;
         if(zpp_inner.vertices == null)
         {
            zpp_inner.vertices = _loc2_.prev = _loc2_.next = _loc2_;
         }
         else
         {
            _loc2_.next = zpp_inner.vertices;
            _loc2_.prev = zpp_inner.vertices.prev;
            zpp_inner.vertices.prev.next = _loc2_;
            zpp_inner.vertices.prev = _loc2_;
         }
         §§pop().vertices = _loc2_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = param1.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc4_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc5_ = param1;
            _loc5_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc5_;
            }
            ZPP_PubPool.nextVec2 = _loc5_;
            _loc5_.zpp_disp = true;
            _loc6_ = _loc4_;
            if(_loc6_.outer != null)
            {
               _loc6_.outer.zpp_inner = null;
               _loc6_.outer = null;
            }
            _loc6_._isimmutable = null;
            _loc6_._validate = null;
            _loc6_._invalidate = null;
            _loc6_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc6_;
         }
         return this;
      }
      
      public function triangularDecomposition(param1:Boolean = false, param2:GeomPolyList = undefined) : GeomPolyList
      {
         var _loc6_:* = null as ZPP_PartitionedPoly;
         var _loc7_:* = null as ZNPList_ZPP_GeomVert;
         var _loc8_:* = null as ZPP_PartitionedPoly;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:* = null as GeomPoly;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot decompose a degenerate polygon";
         }
         §§push(ZPP_Monotone);
         §§push(zpp_inner.vertices);
         if(ZPP_Monotone.sharedPPoly == null)
         {
            ZPP_Monotone.sharedPPoly = new ZPP_PartitionedPoly();
         }
         var _loc3_:ZPP_PartitionedPoly = §§pop().decompose(§§pop(),ZPP_Monotone.sharedPPoly);
         §§push(_loc3_);
         if(ZPP_PartitionedPoly.sharedPPList == null)
         {
            ZPP_PartitionedPoly.sharedPPList = new ZNPList_ZPP_PartitionedPoly();
         }
         var _loc4_:ZNPList_ZPP_PartitionedPoly = §§pop().extract_partitions(ZPP_PartitionedPoly.sharedPPList);
         var _loc5_:GeomPolyList = param2 == null ? new GeomPolyList() : param2;
         while(_loc4_.head != null)
         {
            _loc6_ = _loc4_.pop_unsafe();
            ZPP_Triangular.triangulate(_loc6_);
            if(param1)
            {
               ZPP_Triangular.optimise(_loc6_);
            }
            §§push(_loc6_);
            if(ZPP_PartitionedPoly.sharedGVList == null)
            {
               ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
            }
            _loc7_ = §§pop().extract(ZPP_PartitionedPoly.sharedGVList);
            _loc8_ = _loc6_;
            _loc8_.next = ZPP_PartitionedPoly.zpp_pool;
            ZPP_PartitionedPoly.zpp_pool = _loc8_;
            while(_loc7_.head != null)
            {
               _loc9_ = _loc7_.pop_unsafe();
               _loc10_ = GeomPoly.get();
               _loc10_.zpp_inner.vertices = _loc9_;
               if(_loc5_.zpp_inner.reverse_flag)
               {
                  _loc5_.push(_loc10_);
               }
               else
               {
                  _loc5_.unshift(_loc10_);
               }
            }
         }
         return _loc5_;
      }
      
      public function transform(param1:Mat23) : GeomPoly
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:Number = NaN;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot transform by null matrix";
         }
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc6_ = param1.zpp_inner.a * _loc5_.x + param1.zpp_inner.b * _loc5_.y + param1.zpp_inner.tx;
               _loc5_.y = param1.zpp_inner.c * _loc5_.x + param1.zpp_inner.d * _loc5_.y + param1.zpp_inner.ty;
               _loc5_.x = _loc6_;
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return this;
      }
      
      public function top() : Vec2
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as Vec2;
         var _loc10_:Boolean = false;
         var _loc11_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null)
         {
            Boot.lastError = new Error();
            throw "Error: empty GeomPoly has no defineable topmost vertex";
         }
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices.next;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_.y < _loc1_.y)
               {
                  _loc1_ = _loc5_;
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         if(_loc1_.wrap == null)
         {
            _loc6_ = _loc1_.x;
            _loc7_ = _loc1_.y;
            _loc8_ = false;
            §§push(_loc1_);
            if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc9_ = new Vec2();
            }
            else
            {
               _loc9_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc9_.zpp_pool;
               _loc9_.zpp_pool = null;
               _loc9_.zpp_disp = false;
               if(_loc9_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc9_.zpp_inner == null)
            {
               _loc10_ = false;
               §§push(_loc9_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc11_ = new ZPP_Vec2();
               }
               else
               {
                  _loc11_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.weak = false;
               _loc11_._immutable = _loc10_;
               _loc11_.x = _loc6_;
               _loc11_.y = _loc7_;
               §§pop().zpp_inner = _loc11_;
               _loc9_.zpp_inner.outer = _loc9_;
            }
            else
            {
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc11_._isimmutable != null)
               {
                  _loc11_._isimmutable();
               }
               if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               if(_loc9_.zpp_inner.x == _loc6_)
               {
                  §§pop();
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  §§push(_loc9_.zpp_inner.y == _loc7_);
               }
               if(!§§pop())
               {
                  _loc9_.zpp_inner.x = _loc6_;
                  _loc9_.zpp_inner.y = _loc7_;
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._invalidate != null)
                  {
                     _loc11_._invalidate(_loc11_);
                  }
               }
               _loc9_;
            }
            _loc9_.zpp_inner.weak = _loc8_;
            §§pop().wrap = _loc9_;
            _loc1_.wrap.zpp_inner._inuse = true;
            _loc1_.wrap.zpp_inner._invalidate = _loc1_.modwrap;
            _loc1_.wrap.zpp_inner._validate = _loc1_.getwrap;
         }
         return _loc1_.wrap;
      }
      
      public function toString() : String
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc1_:String = "GeomPoly[";
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_ != zpp_inner.vertices)
               {
                  _loc1_ += ",";
               }
               _loc1_ += "{" + _loc5_.x + "," + _loc5_.y + "}";
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_ + "]";
      }
      
      public function skipForward(param1:int) : GeomPoly
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices != null)
         {
            if(param1 > 0)
            {
               while(param1-- > 0)
               {
                  zpp_inner.vertices = zpp_inner.vertices.next;
               }
            }
            else if(param1 < 0)
            {
               while(param1++ < 0)
               {
                  zpp_inner.vertices = zpp_inner.vertices.prev;
               }
            }
         }
         return this;
      }
      
      public function skipBackwards(param1:int) : GeomPoly
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         return skipForward(-param1);
      }
      
      public function size() : int
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         var _loc1_:int = 0;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc1_++;
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_;
      }
      
      public function simplify(param1:Number) : GeomPoly
      {
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as GeomPoly;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(param1 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Epsilon should be > 0 for simplifying a GeomPoly";
         }
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            return copy();
         }
         _loc2_ = ZPP_Simplify.simplify(zpp_inner.vertices,param1);
         _loc3_ = GeomPoly.get();
         _loc3_.zpp_inner.vertices = _loc2_;
         return _loc3_;
      }
      
      public function simpleDecomposition(param1:GeomPolyList = undefined) : GeomPolyList
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as GeomPoly;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot decompose a degenerate polygon";
         }
         §§push(ZPP_Simple);
         §§push(zpp_inner.vertices);
         if(ZPP_PartitionedPoly.sharedGVList == null)
         {
            ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
         }
         var _loc2_:ZNPList_ZPP_GeomVert = §§pop().decompose(§§pop(),ZPP_PartitionedPoly.sharedGVList);
         var _loc3_:GeomPolyList = param1 == null ? new GeomPolyList() : param1;
         while(_loc2_.head != null)
         {
            _loc4_ = _loc2_.pop_unsafe();
            _loc5_ = GeomPoly.get();
            _loc5_.zpp_inner.vertices = _loc4_;
            if(_loc3_.zpp_inner.reverse_flag)
            {
               _loc3_.push(_loc5_);
            }
            else
            {
               _loc3_.unshift(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function shift() : GeomPoly
      {
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot shift from empty polygon";
         }
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         zpp_inner.vertices = zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices ? (zpp_inner.vertices.next = zpp_inner.vertices.prev = null, zpp_inner.vertices = null) : (_loc2_ = zpp_inner.vertices.next, zpp_inner.vertices.prev.next = zpp_inner.vertices.next, zpp_inner.vertices.next.prev = zpp_inner.vertices.prev, zpp_inner.vertices.next = zpp_inner.vertices.prev = null, zpp_inner.vertices = null, _loc2_);
         _loc2_ = _loc1_;
         if(_loc2_.wrap != null)
         {
            _loc2_.wrap.zpp_inner._inuse = false;
            _loc4_ = _loc2_.wrap;
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc4_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc4_.zpp_inner;
            _loc4_.zpp_inner.outer = null;
            _loc4_.zpp_inner = null;
            _loc6_ = _loc4_;
            _loc6_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc6_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc6_;
            }
            ZPP_PubPool.nextVec2 = _loc6_;
            _loc6_.zpp_disp = true;
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
            _loc2_.wrap = null;
         }
         _loc2_.prev = _loc2_.next = null;
         _loc2_.next = ZPP_GeomVert.zpp_pool;
         ZPP_GeomVert.zpp_pool = _loc2_;
         return this;
      }
      
      public function right() : Vec2
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as Vec2;
         var _loc10_:Boolean = false;
         var _loc11_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null)
         {
            Boot.lastError = new Error();
            throw "Error: empty GeomPoly has no defineable rightmmost vertex";
         }
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices.next;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_.x > _loc1_.x)
               {
                  _loc1_ = _loc5_;
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         if(_loc1_.wrap == null)
         {
            _loc6_ = _loc1_.x;
            _loc7_ = _loc1_.y;
            _loc8_ = false;
            §§push(_loc1_);
            if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc9_ = new Vec2();
            }
            else
            {
               _loc9_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc9_.zpp_pool;
               _loc9_.zpp_pool = null;
               _loc9_.zpp_disp = false;
               if(_loc9_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc9_.zpp_inner == null)
            {
               _loc10_ = false;
               §§push(_loc9_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc11_ = new ZPP_Vec2();
               }
               else
               {
                  _loc11_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.weak = false;
               _loc11_._immutable = _loc10_;
               _loc11_.x = _loc6_;
               _loc11_.y = _loc7_;
               §§pop().zpp_inner = _loc11_;
               _loc9_.zpp_inner.outer = _loc9_;
            }
            else
            {
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc11_._isimmutable != null)
               {
                  _loc11_._isimmutable();
               }
               if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               if(_loc9_.zpp_inner.x == _loc6_)
               {
                  §§pop();
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  §§push(_loc9_.zpp_inner.y == _loc7_);
               }
               if(!§§pop())
               {
                  _loc9_.zpp_inner.x = _loc6_;
                  _loc9_.zpp_inner.y = _loc7_;
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._invalidate != null)
                  {
                     _loc11_._invalidate(_loc11_);
                  }
               }
               _loc9_;
            }
            _loc9_.zpp_inner.weak = _loc8_;
            §§pop().wrap = _loc9_;
            _loc1_.wrap.zpp_inner._inuse = true;
            _loc1_.wrap.zpp_inner._invalidate = _loc1_.modwrap;
            _loc1_.wrap.zpp_inner._validate = _loc1_.getwrap;
         }
         return _loc1_.wrap;
      }
      
      public function push(param1:Vec2) : GeomPoly
      {
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot push null vertex";
         }
         §§push(zpp_inner);
         if(ZPP_GeomVert.zpp_pool == null)
         {
            _loc3_ = new ZPP_GeomVert();
         }
         else
         {
            _loc3_ = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.forced = false;
         §§push(_loc3_);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().x = param1.zpp_inner.x;
         §§push(_loc3_);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().y = param1.zpp_inner.y;
         var _loc2_:ZPP_GeomVert = _loc3_;
         if(zpp_inner.vertices == null)
         {
            zpp_inner.vertices = _loc2_.prev = _loc2_.next = _loc2_;
         }
         else
         {
            _loc2_.prev = zpp_inner.vertices;
            _loc2_.next = zpp_inner.vertices.next;
            zpp_inner.vertices.next.prev = _loc2_;
            zpp_inner.vertices.next = _loc2_;
         }
         §§pop().vertices = _loc2_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = param1.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc4_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc5_ = param1;
            _loc5_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc5_;
            }
            ZPP_PubPool.nextVec2 = _loc5_;
            _loc5_.zpp_disp = true;
            _loc6_ = _loc4_;
            if(_loc6_.outer != null)
            {
               _loc6_.outer.zpp_inner = null;
               _loc6_.outer = null;
            }
            _loc6_._isimmutable = null;
            _loc6_._validate = null;
            _loc6_._invalidate = null;
            _loc6_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc6_;
         }
         return this;
      }
      
      public function pop() : GeomPoly
      {
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot pop from empty polygon";
         }
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         zpp_inner.vertices = zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices ? (zpp_inner.vertices.next = zpp_inner.vertices.prev = null, null) : (_loc2_ = zpp_inner.vertices.prev, zpp_inner.vertices.prev.next = zpp_inner.vertices.next, zpp_inner.vertices.next.prev = zpp_inner.vertices.prev, zpp_inner.vertices.next = zpp_inner.vertices.prev = null, zpp_inner.vertices = null, _loc2_);
         _loc2_ = _loc1_;
         if(_loc2_.wrap != null)
         {
            _loc2_.wrap.zpp_inner._inuse = false;
            _loc4_ = _loc2_.wrap;
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc4_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc4_.zpp_inner;
            _loc4_.zpp_inner.outer = null;
            _loc4_.zpp_inner = null;
            _loc6_ = _loc4_;
            _loc6_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc6_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc6_;
            }
            ZPP_PubPool.nextVec2 = _loc6_;
            _loc6_.zpp_disp = true;
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
            _loc2_.wrap = null;
         }
         _loc2_.prev = _loc2_.next = null;
         _loc2_.next = ZPP_GeomVert.zpp_pool;
         ZPP_GeomVert.zpp_pool = _loc2_;
         return this;
      }
      
      public function monotoneDecomposition(param1:GeomPolyList = undefined) : GeomPolyList
      {
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as GeomPoly;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot decompose a degenerate polygon";
         }
         §§push(ZPP_Monotone);
         §§push(zpp_inner.vertices);
         if(ZPP_Monotone.sharedPPoly == null)
         {
            ZPP_Monotone.sharedPPoly = new ZPP_PartitionedPoly();
         }
         var _loc2_:ZPP_PartitionedPoly = §§pop().decompose(§§pop(),ZPP_Monotone.sharedPPoly);
         §§push(_loc2_);
         if(ZPP_PartitionedPoly.sharedGVList == null)
         {
            ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
         }
         var _loc3_:ZNPList_ZPP_GeomVert = §§pop().extract(ZPP_PartitionedPoly.sharedGVList);
         var _loc4_:GeomPolyList = param1 == null ? new GeomPolyList() : param1;
         while(_loc3_.head != null)
         {
            _loc5_ = _loc3_.pop_unsafe();
            _loc6_ = GeomPoly.get();
            _loc6_.zpp_inner.vertices = _loc5_;
            if(_loc4_.zpp_inner.reverse_flag)
            {
               _loc4_.push(_loc6_);
            }
            else
            {
               _loc4_.unshift(_loc6_);
            }
         }
         return _loc4_;
      }
      
      public function left() : Vec2
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as Vec2;
         var _loc10_:Boolean = false;
         var _loc11_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null)
         {
            Boot.lastError = new Error();
            throw "Error: empty GeomPoly has no defineable leftmost vertex";
         }
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices.next;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_.x < _loc1_.x)
               {
                  _loc1_ = _loc5_;
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         if(_loc1_.wrap == null)
         {
            _loc6_ = _loc1_.x;
            _loc7_ = _loc1_.y;
            _loc8_ = false;
            §§push(_loc1_);
            if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc9_ = new Vec2();
            }
            else
            {
               _loc9_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc9_.zpp_pool;
               _loc9_.zpp_pool = null;
               _loc9_.zpp_disp = false;
               if(_loc9_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc9_.zpp_inner == null)
            {
               _loc10_ = false;
               §§push(_loc9_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc11_ = new ZPP_Vec2();
               }
               else
               {
                  _loc11_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.weak = false;
               _loc11_._immutable = _loc10_;
               _loc11_.x = _loc6_;
               _loc11_.y = _loc7_;
               §§pop().zpp_inner = _loc11_;
               _loc9_.zpp_inner.outer = _loc9_;
            }
            else
            {
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc11_._isimmutable != null)
               {
                  _loc11_._isimmutable();
               }
               if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               if(_loc9_.zpp_inner.x == _loc6_)
               {
                  §§pop();
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  §§push(_loc9_.zpp_inner.y == _loc7_);
               }
               if(!§§pop())
               {
                  _loc9_.zpp_inner.x = _loc6_;
                  _loc9_.zpp_inner.y = _loc7_;
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._invalidate != null)
                  {
                     _loc11_._invalidate(_loc11_);
                  }
               }
               _loc9_;
            }
            _loc9_.zpp_inner.weak = _loc8_;
            §§pop().wrap = _loc9_;
            _loc1_.wrap.zpp_inner._inuse = true;
            _loc1_.wrap.zpp_inner._invalidate = _loc1_.modwrap;
            _loc1_.wrap.zpp_inner._validate = _loc1_.getwrap;
         }
         return _loc1_.wrap;
      }
      
      public function iterator() : GeomVertexIterator
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         return ZPP_GeomVertexIterator.get(zpp_inner.vertices,true);
      }
      
      public function isSimple() : Boolean
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         return zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next ? true : ZPP_Simple.isSimple(zpp_inner.vertices);
      }
      
      public function isMonotone() : Boolean
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         return zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next ? true : ZPP_Monotone.isMonotone(zpp_inner.vertices);
      }
      
      public function isDegenerate() : Boolean
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         return zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next ? true : area() < Config.epsilon;
      }
      
      public function isConvex() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_GeomVert;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            §§push(true);
         }
         else
         {
            _loc1_ = false;
            _loc2_ = false;
            _loc3_ = true;
            _loc4_ = zpp_inner.vertices;
            _loc5_ = zpp_inner.vertices;
            if(_loc4_ != null)
            {
               _loc6_ = _loc4_;
               do
               {
                  _loc7_ = _loc6_;
                  _loc8_ = _loc7_.prev;
                  _loc9_ = _loc7_.next;
                  _loc10_ = 0;
                  _loc11_ = 0;
                  _loc10_ = _loc9_.x - _loc7_.x;
                  _loc11_ = _loc9_.y - _loc7_.y;
                  _loc12_ = 0;
                  _loc13_ = 0;
                  _loc12_ = _loc7_.x - _loc8_.x;
                  _loc13_ = _loc7_.y - _loc8_.y;
                  _loc14_ = _loc13_ * _loc10_ - _loc12_ * _loc11_;
                  if(_loc14_ > 0)
                  {
                     _loc2_ = true;
                  }
                  else if(_loc14_ < 0)
                  {
                     _loc1_ = true;
                  }
                  if(_loc2_ && _loc1_)
                  {
                     _loc3_ = false;
                     break;
                  }
                  _loc6_ = _loc6_.next;
               }
               while(_loc6_ != _loc5_);
               
            }
            §§push(_loc3_);
         }
         return §§pop();
      }
      
      public function isClockwise() : Boolean
      {
         §§push(winding());
         if(ZPP_Flags.Winding_CLOCKWISE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_CLOCKWISE = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         return §§pop() == ZPP_Flags.Winding_CLOCKWISE;
      }
      
      public function inflate(param1:Number) : GeomPoly
      {
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_GeomVert;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Boolean = false;
         var _loc25_:* = null as Vec2;
         var _loc26_:Boolean = false;
         var _loc27_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         var _loc2_:GeomPoly = GeomPoly.get();
         §§push(winding());
         if(ZPP_Flags.Winding_CLOCKWISE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_CLOCKWISE = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.Winding_CLOCKWISE)
         {
            param1 = -param1;
         }
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc4_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc3_ != null)
         {
            _loc5_ = _loc3_;
            do
            {
               _loc6_ = _loc5_;
               _loc7_ = _loc6_.prev;
               _loc8_ = _loc6_.next;
               _loc9_ = 0;
               _loc10_ = 0;
               _loc11_ = 0;
               _loc12_ = 0;
               _loc9_ = _loc6_.x - _loc7_.x;
               _loc10_ = _loc6_.y - _loc7_.y;
               _loc11_ = _loc8_.x - _loc6_.x;
               _loc12_ = _loc8_.y - _loc6_.y;
               _loc13_ = 0;
               _loc14_ = 0;
               _loc15_ = 0;
               _loc16_ = 0;
               _loc13_ = _loc9_;
               _loc14_ = _loc10_;
               _loc17_ = _loc13_ * _loc13_ + _loc14_ * _loc14_;
               sf32(_loc17_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc19_ = lf32(0);
               _loc18_ = _loc19_ * (1.5 - 0.5 * _loc17_ * _loc19_ * _loc19_);
               _loc19_ = _loc18_;
               _loc13_ *= _loc19_;
               _loc14_ *= _loc19_;
               _loc17_ = _loc13_;
               _loc13_ = -_loc14_;
               _loc14_ = _loc17_;
               _loc17_ = param1;
               _loc13_ *= _loc17_;
               _loc14_ *= _loc17_;
               _loc15_ = _loc11_;
               _loc16_ = _loc12_;
               _loc17_ = _loc15_ * _loc15_ + _loc16_ * _loc16_;
               sf32(_loc17_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc19_ = lf32(0);
               _loc18_ = _loc19_ * (1.5 - 0.5 * _loc17_ * _loc19_ * _loc19_);
               _loc19_ = _loc18_;
               _loc15_ *= _loc19_;
               _loc16_ *= _loc19_;
               _loc17_ = _loc15_;
               _loc15_ = -_loc16_;
               _loc16_ = _loc17_;
               _loc17_ = param1;
               _loc15_ *= _loc17_;
               _loc16_ *= _loc17_;
               _loc17_ = 0;
               _loc18_ = 0;
               _loc17_ = _loc15_ - _loc13_;
               _loc18_ = _loc16_ - _loc14_;
               _loc19_ = _loc12_ * _loc17_ - _loc11_ * _loc18_;
               _loc20_ = _loc19_ == 0 ? 0 : _loc19_ / (_loc12_ * _loc9_ - _loc11_ * _loc10_);
               _loc21_ = 0;
               _loc22_ = 0;
               _loc21_ = _loc6_.x + _loc13_;
               _loc22_ = _loc6_.y + _loc14_;
               _loc23_ = _loc20_;
               _loc21_ += _loc9_ * _loc23_;
               _loc22_ += _loc10_ * _loc23_;
               _loc24_ = false;
               §§push(_loc2_);
               if(_loc21_ != _loc21_ || _loc22_ != _loc22_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               if(ZPP_PubPool.poolVec2 == null)
               {
                  _loc25_ = new Vec2();
               }
               else
               {
                  _loc25_ = ZPP_PubPool.poolVec2;
                  ZPP_PubPool.poolVec2 = _loc25_.zpp_pool;
                  _loc25_.zpp_pool = null;
                  _loc25_.zpp_disp = false;
                  if(_loc25_ == ZPP_PubPool.nextVec2)
                  {
                     ZPP_PubPool.nextVec2 = null;
                  }
               }
               if(_loc25_.zpp_inner == null)
               {
                  _loc26_ = false;
                  §§push(_loc25_);
                  if(ZPP_Vec2.zpp_pool == null)
                  {
                     _loc27_ = new ZPP_Vec2();
                  }
                  else
                  {
                     _loc27_ = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc27_.next;
                     _loc27_.next = null;
                  }
                  _loc27_.weak = false;
                  _loc27_._immutable = _loc26_;
                  _loc27_.x = _loc21_;
                  _loc27_.y = _loc22_;
                  §§pop().zpp_inner = _loc27_;
                  _loc25_.zpp_inner.outer = _loc25_;
               }
               else
               {
                  if(_loc25_ != null && _loc25_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc27_ = _loc25_.zpp_inner;
                  if(_loc27_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc27_._isimmutable != null)
                  {
                     _loc27_._isimmutable();
                  }
                  if(_loc21_ != _loc21_ || _loc22_ != _loc22_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 components cannot be NaN";
                  }
                  §§push(false);
                  if(_loc25_ != null && _loc25_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc27_ = _loc25_.zpp_inner;
                  if(_loc27_._validate != null)
                  {
                     _loc27_._validate();
                  }
                  if(_loc25_.zpp_inner.x == _loc21_)
                  {
                     §§pop();
                     if(_loc25_ != null && _loc25_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc27_ = _loc25_.zpp_inner;
                     if(_loc27_._validate != null)
                     {
                        _loc27_._validate();
                     }
                     §§push(_loc25_.zpp_inner.y == _loc22_);
                  }
                  if(!§§pop())
                  {
                     _loc25_.zpp_inner.x = _loc21_;
                     _loc25_.zpp_inner.y = _loc22_;
                     _loc27_ = _loc25_.zpp_inner;
                     if(_loc27_._invalidate != null)
                     {
                        _loc27_._invalidate(_loc27_);
                     }
                  }
                  _loc25_;
               }
               _loc25_.zpp_inner.weak = _loc24_;
               §§pop().push(_loc25_);
               _loc5_ = _loc5_.next;
            }
            while(_loc5_ != _loc4_);
            
         }
         return _loc2_.skipForward(1);
      }
      
      public function forwardIterator() : GeomVertexIterator
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         return ZPP_GeomVertexIterator.get(zpp_inner.vertices,true);
      }
      
      public function erase(param1:int) : GeomPoly
      {
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         while(param1 != 0 && zpp_inner.vertices != null)
         {
            _loc2_ = zpp_inner.vertices;
            if(param1 > 0)
            {
               zpp_inner.vertices = zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices ? (zpp_inner.vertices.next = zpp_inner.vertices.prev = null, zpp_inner.vertices = null) : (_loc3_ = zpp_inner.vertices.next, zpp_inner.vertices.prev.next = zpp_inner.vertices.next, zpp_inner.vertices.next.prev = zpp_inner.vertices.prev, zpp_inner.vertices.next = zpp_inner.vertices.prev = null, zpp_inner.vertices = null, _loc3_);
               param1--;
            }
            else if(param1 < 0)
            {
               zpp_inner.vertices = zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices ? (zpp_inner.vertices.next = zpp_inner.vertices.prev = null, null) : (_loc3_ = zpp_inner.vertices.prev, zpp_inner.vertices.prev.next = zpp_inner.vertices.next, zpp_inner.vertices.next.prev = zpp_inner.vertices.prev, zpp_inner.vertices.next = zpp_inner.vertices.prev = null, zpp_inner.vertices = null, _loc3_);
               param1++;
            }
            _loc3_ = _loc2_;
            if(_loc3_.wrap != null)
            {
               _loc3_.wrap.zpp_inner._inuse = false;
               _loc5_ = _loc3_.wrap;
               if(_loc5_ != null && _loc5_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc5_.zpp_inner;
               if(_loc6_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc6_._isimmutable != null)
               {
                  _loc6_._isimmutable();
               }
               if(_loc5_.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc6_ = _loc5_.zpp_inner;
               _loc5_.zpp_inner.outer = null;
               _loc5_.zpp_inner = null;
               _loc7_ = _loc5_;
               _loc7_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc7_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc7_;
               }
               ZPP_PubPool.nextVec2 = _loc7_;
               _loc7_.zpp_disp = true;
               _loc8_ = _loc6_;
               if(_loc8_.outer != null)
               {
                  _loc8_.outer.zpp_inner = null;
                  _loc8_.outer = null;
               }
               _loc8_._isimmutable = null;
               _loc8_._validate = null;
               _loc8_._invalidate = null;
               _loc8_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc8_;
               _loc3_.wrap = null;
            }
            _loc3_.prev = _loc3_.next = null;
            _loc3_.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc3_;
         }
         return this;
      }
      
      public function empty() : Boolean
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         return zpp_inner.vertices == null;
      }
      
      public function dispose() : void
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         clear();
         var _loc1_:GeomPoly = this;
         _loc1_.zpp_pool = null;
         if(ZPP_PubPool.nextGeomPoly != null)
         {
            ZPP_PubPool.nextGeomPoly.zpp_pool = _loc1_;
         }
         else
         {
            ZPP_PubPool.poolGeomPoly = _loc1_;
         }
         ZPP_PubPool.nextGeomPoly = _loc1_;
         _loc1_.zpp_disp = true;
      }
      
      public function cut(param1:Vec2, param2:Vec2, param3:Boolean = false, param4:Boolean = false, param5:GeomPolyList = undefined) : GeomPolyList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(param1 == null || param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot cut with null start/end\'s";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc6_:GeomPolyList = ZPP_Cutter.run(zpp_inner.vertices,param1,param2,param3,param4,param5);
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc8_ = param1;
            _loc8_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc8_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc8_;
            }
            ZPP_PubPool.nextVec2 = _loc8_;
            _loc8_.zpp_disp = true;
            _loc9_ = _loc7_;
            if(_loc9_.outer != null)
            {
               _loc9_.outer.zpp_inner = null;
               _loc9_.outer = null;
            }
            _loc9_._isimmutable = null;
            _loc9_._validate = null;
            _loc9_._invalidate = null;
            _loc9_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc9_;
         }
         if(param2.zpp_inner.weak)
         {
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param2.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(param2.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = param2.zpp_inner;
            param2.zpp_inner.outer = null;
            param2.zpp_inner = null;
            _loc8_ = param2;
            _loc8_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc8_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc8_;
            }
            ZPP_PubPool.nextVec2 = _loc8_;
            _loc8_.zpp_disp = true;
            _loc9_ = _loc7_;
            if(_loc9_.outer != null)
            {
               _loc9_.outer.zpp_inner = null;
               _loc9_.outer = null;
            }
            _loc9_._isimmutable = null;
            _loc9_._validate = null;
            _loc9_._invalidate = null;
            _loc9_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc9_;
         }
         return _loc6_;
      }
      
      public function current() : Vec2
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:* = null as Vec2;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null)
         {
            Boot.lastError = new Error();
            throw "Error: GeomPoly is empty";
         }
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc1_.wrap == null)
         {
            _loc2_ = _loc1_.x;
            _loc3_ = _loc1_.y;
            _loc4_ = false;
            §§push(_loc1_);
            if(_loc2_ != _loc2_ || _loc3_ != _loc3_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc5_ = new Vec2();
            }
            else
            {
               _loc5_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc5_.zpp_pool;
               _loc5_.zpp_pool = null;
               _loc5_.zpp_disp = false;
               if(_loc5_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc5_.zpp_inner == null)
            {
               _loc6_ = false;
               §§push(_loc5_);
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
               _loc7_.x = _loc2_;
               _loc7_.y = _loc3_;
               §§pop().zpp_inner = _loc7_;
               _loc5_.zpp_inner.outer = _loc5_;
            }
            else
            {
               if(_loc5_ != null && _loc5_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc5_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc2_ != _loc2_ || _loc3_ != _loc3_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc5_ != null && _loc5_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc5_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc5_.zpp_inner.x == _loc2_)
               {
                  §§pop();
                  if(_loc5_ != null && _loc5_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc7_ = _loc5_.zpp_inner;
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  §§push(_loc5_.zpp_inner.y == _loc3_);
               }
               if(!§§pop())
               {
                  _loc5_.zpp_inner.x = _loc2_;
                  _loc5_.zpp_inner.y = _loc3_;
                  _loc7_ = _loc5_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc5_;
            }
            _loc5_.zpp_inner.weak = _loc4_;
            §§pop().wrap = _loc5_;
            _loc1_.wrap.zpp_inner._inuse = true;
            _loc1_.wrap.zpp_inner._invalidate = _loc1_.modwrap;
            _loc1_.wrap.zpp_inner._validate = _loc1_.getwrap;
         }
         return _loc1_.wrap;
      }
      
      public function copy() : GeomPoly
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         var _loc1_:GeomPoly = GeomPoly.get();
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               §§push(_loc1_.zpp_inner);
               if(ZPP_GeomVert.zpp_pool == null)
               {
                  _loc7_ = new ZPP_GeomVert();
               }
               else
               {
                  _loc7_ = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc7_.next;
                  _loc7_.next = null;
               }
               _loc7_.forced = false;
               _loc7_.x = _loc5_.x;
               _loc7_.y = _loc5_.y;
               _loc6_ = _loc7_;
               if(_loc1_.zpp_inner.vertices == null)
               {
                  _loc1_.zpp_inner.vertices = _loc6_.prev = _loc6_.next = _loc6_;
               }
               else
               {
                  _loc6_.prev = _loc1_.zpp_inner.vertices;
                  _loc6_.next = _loc1_.zpp_inner.vertices.next;
                  _loc1_.zpp_inner.vertices.next.prev = _loc6_;
                  _loc1_.zpp_inner.vertices.next = _loc6_;
               }
               §§pop().vertices = _loc6_;
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_.skipForward(1);
      }
      
      public function convexDecomposition(param1:Boolean = false, param2:GeomPolyList = undefined) : GeomPolyList
      {
         var _loc6_:* = null as ZPP_PartitionedPoly;
         var _loc7_:* = null as ZNPList_ZPP_GeomVert;
         var _loc8_:* = null as ZPP_PartitionedPoly;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:* = null as GeomPoly;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot decompose a degenerate polygon";
         }
         §§push(ZPP_Monotone);
         §§push(zpp_inner.vertices);
         if(ZPP_Monotone.sharedPPoly == null)
         {
            ZPP_Monotone.sharedPPoly = new ZPP_PartitionedPoly();
         }
         var _loc3_:ZPP_PartitionedPoly = §§pop().decompose(§§pop(),ZPP_Monotone.sharedPPoly);
         §§push(_loc3_);
         if(ZPP_PartitionedPoly.sharedPPList == null)
         {
            ZPP_PartitionedPoly.sharedPPList = new ZNPList_ZPP_PartitionedPoly();
         }
         var _loc4_:ZNPList_ZPP_PartitionedPoly = §§pop().extract_partitions(ZPP_PartitionedPoly.sharedPPList);
         var _loc5_:GeomPolyList = param2 == null ? new GeomPolyList() : param2;
         while(_loc4_.head != null)
         {
            _loc6_ = _loc4_.pop_unsafe();
            ZPP_Triangular.triangulate(_loc6_);
            if(param1)
            {
               ZPP_Triangular.optimise(_loc6_);
            }
            ZPP_Convex.optimise(_loc6_);
            §§push(_loc6_);
            if(ZPP_PartitionedPoly.sharedGVList == null)
            {
               ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
            }
            _loc7_ = §§pop().extract(ZPP_PartitionedPoly.sharedGVList);
            _loc8_ = _loc6_;
            _loc8_.next = ZPP_PartitionedPoly.zpp_pool;
            ZPP_PartitionedPoly.zpp_pool = _loc8_;
            while(_loc7_.head != null)
            {
               _loc9_ = _loc7_.pop_unsafe();
               _loc10_ = GeomPoly.get();
               _loc10_.zpp_inner.vertices = _loc9_;
               if(_loc5_.zpp_inner.reverse_flag)
               {
                  _loc5_.push(_loc10_);
               }
               else
               {
                  _loc5_.unshift(_loc10_);
               }
            }
         }
         return _loc5_;
      }
      
      public function contains(param1:Vec2) : Boolean
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:* = null as ZPP_GeomVert;
         var _loc11_:* = null as ZPP_GeomVert;
         var _loc12_:* = null as Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: GeomPoly::contains point cannot be null";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Number = param1.zpp_inner.x;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc5_:Number = param1.zpp_inner.y;
         var _loc6_:Boolean = false;
         var _loc7_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc8_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc7_ != null)
         {
            _loc9_ = _loc7_;
            do
            {
               _loc10_ = _loc9_;
               _loc11_ = _loc10_.prev;
               if((_loc10_.y < _loc5_ && _loc11_.y >= _loc5_ || _loc11_.y < _loc5_ && _loc10_.y >= _loc5_) && (_loc10_.x <= _loc3_ || _loc11_.x <= _loc3_))
               {
                  if(_loc10_.x + (_loc5_ - _loc10_.y) / (_loc11_.y - _loc10_.y) * (_loc11_.x - _loc10_.x) < _loc3_)
                  {
                     _loc6_ = !_loc6_;
                  }
               }
               _loc9_ = _loc9_.next;
            }
            while(_loc9_ != _loc8_);
            
         }
         var _loc2_:Boolean = _loc6_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = param1.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc4_ = param1.zpp_inner;
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
            _loc13_ = _loc4_;
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
         return _loc2_;
      }
      
      public function clear() : GeomPoly
      {
         var _loc1_:* = null as ZPP_GeomVert;
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         while(zpp_inner.vertices != null)
         {
            _loc1_ = zpp_inner.vertices;
            zpp_inner.vertices = zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices ? (zpp_inner.vertices.next = zpp_inner.vertices.prev = null, zpp_inner.vertices = null) : (_loc2_ = zpp_inner.vertices.next, zpp_inner.vertices.prev.next = zpp_inner.vertices.next, zpp_inner.vertices.next.prev = zpp_inner.vertices.prev, zpp_inner.vertices.next = zpp_inner.vertices.prev = null, zpp_inner.vertices = null, _loc2_);
            _loc2_ = _loc1_;
            if(_loc2_.wrap != null)
            {
               _loc2_.wrap.zpp_inner._inuse = false;
               _loc4_ = _loc2_.wrap;
               if(_loc4_ != null && _loc4_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = _loc4_.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(_loc4_.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = _loc4_.zpp_inner;
               _loc4_.zpp_inner.outer = null;
               _loc4_.zpp_inner = null;
               _loc6_ = _loc4_;
               _loc6_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc6_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc6_;
               }
               ZPP_PubPool.nextVec2 = _loc6_;
               _loc6_.zpp_disp = true;
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
               _loc2_.wrap = null;
            }
            _loc2_.prev = _loc2_.next = null;
            _loc2_.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc2_;
         }
         return this;
      }
      
      public function bounds() : AABB
      {
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_GeomVert;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null)
         {
            Boot.lastError = new Error();
            throw "Error: empty GeomPoly has no defineable bounds";
         }
         var _loc1_:Number = 1e+100;
         var _loc2_:Number = 1e+100;
         var _loc3_:Number = -1e+100;
         var _loc4_:Number = -1e+100;
         var _loc5_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc6_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc5_ != null)
         {
            _loc7_ = _loc5_;
            do
            {
               _loc8_ = _loc7_;
               if(_loc8_.x < _loc1_)
               {
                  _loc1_ = _loc8_.x;
               }
               if(_loc8_.y < _loc2_)
               {
                  _loc2_ = _loc8_.y;
               }
               if(_loc8_.x > _loc3_)
               {
                  _loc3_ = _loc8_.x;
               }
               if(_loc8_.y > _loc4_)
               {
                  _loc4_ = _loc8_.y;
               }
               _loc7_ = _loc7_.next;
            }
            while(_loc7_ != _loc6_);
            
         }
         return new AABB(_loc1_,_loc2_,_loc3_ - _loc1_,_loc4_ - _loc2_);
      }
      
      public function bottom() : Vec2
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as Vec2;
         var _loc10_:Boolean = false;
         var _loc11_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null)
         {
            Boot.lastError = new Error();
            throw "Error: empty GeomPoly has no defineable bottommost vertex";
         }
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices.next;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_.y > _loc1_.y)
               {
                  _loc1_ = _loc5_;
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         if(_loc1_.wrap == null)
         {
            _loc6_ = _loc1_.x;
            _loc7_ = _loc1_.y;
            _loc8_ = false;
            §§push(_loc1_);
            if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc9_ = new Vec2();
            }
            else
            {
               _loc9_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc9_.zpp_pool;
               _loc9_.zpp_pool = null;
               _loc9_.zpp_disp = false;
               if(_loc9_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc9_.zpp_inner == null)
            {
               _loc10_ = false;
               §§push(_loc9_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc11_ = new ZPP_Vec2();
               }
               else
               {
                  _loc11_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc11_.next;
                  _loc11_.next = null;
               }
               _loc11_.weak = false;
               _loc11_._immutable = _loc10_;
               _loc11_.x = _loc6_;
               _loc11_.y = _loc7_;
               §§pop().zpp_inner = _loc11_;
               _loc9_.zpp_inner.outer = _loc9_;
            }
            else
            {
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc11_._isimmutable != null)
               {
                  _loc11_._isimmutable();
               }
               if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc9_.zpp_inner;
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               if(_loc9_.zpp_inner.x == _loc6_)
               {
                  §§pop();
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  §§push(_loc9_.zpp_inner.y == _loc7_);
               }
               if(!§§pop())
               {
                  _loc9_.zpp_inner.x = _loc6_;
                  _loc9_.zpp_inner.y = _loc7_;
                  _loc11_ = _loc9_.zpp_inner;
                  if(_loc11_._invalidate != null)
                  {
                     _loc11_._invalidate(_loc11_);
                  }
               }
               _loc9_;
            }
            _loc9_.zpp_inner.weak = _loc8_;
            §§pop().wrap = _loc9_;
            _loc1_.wrap.zpp_inner._inuse = true;
            _loc1_.wrap.zpp_inner._invalidate = _loc1_.modwrap;
            _loc1_.wrap.zpp_inner._validate = _loc1_.getwrap;
         }
         return _loc1_.wrap;
      }
      
      public function backwardsIterator() : GeomVertexIterator
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         return ZPP_GeomVertexIterator.get(zpp_inner.vertices,false);
      }
      
      public function area() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            §§push(0);
         }
         else
         {
            _loc2_ = 0;
            _loc3_ = zpp_inner.vertices;
            _loc4_ = zpp_inner.vertices;
            if(_loc3_ != null)
            {
               _loc5_ = _loc3_;
               do
               {
                  _loc6_ = _loc5_;
                  _loc2_ += _loc6_.x * (_loc6_.next.y - _loc6_.prev.y);
                  _loc5_ = _loc5_.next;
               }
               while(_loc5_ != _loc4_);
               
            }
            _loc1_ = _loc2_ * 0.5;
            §§push(_loc1_ < 0 ? -_loc1_ : _loc1_);
         }
         return §§pop();
      }
   }
}
