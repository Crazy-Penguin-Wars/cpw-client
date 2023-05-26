package tuxwars.home.states.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.home.ui.logic.matchloading.PracticeMatchLoadingLogic;
   
   public class PracticeMatchLoadingSubState extends MatchLoadingSubState
   {
       
      
      public function PracticeMatchLoadingSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
         var _loc3_:BattleManager = BattleManager;
         tuxwars.battle.BattleManager._customGameName = null;
         BattleManager.setPracticeMode(true);
         BattleManager.init(game);
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         tuxwars.challenges.ChallengeManager._instance.pause();
      }
      
      override public function get logicClass() : Class
      {
         return PracticeMatchLoadingLogic;
      }
      
      override public function isPracticeMatch() : Boolean
      {
         return true;
      }
   }
}
