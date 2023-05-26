package tuxwars.challenges
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.battle.net.messages.history.HistoryMessageFactory;
   import tuxwars.battle.ui.states.results.ResultsUISubState;
   import tuxwars.challenges.counters.Counter;
   import tuxwars.challenges.counters.CounterFactory;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   import tuxwars.challenges.events.ChallengeGainedCoinsMessage;
   import tuxwars.challenges.events.ChallengeItemBoughtMessage;
   import tuxwars.challenges.events.ChallengeItemCraftedMessage;
   import tuxwars.challenges.events.ChallengeItemGainedMessage;
   import tuxwars.challenges.events.ChallengeLevelObjectDestroyed;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   import tuxwars.challenges.events.ChallengePlayerScoreChangedMessage;
   import tuxwars.challenges.events.ChallengeReachLevelMessage;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   import tuxwars.data.challenges.ChallengeData;
   
   public class Challenge
   {
      
      public static const SCOPE_TURN:String = "Turn";
      
      public static const SCOPE_MATCH:String = "Match";
      
      public static const SCOPE_GLOBAL:String = "Global";
      
      public static const TYPE_BATTLE:String = "Battle";
      
      public static const TYPE_GRIND:String = "Grind";
      
      public static const TYPE_SKILL:String = "Skill";
      
      public static const TYPE_IMPOSSIBLE:String = "Impossible";
      
      private static var tuxGame:TuxWarsGame;
       
      
      private const _counters:Vector.<Counter> = new Vector.<Counter>();
      
      private var _data:ChallengeData;
      
      private var _completed:Boolean;
      
      private var _collected:Boolean;
      
      private var _playerId:String;
      
      private var _id:String;
      
      private var _description:String;
      
      private var _nextChallengeIds:Array;
      
      private var _type:String;
      
      private var _rewardCash:int;
      
      private var _rewardCoins:int;
      
      private var _rewardExp:int;
      
      private var _scope:String;
      
      private var graphics:GraphicsReference;
      
      private var _alreadyCompletedWhenActivated:Boolean;
      
      public function Challenge(data:ChallengeData, playerId:String)
      {
         super();
         _data = data;
         _playerId = playerId;
         graphics = data.icon;
         _scope = data.scope;
         _rewardCash = data.rewardCash;
         _rewardCoins = data.rewardCoins;
         _rewardExp = data.rewardExp;
         _type = data.type;
         _nextChallengeIds = data.nextChallengeIds;
         _description = data.description;
         _id = data.id;
         _alreadyCompletedWhenActivated = false;
         init();
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
         LogUtils.log("Created challenge: " + id + " for player: " + playerId,this,1,"Challenges",false,false,true);
      }
      
      private static function handleSendGame(msg:Message) : void
      {
         tuxGame = msg.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public function toString() : String
      {
         return "Challenge ID: " + id + " counters: " + _counters.toString();
      }
      
      public function update(challengeData:Object) : void
      {
         updateCounters(challengeData);
      }
      
      public function activate(data:Object = null) : void
      {
         if(data)
         {
            updateCounters(data);
         }
         addListeners();
         if(areCountersCompleted())
         {
            _alreadyCompletedWhenActivated = true;
            complete();
         }
      }
      
      public function dispose() : void
      {
         LogUtils.log("Disposing challenge: " + name + " player: " + _playerId,this,1,"Challenges",false);
         removeListeners();
         _data = null;
         _counters.splice(0,_counters.length);
      }
      
      public function get counters() : Vector.<Counter>
      {
         return _counters;
      }
      
      public function pause() : void
      {
         removeListeners();
      }
      
      public function resume() : void
      {
         addListeners();
      }
      
      public function get collected() : Boolean
      {
         return _collected;
      }
      
      public function set collected(value:Boolean) : void
      {
         _collected = value;
      }
      
      public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function set completed(value:Boolean) : void
      {
         _completed = value;
      }
      
      public function calculateCompletionPercentage() : int
      {
         var sum:int = 0;
         for each(var counter in _counters)
         {
            sum += counter.calculateCompletionPercentage();
         }
         return sum / _counters.length;
      }
      
      public function complete() : void
      {
         completed = true;
         removeListeners();
         MessageCenter.sendMessage("ChallengeCompleted",this);
         if(tuxGame.isInBattle())
         {
            if(isScopeBattle)
            {
               HistoryMessageFactory.sendCompletedChallengeMessage(_playerId,id);
            }
            else if(_alreadyCompletedWhenActivated && tuxGame.currentState is ResultsUISubState)
            {
               MessageCenter.sendMessage("ChallengeCompleteUpdateNotInBattle",_data);
            }
            else
            {
               LogUtils.log("Player (" + _playerId + ") challenge inconsistent: " + id + " tried to complete GLOBAL challenge inside of battle",this,3,"Challenges",false);
            }
         }
         else if(!isScopeBattle)
         {
            MessageCenter.sendMessage("ChallengeCompleteUpdateNotInBattle",_data);
         }
         else
         {
            LogUtils.log("Player (" + _playerId + ") challenge inconsistent: " + id + " tried to complete non GLOBAL challenge outside of battle",this,3,"Challenges",false);
         }
         LogUtils.log("Player (" + _playerId + ") challenge completed: " + id,this,1,"Challenges",false);
      }
      
      public function turnStarted() : void
      {
         if(scope == "Turn")
         {
            reset();
         }
      }
      
      public function turnEnded(msg:PlayerTurnEndedMessage) : void
      {
         handleTurnEnded(msg);
         if(!completed && areCountersCompleted() && scope == "Turn")
         {
            complete();
         }
      }
      
      public function matchStarted() : void
      {
         if(scope == "Match")
         {
            reset();
         }
      }
      
      public function matchEnded(msg:MatchEndedMessage) : void
      {
         handleMatchEnded(msg);
         if(!completed && areCountersCompleted() && scope == "Match")
         {
            complete();
         }
      }
      
      public function outOfBattleCheck() : void
      {
         if(!completed && areCountersCompleted())
         {
            complete();
         }
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get name() : String
      {
         return ProjectManager.getText(_data.getTID());
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get nextChallengeIds() : Array
      {
         return _nextChallengeIds;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get rewardCash() : int
      {
         return _rewardCash;
      }
      
      public function get rewardCoins() : int
      {
         return _rewardCoins;
      }
      
      public function get rewardExp() : int
      {
         return _rewardExp;
      }
      
      public function get icon() : MovieClip
      {
         if(graphics)
         {
            return DCResourceManager.instance.getFromSWF(graphics.swf,graphics.export);
         }
         return null;
      }
      
      public function get scope() : String
      {
         return _scope;
      }
      
      public function get challengeData() : ChallengeData
      {
         return _data;
      }
      
      public function get isScopeBattle() : Boolean
      {
         return scope != "Global";
      }
      
      public function get global() : Boolean
      {
         return scope == "Global";
      }
      
      public function reset() : void
      {
         LogUtils.log(id + " challenge reset, player: " + _playerId,this,1,"Challenges",false,false,true);
         for each(var counter in _counters)
         {
            counter.reset();
         }
      }
      
      public function notifyCounterStateChanged() : void
      {
         MessageCenter.sendMessage("ChallengeStateChanged",this);
      }
      
      public function areCountersCompleted() : Boolean
      {
         for each(var counter in _counters)
         {
            if(!counter.completed)
            {
               return false;
            }
         }
         return true;
      }
      
      private function updateCounter(counter:Counter) : Boolean
      {
         return counter.completed && !counter.forceCounterUpdate;
      }
      
      private function handleTurnEnded(msg:PlayerTurnEndedMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleTurnEnded(msg);
            }
         }
      }
      
      private function handleMatchEnded(msg:MatchEndedMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleMatchEnded(msg);
            }
         }
      }
      
      private function handleEndGameConfirm(msg:ChallengeEndGameConfirm) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleEndGameConfirm(msg);
            }
         }
      }
      
      private function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handlePlayerDied(msg);
            }
         }
      }
      
      private function handleLevelObjectDestroyed(msg:ChallengeLevelObjectDestroyed) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleLevelObjectDestroyed(msg);
            }
         }
      }
      
      private function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleAmmoHit(msg);
            }
         }
      }
      
      private function handlePhysicsObjectContact(msg:ChallengePhysicsObjectContactMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handlePhysicsObjectContact(msg);
            }
         }
      }
      
      private function handleItemBought(msg:ChallengeItemBoughtMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleItemBought(msg);
            }
         }
      }
      
      private function handleWeaponUsed(msg:ChallengeWeaponUsedMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleWeaponUsed(msg);
            }
         }
      }
      
      private function handleBoosterUsed(msg:ChallengeBoosterUsedMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleBoosterUsed(msg);
            }
         }
      }
      
      private function handleGainedCoins(msg:ChallengeGainedCoinsMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleGainedCoins(msg);
            }
         }
      }
      
      private function handleReachedLevel(msg:ChallengeReachLevelMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleReachedLevel(msg);
            }
         }
      }
      
      private function handleItemGained(msg:ChallengeItemGainedMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleItemGained(msg);
            }
         }
      }
      
      private function handleItemCrafted(msg:ChallengeItemCraftedMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleItemCrafted(msg);
            }
         }
      }
      
      private function handleScoreChanged(msg:ChallengePlayerScoreChangedMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleScoreChanged(msg);
            }
         }
      }
      
      private function handleTakeCollisionDamage(msg:ChallengeTakeCollisionDamageMessage) : void
      {
         for each(var counter in _counters)
         {
            if(!updateCounter(counter))
            {
               counter.handleTakeCollisionDamage(msg);
            }
         }
      }
      
      private function init() : void
      {
         var i:int = 0;
         var param:* = null;
         var _loc2_:* = null;
         var _loc3_:int = _data.counters.length;
         for(i = 0; i < _loc3_; )
         {
            param = null;
            if(_data.params != null)
            {
               if((_data.params as Array).length > i && _data.params[i])
               {
                  param = new ChallengeParamReference(_data.params[i]);
               }
               else
               {
                  LogUtils.log("More counters than params defined in challengeID: " + id,this,3,"ChallengeData",true,true,true);
               }
            }
            _loc2_ = CounterFactory.createCounter(this,_data.counters[i],_data.targetValues[i],_playerId,param);
            if(_loc2_)
            {
               _counters.push(_loc2_);
            }
            i++;
         }
      }
      
      private function updateCounters(data:Object) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(data.counters)
         {
            _loc2_ = data.counters.counter is Array ? data.counters.counter : [data.counters.counter];
            for each(var counterData in _loc2_)
            {
               _loc4_ = findCounter(counterData.key);
               if(_loc4_)
               {
                  _loc4_.value = counterData.value;
               }
               else
               {
                  var _loc11_:* = counterData;
                  var _loc5_:LogUtils = LogUtils;
                  var _loc10_:String = "";
                  var _loc7_:int = 0;
                  var _loc6_:* = _loc11_;
                  §§push(LogUtils);
                  §§push("Player (" + _playerId + "): Trying to add counter value for a counter that doesn\'t " + "exists in the challenge. Counter: ");
                  for(var _loc12_ in _loc6_)
                  {
                     if(avmplus.getQualifiedClassName(_loc11_[_loc12_]) == avmplus.getQualifiedClassName(Object))
                     {
                        _loc10_ += "<" + _loc12_ + ": " + com.dchoc.utils.LogUtils.getObjectContent(_loc11_[_loc12_]) + ">";
                     }
                     else if(_loc11_[_loc12_] is String)
                     {
                        _loc10_ += "<" + _loc12_ + ": " + _loc11_[_loc12_].toString() + ">";
                     }
                     else
                     {
                        _loc10_ += "<" + _loc12_ + ": " + avmplus.getQualifiedClassName(_loc11_[_loc12_]) + ">";
                     }
                  }
                  §§pop().log(§§pop() + _loc10_ + " Challenge: " + id,this,3,"Challenges",false,false,true);
               }
            }
         }
      }
      
      private function getTargetValue(counter:String) : int
      {
         return findCounter(counter).targetValue;
      }
      
      private function findCounter(id:String) : Counter
      {
         return DCUtils.find(_counters,"id",id);
      }
      
      private function addListeners() : void
      {
         MessageCenter.addListener("ChallengePhysicsObjectContact",handlePhysicsObjectContact);
         MessageCenter.addListener("ChallengeAmmoHit",handleAmmoHit);
         MessageCenter.addListener("ChallengePlayerDied",handlePlayerDied);
         MessageCenter.addListener("ChallengeLevelObjectDestroyed",handleLevelObjectDestroyed);
         MessageCenter.addListener("ChallengeItemBought",handleItemBought);
         MessageCenter.addListener("ChallengeWeaponUsed",handleWeaponUsed);
         MessageCenter.addListener("ChallengeBoosterUsed",handleBoosterUsed);
         MessageCenter.addListener("ChallengeEndGameConfirm",handleEndGameConfirm);
         MessageCenter.addListener("ChallengeScoreChange",handleScoreChanged);
         MessageCenter.addListener("ChallengeTakeCollisionDamage",handleTakeCollisionDamage);
         MessageCenter.addListener("ChallengeGainedCoins",handleGainedCoins);
         MessageCenter.addListener("ChallengeReachedLevel",handleReachedLevel);
         MessageCenter.addListener("ChallengeItemCrafted",handleItemCrafted);
         MessageCenter.addListener("ChallengeItemGained",handleItemGained);
      }
      
      private function removeListeners() : void
      {
         MessageCenter.removeListener("ChallengePhysicsObjectContact",handlePhysicsObjectContact);
         MessageCenter.removeListener("ChallengeAmmoHit",handleAmmoHit);
         MessageCenter.removeListener("ChallengePlayerDied",handlePlayerDied);
         MessageCenter.removeListener("ChallengeLevelObjectDestroyed",handleLevelObjectDestroyed);
         MessageCenter.removeListener("ChallengeItemBought",handleItemBought);
         MessageCenter.removeListener("ChallengeWeaponUsed",handleWeaponUsed);
         MessageCenter.removeListener("ChallengeBoosterUsed",handleBoosterUsed);
         MessageCenter.removeListener("ChallengeEndGameConfirm",handleEndGameConfirm);
         MessageCenter.removeListener("ChallengeScoreChange",handleScoreChanged);
         MessageCenter.removeListener("ChallengeTakeCollisionDamage",handleTakeCollisionDamage);
         MessageCenter.removeListener("ChallengeGainedCoins",handleGainedCoins);
         MessageCenter.removeListener("ChallengeReachedLevel",handleReachedLevel);
         MessageCenter.removeListener("ChallengeItemCrafted",handleItemCrafted);
         MessageCenter.removeListener("ChallengeItemGained",handleItemGained);
      }
   }
}
