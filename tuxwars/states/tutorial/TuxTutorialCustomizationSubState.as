package tuxwars.states.tutorial
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.equipment.EquipmentUISubState;
   import tuxwars.home.ui.screen.equipment.EquipmentScreen;
   import tuxwars.net.CRMService;
   
   public class TuxTutorialCustomizationSubState extends TuxTutorialSubState
   {
       
      
      private var faceClicked:Boolean;
      
      public function TuxTutorialCustomizationSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_CUSTOMIZATION");
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:EquipmentScreen = equipmentScreen;
         addTutorialArrow("bottom",_loc1_._design.Content.Content_Equipment.Container_Arrow);
         equipmentScreen.subTabGroup.getButtonAt(1).setEnabled(false);
         equipmentScreen.subTabGroup.getButtonAt(2).setEnabled(false);
         MessageCenter.addListener("EquipItem",itemEquipped);
         MessageCenter.addListener("UnequipItem",itemunEquipped);
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.removeListener("EquipItem",itemEquipped);
         MessageCenter.removeListener("UnequipItem",itemunEquipped);
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","CustomizationClose","Close_customization");
      }
      
      private function get equipmentScreen() : EquipmentScreen
      {
         return EquipmentUISubState(parent).screenHandler.screen as EquipmentScreen;
      }
      
      private function itemunEquipped(msg:Message) : void
      {
         handleClick();
      }
      
      private function itemEquipped(msg:Message) : void
      {
         handleClick();
      }
      
      private function handleClick() : void
      {
         if(!faceClicked)
         {
            removeTutorialArrow();
            var _loc1_:EquipmentScreen = equipmentScreen;
            addTutorialArrow("left",_loc1_._design.Container_Arrow);
            setText(ProjectManager.getText("TUTORIAL_CUSTOMIZATION_CLOSE"));
            faceClicked = true;
         }
      }
   }
}
