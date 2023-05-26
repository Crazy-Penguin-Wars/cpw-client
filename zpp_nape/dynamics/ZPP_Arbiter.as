package zpp_nape.dynamics
{
   import flash.Boot;
   import nape.dynamics.Arbiter;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.FluidArbiter;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_AABBPair;
   
   public class ZPP_Arbiter
   {
      
      public static var §internal§:Boolean = false;
      
      public static var COL:int = 1;
      
      public static var FLUID:int = 4;
      
      public static var SENSOR:int = 2;
       
      
      public var ws2:ZPP_Shape;
      
      public var ws1:ZPP_Shape;
      
      public var up_stamp:int;
      
      public var type:int;
      
      public var stamp:int;
      
      public var sleeping:Boolean;
      
      public var sleep_stamp:int;
      
      public var sensorarb:ZPP_SensorArbiter;
      
      public var presentable:Boolean;
      
      public var present:int;
      
      public var pair:ZPP_AABBPair;
      
      public var outer:Arbiter;
      
      public var invalidated:Boolean;
      
      public var intchange:Boolean;
      
      public var immState:int;
      
      public var id:int;
      
      public var hnext:ZPP_Arbiter;
      
      public var fresh:Boolean;
      
      public var fluidarb:ZPP_FluidArbiter;
      
      public var endGenerated:int;
      
      public var di:int;
      
      public var continuous:Boolean;
      
      public var colarb:ZPP_ColArbiter;
      
      public var cleared:Boolean;
      
      public var b2:ZPP_Body;
      
      public var b1:ZPP_Body;
      
      public var active:Boolean;
      
      public function ZPP_Arbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         sensorarb = null;
         fluidarb = null;
         colarb = null;
         type = 0;
         pair = null;
         ws2 = null;
         ws1 = null;
         b2 = null;
         b1 = null;
         invalidated = false;
         immState = 0;
         fresh = false;
         continuous = false;
         presentable = false;
         intchange = false;
         present = 0;
         sleeping = false;
         cleared = false;
         active = false;
         endGenerated = 0;
         sleep_stamp = 0;
         up_stamp = 0;
         stamp = 0;
         di = 0;
         id = 0;
         hnext = null;
         outer = null;
      }
      
      public function wrapper() : Arbiter
      {
         if(outer == null)
         {
            ZPP_Arbiter.§internal§ = true;
            if(type == ZPP_Arbiter.COL)
            {
               colarb.outer_zn = new CollisionArbiter();
               outer = colarb.outer_zn;
            }
            else if(type == ZPP_Arbiter.FLUID)
            {
               fluidarb.outer_zn = new FluidArbiter();
               outer = fluidarb.outer_zn;
            }
            else
            {
               outer = new Arbiter();
            }
            outer.zpp_inner = this;
            ZPP_Arbiter.§internal§ = false;
         }
         return outer;
      }
   }
}
