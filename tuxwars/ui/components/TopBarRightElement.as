package tuxwars.ui.components
{
   import com.dchoc.ui.events.UIButtonEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.inbox.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class TopBarRightElement
   {
      private static const BUTTON_INBOX:String = "Button_Inbox";
      
      private var inboxButton:InboxButton;
      
      private var _design:MovieClip;
      
      private var _game:TuxWarsGame;
      
      public function TopBarRightElement(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         this._design = param1;
         this._game = param2;
         this.inboxButton = TuxUiUtils.createButton(InboxButton,param1,"Button_Inbox",this.inboxCallback,"BUTTON_INBOX","TOOLTIP_INBOX");
         this.inboxButton.addEventListener("out",this.mouseOut,false,0,true);
         this.inboxButton.addEventListener("over",this.mouseOver,false,0,true);
         if(Tutorial._tutorial)
         {
            this.inboxButton.setEnabled(!(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart"));
         }
      }
      
      public function dispose() : void
      {
         this._game = null;
         this._design = null;
         this.inboxButton.dispose();
         this.inboxButton = null;
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      private function inboxCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Inbox");
         this._game.homeState.changeState(new InboxState(this._game));
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

