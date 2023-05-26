package tuxwars.battle.input
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.MathUtils;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import nape.geom.Vec2;
   import nape.shape.Circle;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.events.PlayerFiredMessage;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.battle.world.SpawnPointFinder;
   
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
      
      public function WeaponControls(weapon:Weapon)
      {
         super();
         this.weapon = weapon;
         targetingPowerPercentage = -1;
         loadAimingGraphics();
         MessageCenter.addListener("PlayerFired",removePowerBar);
      }
      
      private function loadAimingGraphics() : void
      {
         var boundingBox:* = null;
         switch(weapon.targeting)
         {
            case "Target":
            case "TargetGlobal":
               targetingCursors = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","aim_ui");
               targetingCursors.stop();
               targetingGraphics = targetingCursors.getChildByName("Power_Bar") as MovieClip;
               targetingGraphics.gotoAndStop(101);
               break;
            case "Activation":
            case "Aiming":
               targetingCursors = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","aim_ui");
               targetingCursors.stop();
               targetingGraphics = targetingCursors.getChildByName("Power_Bar") as MovieClip;
               targetingGraphics.gotoAndStop(100);
               break;
            case "PowerBar":
               targetingCursors = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","aim_ui");
               targetingCursors.gotoAndStop(0);
               targetingGraphics = targetingCursors.getChildByName("Power_Bar") as MovieClip;
               boundingBox = targetingGraphics.getChildByName("Bounding_Box") as MovieClip;
               barLength = boundingBox.width;
               barDistanceFromPivot = Math.abs(targetingGraphics.y);
         }
      }
      
      private function removePowerBar(msg:PlayerFiredMessage) : void
      {
         showPowerBar(false);
      }
      
      public function showPowerBar(value:Boolean) : void
      {
         if(value && !controlsVisible())
         {
            weapon.player.container.addChild(targetingCursors);
         }
         else if(!value && controlsVisible())
         {
            weapon.player.container.removeChild(targetingCursors);
         }
      }
      
      public function updateAiming(vector:Vec2) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:* = null;
         var _loc6_:Number = NaN;
         var _loc5_:int = 0;
         var _loc7_:Number = NaN;
         var angleDegrees:Number = NaN;
         if(BattleManager.getCurrentActivePlayer() == weapon.player)
         {
            if(!controlsVisible())
            {
               showPowerBar(true);
            }
            _allowFire = true;
            if(weapon.targeting == "Target" || weapon.targeting == "TargetGlobal")
            {
               if(weapon.player.body)
               {
                  if(finder == null)
                  {
                     var _loc8_:* = weapon.player;
                     finder = new SpawnPointFinder((_loc8_.game as tuxwars.TuxWarsGame).tuxWorld);
                  }
                  _loc3_ = Number(Circle(weapon.player.body.shapes.at(0)).radius);
                  _loc2_ = weapon.player.body.position.copy();
                  _targetLocation.x = _loc2_.x;
                  _targetLocation.y = _loc2_.y;
                  _targetLocation.x += vector.x;
                  _targetLocation.y += vector.y;
                  targetingGraphics.x = vector.x;
                  targetingGraphics.y = vector.y;
                  if(weapon.targeting == "TargetGlobal" || finder.isValidPoint(_targetLocation,_loc3_))
                  {
                     targetingGraphics.transform.colorTransform = new ColorTransform(1,1,1);
                  }
                  else
                  {
                     targetingGraphics.transform.colorTransform = new ColorTransform(1,0,0);
                     _allowFire = false;
                  }
               }
            }
            else
            {
               if(weapon.targeting == "PowerBar")
               {
                  _loc6_ = Math.min(Math.max(0,vector.length - barDistanceFromPivot),barLength);
                  targetingPowerPercentage = barLength != 0 ? 100 * _loc6_ / barLength : -1;
                  _loc5_ = targetingGraphics.totalFrames - 2 - (targetingGraphics.totalFrames - 2) * _loc6_ / barLength;
                  targetingGraphics.gotoAndStop(_loc5_);
               }
               if(vector.length != 0)
               {
                  vector.normalise();
               }
               var _loc9_:Config = Config;
               _loc7_ = Math.acos(vector.dot(Config.VEC_UP.copy()));
               angleDegrees = Number(vector.x > 0 ? MathUtils.radiansToDegrees(_loc7_) : -MathUtils.radiansToDegrees(_loc7_));
               if(weapon.targeting == "Activation")
               {
                  if(vector.x > 0)
                  {
                     vector.x = 1;
                     vector.y = 0;
                     angleDegrees = 90;
                  }
                  else
                  {
                     vector.x = -1;
                     vector.y = 0;
                     angleDegrees = -90;
                  }
                  if(vector.length != 0)
                  {
                     vector.normalise();
                  }
               }
               targetingCursors.rotation = angleDegrees;
            }
         }
      }
      
      private function controlsVisible() : Boolean
      {
         return weapon.player.container.contains(targetingCursors);
      }
      
      public function dispose() : void
      {
         MessageCenter.removeListener("PlayerFired",removePowerBar);
         showPowerBar(false);
         weapon = null;
         targetingCursors = null;
         targetingGraphics = null;
         finder = null;
      }
      
      public function getLastTargetingPowerPercentage() : int
      {
         return targetingPowerPercentage;
      }
      
      public function get allowFire() : Boolean
      {
         return _allowFire;
      }
      
      public function get targetLocation() : Vec2
      {
         return _targetLocation;
      }
   }
}
