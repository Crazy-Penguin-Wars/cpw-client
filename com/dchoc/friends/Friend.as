package com.dchoc.friends
{
   import com.dchoc.projectdata.*;
   import no.olog.utilfunctions.*;
   
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
      
      public function init(param1:Object) : void
      {
         var _loc2_:* = undefined;
         assert("Loading player data.",true,param1 != null);
         this._level = param1.level;
         this._userId = param1.dcg_id != null ? param1.dcg_id.toString() : this._userId;
         for each(_loc2_ in param1.platforms_data)
         {
            this._name = _loc2_.name;
            if(!this._name)
            {
               this._name = ProjectManager.getText("DEFAULT_FRIEND_NAME");
            }
            this._picUrl = _loc2_.pic_url;
            this._platformId = _loc2_.user_id != null ? _loc2_.user_id.toString() : null;
            this._status = "Neighbor";
         }
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get firstName() : String
      {
         return this.name;
      }
      
      public function set id(param1:String) : void
      {
         this._userId = param1;
      }
      
      public function get id() : String
      {
         return this._userId;
      }
      
      public function get platformId() : String
      {
         return this._platformId;
      }
      
      public function get picUrl() : String
      {
         return this._picUrl;
      }
      
      public function set picUrl(param1:String) : void
      {
         this._picUrl = param1;
      }
      
      public function set status(param1:String) : void
      {
         this._status = param1;
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function isNeighbor() : Boolean
      {
         return this._status == "Neighbor";
      }
      
      public function isMe() : Boolean
      {
         return false;
      }
      
      public function equals(param1:*) : Boolean
      {
         if(param1 is Friend)
         {
            return this._userId == Friend(param1).id;
         }
         return false;
      }
      
      public function toString() : String
      {
         return "Friend Name=" + this._name + " userID=" + this._userId + " platformID=" + this._platformId + " pic=" + this._picUrl + " level:" + this._level + " status:" + this._status;
      }
   }
}

