package tuxwars.home.ui.screen.gifts
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.gifts.GiftLogic;
   import tuxwars.home.ui.logic.gifts.GiftManager;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.gifts.container.GiftContainers;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.utils.TuxUiUtils;
   
   public class GiftScreen extends TuxUIScreen
   {
       
      
      private const GIFT_SCREEN:String = "popup_gifts";
      
      private var buttonClose:UIButton;
      
      private var title:UIAutoTextField;
      
      private var objectContainer:ObjectContainer;
      
      public function GiftScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_gifts"));
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeScreen);
         title = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Header") as TextField,"Free_Gifts");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         objectContainer = new ObjectContainer(this._design,tuxGame,getSlotContent,"transition_slots_left","transition_slots_right",false);
         objectContainer.init(GiftManager.getGiftsShow());
      }
      
      private function getSlotContent(slotIndex:int, object:*, design:MovieClip) : *
      {
         return new GiftContainers(object,design,_game,params);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         buttonClose.dispose();
         buttonClose = null;
         objectContainer.dispose();
         objectContainer = null;
      }
      
      private function closeScreen(event:MouseEvent) : void
      {
         close();
      }
      
      private function get giftLogic() : GiftLogic
      {
         return logic;
      }
   }
}
