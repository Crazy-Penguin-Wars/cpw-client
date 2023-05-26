package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.challenges.Challenge;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.ui.components.IconButton;
   import tuxwars.ui.tooltips.ChallengeTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   
   public class ChallengeButtonContainer extends UIContainer
   {
       
      
      private var _challengeData:ChallengeData;
      
      private var iconButton:IconButton;
      
      public function ChallengeButtonContainer(slotIndex:int, challengeData:ChallengeData, design:MovieClip, activeChallenge:Challenge)
      {
         super(design);
         _challengeData = challengeData;
         iconButton = new IconButton(design);
         iconButton.setIcon(challengeData.iconMC);
         iconButton.addEventListener("mouseOver",mouseOver,false,0,true);
         iconButton.addEventListener("mouseOut",mouseOut,false,0,true);
      }
      
      override public function dispose() : void
      {
         iconButton.removeEventListener("mouseOver",mouseOver,false);
         iconButton.removeEventListener("mouseOut",mouseOut,false);
         iconButton.dispose();
         iconButton = null;
         _challengeData = null;
         super.dispose();
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         var _loc2_:IconButton = iconButton;
         TooltipManager.showTooltip(new ChallengeTooltip(true,_challengeData),_loc2_._design as MovieClip,1,1);
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
