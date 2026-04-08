package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.states.gifts.*;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.home.ui.screen.inbox.*;
   import tuxwars.utils.*;
   
   public class InboxNoGifts extends InboxCore
   {
      private var buttonSendGifts:UIButton;
      
      public function InboxNoGifts(param1:RequestData, param2:MovieClip, param3:UIComponent = null)
      {
         super(param1,param2,"No_Gifts","No_Gifts_desc",null,null,param3);
         this.buttonSendGifts = TuxUiUtils.createButton(UIButton,param2,"Button_Gifts",this.sendGifts,"Send_Gift");
      }
      
      public function sendGifts(param1:MouseEvent) : void
      {
         MessageCenter.sendMessage("InboxUpdateCounter",InboxManager.messageCount);
         (parent as InboxScreen).tuxGame.homeState.changeState(new GiftState((parent as InboxScreen).tuxGame));
      }
   }
}

