package tuxwars.challenges
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.battle.net.messages.history.*;
   import tuxwars.battle.ui.states.results.*;
   import tuxwars.challenges.counters.*;
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
      private static var tuxGame:TuxWarsGame;
      
      public static const SCOPE_TURN:String = "Turn";
      
      public static const SCOPE_MATCH:String = "Match";
      
      public static const SCOPE_GLOBAL:String = "Global";
      
      public static const TYPE_BATTLE:String = "Battle";
      
      public static const TYPE_GRIND:String = "Grind";
      
      public static const TYPE_SKILL:String = "Skill";
      
      public static const TYPE_IMPOSSIBLE:String = "Impossible";
      
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
      
      public function Challenge(param1:ChallengeData, param2:String)
      {
         super();
         this._data = param1;
         this._playerId = param2;
         this.graphics = param1.icon;
         this._scope = param1.scope;
         this._rewardCash = param1.rewardCash;
         this._rewardCoins = param1.rewardCoins;
         this._rewardExp = param1.rewardExp;
         this._type = param1.type;
         this._nextChallengeIds = param1.nextChallengeIds;
         this._description = param1.description;
         this._id = param1.id;
         this._alreadyCompletedWhenActivated = false;
         this.init();
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
         LogUtils.log("Created challenge: " + this.id + " for player: " + param2,this,1,"Challenges",false,false,true);
      }
      
      private static function handleSendGame(param1:Message) : void
      {
         tuxGame = param1.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public function toString() : String
      {
         return "Challenge ID: " + this.id + " counters: " + this._counters.toString();
      }
      
      public function update(param1:Object) : void
      {
         this.updateCounters(param1);
      }
      
      public function activate(param1:Object = null) : void
      {
         if(param1)
         {
            this.updateCounters(param1);
         }
         this.addListeners();
         if(this.areCountersCompleted())
         {
            this._alreadyCompletedWhenActivated = true;
            this.complete();
         }
      }
      
      public function dispose() : void
      {
         LogUtils.log("Disposing challenge: " + this.name + " player: " + this._playerId,this,1,"Challenges",false);
         this.removeListeners();
         this._data = null;
         this._counters.splice(0,this._counters.length);
      }
      
      public function get counters() : Vector.<Counter>
      {
         return this._counters;
      }
      
      public function pause() : void
      {
         this.removeListeners();
      }
      
      public function resume() : void
      {
         this.addListeners();
      }
      
      public function get collected() : Boolean
      {
         return this._collected;
      }
      
      public function set collected(param1:Boolean) : void
      {
         this._collected = param1;
      }
      
      public function get completed() : Boolean
      {
         return this._completed;
      }
      
      public function set completed(param1:Boolean) : void
      {
         this._completed = param1;
      }
      
      public function calculateCompletionPercentage() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for each(_loc2_ in this._counters)
         {
            _loc1_ += _loc2_.calculateCompletionPercentage();
         }
         return _loc1_ / this._counters.length;
      }
      
      public function complete() : void
      {
         this.completed = true;
         this.removeListeners();
         MessageCenter.sendMessage("ChallengeCompleted",this);
         if(tuxGame.isInBattle())
         {
            if(this.isScopeBattle)
            {
               HistoryMessageFactory.sendCompletedChallengeMessage(this._playerId,this.id);
            }
            else if(Boolean(this._alreadyCompletedWhenActivated) && tuxGame.currentState is ResultsUISubState)
            {
               MessageCenter.sendMessage("ChallengeCompleteUpdateNotInBattle",this._data);
            }
            else
            {
               LogUtils.log("Player (" + this._playerId + ") challenge inconsistent: " + this.id + " tried to complete GLOBAL challenge inside of battle",this,3,"Challenges",false);
            }
         }
         else if(!this.isScopeBattle)
         {
            MessageCenter.sendMessage("ChallengeCompleteUpdateNotInBattle",this._data);
         }
         else
         {
            LogUtils.log("Player (" + this._playerId + ") challenge inconsistent: " + this.id + " tried to complete non GLOBAL challenge outside of battle",this,3,"Challenges",false);
         }
         LogUtils.log("Player (" + this._playerId + ") challenge completed: " + this.id,this,1,"Challenges",false);
      }
      
      public function turnStarted() : void
      {
         if(this.scope == "Turn")
         {
            this.reset();
         }
      }
      
      public function turnEnded(param1:PlayerTurnEndedMessage) : void
      {
         this.handleTurnEnded(param1);
         if(!this.completed && this.areCountersCompleted() && this.scope == "Turn")
         {
            this.complete();
         }
      }
      
      public function matchStarted() : void
      {
         if(this.scope == "Match")
         {
            this.reset();
         }
      }
      
      public function matchEnded(param1:MatchEndedMessage) : void
      {
         this.handleMatchEnded(param1);
         if(!this.completed && this.areCountersCompleted() && this.scope == "Match")
         {
            this.complete();
         }
      }
      
      public function outOfBattleCheck() : void
      {
         if(!this.completed && this.areCountersCompleted())
         {
            this.complete();
         }
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return ProjectManager.getText(this._data.getTID());
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get nextChallengeIds() : Array
      {
         return this._nextChallengeIds;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get rewardCash() : int
      {
         return this._rewardCash;
      }
      
      public function get rewardCoins() : int
      {
         return this._rewardCoins;
      }
      
      public function get rewardExp() : int
      {
         return this._rewardExp;
      }
      
      public function get icon() : MovieClip
      {
         if(this.graphics)
         {
            return DCResourceManager.instance.getFromSWF(this.graphics.swf,this.graphics.export);
         }
         return null;
      }
      
      public function get scope() : String
      {
         return this._scope;
      }
      
      public function get challengeData() : ChallengeData
      {
         return this._data;
      }
      
      public function get isScopeBattle() : Boolean
      {
         return this.scope != "Global";
      }
      
      public function get global() : Boolean
      {
         return this.scope == "Global";
      }
      
      public function reset() : void
      {
         var _loc1_:* = undefined;
         LogUtils.log(this.id + " challenge reset, player: " + this._playerId,this,1,"Challenges",false,false,true);
         for each(_loc1_ in this._counters)
         {
            _loc1_.reset();
         }
      }
      
      public function notifyCounterStateChanged() : void
      {
         MessageCenter.sendMessage("ChallengeStateChanged",this);
      }
      
      public function areCountersCompleted() : Boolean
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._counters)
         {
            if(!_loc1_.completed)
            {
               return false;
            }
         }
         return true;
      }
      
      private function updateCounter(param1:Counter) : Boolean
      {
         return param1.completed && !param1.forceCounterUpdate;
      }
      
      private function handleTurnEnded(param1:PlayerTurnEndedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleTurnEnded(param1);
            }
         }
      }
      
      private function handleMatchEnded(param1:MatchEndedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleMatchEnded(param1);
            }
         }
      }
      
      private function handleEndGameConfirm(param1:ChallengeEndGameConfirm) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleEndGameConfirm(param1);
            }
         }
      }
      
      private function handlePlayerDied(param1:ChallengePlayerDiedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handlePlayerDied(param1);
            }
         }
      }
      
      private function handleLevelObjectDestroyed(param1:ChallengeLevelObjectDestroyed) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleLevelObjectDestroyed(param1);
            }
         }
      }
      
      private function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleAmmoHit(param1);
            }
         }
      }
      
      private function handlePhysicsObjectContact(param1:ChallengePhysicsObjectContactMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handlePhysicsObjectContact(param1);
            }
         }
      }
      
      private function handleItemBought(param1:ChallengeItemBoughtMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleItemBought(param1);
            }
         }
      }
      
      private function handleWeaponUsed(param1:ChallengeWeaponUsedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleWeaponUsed(param1);
            }
         }
      }
      
      private function handleBoosterUsed(param1:ChallengeBoosterUsedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleBoosterUsed(param1);
            }
         }
      }
      
      private function handleGainedCoins(param1:ChallengeGainedCoinsMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleGainedCoins(param1);
            }
         }
      }
      
      private function handleReachedLevel(param1:ChallengeReachLevelMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleReachedLevel(param1);
            }
         }
      }
      
      private function handleItemGained(param1:ChallengeItemGainedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleItemGained(param1);
            }
         }
      }
      
      private function handleItemCrafted(param1:ChallengeItemCraftedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleItemCrafted(param1);
            }
         }
      }
      
      private function handleScoreChanged(param1:ChallengePlayerScoreChangedMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleScoreChanged(param1);
            }
         }
      }
      
      private function handleTakeCollisionDamage(param1:ChallengeTakeCollisionDamageMessage) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._counters)
         {
            if(!this.updateCounter(_loc2_))
            {
               _loc2_.handleTakeCollisionDamage(param1);
            }
         }
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ChallengeParamReference = null;
         var _loc3_:Counter = null;
         var _loc4_:int = int(this._data.counters.length);
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_ = null;
            if(this._data.params != null)
            {
               if((this._data.params as Array).length > _loc1_ && Boolean(this._data.params[_loc1_]))
               {
                  _loc2_ = new ChallengeParamReference(this._data.params[_loc1_]);
               }
               else
               {
                  LogUtils.log("More counters than params defined in challengeID: " + this.id,this,3,"ChallengeData",true,true,true);
               }
            }
            _loc3_ = CounterFactory.createCounter(this,this._data.counters[_loc1_],this._data.targetValues[_loc1_],this._playerId,_loc2_);
            if(_loc3_)
            {
               this._counters.push(_loc3_);
            }
            _loc1_++;
         }
      }
      
      private function updateCounters(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc2_:Array = null;
         var _loc3_:Counter = null;
         if(param1.counters)
         {
            _loc2_ = param1.counters.counter is Array ? param1.counters.counter : [param1.counters.counter];
            for each(_loc4_ in _loc2_)
            {
               _loc3_ = this.findCounter(_loc4_.key);
               if(_loc3_)
               {
                  _loc3_.value = _loc4_.value;
               }
               else
               {
                  _loc5_ = LogUtils.getObjectContent(_loc4_);
                  LogUtils.log("Player (" + this._playerId + "): Trying to add counter value for a counter that doesn\'t exists in the challenge. Counter: " + _loc5_ + " Challenge: " + this.id,this,3,"Challenges",false,false,true);
               }
            }
         }
      }
      
      private function getTargetValue(param1:String) : int
      {
         return this.findCounter(param1).targetValue;
      }
      
      private function findCounter(param1:String) : Counter
      {
         return DCUtils.find(this._counters,"id",param1);
      }
      
      private function addListeners() : void
      {
         MessageCenter.addListener("ChallengePhysicsObjectContact",this.handlePhysicsObjectContact);
         MessageCenter.addListener("ChallengeAmmoHit",this.handleAmmoHit);
         MessageCenter.addListener("ChallengePlayerDied",this.handlePlayerDied);
         MessageCenter.addListener("ChallengeLevelObjectDestroyed",this.handleLevelObjectDestroyed);
         MessageCenter.addListener("ChallengeItemBought",this.handleItemBought);
         MessageCenter.addListener("ChallengeWeaponUsed",this.handleWeaponUsed);
         MessageCenter.addListener("ChallengeBoosterUsed",this.handleBoosterUsed);
         MessageCenter.addListener("ChallengeEndGameConfirm",this.handleEndGameConfirm);
         MessageCenter.addListener("ChallengeScoreChange",this.handleScoreChanged);
         MessageCenter.addListener("ChallengeTakeCollisionDamage",this.handleTakeCollisionDamage);
         MessageCenter.addListener("ChallengeGainedCoins",this.handleGainedCoins);
         MessageCenter.addListener("ChallengeReachedLevel",this.handleReachedLevel);
         MessageCenter.addListener("ChallengeItemCrafted",this.handleItemCrafted);
         MessageCenter.addListener("ChallengeItemGained",this.handleItemGained);
      }
      
      private function removeListeners() : void
      {
         MessageCenter.removeListener("ChallengePhysicsObjectContact",this.handlePhysicsObjectContact);
         MessageCenter.removeListener("ChallengeAmmoHit",this.handleAmmoHit);
         MessageCenter.removeListener("ChallengePlayerDied",this.handlePlayerDied);
         MessageCenter.removeListener("ChallengeLevelObjectDestroyed",this.handleLevelObjectDestroyed);
         MessageCenter.removeListener("ChallengeItemBought",this.handleItemBought);
         MessageCenter.removeListener("ChallengeWeaponUsed",this.handleWeaponUsed);
         MessageCenter.removeListener("ChallengeBoosterUsed",this.handleBoosterUsed);
         MessageCenter.removeListener("ChallengeEndGameConfirm",this.handleEndGameConfirm);
         MessageCenter.removeListener("ChallengeScoreChange",this.handleScoreChanged);
         MessageCenter.removeListener("ChallengeTakeCollisionDamage",this.handleTakeCollisionDamage);
         MessageCenter.removeListener("ChallengeGainedCoins",this.handleGainedCoins);
         MessageCenter.removeListener("ChallengeReachedLevel",this.handleReachedLevel);
         MessageCenter.removeListener("ChallengeItemCrafted",this.handleItemCrafted);
         MessageCenter.removeListener("ChallengeItemGained",this.handleItemGained);
      }
   }
}

