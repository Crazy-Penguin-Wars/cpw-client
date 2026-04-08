package tuxwars.home.states.equipment
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.equipment.*;
   import tuxwars.home.ui.screen.equipment.*;
   import tuxwars.states.tutorial.*;
   import tuxwars.tutorial.*;
   
   public class EquipmentUISubState extends TuxUIState
   {
      public function EquipmentUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(EquipmentScreen,EquipmentLogic,param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         if(Tutorial._tutorial)
         {
            if(Tutorial._tutorialStep == "TutorialStart")
            {
               changeState(new TuxTutorialCustomizationSubState(tuxGame));
            }
         }
      }
   }
}

