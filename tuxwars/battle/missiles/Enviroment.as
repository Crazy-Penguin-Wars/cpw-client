package tuxwars.battle.missiles
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import nape.dynamics.ArbiterList;
   import nape.phys.Body;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.gameobjects.EmissionSpawn;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   import tuxwars.data.SoundManager;
   
   public class Enviroment extends Missile
   {
       
      
      private var _duration:int;
      
      private var _interval:int;
      
      private var _randomIntervalStart:Boolean;
      
      private var _durationElapsed:int;
      
      private var _intervalElapsed:int;
      
      private var activated:Boolean;
      
      private var _atSleepToStaticAndSensor:Boolean;
      
      public function Enviroment(def:MissileDef, game:DCGame)
      {
         super(def,game);
         _duration = def.duration;
         _interval = def.interval;
         _randomIntervalStart = def.randomIntervalStart;
         _atSleepToStaticAndSensor = def.atSleepToStaticAndSensor;
         if(_randomIntervalStart)
         {
            LogUtils.log("Call to random Enviroment()",this,0,"Random",false,false,false);
            _intervalElapsed += BattleManager.getRandom().integer(0,_interval);
            LogUtils.log("Enviroment got random intervalElapsed of: " + _intervalElapsed + "/" + _interval,this,0,"Emission",false,false,false);
         }
         tag.allowClear = false;
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         super.physicsUpdate(deltaTime);
         if(!body)
         {
            return;
         }
         if(!activated)
         {
            LogUtils.log("Activated environment: " + shortName + " stepTime: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
            activated = true;
         }
         _intervalElapsed += deltaTime;
         _durationElapsed += deltaTime;
         if(_atSleepToStaticAndSensor && body.isSleeping && body.allowMovement)
         {
            body.allowMovement = false;
            body.velocity.setxy(0,0);
            setCollisionFilterValues(0,0);
         }
         if(_intervalElapsed >= _interval && _durationElapsed <= _duration)
         {
            location = body.position.copy();
            emitLocation = body.position.copy();
            LogUtils.log("Environment: " + shortName + " explodes intervalElapsed: " + _intervalElapsed + " interval: " + _interval + " location: " + location + " stepTime: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
            _intervalElapsed -= _interval;
            var _loc2_:*;
            MessageCenter.sendEvent(new EmissionMessage(new EmissionSpawn(this,location,tagger),!!tagger ? (_loc2_ = tagger.gameObject, _loc2_._id) : null));
         }
         if(_durationElapsed >= _duration)
         {
            LogUtils.log("Environment: " + shortName + " finished durationElapsed: " + _durationElapsed + " duration: " + _duration + " stepTime: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
            markForRemoval();
         }
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,otherBody.userData.gameObject,findFirstCollisionPosition(arbiterList)));
         SoundManager.markCollision(this,otherBody.userData.gameObject);
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
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         var _loc3_:* = type;
         if("enviroment" !== _loc3_)
         {
            return super.affectsGameObject(type,taggerGameObject);
         }
         return true;
      }
   }
}
