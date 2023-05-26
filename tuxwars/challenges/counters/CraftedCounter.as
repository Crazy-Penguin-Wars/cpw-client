package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemCraftedMessage;
   
   public class CraftedCounter extends DynamicCounter
   {
       
      
      public function CraftedCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleItemCrafted(msg:ChallengeItemCraftedMessage) : void
      {
         if(playerId == msg.playerId)
         {
            if(targetId == msg.itemID)
            {
               updateValue(1,false);
            }
            else
            {
               LogUtils.log(toString() + " not correct itemId " + msg.itemID + " != " + targetId,this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}
