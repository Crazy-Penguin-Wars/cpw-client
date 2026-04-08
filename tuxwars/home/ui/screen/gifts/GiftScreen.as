package tuxwars.home.ui.screen.gifts
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.gifts.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.gifts.container.*;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
   public class GiftScreen extends TuxUIScreen
   {
      private const GIFT_SCREEN:String = "popup_gifts";
      
      private var buttonClose:UIButton;
      
      private var title:UIAutoTextField;
      
      private var objectContainer:ObjectContainer;
      
      public function GiftScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_gifts"));
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         this.buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",this.closeScreen);
         this.title = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Header") as TextField,"Free_Gifts");
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.objectContainer = new ObjectContainer(this._design,tuxGame,this.getSlotContent,"transition_slots_left","transition_slots_right",false);
         this.objectContainer.init(GiftManager.getGiftsShow());
      }
      
      private function getSlotContent(param1:int, param2:*, param3:MovieClip) : *
      {
         return new GiftContainers(param2,param3,_game,params);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         this.buttonClose.dispose();
         this.buttonClose = null;
         this.objectContainer.dispose();
         this.objectContainer = null;
      }
      
      private function closeScreen(param1:MouseEvent) : void
      {
         close();
      }
      
      private function get giftLogic() : GiftLogic
      {
         return logic;
      }
   }
}

