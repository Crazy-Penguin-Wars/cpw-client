package tuxwars.battle.ui.screen.result.position
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class PositionElement extends TuxUIElementScreen
   {
      
      private static const NUM_CONTAINERS:int = 4;
      
      private static const CONTAINER:String = "Container_";
       
      
      private const containers:UIContainers = new UIContainers();
      
      private var container:PositionContainer;
      
      public function PositionElement(design:MovieClip, game:TuxWarsGame)
      {
         var i:int = 0;
         super(design,game);
         for(i = 1; i <= 4; )
         {
            containers.add("Container_" + i,new PositionContainer(design.getChildByName("Container_" + i) as MovieClip,this,i));
            i++;
         }
         containers.setAllVisible(false);
      }
      
      public function init(results:BattleResults) : void
      {
         var _loc2_:int = results.playerResults.length;
         container = containers.getContainer("Container_" + _loc2_) as PositionContainer;
         container.init(results);
         containers.show("Container_" + _loc2_,false);
      }
      
      public function getActivatedPositionSlots() : Vector.<PositionSlot>
      {
         return container.getPositionSlots();
      }
   }
}
