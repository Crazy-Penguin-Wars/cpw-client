package tuxwars.battle.gameobjects
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.emitters.ExplosionPreCalculationsWrapper;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.items.references.EmissionReference;
   
   public class PhysicsEmissionGameObject extends PhysicsGameObject implements Emission, SimpleScript
   {
       
      
      private var _emissionData:Object;
      
      private var _emissions:Array;
      
      private var _emitLocation:Vec2;
      
      protected var _location:Vec2;
      
      protected var _locationOriginal:Vec2;
      
      protected var emittingDone:Boolean;
      
      private var _explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper;
      
      private var _simpleScript:Array;
      
      private var _playerBoosterStats:Stats;
      
      private var _firingPlayerId:String;
      
      public function PhysicsEmissionGameObject(def:PhysicsEmissionGameObjectDef, game:TuxWarsGame)
      {
         _emissionData = {};
         super(def,game);
         _emissions = def.emissions;
         _simpleScript = def.simpleScript;
         if(body)
         {
            _locationOriginal = body.position.copy();
         }
         if(def.playerAttackValue)
         {
            stats.addStat("Attackers_Stat",def.playerAttackValue,body);
         }
      }
      
      override public function dispose() : void
      {
         if(this._game as TuxWarsGame != null && (this._game as TuxWarsGame).tuxWorld != null && (this._game as TuxWarsGame).tuxWorld.physicsWorld != null)
         {
            LogUtils.log("Disposing emission stepTime:" + (this._game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
         }
         _emissionData = null;
         _emissions = null;
         if(_explosionPreCalculationsWrapper)
         {
            _explosionPreCalculationsWrapper.dispose();
            _explosionPreCalculationsWrapper = null;
         }
         if(_playerBoosterStats)
         {
            _playerBoosterStats.dispose();
            _playerBoosterStats = null;
         }
         super.dispose();
      }
      
      public function get firingPlayerId() : String
      {
         return _firingPlayerId;
      }
      
      public function set firingPlayerId(value:String) : void
      {
         _firingPlayerId = value;
      }
      
      public function get emissions() : Array
      {
         return _emissions;
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
         return _emissions != null && !emittingDone && _location;
      }
      
      public function setEmittingDone() : void
      {
         LogUtils.log("Setting emitting done for: " + shortName,this,1,"Emission",false,false,false);
         markForRemoval();
         emittingDone = true;
      }
      
      public function isEmittingDone() : Boolean
      {
         return emittingDone;
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
      
      public function set location(location:Vec2) : void
      {
         _location = location;
      }
      
      public function get location() : Vec2
      {
         return _location;
      }
      
      public function get emitLocation() : Vec2
      {
         return _emitLocation != null ? _emitLocation : bodyLocation;
      }
      
      public function set emitLocation(value:Vec2) : void
      {
         _emitLocation = value;
      }
      
      public function get playerAttackValueStat() : Stat
      {
         return !!this.stats ? this.stats.getStat("Attackers_Stat") : null;
      }
      
      public function set playerAttackValue(value:int) : void
      {
         if(stats.hasStat("Attackers_Stat"))
         {
            stats.deleteStat("Attackers_Stat");
         }
         stats.create("Attackers_Stat",body,value);
      }
      
      public function setEmissionsParams(key:String, value:*) : void
      {
         _emissionData[key] = value;
      }
      
      public function getEmissionsParams(key:String) : *
      {
         if(!_emissionData)
         {
            return null;
         }
         return _emissionData[key];
      }
      
      public function hasEmissionsParams(key:String) : Boolean
      {
         return _emissionData && _emissionData.hasOwnProperty(key);
      }
      
      public function setEmissionData(emit:EmissionReference, key:String, value:*) : void
      {
         if(_emissionData[emit.id] == null)
         {
            _emissionData[emit.id] = {};
         }
         _emissionData[emit.id][key] = value;
      }
      
      public function getEmissionData(emit:EmissionReference, key:String) : *
      {
         if(!_emissionData || _emissionData[emit.id] == null)
         {
            return null;
         }
         return _emissionData[emit.id][key];
      }
      
      public function hasEmissionData(emit:EmissionReference, key:String) : Boolean
      {
         return hasEmissionsParams(emit.id) && _emissionData[emit.id].hasOwnProperty(key);
      }
      
      public function resetEmissionData() : void
      {
         _emissionData = {};
      }
      
      override public function set soundId(value:String) : void
      {
         super.soundId = value;
         if(value)
         {
            playSound();
            playLoopSound();
         }
      }
      
      public function setExplosionPrecalculationsWrapper(explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper) : void
      {
         _explosionPreCalculationsWrapper = explosionPreCalculationsWrapper;
      }
      
      public function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         return _explosionPreCalculationsWrapper;
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
         var _loc1_:*;
         MessageCenter.sendEvent(new EmissionMessage(this,!!tagger ? (_loc1_ = tagger.gameObject, _loc1_._id) : null));
      }
      
      public function get className() : String
      {
         if(_simpleScript && _simpleScript.length > 0)
         {
            return _simpleScript[0];
         }
         return null;
      }
      
      public function get variables() : Array
      {
         return _simpleScript;
      }
      
      public function get locationOriginal() : Vec2
      {
         return _locationOriginal;
      }
      
      public function set locationOriginal(value:Vec2) : void
      {
         _locationOriginal = value;
      }
      
      public function set playerBoosterStats(stats:Stats) : void
      {
         _playerBoosterStats = Stats.copyStats(stats,_playerBoosterStats);
      }
      
      public function get playerBoosterStats() : Stats
      {
         return _playerBoosterStats;
      }
      
      override protected function updateGraphics() : void
      {
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
         if(body)
         {
            this._displayObject.x = bodyLocation.x;
            this._displayObject.y = bodyLocation.y;
            if(allowDisplayObjectRotation && body.allowRotation)
            {
               this._displayObject.rotation = body.rotation;
            }
            else
            {
               _loc1_ = linearVelocity;
               if(_loc1_.length >= 0.00001)
               {
                  _loc1_.normalise();
                  _loc2_ = Math.acos(_loc1_.dot(Config.VEC_UP));
                  this._displayObject.rotation = _loc1_.x < 0 ? -_loc2_ : _loc2_;
               }
            }
         }
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         super.handleCollision(otherBody,arbiterList);
         MessageCenter.sendMessage("MissileContact",this);
      }
      
      override protected function outOfWorld() : void
      {
         if(body && !isFinished() && !_location)
         {
            _location = bodyLocation.copy();
            LogUtils.log(this._id + ": Out of world!","PhysicsEmissionGameObject",1,"LevelObjects",false,false,false);
         }
      }
   }
}
