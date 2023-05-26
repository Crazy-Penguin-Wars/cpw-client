package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   
   public class PlayerFlyTimeCounter extends Counter
   {
       
      
      public function PlayerFlyTimeCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override protected function updateValue(amount:int, sendInBattleUpdate:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(amount != 0)
         {
            _loc3_ = completed;
            value = amount;
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
      
      override public function handlePhysicsObjectContact(msg:ChallengePhysicsObjectContactMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:PlayerGameObject = msg.object as PlayerGameObject;
         if(_loc3_ != null && playerId == _loc4_._id)
         {
            _loc2_ = _loc3_.timeFromLastContact * 0.001;
            if(_loc2_ > value)
            {
               updateValue(_loc2_);
            }
         }
      }
   }
}
