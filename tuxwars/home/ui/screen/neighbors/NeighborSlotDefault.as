package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.friends.Friend;
   import com.dchoc.messages.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.gifts.*;
   import tuxwars.utils.*;
   
   public class NeighborSlotDefault extends NeighborSlot
   {
      private static const BUTTON_SEND:String = "Button_Send";
      
      private static const BUTTON_REMOVE:String = "Button_Remove";
      
      private var sendButton:UIButton;
      
      private var removeButton:UIButton;
      
      public function NeighborSlotDefault(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this.sendButton = TuxUiUtils.createButton(UIButton,param1,"Button_Send",this.sendCallback,"BUTTON_NEIGHBOR_SEND");
         this.removeButton = TuxUiUtils.createButton(UIButton,param1,"Button_Remove",this.removeCallback,"BUTTON_NEIGHBOR_REMOVE");
      }
      
      override public function setFriend(param1:Friend) : void
      {
         super.setFriend(param1);
         if(param1)
         {
            design.visible = true;
         }
         else
         {
            design.visible = false;
         }
      }
      
      private function sendCallback(param1:MouseEvent) : void
      {
         if(getFriend())
         {
            tuxWarsGame.homeState.changeState(new GiftState(tuxWarsGame,getFriend().platformId));
         }
      }
      
      private function removeCallback(param1:MouseEvent) : void
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

