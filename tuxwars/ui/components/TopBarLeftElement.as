package tuxwars.ui.components
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.external.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.dailynews.*;
   import tuxwars.home.states.gifts.*;
   import tuxwars.home.states.help.*;
   import tuxwars.home.states.neighbors.*;
   import tuxwars.home.states.vip.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
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
      
      public function TopBarLeftElement(param1:MovieClip, param2:TuxWarsGame)
      {
         super();
         this._design = param1;
         this._game = param2;
         this.giftsButton = TuxUiUtils.createButton(UIButton,param1,"Button_Gifts",this.giftsCallback,"BUTTON_GIFTS","TOOLTIP_FREE_GIFTS");
         this.giftsButton.addEventListener("out",this.mouseOut,false,0,true);
         this.giftsButton.addEventListener("over",this.mouseOver,false,0,true);
         this.neighborsButton = TuxUiUtils.createButton(UIButton,param1,"Button_Friends",this.neightborsCallback,"BUTTON_NEIGHBORS","TOOLTIP_FRIENDS");
         this.neighborsButton.addEventListener("out",this.mouseOut,false,0,true);
         this.neighborsButton.addEventListener("over",this.mouseOver,false,0,true);
         this.vipStatusChanged(null);
         this.helpButton = TuxUiUtils.createButton(UIButton,param1,"Button_Help",this.helpCallback,"BUTTON_HELP","TOOLTIP_HELP");
         this.helpButton.addEventListener("out",this.mouseOut,false,0,true);
         this.helpButton.addEventListener("over",this.mouseOver,false,0,true);
         this.newsButton = TuxUiUtils.createButton(UIButton,param1,"Button_News",this.newsCallback,"BUTTON_NEWS","TOOLTIP_NEWS");
         this.newsButton.addEventListener("out",this.mouseOut,false,0,true);
         this.newsButton.addEventListener("over",this.mouseOver,false,0,true);
         try
         {
            this.earnGoldButton = TuxUiUtils.createButton(UIButton,param1,"Button_cash",this.earnGoldCallback);
         }
         catch(e:Error)
         {
         }
         if(Tutorial._tutorial)
         {
            this.giftsButton.setEnabled(!(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart"));
            this.neighborsButton.setEnabled(!(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart"));
            this.vipButton.setEnabled(!(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart"));
            this.helpButton.setEnabled(!(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart"));
            this.newsButton.setEnabled(!(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart"));
            this.earnGoldButton.setEnabled(!(Tutorial._tutorialStep == "TutorialCustomizationDone" || Tutorial._tutorialStep == "TutorialStart"));
         }
         MessageCenter.addListener("VipStatusChanged",this.vipStatusChanged);
      }
      
      public function dispose() : void
      {
         this._game = null;
         this._design = null;
         this.giftsButton.dispose();
         this.giftsButton = null;
         this.neighborsButton.dispose();
         this.neighborsButton = null;
         this.vipButton.dispose();
         this.vipButton = null;
         this.helpButton.dispose();
         this.helpButton = null;
         this.newsButton.dispose();
         this.newsButton = null;
         this.earnGoldButton.dispose();
         this.earnGoldButton = null;
         MessageCenter.removeListener("VipStatusChanged",this.vipStatusChanged);
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      private function giftsCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Gifts");
         this._game.homeState.changeState(new GiftState(this._game));
      }
      
      private function neightborsCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Party");
         this._game.homeState.changeState(new NeighborState(this._game));
      }
      
      private function vipCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","VIP");
         this._game.homeState.changeState(new VIPState(this._game));
      }
      
      private function helpCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","Help");
         this._game.homeState.changeState(new HelpState(this._game));
      }
      
      private function newsCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tabs","Clicked","News");
         this._game.homeState.changeState(new DailyNewsState(this._game,this._game.dailyNewsData));
      }
      
      private function earnGoldCallback(param1:MouseEvent) : void
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
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function vipStatusChanged(param1:Message) : void
      {
         if(this.vipButton)
         {
            this.vipButton.dispose();
            this.vipButton = null;
         }
         if(this._game.player.vipMembership.vip)
         {
            this.design.getChildByName("Button_VIP").visible = false;
            this.design.getChildByName("Button_VIP_Active").visible = true;
         }
         else
         {
            this.design.getChildByName("Button_VIP").visible = true;
            this.design.getChildByName("Button_VIP_Active").visible = false;
         }
         this.vipButton = TuxUiUtils.createButton(UIButton,this.design,!!this._game.player.vipMembership.vip ? "Button_VIP_Active" : "Button_VIP",this.vipCallback,"BUTTON_VIP","TOOLTIP_MEMBERSHIP");
         this.vipButton.addEventListener("out",this.mouseOut,false,0,true);
         this.vipButton.addEventListener("over",this.mouseOver,false,0,true);
      }
   }
}

