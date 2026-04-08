package tuxwars.home.states.matchloading
{
   import com.dchoc.messages.*;
   import com.dchoc.net.ServerRequest;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.home.ui.logic.matchloading.*;
   
   public class MultiplayerMatchLoadingSubState extends MatchLoadingSubState
   {
      public function MultiplayerMatchLoadingSubState(param1:TuxWarsGame, param2:ServerRequest)
      {
         super(param1,param2);
         var _loc3_:* = null;
         BattleManager.customGameName = _loc3_;
         BattleManager.setPracticeMode(false);
      }
      
      override public function enter() : void
      {
         super.enter();
         if(allowEnterGame)
         {
            this.request.buffered = true;
            MessageCenter.sendEvent(this.request);
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

