package tuxwars.battle.ui.logic
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class PracticeMessagePopUpLogic extends MessagePopUpLogic
   {
      public function PracticeMessagePopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function get headerText() : String
      {
         return PopUpData.getTitle("practice");
      }
      
      override public function get messageText() : String
      {
         return PopUpData.getDescription("practice");
      }
      
      override public function get picture() : String
      {
         return PopUpData.getPicture("practice");
      }
   }
}

