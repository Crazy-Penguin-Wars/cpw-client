package nape.shape
{
   import flash.Boot;
   import nape.dynamics.InteractionFilter;
   import nape.geom.GeomPoly;
   import nape.geom.Vec2;
   import nape.geom.Vec2Iterator;
   import nape.geom.Vec2List;
   import nape.phys.Material;
   import zpp_nape.ZPP_Const;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Material;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.util.ZNPList_ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Polygon extends Shape
   {
       
      
      public var zpp_inner_zn:ZPP_Polygon;
      
      public function Polygon(param1:*, param2:Material = undefined, param3:InteractionFilter = undefined)
      {
         var _loc5_:* = null;
         var _loc6_:* = null as Array;
         var _loc7_:int = 0;
         var _loc8_:* = null as Vec2;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as Vec2;
         var _loc14_:Boolean = false;
         var _loc15_:* = null as Vector.<Vec2>;
         var _loc16_:* = null as Vec2;
         var _loc17_:* = null as Vec2List;
         var _loc18_:* = null as Vec2Iterator;
         var _loc19_:* = null as GeomPoly;
         var _loc20_:* = null as ZPP_GeomVert;
         var _loc21_:* = null as ZPP_GeomVert;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:* = null as ZNPList_ZPP_Vec2;
         var _loc24_:* = null as ZNPNode_ZPP_Vec2;
         var _loc25_:* = null as ZNPNode_ZPP_Vec2;
         var _loc26_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = null;
         try
         {
            super();
         }
         catch(_loc_e_:*)
         {
            if(param1 == null)
            {
               Boot.lastError = new Error();
               throw "Error: localVerts cannot be null";
            }
            zpp_inner_zn = new ZPP_Polygon();
            zpp_inner_zn.outer = this;
            zpp_inner_zn.outer_zn = this;
            zpp_inner = zpp_inner_zn;
            zpp_inner_i = zpp_inner;
            zpp_inner_i.outer_i = this;
            if(param1 is Array)
            {
               _loc6_ = param1;
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length)
               {
                  _loc5_ = _loc6_[_loc7_];
                  _loc7_++;
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
                  _loc8_ = _loc5_;
                  if(_loc8_ != null && _loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(zpp_inner_zn.wrap_lverts == null)
                  {
                     zpp_inner_zn.getlverts();
                  }
                  _loc9_ = false;
                  §§push(zpp_inner_zn.wrap_lverts);
                  if(_loc8_ != null && _loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc8_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  _loc10_ = _loc8_.zpp_inner.x;
                  if(_loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc8_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  _loc12_ = _loc8_.zpp_inner.y;
                  if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 components cannot be NaN";
                  }
                  if(ZPP_PubPool.poolVec2 == null)
                  {
                     _loc13_ = new Vec2();
                  }
                  else
                  {
                     _loc13_ = ZPP_PubPool.poolVec2;
                     ZPP_PubPool.poolVec2 = _loc13_.zpp_pool;
                     _loc13_.zpp_pool = null;
                     _loc13_.zpp_disp = false;
                     if(_loc13_ == ZPP_PubPool.nextVec2)
                     {
                        ZPP_PubPool.nextVec2 = null;
                     }
                  }
                  if(_loc13_.zpp_inner == null)
                  {
                     _loc14_ = false;
                     §§push(_loc13_);
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
                     _loc11_._immutable = _loc14_;
                     _loc11_.x = _loc10_;
                     _loc11_.y = _loc12_;
                     §§pop().zpp_inner = _loc11_;
                     _loc13_.zpp_inner.outer = _loc13_;
                  }
                  else
                  {
                     if(_loc13_ != null && _loc13_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc13_.zpp_inner;
                     if(_loc11_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc11_._isimmutable != null)
                     {
                        _loc11_._isimmutable();
                     }
                     if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     §§push(false);
                     if(_loc13_ != null && _loc13_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc13_.zpp_inner;
                     if(_loc11_._validate != null)
                     {
                        _loc11_._validate();
                     }
                     if(_loc13_.zpp_inner.x == _loc10_)
                     {
                        §§pop();
                        if(_loc13_ != null && _loc13_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc13_.zpp_inner;
                        if(_loc11_._validate != null)
                        {
                           _loc11_._validate();
                        }
                        §§push(_loc13_.zpp_inner.y == _loc12_);
                     }
                     if(!§§pop())
                     {
                        _loc13_.zpp_inner.x = _loc10_;
                        _loc13_.zpp_inner.y = _loc12_;
                        _loc11_ = _loc13_.zpp_inner;
                        if(_loc11_._invalidate != null)
                        {
                           _loc11_._invalidate(_loc11_);
                        }
                     }
                     _loc13_;
                  }
                  _loc13_.zpp_inner.weak = _loc9_;
                  §§pop().push(_loc13_);
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc15_ = param1;
               _loc7_ = 0;
               while(_loc7_ < _loc15_.length)
               {
                  _loc8_ = _loc15_[_loc7_];
                  _loc7_++;
                  if(_loc8_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: flash.Vector<Vec2> contains null objects";
                  }
                  _loc13_ = _loc8_;
                  if(_loc13_ != null && _loc13_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(zpp_inner_zn.wrap_lverts == null)
                  {
                     zpp_inner_zn.getlverts();
                  }
                  _loc9_ = false;
                  §§push(zpp_inner_zn.wrap_lverts);
                  if(_loc13_ != null && _loc13_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc13_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc13_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  _loc10_ = _loc13_.zpp_inner.x;
                  if(_loc13_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc13_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  _loc12_ = _loc13_.zpp_inner.y;
                  if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
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
                     _loc14_ = false;
                     §§push(_loc16_);
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
                     _loc11_._immutable = _loc14_;
                     _loc11_.x = _loc10_;
                     _loc11_.y = _loc12_;
                     §§pop().zpp_inner = _loc11_;
                     _loc16_.zpp_inner.outer = _loc16_;
                  }
                  else
                  {
                     if(_loc16_ != null && _loc16_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc16_.zpp_inner;
                     if(_loc11_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc11_._isimmutable != null)
                     {
                        _loc11_._isimmutable();
                     }
                     if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
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
                     _loc11_ = _loc16_.zpp_inner;
                     if(_loc11_._validate != null)
                     {
                        _loc11_._validate();
                     }
                     if(_loc16_.zpp_inner.x == _loc10_)
                     {
                        §§pop();
                        if(_loc16_ != null && _loc16_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc16_.zpp_inner;
                        if(_loc11_._validate != null)
                        {
                           _loc11_._validate();
                        }
                        §§push(_loc16_.zpp_inner.y == _loc12_);
                     }
                     if(!§§pop())
                     {
                        _loc16_.zpp_inner.x = _loc10_;
                        _loc16_.zpp_inner.y = _loc12_;
                        _loc11_ = _loc16_.zpp_inner;
                        if(_loc11_._invalidate != null)
                        {
                           _loc11_._invalidate(_loc11_);
                        }
                     }
                     _loc16_;
                  }
                  _loc16_.zpp_inner.weak = _loc9_;
                  §§pop().push(_loc16_);
               }
            }
            else if(param1 is Vec2List)
            {
               _loc17_ = param1;
               _loc18_ = _loc17_.iterator();
               while(true)
               {
                  _loc18_.zpp_inner.zpp_inner.valmod();
                  _loc7_ = _loc18_.zpp_inner.zpp_gl();
                  _loc18_.zpp_critical = true;
                  if(!(_loc18_.zpp_i < _loc7_ ? true : (_loc18_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc18_, _loc18_.zpp_inner = null, false)))
                  {
                     break;
                  }
                  _loc18_.zpp_critical = false;
                  _loc18_.zpp_i = (_loc7_ = _loc18_.zpp_i) + 1;
                  _loc8_ = _loc18_.zpp_inner.at(_loc7_);
                  if(_loc8_ == null)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2List contains null objects";
                  }
                  if(_loc8_ != null && _loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(zpp_inner_zn.wrap_lverts == null)
                  {
                     zpp_inner_zn.getlverts();
                  }
                  _loc9_ = false;
                  §§push(zpp_inner_zn.wrap_lverts);
                  if(_loc8_ != null && _loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  if(_loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc8_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  _loc10_ = _loc8_.zpp_inner.x;
                  if(_loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc11_ = _loc8_.zpp_inner;
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  _loc12_ = _loc8_.zpp_inner.y;
                  if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 components cannot be NaN";
                  }
                  if(ZPP_PubPool.poolVec2 == null)
                  {
                     _loc13_ = new Vec2();
                  }
                  else
                  {
                     _loc13_ = ZPP_PubPool.poolVec2;
                     ZPP_PubPool.poolVec2 = _loc13_.zpp_pool;
                     _loc13_.zpp_pool = null;
                     _loc13_.zpp_disp = false;
                     if(_loc13_ == ZPP_PubPool.nextVec2)
                     {
                        ZPP_PubPool.nextVec2 = null;
                     }
                  }
                  if(_loc13_.zpp_inner == null)
                  {
                     _loc14_ = false;
                     §§push(_loc13_);
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
                     _loc11_._immutable = _loc14_;
                     _loc11_.x = _loc10_;
                     _loc11_.y = _loc12_;
                     §§pop().zpp_inner = _loc11_;
                     _loc13_.zpp_inner.outer = _loc13_;
                  }
                  else
                  {
                     if(_loc13_ != null && _loc13_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc13_.zpp_inner;
                     if(_loc11_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc11_._isimmutable != null)
                     {
                        _loc11_._isimmutable();
                     }
                     if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     §§push(false);
                     if(_loc13_ != null && _loc13_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc13_.zpp_inner;
                     if(_loc11_._validate != null)
                     {
                        _loc11_._validate();
                     }
                     if(_loc13_.zpp_inner.x == _loc10_)
                     {
                        §§pop();
                        if(_loc13_ != null && _loc13_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc13_.zpp_inner;
                        if(_loc11_._validate != null)
                        {
                           _loc11_._validate();
                        }
                        §§push(_loc13_.zpp_inner.y == _loc12_);
                     }
                     if(!§§pop())
                     {
                        _loc13_.zpp_inner.x = _loc10_;
                        _loc13_.zpp_inner.y = _loc12_;
                        _loc11_ = _loc13_.zpp_inner;
                        if(_loc11_._invalidate != null)
                        {
                           _loc11_._invalidate(_loc11_);
                        }
                     }
                     _loc13_;
                  }
                  _loc13_.zpp_inner.weak = _loc9_;
                  §§pop().push(_loc13_);
               }
            }
            else
            {
               if(!(param1 is GeomPoly))
               {
                  Boot.lastError = new Error();
                  throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
               }
               _loc19_ = param1;
               if(_loc19_ != null && _loc19_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
               }
               _loc20_ = _loc19_.zpp_inner.vertices;
               if(_loc20_ != null)
               {
                  _loc21_ = _loc20_;
                  while(true)
                  {
                     _loc10_ = _loc21_.x;
                     _loc12_ = _loc21_.y;
                     _loc9_ = false;
                     if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
                     {
                        break;
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc13_ = new Vec2();
                     }
                     else
                     {
                        _loc13_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc13_.zpp_pool;
                        _loc13_.zpp_pool = null;
                        _loc13_.zpp_disp = false;
                        if(_loc13_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc13_.zpp_inner == null)
                     {
                        _loc14_ = false;
                        §§push(_loc13_);
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
                        _loc11_._immutable = _loc14_;
                        _loc11_.x = _loc10_;
                        _loc11_.y = _loc12_;
                        §§pop().zpp_inner = _loc11_;
                        _loc13_.zpp_inner.outer = _loc13_;
                     }
                     else
                     {
                        if(_loc13_ != null && _loc13_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc13_.zpp_inner;
                        if(_loc11_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc11_._isimmutable != null)
                        {
                           _loc11_._isimmutable();
                        }
                        if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc13_ != null && _loc13_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc13_.zpp_inner;
                        if(_loc11_._validate != null)
                        {
                           _loc11_._validate();
                        }
                        if(_loc13_.zpp_inner.x == _loc10_)
                        {
                           §§pop();
                           if(_loc13_ != null && _loc13_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc11_ = _loc13_.zpp_inner;
                           if(_loc11_._validate != null)
                           {
                              _loc11_._validate();
                           }
                           §§push(_loc13_.zpp_inner.y == _loc12_);
                        }
                        if(!§§pop())
                        {
                           _loc13_.zpp_inner.x = _loc10_;
                           _loc13_.zpp_inner.y = _loc12_;
                           _loc11_ = _loc13_.zpp_inner;
                           if(_loc11_._invalidate != null)
                           {
                              _loc11_._invalidate(_loc11_);
                           }
                        }
                        _loc13_;
                     }
                     _loc13_.zpp_inner.weak = _loc9_;
                     _loc8_ = _loc13_;
                     _loc21_ = _loc21_.next;
                     if(zpp_inner_zn.wrap_lverts == null)
                     {
                        zpp_inner_zn.getlverts();
                     }
                     _loc9_ = false;
                     §§push(zpp_inner_zn.wrap_lverts);
                     if(_loc8_ != null && _loc8_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     if(_loc8_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc8_.zpp_inner;
                     if(_loc11_._validate != null)
                     {
                        _loc11_._validate();
                     }
                     _loc10_ = _loc8_.zpp_inner.x;
                     if(_loc8_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc8_.zpp_inner;
                     if(_loc11_._validate != null)
                     {
                        _loc11_._validate();
                     }
                     _loc12_ = _loc8_.zpp_inner.y;
                     if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     if(ZPP_PubPool.poolVec2 == null)
                     {
                        _loc13_ = new Vec2();
                     }
                     else
                     {
                        _loc13_ = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc13_.zpp_pool;
                        _loc13_.zpp_pool = null;
                        _loc13_.zpp_disp = false;
                        if(_loc13_ == ZPP_PubPool.nextVec2)
                        {
                           ZPP_PubPool.nextVec2 = null;
                        }
                     }
                     if(_loc13_.zpp_inner == null)
                     {
                        _loc14_ = false;
                        §§push(_loc13_);
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
                        _loc11_._immutable = _loc14_;
                        _loc11_.x = _loc10_;
                        _loc11_.y = _loc12_;
                        §§pop().zpp_inner = _loc11_;
                        _loc13_.zpp_inner.outer = _loc13_;
                     }
                     else
                     {
                        if(_loc13_ != null && _loc13_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc13_.zpp_inner;
                        if(_loc11_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc11_._isimmutable != null)
                        {
                           _loc11_._isimmutable();
                        }
                        if(_loc10_ != _loc10_ || _loc12_ != _loc12_)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 components cannot be NaN";
                        }
                        §§push(false);
                        if(_loc13_ != null && _loc13_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc13_.zpp_inner;
                        if(_loc11_._validate != null)
                        {
                           _loc11_._validate();
                        }
                        if(_loc13_.zpp_inner.x == _loc10_)
                        {
                           §§pop();
                           if(_loc13_ != null && _loc13_.zpp_disp)
                           {
                              Boot.lastError = new Error();
                              throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                           }
                           _loc11_ = _loc13_.zpp_inner;
                           if(_loc11_._validate != null)
                           {
                              _loc11_._validate();
                           }
                           §§push(_loc13_.zpp_inner.y == _loc12_);
                        }
                        if(!§§pop())
                        {
                           _loc13_.zpp_inner.x = _loc10_;
                           _loc13_.zpp_inner.y = _loc12_;
                           _loc11_ = _loc13_.zpp_inner;
                           if(_loc11_._invalidate != null)
                           {
                              _loc11_._invalidate(_loc11_);
                           }
                        }
                        _loc13_;
                     }
                     _loc13_.zpp_inner.weak = _loc9_;
                     §§pop().push(_loc13_);
                     if(_loc8_ != null && _loc8_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc8_.zpp_inner;
                     if(_loc11_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc11_._isimmutable != null)
                     {
                        _loc11_._isimmutable();
                     }
                     if(_loc8_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc11_ = _loc8_.zpp_inner;
                     _loc8_.zpp_inner.outer = null;
                     _loc8_.zpp_inner = null;
                     _loc13_ = _loc8_;
                     _loc13_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc13_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc13_;
                     }
                     ZPP_PubPool.nextVec2 = _loc13_;
                     _loc13_.zpp_disp = true;
                     _loc22_ = _loc11_;
                     if(_loc22_.outer != null)
                     {
                        _loc22_.outer.zpp_inner = null;
                        _loc22_.outer = null;
                     }
                     _loc22_._isimmutable = null;
                     _loc22_._validate = null;
                     _loc22_._invalidate = null;
                     _loc22_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc22_;
                     if(_loc21_ != _loc20_)
                     {
                        continue;
                     }
                  }
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
            }
            if(param1 is Array)
            {
               _loc6_ = param1;
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length)
               {
                  _loc8_ = _loc6_[_loc7_];
                  if(_loc8_.zpp_inner.weak)
                  {
                     if(_loc8_ != null && _loc8_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc8_.zpp_inner;
                     if(_loc11_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc11_._isimmutable != null)
                     {
                        _loc11_._isimmutable();
                     }
                     if(_loc8_.zpp_inner._inuse)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This Vec2 is not disposable";
                     }
                     _loc11_ = _loc8_.zpp_inner;
                     _loc8_.zpp_inner.outer = null;
                     _loc8_.zpp_inner = null;
                     _loc13_ = _loc8_;
                     _loc13_.zpp_pool = null;
                     if(ZPP_PubPool.nextVec2 != null)
                     {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc13_;
                     }
                     else
                     {
                        ZPP_PubPool.poolVec2 = _loc13_;
                     }
                     ZPP_PubPool.nextVec2 = _loc13_;
                     _loc13_.zpp_disp = true;
                     _loc22_ = _loc11_;
                     if(_loc22_.outer != null)
                     {
                        _loc22_.outer.zpp_inner = null;
                        _loc22_.outer = null;
                     }
                     _loc22_._isimmutable = null;
                     _loc22_._validate = null;
                     _loc22_._invalidate = null;
                     _loc22_.next = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc22_;
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  if(§§pop())
                  {
                     _loc6_.splice(_loc7_,1);
                  }
                  else
                  {
                     _loc7_++;
                  }
               }
            }
            else if(param1 is ZPP_Const.vec2vector)
            {
               _loc15_ = param1;
               if(!_loc15_.fixed)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc15_.length)
                  {
                     _loc8_ = _loc15_[_loc7_];
                     if(_loc8_.zpp_inner.weak)
                     {
                        if(_loc8_ != null && _loc8_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc8_.zpp_inner;
                        if(_loc11_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc11_._isimmutable != null)
                        {
                           _loc11_._isimmutable();
                        }
                        if(_loc8_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc11_ = _loc8_.zpp_inner;
                        _loc8_.zpp_inner.outer = null;
                        _loc8_.zpp_inner = null;
                        _loc13_ = _loc8_;
                        _loc13_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc13_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc13_;
                        }
                        ZPP_PubPool.nextVec2 = _loc13_;
                        _loc13_.zpp_disp = true;
                        _loc22_ = _loc11_;
                        if(_loc22_.outer != null)
                        {
                           _loc22_.outer.zpp_inner = null;
                           _loc22_.outer = null;
                        }
                        _loc22_._isimmutable = null;
                        _loc22_._validate = null;
                        _loc22_._invalidate = null;
                        _loc22_.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc22_;
                        §§push(true);
                     }
                     else
                     {
                        §§push(false);
                     }
                     if(§§pop())
                     {
                        _loc15_.splice(_loc7_,1);
                     }
                     else
                     {
                        _loc7_++;
                     }
                  }
               }
            }
            else if(param1 is Vec2List)
            {
               _loc17_ = param1;
               if(_loc17_.zpp_inner._validate != null)
               {
                  _loc17_.zpp_inner._validate();
               }
               _loc23_ = _loc17_.zpp_inner.inner;
               _loc24_ = null;
               _loc25_ = _loc23_.head;
               while(_loc25_ != null)
               {
                  _loc11_ = _loc25_.elt;
                  if(_loc11_.outer.zpp_inner.weak)
                  {
                     _loc25_ = _loc23_.erase(_loc24_);
                     if(_loc11_.outer.zpp_inner.weak)
                     {
                        _loc8_ = _loc11_.outer;
                        if(_loc8_ != null && _loc8_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc22_ = _loc8_.zpp_inner;
                        if(_loc22_._immutable)
                        {
                           Boot.lastError = new Error();
                           throw "Error: Vec2 is immutable";
                        }
                        if(_loc22_._isimmutable != null)
                        {
                           _loc22_._isimmutable();
                        }
                        if(_loc8_.zpp_inner._inuse)
                        {
                           Boot.lastError = new Error();
                           throw "Error: This Vec2 is not disposable";
                        }
                        _loc22_ = _loc8_.zpp_inner;
                        _loc8_.zpp_inner.outer = null;
                        _loc8_.zpp_inner = null;
                        _loc13_ = _loc8_;
                        _loc13_.zpp_pool = null;
                        if(ZPP_PubPool.nextVec2 != null)
                        {
                           ZPP_PubPool.nextVec2.zpp_pool = _loc13_;
                        }
                        else
                        {
                           ZPP_PubPool.poolVec2 = _loc13_;
                        }
                        ZPP_PubPool.nextVec2 = _loc13_;
                        _loc13_.zpp_disp = true;
                        _loc26_ = _loc22_;
                        if(_loc26_.outer != null)
                        {
                           _loc26_.outer.zpp_inner = null;
                           _loc26_.outer = null;
                        }
                        _loc26_._isimmutable = null;
                        _loc26_._validate = null;
                        _loc26_._invalidate = null;
                        _loc26_.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc26_;
                     }
                  }
                  else
                  {
                     _loc24_ = _loc25_;
                     _loc25_ = _loc25_.next;
                  }
               }
            }
            if(param2 == null)
            {
               if(ZPP_Material.zpp_pool == null)
               {
                  zpp_inner.material = new ZPP_Material();
               }
               else
               {
                  zpp_inner.material = ZPP_Material.zpp_pool;
                  ZPP_Material.zpp_pool = zpp_inner.material.next;
                  zpp_inner.material.next = null;
               }
            }
            else
            {
               zpp_inner.immutable_midstep("Shape::material");
               if(param2 == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Cannot assign null as Shape material";
               }
               zpp_inner.setMaterial(param2.zpp_inner);
               zpp_inner.material.wrapper();
            }
            if(param3 == null)
            {
               if(ZPP_InteractionFilter.zpp_pool == null)
               {
                  zpp_inner.filter = new ZPP_InteractionFilter();
               }
               else
               {
                  zpp_inner.filter = ZPP_InteractionFilter.zpp_pool;
                  ZPP_InteractionFilter.zpp_pool = zpp_inner.filter.next;
                  zpp_inner.filter.next = null;
               }
            }
            else
            {
               zpp_inner.immutable_midstep("Shape::filter");
               if(param3 == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Cannot assign null as Shape filter";
               }
               zpp_inner.setFilter(param3.zpp_inner);
               zpp_inner.filter.wrapper();
            }
            zpp_inner_i.insert_cbtype(ZPP_CbType.ANY_SHAPE.zpp_inner);
            return;
         }
      }
      
      public static function rect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : Array
      {
         var _loc6_:* = null as Vec2;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as ZPP_Vec2;
         if(param1 != param1 || param2 != param2 || param3 != param3 || param4 != param4)
         {
            Boot.lastError = new Error();
            throw "Error: Polygon.rect cannot accept NaN arguments";
         }
         if(param1 != param1 || param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc6_ = new Vec2();
         }
         else
         {
            _loc6_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc6_.zpp_pool;
            _loc6_.zpp_pool = null;
            _loc6_.zpp_disp = false;
            if(_loc6_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc6_.zpp_inner == null)
         {
            _loc7_ = false;
            §§push(_loc6_);
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
            _loc8_._immutable = _loc7_;
            _loc8_.x = param1;
            _loc8_.y = param2;
            §§pop().zpp_inner = _loc8_;
            _loc6_.zpp_inner.outer = _loc6_;
         }
         else
         {
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc8_._isimmutable != null)
            {
               _loc8_._isimmutable();
            }
            if(param1 != param1 || param2 != param2)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            if(_loc6_.zpp_inner.x == param1)
            {
               §§pop();
               if(_loc6_ != null && _loc6_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               §§push(_loc6_.zpp_inner.y == param2);
            }
            if(!§§pop())
            {
               _loc6_.zpp_inner.x = param1;
               _loc6_.zpp_inner.y = param2;
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._invalidate != null)
               {
                  _loc8_._invalidate(_loc8_);
               }
            }
            _loc6_;
         }
         _loc6_.zpp_inner.weak = param5;
         var _loc9_:Number = param1 + param3;
         §§push(_loc6_);
         if(_loc9_ != _loc9_ || param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc6_ = new Vec2();
         }
         else
         {
            _loc6_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc6_.zpp_pool;
            _loc6_.zpp_pool = null;
            _loc6_.zpp_disp = false;
            if(_loc6_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc6_.zpp_inner == null)
         {
            _loc7_ = false;
            §§push(_loc6_);
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
            _loc8_._immutable = _loc7_;
            _loc8_.x = _loc9_;
            _loc8_.y = param2;
            §§pop().zpp_inner = _loc8_;
            _loc6_.zpp_inner.outer = _loc6_;
         }
         else
         {
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc8_._isimmutable != null)
            {
               _loc8_._isimmutable();
            }
            if(_loc9_ != _loc9_ || param2 != param2)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            if(_loc6_.zpp_inner.x == _loc9_)
            {
               §§pop();
               if(_loc6_ != null && _loc6_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               §§push(_loc6_.zpp_inner.y == param2);
            }
            if(!§§pop())
            {
               _loc6_.zpp_inner.x = _loc9_;
               _loc6_.zpp_inner.y = param2;
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._invalidate != null)
               {
                  _loc8_._invalidate(_loc8_);
               }
            }
            _loc6_;
         }
         _loc6_.zpp_inner.weak = param5;
         _loc9_ = param1 + param3;
         var _loc10_:Number = param2 + param4;
         §§push(_loc6_);
         if(_loc9_ != _loc9_ || _loc10_ != _loc10_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc6_ = new Vec2();
         }
         else
         {
            _loc6_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc6_.zpp_pool;
            _loc6_.zpp_pool = null;
            _loc6_.zpp_disp = false;
            if(_loc6_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc6_.zpp_inner == null)
         {
            _loc7_ = false;
            §§push(_loc6_);
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
            _loc8_._immutable = _loc7_;
            _loc8_.x = _loc9_;
            _loc8_.y = _loc10_;
            §§pop().zpp_inner = _loc8_;
            _loc6_.zpp_inner.outer = _loc6_;
         }
         else
         {
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc8_._isimmutable != null)
            {
               _loc8_._isimmutable();
            }
            if(_loc9_ != _loc9_ || _loc10_ != _loc10_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            if(_loc6_.zpp_inner.x == _loc9_)
            {
               §§pop();
               if(_loc6_ != null && _loc6_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               §§push(_loc6_.zpp_inner.y == _loc10_);
            }
            if(!§§pop())
            {
               _loc6_.zpp_inner.x = _loc9_;
               _loc6_.zpp_inner.y = _loc10_;
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._invalidate != null)
               {
                  _loc8_._invalidate(_loc8_);
               }
            }
            _loc6_;
         }
         _loc6_.zpp_inner.weak = param5;
         _loc9_ = param2 + param4;
         §§push(_loc6_);
         if(param1 != param1 || _loc9_ != _loc9_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc6_ = new Vec2();
         }
         else
         {
            _loc6_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc6_.zpp_pool;
            _loc6_.zpp_pool = null;
            _loc6_.zpp_disp = false;
            if(_loc6_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc6_.zpp_inner == null)
         {
            _loc7_ = false;
            §§push(_loc6_);
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
            _loc8_._immutable = _loc7_;
            _loc8_.x = param1;
            _loc8_.y = _loc9_;
            §§pop().zpp_inner = _loc8_;
            _loc6_.zpp_inner.outer = _loc6_;
         }
         else
         {
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc8_._isimmutable != null)
            {
               _loc8_._isimmutable();
            }
            if(param1 != param1 || _loc9_ != _loc9_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            if(_loc6_.zpp_inner.x == param1)
            {
               §§pop();
               if(_loc6_ != null && _loc6_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               §§push(_loc6_.zpp_inner.y == _loc9_);
            }
            if(!§§pop())
            {
               _loc6_.zpp_inner.x = param1;
               _loc6_.zpp_inner.y = _loc9_;
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._invalidate != null)
               {
                  _loc8_._invalidate(_loc8_);
               }
            }
            _loc6_;
         }
         _loc6_.zpp_inner.weak = param5;
         return null;
      }
      
      public static function box(param1:Number, param2:Number, param3:Boolean = false) : Array
      {
         if(param1 != param1 || param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Polygon.box cannot accept NaN arguments";
         }
         return Polygon.rect(-param1 / 2,-param2 / 2,param1,param2,param3);
      }
      
      public static function regular(param1:Number, param2:Number, param3:int, param4:Number = 0, param5:Boolean = false) : Array
      {
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as Vec2;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as Vec2;
         var _loc15_:Boolean = false;
         var _loc16_:* = null as ZPP_Vec2;
         if(param1 != param1 || param2 != param2 || param4 != param4)
         {
            Boot.lastError = new Error();
            throw "Error: Polygon.regular cannot accept NaN arguments";
         }
         var _loc6_:Array = [];
         var _loc7_:Number = Math.PI * 2 / param3;
         var _loc8_:int = 0;
         while(_loc8_ < param3)
         {
            _loc9_ = _loc8_++;
            _loc10_ = _loc9_ * _loc7_ + param4;
            _loc12_ = Math.cos(_loc10_) * param1;
            _loc13_ = Math.sin(_loc10_) * param2;
            if(_loc12_ != _loc12_ || _loc13_ != _loc13_)
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
                  _loc16_ = new ZPP_Vec2();
               }
               else
               {
                  _loc16_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc16_.next;
                  _loc16_.next = null;
               }
               _loc16_.weak = false;
               _loc16_._immutable = _loc15_;
               _loc16_.x = _loc12_;
               _loc16_.y = _loc13_;
               §§pop().zpp_inner = _loc16_;
               _loc14_.zpp_inner.outer = _loc14_;
            }
            else
            {
               if(_loc14_ != null && _loc14_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc16_ = _loc14_.zpp_inner;
               if(_loc16_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc16_._isimmutable != null)
               {
                  _loc16_._isimmutable();
               }
               if(_loc12_ != _loc12_ || _loc13_ != _loc13_)
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
               _loc16_ = _loc14_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               if(_loc14_.zpp_inner.x == _loc12_)
               {
                  §§pop();
                  if(_loc14_ != null && _loc14_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  §§push(_loc14_.zpp_inner.y == _loc13_);
               }
               if(!§§pop())
               {
                  _loc14_.zpp_inner.x = _loc12_;
                  _loc14_.zpp_inner.y = _loc13_;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._invalidate != null)
                  {
                     _loc16_._invalidate(_loc16_);
                  }
               }
               _loc14_;
            }
            _loc14_.zpp_inner.weak = param5;
            _loc11_ = _loc14_;
            _loc6_.push(_loc11_);
         }
         return _loc6_;
      }
      
      public function validity() : ValidationResult
      {
         return zpp_inner_zn.valid();
      }
      
      public function get worldVerts() : Vec2List
      {
         if(zpp_inner_zn.wrap_gverts == null)
         {
            zpp_inner_zn.getgverts();
         }
         return zpp_inner_zn.wrap_gverts;
      }
      
      public function get localVerts() : Vec2List
      {
         if(zpp_inner_zn.wrap_lverts == null)
         {
            zpp_inner_zn.getlverts();
         }
         return zpp_inner_zn.wrap_lverts;
      }
      
      public function get edges() : EdgeList
      {
         if(zpp_inner_zn.wrap_edges == null)
         {
            zpp_inner_zn.getedges();
         }
         return zpp_inner_zn.wrap_edges;
      }
   }
}
