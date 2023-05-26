package tuxwars.tournament
{
   import com.dchoc.projectdata.ProjectManager;
   
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
      
      public function TournamentPlayer(data:Object)
      {
         var platformData:* = null;
         super();
         _dcg_id = data.dcg_id;
         _rank = data.rank;
         _points = data.points;
         _score = data.score;
         _played_matches = data.played_matches;
         _status = data.status;
         if(data.previous_rank)
         {
            _previous_rank = data.previous_rank;
         }
         else
         {
            _previous_rank = _rank;
         }
         if(data.platforms_data)
         {
            _platforms_data = data.platforms_data.platform_data is Array ? data.platforms_data.platform_data : [data.platforms_data.platform_data];
         }
         else
         {
            platformData = {};
            platformData.name = data.name;
            platformData.user_id = data.user_id;
            platformData.platform = data.platform;
            platformData.pic_url = data.pic_url;
            _platforms_data = [platformData];
         }
      }
      
      public function get name() : String
      {
         var name:* = null;
         for each(var pd in _platforms_data)
         {
            if(pd.platform == Config.getPlatform())
            {
               return pd.name != null ? pd.name : ProjectManager.getText("DEFAULT_FRIEND_NAME");
            }
            if(!name && pd.name)
            {
               name = pd.name;
            }
         }
         return name != null ? name : ProjectManager.getText("DEFAULT_FRIEND_NAME");
      }
      
      public function get pic_url() : String
      {
         var url:* = null;
         for each(var pd in _platforms_data)
         {
            if(pd.platform == Config.getPlatform())
            {
               return pd.pic_url;
            }
            if(!url && pd.pic_url)
            {
               url = pd.pic_url;
            }
         }
         return url;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get played_matches() : int
      {
         return _played_matches;
      }
      
      public function get dcg_id() : String
      {
         return _dcg_id;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function get previous_rank() : int
      {
         return _previous_rank;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function get score() : String
      {
         return _score;
      }
   }
}
