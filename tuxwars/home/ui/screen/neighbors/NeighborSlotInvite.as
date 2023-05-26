package tuxwars.home.ui.screen.neighbors
{
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.net.NeighborService;
   import tuxwars.utils.TuxUiUtils;
   
   public class NeighborSlotInvite
   {
      
      private static const BUTTON_INVITE:String = "Button_Invite";
       
      
      private var buttonInvite:UIButton;
      
      private var _design:MovieClip;
      
      public function NeighborSlotInvite(design:MovieClip)
      {
         super();
         _design = design;
         buttonInvite = TuxUiUtils.createButton(UIButton,design,"Button_Invite",inviteCallback,"BUTTON_NEIGHBOR_INVITE");
         buttonInvite.setState("Down");
         buttonInvite.setState("Visible");
      }
      
      public function setVisible(value:Boolean) : void
      {
         design.visible = value;
      }
      
      public function refresh() : void
      {
      }
      
      public function get design() : MovieClip
      {
         return _design;
      }
      
      private function inviteCallback(event:MouseEvent) : void
      {
         NeighborService.sendNeighborRequestSelectFriends("INVITE_NEIGHBOR_TITLE","INVITE_NEIGHBOR_MESSAGE","NeighborsScreen");
      }
   }
}
