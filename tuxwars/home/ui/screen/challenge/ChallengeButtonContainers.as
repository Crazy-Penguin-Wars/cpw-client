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
      
      public function ChallengeButtonContainers(param1:int, param2:ChallengeData, param3:MovieClip, param4:Challenge, param5:Boolean)
      {
         super();
         param3.visible = true;
         add("Slot_Default",new ChallengeButtonContainer(param1,param2,param3.Slot_Default,param4));
         add("Challenge_Current",new ChallengeButtonContainer(param1,param2,param3.Challenge_Current,param4));
         add("Challenge_Disabled",new ChallengeButtonContainer(param1,param2,param3.Challenge_Disabled,param4));
         if(!param4)
         {
            show("Slot_Default",false);
         }
         else if(param4.id == param2.id)
         {
            show("Challenge_Current",false);
         }
         else if(param5)
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

