package tuxwars.ui.popups.logic.wrongversion
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PopUpData;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   
   public class WrongVersionPopUpLogic extends PopUpBaseLogic
   {
       
      
      public function WrongVersionPopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function get picture() : String
      {
         return PopUpData.getPicture("wrongversionpopup");
      }
      
      public function get header() : String
      {
         return PopUpData.getTitle("wrongversionpopup");
      }
      
      public function get description() : String
      {
         return PopUpData.getDescription("wrongversionpopup");
      }
   }
}
