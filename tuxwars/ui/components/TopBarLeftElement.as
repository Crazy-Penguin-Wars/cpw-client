package tuxwars.ui.components
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.dailynews.DailyNewsState;
   import tuxwars.home.states.gifts.GiftState;
   import tuxwars.home.states.help.HelpState;
   import tuxwars.home.states.neighbors.NeighborState;
   import tuxwars.home.states.vip.VIPState;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class TopBarLeftElement
   {
      
      private static const BUTTON_GIFTS:String = "Button_Gifts";
      
      private static const BUTTON_MONEY:String = "Button_Add";
      
      private static const BUTTON_NEIGHBORS:String = "Button_Friends";
      
      private static const BUTTON_VIP:String = "Button_VIP";
      
      private static const BUTTON_VIP_ACTIVE:String = "Button_VIP_Active";
      
      private static const BUTTON_HELP:String = "Button_Help";
      
      private static const BUTTON_NEWS:String = "Button_News";
      
      private static const BUTTON_EARNGOLD:String = "Button_cash";
       
      
      private var _design:MovieClip;
      
      private var _game:TuxWarsGame;
      
      private var giftsButton:UIButton;
      
      private var neighborsButton:UIButton;
      
      private var vipButton:UIButton;
      
      private var helpButton:UIButton;
      
      private var newsButton:UIButton;
      
      private var earnGoldButton:UIButton;
      
      public function TopBarLeftElement(design:MovieClip, game:TuxWarsGame)
      {
         super();
         _design = design;
         _game = game;
         giftsButton = TuxUiUtils.createButton(UIButton,design,"Button_Gifts",giftsCallback,"BUTTON_GIFTS","TOOLTIP_FREE_GIFTS");
         giftsButton.addEventListener("out",mouseOut,false,0,true);
         giftsButton.addEventListener("over",mouseOver,false,0,true);
         neighborsButton = TuxUiUtils.createButton(UIButton,design,"Button_Friends",neightborsCallback,"BUTTON_NEIGHBORS","TOOLTIP_FRIENDS");
         neighborsButton.addEventListener("out",mouseOut,false,0,true);
         neighborsButton.addEventListener("over",mouseOver,false,0,true);
         vipStatusChanged(null);
         helpButton = TuxUiUtils.createButton(UIButton,design,"Button_Help",helpCallback,"BUTTON_HELP","TOOLTIP_HELP");
         helpButton.addEventListener("out",mouseOut,false,0,true);
         helpButton.addEventListener("over",mouseOver,false,0,true);
         newsButton = TuxUiUtils.createButton(UIButton,design,"Button_News",newsCallback,"BUTTON_NEWS","TOOLTIP_NEWS");
         newsButton.addEventListener("out",mouseOut,false,0,true);
         newsButton.addEventListener("over",mouseOver,false,0,true);
         try
         {
            earnGoldButton = TuxUiUtils.createButton(UIButton,design,"Button_cash",earnGoldCallback);
         }
         catch(e:Error)
         {
         }
         var _loc5_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            var _loc6_:Tutorial = Tutorial;
            giftsButton.setEnabled(!(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart"));
            var _loc8_:Tutorial = Tutorial;
            neighborsButton.setEnabled(!(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart"));
            var _loc10_:Tutorial = Tutorial;
            vipButton.setEnabled(!(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart"));
            var _loc12_:Tutorial = Tutorial;
            helpButton.setEnabled(!(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart"));
            var _loc14_:Tutorial = Tutorial;
            newsButton.setEnabled(!(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart"));
            var _loc16_:Tutorial = Tutorial;
            earnGoldButton.setEnabled(!(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart"));
         }
         MessageCenter.addListener("VipStatusChanged",vipStatusChanged);
      }
      
      public function dispose() : void
      {
         _game = null;
         _design = null;
         giftsButton.dispose();
         giftsButton = null;
         neighborsButton.dispose();
         neighborsButton = null;
         vipButton.dispose();
         vipButton = null;
         helpButton.dispose();
         helpButton = null;
         newsButton.dispose();
         newsButton = null;
         earnGoldButton.dispose();
         earnGoldButton = null;
         MessageCenter.removeListener("VipStatusChanged",vipStatusChanged);
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      private function giftsCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Gifts");
         _game.homeState.changeState(new GiftState(_game));
      }
      
      private function neightborsCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Party");
         _game.homeState.changeState(new NeighborState(_game));
      }
      
      private function vipCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","VIP");
         _game.homeState.changeState(new VIPState(_game));
      }
      
      private function helpCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Help");
         _game.homeState.changeState(new HelpState(_game));
      }
      
      private function newsCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","News");
         _game.homeState.changeState(new DailyNewsState(_game,_game.dailyNewsData));
      }
      
      private function earnGoldCallback(event:MouseEvent) : void
      {
         if(Config.debugMode)
         {
            LogUtils.log("Earn gold call back pressed","EarnGold",0,"DealSpot");
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.call("fromFlash","showEarnPage",null);
         }
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function vipStatusChanged(msg:Message) : void
      {
         if(vipButton)
         {
            vipButton.dispose();
            vipButton = null;
         }
         if(_game.player.vipMembership.vip)
         {
            design.getChildByName("Button_VIP").visible = false;
            design.getChildByName("Button_VIP_Active").visible = true;
         }
         else
         {
            design.getChildByName("Button_VIP").visible = true;
            design.getChildByName("Button_VIP_Active").visible = false;
         }
         vipButton = TuxUiUtils.createButton(UIButton,design,_game.player.vipMembership.vip ? "Button_VIP_Active" : "Button_VIP",vipCallback,"BUTTON_VIP","TOOLTIP_MEMBERSHIP");
         vipButton.addEventListener("out",mouseOut,false,0,true);
         vipButton.addEventListener("over",mouseOver,false,0,true);
      }
   }
}
