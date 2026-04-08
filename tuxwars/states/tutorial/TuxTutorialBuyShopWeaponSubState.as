package tuxwars.states.tutorial
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.groups.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.shop.*;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.home.ui.screen.shop.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialBuyShopWeaponSubState extends TuxTutorialSubState
   {
      private var buyClicked:Boolean;
      
      private var tabClicked:Boolean;
      
      private var exitClicked:Boolean;
      
      public function TuxTutorialBuyShopWeaponSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_BUY_SHOP_WEAPONS");
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","BuyAmmo");
      }
      
      override public function enter() : void
      {
         super.enter();
         if(Tutorial._tutorialStep == "TutorialMatchPlayed")
         {
            Tutorial.saveTutorialStep("TutorialBuyShopWeapons",false);
            this.shopScreen.activateTutorial("BasicNuke","right",addTutorialArrow);
            MessageCenter.addListener("ItemBought",this.itemWeaponBuy);
         }
         else if(Tutorial._tutorialStep == "TutorialBuyShopWeaponsDone")
         {
            this.handleClick();
         }
         else
         {
            this.handleExit();
         }
      }
      
      override public function exit() : void
      {
         var _loc1_:HomeScreen = tuxGame.homeState.screenHandler.screen as HomeScreen;
         _loc1_.characterFrameElementScreen.playButton.setEnabled(true);
         _loc1_.characterFrameElementScreen.enableTournamentButton(true);
         super.exit();
         MessageCenter.removeListener("ItemBought",this.itemWeaponBuy);
         MessageCenter.removeListener("ItemBought",this.itemClothingBuy);
         Tutorial.saveTutorialStep("TutorialCloseShopWeapons",true);
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","BuyAmmoDone");
      }
      
      private function get shopScreen() : ShopScreen
      {
         return ShopUISubState(parent).screenHandler.screen as ShopScreen;
      }
      
      private function itemWeaponBuy(param1:Message) : void
      {
         MessageCenter.removeListener("ItemBought",this.itemWeaponBuy);
         this.handleClick();
      }
      
      private function itemClothingBuy(param1:Message) : void
      {
         MessageCenter.removeListener("ItemBought",this.itemClothingBuy);
         this.handleExit();
      }
      
      private function handleClick() : void
      {
         var _loc1_:ShopScreen = null;
         var _loc2_:ShopScreen = null;
         var _loc3_:ShopScreen = null;
         if(!this.buyClicked)
         {
            MessageCenter.removeListener("ItemBought",this.itemWeaponBuy);
            Tutorial.saveTutorialStep("TutorialBuyShopWeaponsDone",true);
            this.buyClicked = true;
            removeTutorialArrow();
            _loc1_ = this.shopScreen;
            addTutorialArrow("left",_loc1_._design.Container_Tabs.Tab_05.Container_Arrow);
            _loc2_ = this.shopScreen;
            _loc3_ = this.shopScreen;
            DCUtils.bringToFront(_loc2_._design,_loc3_._design.Container_Tabs);
            setText(ProjectManager.getText("TUTORIAL_CHANGE_TO_CLOTHING_TAB"));
            this.shopScreen.activateTutorial(null,null,null);
            ((this.shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).setEnabled(true);
            ((this.shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).clickPostCallbackEvent = true;
            ((this.shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).addEventListener("clicked_post_callback",this.tabPressed,false,0,true);
         }
      }
      
      private function tabPressed(param1:UIButtonEvent) : void
      {
         if(!this.tabClicked)
         {
            CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","ClothingTabPressed");
            setText(ProjectManager.getText("TUTORIAL_BUY_CLOTHES"));
            Tutorial.saveTutorialStep("TutorialBuyClothes",false);
            this.tabClicked = true;
            removeTutorialArrow();
            ((this.shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).clickPostCallbackEvent = false;
            ((this.shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).removeEventListener("clicked_post_callback",this.tabPressed,false);
            this.shopScreen.activateTutorial("RedHat","right",addTutorialArrow);
            MessageCenter.addListener("ItemBought",this.itemClothingBuy);
         }
      }
      
      private function handleExit() : void
      {
         var _loc1_:ShopScreen = null;
         if(!this.exitClicked)
         {
            MessageCenter.removeListener("ItemBought",this.itemClothingBuy);
            Tutorial.saveTutorialStep("TutorialCloseShopWeapons",true);
            this.exitClicked = true;
            removeTutorialArrow();
            _loc1_ = this.shopScreen;
            addTutorialArrow("left",_loc1_._design.Container_Arrow_Home);
            setText(ProjectManager.getText("TUTORIAL_BUY_SHOP_WEAPONS_CLOSE"));
            this.shopScreen.activateTutorial(null,null,null);
            this.shopScreen.homeButton.setEnabled(true);
         }
      }
   }
}

