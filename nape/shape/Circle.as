package nape.shape
{
   import flash.Boot;
   import nape.Config;
   import nape.dynamics.InteractionFilter;
   import nape.geom.Vec2;
   import nape.phys.Material;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Material;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Circle extends Shape
   {
       
      
      public var zpp_inner_zn:ZPP_Circle;
      
      public function Circle(param1:Number, param2:Vec2 = undefined, param3:Material = undefined, param4:InteractionFilter = undefined)
      {
         var _loc6_:* = null;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
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
            zpp_inner_zn = new ZPP_Circle();
            zpp_inner_zn.outer = this;
            zpp_inner_zn.outer_zn = this;
            zpp_inner = zpp_inner_zn;
            zpp_inner_i = zpp_inner;
            zpp_inner_i.outer_i = this;
            zpp_inner.immutable_midstep("Circle::radius");
            if(zpp_inner.body != null && zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC && zpp_inner.body.space != null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot modifiy radius of Circle contained in static object once added to space";
            }
            if(param1 != zpp_inner_zn.radius)
            {
               if(param1 != param1)
               {
                  Boot.lastError = new Error();
                  throw "Error: Circle::radius cannot be NaN";
               }
               if(param1 < Config.epsilon)
               {
                  Boot.lastError = new Error();
                  throw "Error: Circle::radius (" + param1 + ") must be > Config.epsilon";
               }
               if(param1 > 1e+100)
               {
                  Boot.lastError = new Error();
                  throw "Error: Circle::radius (" + param1 + ") must be < PR(Const).FMAX";
               }
               zpp_inner_zn.radius = param1;
               zpp_inner_zn.invalidate_radius();
            }
            zpp_inner_zn.radius;
            if(param2 == null)
            {
               zpp_inner.localCOMx = 0;
               zpp_inner.localCOMy = 0;
            }
            else
            {
               if(param2 != null && param2.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               §§push(zpp_inner);
               if(param2 != null && param2.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = param2.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               §§pop().localCOMx = param2.zpp_inner.x;
               §§push(zpp_inner);
               if(param2 != null && param2.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = param2.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               §§pop().localCOMy = param2.zpp_inner.y;
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
            }
            if(param3 == null)
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
               if(param3 == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Cannot assign null as Shape material";
               }
               zpp_inner.setMaterial(param3.zpp_inner);
               zpp_inner.material.wrapper();
            }
            if(param4 == null)
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
               if(param4 == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Cannot assign null as Shape filter";
               }
               zpp_inner.setFilter(param4.zpp_inner);
               zpp_inner.filter.wrapper();
            }
            zpp_inner_i.insert_cbtype(ZPP_CbType.ANY_SHAPE.zpp_inner);
            return;
         }
      }
      
      public function set radius(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("Circle::radius");
         if(zpp_inner.body != null && zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC && zpp_inner.body.space != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot modifiy radius of Circle contained in static object once added to space";
         }
         if(param1 != zpp_inner_zn.radius)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: Circle::radius cannot be NaN";
            }
            if(param1 < Config.epsilon)
            {
               Boot.lastError = new Error();
               throw "Error: Circle::radius (" + param1 + ") must be > Config.epsilon";
            }
            if(param1 > 1e+100)
            {
               Boot.lastError = new Error();
               throw "Error: Circle::radius (" + param1 + ") must be < PR(Const).FMAX";
            }
            zpp_inner_zn.radius = param1;
            zpp_inner_zn.invalidate_radius();
         }
         return zpp_inner_zn.radius;
      }
      
      public function get radius() : Number
      {
         return zpp_inner_zn.radius;
      }
   }
}
