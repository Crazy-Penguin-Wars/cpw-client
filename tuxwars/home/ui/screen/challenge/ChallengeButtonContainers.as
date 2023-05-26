package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.challenges.Challenge;
   import tuxwars.data.challenges.ChallengeData;
   
   public class ChallengeButtonContainers extends UIContainers
   {
      
      private static const DEFAULT_SLOT:String = "Slot_Default";
      
      private static const CURRENT_SLOT:String = "Challenge_Current";
      
      private static const DISABLED_SLOT:String = "Challenge_Disabled";
       
      
      public function ChallengeButtonContainers(slotIndex:int, challengeData:ChallengeData, design:MovieClip, activeChallenge:Challenge, completed:Boolean)
      {
         super();
         design.visible = true;
         add("Slot_Default",new ChallengeButtonContainer(slotIndex,challengeData,design.Slot_Default,activeChallenge));
         add("Challenge_Current",new ChallengeButtonContainer(slotIndex,challengeData,design.Challenge_Current,activeChallenge));
         add("Challenge_Disabled",new ChallengeButtonContainer(slotIndex,challengeData,design.Challenge_Disabled,activeChallenge));
         if(!activeChallenge)
         {
            show("Slot_Default",false);
         }
         else if(activeChallenge.id == challengeData.id)
         {
            show("Challenge_Current",false);
         }
         else if(completed)
         {
            show("Slot_Default",false);
         }
         else
         {
            show("Challenge_Disabled",false);
         }
      }
   }
}
