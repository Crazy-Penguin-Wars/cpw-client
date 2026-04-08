package tuxwars.battle.ui.screen.result.position
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.*;
   import tuxwars.battle.BattleResults;
   
   public class PositionContainer extends UIContainer
   {
      private static const SLOT:String = "Slot_";
      
      private const slots:Vector.<PositionSlot>;
      
      private var numSlots:int;
      
      public function PositionContainer(param1:MovieClip, param2:UIComponent, param3:int)
      {
         var _loc4_:int = 0;
         this.slots = new Vector.<PositionSlot>();
         super(param1,param2);
         this.numSlots = param3;
         _loc4_ = 0;
         while(_loc4_ < param3)
         {
            this.slots.push(new PositionSlot(param1.getChildByName("Slot_" + (_loc4_ + 1)) as MovieClip));
            _loc4_++;
         }
      }
      
      public function init(param1:BattleResults) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.playerResults.length)
         {
            this.slots[_loc2_].init(param1.playerResults[_loc2_],_loc2_ + 1,param1.isTournamentMode,param1.isZeroPointGame);
            _loc2_++;
         }
      }
      
      public function getPositionSlots() : Vector.<PositionSlot>
      {
         return this.slots;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.slots)
         {
            _loc1_.dispose();
         }
         this.slots.splice(0,this.slots.length);
         super.dispose();
      }
   }
}

