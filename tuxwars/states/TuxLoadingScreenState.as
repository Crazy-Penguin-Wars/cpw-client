package tuxwars.states
{
   import com.dchoc.game.*;
   import com.dchoc.messages.Message;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.progress.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.*;
   import tuxwars.utils.*;
   
   public class TuxLoadingScreenState extends TuxState
   {
      private static const PROGRESS_BAR:String = "Slider_Loading";
      
      private static const TEXT:String = "Text";
      
      private static const POPUP_ERROR:String = "Popup_Error";
      
      private static const POPUP_ERROR_TITLE:String = "Text_Header";
      
      private static const POPUP_ERROR_TEXT:String = "Text_Message";
      
      protected var step:int;
      
      protected var maxValue:int;
      
      protected var loadingScreen:DisplayObjectContainer;
      
      protected var progressBar:UIProgressIndicator;
      
      protected var textField:UIAutoTextField;
      
      protected var progressValue:int;
      
      public function TuxLoadingScreenState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
         trace("until here it works");
         this.loadingScreen = Config.getLoadingScreen();
         trace("but here?");
         this.hideErrorPopup();
         this.progressBar = new UIProgressIndicator(this.loadingScreen.getChildByName("Slider_Loading") as MovieClip,0,this.maxValue);
         this.textField = TuxUiUtils.createAutoTextFieldWithText(this.loadingScreen.getChildByName("Text") as TextField,"");
      }
      
      override public function enter() : void
      {
         super.enter();
         DCUtils.centerClip(this.loadingScreen);
         DCGame.getMainMovieClip().addChild(this.loadingScreen);
      }
      
      override public function exit() : void
      {
         super.exit();
         DCGame.getMainMovieClip().removeChild(this.loadingScreen);
         this.progressBar.dispose();
         this.progressBar = null;
         this.loadingScreen = null;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this.progressBar.logicUpdate(param1);
      }
      
      protected function updateLoadingBar(param1:Message = null) : void
      {
         this.progressValue += this.step;
         this.progressBar.setValue(this.progressValue);
         LogUtils.log("Progress bar value: " + this.progressValue + "/" + this.maxValue,this,0,"LoadResource",false,false,true);
      }
      
      public function hideErrorPopup() : void
      {
         var _loc1_:MovieClip = this.loadingScreen.getChildByName("Popup_Error") as MovieClip;
         if(_loc1_)
         {
            _loc1_.visible = false;
         }
      }
      
      public function error(param1:String, param2:String) : void
      {
         var _loc3_:MovieClip = this.loadingScreen.getChildByName("Popup_Error") as MovieClip;
         if(_loc3_)
         {
            _loc3_.visible = true;
            TextField(_loc3_.getChildByName("Text_Header")).text = ProjectManager.getText("ERROR_HEADER");
            TextField(_loc3_.getChildByName("Text_Message")).text = ProjectManager.getText("CONNECTION_ERROR_BODY");
         }
         CRMService.sendEvent("Game Error","Client",param1,"Unspecified");
      }
   }
}

