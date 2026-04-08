package tuxwars.home.ui.screen.help
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.help.HelpLogic;
   import tuxwars.home.ui.logic.help.HelpReference;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.utils.*;
   
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
      
      public function HelpScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_help"));
         this.darkBackGround = new DarkBackgroundElementWindow(this._design,_game,null,null,true);
         this.darkBackGround.setVisible(true);
         this.buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",this.closeScreen);
         this.buttonLeft = TuxUiUtils.createButton(UIButton,this._design,"Button_Scroll_Left",this.scrollLeft);
         this.buttonRight = TuxUiUtils.createButton(UIButton,this._design,"Button_Scroll_Right",this.scrollRight);
         this.title = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Header") as TextField,"Help");
         this.subtitle = TuxUiUtils.createAutoTextFieldWithText(getDesignMovieClip().getChildByName("Text_Step") as TextField,"");
         this.description = TuxUiUtils.createAutoTextFieldWithText(getDesignMovieClip().getChildByName("Text_Message") as TextField,"");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         if(param1 != null)
         {
            this.update(this.helpLogic.getHelpPage(param1));
         }
         else
         {
            this.update(this.helpLogic.getHelpPage("help_1"));
         }
      }
      
      private function update(param1:HelpReference) : void
      {
         this.subtitle.setText(param1.title);
         this.description.setText(param1.description);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.darkBackGround.dispose();
         this.darkBackGround = null;
         this.buttonClose.dispose();
         this.buttonClose = null;
      }
      
      private function closeScreen(param1:MouseEvent) : void
      {
         close(_game.currentState.parent);
      }
      
      private function scrollLeft(param1:MouseEvent) : void
      {
         this.update(this.helpLogic.prevPage);
      }
      
      private function scrollRight(param1:MouseEvent) : void
      {
         this.update(this.helpLogic.nextPage);
      }
      
      private function get helpLogic() : HelpLogic
      {
         return logic;
      }
      
      public function disableRightButton() : void
      {
         this.buttonRight.setEnabled(false);
      }
      
      public function disableLeftButton() : void
      {
         this.buttonLeft.setEnabled(false);
      }
      
      public function enableRightButton() : void
      {
         this.buttonRight.setEnabled(true);
      }
      
      public function enableLeftButton() : void
      {
         this.buttonLeft.setEnabled(true);
      }
      
      public function getResourceUrl() : String
      {
         return this.helpLogic.pictureURL;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
   }
}

