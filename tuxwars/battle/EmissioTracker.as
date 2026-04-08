package tuxwars.battle
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import org.as3commons.lang.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.responses.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.battle.world.*;
   import tuxwars.items.references.EmissionReference;
   
   public class EmissioTracker
   {
      private static const PHYSICS_LOG_INTERVAL:int = 30000;
      
      private static var _physicsElapsedTime:int = 0;
      
      public static const PARAMS:String = "Params";
      
      public static const REPEAT_COUNT:String = "RepeatCount";
      
      public static const MISSILE_NOT_FIRED:String = "MissileFired";
      
      public static const DONE:String = "Done";
      
      public static const NUMBER_OF_TIMES_TO_ACTIVATE:String = "NumberOfTimesToActivate";
      
      public static const NUMBER_OF_TIMES_ACTIVATED:String = "NumberOfTimesActivated";
      
      public static const NUMBER_OF_TIMES_RECIEVED:String = "NumberOfTimesRecieved";
      
      public static const LOGIC_DELTA_TIME:String = "LogicDeltaTime";
      
      public static const HANDLED:String = "Handled";
      
      public static const ELAPSED_TIME:String = "ElapsedTime";
      
      public static const SIMPLE_SCRIPT_COMPLETED:String = "SimpleScriptCompleted";
      
      public static const PROCESSED:String = "Processed";
      
      public static const EMISSION_REFERENCE_INDEX:String = "EmissionReferenceIndex";
      
      public static const IMPULSE_LIST:String = "ImpulseList";
      
      public static const DAMAGE_LIST:String = "DamageList";
      
      public static const TERRAIN_LIST:String = "TerrainList";
      
      private const emissions:Vector.<EmissionMessage> = new Vector.<EmissionMessage>();
      
      private const toAddEmissions:Vector.<EmissionMessage> = new Vector.<EmissionMessage>();
      
      private const waitingEmissions:Object = {};
      
      private var playerFiredThisTurn:Boolean;
      
      private var game:TuxWarsGame;
      
      public function EmissioTracker()
      {
         super();
      }
      
      public function init() : void
      {
         _physicsElapsedTime = 0;
         MessageCenter.addListener("SendGame",this.handleSendGame);
         MessageCenter.sendMessage("GetGame");
         PhysicsUpdater.register(this,"EmissioTracker");
         MessageCenter.addListener("PlayerFired",this.playerFired);
         MessageCenter.addListener("EmissionNotification",this.emissioHandler);
         MessageCenter.addListener("ActionResponse",this.actionHandler);
      }
      
      public function dispose() : void
      {
         PhysicsUpdater.unregister(this,"EmissioTracker");
         MessageCenter.removeListener("PlayerFired",this.playerFired);
         MessageCenter.removeListener("EmissionNotification",this.emissioHandler);
         MessageCenter.removeListener("ActionResponse",this.actionHandler);
         this.emissions.splice(0,this.emissions.length);
         this.toAddEmissions.splice(0,this.toAddEmissions.length);
         DCUtils.deleteProperties(this.waitingEmissions);
      }
      
      public function physicsUpdate(param1:int) : void
      {
         var _loc5_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:EmissionMessage = null;
         var _loc4_:Emission = null;
         for each(_loc5_ in this.toAddEmissions)
         {
            LogUtils.log("EmissioTracker: Adding new emission: " + Emission(_loc5_.data).shortName,this,0,"Emitter",false,false,false);
            if(Config.debugMode)
            {
               if(!this.isPlayerId(_loc5_.playerId))
               {
                  LogUtils.log("EmissionMessage with invalid player id: " + _loc5_.playerId,this,3,"Emitter",true,false);
               }
               if(this.isDuplicate(_loc5_))
               {
                  LogUtils.log("Duplicate EmissionMessage: " + Emission(_loc5_.data).shortName,this,3,"Emitter",true,false);
               }
            }
            this.emissions.unshift(_loc5_);
         }
         this.toAddEmissions.splice(0,this.toAddEmissions.length);
         _loc2_ = this.emissions.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this.emissions[_loc2_];
            _loc4_ = _loc3_.data;
            if(_loc4_.readyToEmit())
            {
               this.emit(_loc4_,param1,_loc3_.playerId);
            }
            _loc2_--;
         }
         this.removeFinishedEmissions();
         this.setEmittingDoneForFinishedEmissions();
         if(this.playerFiredThisTurn)
         {
            this.playerFiredThisTurn = false;
            MessageCenter.sendMessage("TurnCompleted");
         }
      }
      
      private function setEmittingDoneForFinishedEmissions() : void
      {
         var _loc6_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:EmissionMessage = null;
         var _loc3_:Emission = null;
         var _loc4_:* = false;
         var _loc5_:Boolean = false;
         if(Config.debugMode)
         {
            LogUtils.log("Setting emitting done for finished emissions.",this,1,"Emission",false,false,false);
         }
         _loc1_ = this.emissions.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.emissions[_loc1_];
            _loc3_ = _loc2_.data;
            _loc4_ = true;
            if(Config.debugMode)
            {
               LogUtils.log("Emission: " + _loc3_.shortName,this,1,"Emission",false,false,false);
            }
            for each(_loc6_ in _loc3_.emissions)
            {
               _loc5_ = Boolean(_loc3_.getEmissionData(_loc6_,"Done"));
               if(Config.debugMode)
               {
                  LogUtils.log("emit: " + _loc6_.id + " done: " + _loc5_,this,1,"Emission",false,false,false);
               }
               _loc4_ &&= _loc5_;
            }
            if(_loc4_ && !this.hasWaitingEmission(_loc3_.uniqueId))
            {
               LogUtils.log("PhysicsUpdate: Setting emitting done for " + _loc3_.shortName + " world step: " + this.game.tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
               _loc3_.setEmittingDone();
            }
            _loc1_--;
         }
      }
      
      private function removeFinishedEmissions() : void
      {
         var _loc1_:int = 0;
         var _loc2_:EmissionMessage = null;
         var _loc3_:Emission = null;
         _loc1_ = this.emissions.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.emissions[_loc1_];
            _loc3_ = _loc2_.data;
            if(_loc3_.isFinished())
            {
               LogUtils.log("Removing emission from EmissionTracker: " + _loc3_.shortName + " world step: " + this.game.tuxWorld.physicsWorld.stepCount,this,1,"Emitter",false,false,false);
               this.emissions.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      public function postProcessEmission(param1:Emission) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:* = undefined;
         LogUtils.log("Post processing emission: " + param1.shortName,this,1,"Emitter",false,false,false);
         var _loc3_:Boolean = true;
         for each(_loc4_ in param1.emissions)
         {
            if(param1.getEmissionData(_loc4_,"Done"))
            {
               LogUtils.log("emit: " + _loc4_.id + " is already done.",this,1,"Emitter",false,false,false);
            }
            else
            {
               LogUtils.log("Emit activated " + param1.getEmissionData(_loc4_,"NumberOfTimesRecieved") + "/" + param1.getEmissionData(_loc4_,"NumberOfTimesToActivate"),this,1,"Emitter",false,false,false);
               if(_loc4_.specialType == "MissileEmitter")
               {
                  if(Boolean(param1.getEmissionData(_loc4_,"MissileFired")) && param1.getEmissionData(_loc4_,"NumberOfTimesRecieved") >= param1.getEmissionData(_loc4_,"NumberOfTimesToActivate"))
                  {
                     LogUtils.log("Setting emit: " + _loc4_.id + " done.",this,1,"Emitter",false,false,false);
                     param1.setEmissionData(_loc4_,"Done",true);
                  }
               }
               else if(_loc4_.specialType == "ExplosionEmitter")
               {
                  if(param1.getEmissionData(_loc4_,"MissileFired"))
                  {
                     if(param1.getEmissionData(_loc4_,"NumberOfTimesRecieved") >= param1.getEmissionData(_loc4_,"NumberOfTimesToActivate"))
                     {
                        LogUtils.log("Setting emit: " + _loc4_.id + " done.",this,1,"Emitter",false,false,false);
                        param1.setEmissionData(_loc4_,"Done",true);
                     }
                     else
                     {
                        param1.setEmissionData(_loc4_,"Handled",false);
                     }
                  }
               }
               else if(Boolean(param1.getEmissionData(_loc4_,"Handled")) || _loc4_.specialType == "AnimationEmitter")
               {
                  LogUtils.log("Setting emit: " + _loc4_.id + " done.",this,1,"Emitter",false,false,false);
                  param1.setEmissionData(_loc4_,"Done",true);
               }
               _loc2_ = param1.getEmissionsParams("RepeatCount");
               if(_loc2_)
               {
                  if(Boolean(param1.getEmissionData(_loc4_,"Done")) && _loc2_ as int > 1)
                  {
                     LogUtils.log("Emission\'s repeat count > 1. emit = " + _loc4_.id,this,1,"Emitter",false,false,false);
                     param1.setEmissionsParams("RepeatCount",(_loc2_ as int) - 1);
                     param1.setEmissionData(_loc4_,"Done",false);
                     param1.setEmissionData(_loc4_,"Processed",false);
                  }
               }
               _loc3_ &&= Boolean(param1.getEmissionData(_loc4_,"Done"));
               LogUtils.log("Emissio done after emit " + _loc4_.id + ": " + _loc3_,this,1,"Emitter",false,false,false);
            }
         }
         if(_loc3_ && !this.hasWaitingEmission(param1.uniqueId))
         {
            LogUtils.log("Setting emitting done for " + param1.shortName + " world step: " + this.game.tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
            param1.setEmittingDone();
         }
      }
      
      private function emit(param1:Emission, param2:int, param3:String) : void
      {
         var _loc10_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:EmissionReference = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         LogUtils.log("Emitting: " + param1 + " by: " + param3,this,1,"Emission",false,false,false);
         var _loc9_:Array = param1.emissions;
         if((Boolean(_loc9_)) && _loc9_.length > 0)
         {
            if(!param1.emitLocation)
            {
               LogUtils.log("Emission: " + param1.shortName + " has no location.",this,2,"Emitter",true,false,true);
               param1.setEmittingDone();
               return;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc9_.length)
            {
               _loc5_ = _loc9_[_loc4_];
               if(this.allowProcessing(param1,_loc5_,param2,false))
               {
                  if(!param1.getEmissionData(_loc5_,"Done"))
                  {
                     param1.setEmissionData(_loc5_,"MissileFired",false);
                  }
                  if(!param1.hasEmissionData(_loc5_,"EmissionReferenceIndex"))
                  {
                     param1.setEmissionData(_loc5_,"EmissionReferenceIndex",_loc4_);
                  }
               }
               _loc4_++;
            }
            for each(_loc10_ in _loc9_)
            {
               if(this.allowProcessing(param1,_loc10_,param2,true))
               {
                  if(!param1.getEmissionData(_loc10_,"Done"))
                  {
                     param1.setEmissionData(_loc10_,"LogicDeltaTime",param2);
                     param1.setEmissionData(_loc10_,"NumberOfTimesToActivate",_loc10_.number);
                     _loc6_ = int(param1.getEmissionData(_loc10_,"NumberOfTimesActivated"));
                     _loc7_ = _loc10_.delay <= 0 ? int(_loc10_.number) : 1;
                     _loc8_ = 0;
                     while(_loc8_ < _loc7_)
                     {
                        this.addWaitingEmission(new FireEmissionMessage(_loc10_,param1,param3,_loc8_,_loc7_));
                        param1.setEmissionData(_loc10_,"NumberOfTimesActivated",_loc6_ + _loc8_ + 1);
                        if(param1 is EmissionSpawn)
                        {
                           EmissionSpawn(param1).updateEmitLocation();
                        }
                        _loc8_++;
                     }
                     param1.setEmissionData(_loc10_,"Processed",true);
                  }
               }
            }
         }
         else
         {
            LogUtils.log(param1.shortName + " has no emissions to emit, it is " + (!!_loc9_ ? " empty" : _loc9_),this,0,"Emission",false,false,false);
            param1.setEmittingDone();
         }
      }
      
      private function allowProcessing(param1:Emission, param2:EmissionReference, param3:int, param4:Boolean) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1.hasEmissionData(param2,"ElapsedTime"))
         {
            _loc7_ = int(param1.getEmissionData(param2,"ElapsedTime"));
         }
         if(_loc7_ + param3 < param2.delay)
         {
            if(param4)
            {
               param1.setEmissionData(param2,"ElapsedTime",_loc7_ + param3);
            }
            LogUtils.log("Emissio not allowed to process:" + this.getEmissionId(param1,param2) + ", elapsedTime + deltaTime < emitPreLoop.delay",this,1,"Emitter",false,false,false);
            return false;
         }
         if(param4)
         {
            param1.setEmissionData(param2,"ElapsedTime",0);
         }
         if(Boolean(param1.hasEmissionData(param2,"Processed")) && Boolean(param1.getEmissionData(param2,"Processed")))
         {
            _loc5_ = int(param1.getEmissionData(param2,"NumberOfTimesActivated"));
            _loc6_ = int(param1.getEmissionData(param2,"NumberOfTimesToActivate"));
            if(_loc5_ >= _loc6_)
            {
               LogUtils.log("Emissio not allowed to process: " + this.getEmissionId(param1,param2) + ", activations left. " + _loc5_ + "/" + _loc6_,this,1,"Emitter",false,false,false);
               return false;
            }
         }
         return true;
      }
      
      private function addWaitingEmission(param1:FireEmissionMessage) : void
      {
         var _loc2_:ExplosionPreCalculationsWrapper = null;
         var _loc3_:Object = null;
         var _loc4_:Emission = param1.emissionObject;
         var _loc5_:String = this.getEmissionId(_loc4_,param1.emissionReference);
         LogUtils.log("EmissioTracker: addWaitingEmission: " + _loc5_ + " world step: " + this.game.tuxWorld.physicsWorld.stepCount,this,0,"Emitter",false,false,false);
         if(this.waitingEmissions.hasOwnProperty(_loc5_))
         {
            LogUtils.log("Duplicate emission: " + _loc5_,this,2,"Emitter",true,false,false);
            return;
         }
         this.waitingEmissions[_loc5_] = param1;
         if(Boolean(BattleManager.isLocalPlayersTurn()) || Boolean(BattleManager.isPracticeMode()))
         {
            _loc2_ = ExplosionPreCalculationsWrapper.get(_loc4_);
            _loc3_ = _loc4_.getEmissionsParams("Params");
            MessageCenter.sendEvent(new EmitMessage(param1.playerId,_loc5_,_loc4_.emitLocation,!!_loc3_ ? _loc3_.dir : null,Boolean(_loc3_) && Boolean(_loc3_.hasOwnProperty("powerBar")) ? int(_loc3_.powerBar) : -1,!!_loc4_.playerAttackValueStat ? int(_loc4_.playerAttackValueStat.calculateRoundedValue()) : 0,this.locatioWrappersToIdList(_loc2_.getImpulseAffectedObjects(param1.emissionReference.id)),this.locatioWrappersToIdList(_loc2_.getDamageAffectedObjects(param1.emissionReference.id)),this.locatioWrappersToIdList(_loc2_.getTerrainAffectedObjects(param1.emissionReference.id))));
         }
      }
      
      private function locatioWrappersToIdList(param1:Vector.<LocationWrapper>) : Array
      {
         var wrapper:LocationWrapper = null;
         var _loc3_:* = undefined;
         var wrappers:Vector.<LocationWrapper> = param1;
         var ids:Array = [];
         for each(wrapper in wrappers)
         {
            if(!(wrapper.physicsGameObject._hasHPs && wrapper.physicsGameObject.isDeadHP() || wrapper.physicsGameObject is PlayerGameObject && (Boolean((wrapper.physicsGameObject as PlayerGameObject).isDead()) || Boolean((wrapper.physicsGameObject as PlayerGameObject).isSpawning()))))
            {
               _loc3_ = wrapper.physicsGameObject;
               ids.push(_loc3_._uniqueId);
            }
         }
         ids.sort(function(param1:String, param2:String):int
         {
            return StringUtils.compareTo(param1,param2);
         });
         return ids;
      }
      
      private function getEmissionId(param1:Emission, param2:EmissionReference) : String
      {
         var _loc3_:int = 0;
         if(param1.hasEmissionData(param2,"EmissionReferenceIndex"))
         {
            _loc3_ = int(param1.getEmissionData(param2,"EmissionReferenceIndex"));
         }
         else
         {
            LogUtils.log("No index for emissio: " + param1.shortName + " and emissioReference: " + param2.id,"EmissioTracker",2,"Emitter",false,false,true);
         }
         var _loc4_:int = int(param1.getEmissionData(param2,"NumberOfTimesActivated"));
         return param2.id + "_" + param1.uniqueId + "_" + _loc3_ + "_" + _loc4_;
      }
      
      private function actionHandler(param1:ActionResponse) : void
      {
         var _loc2_:EmitResponse = null;
         var _loc3_:FireEmissionMessage = null;
         if(param1.responseType == 9)
         {
            _loc2_ = EmitResponse(param1);
            _loc3_ = this.getEmissionMessage(_loc2_);
            if(_loc3_)
            {
               LogUtils.log("Handling FireEmissionMessage: " + _loc2_.emitterId + " world step: " + this.game.tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
               MessageCenter.sendEvent(_loc3_);
            }
            else
            {
               LogUtils.log("Couldn\'t find emission: " + param1.id + " " + _loc2_.emitterId + " world step: " + this.game.tuxWorld.physicsWorld.stepCount,this,3,"Emission",true,false,true);
            }
         }
      }
      
      private function getEmissionMessage(param1:EmitResponse) : FireEmissionMessage
      {
         var _loc2_:Emission = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:SimpleScript = null;
         var _loc6_:FireEmissionMessage = !!this.hasWaitingEmission(param1.emitterId) ? this.getWaitingEmission(param1.emitterId) : this.createEmissionMessage(param1);
         if(_loc6_)
         {
            _loc2_ = _loc6_.emissionObject;
            if(_loc2_.isEmittingDone())
            {
               LogUtils.log("Emitting already done for emission: " + _loc2_.uniqueId,this,3,"Emission",true,false);
               return null;
            }
            _loc2_.location = param1.location;
            _loc2_.playerAttackValue = param1.playerAttack;
            _loc3_ = !!_loc2_.getEmissionsParams("Params") ? _loc2_.getEmissionsParams("Params") : {};
            _loc3_["dir"] = param1.direction;
            _loc3_["powerBar"] = param1.powerBar;
            _loc2_.setEmissionsParams("Params",_loc3_);
            _loc2_.setEmissionData(_loc6_.emissionReference,"ImpulseList",param1.impulseList);
            _loc2_.setEmissionData(_loc6_.emissionReference,"DamageList",param1.damageList);
            _loc2_.setEmissionData(_loc6_.emissionReference,"TerrainList",param1.terrainList);
            _loc2_.setEmissionData(_loc6_.emissionReference,"MissileFired",true);
            _loc4_ = int(_loc2_.getEmissionData(_loc6_.emissionReference,"NumberOfTimesRecieved"));
            _loc2_.setEmissionData(_loc6_.emissionReference,"NumberOfTimesRecieved",_loc4_ + 1);
            if(_loc2_ is SimpleScript && !_loc2_.getEmissionsParams("SimpleScriptCompleted"))
            {
               _loc5_ = _loc2_ as SimpleScript;
               if(_loc5_.className)
               {
                  if(!SimpleScriptManager.instance)
                  {
                     new SimpleScriptManager();
                  }
                  SimpleScriptManager.instance.run(false,_loc5_,new SimpleScriptParams());
               }
               _loc2_.setEmissionsParams("SimpleScriptCompleted",true);
            }
         }
         return _loc6_;
      }
      
      private function createEmissionMessage(param1:EmitResponse) : FireEmissionMessage
      {
         var _loc9_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = param1.emitterId.split("_");
         var _loc5_:String = _loc4_[0];
         var _loc6_:int = int(parseInt(_loc4_[2]));
         var _loc7_:int = int(parseInt(_loc4_[3]));
         var _loc8_:Vector.<FireEmissionMessage> = this.findWaitingEmissionsWithEmitReferenceId(_loc5_);
         if(_loc8_.length > 0)
         {
            for each(_loc9_ in _loc8_)
            {
               _loc2_ = int(!!_loc9_.emissionObject.hasEmissionData(_loc9_.emissionReference,"EmissionReferenceIndex") ? _loc9_.emissionObject.getEmissionData(_loc9_.emissionReference,"EmissionReferenceIndex") : 0);
               if(_loc6_ == _loc2_)
               {
                  _loc3_ = int(_loc9_.emissionObject.getEmissionData(_loc9_.emissionReference,"NumberOfTimesActivated"));
                  if(_loc7_ == _loc3_)
                  {
                     return _loc9_;
                  }
               }
            }
            return _loc8_[0];
         }
         return null;
      }
      
      private function findWaitingEmissionsWithEmitReferenceId(param1:String) : Vector.<FireEmissionMessage>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<FireEmissionMessage> = new Vector.<FireEmissionMessage>();
         for each(_loc3_ in this.waitingEmissions)
         {
            if(_loc3_.emissionReference.id == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function sameId(param1:String, param2:String) : Boolean
      {
         if(param1 == null && param2 == null)
         {
            return true;
         }
         return param1 == param2;
      }
      
      private function getWaitingEmission(param1:String) : FireEmissionMessage
      {
         var _loc2_:FireEmissionMessage = this.waitingEmissions[param1];
         this.waitingEmissions[param1] = null;
         delete this.waitingEmissions[param1];
         return _loc2_;
      }
      
      private function hasWaitingEmission(param1:String) : Boolean
      {
         return this.waitingEmissions.hasOwnProperty(param1);
      }
      
      private function playerFired(param1:Message) : void
      {
         this.playerFiredThisTurn = true;
      }
      
      private function emissioHandler(param1:EmissionMessage) : void
      {
         LogUtils.log("EmissioTracker, received emission msg: " + (param1.data as Emission).shortName,this,0,"Emitter",false,false,false);
         this.toAddEmissions.push(param1);
      }
      
      private function isPlayerId(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(param1 == null)
         {
            return true;
         }
         for each(_loc2_ in BattleManager.getTuxGame().tuxWorld.players)
         {
            _loc3_ = _loc2_;
            if(param1 == _loc3_._id)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isDuplicate(param1:EmissionMessage) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.emissions)
         {
            if(Emission(_loc2_.data).uniqueId == Emission(param1.data).uniqueId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function handleSendGame(param1:Message) : void
      {
         this.game = param1.data;
         MessageCenter.removeListener("SendGame",this.handleSendGame);
      }
   }
}

