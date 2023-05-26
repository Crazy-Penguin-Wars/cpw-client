package tuxwars.home.states.equipment
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.equipment.EquipmentLogic;
   import tuxwars.home.ui.screen.equipment.EquipmentScreen;
   import tuxwars.states.tutorial.TuxTutorialCustomizationSubState;
   import tuxwars.tutorial.Tutorial;
   
   public class EquipmentUISubState extends TuxUIState
   {
       
      
      public function EquipmentUISubState(game:TuxWarsGame, params:* = null)
      {
         super(EquipmentScreen,EquipmentLogic,game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            var _loc2_:Tutorial = Tutorial;
            if(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialStart")
            {
               changeState(new TuxTutorialCustomizationSubState(tuxGame));
            }
         }
      }
   }
}
