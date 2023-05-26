package tuxwars.player.reports
{
   public class PlayerReport
   {
       
      
      private var _all:Object;
      
      private var _weekly:Object;
      
      private var _monthly:Object;
      
      private var _leaderboard:Object;
      
      public function PlayerReport(all:Object, weekly:Object, monthly:Object, leaderboard:Object)
      {
         super();
         _all = !!all ? all : {};
         _weekly = !!weekly ? weekly : {};
         _monthly = !!monthly ? monthly : {};
         _leaderboard = !!leaderboard ? leaderboard : {};
      }
      
      public function get allTimeData() : Object
      {
         return _all;
      }
      
      public function get weeklyData() : Object
      {
         return _weekly;
      }
      
      public function get monthlyData() : Object
      {
         return _monthly;
      }
      
      public function get leaderboard() : Object
      {
         return _leaderboard;
      }
      
      public function get weeklyLeaderboard() : Object
      {
         return _leaderboard.hasOwnProperty("weeklyLeaderboard") ? _leaderboard.weeklyLeaderboard : {};
      }
      
      public function get monthlyLeaderboard() : Object
      {
         return _leaderboard.hasOwnProperty("monthlyLeaderboard") ? _leaderboard.monthlyLeaderboard : {};
      }
      
      public function get allTimeLeaderboard() : Object
      {
         return _leaderboard.hasOwnProperty("globalLeaderboard") ? _leaderboard.globalLeaderboard : {};
      }
      
      public function get wornItems() : Object
      {
         return _leaderboard.hasOwnProperty("wornItems") ? _leaderboard.wornItems : {};
      }
   }
}
