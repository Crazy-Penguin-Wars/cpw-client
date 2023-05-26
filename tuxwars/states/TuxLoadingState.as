package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.media.DCVideoPlayer;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.Server;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.ConfigUpdater;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.tournament.TournamentManager;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.logic.crm.CRMPopUpData;
   import tuxwars.ui.popups.states.crm.CRMMessagePopUpSubState;
   
   public class TuxLoadingState extends TuxLoadingScreenState
   {
       
      
      private const getAccountInfoRequest:ServerRequest = new ServerRequest("GetAccountInformation",null,true);
      
      private var videoPlayer:DCVideoPlayer;
      
      private var skipButton:UIButton;
      
      public var configOverrides:Array;
      
      public function TuxLoadingState(game:TuxWarsGame)
      {
         step = 10;
         maxValue = 60;
         var _loc2_:DCGame = DCGame;
         videoPlayer = new DCVideoPlayer(com.dchoc.game.DCGame._stage,640,360);
         super(game);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(getAccountInfoRequest);
         changeState(new TuxProjectDataLoadingSubState(tuxGame));
      }
      
      override public function exit() : void
      {
         if(videoPlayer)
         {
            videoPlayer.dispose();
            videoPlayer = null;
         }
         removeSkipButton();
         super.exit();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         var _loc2_:ServerResponse = Server.findResponse(getAccountInfoRequest.callId);
         if(_loc2_ && !state)
         {
            textField.setText(ProjectManager.getText("LOADING"));
            updateLoadingBar();
            TournamentManager.init(tuxGame);
            setUpTutorial(_loc2_.data);
            setUpIntro();
            InboxManager.updateFromAccountInfo({
               "incoming_neighbor_requests":_loc2_.data.incoming_neighbor_requests,
               "incoming_gift_requests":_loc2_.data.incoming_gift_requests
            });
            tuxGame.player.init(_loc2_.data);
            TournamentManager.triggerContentUpdate(true,true,true);
            if(_loc2_.data.custom_content)
            {
               configOverrides = _loc2_.data.custom_content.content is Array ? _loc2_.data.custom_content.content : [_loc2_.data.custom_content.content];
               ConfigUpdater.updateConfig(configOverrides);
            }
            setUpCRMMessages(_loc2_.data);
            tuxGame.setUpDailyNews(getDailyContent(_loc2_.data));
            tuxGame.setUpGiftingInfo(_loc2_.data.friends);
            Server.removeResponse(_loc2_);
            changeState(new TuxLoadingStartUpSharedAssetsSubState(tuxGame));
         }
         if(state is TuxLoadingFinishedSubState && !videoPlayer.playing)
         {
            tuxGame.loadingCompleted();
            tuxGame.changeState(new HomeState(tuxGame),true);
         }
      }
      
      private function setUpCRMMessages(data:Object) : void
      {
         var _loc3_:Array = getCRMMessages(data);
         for each(var message in _loc3_)
         {
            var _loc4_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.addPopup(new CRMMessagePopUpSubState(tuxGame,new CRMPopUpData(message.title,message.text,message.img,message.actionButton)));
         }
      }
      
      private function getCRMMessages(data:Object) : Array
      {
         return getMessages(data,"idle");
      }
      
      private function getDailyContent(data:Object) : Array
      {
         return getMessages(data,"init");
      }
      
      private function getMessages(data:Object, displayOn:String) : Array
      {
         var _loc4_:* = null;
         var _loc5_:Array = [];
         if(data.popup && data.popup.content)
         {
            _loc4_ = data.popup.content is Array ? data.popup.content : [data.popup.content];
            for each(var content in _loc4_)
            {
               if(content.display_on == displayOn)
               {
                  _loc5_.push(content);
               }
            }
         }
         return _loc5_;
      }
      
      public function sharedAssetsLoaded() : void
      {
         addSkipIntroButton();
      }
      
      private function skipMovie(event:MouseEvent) : void
      {
         videoPlayer.dispose();
         loadingScreen.visible = true;
         removeSkipButton();
      }
      
      private function setUpTutorial(data:Object) : void
      {
         var tutorialFlagFound:Boolean = false;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:Object = data.flags;
         if(_loc3_)
         {
            _loc4_ = _loc3_.flag is Array ? _loc3_.flag : [_loc3_.flag];
            for each(var flag in _loc4_)
            {
               if(flag.key == "Tutorial")
               {
                  Tutorial.setTutorial(flag.value,false);
                  tutorialFlagFound = true;
               }
               if(flag.key == "TutorialStep")
               {
                  _loc6_ = getTutorialStep(flag.value,data);
                  Tutorial.saveTutorialStep(_loc6_,false);
               }
            }
            if(!tutorialFlagFound)
            {
               Tutorial.setTutorial(true);
            }
         }
         else
         {
            Tutorial.setTutorial(true);
         }
      }
      
      private function getTutorialStep(step:String, data:Object) : String
      {
         var _loc3_:* = null;
         if(step == "TutorialCustomizationDone")
         {
            _loc3_ = data.items.item is Array ? data.items.item : [data.items.item];
            for each(var item in _loc3_)
            {
               if(item.item_id == "ClusterRocket")
               {
                  return "TutorialMatchPlayed";
               }
            }
         }
         return step;
      }
      
      private function setUpIntro() : void
      {
         var _loc1_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial && tuxwars.tutorial.Tutorial._tutorialStep == "TutorialCustomizationDone")
         {
            videoPlayer.play(Config.getIntroMovie());
            loadingScreen.visible = false;
            addSkipIntroButton();
         }
         else
         {
            loadingScreen.visible = true;
         }
      }
      
      private function addSkipIntroButton() : void
      {
         var _loc1_:* = null;
         var _loc2_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial && !skipButton)
         {
            _loc1_ = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","button_blue_medium");
            if(_loc1_)
            {
               skipButton = new UIButton(_loc1_);
               skipButton.setText(ProjectManager.getText("SKIP_BUTTON"));
               skipButton.setMouseClickFunction(skipMovie);
               var _loc3_:DCGame = DCGame;
               com.dchoc.game.DCGame._stage.addChild(skipButton.getDesignMovieClip());
               var _loc4_:DCGame = DCGame;
               skipButton.setX(Number(com.dchoc.game.DCGame._stage.stageWidth) - _loc1_.width - 10);
               var _loc5_:DCGame = DCGame;
               skipButton.setY(Number(com.dchoc.game.DCGame._stage.stageHeight) - _loc1_.height - 10);
            }
         }
      }
      
      private function removeSkipButton() : void
      {
         if(skipButton)
         {
            skipButton.getDesignMovieClip().parent.removeChild(skipButton.getDesignMovieClip());
            skipButton.dispose();
            skipButton = null;
         }
      }
      
      private function getDummyCustomContent() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push({"tables":{"table":{
            "name":"ItemPrice",
            "row":{
               "Id":"MegaNuke",
               "Premium":10
            }
         }}});
         return _loc1_;
      }
   }
}
