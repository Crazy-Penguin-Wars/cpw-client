package tuxwars.challenges.counters
{
   import avmplus.getQualifiedClassName;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.missiles.Missile;
   import tuxwars.battle.missiles.TimerMissile;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   
   public class MissileFlyTimeCounter extends Counter
   {
       
      
      public function MissileFlyTimeCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
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
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:Tagger = msg.object.tag.findLatestPlayerTagger();
         if(_loc4_)
         {
            _loc3_ = _loc4_.gameObject as PlayerGameObject;
            if(_loc3_ && playerId == _loc5_._id)
            {
               if(getQualifiedClassName(Missile) == getQualifiedClassName(msg.object) || getQualifiedClassName(TimerMissile) == getQualifiedClassName(msg.object))
               {
                  _loc2_ = msg.object.elapsedTime * 0.001;
                  if(_loc2_ > value)
                  {
                     updateValue(_loc2_);
                  }
                  else
                  {
                     LogUtils.log(toString() + " value was greater than time " + _loc2_,this,0,"Challenges",false,false,false);
                  }
               }
               else
               {
                  LogUtils.log(toString() + " was not a missile/timerMissile " + getQualifiedClassName(msg.object),this,0,"Challenges",false,false,false);
               }
            }
         }
      }
   }
}
