package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemCraftedMessage;
   
   public class CraftedItemsCounter extends Counter
   {
       
      
      public function CraftedItemsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleItemCrafted(msg:ChallengeItemCraftedMessage) : void
      {
         if(playerId == msg.playerId)
         {
            updateValue(1,false);
         }
      }
   }
}
