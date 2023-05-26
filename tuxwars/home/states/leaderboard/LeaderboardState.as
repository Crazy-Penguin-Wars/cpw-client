package tuxwars.home.states.leaderboard
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import tuxwars.TuxWarsGame;
   import tuxwars.player.reports.PlayerReport;
   import tuxwars.states.TuxState;
   
   public class LeaderboardState extends TuxState
   {
       
      
      private var report:PlayerReport;
      
      public function LeaderboardState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(new ServerRequest("GetUserStatistic",null,false,responseReceived));
         changeState(new LeaderboardLoadAssetsSubState(tuxGame));
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(state == null && report)
         {
            changeState(new LeaderboardUISubState(tuxGame,report),true);
         }
      }
      
      private function responseReceived(response:ServerResponse) : void
      {
         report = new PlayerReport(response.data.globalUserStatistic,response.data.weeklyUserStatistic,response.data.monthlyUserStatistic,response.data.leaderboardsStatistic);
      }
   }
}
