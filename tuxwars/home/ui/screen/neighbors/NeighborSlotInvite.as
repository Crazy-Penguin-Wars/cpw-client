package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.net.*;
   import tuxwars.utils.*;
   
   public class NeighborSlotInvite
   {
      private static const BUTTON_INVITE:String = "Button_Invite";
      
      private var buttonInvite:UIButton;
      
      private var _design:MovieClip;
      
      public function NeighborSlotInvite(param1:MovieClip)
      {
         super();
         this._design = param1;
         this.buttonInvite = TuxUiUtils.createButton(UIButton,param1,"Button_Invite",this.inviteCallback,"BUTTON_NEIGHBOR_INVITE");
         this.buttonInvite.setState("Down");
         this.buttonInvite.setState("Visible");
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.design.visible = param1;
      }
      
      public function refresh() : void
      {
      }
      
      public function get design() : MovieClip
      {
         return this._design;
      }
      
      private function inviteCallback(param1:MouseEvent) : void
      {
         NeighborService.sendNeighborRequestSelectFriends("INVITE_NEIGHBOR_TITLE","INVITE_NEIGHBOR_MESSAGE","NeighborsScreen");
      }
   }
}

