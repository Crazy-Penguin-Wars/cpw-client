package tuxwars.home.ui.screen.help
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.help.HelpLogic;
   import tuxwars.home.ui.logic.help.HelpReference;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.DarkBackgroundElementWindow;
   import tuxwars.utils.TuxUiUtils;
   
   public class HelpScreen extends TuxUIScreen implements IResourceLoaderURL
   {
       
      
      private const HELP_SCREEN:String = "popup_help";
      
      private var buttonClose:UIButton;
      
      private var buttonLeft:UIButton;
      
      private var buttonRight:UIButton;
      
      private var title:UIAutoTextField;
      
      private var subtitle:UIAutoTextField;
      
      private var description:UIAutoTextField;
      
      private var darkBackGround:DarkBackgroundElementWindow;
      
      public function HelpScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_help"));
         darkBackGround = new DarkBackgroundElementWindow(this._design,_game,null,null,true);
         darkBackGround.setVisible(true);
         buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeScreen);
         buttonLeft = TuxUiUtils.createButton(UIButton,this._design,"Button_Scroll_Left",scrollLeft);
         buttonRight = TuxUiUtils.createButton(UIButton,this._design,"Button_Scroll_Right",scrollRight);
         title = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Header") as TextField,"Help");
         subtitle = TuxUiUtils.createAutoTextFieldWithText(getDesignMovieClip().getChildByName("Text_Step") as TextField,"");
         description = TuxUiUtils.createAutoTextFieldWithText(getDesignMovieClip().getChildByName("Text_Message") as TextField,"");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         if(params != null)
         {
            update(helpLogic.getHelpPage(params));
         }
         else
         {
            update(helpLogic.getHelpPage("help_1"));
         }
      }
      
      private function update(helpReference:HelpReference) : void
      {
         subtitle.setText(helpReference.title);
         description.setText(helpReference.description);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         darkBackGround.dispose();
         darkBackGround = null;
         buttonClose.dispose();
         buttonClose = null;
      }
      
      private function closeScreen(event:MouseEvent) : void
      {
         close(_game.currentState.parent);
      }
      
      private function scrollLeft(event:MouseEvent) : void
      {
         update(helpLogic.prevPage);
      }
      
      private function scrollRight(event:MouseEvent) : void
      {
         update(helpLogic.nextPage);
      }
      
      private function get helpLogic() : HelpLogic
      {
         return logic;
      }
      
      public function disableRightButton() : void
      {
         buttonRight.setEnabled(false);
      }
      
      public function disableLeftButton() : void
      {
         buttonLeft.setEnabled(false);
      }
      
      public function enableRightButton() : void
      {
         buttonRight.setEnabled(true);
      }
      
      public function enableLeftButton() : void
      {
         buttonLeft.setEnabled(true);
      }
      
      public function getResourceUrl() : String
      {
         return helpLogic.pictureURL;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
   }
}
