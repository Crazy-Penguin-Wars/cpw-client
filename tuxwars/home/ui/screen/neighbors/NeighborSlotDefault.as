package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.gifts.GiftState;
   import tuxwars.utils.TuxUiUtils;
   
   public class NeighborSlotDefault extends NeighborSlot
   {
      
      private static const BUTTON_SEND:String = "Button_Send";
      
      private static const BUTTON_REMOVE:String = "Button_Remove";
       
      
      private var sendButton:UIButton;
      
      private var removeButton:UIButton;
      
      public function NeighborSlotDefault(design:MovieClip, tuxGame:TuxWarsGame)
      {
         super(design,tuxGame);
         sendButton = TuxUiUtils.createButton(UIButton,design,"Button_Send",sendCallback,"BUTTON_NEIGHBOR_SEND");
         removeButton = TuxUiUtils.createButton(UIButton,design,"Button_Remove",removeCallback,"BUTTON_NEIGHBOR_REMOVE");
      }
      
      override public function setFriend(f:Friend) : void
      {
         super.setFriend(f);
         if(f)
         {
            design.visible = true;
         }
         else
         {
            design.visible = false;
         }
      }
      
      private function sendCallback(event:MouseEvent) : void
      {
         if(getFriend())
         {
            tuxWarsGame.homeState.changeState(new GiftState(tuxWarsGame,getFriend().platformId));
         }
      }
      
      private function removeCallback(event:MouseEvent) : void
      {
         if(!getFriend())
         {
            return;
         }
         serverMessage = new Message("NeighbourRemove",getFriend().id);
         MessageCenter.sendMessage("NeighbourRemove",serverMessage);
      }
   }
}
