package tuxwars.home.ui.screen.friendselector
{
   public class MultipleFriendSelectorFriendsCollection extends CellList
   {
      private var copyList:Vector.<Object>;
      
      private var searchResultList:Vector.<Object>;
      
      private var sortList:Array;
      
      private var searchText:String = "";
      
      public function MultipleFriendSelectorFriendsCollection()
      {
         super();
      }
      
      public function search(param1:String, param2:Vector.<Object> = null) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         this.cancelSearch();
         if(!this.copyList)
         {
            this.copyList = new Vector.<Object>();
            this.copyList = dataList.concat();
         }
         this.searchResultList = new Vector.<Object>();
         if(param1 != "")
         {
            this.searchText = param1;
            _loc3_ = 0;
            _loc4_ = dataList.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = MultipleFriendSelectorFriend(dataList[_loc3_]).name.toLocaleLowerCase();
               param1 = param1.toLocaleLowerCase();
               if(_loc5_.indexOf(param1) > -1)
               {
                  this.searchResultList.push(MultipleFriendSelectorFriend(dataList[_loc3_]));
               }
               _loc3_++;
            }
            dataList = this.searchResultList;
            updateFromIndex(0,param2);
         }
         else if(dataList != null)
         {
            dataList = this.copyList;
            updateFromIndex(0,param2);
            this.copyList = null;
         }
      }
      
      public function cancelSearch() : void
      {
         if(dataList != null && this.copyList != null)
         {
            dataList = this.copyList;
            this.copyList = null;
         }
      }
      
      public function sortByFirstName() : void
      {
         dataList.sort(this.sortFirstNameDescending);
      }
      
      public function sortByLastName() : void
      {
         dataList.sort(this.sortLastNameDescending);
      }
      
      private function sortFirstNameDescending(param1:MultipleFriendSelectorFriend, param2:MultipleFriendSelectorFriend) : int
      {
         var _loc3_:String = param1.firstName;
         var _loc4_:String = param2.firstName;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortLastNameDescending(param1:MultipleFriendSelectorFriend, param2:MultipleFriendSelectorFriend) : int
      {
         var _loc3_:String = param1.lastName;
         var _loc4_:String = param2.lastName;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
   }
}

