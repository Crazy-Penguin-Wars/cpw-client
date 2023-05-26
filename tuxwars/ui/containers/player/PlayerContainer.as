package tuxwars.ui.containers.player
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   
   public class PlayerContainer
   {
      
      private static const FREE_SLOT:String = "Free";
      
      private static const READY_SLOT:String = "Ready";
       
      
      private const slotContainers:UIContainers = new UIContainers();
      
      public function PlayerContainer(design:MovieClip, index:int)
      {
         super();
         slotContainers.add("Free",new PlayerFreeSlotContainer(design.Container_Free,index));
         slotContainers.add("Ready",new PlayerReadySlotContainer(design.Container_Ready,index));
         slotContainers.show("Free",false);
      }
      
      public function init(playerData:PlayerSlotData) : void
      {
         var _loc2_:PlayerReadySlotContainer = slotContainers.getContainer("Ready") as PlayerReadySlotContainer;
         _loc2_.init(playerData);
         slotContainers.show("Ready");
      }
      
      public function dispose() : void
      {
         slotContainers.dispose();
      }
      
      public function reset() : void
      {
         slotContainers.show("Free",false);
      }
   }
}
