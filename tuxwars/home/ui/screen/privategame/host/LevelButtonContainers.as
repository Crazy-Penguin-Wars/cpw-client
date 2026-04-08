package tuxwars.home.ui.screen.privategame.host
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.battle.data.*;
   import tuxwars.ui.containers.shopitem.*;
   
   public class LevelButtonContainers extends UIContainers implements ButtonContainers
   {
      private static const BUTTON_DEFAULT:String = "Slot_Default";
      
      private static const BUTTON_LOCKED:String = "Slot_Locked";
      
      private var parent:HostPrivateGameSettingsScreen;
      
      private var levelData:LevelData;
      
      public function LevelButtonContainers(param1:MovieClip, param2:HostPrivateGameSettingsScreen, param3:*)
      {
         super();
         this.parent = param2;
         this.levelData = param3 as LevelData;
         param1.visible = true;
         add("Slot_Default",new DefaultLevelButtonContainer(param1.Slot_Default,param2,this.levelData));
         add("Slot_Locked",new LockedLevelButtonContainer(param1.Slot_Locked,param2,this.levelData));
         show(this.getInitialContainer(),false);
      }
      
      override public function dispose() : void
      {
         this.parent = null;
         this.levelData = null;
         super.dispose();
      }
      
      public function get currentButtonContainer() : ButtonContainer
      {
         return getCurrentContainer() as ButtonContainer;
      }
      
      public function get isLocked() : Boolean
      {
         if(this.levelData)
         {
            return this.levelData.minLevel > this.parent.tuxGame.player.level;
         }
         return false;
      }
      
      private function getInitialContainer() : String
      {
         return this.isLocked ? "Slot_Locked" : "Slot_Default";
      }
   }
}

