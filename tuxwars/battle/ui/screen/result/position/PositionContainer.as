package tuxwars.battle.ui.screen.result.position
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.battle.BattleResults;
   
   public class PositionContainer extends UIContainer
   {
      
      private static const SLOT:String = "Slot_";
       
      
      private const slots:Vector.<PositionSlot> = new Vector.<PositionSlot>();
      
      private var numSlots:int;
      
      public function PositionContainer(design:MovieClip, parent:UIComponent, numSlots:int)
      {
         var i:int = 0;
         super(design,parent);
         this.numSlots = numSlots;
         for(i = 0; i < numSlots; )
         {
            slots.push(new PositionSlot(design.getChildByName("Slot_" + (i + 1)) as MovieClip));
            i++;
         }
      }
      
      public function init(results:BattleResults) : void
      {
         var i:int = 0;
         for(i = 0; i < results.playerResults.length; )
         {
            slots[i].init(results.playerResults[i],i + 1,results.isTournamentMode,results.isZeroPointGame);
            i++;
         }
      }
      
      public function getPositionSlots() : Vector.<PositionSlot>
      {
         return slots;
      }
      
      override public function dispose() : void
      {
         for each(var slot in slots)
         {
            slot.dispose();
         }
         slots.splice(0,slots.length);
         super.dispose();
      }
   }
}
