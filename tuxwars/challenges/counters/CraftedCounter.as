package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeItemCraftedMessage;
   
   public class CraftedCounter extends DynamicCounter
   {
      public function CraftedCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleItemCrafted(param1:ChallengeItemCraftedMessage) : void
      {
         if(playerId == param1.playerId)
         {
            if(targetId == param1.itemID)
            {
               updateValue(1,false);
            }
            else
            {
               LogUtils.log(toString() + " not correct itemId " + param1.itemID + " != " + targetId,this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}

