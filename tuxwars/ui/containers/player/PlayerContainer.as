package tuxwars.ui.containers.player
{
   import com.dchoc.ui.windows.*;
   import flash.display.MovieClip;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   
   public class PlayerContainer
   {
      private static const FREE_SLOT:String = "Free";
      
      private static const READY_SLOT:String = "Ready";
      
      private const slotContainers:UIContainers = new UIContainers();
      
      public function PlayerContainer(param1:MovieClip, param2:int)
      {
         super();
         this.slotContainers.add("Free",new PlayerFreeSlotContainer(param1.Container_Free,param2));
         this.slotContainers.add("Ready",new PlayerReadySlotContainer(param1.Container_Ready,param2));
         this.slotContainers.getContainer("Free").setVisible(true);
         this.slotContainers.getContainer("Ready").setVisible(false);
         trace("slotContainers.show(\'Free\',false);");
      }
      
      public function init(param1:PlayerSlotData) : void
      {
         this.slotContainers.getContainer("Free").setVisible(false);
         this.slotContainers.getContainer("Ready").setVisible(true);
         var _loc2_:PlayerReadySlotContainer = this.slotContainers.getContainer("Ready") as PlayerReadySlotContainer;
         _loc2_.init(param1);
         trace("Temporary solution until we figure out how to add transitions");
         trace("slotContainers.show(\'Ready\');");
         trace("slotContainers.setVisible(true);");
      }
      
      public function dispose() : void
      {
         this.slotContainers.dispose();
      }
      
      public function reset() : void
      {
         this.slotContainers.getContainer("Free").setVisible(true);
         this.slotContainers.getContainer("Ready").setVisible(false);
         trace("slotContainers.show(\'Free\',false);");
      }
   }
}

