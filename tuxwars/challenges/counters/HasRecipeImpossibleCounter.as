package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemGainedMessage;
   
   public class HasRecipeImpossibleCounter extends HasRecipesCounter
   {
      public function HasRecipeImpossibleCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleItemGained(param1:ChallengeItemGainedMessage) : void
      {
         if(playerId == param1.player.id)
         {
            if(param1.item.type == "Recipe" && param1.item.hasCategory("Impossible"))
            {
               updateValue(param1.gainedAmount,false);
            }
         }
      }
   }
}

