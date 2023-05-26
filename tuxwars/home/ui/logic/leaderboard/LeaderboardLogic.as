package tuxwars.home.ui.logic.leaderboard
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxPageSubTabLogic;
   import tuxwars.home.ui.screen.leaderboard.LeaderboardScreen;
   import tuxwars.player.reports.PlayerReport;
   import tuxwars.states.TuxState;
   
   public class LeaderboardLogic extends TuxPageSubTabLogic
   {
      
      private static const TABLE:String = "Screen";
      
      private static const LEADERBOARD_PAGE:String = "Leaderboard";
      
      public static const ALL:String = "All";
      
      public static const WEEKLY:String = "Weekly";
      
      public static const MONTHLY:String = "Monthly";
       
      
      private var report:PlayerReport;
      
      private var _currentLeaderboardData:String = "Weekly";
      
      public function LeaderboardLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public static function getStaticData() : Row
      {
         var _loc1_:ProjectManager = ProjectManager;
         var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Screen");
         if(!_loc2_._cache["Leaderboard"])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Leaderboard");
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Leaderboard" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache["Leaderboard"] = _loc5_;
         }
         return _loc2_._cache["Leaderboard"];
      }
      
      override public function preInit(params:*) : void
      {
         super.preInit(params);
         report = params;
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         showLeaderboard();
      }
      
      override public function getData() : Row
      {
         return getStaticData();
      }
      
      public function get currentLeaderboardData() : String
      {
         return _currentLeaderboardData;
      }
      
      public function personalAllSelected() : void
      {
         leaderboardScreen.showPersonalStats(report.allTimeData);
      }
      
      public function personalWeeklySelected() : void
      {
         leaderboardScreen.showPersonalStats(report.weeklyData);
      }
      
      public function personalMonthlySelected() : void
      {
         leaderboardScreen.showPersonalStats(report.monthlyData);
      }
      
      public function leaderboardAllSelected() : void
      {
         _currentLeaderboardData = "All";
         leaderboardScreen.showLeaderboardStats(report.allTimeLeaderboard,report.wornItems);
      }
      
      public function leaderboardWeeklySelected() : void
      {
         _currentLeaderboardData = "Weekly";
         leaderboardScreen.showLeaderboardStats(report.weeklyLeaderboard,report.wornItems);
      }
      
      public function leaderboardMonthlySelected() : void
      {
         _currentLeaderboardData = "Monthly";
         leaderboardScreen.showLeaderboardStats(report.monthlyLeaderboard,report.wornItems);
      }
      
      public function get leaderboardScreen() : LeaderboardScreen
      {
         return screen;
      }
      
      public function showLeaderboard() : void
      {
         switch(_currentLeaderboardData)
         {
            case "All":
               leaderboardAllSelected();
               break;
            case "Weekly":
               leaderboardWeeklySelected();
               break;
            case "Monthly":
               leaderboardMonthlySelected();
         }
      }
   }
}
