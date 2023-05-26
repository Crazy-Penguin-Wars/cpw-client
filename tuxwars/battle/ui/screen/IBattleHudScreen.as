package tuxwars.battle.ui.screen
{
   import tuxwars.home.ui.screenhandlers.IScreen;
   
   public interface IBattleHudScreen extends IScreen
   {
       
      
      function showHud() : void;
      
      function hideHud() : void;
   }
}
