package tuxwars.challenges.counters
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.challenges.*;
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
   
   public class Counter
   {
      private var _challenge:Challenge;
      
      private var _targetValue:int;
      
      private var _id:String;
      
      private var _value:int;
      
      private var _playerId:String;
      
      private var _tuxGame:TuxWarsGame;
      
      private var _params:ChallengeParamReference;
      
      public function Counter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super();
         this._challenge = param1;
         this._id = param2;
         this._targetValue = param3;
         this._playerId = param4;
         this._params = param5;
         MessageCenter.addListener("SendGame",this.handleSendGame);
         MessageCenter.sendMessage("GetGame");
         LogUtils.log("Created counter: " + this.toString(),null,1,"Challenges",false,false,true);
      }
      
      public function toString() : String
      {
         var _loc1_:String = "Counter: " + this._id + ", value: " + this.value + "/" + this.targetValue + ", player ID: " + this._playerId + ", completed: " + this.completed;
         if(this.challenge != null)
         {
            _loc1_ += "challenge: " + this.challenge.id + ", scope:" + this.challenge.scope;
         }
         if(this.params != null)
         {
            _loc1_ += ", params: " + this.params.toString();
         }
         return _loc1_;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get targetValue() : int
      {
         return this._targetValue;
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function set value(param1:int) : void
      {
         this._value = param1;
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return this._tuxGame;
      }
      
      public function get playerId() : String
      {
         return this._playerId;
      }
      
      protected function updateValue(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(param1 != 0)
         {
            _loc3_ = this.completed;
            this._value += param1;
            LogUtils.log(this.toString() + " Updated.",this,0,"Challenges",false,false,false);
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.sendCounterUpdate(new CounterUpdate(this.playerId,this,param1),param2);
            if(Config.debugMode && this.completed)
            {
               LogUtils.log(this.toString() + " Completed!",this,1,"Challenges",false,false,false);
            }
            if(_loc3_ != this.completed)
            {
               this.challenge.notifyCounterStateChanged();
            }
         }
      }
      
      public function calculateCompletionPercentage() : int
      {
         var _loc1_:int = this.value;
         var _loc2_:int = this.targetValue;
         if(_loc1_ >= _loc2_)
         {
            return 100;
         }
         return _loc1_ * 100 / _loc2_;
      }
      
      public function reset() : void
      {
         var _loc1_:Boolean = this.completed;
         this._value = 0;
         if(_loc1_ != this.completed)
         {
            this.challenge.notifyCounterStateChanged();
         }
      }
      
      public function getProgressString() : String
      {
         return ProjectManager.getText(this.id,[this.value + " / " + this.targetValue]) + "\n";
      }
      
      public function get completed() : Boolean
      {
         return this.value >= this.targetValue;
      }
      
      public function handlePlayerDied(param1:ChallengePlayerDiedMessage) : void
      {
      }
      
      public function handleLevelObjectDestroyed(param1:ChallengeLevelObjectDestroyed) : void
      {
      }
      
      public function handleItemBought(param1:ChallengeItemBoughtMessage) : void
      {
      }
      
      public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
      }
      
      public function handlePhysicsObjectContact(param1:ChallengePhysicsObjectContactMessage) : void
      {
      }
      
      public function handleWeaponUsed(param1:ChallengeWeaponUsedMessage) : void
      {
      }
      
      public function handleBoosterUsed(param1:ChallengeBoosterUsedMessage) : void
      {
      }
      
      public function handleTurnEnded(param1:PlayerTurnEndedMessage) : void
      {
      }
      
      public function handleMatchEnded(param1:MatchEndedMessage) : void
      {
      }
      
      public function handleEndGameConfirm(param1:ChallengeEndGameConfirm) : void
      {
      }
      
      public function handleTakeCollisionDamage(param1:ChallengeTakeCollisionDamageMessage) : void
      {
      }
      
      public function handleGainedCoins(param1:ChallengeGainedCoinsMessage) : void
      {
      }
      
      public function handleReachedLevel(param1:ChallengeReachLevelMessage) : void
      {
      }
      
      public function handleItemGained(param1:ChallengeItemGainedMessage) : void
      {
      }
      
      public function handleItemCrafted(param1:ChallengeItemCraftedMessage) : void
      {
      }
      
      public function handleScoreChanged(param1:ChallengePlayerScoreChangedMessage) : void
      {
      }
      
      private function handleSendGame(param1:Message) : void
      {
         this._tuxGame = param1.data;
         MessageCenter.removeListener("SendGame",this.handleSendGame);
      }
      
      public function get params() : ChallengeParamReference
      {
         return this._params;
      }
      
      public function set params(param1:ChallengeParamReference) : void
      {
         this._params = param1;
      }
      
      public function get challenge() : Challenge
      {
         return this._challenge;
      }
      
      public function get forceCounterUpdate() : Boolean
      {
         return false;
      }
   }
}

