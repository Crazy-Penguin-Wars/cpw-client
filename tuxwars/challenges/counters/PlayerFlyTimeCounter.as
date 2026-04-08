package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   
   public class PlayerFlyTimeCounter extends Counter
   {
      public function PlayerFlyTimeCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function updateValue(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         if(param1 != 0)
         {
            _loc3_ = completed;
            value = param1;
            LogUtils.log(toString() + " Updated.",this,0,"Challenges",false,false,false);
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.sendCounterUpdate(new CounterUpdate(playerId,this,param1),param2);
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
      
      override public function handlePhysicsObjectContact(param1:ChallengePhysicsObjectContactMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:PlayerGameObject = param1.object as PlayerGameObject;
         if(_loc3_ != null && playerId == _loc4_._id)
         {
            _loc2_ = _loc3_.timeFromLastContact * 0.001;
            if(_loc2_ > value)
            {
               this.updateValue(_loc2_);
            }
         }
      }
   }
}

