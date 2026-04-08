package tuxwars.home.ui.screen.friendselector
{
   public class MultipleFriendSelectorFriend
   {
      private var mFirstName:String;
      
      private var mLastName:String;
      
      private var mId:String;
      
      public function MultipleFriendSelectorFriend(param1:String, param2:String, param3:String)
      {
         super();
         this.mFirstName = param1;
         this.mLastName = param2;
         this.mId = param3;
      }
      
      public function get firstName() : String
      {
         return this.mFirstName;
      }
      
      public function get lastName() : String
      {
         return this.mLastName;
      }
      
      public function get name() : String
      {
         return (this.mFirstName != null ? this.mFirstName : "") + (this.mLastName != null ? " " + this.mLastName : "");
      }
      
      public function get id() : String
      {
         return this.mId;
      }
   }
}

