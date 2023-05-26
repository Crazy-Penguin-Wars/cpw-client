package tuxwars.home.ui.screen.privategame.host
{
   import flash.display.MovieClip;
   import tuxwars.battle.data.LevelData;
   
   public class DefaultLevelButtonContainer extends AbstractLevelButtonContainer
   {
       
      
      public function DefaultLevelButtonContainer(design:MovieClip, parent:HostPrivateGameSettingsScreen, levelData:LevelData)
      {
         super(design,parent,levelData);
      }
   }
}
