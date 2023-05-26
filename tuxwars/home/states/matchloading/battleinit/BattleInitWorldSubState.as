package tuxwars.home.states.matchloading.battleinit
{
   import avmplus.getQualifiedClassName;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.states.State;
   import com.dchoc.utils.LogUtils;
   import tuxwars.BattleLoader;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.events.TextIDMessage;
   import tuxwars.states.TuxState;
   
   public class BattleInitWorldSubState extends TuxState
   {
       
      
      public function BattleInitWorldSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
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
      
      override public function changeState(state:State, force:Boolean = false) : void
      {
         if(state && state.parent == null)
         {
            LogUtils.log("State:" + getQualifiedClassName(state) + " has no parent!",this,0,"Warning",false,false,false);
         }
         super.changeState(state,force);
      }
   }
}
