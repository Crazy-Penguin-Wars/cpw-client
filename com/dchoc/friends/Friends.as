package com.dchoc.friends
{
   public class Friends
   {
       
      
      private const _friends:Vector.<Friend> = new Vector.<Friend>();
      
      public function Friends()
      {
         super();
      }
      
      public function addFriend(friend:Friend) : void
      {
         if(!contains(friend))
         {
            _friends.push(friend);
         }
      }
      
      public function contains(friend:Friend) : Boolean
      {
         for each(var fr in _friends)
         {
            if(fr.equals(friend))
            {
               return true;
            }
         }
         return false;
      }
      
      public function get friends() : Vector.<Friend>
      {
         return _friends;
      }
      
      public function getFriend(id:String) : Friend
      {
         for each(var friend in _friends)
         {
            if(friend.id == id)
            {
               return friend;
            }
         }
         return null;
      }
      
      public function getFriends() : Vector.<Friend>
      {
         var _loc1_:Vector.<Friend> = new Vector.<Friend>();
         for each(var friend in _friends)
         {
            if(!friend.isMe())
            {
               _loc1_.push(friend);
            }
         }
         return _loc1_;
      }
      
      public function getOnlyNeighbors() : Vector.<Friend>
      {
         var _loc1_:Vector.<Friend> = new Vector.<Friend>();
         for each(var friend in _friends)
         {
            if(friend.isNeighbor())
            {
               _loc1_.push(friend);
            }
         }
         return _loc1_;
      }
      
      public function findMe() : Friend
      {
         for each(var friend in _friends)
         {
            if(friend.isMe())
            {
               return friend;
            }
         }
         return null;
      }
      
      public function changeFriendStatus(id:String, newStatus:String) : void
      {
         var i:int = 0;
         for(i = 0; i < _friends.length; )
         {
            if(_friends[i].id == id)
            {
               _friends[i].status = newStatus;
               break;
            }
            i++;
         }
      }
   }
}
