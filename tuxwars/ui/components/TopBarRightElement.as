package tuxwars.ui.components
{
   import com.dchoc.ui.events.UIButtonEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.inbox.InboxState;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class TopBarRightElement
   {
      
      private static const BUTTON_INBOX:String = "Button_Inbox";
       
      
      private var inboxButton:InboxButton;
      
      private var _design:MovieClip;
      
      private var _game:TuxWarsGame;
      
      public function TopBarRightElement(design:MovieClip, game:TuxWarsGame)
      {
         super();
         _design = design;
         _game = game;
         inboxButton = TuxUiUtils.createButton(InboxButton,design,"Button_Inbox",inboxCallback,"BUTTON_INBOX","TOOLTIP_INBOX");
         inboxButton.addEventListener("out",mouseOut,false,0,true);
         inboxButton.addEventListener("over",mouseOver,false,0,true);
         var _loc3_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            var _loc4_:Tutorial = Tutorial;
            inboxButton.setEnabled(!(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart"));
         }
      }
      
      public function dispose() : void
      {
         _game = null;
         _design = null;
         inboxButton.dispose();
         inboxButton = null;
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      private function inboxCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Inbox");
         _game.homeState.changeState(new InboxState(_game));
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
