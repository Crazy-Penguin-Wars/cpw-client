package tuxwars.ui.containers.slotitem.uicontainers.container
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.home.states.vip.VIPState;
   import tuxwars.net.CRMService;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class MembershipButtonContainer extends ButtonContainer
   {
       
      
      public function MembershipButtonContainer(design:MovieClip, parent:UIComponent = null)
      {
         super(design,parent);
         buttonText = ProjectManager.getText("ITEM_GET_MEMBERSHIP_BUTTON");
      }
      
      override public function setVisible(value:Boolean) : void
      {
         super.setVisible(value);
         button.setVisible(value);
      }
      
      override protected function buttonPressed(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Button_Pressed","Clicked","VIP Locked");
         SlotElement(parent).game.currentState.changeState(new VIPState(SlotElement(parent).game));
      }
   }
}
