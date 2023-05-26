package tuxwars.home.states.matchloading.levelloading
{
   import com.dchoc.messages.MessageCenter;
   import tuxwars.BattleLoader;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.events.TextIDMessage;
   import tuxwars.home.states.matchloading.battleinit.BattleInitState;
   import tuxwars.states.TuxState;
   
   public class LevelLoadingSubState extends TuxState
   {
       
      
      private var vip:Boolean;
      
      private var tournament:Boolean;
      
      public function LevelLoadingSubState(game:TuxWarsGame, data:Object, vip:Boolean, tournament:Boolean)
      {
         super(game,data);
         this.vip = vip;
         this.tournament = tournament;
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(new TextIDMessage("MATCH_LOADING_LEVEL"));
         BattleLoader.load(params,tuxGame.player,vip,tournament);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(BattleLoader.isLoaded())
         {
            parent.changeState(new BattleInitState(tuxGame));
            BattleManager.setRandomSeed(BattleLoader.getSeed());
         }
      }
   }
}
