package com.dchoc.friends
{
   public class Friends
   {
      private const _friends:Vector.<Friend> = new Vector.<Friend>();
      
      public function Friends()
      {
         super();
      }
      
      public function addFriend(param1:Friend) : void
      {
         if(!this.contains(param1))
         {
            this._friends.push(param1);
         }
      }
      
      public function contains(param1:Friend) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._friends)
         {
            if(_loc2_.equals(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function get friends() : Vector.<Friend>
      {
         return this._friends;
      }
      
      public function getFriend(param1:String) : Friend
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._friends)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getFriends() : Vector.<Friend>
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<Friend> = new Vector.<Friend>();
         for each(_loc2_ in this._friends)
         {
            if(!_loc2_.isMe())
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getOnlyNeighbors() : Vector.<Friend>
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<Friend> = new Vector.<Friend>();
         for each(_loc2_ in this._friends)
         {
            if(_loc2_.isNeighbor())
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function findMe() : Friend
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._friends)
         {
            if(_loc1_.isMe())
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function changeFriendStatus(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._friends.length)
         {
            if(this._friends[_loc3_].id == param1)
            {
               this._friends[_loc3_].status = param2;
               break;
            }
            _loc3_++;
         }
      }
   }
}

