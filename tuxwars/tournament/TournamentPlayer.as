package tuxwars.tournament
{
   import com.dchoc.projectdata.*;
   
   public class TournamentPlayer
   {
      private var _dcg_id:String;
      
      private var _rank:int;
      
      private var _points:int;
      
      private var _score:String;
      
      private var _played_matches:int;
      
      private var _status:int;
      
      private var _previous_rank:int;
      
      private var _platforms_data:Array;
      
      public function TournamentPlayer(param1:Object)
      {
         var _loc2_:Object = null;
         super();
         this._dcg_id = param1.dcg_id;
         this._rank = param1.rank;
         this._points = param1.points;
         this._score = param1.score;
         this._played_matches = param1.played_matches;
         this._status = param1.status;
         if(param1.previous_rank)
         {
            this._previous_rank = param1.previous_rank;
         }
         else
         {
            this._previous_rank = this._rank;
         }
         if(param1.platforms_data)
         {
            this._platforms_data = param1.platforms_data.platform_data is Array ? param1.platforms_data.platform_data : [param1.platforms_data.platform_data];
         }
         else
         {
            _loc2_ = {};
            _loc2_.name = param1.name;
            _loc2_.user_id = param1.user_id;
            _loc2_.platform = param1.platform;
            _loc2_.pic_url = param1.pic_url;
            this._platforms_data = [_loc2_];
         }
      }
      
      public function get name() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:String = null;
         for each(_loc2_ in this._platforms_data)
         {
            if(_loc2_.platform == Config.getPlatform())
            {
               return _loc2_.name != null ? _loc2_.name : ProjectManager.getText("DEFAULT_FRIEND_NAME");
            }
            if(!_loc1_ && Boolean(_loc2_.name))
            {
               _loc1_ = _loc2_.name;
            }
         }
         return _loc1_ != null ? _loc1_ : ProjectManager.getText("DEFAULT_FRIEND_NAME");
      }
      
      public function get pic_url() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:String = null;
         for each(_loc2_ in this._platforms_data)
         {
            if(_loc2_.platform == Config.getPlatform())
            {
               return _loc2_.pic_url;
            }
            if(!_loc1_ && Boolean(_loc2_.pic_url))
            {
               _loc1_ = _loc2_.pic_url;
            }
         }
         return _loc1_;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function get played_matches() : int
      {
         return this._played_matches;
      }
      
      public function get dcg_id() : String
      {
         return this._dcg_id;
      }
      
      public function get rank() : int
      {
         return this._rank;
      }
      
      public function get previous_rank() : int
      {
         return this._previous_rank;
      }
      
      public function get points() : int
      {
         return this._points;
      }
      
      public function get score() : String
      {
         return this._score;
      }
   }
}

