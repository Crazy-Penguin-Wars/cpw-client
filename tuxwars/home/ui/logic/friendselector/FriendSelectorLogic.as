package tuxwars.home.ui.logic.friendselector
{
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.home.ui.screen.friendselector.*;
   import tuxwars.net.SendRequestObject;
   import tuxwars.states.TuxState;
   
   public class FriendSelectorLogic extends TuxUILogic
   {
      public static const GIFTING:String = "GIFT";
      
      public static const INVITE:String = "INVITE";
      
      public static const HELP_REQUEST:String = "HELP";
      
      private var _sendRequest:SendRequestObject;
      
      public function FriendSelectorLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function get data() : MultipleFriendSelectorData
      {
         var _loc1_:MultipleFriendSelectorData = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         return new MultipleFriendSelectorData(this.header,this.description,this.imageDescription,_loc4_,_loc5_,this.buttonText,_loc2_,_loc3_);
      }
      
      public function get header() : String
      {
         return this.getText("HEADER");
      }
      
      public function get description() : String
      {
         return this.getText("DESCRIPTION");
      }
      
      public function get imageDescription() : String
      {
         return this.getText("DESCRIPTION_TWO");
      }
      
      public function get buttonText() : String
      {
         return this.getText("SEND");
      }
      
      public function getText(param1:String) : String
      {
         return ProjectManager.getText("FS_" + this._sendRequest.type + "_" + param1);
      }
      
      public function getTabsContent(param1:SendRequestObject) : Array
      {
         this._sendRequest = param1;
         if(param1.type == "INVITE")
         {
            return this.getCallPlatformFilterInviteFriends();
         }
         if(param1.type == "GIFT")
         {
            return this.getCallPlatformFilterGiftableFriends(param1.giftReference);
         }
         return null;
      }
      
      public function getCallPlatformFilterGiftableFriends(param1:GiftReference) : Array
      {
         var _loc2_:GiftingInfo = game.giftingInfo;
         var _loc3_:String = ProjectManager.getText("FS_APP_FRIENDS");
         var _loc4_:String = ProjectManager.getText("FS_ALL_FRIENDS");
         var _loc5_:String = ProjectManager.getText("FS_NON_APP_FRIENDS");
         return [{
            "name":_loc4_,
            "user_ids":_loc2_.getAllGiftableFriendsByGiftId(param1.id)
         },{
            "name":_loc5_,
            "user_ids":_loc2_.getGiftableNonAppFriendsByGiftId(param1.id)
         },{
            "name":_loc3_,
            "user_ids":_loc2_.getGiftableAppFriendsByGiftId(param1.id)
         }];
      }
      
      public function getCallPlatformFilterInviteFriends() : Array
      {
         var _loc1_:GiftingInfo = game.giftingInfo;
         var _loc2_:String = ProjectManager.getText("FS_ALL_FRIENDS");
         var _loc3_:String = ProjectManager.getText("FS_NON_APP_FRIENDS");
         var _loc4_:String = ProjectManager.getText("FS_APP_FRIENDS");
         return [{
            "name":_loc2_,
            "user_ids":_loc1_.getAllFriends()
         },{
            "name":_loc3_,
            "user_ids":_loc1_.getNonAppFriends()
         },{
            "name":_loc4_,
            "user_ids":_loc1_.getAppFriends()
         }];
      }
   }
}

