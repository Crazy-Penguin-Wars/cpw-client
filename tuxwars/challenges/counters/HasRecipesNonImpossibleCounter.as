package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemGainedMessage;
   
   public class HasRecipesNonImpossibleCounter extends HasRecipesCounter
   {
       
      
      public function HasRecipesNonImpossibleCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleItemGained(msg:ChallengeItemGainedMessage) : void
      {
         if(playerId == msg.player.id)
         {
            if(msg.item.type == "Recipe" && !msg.item.hasCategory("Impossible"))
            {
               updateValue(msg.gainedAmount,false);
            }
            else
            {
               LogUtils.log(toString() + " not correct type " + msg.item.type + "!=" + "Recipe",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}
