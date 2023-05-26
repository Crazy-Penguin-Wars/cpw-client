package tuxwars.ui.popups.screen
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.DarkBackgroundElementWindow;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.utils.TuxUiUtils;
   
   public class PopUpBaseScreen extends TuxUIScreen
   {
      
      private static const BUTTON_CLOSE:String = "Button_Close";
      
      private static const BUTTON_OK:String = "Button_Ok";
      
      private static const TEXT_MESSAGE:String = "Text_Message";
      
      private static const TEXT_HEADER:String = "Text_Header";
       
      
      protected const headerField:UIAutoTextField = new UIAutoTextField();
      
      protected const messageField:UIAutoTextField = new UIAutoTextField();
      
      private var _okButton:UIButton;
      
      private var _closeButton:UIButton;
      
      private var darkBackGround:DarkBackgroundElementWindow;
      
      public function PopUpBaseScreen(game:TuxWarsGame, swf:String, exportName:String)
      {
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF(swf,exportName);
         darkBackGround = new DarkBackgroundElementWindow(_loc4_,game,null,null,true);
         darkBackGround.setVisible(true);
         super(game,_loc4_);
         if(_loc4_["Button_Close"])
         {
            _closeButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Close",closePressed);
         }
         if(_loc4_["Button_Ok"])
         {
            _okButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Ok",okPressed,"BUTTON_OK");
         }
         headerField.setTextField(_loc4_.Text_Header);
         headerField.setText("");
         if(_loc4_.Text_Message)
         {
            messageField.setTextField(_loc4_.Text_Message);
            messageField.setText("");
         }
      }
      
      public function get closeButton() : UIButton
      {
         return _closeButton;
      }
      
      public function get okButton() : UIButton
      {
         return _okButton;
      }
      
      protected function closePressed(event:MouseEvent) : void
      {
         exit();
      }
      
      protected function okPressed(event:MouseEvent) : void
      {
         exit();
      }
      
      public function exit() : void
      {
         popUpLogic.exit();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_closeButton)
         {
            _closeButton.dispose();
            _closeButton = null;
         }
         if(_okButton)
         {
            _okButton.dispose();
            _okButton = null;
         }
         darkBackGround.dispose();
         darkBackGround = null;
      }
      
      private function get popUpLogic() : PopUpBaseLogic
      {
         return logic as PopUpBaseLogic;
      }
   }
}
