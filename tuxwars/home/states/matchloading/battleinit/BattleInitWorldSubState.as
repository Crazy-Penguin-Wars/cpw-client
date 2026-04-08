package tuxwars.home.states.matchloading.battleinit
{
   import avmplus.*;
   import com.dchoc.messages.*;
   import com.dchoc.states.State;
   import com.dchoc.utils.*;
   import tuxwars.*;
   import tuxwars.battle.world.*;
   import tuxwars.events.*;
   import tuxwars.states.TuxState;
   
   public class BattleInitWorldSubState extends TuxState
   {
      public function BattleInitWorldSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_CREATING_WORLD"));
         tuxGame.world = new TuxWorld(tuxGame);
         tuxGame.world.init({
            "level":BattleLoader.getLevel(),
            "players":BattleLoader.getPlayers()
         });
         if(parent == null)
         {
            LogUtils.log("Parent is null this will crash, look for other warnings from this class",this,3,"Warning",true,false,true);
         }
         parent.changeState(new BattleInitManagerSubState(tuxGame));
      }
      
      override public function exit() : void
      {
         LogUtils.log("Exit called",this,0,"Warning",false,false,false);
         super.exit();
      }
      
      override public function dispose() : void
      {
      }
      
      private function get battleInitState() : BattleInitState
      {
         return state as BattleInitState;
      }
      
      override public function changeState(param1:State, param2:Boolean = false) : void
      {
         if(Boolean(param1) && param1.parent == null)
         {
            LogUtils.log("State:" + getQualifiedClassName(param1) + " has no parent!",this,0,"Warning",false,false,false);
         }
         super.changeState(param1,param2);
      }
   }
}

