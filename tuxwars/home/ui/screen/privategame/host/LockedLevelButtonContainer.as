package tuxwars.home.ui.screen.privategame.host
{
   import flash.display.MovieClip;
   import tuxwars.battle.data.LevelData;
   
   public class LockedLevelButtonContainer extends AbstractLevelButtonContainer
   {
      public function LockedLevelButtonContainer(param1:MovieClip, param2:HostPrivateGameSettingsScreen, param3:LevelData)
      {
         var _loc4_:MovieClip = null;
         super(param1,param2,param3);
         if(param3)
         {
            _loc4_ = button.getDesignMovieClip();
            _loc4_.Text_Level.text = param3.minLevel.toString();
         }
      }
   }
}

