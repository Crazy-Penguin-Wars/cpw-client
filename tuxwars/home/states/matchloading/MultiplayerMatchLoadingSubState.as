package tuxwars.home.states.matchloading
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.home.ui.logic.matchloading.MultiplayerMatchLoadingLogic;
   
   public class MultiplayerMatchLoadingSubState extends MatchLoadingSubState
   {
       
      
      public function MultiplayerMatchLoadingSubState(game:TuxWarsGame, request:ServerRequest)
      {
         super(game,request);
         var _loc3_:BattleManager = BattleManager;
         tuxwars.battle.BattleManager._customGameName = null;
         BattleManager.setPracticeMode(false);
      }
      
      override public function enter() : void
      {
         super.enter();
         if(allowEnterGame)
         {
            request.buffered = true;
            MessageCenter.sendEvent(request);
         }
      }
      
      override public function get logicClass() : Class
      {
         return MultiplayerMatchLoadingLogic;
      }
      
      public function get request() : ServerRequest
      {
         return params;
      }
   }
}
