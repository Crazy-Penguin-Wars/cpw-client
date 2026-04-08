package tuxwars.battle.gameobjects
{
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import tuxwars.*;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.data.*;
   import tuxwars.items.references.EmissionReference;
   
   public class PhysicsEmissionGameObject extends PhysicsGameObject implements Emission, SimpleScript
   {
      private var _emissionData:Object = {};
      
      private var _emissions:Array;
      
      private var _emitLocation:Vec2;
      
      protected var _location:Vec2;
      
      protected var _locationOriginal:Vec2;
      
      protected var emittingDone:Boolean;
      
      private var _explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper;
      
      private var _simpleScript:Array;
      
      private var _playerBoosterStats:Stats;
      
      private var _firingPlayerId:String;
      
      public function PhysicsEmissionGameObject(param1:PhysicsEmissionGameObjectDef, param2:TuxWarsGame)
      {
         super(param1,param2);
         this._emissions = param1.emissions;
         this._simpleScript = param1.simpleScript;
         if(body)
         {
            this._locationOriginal = body.position.copy();
         }
         if(param1.playerAttackValue)
         {
            stats.addStat("Attackers_Stat",param1.playerAttackValue,body);
         }
      }
      
      override public function dispose() : void
      {
         if(this._game as TuxWarsGame != null && (this._game as TuxWarsGame).tuxWorld != null && (this._game as TuxWarsGame).tuxWorld.physicsWorld != null)
         {
            LogUtils.log("Disposing emission stepTime:" + (this._game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
         }
         this._emissionData = null;
         this._emissions = null;
         if(this._explosionPreCalculationsWrapper)
         {
            this._explosionPreCalculationsWrapper.dispose();
            this._explosionPreCalculationsWrapper = null;
         }
         if(this._playerBoosterStats)
         {
            this._playerBoosterStats.dispose();
            this._playerBoosterStats = null;
         }
         super.dispose();
      }
      
      public function get firingPlayerId() : String
      {
         return this._firingPlayerId;
      }
      
      public function set firingPlayerId(param1:String) : void
      {
         this._firingPlayerId = param1;
      }
      
      public function get emissions() : Array
      {
         return this._emissions;
      }
      
      public function get tagger() : Tagger
      {
         return !!tag ? tag.findLatestPlayerTagger() : null;
      }
      
      public function isFinished() : Boolean
      {
         return this._markedForRemoval;
      }
      
      public function readyToEmit() : Boolean
      {
         return this._emissions != null && !this.emittingDone && Boolean(this._location);
      }
      
      public function setEmittingDone() : void
      {
         LogUtils.log("Setting emitting done for: " + shortName,this,1,"Emission",false,false,false);
         markForRemoval();
         this.emittingDone = true;
      }
      
      public function isEmittingDone() : Boolean
      {
         return this.emittingDone;
      }
      
      public function getBoosterMissileEmissions() : Array
      {
         return null;
      }
      
      public function getBoosterExplosionEmissions() : Array
      {
         return null;
      }
      
      public function get radius() : Number
      {
         return 0;
      }
      
      public function set location(param1:Vec2) : void
      {
         this._location = param1;
      }
      
      public function get location() : Vec2
      {
         return this._location;
      }
      
      public function get emitLocation() : Vec2
      {
         return this._emitLocation != null ? this._emitLocation : bodyLocation;
      }
      
      public function set emitLocation(param1:Vec2) : void
      {
         this._emitLocation = param1;
      }
      
      public function get playerAttackValueStat() : Stat
      {
         var _loc1_:String = "Attackers_Stat";
         return !!this.stats ? this.stats.getStat(_loc1_) : null;
      }
      
      public function set playerAttackValue(param1:int) : void
      {
         if(stats.hasStat("Attackers_Stat"))
         {
            stats.deleteStat("Attackers_Stat");
         }
         stats.create("Attackers_Stat",body,param1);
      }
      
      public function setEmissionsParams(param1:String, param2:*) : void
      {
         this._emissionData[param1] = param2;
      }
      
      public function getEmissionsParams(param1:String) : *
      {
         if(!this._emissionData)
         {
            return null;
         }
         return this._emissionData[param1];
      }
      
      public function hasEmissionsParams(param1:String) : Boolean
      {
         return Boolean(this._emissionData) && Boolean(this._emissionData.hasOwnProperty(param1));
      }
      
      public function setEmissionData(param1:EmissionReference, param2:String, param3:*) : void
      {
         if(this._emissionData[param1.id] == null)
         {
            this._emissionData[param1.id] = {};
         }
         this._emissionData[param1.id][param2] = param3;
      }
      
      public function getEmissionData(param1:EmissionReference, param2:String) : *
      {
         if(!this._emissionData || this._emissionData[param1.id] == null)
         {
            return null;
         }
         return this._emissionData[param1.id][param2];
      }
      
      public function hasEmissionData(param1:EmissionReference, param2:String) : Boolean
      {
         return this.hasEmissionsParams(param1.id) && Boolean(this._emissionData[param1.id].hasOwnProperty(param2));
      }
      
      public function resetEmissionData() : void
      {
         this._emissionData = {};
      }
      
      override public function set soundId(param1:String) : void
      {
         super.soundId = param1;
         if(param1)
         {
            this.playSound();
            this.playLoopSound();
         }
      }
      
      public function setExplosionPrecalculationsWrapper(param1:ExplosionPreCalculationsWrapper) : void
      {
         this._explosionPreCalculationsWrapper = param1;
      }
      
      public function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         return this._explosionPreCalculationsWrapper;
      }
      
      public function playSound() : void
      {
         var _loc1_:SoundReference = Sounds.getSoundReference(soundId);
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc1_.getMusicID(),_loc1_.getStart(),_loc1_.getType()));
         }
      }
      
      public function playLoopSound() : void
      {
         var _loc1_:SoundReference = Sounds.getSoundReference(soundId);
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopSound",_loc1_.getMusicID(),_loc1_.getLoop(),_loc1_.getType()));
         }
      }
      
      public function triggerEmission() : void
      {
         var _loc1_:* = undefined;
         MessageCenter.sendEvent(new EmissionMessage(this,!!this.tagger ? (_loc1_ = this.tagger.gameObject, _loc1_._id) : null));
      }
      
      public function get className() : String
      {
         var _loc1_:String = null;
         if(Boolean(this._simpleScript) && this._simpleScript.length > 0)
         {
            return this._simpleScript[0];
         }
         return null;
      }
      
      public function get variables() : Array
      {
         return this._simpleScript;
      }
      
      public function get locationOriginal() : Vec2
      {
         return this._locationOriginal;
      }
      
      public function set locationOriginal(param1:Vec2) : void
      {
         this._locationOriginal = param1;
      }
      
      public function set playerBoosterStats(param1:Stats) : void
      {
         this._playerBoosterStats = Stats.copyStats(param1,this._playerBoosterStats);
      }
      
      public function get playerBoosterStats() : Stats
      {
         return this._playerBoosterStats;
      }
      
      override protected function updateGraphics() : void
      {
         var _loc1_:Vec2 = null;
         var _loc2_:Number = Number(NaN);
         if(body)
         {
            this.displayObject.x = bodyLocation.x;
            this.displayObject.y = bodyLocation.y;
            if(allowDisplayObjectRotation && body.allowRotation)
            {
               this.displayObject.rotation = body.rotation;
            }
            else
            {
               _loc1_ = linearVelocity;
               if(_loc1_.length >= 0.00001)
               {
                  _loc1_.normalise();
                  _loc2_ = Math.acos(_loc1_.dot(Config.VEC_UP));
                  this.displayObject.rotation = _loc1_.x < 0 ? -_loc2_ : _loc2_;
               }
            }
         }
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         super.handleCollision(param1,param2);
         MessageCenter.sendMessage("MissileContact",this);
      }
      
      override protected function outOfWorld() : void
      {
         if(body && !this.isFinished() && !this._location)
         {
            this._location = bodyLocation.copy();
            LogUtils.log(this._id + ": Out of world!","PhysicsEmissionGameObject",1,"LevelObjects",false,false,false);
         }
      }
   }
}

