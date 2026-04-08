package tuxwars.home.ui.screen.friendselector
{
   public class GiftingInfo
   {
      private static const FILTER_ALL_FRIENDS:int = 0;
      
      private static const FILTER_APP_FRIENDS:int = 1;
      
      private static const FILTER_NON_APP_FRIENDS:int = 2;
      
      private var mFriends:Object;
      
      private var mGiftIds:Array;
      
      public function GiftingInfo(param1:Object)
      {
         super();
         if(param1)
         {
            this.mFriends = param1.friend is Array ? param1.friend : [param1.friend];
         }
         else
         {
            this.mFriends = new Array(0);
         }
      }
      
      public function getFriends(param1:int) : String
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in this.mFriends)
         {
            if(_loc3_)
            {
               if(!(param1 == 1 && !_loc3_.isPlaying))
               {
                  if(!(param1 == 2 && _loc3_.isPlaying))
                  {
                     if(_loc2_.indexOf(_loc3_.platformId) == -1)
                     {
                        _loc2_.push(_loc3_.platformId);
                     }
                  }
               }
            }
         }
         return _loc2_.toString();
      }
      
      public function getAllFriends() : String
      {
         return this.getFriends(0);
      }
      
      public function getAppFriends() : String
      {
         return this.getFriends(1);
      }
      
      public function getNonAppFriends() : String
      {
         return this.getFriends(2);
      }
      
      public function getGiftableFriendsByGiftId(param1:String, param2:int) : String
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:Boolean = false;
         var _loc4_:Vector.<Object> = new Vector.<Object>();
         for each(_loc5_ in this.mFriends)
         {
            if(_loc5_)
            {
               if(!(param2 == 1 && !_loc5_.isPlaying))
               {
                  if(!(param2 == 2 && _loc5_.isPlaying))
                  {
                     _loc3_ = false;
                     if(_loc5_.gifts)
                     {
                        for each(_loc6_ in _loc5_.gifts)
                        {
                           if(_loc6_ == param1)
                           {
                              _loc3_ = true;
                           }
                        }
                     }
                     if(_loc4_.indexOf(_loc5_.platformId) == -1)
                     {
                        if(!_loc3_)
                        {
                           _loc4_.push(_loc5_.platformId);
                        }
                     }
                  }
               }
            }
         }
         return _loc4_.toString();
      }
      
      public function getAllGiftableFriendsByGiftId(param1:String) : String
      {
         return this.getGiftableFriendsByGiftId(param1,0);
      }
      
      public function getGiftableAppFriendsByGiftId(param1:String) : String
      {
         return this.getGiftableFriendsByGiftId(param1,1);
      }
      
      public function getGiftableNonAppFriendsByGiftId(param1:String) : String
      {
         return this.getGiftableFriendsByGiftId(param1,2);
      }
      
      public function addGiftForFriends(param1:String, param2:String) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:Array = param2.split(",");
         for each(_loc5_ in _loc4_)
         {
            for each(_loc6_ in this.mFriends)
            {
               if(_loc6_)
               {
                  if(_loc5_ == _loc6_.platformId)
                  {
                     if(!_loc6_.gifts)
                     {
                        _loc6_.gifts = [];
                     }
                     if(!(_loc6_.gifts is Array))
                     {
                        _loc3_ = _loc6_.gifts.giftId;
                        _loc6_.gifts = [];
                        _loc6_.gifts.push(_loc3_);
                     }
                     _loc6_.gifts.push(param1);
                  }
               }
            }
         }
      }
      
      public function getFriendInfoByPlatformUserId(param1:String) : Object
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.mFriends)
         {
            if(_loc2_)
            {
               if(_loc2_.platformId == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
   }
}

