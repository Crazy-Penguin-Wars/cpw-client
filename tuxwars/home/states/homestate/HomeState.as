package tuxwars.home.states.homestate
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.game.DCGame;
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MovieMonitor;
   import flash.events.KeyboardEvent;
   import no.olog.Olog;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.net.BattleServerDisconnectMessage;
   import tuxwars.data.Sounds;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.states.dailynews.DailyNewsState;
   import tuxwars.home.states.equipment.EquipmentState;
   import tuxwars.home.states.gifts.GiftState;
   import tuxwars.home.states.oldcustomgame.OldCustomGameState;
   import tuxwars.home.states.shop.ShopState;
   import tuxwars.home.states.slotmachine.SlotMachineState;
   import tuxwars.home.states.vip.VIPState;
   import tuxwars.home.states.vipend.VipEndPopupSubState;
   import tuxwars.home.ui.logic.home.HomeLogic;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.home.ui.screen.home.HomeScreen;
   import tuxwars.home.ui.screen.slotmachine.SlotMachineButton;
   import tuxwars.states.tutorial.TuxTutorialPlaySubState;
   import tuxwars.states.tutorial.TuxTutorialSubState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.firstvip.VipFirstTimePopUpSubState;
   import tuxwars.utils.TuxUiUtils;
   
   public class HomeState extends TuxUIState
   {
       
      
      private var updateInbox:Boolean;
      
      private var movieMonitor:MovieMonitor;
      
      private var mSendGiftNo:Number;
      
      private var mDailyNewsNo:Number;
      
      private var mPopupshown:Boolean;
      
      public function HomeState(game:TuxWarsGame, updateInbox:Boolean = true, params:* = null)
      {
         super(HomeScreen,HomeLogic,game,params);
         this.updateInbox = updateInbox;
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
            var _loc1_:DCGame = DCGame;
            com.dchoc.game.DCGame._stage.addEventListener("keyUp",keyUp,false,0,true);
         }
         Sounds.playTheme();
         PhysicsGameObject.resetStaticCounters();
         if(updateInbox)
         {
            InboxManager.triggerContentUpdate();
         }
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            var _loc3_:Tutorial = Tutorial;
            switch(tuxwars.tutorial.Tutorial._tutorialStep)
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
            var _loc4_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            if(tuxwars.ui.popups.PopUpManager._instance.hasPopUps())
            {
               var _loc5_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.showPopUps(this);
            }
            else if(tuxGame.dailyNewsData && !tuxGame.dailyNewsData.shown || !tuxGame._giftShown)
            {
               mSendGiftNo = TuxUiUtils.randomNumbers(1,100);
               mDailyNewsNo = TuxUiUtils.randomNumbers(1,100);
               mPopupshown = false;
            }
            else if(!tuxGame._slotMachineShown && !tuxGame.spinPressed && SlotMachineButton.getFreeDailySpins(tuxGame.player) == 3)
            {
               tuxGame._slotMachineShown = true;
               changeState(new SlotMachineState(tuxGame));
               trace("tuxGame.player.vipMembership.:" + tuxGame.player.vipMembership.vip);
            }
            else if(!tuxGame._VIPMembershipShown && !tuxGame.player.vipMembership.vip && !tuxGame.player._expiredVipMembershipPopup)
            {
               tuxGame._VIPMembershipShown = true;
               changeState(new VIPState(tuxGame));
            }
         }
         LogUtils.log("Loading speed: " + DCResourceManager.instance.calculateAverageDownloadSpeed() + " kB/s",this,1,"Assets");
      }
      
      override public function exit() : void
      {
         if(Config.debugMode)
         {
            var _loc1_:DCGame = DCGame;
            com.dchoc.game.DCGame._stage.removeEventListener("keyUp",keyUp);
         }
         super.exit();
      }
      
      override public function exitCurrentState(clearQueue:Boolean = false) : void
      {
         super.exitCurrentState(clearQueue);
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            var _loc3_:Tutorial = Tutorial;
            if(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone")
            {
               changeState(new TuxTutorialPlaySubState(tuxGame));
            }
            else
            {
               var _loc4_:Tutorial = Tutorial;
               if(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCloseShopWeapons")
               {
                  changeState(new TuxTutorialSubState(tuxGame,"TUTORIAL_CLOTHES_BOUGHT",false,true));
                  var _loc5_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.addPopup(new VipFirstTimePopUpSubState(tuxGame));
                  var _loc6_:PopUpManager = PopUpManager;
                  if(!tuxwars.ui.popups.PopUpManager._instance)
                  {
                     tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
                  }
                  tuxwars.ui.popups.PopUpManager._instance.showPopUps(this);
               }
            }
         }
         else if(screenHandler.screen as HomeScreen)
         {
            (screenHandler.screen as HomeScreen).resetPlayButtons();
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(tuxGame.homeState)
         {
            if(tuxGame.player.vipMembership.didWeLoseVip())
            {
               var _loc2_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.addPopup(new VipEndPopupSubState(tuxGame));
               var _loc3_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.showPopUps(this);
               MessageCenter.sendMessage("VipStatusChanged",false);
            }
            else if(tuxGame.homeState.state == null)
            {
               if(!mPopupshown)
               {
                  if(mDailyNewsNo > mSendGiftNo)
                  {
                     if(tuxGame.dailyNewsData && !tuxGame.dailyNewsData.shown)
                     {
                        tuxGame.dailyNewsData.shown = true;
                        changeState(new DailyNewsState(tuxGame,tuxGame.dailyNewsData));
                     }
                  }
                  else if(!tuxGame._giftShown)
                  {
                     tuxGame._giftShown = true;
                     changeState(new GiftState(tuxGame));
                  }
                  mPopupshown = true;
               }
               else if(mPopupshown && !tuxGame._slotMachineShown && !tuxGame.spinPressed && SlotMachineButton.getFreeDailySpins(tuxGame.player) > 0)
               {
                  LogUtils.log("tuxGame.player.vipMembership.vip: " + tuxGame.player.vipMembership.vip,this,1,"LogicUpdater");
                  tuxGame._slotMachineShown = true;
                  changeState(new SlotMachineState(tuxGame));
               }
               else if(mPopupshown && !tuxGame._VIPMembershipShown && !tuxGame.player.vipMembership.vip && !tuxGame.player._expiredVipMembershipPopup)
               {
                  tuxGame._VIPMembershipShown = true;
                  changeState(new VIPState(tuxGame));
               }
            }
         }
      }
      
      private function keyUp(event:KeyboardEvent) : void
      {
         switch(event.keyCode - 67)
         {
            case 0:
               changeState(new OldCustomGameState(tuxGame));
               break;
            case 1:
               if(Config.debugMode && event.ctrlKey)
               {
                  LogUtils.log("All debug cleared",this,0,"All",false,false,true);
                  LogUtils.clearAll();
                  break;
               }
               break;
            case 2:
               if(Config.debugMode && event.ctrlKey && event.shiftKey && event.altKey)
               {
                  MessageCenter.sendEvent(new ErrorMessage("UserGenerated","HomeState","HomeState: User Generated Error0",null,new Error("User Generated Error0")));
                  break;
               }
               break;
            case 9:
               if(Config.debugMode && event.ctrlKey && !event.shiftKey)
               {
                  MessageCenter.displayListeners();
                  break;
               }
               if(Config.debugMode && event.ctrlKey && event.shiftKey)
               {
                  LogUtils.log(LogicUpdater.toString(),"LogicUpdater",0,"ListenerDebug",false,false,true);
                  break;
               }
               break;
            case 10:
               if(movieMonitor)
               {
                  movieMonitor.dispose();
                  DCGame.getMainMovieClip().removeChild(movieMonitor);
                  movieMonitor = null;
                  break;
               }
               movieMonitor = new MovieMonitor();
               DCGame.getMainMovieClip().addChild(movieMonitor);
               break;
            case 16:
               if(Config.debugMode && event.ctrlKey)
               {
                  Olog.traceDisplayList();
                  break;
               }
         }
      }
   }
}
