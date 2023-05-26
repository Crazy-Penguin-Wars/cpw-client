package tuxwars.home.ui.screen.friendselector
{
   public class MultipleFriendSelectorFriend
   {
       
      
      private var mFirstName:String;
      
      private var mLastName:String;
      
      private var mId:String;
      
      public function MultipleFriendSelectorFriend(firstName:String, lastName:String, id:String)
      {
         super();
         mFirstName = firstName;
         mLastName = lastName;
         mId = id;
      }
      
      public function get firstName() : String
      {
         return mFirstName;
      }
      
      public function get lastName() : String
      {
         return mLastName;
      }
      
      public function get name() : String
      {
         return (mFirstName != null ? mFirstName : "") + (mLastName != null ? " " + mLastName : "");
      }
      
      public function get id() : String
      {
         return mId;
      }
   }
}
