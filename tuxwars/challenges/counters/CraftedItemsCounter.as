package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemCraftedMessage;
   
   public class CraftedItemsCounter extends Counter
   {
      public function CraftedItemsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleItemCrafted(param1:ChallengeItemCraftedMessage) : void
      {
         if(playerId == param1.playerId)
         {
            updateValue(1,false);
         }
      }
   }
}

