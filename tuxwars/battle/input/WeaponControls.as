package tuxwars.battle.input
{
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.geom.*;
   import nape.geom.*;
   import nape.shape.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.events.PlayerFiredMessage;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.battle.world.*;
   
   public class WeaponControls
   {
      public static const POWER_BAR:String = "PowerBar";
      
      public static const AIMING:String = "Aiming";
      
      public static const TARGET:String = "Target";
      
      public static const TARGET_GLOBAL:String = "TargetGlobal";
      
      public static const ACTIVATION:String = "Activation";
      
      private static const AIM_UI:String = "aim_ui";
      
      private static const BOUNDING_BOX:String = "Bounding_Box";
      
      private static const POWER_BAR_GRAPHICS:String = "Power_Bar";
      
      private const _targetLocation:Vec2 = new Vec2();
      
      private var barLength:Number;
      
      private var barDistanceFromPivot:Number;
      
      private var weapon:Weapon;
      
      private var targetingGraphics:MovieClip;
      
      private var targetingCursors:MovieClip;
      
      private var targetingPowerPercentage:int;
      
      private var finder:SpawnPointFinder;
      
      private var _allowFire:Boolean;
      
      public function WeaponControls(param1:Weapon)
      {
         super();
         this.weapon = param1;
         this.targetingPowerPercentage = -1;
         this.loadAimingGraphics();
         MessageCenter.addListener("PlayerFired",this.removePowerBar);
      }
      
      private function loadAimingGraphics() : void
      {
         var _loc1_:MovieClip = null;
         switch(this.weapon.targeting)
         {
            case "Target":
            case "TargetGlobal":
               this.targetingCursors = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","aim_ui");
               this.targetingCursors.stop();
               this.targetingGraphics = this.targetingCursors.getChildByName("Power_Bar") as MovieClip;
               this.targetingGraphics.gotoAndStop(101);
               break;
            case "Activation":
            case "Aiming":
               this.targetingCursors = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","aim_ui");
               this.targetingCursors.stop();
               this.targetingGraphics = this.targetingCursors.getChildByName("Power_Bar") as MovieClip;
               this.targetingGraphics.gotoAndStop(100);
               break;
            case "PowerBar":
               this.targetingCursors = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","aim_ui");
               this.targetingCursors.gotoAndStop(0);
               this.targetingGraphics = this.targetingCursors.getChildByName("Power_Bar") as MovieClip;
               _loc1_ = this.targetingGraphics.getChildByName("Bounding_Box") as MovieClip;
               this.barLength = _loc1_.width;
               this.barDistanceFromPivot = Math.abs(this.targetingGraphics.y);
         }
      }
      
      private function removePowerBar(param1:PlayerFiredMessage) : void
      {
         this.showPowerBar(false);
      }
      
      public function showPowerBar(param1:Boolean) : void
      {
         if(param1 && !this.controlsVisible())
         {
            this.weapon.player.container.addChild(this.targetingCursors);
         }
         else if(!param1 && Boolean(this.controlsVisible()))
         {
            this.weapon.player.container.removeChild(this.targetingCursors);
         }
      }
      
      public function updateAiming(param1:Vec2) : void
      {
         var _loc8_:* = undefined;
         var _loc9_:Config = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Vec2 = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:int = 0;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         if(BattleManager.getCurrentActivePlayer() == this.weapon.player)
         {
            if(!this.controlsVisible())
            {
               this.showPowerBar(true);
            }
            this._allowFire = true;
            if(this.weapon.targeting == "Target" || this.weapon.targeting == "TargetGlobal")
            {
               if(this.weapon.player.body)
               {
                  if(this.finder == null)
                  {
                     _loc8_ = this.weapon.player;
                     this.finder = new SpawnPointFinder((_loc8_.game as TuxWarsGame).tuxWorld);
                  }
                  _loc2_ = Number(Circle(this.weapon.player.body.shapes.at(0)).radius);
                  _loc3_ = this.weapon.player.body.position.copy();
                  this._targetLocation.x = _loc3_.x;
                  this._targetLocation.y = _loc3_.y;
                  this._targetLocation.x += param1.x;
                  this._targetLocation.y += param1.y;
                  this.targetingGraphics.x = param1.x;
                  this.targetingGraphics.y = param1.y;
                  if(this.weapon.targeting == "TargetGlobal" || Boolean(this.finder.isValidPoint(this._targetLocation,_loc2_)))
                  {
                     this.targetingGraphics.transform.colorTransform = new ColorTransform(1,1,1);
                  }
                  else
                  {
                     this.targetingGraphics.transform.colorTransform = new ColorTransform(1,0,0);
                     this._allowFire = false;
                  }
               }
            }
            else
            {
               if(this.weapon.targeting == "PowerBar")
               {
                  _loc4_ = Math.min(Math.max(0,param1.length - this.barDistanceFromPivot),this.barLength);
                  this.targetingPowerPercentage = this.barLength != 0 ? int(100 * _loc4_ / this.barLength) : -1;
                  _loc5_ = this.targetingGraphics.totalFrames - 2 - (this.targetingGraphics.totalFrames - 2) * _loc4_ / this.barLength;
                  this.targetingGraphics.gotoAndStop(_loc5_);
               }
               if(param1.length != 0)
               {
                  param1.normalise();
               }
               _loc9_ = Config;
               _loc6_ = Math.acos(param1.dot(Config.VEC_UP.copy()));
               _loc7_ = param1.x > 0 ? Number(MathUtils.radiansToDegrees(_loc6_)) : -MathUtils.radiansToDegrees(_loc6_);
               if(this.weapon.targeting == "Activation")
               {
                  if(param1.x > 0)
                  {
                     param1.x = 1;
                     param1.y = 0;
                     _loc7_ = 90;
                  }
                  else
                  {
                     param1.x = -1;
                     param1.y = 0;
                     _loc7_ = -90;
                  }
                  if(param1.length != 0)
                  {
                     param1.normalise();
                  }
               }
               this.targetingCursors.rotation = _loc7_;
            }
         }
      }
      
      private function controlsVisible() : Boolean
      {
         return this.weapon.player.container.contains(this.targetingCursors);
      }
      
      public function dispose() : void
      {
         MessageCenter.removeListener("PlayerFired",this.removePowerBar);
         this.showPowerBar(false);
         this.weapon = null;
         this.targetingCursors = null;
         this.targetingGraphics = null;
         this.finder = null;
      }
      
      public function getLastTargetingPowerPercentage() : int
      {
         return this.targetingPowerPercentage;
      }
      
      public function get allowFire() : Boolean
      {
         return this._allowFire;
      }
      
      public function get targetLocation() : Vec2
      {
         return this._targetLocation;
      }
   }
}

