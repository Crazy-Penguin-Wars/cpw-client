package tuxwars.ui.popups.screen.freeammopackage
{
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.gifts.GiftState;
   import tuxwars.home.states.money.MoneyState;
   import tuxwars.ui.popups.logic.freeammopackage.FreeAmmoPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class FreeAmmoPopUpScreen extends PopUpBaseScreen implements IResourceLoaderURL
   {
      
      private static const IMAGE_CONTAINER:String = "Container_Image";
      
      private static const BUTTON_GIFTS:String = "Button_SendGifts";
      
      private static const BUTTON_MONEY:String = "Button_GetCash";
       
      
      private var loader:URLResourceLoader;
      
      private var _sendGift:UIButton;
      
      private var _getMoney:UIButton;
      
      public function FreeAmmoPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_free_ammo_package");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         headerField.setText(freeAmmoLogic.headerText);
         messageField.setText(freeAmmoLogic.messageText);
         if(freeAmmoLogic.picture)
         {
            loader = ResourceLoaderURL.getInstance().load(this);
         }
         _getMoney = TuxUiUtils.createButton(UIButton,this._design,"Button_GetCash",getMoneyPressed,"BUTTON_MONEY");
         _sendGift = TuxUiUtils.createButton(UIButton,this._design,"Button_SendGifts",sendGiftPressed,"BUTTON_GIFTS");
      }
      
      public function getResourceUrl() : String
      {
         return freeAmmoLogic.picture;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return getDesignMovieClip().getChildByName("Container_Image") as MovieClip;
      }
      
      private function get freeAmmoLogic() : FreeAmmoPopUpLogic
      {
         return logic as FreeAmmoPopUpLogic;
      }
      
      private function getMoneyPressed(event:MouseEvent) : void
      {
         _game.homeState.changeState(new MoneyState(_game,"popup_get_cash_new"));
         exit();
      }
      
      private function sendGiftPressed(event:MouseEvent) : void
      {
         _game.homeState.changeState(new GiftState(_game));
         exit();
      }
   }
}
