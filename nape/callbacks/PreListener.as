package nape.callbacks
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_InteractionListener;
   import zpp_nape.callbacks.ZPP_Listener;
   import zpp_nape.callbacks.ZPP_OptionType;
   import zpp_nape.util.ZPP_Flags;
   
   public final class PreListener extends Listener
   {
       
      
      public var zpp_inner_zn:ZPP_InteractionListener;
      
      public function PreListener(param1:InteractionType, param2:*, param3:*, param4:Function, param5:int = 0, param6:Boolean = false)
      {
         var _loc7_:int = 0;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = null;
         ZPP_Listener.§internal§ = true;
         super();
         ZPP_Listener.§internal§ = false;
         if(param4 == null)
         {
            Boot.lastError = new Error();
            throw "Error: PreListener must take a handler!";
         }
         zpp_inner_zn = new ZPP_InteractionListener(ZPP_OptionType.argument(param2),ZPP_OptionType.argument(param3),ZPP_Flags.id_CbEvent_PRE,ZPP_Flags.id_ListenerType_PRE);
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
         zpp_inner_zn.outer_znp = this;
         zpp_inner.precedence = param5;
         zpp_inner_zn.pure = param6;
         zpp_inner_zn.handlerp = param4;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set listener interaction type to null";
         }
         _loc7_ = zpp_inner_zn.itype;
         if(_loc7_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_COLLISION);
         }
         else if(_loc7_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         else if(_loc7_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_FLUID);
         }
         else if(_loc7_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_ANY);
         }
         else
         {
            §§push(null);
         }
         if(§§pop() != param1)
         {
            §§push(param1);
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.InteractionType_COLLISION)
            {
               §§push(ZPP_Flags.id_InteractionType_COLLISION);
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.InteractionType_SENSOR == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               if(§§pop() == ZPP_Flags.InteractionType_SENSOR)
               {
                  §§push(ZPP_Flags.id_InteractionType_SENSOR);
               }
               else
               {
                  §§push(param1);
                  if(ZPP_Flags.InteractionType_FLUID == null)
                  {
                     ZPP_Flags.§internal§ = true;
                     ZPP_Flags.InteractionType_FLUID = new InteractionType();
                     ZPP_Flags.§internal§ = false;
                  }
                  §§push(§§pop() == ZPP_Flags.InteractionType_FLUID ? ZPP_Flags.id_InteractionType_FLUID : ZPP_Flags.id_InteractionType_ANY);
               }
            }
            _loc7_ = §§pop();
            zpp_inner_zn.itype = _loc7_;
         }
         _loc7_ = zpp_inner_zn.itype;
         if(_loc7_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            ZPP_Flags.InteractionType_COLLISION;
         }
         else if(_loc7_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            ZPP_Flags.InteractionType_SENSOR;
         }
         else if(_loc7_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            ZPP_Flags.InteractionType_FLUID;
         }
         else if(_loc7_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            ZPP_Flags.InteractionType_ANY;
         }
      }
      
      public function set pure(param1:Boolean) : Boolean
      {
         if(!param1)
         {
            zpp_inner_zn.wake();
         }
         zpp_inner_zn.pure = param1;
         return zpp_inner_zn.pure;
      }
      
      public function set options2(param1:OptionType) : OptionType
      {
         zpp_inner_zn.options2.set(param1.zpp_inner);
         return zpp_inner_zn.options2.outer;
      }
      
      public function set options1(param1:OptionType) : OptionType
      {
         zpp_inner_zn.options1.set(param1.zpp_inner);
         return zpp_inner_zn.options1.outer;
      }
      
      public function set interactionType(param1:InteractionType) : InteractionType
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set listener interaction type to null";
         }
         _loc2_ = zpp_inner_zn.itype;
         if(_loc2_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_COLLISION);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_FLUID);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_ANY);
         }
         else
         {
            §§push(null);
         }
         if(§§pop() != param1)
         {
            §§push(param1);
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.InteractionType_COLLISION)
            {
               §§push(ZPP_Flags.id_InteractionType_COLLISION);
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.InteractionType_SENSOR == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               if(§§pop() == ZPP_Flags.InteractionType_SENSOR)
               {
                  §§push(ZPP_Flags.id_InteractionType_SENSOR);
               }
               else
               {
                  §§push(param1);
                  if(ZPP_Flags.InteractionType_FLUID == null)
                  {
                     ZPP_Flags.§internal§ = true;
                     ZPP_Flags.InteractionType_FLUID = new InteractionType();
                     ZPP_Flags.§internal§ = false;
                  }
                  §§push(§§pop() == ZPP_Flags.InteractionType_FLUID ? ZPP_Flags.id_InteractionType_FLUID : ZPP_Flags.id_InteractionType_ANY);
               }
            }
            _loc2_ = §§pop();
            zpp_inner_zn.itype = _loc2_;
         }
         _loc2_ = zpp_inner_zn.itype;
         if(_loc2_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_COLLISION);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_FLUID);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_ANY);
         }
         else
         {
            §§push(null);
         }
         return §§pop();
      }
      
      public function set handler(param1:Function) : Function
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: PreListener must take a non-null handler!";
         }
         zpp_inner_zn.handlerp = param1;
         zpp_inner_zn.wake();
         return zpp_inner_zn.handlerp;
      }
      
      public function get pure() : Boolean
      {
         return zpp_inner_zn.pure;
      }
      
      public function get options2() : OptionType
      {
         return zpp_inner_zn.options2.outer;
      }
      
      public function get options1() : OptionType
      {
         return zpp_inner_zn.options1.outer;
      }
      
      public function get interactionType() : InteractionType
      {
         var _loc1_:int = zpp_inner_zn.itype;
         if(_loc1_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_COLLISION);
         }
         else if(_loc1_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         else if(_loc1_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_FLUID);
         }
         else if(_loc1_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_ANY);
         }
         else
         {
            §§push(null);
         }
         return §§pop();
      }
      
      public function get handler() : Function
      {
         return zpp_inner_zn.handlerp;
      }
   }
}
