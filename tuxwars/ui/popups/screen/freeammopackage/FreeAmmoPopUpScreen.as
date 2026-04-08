package tuxwars.ui.popups.screen.freeammopackage
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.gifts.*;
   import tuxwars.home.states.money.*;
   import tuxwars.ui.popups.logic.freeammopackage.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.*;
   
   public class FreeAmmoPopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      private static const IMAGE_CONTAINER:String = "Container_Image";
      
      private static const BUTTON_GIFTS:String = "Button_SendGifts";
      
      private static const BUTTON_MONEY:String = "Button_GetCash";
      
      private var loader:URLResourceLoader;
      
      private var _sendGift:UIButton;
      
      private var _getMoney:UIButton;
      
      public function FreeAmmoPopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_free_ammo_package");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         headerField.setText(this.freeAmmoLogic.headerText);
         messageField.setText(this.freeAmmoLogic.messageText);
         if(this.freeAmmoLogic.picture)
         {
            this.loader = ResourceLoaderURL.getInstance().load(this);
         }
         this._getMoney = TuxUiUtils.createButton(UIButton,this._design,"Button_GetCash",this.getMoneyPressed,"BUTTON_MONEY");
         this._sendGift = TuxUiUtils.createButton(UIButton,this._design,"Button_SendGifts",this.sendGiftPressed,"BUTTON_GIFTS");
      }
      
      public function getResourceUrl() : String
      {
         return this.freeAmmoLogic.picture;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function get freeAmmoLogic() : FreeAmmoPopUpLogic
      {
         return logic as FreeAmmoPopUpLogic;
      }
      
      private function getMoneyPressed(param1:MouseEvent) : void
      {
         _game.homeState.changeState(new MoneyState(_game,"popup_get_cash_new"));
         exit();
      }
      
      private function sendGiftPressed(param1:MouseEvent) : void
      {
         _game.homeState.changeState(new GiftState(_game));
         exit();
      }
   }
}

