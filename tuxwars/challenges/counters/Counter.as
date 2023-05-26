package tuxwars.challenges.counters
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.ChallengeParamReference;
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
      
      public function Counter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super();
         _challenge = challenge;
         _id = id;
         _targetValue = targetValue;
         _playerId = playerId;
         _params = params;
         MessageCenter.addListener("SendGame",handleSendGame);
         MessageCenter.sendMessage("GetGame");
         LogUtils.log("Created counter: " + toString(),null,1,"Challenges",false,false,true);
      }
      
      public function toString() : String
      {
         var msg:String = "Counter: " + _id + ", value: " + value + "/" + targetValue + ", player ID: " + _playerId + ", completed: " + completed;
         if(challenge != null)
         {
            msg += "challenge: " + challenge.id + ", scope:" + challenge.scope;
         }
         if(params != null)
         {
            msg += ", params: " + params.toString();
         }
         return msg;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get targetValue() : int
      {
         return _targetValue;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function set value(value:int) : void
      {
         _value = value;
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return _tuxGame;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
      
      protected function updateValue(amount:int, sendInBattleUpdate:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(amount != 0)
         {
            _loc3_ = completed;
            _value += amount;
            LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
            var _loc4_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.sendCounterUpdate(new CounterUpdate(playerId,this,amount),sendInBattleUpdate);
            if(Config.debugMode && completed)
            {
               LogUtils.log(toString() + " Completed!",this,1,"Challenges",false,false,false);
            }
            if(_loc3_ != completed)
            {
               challenge.notifyCounterStateChanged();
            }
         }
      }
      
      public function calculateCompletionPercentage() : int
      {
         var _loc1_:int = value;
         var _loc2_:int = targetValue;
         if(_loc1_ >= _loc2_)
         {
            return 100;
         }
         return _loc1_ * 100 / _loc2_;
      }
      
      public function reset() : void
      {
         var _loc1_:Boolean = completed;
         _value = 0;
         if(_loc1_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      public function getProgressString() : String
      {
         return ProjectManager.getText(id,[value + " / " + targetValue]) + "\n";
      }
      
      public function get completed() : Boolean
      {
         return value >= targetValue;
      }
      
      public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
      }
      
      public function handleLevelObjectDestroyed(msg:ChallengeLevelObjectDestroyed) : void
      {
      }
      
      public function handleItemBought(msg:ChallengeItemBoughtMessage) : void
      {
      }
      
      public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
      }
      
      public function handlePhysicsObjectContact(msg:ChallengePhysicsObjectContactMessage) : void
      {
      }
      
      public function handleWeaponUsed(msg:ChallengeWeaponUsedMessage) : void
      {
      }
      
      public function handleBoosterUsed(msg:ChallengeBoosterUsedMessage) : void
      {
      }
      
      public function handleTurnEnded(msg:PlayerTurnEndedMessage) : void
      {
      }
      
      public function handleMatchEnded(msg:MatchEndedMessage) : void
      {
      }
      
      public function handleEndGameConfirm(msg:ChallengeEndGameConfirm) : void
      {
      }
      
      public function handleTakeCollisionDamage(msg:ChallengeTakeCollisionDamageMessage) : void
      {
      }
      
      public function handleGainedCoins(msg:ChallengeGainedCoinsMessage) : void
      {
      }
      
      public function handleReachedLevel(msg:ChallengeReachLevelMessage) : void
      {
      }
      
      public function handleItemGained(msg:ChallengeItemGainedMessage) : void
      {
      }
      
      public function handleItemCrafted(msg:ChallengeItemCraftedMessage) : void
      {
      }
      
      public function handleScoreChanged(msg:ChallengePlayerScoreChangedMessage) : void
      {
      }
      
      private function handleSendGame(msg:Message) : void
      {
         _tuxGame = msg.data;
         MessageCenter.removeListener("SendGame",handleSendGame);
      }
      
      public function get params() : ChallengeParamReference
      {
         return _params;
      }
      
      public function set params(value:ChallengeParamReference) : void
      {
         _params = value;
      }
      
      public function get challenge() : Challenge
      {
         return _challenge;
      }
      
      public function get forceCounterUpdate() : Boolean
      {
         return false;
      }
   }
}
