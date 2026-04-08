package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemGainedMessage;
   
   public class HasItemCounter extends DynamicCounter
   {
      public function HasItemCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleItemGained(param1:ChallengeItemGainedMessage) : void
      {
         if(playerId == param1.player.id)
         {
            if(targetId == param1.item.id)
            {
               updateValue(param1.gainedAmount,false);
            }
            else
            {
               LogUtils.log(toString() + " not correct item " + param1.item.id,this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}

