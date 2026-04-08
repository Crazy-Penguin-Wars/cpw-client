package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.challenges.Challenge;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.ui.components.*;
   import tuxwars.ui.tooltips.*;
   
   public class ChallengeButtonContainer extends UIContainer
   {
      private var _challengeData:ChallengeData;
      
      private var iconButton:IconButton;
      
      public function ChallengeButtonContainer(param1:int, param2:ChallengeData, param3:MovieClip, param4:Challenge)
      {
         super(param3);
         this._challengeData = param2;
         this.iconButton = new IconButton(param3);
         this.iconButton.setIcon(param2.iconMC);
         this.iconButton.addEventListener("mouseOver",this.mouseOver,false,0,true);
         this.iconButton.addEventListener("mouseOut",this.mouseOut,false,0,true);
      }
      
      override public function dispose() : void
      {
         this.iconButton.removeEventListener("mouseOver",this.mouseOver,false);
         this.iconButton.removeEventListener("mouseOut",this.mouseOut,false);
         this.iconButton.dispose();
         this.iconButton = null;
         this._challengeData = null;
         super.dispose();
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:IconButton = this.iconButton;
         TooltipManager.showTooltip(new ChallengeTooltip(true,this._challengeData),_loc2_._design as MovieClip,1,1);
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

