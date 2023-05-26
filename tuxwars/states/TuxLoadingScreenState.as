package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.progress.UIProgressIndicator;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.net.CRMService;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function TuxLoadingScreenState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
         loadingScreen = Config.getLoadingScreen();
         hideErrorPopup();
         progressBar = new UIProgressIndicator(loadingScreen.getChildByName("Slider_Loading") as MovieClip,0,maxValue);
         textField = TuxUiUtils.createAutoTextFieldWithText(loadingScreen.getChildByName("Text") as TextField,"");
      }
      
      override public function enter() : void
      {
         super.enter();
         DCUtils.centerClip(loadingScreen);
         DCGame.getMainMovieClip().addChild(loadingScreen);
      }
      
      override public function exit() : void
      {
         super.exit();
         DCGame.getMainMovieClip().removeChild(loadingScreen);
         progressBar.dispose();
         progressBar = null;
         loadingScreen = null;
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         progressBar.logicUpdate(deltaTime);
      }
      
      protected function updateLoadingBar(msg:Message = null) : void
      {
         progressValue += step;
         progressBar.setValue(progressValue);
         LogUtils.log("Progress bar value: " + progressValue + "/" + maxValue,this,0,"LoadResource",false,false,true);
      }
      
      public function hideErrorPopup() : void
      {
         var clip:MovieClip = loadingScreen.getChildByName("Popup_Error") as MovieClip;
         if(clip)
         {
            clip.visible = false;
         }
      }
      
      public function error(code:String, description:String) : void
      {
         var clip:MovieClip = loadingScreen.getChildByName("Popup_Error") as MovieClip;
         if(clip)
         {
            clip.visible = true;
            TextField(clip.getChildByName("Text_Header")).text = ProjectManager.getText("ERROR_HEADER");
            TextField(clip.getChildByName("Text_Message")).text = ProjectManager.getText("CONNECTION_ERROR_BODY");
         }
         CRMService.sendEvent("Game Error","Client",code,"Unspecified");
      }
   }
}
