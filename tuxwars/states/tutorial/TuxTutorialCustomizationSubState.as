package tuxwars.states.tutorial
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.equipment.*;
   import tuxwars.home.ui.screen.equipment.*;
   import tuxwars.net.*;
   
   public class TuxTutorialCustomizationSubState extends TuxTutorialSubState
   {
      private var faceClicked:Boolean;
      
      public function TuxTutorialCustomizationSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_CUSTOMIZATION");
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:EquipmentScreen = this.equipmentScreen;
         addTutorialArrow("bottom",_loc1_._design.Content.Content_Equipment.Container_Arrow);
         this.equipmentScreen.subTabGroup.getButtonAt(1).setEnabled(false);
         this.equipmentScreen.subTabGroup.getButtonAt(2).setEnabled(false);
         MessageCenter.addListener("EquipItem",this.itemEquipped);
         MessageCenter.addListener("UnequipItem",this.itemunEquipped);
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.removeListener("EquipItem",this.itemEquipped);
         MessageCenter.removeListener("UnequipItem",this.itemunEquipped);
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","CustomizationClose","Close_customization");
      }
      
      private function get equipmentScreen() : EquipmentScreen
      {
         return EquipmentUISubState(parent).screenHandler.screen as EquipmentScreen;
      }
      
      private function itemunEquipped(param1:Message) : void
      {
         this.handleClick();
      }
      
      private function itemEquipped(param1:Message) : void
      {
         this.handleClick();
      }
      
      private function handleClick() : void
      {
         var _loc1_:EquipmentScreen = null;
         if(!this.faceClicked)
         {
            removeTutorialArrow();
            _loc1_ = this.equipmentScreen;
            addTutorialArrow("left",_loc1_._design.Container_Arrow);
            setText(ProjectManager.getText("TUTORIAL_CUSTOMIZATION_CLOSE"));
            this.faceClicked = true;
         }
      }
   }
}

