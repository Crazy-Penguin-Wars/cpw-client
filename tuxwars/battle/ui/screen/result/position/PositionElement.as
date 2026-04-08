package tuxwars.battle.ui.screen.result.position
{
   import com.dchoc.ui.windows.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class PositionElement extends TuxUIElementScreen
   {
      private static const NUM_CONTAINERS:int = 4;
      
      private static const CONTAINER:String = "Container_";
      
      private const containers:UIContainers;
      
      private var container:PositionContainer;
      
      public function PositionElement(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:int = 0;
         this.containers = new UIContainers();
         super(param1,param2);
         _loc3_ = 1;
         while(_loc3_ <= 4)
         {
            this.containers.add("Container_" + _loc3_,new PositionContainer(param1.getChildByName("Container_" + _loc3_) as MovieClip,this,_loc3_));
            _loc3_++;
         }
         this.containers.setAllVisible(false);
      }
      
      public function init(param1:BattleResults) : void
      {
         var _loc2_:int = int(param1.playerResults.length);
         this.container = this.containers.getContainer("Container_" + _loc2_) as PositionContainer;
         this.container.init(param1);
         this.containers.show("Container_" + _loc2_,false);
      }
      
      public function getActivatedPositionSlots() : Vector.<PositionSlot>
      {
         return this.container.getPositionSlots();
      }
   }
}

