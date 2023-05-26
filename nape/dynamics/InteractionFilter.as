package nape.dynamics
{
   import flash.Boot;
   import nape.shape.ShapeList;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.util.ZPP_ShapeList;
   
   public final class InteractionFilter
   {
       
      
      public var zpp_inner:ZPP_InteractionFilter;
      
      public function InteractionFilter(param1:int = 1, param2:int = -1, param3:int = 1, param4:int = -1, param5:int = 1, param6:int = -1)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(ZPP_InteractionFilter.zpp_pool == null)
         {
            zpp_inner = new ZPP_InteractionFilter();
         }
         else
         {
            zpp_inner = ZPP_InteractionFilter.zpp_pool;
            ZPP_InteractionFilter.zpp_pool = zpp_inner.next;
            zpp_inner.next = null;
         }
         zpp_inner.outer = this;
         if(zpp_inner.collisionGroup != param1)
         {
            zpp_inner.collisionGroup = param1;
            zpp_inner.invalidate();
         }
         zpp_inner.collisionGroup;
         if(zpp_inner.collisionMask != param2)
         {
            zpp_inner.collisionMask = param2;
            zpp_inner.invalidate();
         }
         zpp_inner.collisionMask;
         if(zpp_inner.sensorGroup != param3)
         {
            zpp_inner.sensorGroup = param3;
            zpp_inner.invalidate();
         }
         zpp_inner.sensorGroup;
         if(zpp_inner.sensorMask != param4)
         {
            zpp_inner.sensorMask = param4;
            zpp_inner.invalidate();
         }
         zpp_inner.sensorMask;
         if(zpp_inner.fluidGroup != param5)
         {
            zpp_inner.fluidGroup = param5;
            zpp_inner.invalidate();
         }
         zpp_inner.fluidGroup;
         if(zpp_inner.fluidMask != param6)
         {
            zpp_inner.fluidMask = param6;
            zpp_inner.invalidate();
         }
         zpp_inner.fluidMask;
      }
      
      public function toString() : String
      {
         return "{ collision: " + StringTools.hex(zpp_inner.collisionGroup,8) + "~" + StringTools.hex(zpp_inner.collisionMask,8) + " sensor: " + StringTools.hex(zpp_inner.sensorGroup,8) + "~" + StringTools.hex(zpp_inner.sensorMask,8) + " fluid: " + StringTools.hex(zpp_inner.fluidGroup,8) + "~" + StringTools.hex(zpp_inner.fluidMask,8) + " }";
      }
      
      public function shouldSense(param1:InteractionFilter) : Boolean
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: filter argument cannot be null for shouldSense";
         }
         var _loc2_:ZPP_InteractionFilter = zpp_inner;
         var _loc3_:ZPP_InteractionFilter = param1.zpp_inner;
         return (_loc2_.sensorMask & _loc3_.sensorGroup) != 0 && (_loc3_.sensorMask & _loc2_.sensorGroup) != 0;
      }
      
      public function shouldFlow(param1:InteractionFilter) : Boolean
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: filter argument cannot be null for shouldFlow";
         }
         var _loc2_:ZPP_InteractionFilter = zpp_inner;
         var _loc3_:ZPP_InteractionFilter = param1.zpp_inner;
         return (_loc2_.fluidMask & _loc3_.fluidGroup) != 0 && (_loc3_.fluidMask & _loc2_.fluidGroup) != 0;
      }
      
      public function shouldCollide(param1:InteractionFilter) : Boolean
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: filter argument cannot be null for shouldCollide";
         }
         var _loc2_:ZPP_InteractionFilter = zpp_inner;
         var _loc3_:ZPP_InteractionFilter = param1.zpp_inner;
         return (_loc2_.collisionMask & _loc3_.collisionGroup) != 0 && (_loc3_.collisionMask & _loc2_.collisionGroup) != 0;
      }
      
      public function set sensorMask(param1:int) : int
      {
         if(zpp_inner.sensorMask != param1)
         {
            zpp_inner.sensorMask = param1;
            zpp_inner.invalidate();
         }
         return zpp_inner.sensorMask;
      }
      
      public function set sensorGroup(param1:int) : int
      {
         if(zpp_inner.sensorGroup != param1)
         {
            zpp_inner.sensorGroup = param1;
            zpp_inner.invalidate();
         }
         return zpp_inner.sensorGroup;
      }
      
      public function set fluidMask(param1:int) : int
      {
         if(zpp_inner.fluidMask != param1)
         {
            zpp_inner.fluidMask = param1;
            zpp_inner.invalidate();
         }
         return zpp_inner.fluidMask;
      }
      
      public function set fluidGroup(param1:int) : int
      {
         if(zpp_inner.fluidGroup != param1)
         {
            zpp_inner.fluidGroup = param1;
            zpp_inner.invalidate();
         }
         return zpp_inner.fluidGroup;
      }
      
      public function set collisionMask(param1:int) : int
      {
         if(zpp_inner.collisionMask != param1)
         {
            zpp_inner.collisionMask = param1;
            zpp_inner.invalidate();
         }
         return zpp_inner.collisionMask;
      }
      
      public function set collisionGroup(param1:int) : int
      {
         if(zpp_inner.collisionGroup != param1)
         {
            zpp_inner.collisionGroup = param1;
            zpp_inner.invalidate();
         }
         return zpp_inner.collisionGroup;
      }
      
      public function get userData() : *
      {
         if(zpp_inner.userData == null)
         {
            zpp_inner.userData = {};
         }
         return zpp_inner.userData;
      }
      
      public function get shapes() : ShapeList
      {
         if(zpp_inner.wrap_shapes == null)
         {
            zpp_inner.wrap_shapes = ZPP_ShapeList.get(zpp_inner.shapes,true);
         }
         return zpp_inner.wrap_shapes;
      }
      
      public function get sensorMask() : int
      {
         return zpp_inner.sensorMask;
      }
      
      public function get sensorGroup() : int
      {
         return zpp_inner.sensorGroup;
      }
      
      public function get fluidMask() : int
      {
         return zpp_inner.fluidMask;
      }
      
      public function get fluidGroup() : int
      {
         return zpp_inner.fluidGroup;
      }
      
      public function get collisionMask() : int
      {
         return zpp_inner.collisionMask;
      }
      
      public function get collisionGroup() : int
      {
         return zpp_inner.collisionGroup;
      }
      
      public function copy() : InteractionFilter
      {
         return new InteractionFilter(zpp_inner.collisionGroup,zpp_inner.collisionMask,zpp_inner.sensorGroup,zpp_inner.sensorMask,zpp_inner.fluidGroup,zpp_inner.fluidMask);
      }
   }
}
