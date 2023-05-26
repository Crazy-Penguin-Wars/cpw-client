package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.states.gifts.GiftState;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.home.ui.logic.inbox.RequestData;
   import tuxwars.home.ui.screen.inbox.InboxScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class InboxNoGifts extends InboxCore
   {
       
      
      private var buttonSendGifts:UIButton;
      
      public function InboxNoGifts(requestDataObj:RequestData, design:MovieClip, parent:UIComponent = null)
      {
         super(requestDataObj,design,"No_Gifts","No_Gifts_desc",null,null,parent);
         buttonSendGifts = TuxUiUtils.createButton(UIButton,design,"Button_Gifts",sendGifts,"Send_Gift");
      }
      
      public function sendGifts(event:MouseEvent) : void
      {
         MessageCenter.sendMessage("InboxUpdateCounter",InboxManager.messageCount);
         (parent as InboxScreen).tuxGame.homeState.changeState(new GiftState((parent as InboxScreen).tuxGame));
      }
   }
}
