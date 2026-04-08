package tuxwars.ui.popups.logic.error
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   
   public class ErrorPopUpLogic extends PopUpBaseLogic
   {
      public function ErrorPopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
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

