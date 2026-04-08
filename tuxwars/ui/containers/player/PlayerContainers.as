package tuxwars.ui.containers.player
{
   import flash.display.MovieClip;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   
   public class PlayerContainers
   {
      private static const NUM_SLOTS:int = 4;
      
      private static const SLOT:String = "Slot_0";
      
      private const slots:Vector.<PlayerContainer>;
      
      public function PlayerContainers(param1:MovieClip)
      {
         var _loc2_:int = 0;
         this.slots = new Vector.<PlayerContainer>(4,true);
         super();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            this.slots[_loc2_] = new PlayerContainer(param1["Slot_0" + (_loc2_ + 1)],_loc2_ + 1);
            _loc2_++;
         }
      }
      
      public function init(param1:Vector.<PlayerSlotData>) : void
      {
         var _loc2_:int = 0;
         this.resetSlots();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            this.slots[_loc2_].init(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.slots)
         {
            _loc1_.dispose();
         }
      }
      
      private function resetSlots() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.slots)
         {
            _loc1_.reset();
         }
      }
   }
}

