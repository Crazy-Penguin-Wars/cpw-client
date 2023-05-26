package tuxwars.battle
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import org.as3commons.lang.StringUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.emitters.ExplosionPreCalculationsWrapper;
   import tuxwars.battle.emitters.LocationWrapper;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.events.FireEmissionMessage;
   import tuxwars.battle.gameobjects.EmissionSpawn;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.EmitMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.EmitResponse;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.battle.world.PhysicsUpdater;
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
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
         PhysicsUpdater.register(this,"EmissioTracker");
         MessageCenter.addListener("PlayerFired",playerFired);
         MessageCenter.addListener("EmissionNotification",emissioHandler);
         MessageCenter.addListener("ActionResponse",actionHandler);
      }
      
      public function dispose() : void
      {
         PhysicsUpdater.unregister(this,"EmissioTracker");
         MessageCenter.removeListener("PlayerFired",playerFired);
         MessageCenter.removeListener("EmissionNotification",emissioHandler);
         MessageCenter.removeListener("ActionResponse",actionHandler);
         emissions.splice(0,emissions.length);
         toAddEmissions.splice(0,toAddEmissions.length);
         DCUtils.deleteProperties(waitingEmissions);
      }
      
      public function physicsUpdate(deltaTime:int) : void
      {
         var i:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         for each(var toAdd in toAddEmissions)
         {
            LogUtils.log("EmissioTracker: Adding new emission: " + Emission(toAdd.data).shortName,this,0,"Emitter",false,false,false);
            if(Config.debugMode)
            {
               if(!isPlayerId(toAdd.playerId))
               {
                  LogUtils.log("EmissionMessage with invalid player id: " + toAdd.playerId,this,3,"Emitter",true,false);
               }
               if(isDuplicate(toAdd))
               {
                  LogUtils.log("Duplicate EmissionMessage: " + Emission(toAdd.data).shortName,this,3,"Emitter",true,false);
               }
            }
            emissions.unshift(toAdd);
         }
         toAddEmissions.splice(0,toAddEmissions.length);
         for(i = emissions.length - 1; i >= 0; )
         {
            _loc4_ = emissions[i];
            _loc2_ = _loc4_.data;
            if(_loc2_.readyToEmit())
            {
               emit(_loc2_,deltaTime,_loc4_.playerId);
            }
            i--;
         }
         removeFinishedEmissions();
         setEmittingDoneForFinishedEmissions();
         if(playerFiredThisTurn)
         {
            playerFiredThisTurn = false;
            MessageCenter.sendMessage("TurnCompleted");
         }
      }
      
      private function setEmittingDoneForFinishedEmissions() : void
      {
         var i:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var done:* = false;
         var _loc3_:Boolean = false;
         if(Config.debugMode)
         {
            LogUtils.log("Setting emitting done for finished emissions.",this,1,"Emission",false,false,false);
         }
         for(i = emissions.length - 1; i >= 0; )
         {
            _loc5_ = emissions[i];
            _loc2_ = _loc5_.data;
            done = true;
            if(Config.debugMode)
            {
               LogUtils.log("Emission: " + _loc2_.shortName,this,1,"Emission",false,false,false);
            }
            for each(var emit in _loc2_.emissions)
            {
               _loc3_ = _loc2_.getEmissionData(emit,"Done");
               if(Config.debugMode)
               {
                  LogUtils.log("emit: " + emit.id + " done: " + _loc3_,this,1,"Emission",false,false,false);
               }
               done = done && _loc3_;
            }
            if(done && !hasWaitingEmission(_loc2_.uniqueId))
            {
               LogUtils.log("PhysicsUpdate: Setting emitting done for " + _loc2_.shortName + " world step: " + game.tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
               _loc2_.setEmittingDone();
            }
            i--;
         }
      }
      
      private function removeFinishedEmissions() : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         for(i = emissions.length - 1; i >= 0; )
         {
            _loc2_ = emissions[i];
            _loc1_ = _loc2_.data;
            if(_loc1_.isFinished())
            {
               LogUtils.log("Removing emission from EmissionTracker: " + _loc1_.shortName + " world step: " + game.tuxWorld.physicsWorld.stepCount,this,1,"Emitter",false,false,false);
               emissions.splice(i,1);
            }
            i--;
         }
      }
      
      public function postProcessEmission(emissio:Emission) : void
      {
         var _loc4_:* = undefined;
         LogUtils.log("Post processing emission: " + emissio.shortName,this,1,"Emitter",false,false,false);
         var emissioDone:Boolean = true;
         for each(var emit in emissio.emissions)
         {
            if(emissio.getEmissionData(emit,"Done"))
            {
               LogUtils.log("emit: " + emit.id + " is already done.",this,1,"Emitter",false,false,false);
            }
            else
            {
               LogUtils.log("Emit activated " + emissio.getEmissionData(emit,"NumberOfTimesRecieved") + "/" + emissio.getEmissionData(emit,"NumberOfTimesToActivate"),this,1,"Emitter",false,false,false);
               if(emit.specialType == "MissileEmitter")
               {
                  if(emissio.getEmissionData(emit,"MissileFired") && emissio.getEmissionData(emit,"NumberOfTimesRecieved") >= emissio.getEmissionData(emit,"NumberOfTimesToActivate"))
                  {
                     LogUtils.log("Setting emit: " + emit.id + " done.",this,1,"Emitter",false,false,false);
                     emissio.setEmissionData(emit,"Done",true);
                  }
               }
               else if(emit.specialType == "ExplosionEmitter")
               {
                  if(emissio.getEmissionData(emit,"MissileFired"))
                  {
                     if(emissio.getEmissionData(emit,"NumberOfTimesRecieved") >= emissio.getEmissionData(emit,"NumberOfTimesToActivate"))
                     {
                        LogUtils.log("Setting emit: " + emit.id + " done.",this,1,"Emitter",false,false,false);
                        emissio.setEmissionData(emit,"Done",true);
                     }
                     else
                     {
                        emissio.setEmissionData(emit,"Handled",false);
                     }
                  }
               }
               else if(emissio.getEmissionData(emit,"Handled") || emit.specialType == "AnimationEmitter")
               {
                  LogUtils.log("Setting emit: " + emit.id + " done.",this,1,"Emitter",false,false,false);
                  emissio.setEmissionData(emit,"Done",true);
               }
               _loc4_ = emissio.getEmissionsParams("RepeatCount");
               if(_loc4_)
               {
                  if(emissio.getEmissionData(emit,"Done") && _loc4_ as int > 1)
                  {
                     LogUtils.log("Emission\'s repeat count > 1. emit = " + emit.id,this,1,"Emitter",false,false,false);
                     emissio.setEmissionsParams("RepeatCount",(_loc4_ as int) - 1);
                     emissio.setEmissionData(emit,"Done",false);
                     emissio.setEmissionData(emit,"Processed",false);
                  }
               }
               emissioDone = emissioDone && emissio.getEmissionData(emit,"Done");
               LogUtils.log("Emissio done after emit " + emit.id + ": " + emissioDone,this,1,"Emitter",false,false,false);
            }
         }
         if(emissioDone && !hasWaitingEmission(emissio.uniqueId))
         {
            LogUtils.log("Setting emitting done for " + emissio.shortName + " world step: " + game.tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
            emissio.setEmittingDone();
         }
      }
      
      private function emit(emissio:Emission, deltaTime:int, playerId:String) : void
      {
         var i:int = 0;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var count:int = 0;
         var k:int = 0;
         LogUtils.log("Emitting: " + emissio + " by: " + playerId,this,1,"Emission",false,false,false);
         var _loc5_:Array = emissio.emissions;
         if(_loc5_ && _loc5_.length > 0)
         {
            if(!emissio.emitLocation)
            {
               LogUtils.log("Emission: " + emissio.shortName + " has no location.",this,2,"Emitter",true,false,true);
               emissio.setEmittingDone();
               return;
            }
            i = 0;
            while(i < _loc5_.length)
            {
               _loc8_ = _loc5_[i];
               if(allowProcessing(emissio,_loc8_,deltaTime,false))
               {
                  if(!emissio.getEmissionData(_loc8_,"Done"))
                  {
                     emissio.setEmissionData(_loc8_,"MissileFired",false);
                  }
                  if(!emissio.hasEmissionData(_loc8_,"EmissionReferenceIndex"))
                  {
                     emissio.setEmissionData(_loc8_,"EmissionReferenceIndex",i);
                  }
               }
               i++;
            }
            for each(var emit in _loc5_)
            {
               if(allowProcessing(emissio,emit,deltaTime,true))
               {
                  if(!emissio.getEmissionData(emit,"Done"))
                  {
                     emissio.setEmissionData(emit,"LogicDeltaTime",deltaTime);
                     emissio.setEmissionData(emit,"NumberOfTimesToActivate",emit.number);
                     _loc7_ = emissio.getEmissionData(emit,"NumberOfTimesActivated");
                     count = emit.delay <= 0 ? emit.number : 1;
                     for(k = 0; k < count; )
                     {
                        addWaitingEmission(new FireEmissionMessage(emit,emissio,playerId,k,count));
                        emissio.setEmissionData(emit,"NumberOfTimesActivated",_loc7_ + k + 1);
                        if(emissio is EmissionSpawn)
                        {
                           EmissionSpawn(emissio).updateEmitLocation();
                        }
                        k++;
                     }
                     emissio.setEmissionData(emit,"Processed",true);
                  }
               }
            }
         }
         else
         {
            LogUtils.log(emissio.shortName + " has no emissions to emit, it is " + (!!_loc5_ ? " empty" : _loc5_),this,0,"Emission",false,false,false);
            emissio.setEmittingDone();
         }
      }
      
      private function allowProcessing(emissio:Emission, emitPreLoop:EmissionReference, deltaTime:int, updateDeltaTime:Boolean) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var elapsedTime:int = 0;
         if(emissio.hasEmissionData(emitPreLoop,"ElapsedTime"))
         {
            elapsedTime = emissio.getEmissionData(emitPreLoop,"ElapsedTime");
         }
         if(elapsedTime + deltaTime < emitPreLoop.delay)
         {
            if(updateDeltaTime)
            {
               emissio.setEmissionData(emitPreLoop,"ElapsedTime",elapsedTime + deltaTime);
            }
            LogUtils.log("Emissio not allowed to process:" + getEmissionId(emissio,emitPreLoop) + ", elapsedTime + deltaTime < emitPreLoop.delay",this,1,"Emitter",false,false,false);
            return false;
         }
         if(updateDeltaTime)
         {
            emissio.setEmissionData(emitPreLoop,"ElapsedTime",0);
         }
         if(emissio.hasEmissionData(emitPreLoop,"Processed") && emissio.getEmissionData(emitPreLoop,"Processed"))
         {
            _loc6_ = emissio.getEmissionData(emitPreLoop,"NumberOfTimesActivated");
            _loc5_ = emissio.getEmissionData(emitPreLoop,"NumberOfTimesToActivate");
            if(_loc6_ >= _loc5_)
            {
               LogUtils.log("Emissio not allowed to process: " + getEmissionId(emissio,emitPreLoop) + ", activations left. " + _loc6_ + "/" + _loc5_,this,1,"Emitter",false,false,false);
               return false;
            }
         }
         return true;
      }
      
      private function addWaitingEmission(msg:FireEmissionMessage) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Emission = msg.emissionObject;
         var _loc5_:String = getEmissionId(_loc2_,msg.emissionReference);
         LogUtils.log("EmissioTracker: addWaitingEmission: " + _loc5_ + " world step: " + game.tuxWorld.physicsWorld.stepCount,this,0,"Emitter",false,false,false);
         if(waitingEmissions.hasOwnProperty(_loc5_))
         {
            LogUtils.log("Duplicate emission: " + _loc5_,this,2,"Emitter",true,false,false);
            return;
         }
         waitingEmissions[_loc5_] = msg;
         if(BattleManager.isLocalPlayersTurn() || BattleManager.isPracticeMode())
         {
            _loc3_ = ExplosionPreCalculationsWrapper.get(_loc2_);
            _loc4_ = _loc2_.getEmissionsParams("Params");
            MessageCenter.sendEvent(new EmitMessage(msg.playerId,_loc5_,_loc2_.emitLocation,!!_loc4_ ? _loc4_.dir : null,_loc4_ && _loc4_.hasOwnProperty("powerBar") ? _loc4_.powerBar : -1,!!_loc2_.playerAttackValueStat ? _loc2_.playerAttackValueStat.calculateRoundedValue() : 0,locatioWrappersToIdList(_loc3_.getImpulseAffectedObjects(msg.emissionReference.id)),locatioWrappersToIdList(_loc3_.getDamageAffectedObjects(msg.emissionReference.id)),locatioWrappersToIdList(_loc3_.getTerrainAffectedObjects(msg.emissionReference.id))));
         }
      }
      
      private function locatioWrappersToIdList(wrappers:Vector.<LocationWrapper>) : Array
      {
         var wrapper:LocationWrapper;
         var ids:Array = [];
         for each(wrapper in wrappers)
         {
            if(!(wrapper.physicsGameObject._hasHPs && wrapper.physicsGameObject.isDeadHP() || wrapper.physicsGameObject is PlayerGameObject && ((wrapper.physicsGameObject as PlayerGameObject).isDead() || (wrapper.physicsGameObject as PlayerGameObject).isSpawning())))
            {
               var _loc3_:* = wrapper.physicsGameObject;
               ids.push(_loc3_._uniqueId);
            }
         }
         ids.sort(function(id1:String, id2:String):int
         {
            return StringUtils.compareTo(id1,id2);
         });
         return ids;
      }
      
      private function getEmissionId(emissio:Emission, emitPreLoop:EmissionReference) : String
      {
         var index:int = 0;
         if(emissio.hasEmissionData(emitPreLoop,"EmissionReferenceIndex"))
         {
            index = emissio.getEmissionData(emitPreLoop,"EmissionReferenceIndex");
         }
         else
         {
            LogUtils.log("No index for emissio: " + emissio.shortName + " and emissioReference: " + emitPreLoop.id,"EmissioTracker",2,"Emitter",false,false,true);
         }
         var _loc4_:int = emissio.getEmissionData(emitPreLoop,"NumberOfTimesActivated");
         return emitPreLoop.id + "_" + emissio.uniqueId + "_" + index + "_" + _loc4_;
      }
      
      private function actionHandler(action:ActionResponse) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(action.responseType == 9)
         {
            _loc2_ = EmitResponse(action);
            _loc3_ = getEmissionMessage(_loc2_);
            if(_loc3_)
            {
               LogUtils.log("Handling FireEmissionMessage: " + _loc2_.emitterId + " world step: " + game.tuxWorld.physicsWorld.stepCount,this,1,"Emission",false,false,false);
               MessageCenter.sendEvent(_loc3_);
            }
            else
            {
               LogUtils.log("Couldn\'t find emission: " + action.id + " " + _loc2_.emitterId + " world step: " + game.tuxWorld.physicsWorld.stepCount,this,3,"Emission",true,false,true);
            }
         }
      }
      
      private function getEmissionMessage(response:EmitResponse) : FireEmissionMessage
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:FireEmissionMessage = hasWaitingEmission(response.emitterId) ? getWaitingEmission(response.emitterId) : createEmissionMessage(response);
         if(_loc6_)
         {
            _loc2_ = _loc6_.emissionObject;
            if(_loc2_.isEmittingDone())
            {
               LogUtils.log("Emitting already done for emission: " + _loc2_.uniqueId,this,3,"Emission",true,false);
               return null;
            }
            _loc2_.location = response.location;
            _loc2_.playerAttackValue = response.playerAttack;
            _loc3_ = !!_loc2_.getEmissionsParams("Params") ? _loc2_.getEmissionsParams("Params") : {};
            _loc3_["dir"] = response.direction;
            _loc3_["powerBar"] = response.powerBar;
            _loc2_.setEmissionsParams("Params",_loc3_);
            _loc2_.setEmissionData(_loc6_.emissionReference,"ImpulseList",response.impulseList);
            _loc2_.setEmissionData(_loc6_.emissionReference,"DamageList",response.damageList);
            _loc2_.setEmissionData(_loc6_.emissionReference,"TerrainList",response.terrainList);
            _loc2_.setEmissionData(_loc6_.emissionReference,"MissileFired",true);
            _loc5_ = _loc2_.getEmissionData(_loc6_.emissionReference,"NumberOfTimesRecieved");
            _loc2_.setEmissionData(_loc6_.emissionReference,"NumberOfTimesRecieved",_loc5_ + 1);
            if(_loc2_ is SimpleScript && !_loc2_.getEmissionsParams("SimpleScriptCompleted"))
            {
               _loc4_ = _loc2_ as SimpleScript;
               if(_loc4_.className)
               {
                  var _loc7_:SimpleScriptManager = SimpleScriptManager;
                  if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
                  {
                     new tuxwars.battle.simplescript.SimpleScriptManager();
                  }
                  tuxwars.battle.simplescript.SimpleScriptManager._instance.run(false,_loc4_,new SimpleScriptParams());
               }
               _loc2_.setEmissionsParams("SimpleScriptCompleted",true);
            }
         }
         return _loc6_;
      }
      
      private function createEmissionMessage(response:EmitResponse) : FireEmissionMessage
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Array = response.emitterId.split("_");
         var _loc8_:String = _loc4_[0];
         var _loc2_:int = parseInt(_loc4_[2]);
         var _loc3_:int = parseInt(_loc4_[3]);
         var _loc7_:Vector.<FireEmissionMessage> = findWaitingEmissionsWithEmitReferenceId(_loc8_);
         if(_loc7_.length > 0)
         {
            for each(var msg in _loc7_)
            {
               _loc6_ = int(msg.emissionObject.hasEmissionData(msg.emissionReference,"EmissionReferenceIndex") ? msg.emissionObject.getEmissionData(msg.emissionReference,"EmissionReferenceIndex") : 0);
               if(_loc2_ == _loc6_)
               {
                  _loc5_ = msg.emissionObject.getEmissionData(msg.emissionReference,"NumberOfTimesActivated");
                  if(_loc3_ == _loc5_)
                  {
                     return msg;
                  }
               }
            }
            return _loc7_[0];
         }
         return null;
      }
      
      private function findWaitingEmissionsWithEmitReferenceId(id:String) : Vector.<FireEmissionMessage>
      {
         var _loc2_:Vector.<FireEmissionMessage> = new Vector.<FireEmissionMessage>();
         for each(var msg in waitingEmissions)
         {
            if(msg.emissionReference.id == id)
            {
               _loc2_.push(msg);
            }
         }
         return _loc2_;
      }
      
      private function sameId(id1:String, id2:String) : Boolean
      {
         if(id1 == null && id2 == null)
         {
            return true;
         }
         return id1 == id2;
      }
      
      private function getWaitingEmission(uid:String) : FireEmissionMessage
      {
         var _loc2_:FireEmissionMessage = waitingEmissions[uid];
         waitingEmissions[uid] = null;
         delete waitingEmissions[uid];
         return _loc2_;
      }
      
      private function hasWaitingEmission(uid:String) : Boolean
      {
         return waitingEmissions.hasOwnProperty(uid);
      }
      
      private function playerFired(msg:Message) : void
      {
         playerFiredThisTurn = true;
      }
      
      private function emissioHandler(msg:EmissionMessage) : void
      {
         LogUtils.log("EmissioTracker, received emission msg: " + (msg.data as Emission).shortName,this,0,"Emitter",false,false,false);
         toAddEmissions.push(msg);
      }
      
      private function isPlayerId(id:String) : Boolean
      {
         if(id == null)
         {
            return true;
         }
         for each(var player in BattleManager.getTuxGame().tuxWorld.players)
         {
            var _loc3_:* = player;
            if(id == _loc3_._id)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isDuplicate(msg:EmissionMessage) : Boolean
      {
         for each(var emissionMsg in emissions)
         {
            if(Emission(emissionMsg.data).uniqueId == Emission(msg.data).uniqueId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function handleSendGame(msg:Message) : void
      {
         game = msg.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
   }
}
