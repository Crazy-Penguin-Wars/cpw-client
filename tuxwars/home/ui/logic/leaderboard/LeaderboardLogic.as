package tuxwars.home.ui.logic.leaderboard
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
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
      
      public function LeaderboardLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public static function getStaticData() : Row
      {
         var _loc4_:Row = null;
         var _loc1_:String = "Screen";
         var _loc2_:String = "Leaderboard";
         var _loc3_:* = ProjectManager.findTable(_loc1_);
         if(!_loc3_.getCache[_loc2_])
         {
            _loc4_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc4_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc4_;
         }
         return _loc3_.getCache[_loc2_];
      }
      
      override public function preInit(param1:*) : void
      {
         super.preInit(param1);
         this.report = param1;
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.showLeaderboard();
      }
      
      override public function getData() : Row
      {
         return getStaticData();
      }
      
      public function get currentLeaderboardData() : String
      {
         return this._currentLeaderboardData;
      }
      
      public function personalAllSelected() : void
      {
         this.leaderboardScreen.showPersonalStats(this.report.allTimeData);
      }
      
      public function personalWeeklySelected() : void
      {
         this.leaderboardScreen.showPersonalStats(this.report.weeklyData);
      }
      
      public function personalMonthlySelected() : void
      {
         this.leaderboardScreen.showPersonalStats(this.report.monthlyData);
      }
      
      public function leaderboardAllSelected() : void
      {
         this._currentLeaderboardData = "All";
         this.leaderboardScreen.showLeaderboardStats(this.report.allTimeLeaderboard,this.report.wornItems);
      }
      
      public function leaderboardWeeklySelected() : void
      {
         this._currentLeaderboardData = "Weekly";
         this.leaderboardScreen.showLeaderboardStats(this.report.weeklyLeaderboard,this.report.wornItems);
      }
      
      public function leaderboardMonthlySelected() : void
      {
         this._currentLeaderboardData = "Monthly";
         this.leaderboardScreen.showLeaderboardStats(this.report.monthlyLeaderboard,this.report.wornItems);
      }
      
      public function get leaderboardScreen() : LeaderboardScreen
      {
         return screen;
      }
      
      public function showLeaderboard() : void
      {
         switch(this._currentLeaderboardData)
         {
            case "All":
               this.leaderboardAllSelected();
               break;
            case "Weekly":
               this.leaderboardWeeklySelected();
               break;
            case "Monthly":
               this.leaderboardMonthlySelected();
         }
      }
   }
}

