package tuxwars.home.states.homestate
{
   import com.dchoc.events.*;
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.events.KeyboardEvent;
   import no.olog.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.net.*;
   import tuxwars.data.*;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.states.dailynews.*;
   import tuxwars.home.states.equipment.*;
   import tuxwars.home.states.gifts.*;
   import tuxwars.home.states.oldcustomgame.*;
   import tuxwars.home.states.shop.*;
   import tuxwars.home.states.slotmachine.*;
   import tuxwars.home.states.vip.*;
   import tuxwars.home.states.vipend.*;
   import tuxwars.home.ui.logic.home.*;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.home.ui.screen.slotmachine.*;
   import tuxwars.states.tutorial.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.firstvip.*;
   import tuxwars.utils.*;
   
   public class HomeState extends TuxUIState
   {
      private var updateInbox:Boolean;
      
      private var movieMonitor:MovieMonitor;
      
      private var mSendGiftNo:Number;
      
      private var mDailyNewsNo:Number;
      
      private var mPopupshown:Boolean;
      
      public function HomeState(param1:TuxWarsGame, param2:Boolean = true, param3:* = null)
      {
         super(HomeScreen,HomeLogic,param1,param3);
         this.updateInbox = param2;
      }
      
      override public function enter() : void
      {
         super.enter();
         if(tuxGame.battleServer.isConnected())
         {
            MessageCenter.sendEvent(new BattleServerDisconnectMessage());
            LogUtils.log("Exited game in some way that did not notify BattleServer to disconnect",this,2,"Warning");
         }
         if(Config.debugMode)
         {
            DCGame.getStage().addEventListener("keyUp",this.keyUp,false,0,true);
         }
         Sounds.playTheme();
         PhysicsGameObject.resetStaticCounters();
         if(this.updateInbox)
         {
            InboxManager.triggerContentUpdate();
         }
         if(Tutorial._tutorial)
         {
            switch(Tutorial._tutorialStep)
            {
               case "TutorialStart":
                  changeState(new EquipmentState(tuxGame));
                  break;
               case "TutorialCustomizationDone":
                  changeState(new TuxTutorialPlaySubState(tuxGame));
                  break;
               case "TutorialMatchPlayed":
               case "TutorialBuyShopWeaponsDone":
                  changeState(new ShopState(tuxGame));
                  break;
               case "TutorialBuyClothesDone":
                  changeState(new TuxTutorialSubState(tuxGame,"TUTORIAL_CLOTHES_BOUGHT",false,true));
            }
         }
         else
         {
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            if(PopUpManager.instance.hasPopUps())
            {
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.showPopUps(this);
            }
            else if(tuxGame.dailyNewsData && !tuxGame.dailyNewsData.shown || !tuxGame._giftShown)
            {
               this.mSendGiftNo = TuxUiUtils.randomNumbers(1,100);
               this.mDailyNewsNo = TuxUiUtils.randomNumbers(1,100);
               this.mPopupshown = false;
            }
            else if(!tuxGame._slotMachineShown && !tuxGame.spinPressed && SlotMachineButton.getFreeDailySpins(tuxGame.player) == 3)
            {
               tuxGame._slotMachineShown = true;
               changeState(new SlotMachineState(tuxGame));
               trace("tuxGame.player.vipMembership.:" + tuxGame.player.vipMembership.vip);
            }
            else if(!tuxGame._VIPMembershipShown && !tuxGame.player.vipMembership.vip && !tuxGame.player._expiredVipMembershipPopup)
            {
               // TEMPORARILY DISABLED
               //tuxGame._VIPMembershipShown = true;
               //changeState(new VIPState(tuxGame));
            }
         }
         LogUtils.log("Loading speed: " + int(DCResourceManager.instance.calculateAverageDownloadSpeed()) + " kB/s",this,1,"Assets");
      }
      
      override public function exit() : void
      {
         if(Config.debugMode)
         {
            DCGame.getStage().removeEventListener("keyUp",this.keyUp);
         }
         super.exit();
      }
      
      override public function exitCurrentState(param1:Boolean = false) : void
      {
         super.exitCurrentState(param1);
         if(Tutorial._tutorial)
         {
            if(Tutorial._tutorialStep == "TutorialCustomizationDone")
            {
               changeState(new TuxTutorialPlaySubState(tuxGame));
            }
            else if(Tutorial._tutorialStep == "TutorialCloseShopWeapons")
            {
               changeState(new TuxTutorialSubState(tuxGame,"TUTORIAL_CLOTHES_BOUGHT",false,true));
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new VipFirstTimePopUpSubState(tuxGame));
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.showPopUps(this);
            }
         }
         else if(screenHandler.screen as HomeScreen)
         {
            (screenHandler.screen as HomeScreen).resetPlayButtons();
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(tuxGame.homeState)
         {
            if(tuxGame.player.vipMembership.didWeLoseVip())
            {
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new VipEndPopupSubState(tuxGame));
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.showPopUps(this);
               MessageCenter.sendMessage("VipStatusChanged",false);
            }
            else if(tuxGame.homeState.state == null)
            {
               if(!this.mPopupshown)
               {
                  // TEMPORARILY DISABLED
                  //if(this.mDailyNewsNo > this.mSendGiftNo)
                  //{
                  //   if(Boolean(tuxGame.dailyNewsData) && !tuxGame.dailyNewsData.shown)
                  //   {
                  //      tuxGame.dailyNewsData.shown = true;
                  //      changeState(new DailyNewsState(tuxGame,tuxGame.dailyNewsData));
                  //   }
                  //}
                  //else if(!tuxGame._giftShown)
                  //{
                  //   tuxGame._giftShown = true;
                  //   changeState(new GiftState(tuxGame));
                  //}
                  //this.mPopupshown = true;
               }
               else if(Boolean(this.mPopupshown) && !tuxGame._slotMachineShown && !tuxGame.spinPressed && SlotMachineButton.getFreeDailySpins(tuxGame.player) > 0)
               {
                  LogUtils.log("tuxGame.player.vipMembership.vip: " + tuxGame.player.vipMembership.vip,this,1,"LogicUpdater");
                  tuxGame._slotMachineShown = true;
                  changeState(new SlotMachineState(tuxGame));
               }
               else if(Boolean(this.mPopupshown) && !tuxGame._VIPMembershipShown && !tuxGame.player.vipMembership.vip && !tuxGame.player._expiredVipMembershipPopup)
               {
                  // TEMPORARILY DISABLED
                  //tuxGame._VIPMembershipShown = true;
                  //changeState(new VIPState(tuxGame));
               }
            }
         }
      }
      
      private function keyUp(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 67)
         {
            case 0:
               changeState(new OldCustomGameState(tuxGame));
               break;
            case 1:
               if(Config.debugMode && param1.ctrlKey)
               {
                  LogUtils.log("All debug cleared",this,0,"All",false,false,true);
                  LogUtils.clearAll();
               }
               break;
            case 2:
               if(Config.debugMode && param1.ctrlKey && param1.shiftKey && param1.altKey)
               {
                  MessageCenter.sendEvent(new ErrorMessage("UserGenerated","HomeState","HomeState: User Generated Error0",null,new Error("User Generated Error0")));
               }
               break;
            case 9:
               if(Config.debugMode && param1.ctrlKey && !param1.shiftKey)
               {
                  MessageCenter.displayListeners();
               }
               else if(Config.debugMode && param1.ctrlKey && param1.shiftKey)
               {
                  LogUtils.log(LogicUpdater.toString(),"LogicUpdater",0,"ListenerDebug",false,false,true);
               }
               break;
            case 10:
               if(this.movieMonitor)
               {
                  this.movieMonitor.dispose();
                  DCGame.getMainMovieClip().removeChild(this.movieMonitor);
                  this.movieMonitor = null;
               }
               else
               {
                  this.movieMonitor = new MovieMonitor();
                  DCGame.getMainMovieClip().addChild(this.movieMonitor);
               }
               break;
            case 16:
               if(Config.debugMode && param1.ctrlKey)
               {
                  Olog.traceDisplayList();
               }
         }
      }
   }
}

