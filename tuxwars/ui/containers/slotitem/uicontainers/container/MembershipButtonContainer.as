package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.states.vip.*;
   import tuxwars.net.*;
   import tuxwars.ui.containers.slotitem.*;
   
   public class MembershipButtonContainer extends ButtonContainer
   {
      public function MembershipButtonContainer(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1,param2);
         buttonText = ProjectManager.getText("ITEM_GET_MEMBERSHIP_BUTTON");
      }
      
      override public function setVisible(param1:Boolean) : void
      {
         super.setVisible(param1);
         button.setVisible(param1);
      }
      
      override protected function buttonPressed(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Button_Pressed","Clicked","VIP Locked");
         SlotElement(parent).game.currentState.changeState(new VIPState(SlotElement(parent).game));
      }
   }
}

