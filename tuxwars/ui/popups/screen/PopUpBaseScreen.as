package tuxwars.ui.popups.screen
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.ui.popups.logic.*;
   import tuxwars.utils.*;
   
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
      
      public function PopUpBaseScreen(param1:TuxWarsGame, param2:String, param3:String)
      {
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF(param2,param3);
         this.darkBackGround = new DarkBackgroundElementWindow(_loc4_,param1,null,null,true);
         this.darkBackGround.setVisible(true);
         super(param1,_loc4_);
         if(_loc4_["Button_Close"])
         {
            this._closeButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Close",this.closePressed);
         }
         if(_loc4_["Button_Ok"])
         {
            this._okButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Ok",this.okPressed,"BUTTON_OK");
         }
         this.headerField.setTextField(_loc4_.Text_Header);
         this.headerField.setText("");
         if(_loc4_.Text_Message)
         {
            this.messageField.setTextField(_loc4_.Text_Message);
            this.messageField.setText("");
         }
      }
      
      public function get closeButton() : UIButton
      {
         return this._closeButton;
      }
      
      public function get okButton() : UIButton
      {
         return this._okButton;
      }
      
      protected function closePressed(param1:MouseEvent) : void
      {
         this.exit();
      }
      
      protected function okPressed(param1:MouseEvent) : void
      {
         this.exit();
      }
      
      public function exit() : void
      {
         this.popUpLogic.exit();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._closeButton)
         {
            this._closeButton.dispose();
            this._closeButton = null;
         }
         if(this._okButton)
         {
            this._okButton.dispose();
            this._okButton = null;
         }
         this.darkBackGround.dispose();
         this.darkBackGround = null;
      }
      
      private function get popUpLogic() : PopUpBaseLogic
      {
         return logic as PopUpBaseLogic;
      }
   }
}

