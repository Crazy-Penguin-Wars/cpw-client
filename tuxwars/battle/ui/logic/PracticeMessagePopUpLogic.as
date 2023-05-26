package tuxwars.battle.ui.logic
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PopUpData;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class PracticeMessagePopUpLogic extends MessagePopUpLogic
   {
       
      
      public function PracticeMessagePopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
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
