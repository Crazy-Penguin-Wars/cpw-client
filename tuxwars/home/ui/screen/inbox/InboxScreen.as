package tuxwars.home.ui.screen.inbox
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.inbox.InboxLogic;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.home.ui.screen.inbox.container.InboxContainers;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.utils.TuxUiUtils;
   
   public class InboxScreen extends TuxUIScreen
   {
       
      
      private const GIFT_SCREEN:String = "popup_inbox";
      
      private var buttonClose:UIButton;
      
      private var title:UIAutoTextField;
      
      private var objectContainer:ObjectContainer;
      
      public function InboxScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_inbox"));
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",closeScreen);
         title = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Header") as TextField,"Inbox");
         objectContainer = new ObjectContainer(this._design,game,getSlotContent,"transition_slots_left","transition_slots_right",false);
         MessageCenter.addListener("InboxContentUpdate",updateContent);
         updateContent(null);
      }
      
      private function updateContent(msg:Message) : void
      {
         objectContainer.init(InboxManager.messages);
      }
      
      public function getSlotContent(slotIndex:int, object:*, design:MovieClip) : *
      {
         return new InboxContainers(object,design,tuxGame,this);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         MessageCenter.removeListener("InboxContentUpdate",updateContent);
         super.dispose();
         buttonClose.dispose();
         buttonClose = null;
         objectContainer.dispose();
         objectContainer = null;
      }
      
      private function closeScreen(event:MouseEvent) : void
      {
         MessageCenter.sendMessage("InboxUpdateCounter",InboxManager.messageCount);
         close();
      }
      
      private function get inboxLogic() : InboxLogic
      {
         return logic;
      }
   }
}
