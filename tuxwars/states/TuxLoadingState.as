package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.media.*;
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.tournament.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.logic.crm.*;
   import tuxwars.ui.popups.states.crm.*;
   
   public class TuxLoadingState extends TuxLoadingScreenState
   {
      private const getAccountInfoRequest:ServerRequest = new ServerRequest("GetAccountInformation",null,true);
      
      private var videoPlayer:DCVideoPlayer;
      
      private var skipButton:UIButton;
      
      public var configOverrides:Array;
      
      public function TuxLoadingState(param1:TuxWarsGame)
      {
         step = 10;
         maxValue = 60;
         this.videoPlayer = new DCVideoPlayer(DCGame.getStage(),640,360);
         super(param1);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(this.getAccountInfoRequest);
         changeState(new TuxProjectDataLoadingSubState(tuxGame));
      }
      
      override public function exit() : void
      {
         if(this.videoPlayer)
         {
            this.videoPlayer.dispose();
            this.videoPlayer = null;
         }
         this.removeSkipButton();
         super.exit();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         var _loc2_:ServerResponse = Server.findResponse(this.getAccountInfoRequest.callId);
         if(Boolean(_loc2_) && !state)
         {
            textField.setText(ProjectManager.getText("LOADING"));
            updateLoadingBar();
            TournamentManager.init(tuxGame);
            this.setUpTutorial(_loc2_.data);
            this.setUpIntro();
            InboxManager.updateFromAccountInfo({
               "incoming_neighbor_requests":_loc2_.data.incoming_neighbor_requests,
               "incoming_gift_requests":_loc2_.data.incoming_gift_requests
            });
            tuxGame.player.init(_loc2_.data);
            TournamentManager.triggerContentUpdate(true,true,true);
            if(_loc2_.data.custom_content)
            {
               this.configOverrides = _loc2_.data.custom_content.content is Array ? _loc2_.data.custom_content.content : [_loc2_.data.custom_content.content];
               ConfigUpdater.updateConfig(this.configOverrides);
            }
            this.setUpCRMMessages(_loc2_.data);
            tuxGame.setUpDailyNews(this.getDailyContent(_loc2_.data));
            tuxGame.setUpGiftingInfo(_loc2_.data.friends);
            Server.removeResponse(_loc2_);
            changeState(new TuxLoadingStartUpSharedAssetsSubState(tuxGame));
         }
         if(state is TuxLoadingFinishedSubState && !this.videoPlayer.playing)
         {
            tuxGame.loadingCompleted();
            tuxGame.changeState(new HomeState(tuxGame),true);
         }
      }
      
      private function setUpCRMMessages(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = this.getCRMMessages(param1);
         for each(_loc3_ in _loc2_)
         {
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.addPopup(new CRMMessagePopUpSubState(tuxGame,new CRMPopUpData(_loc3_.title,_loc3_.text,_loc3_.img,_loc3_.actionButton)));
         }
      }
      
      private function getCRMMessages(param1:Object) : Array
      {
         return this.getMessages(param1,"idle");
      }
      
      private function getDailyContent(param1:Object) : Array
      {
         return this.getMessages(param1,"init");
      }
      
      private function getMessages(param1:Object, param2:String) : Array
      {
         var _loc5_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:Array = [];
         if(Boolean(param1.popup) && Boolean(param1.popup.content))
         {
            _loc3_ = param1.popup.content is Array ? param1.popup.content : [param1.popup.content];
            for each(_loc5_ in _loc3_)
            {
               if(_loc5_.display_on == param2)
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         return _loc4_;
      }
      
      public function sharedAssetsLoaded() : void
      {
         this.addSkipIntroButton();
      }
      
      private function skipMovie(param1:MouseEvent) : void
      {
         this.videoPlayer.dispose();
         loadingScreen.visible = true;
         this.removeSkipButton();
      }
      
      private function setUpTutorial(param1:Object) : void
      {
         var _loc6_:* = undefined;
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Object = param1.flags;
         if(_loc5_)
         {
            _loc3_ = _loc5_.flag is Array ? _loc5_.flag : [_loc5_.flag];
            for each(_loc6_ in _loc3_)
            {
               if(_loc6_.key == "Tutorial")
               {
                  Tutorial.setTutorial(_loc6_.value,false);
                  _loc2_ = true;
               }
               if(_loc6_.key == "TutorialStep")
               {
                  _loc4_ = this.getTutorialStep(_loc6_.value,param1);
                  Tutorial.saveTutorialStep(_loc4_,false);
               }
            }
            if(!_loc2_)
            {
               Tutorial.setTutorial(true);
            }
         }
         else
         {
            Tutorial.setTutorial(true);
         }
      }
      
      private function getTutorialStep(param1:String, param2:Object) : String
      {
         var _loc4_:* = undefined;
         var _loc3_:Array = null;
         if(param1 == "TutorialCustomizationDone")
         {
            _loc3_ = param2.items.item is Array ? param2.items.item : [param2.items.item];
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.item_id == "ClusterRocket")
               {
                  return "TutorialMatchPlayed";
               }
            }
         }
         return param1;
      }
      
      private function setUpIntro() : void
      {
         if(Boolean(Tutorial._tutorial) && Tutorial._tutorialStep == "TutorialCustomizationDone")
         {
            this.videoPlayer.play(Config.getIntroMovie());
            loadingScreen.visible = false;
            this.addSkipIntroButton();
         }
         else
         {
            loadingScreen.visible = true;
         }
      }
      
      private function addSkipIntroButton() : void
      {
         var _loc1_:MovieClip = null;
         if(Boolean(Tutorial._tutorial) && !this.skipButton)
         {
            _loc1_ = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","button_blue_medium");
            if(_loc1_)
            {
               this.skipButton = new UIButton(_loc1_);
               this.skipButton.setText(ProjectManager.getText("SKIP_BUTTON"));
               this.skipButton.setMouseClickFunction(this.skipMovie);
               DCGame.getStage().addChild(this.skipButton.getDesignMovieClip());
               this.skipButton.setX(DCGame.getStage().stageWidth - _loc1_.width - 10);
               this.skipButton.setY(DCGame.getStage().stageHeight - _loc1_.height - 10);
            }
         }
      }
      
      private function removeSkipButton() : void
      {
         if(this.skipButton)
         {
            this.skipButton.getDesignMovieClip().parent.removeChild(this.skipButton.getDesignMovieClip());
            this.skipButton.dispose();
            this.skipButton = null;
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

