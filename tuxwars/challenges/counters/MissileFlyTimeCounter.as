package tuxwars.challenges.counters
{
   import avmplus.*;
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   
   public class MissileFlyTimeCounter extends Counter
   {
      public function MissileFlyTimeCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
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
         var _loc2_:PlayerGameObject = null;
         var _loc3_:int = 0;
         var _loc4_:Tagger = param1.object.tag.findLatestPlayerTagger();
         if(_loc4_)
         {
            _loc2_ = _loc4_.gameObject as PlayerGameObject;
            if(Boolean(_loc2_) && playerId == _loc5_._id)
            {
               if(getQualifiedClassName(Missile) == getQualifiedClassName(param1.object) || getQualifiedClassName(TimerMissile) == getQualifiedClassName(param1.object))
               {
                  _loc3_ = param1.object.elapsedTime * 0.001;
                  if(_loc3_ > value)
                  {
                     this.updateValue(_loc3_);
                  }
                  else
                  {
                     LogUtils.log(toString() + " value was greater than time " + _loc3_,this,0,"Challenges",false,false,false);
                  }
               }
               else
               {
                  LogUtils.log(toString() + " was not a missile/timerMissile " + getQualifiedClassName(param1.object),this,0,"Challenges",false,false,false);
               }
            }
         }
      }
   }
}

