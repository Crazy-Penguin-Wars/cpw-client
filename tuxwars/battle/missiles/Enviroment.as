package tuxwars.battle.missiles
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.dynamics.ArbiterList;
   import nape.phys.Body;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   
   public class Enviroment extends Missile
   {
      private var _duration:int;
      
      private var _interval:int;
      
      private var _randomIntervalStart:Boolean;
      
      private var _durationElapsed:int;
      
      private var _intervalElapsed:int;
      
      private var activated:Boolean;
      
      private var _atSleepToStaticAndSensor:Boolean;
      
      public function Enviroment(param1:MissileDef, param2:DCGame)
      {
         super(param1,param2);
         this._duration = param1.duration;
         this._interval = param1.interval;
         this._randomIntervalStart = param1.randomIntervalStart;
         this._atSleepToStaticAndSensor = param1.atSleepToStaticAndSensor;
         if(this._randomIntervalStart)
         {
            LogUtils.log("Call to random Enviroment()",this,0,"Random",false,false,false);
            this._intervalElapsed += BattleManager.getRandom().integer(0,this._interval);
            LogUtils.log("Enviroment got random intervalElapsed of: " + this._intervalElapsed + "/" + this._interval,this,0,"Emission",false,false,false);
         }
         tag.allowClear = false;
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         var _loc2_:* = undefined;
         super.physicsUpdate(param1);
         if(!body)
         {
            return;
         }
         if(!this.activated)
         {
            LogUtils.log("Activated environment: " + shortName + " stepTime: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
            this.activated = true;
         }
         this._intervalElapsed += param1;
         this._durationElapsed += param1;
         if(Boolean(this._atSleepToStaticAndSensor) && body.isSleeping && body.allowMovement)
         {
            body.allowMovement = false;
            body.velocity.setxy(0,0);
            setCollisionFilterValues(0,0);
         }
         if(this._intervalElapsed >= this._interval && this._durationElapsed <= this._duration)
         {
            location = body.position.copy();
            emitLocation = body.position.copy();
            LogUtils.log("Environment: " + shortName + " explodes intervalElapsed: " + this._intervalElapsed + " interval: " + this._interval + " location: " + location + " stepTime: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
            this._intervalElapsed -= this._interval;
            MessageCenter.sendEvent(new EmissionMessage(new EmissionSpawn(this,location,tagger),!!tagger ? (_loc2_ = tagger.gameObject, _loc2_._id) : null));
         }
         if(this._durationElapsed >= this._duration)
         {
            LogUtils.log("Environment: " + shortName + " finished durationElapsed: " + this._durationElapsed + " duration: " + this._duration + " stepTime: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
            markForRemoval();
         }
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,param1.userData.gameObject,findFirstCollisionPosition(param2)));
         SoundManager.markCollision(this,param1.userData.gameObject);
      }
      
      override public function setEmittingDone() : void
      {
      }
      
      override public function isFinished() : Boolean
      {
         return true;
      }
      
      override public function readyToEmit() : Boolean
      {
         return false;
      }
      
      override protected function outOfWorld() : void
      {
         if(!this._markedForRemoval)
         {
            markForRemoval();
            emptyCollectedDamage();
            LogUtils.log(this._id + ": Out of world!",this,1,"LevelObjects",false,false,false);
         }
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         var _loc3_:* = param1;
         if("enviroment" !== _loc3_)
         {
            return super.affectsGameObject(param1,param2);
         }
         return true;
      }
   }
}

