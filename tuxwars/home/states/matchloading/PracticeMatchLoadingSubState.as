package tuxwars.home.states.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.challenges.*;
   import tuxwars.home.ui.logic.matchloading.*;
   
   public class PracticeMatchLoadingSubState extends MatchLoadingSubState
   {
      public function PracticeMatchLoadingSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
         var _loc3_:* = null;
         BattleManager.customGameName = _loc3_;
         BattleManager.setPracticeMode(true);
         BattleManager.init(param1);
      }
      
      override public function enter() : void
      {
         super.enter();
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         ChallengeManager.instance.pause();
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

