package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemGainedMessage;
   
   public class HasItemCounter extends DynamicCounter
   {
       
      
      public function HasItemCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleItemGained(msg:ChallengeItemGainedMessage) : void
      {
         if(playerId == msg.player.id)
         {
            if(targetId == msg.item.id)
            {
               updateValue(msg.gainedAmount,false);
            }
            else
            {
               LogUtils.log(toString() + " not correct item " + msg.item.id,this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}
