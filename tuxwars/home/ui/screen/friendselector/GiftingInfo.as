package tuxwars.home.ui.screen.friendselector
{
   public class GiftingInfo
   {
      
      private static const FILTER_ALL_FRIENDS:int = 0;
      
      private static const FILTER_APP_FRIENDS:int = 1;
      
      private static const FILTER_NON_APP_FRIENDS:int = 2;
       
      
      private var mFriends:Object;
      
      private var mGiftIds:Array;
      
      public function GiftingInfo(friends:Object)
      {
         super();
         if(friends)
         {
            mFriends = friends.friend is Array ? friends.friend : [friends.friend];
         }
         else
         {
            mFriends = new Array(0);
         }
      }
      
      public function getFriends(filter:int) : String
      {
         var returnVal:Array = [];
         for each(var friend in mFriends)
         {
            if(friend)
            {
               if(!(filter == 1 && !friend.isPlaying))
               {
                  if(!(filter == 2 && friend.isPlaying))
                  {
                     if(returnVal.indexOf(friend.platformId) == -1)
                     {
                        returnVal.push(friend.platformId);
                     }
                  }
               }
            }
         }
         return returnVal.toString();
      }
      
      public function getAllFriends() : String
      {
         return getFriends(0);
      }
      
      public function getAppFriends() : String
      {
         return getFriends(1);
      }
      
      public function getNonAppFriends() : String
      {
         return getFriends(2);
      }
      
      public function getGiftableFriendsByGiftId(giftId:String, filter:int) : String
      {
         var found:Boolean = false;
         var returnVal:Vector.<Object> = new Vector.<Object>();
         for each(var friend in mFriends)
         {
            if(friend)
            {
               if(!(filter == 1 && !friend.isPlaying))
               {
                  if(!(filter == 2 && friend.isPlaying))
                  {
                     found = false;
                     if(friend.gifts)
                     {
                        for each(var gift in friend.gifts)
                        {
                           if(gift == giftId)
                           {
                              found = true;
                           }
                        }
                     }
                     if(returnVal.indexOf(friend.platformId) == -1)
                     {
                        if(!found)
                        {
                           returnVal.push(friend.platformId);
                        }
                     }
                  }
               }
            }
         }
         return returnVal.toString();
      }
      
      public function getAllGiftableFriendsByGiftId(giftId:String) : String
      {
         return getGiftableFriendsByGiftId(giftId,0);
      }
      
      public function getGiftableAppFriendsByGiftId(giftId:String) : String
      {
         return getGiftableFriendsByGiftId(giftId,1);
      }
      
      public function getGiftableNonAppFriendsByGiftId(giftId:String) : String
      {
         return getGiftableFriendsByGiftId(giftId,2);
      }
      
      public function addGiftForFriends(giftId:String, friendsList:String) : void
      {
         var previous:* = null;
         var friendsReceivingGift:Array = friendsList.split(",");
         for each(var friendToAddGiftTo in friendsReceivingGift)
         {
            for each(var friend in mFriends)
            {
               if(friend)
               {
                  if(friendToAddGiftTo == friend.platformId)
                  {
                     if(!friend.gifts)
                     {
                        friend.gifts = [];
                     }
                     if(!(friend.gifts is Array))
                     {
                        previous = friend.gifts.giftId;
                        friend.gifts = [];
                        friend.gifts.push(previous);
                     }
                     friend.gifts.push(giftId);
                  }
               }
            }
         }
      }
      
      public function getFriendInfoByPlatformUserId(id:String) : Object
      {
         for each(var friend in mFriends)
         {
            if(friend)
            {
               if(friend.platformId == id)
               {
                  return friend;
               }
            }
         }
         return null;
      }
   }
}
