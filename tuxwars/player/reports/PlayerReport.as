package tuxwars.player.reports
{
   public class PlayerReport
   {
      private var _all:Object;
      
      private var _weekly:Object;
      
      private var _monthly:Object;
      
      private var _leaderboard:Object;
      
      public function PlayerReport(param1:Object, param2:Object, param3:Object, param4:Object)
      {
         super();
         this._all = !!param1 ? param1 : {};
         this._weekly = !!param2 ? param2 : {};
         this._monthly = !!param3 ? param3 : {};
         this._leaderboard = !!param4 ? param4 : {};
      }
      
      public function get allTimeData() : Object
      {
         return this._all;
      }
      
      public function get weeklyData() : Object
      {
         return this._weekly;
      }
      
      public function get monthlyData() : Object
      {
         return this._monthly;
      }
      
      public function get leaderboard() : Object
      {
         return this._leaderboard;
      }
      
      public function get weeklyLeaderboard() : Object
      {
         return !!this._leaderboard.hasOwnProperty("weeklyLeaderboard") ? this._leaderboard.weeklyLeaderboard : {};
      }
      
      public function get monthlyLeaderboard() : Object
      {
         return !!this._leaderboard.hasOwnProperty("monthlyLeaderboard") ? this._leaderboard.monthlyLeaderboard : {};
      }
      
      public function get allTimeLeaderboard() : Object
      {
         return !!this._leaderboard.hasOwnProperty("globalLeaderboard") ? this._leaderboard.globalLeaderboard : {};
      }
      
      public function get wornItems() : Object
      {
         return !!this._leaderboard.hasOwnProperty("wornItems") ? this._leaderboard.wornItems : {};
      }
   }
}

