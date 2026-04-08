package tuxwars.home.states.leaderboard
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.player.reports.*;
   import tuxwars.states.TuxState;
   
   public class LeaderboardState extends TuxState
   {
      private var report:PlayerReport;
      
      public function LeaderboardState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.sendEvent(new ServerRequest("GetUserStatistic",null,false,this.responseReceived));
         changeState(new LeaderboardLoadAssetsSubState(tuxGame));
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(state == null && Boolean(this.report))
         {
            changeState(new LeaderboardUISubState(tuxGame,this.report),true);
         }
      }
      
      private function responseReceived(param1:ServerResponse) : void
      {
         this.report = new PlayerReport(param1.data.globalUserStatistic,param1.data.weeklyUserStatistic,param1.data.monthlyUserStatistic,param1.data.leaderboardsStatistic);
      }
   }
}

