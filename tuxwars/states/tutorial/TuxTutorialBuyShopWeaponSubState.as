package tuxwars.states.tutorial
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.groups.UIRadialGroup;
   import com.dchoc.utils.DCUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.shop.ShopUISubState;
   import tuxwars.home.ui.screen.home.HomeScreen;
   import tuxwars.home.ui.screen.shop.ShopScreen;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialBuyShopWeaponSubState extends TuxTutorialSubState
   {
       
      
      private var buyClicked:Boolean;
      
      private var tabClicked:Boolean;
      
      private var exitClicked:Boolean;
      
      public function TuxTutorialBuyShopWeaponSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_BUY_SHOP_WEAPONS");
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","BuyAmmo");
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialMatchPlayed")
         {
            Tutorial.saveTutorialStep("TutorialBuyShopWeapons",false);
            shopScreen.activateTutorial("BasicNuke","right",addTutorialArrow);
            MessageCenter.addListener("ItemBought",itemWeaponBuy);
         }
         else
         {
            var _loc2_:Tutorial = Tutorial;
            if(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialBuyShopWeaponsDone")
            {
               handleClick();
            }
            else
            {
               handleExit();
            }
         }
      }
      
      override public function exit() : void
      {
         var _loc1_:HomeScreen = tuxGame.homeState.screenHandler.screen as HomeScreen;
         _loc1_.characterFrameElementScreen.playButton.setEnabled(true);
         _loc1_.characterFrameElementScreen.enableTournamentButton(true);
         super.exit();
         MessageCenter.removeListener("ItemBought",itemWeaponBuy);
         MessageCenter.removeListener("ItemBought",itemClothingBuy);
         Tutorial.saveTutorialStep("TutorialCloseShopWeapons",true);
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","BuyAmmoDone");
      }
      
      private function get shopScreen() : ShopScreen
      {
         return ShopUISubState(parent).screenHandler.screen as ShopScreen;
      }
      
      private function itemWeaponBuy(msg:Message) : void
      {
         MessageCenter.removeListener("ItemBought",itemWeaponBuy);
         handleClick();
      }
      
      private function itemClothingBuy(msg:Message) : void
      {
         MessageCenter.removeListener("ItemBought",itemClothingBuy);
         handleExit();
      }
      
      private function handleClick() : void
      {
         if(!buyClicked)
         {
            MessageCenter.removeListener("ItemBought",itemWeaponBuy);
            Tutorial.saveTutorialStep("TutorialBuyShopWeaponsDone",true);
            buyClicked = true;
            removeTutorialArrow();
            var _loc1_:ShopScreen = shopScreen;
            addTutorialArrow("left",_loc1_._design.Container_Tabs.Tab_05.Container_Arrow);
            var _loc2_:ShopScreen = shopScreen;
            var _loc3_:ShopScreen = shopScreen;
            DCUtils.bringToFront(_loc2_._design,_loc3_._design.Container_Tabs);
            setText(ProjectManager.getText("TUTORIAL_CHANGE_TO_CLOTHING_TAB"));
            shopScreen.activateTutorial(null,null,null);
            ((shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).setEnabled(true);
            ((shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).clickPostCallbackEvent = true;
            ((shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).addEventListener("clicked_post_callback",tabPressed,false,0,true);
         }
      }
      
      private function tabPressed(event:UIButtonEvent) : void
      {
         if(!tabClicked)
         {
            CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","ClothingTabPressed");
            setText(ProjectManager.getText("TUTORIAL_BUY_CLOTHES"));
            Tutorial.saveTutorialStep("TutorialBuyClothes",false);
            tabClicked = true;
            removeTutorialArrow();
            ((shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).clickPostCallbackEvent = false;
            ((shopScreen.tabGroup as UIRadialGroup).getButtons()[4] as UIToggleButton).removeEventListener("clicked_post_callback",tabPressed,false);
            shopScreen.activateTutorial("RedHat","right",addTutorialArrow);
            MessageCenter.addListener("ItemBought",itemClothingBuy);
         }
      }
      
      private function handleExit() : void
      {
         if(!exitClicked)
         {
            MessageCenter.removeListener("ItemBought",itemClothingBuy);
            Tutorial.saveTutorialStep("TutorialCloseShopWeapons",true);
            exitClicked = true;
            removeTutorialArrow();
            var _loc1_:ShopScreen = shopScreen;
            addTutorialArrow("left",_loc1_._design.Container_Arrow_Home);
            setText(ProjectManager.getText("TUTORIAL_BUY_SHOP_WEAPONS_CLOSE"));
            shopScreen.activateTutorial(null,null,null);
            shopScreen.homeButton.setEnabled(true);
         }
      }
   }
}
