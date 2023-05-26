package tuxwars.ui.containers.player
{
   import flash.display.MovieClip;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   
   public class PlayerContainers
   {
      
      private static const NUM_SLOTS:int = 4;
      
      private static const SLOT:String = "Slot_0";
       
      
      private const slots:Vector.<PlayerContainer> = new Vector.<PlayerContainer>(4,true);
      
      public function PlayerContainers(design:MovieClip)
      {
         var i:int = 0;
         super();
         for(i = 0; i < 4; )
         {
            slots[i] = new PlayerContainer(design["Slot_0" + (i + 1)],i + 1);
            i++;
         }
      }
      
      public function init(players:Vector.<PlayerSlotData>) : void
      {
         var i:int = 0;
         resetSlots();
         for(i = 0; i < players.length; )
         {
            slots[i].init(players[i]);
            i++;
         }
      }
      
      public function dispose() : void
      {
         for each(var slot in slots)
         {
            slot.dispose();
         }
      }
      
      private function resetSlots() : void
      {
         for each(var slot in slots)
         {
            slot.reset();
         }
      }
   }
}
