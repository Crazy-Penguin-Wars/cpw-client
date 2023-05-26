package com.dchoc.friends
{
   import com.dchoc.projectdata.ProjectManager;
   import no.olog.utilfunctions.assert;
   
   public class Friend
   {
      
      public static const STATUS_PLAYER:String = "Player";
      
      public static const STATUS_PENDING:String = "Pending";
      
      public static const STATUS_NEIGHBOR:String = "Neighbor";
      
      public static const STATUS_NO_NEIGHBOR:String = "NoNeighbor";
      
      public static const STATUS_ORDER:Array = new Array("Pending","Neighbor","NoNeighbor");
       
      
      private var _userId:String;
      
      private var _platformId:String;
      
      private var _name:String;
      
      private var _picUrl:String;
      
      private var _level:int;
      
      private var _status:String;
      
      public function Friend()
      {
         super();
      }
      
      public function init(data:Object) : void
      {
         assert("Loading player data.",true,data != null);
         _level = data.level;
         _userId = data.dcg_id != null ? data.dcg_id.toString() : _userId;
         for each(var platform_data in data.platforms_data)
         {
            _name = platform_data.name;
            if(!_name)
            {
               _name = ProjectManager.getText("DEFAULT_FRIEND_NAME");
            }
            _picUrl = platform_data.pic_url;
            _platformId = platform_data.user_id != null ? platform_data.user_id.toString() : null;
            _status = "Neighbor";
         }
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(level:int) : void
      {
         _level = level;
      }
      
      public function set name(name:String) : void
      {
         _name = name;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get firstName() : String
      {
         return name;
      }
      
      public function set id(userId:String) : void
      {
         _userId = userId;
      }
      
      public function get id() : String
      {
         return _userId;
      }
      
      public function get platformId() : String
      {
         return _platformId;
      }
      
      public function get picUrl() : String
      {
         return _picUrl;
      }
      
      public function set picUrl(picUrl:String) : void
      {
         _picUrl = picUrl;
      }
      
      public function set status(newStatus:String) : void
      {
         _status = newStatus;
      }
      
      public function get status() : String
      {
         return _status;
      }
      
      public function isNeighbor() : Boolean
      {
         return _status == "Neighbor";
      }
      
      public function isMe() : Boolean
      {
         return false;
      }
      
      public function equals(other:*) : Boolean
      {
         if(other is Friend)
         {
            return _userId == Friend(other).id;
         }
         return false;
      }
      
      public function toString() : String
      {
         return "Friend Name=" + _name + " userID=" + _userId + " platformID=" + _platformId + " pic=" + _picUrl + " level:" + _level + " status:" + _status;
      }
   }
}
