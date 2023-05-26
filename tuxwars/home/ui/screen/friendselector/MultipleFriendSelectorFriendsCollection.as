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
      
      public function search(value:String, excluded:Vector.<Object> = null) : void
      {
         var i:* = 0;
         var max:* = 0;
         var _loc4_:* = null;
         cancelSearch();
         if(!copyList)
         {
            copyList = new Vector.<Object>();
            copyList = dataList.concat();
         }
         searchResultList = new Vector.<Object>();
         if(value != "")
         {
            searchText = value;
            i = 0;
            max = dataList.length;
            for(i = 0; i < max; )
            {
               _loc4_ = MultipleFriendSelectorFriend(dataList[i]).name.toLocaleLowerCase();
               value = value.toLocaleLowerCase();
               if(_loc4_.indexOf(value) > -1)
               {
                  searchResultList.push(MultipleFriendSelectorFriend(dataList[i]));
               }
               i++;
            }
            dataList = searchResultList;
            updateFromIndex(0,excluded);
         }
         else if(dataList != null)
         {
            dataList = copyList;
            updateFromIndex(0,excluded);
            copyList = null;
         }
      }
      
      public function cancelSearch() : void
      {
         if(dataList != null && copyList != null)
         {
            dataList = copyList;
            copyList = null;
         }
      }
      
      public function sortByFirstName() : void
      {
         dataList.sort(sortFirstNameDescending);
      }
      
      public function sortByLastName() : void
      {
         dataList.sort(sortLastNameDescending);
      }
      
      private function sortFirstNameDescending(obj1:MultipleFriendSelectorFriend, obj2:MultipleFriendSelectorFriend) : int
      {
         var name1:String = obj1.firstName;
         var name2:String = obj2.firstName;
         if(name1 < name2)
         {
            return -1;
         }
         if(name1 > name2)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortLastNameDescending(obj1:MultipleFriendSelectorFriend, obj2:MultipleFriendSelectorFriend) : int
      {
         var name1:String = obj1.lastName;
         var name2:String = obj2.lastName;
         if(name1 < name2)
         {
            return -1;
         }
         if(name1 > name2)
         {
            return 1;
         }
         return 0;
      }
   }
}
