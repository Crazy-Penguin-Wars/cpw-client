package tuxwars.ui.popups.logic.wrongversion
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   
   public class WrongVersionPopUpLogic extends PopUpBaseLogic
   {
      public function WrongVersionPopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
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

