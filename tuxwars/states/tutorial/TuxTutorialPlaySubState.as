package tuxwars.states.tutorial
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.home.HomeScreen;
   
   public class TuxTutorialPlaySubState extends TuxTutorialSubState
   {
       
      
      public function TuxTutorialPlaySubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_PLAY_GAME");
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:HomeScreen = tuxGame.homeState.screenHandler.screen as HomeScreen;
         var _loc2_:* = _loc1_.characterFrameElementScreen.playButton;
         addTutorialArrow("left",_loc2_._design.Container_Arrow);
      }
   }
}
