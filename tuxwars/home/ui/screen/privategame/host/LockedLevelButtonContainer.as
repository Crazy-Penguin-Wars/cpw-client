package tuxwars.home.ui.screen.privategame.host
{
   import flash.display.MovieClip;
   import tuxwars.battle.data.LevelData;
   
   public class LockedLevelButtonContainer extends AbstractLevelButtonContainer
   {
       
      
      public function LockedLevelButtonContainer(design:MovieClip, parent:HostPrivateGameSettingsScreen, levelData:LevelData)
      {
         var _loc4_:* = null;
         super(design,parent,levelData);
         if(levelData)
         {
            _loc4_ = button.getDesignMovieClip();
            _loc4_.Text_Level.text = levelData.minLevel.toString();
         }
      }
   }
}
