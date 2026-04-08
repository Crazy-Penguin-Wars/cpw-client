package tuxwars.home.ui.screen.inbox
{
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.home.ui.screen.inbox.container.*;
   import tuxwars.ui.components.*;
   import tuxwars.utils.*;
   
   public class InboxScreen extends TuxUIScreen
   {
      private const GIFT_SCREEN:String = "popup_inbox";
      
      private var buttonClose:UIButton;
      
      private var title:UIAutoTextField;
      
      private var objectContainer:ObjectContainer;
      
      public function InboxScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/top_bar_popups.swf","popup_inbox"));
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         this.buttonClose = TuxUiUtils.createButton(UIButton,this._design,"Button_Close",this.closeScreen);
         this.title = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Header") as TextField,"Inbox");
         this.objectContainer = new ObjectContainer(this._design,param1,this.getSlotContent,"transition_slots_left","transition_slots_right",false);
         MessageCenter.addListener("InboxContentUpdate",this.updateContent);
         this.updateContent(null);
      }
      
      private function updateContent(param1:Message) : void
      {
         this.objectContainer.init(InboxManager.messages);
      }
      
      public function getSlotContent(param1:int, param2:*, param3:MovieClip) : *
      {
         return new InboxContainers(param2,param3,tuxGame,this);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         MessageCenter.removeListener("InboxContentUpdate",this.updateContent);
         super.dispose();
         this.buttonClose.dispose();
         this.buttonClose = null;
         this.objectContainer.dispose();
         this.objectContainer = null;
      }
      
      private function closeScreen(param1:MouseEvent) : void
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

