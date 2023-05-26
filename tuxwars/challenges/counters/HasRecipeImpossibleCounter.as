package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemGainedMessage;
   
   public class HasRecipeImpossibleCounter extends HasRecipesCounter
   {
       
      
      public function HasRecipeImpossibleCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleItemGained(msg:ChallengeItemGainedMessage) : void
      {
         if(playerId == msg.player.id)
         {
            if(msg.item.type == "Recipe" && msg.item.hasCategory("Impossible"))
            {
               updateValue(msg.gainedAmount,false);
            }
         }
      }
   }
}
