package tuxwars.home.ui.screen.privategame.host
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.battle.data.LevelData;
   import tuxwars.ui.containers.shopitem.ButtonContainer;
   import tuxwars.ui.containers.shopitem.ButtonContainers;
   
   public class LevelButtonContainers extends UIContainers implements ButtonContainers
   {
      
      private static const BUTTON_DEFAULT:String = "Slot_Default";
      
      private static const BUTTON_LOCKED:String = "Slot_Locked";
       
      
      private var parent:HostPrivateGameSettingsScreen;
      
      private var levelData:LevelData;
      
      public function LevelButtonContainers(design:MovieClip, parent:HostPrivateGameSettingsScreen, level:*)
      {
         super();
         this.parent = parent;
         this.levelData = level as LevelData;
         design.visible = true;
         add("Slot_Default",new DefaultLevelButtonContainer(design.Slot_Default,parent,levelData));
         add("Slot_Locked",new LockedLevelButtonContainer(design.Slot_Locked,parent,levelData));
         show(getInitialContainer(),false);
      }
      
      override public function dispose() : void
      {
         parent = null;
         levelData = null;
         super.dispose();
      }
      
      public function get currentButtonContainer() : ButtonContainer
      {
         return getCurrentContainer() as ButtonContainer;
      }
      
      public function get isLocked() : Boolean
      {
         if(levelData)
         {
            return levelData.minLevel > parent.tuxGame.player.level;
         }
         return false;
      }
      
      private function getInitialContainer() : String
      {
         return isLocked ? "Slot_Locked" : "Slot_Default";
      }
   }
}
