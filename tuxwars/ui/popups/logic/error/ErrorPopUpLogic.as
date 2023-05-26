package tuxwars.ui.popups.logic.error
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PopUpData;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   
   public class ErrorPopUpLogic extends PopUpBaseLogic
   {
       
      
      public function ErrorPopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function get picture() : String
      {
         return PopUpData.getPicture("errorpopup_1");
      }
      
      public function get header() : String
      {
         return "ERROR_HEADER";
      }
   }
}
