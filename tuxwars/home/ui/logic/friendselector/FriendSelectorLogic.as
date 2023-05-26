package tuxwars.home.ui.logic.friendselector
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.home.ui.screen.friendselector.GiftingInfo;
   import tuxwars.home.ui.screen.friendselector.MultipleFriendSelectorData;
   import tuxwars.net.SendRequestObject;
   import tuxwars.states.TuxState;
   
   public class FriendSelectorLogic extends TuxUILogic
   {
      
      public static const GIFTING:String = "GIFT";
      
      public static const INVITE:String = "INVITE";
      
      public static const HELP_REQUEST:String = "HELP";
       
      
      private var _sendRequest:SendRequestObject;
      
      public function FriendSelectorLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function get data() : MultipleFriendSelectorData
      {
         var returnData:MultipleFriendSelectorData = null;
         return new MultipleFriendSelectorData(header,description,imageDescription,null,null,buttonText,null,null);
      }
      
      public function get header() : String
      {
         return getText("HEADER");
      }
      
      public function get description() : String
      {
         return getText("DESCRIPTION");
      }
      
      public function get imageDescription() : String
      {
         return getText("DESCRIPTION_TWO");
      }
      
      public function get buttonText() : String
      {
         return getText("SEND");
      }
      
      public function getText(type:String) : String
      {
         return ProjectManager.getText("FS_" + _sendRequest.type + "_" + type);
      }
      
      public function getTabsContent(sendRequest:SendRequestObject) : Array
      {
         _sendRequest = sendRequest;
         if(sendRequest.type == "INVITE")
         {
            return getCallPlatformFilterInviteFriends();
         }
         if(sendRequest.type == "GIFT")
         {
            return getCallPlatformFilterGiftableFriends(sendRequest.giftReference);
         }
         return null;
      }
      
      public function getCallPlatformFilterGiftableFriends(giftItem:GiftReference) : Array
      {
         var giftingInfo:GiftingInfo = game.giftingInfo;
         var filterNameAppFriends:String = ProjectManager.getText("FS_APP_FRIENDS");
         var filterNameAllFriends:String = ProjectManager.getText("FS_ALL_FRIENDS");
         var filterNameNonAppFriends:String = ProjectManager.getText("FS_NON_APP_FRIENDS");
         return [{
            "name":filterNameAllFriends,
            "user_ids":giftingInfo.getAllGiftableFriendsByGiftId(giftItem.id)
         },{
            "name":filterNameNonAppFriends,
            "user_ids":giftingInfo.getGiftableNonAppFriendsByGiftId(giftItem.id)
         },{
            "name":filterNameAppFriends,
            "user_ids":giftingInfo.getGiftableAppFriendsByGiftId(giftItem.id)
         }];
      }
      
      public function getCallPlatformFilterInviteFriends() : Array
      {
         var giftingInfo:GiftingInfo = game.giftingInfo;
         var filterNameAllFriends:String = ProjectManager.getText("FS_ALL_FRIENDS");
         var filterNameNonAppFriends:String = ProjectManager.getText("FS_NON_APP_FRIENDS");
         var filterNameAppFriends:String = ProjectManager.getText("FS_APP_FRIENDS");
         return [{
            "name":filterNameAllFriends,
            "user_ids":giftingInfo.getAllFriends()
         },{
            "name":filterNameNonAppFriends,
            "user_ids":giftingInfo.getNonAppFriends()
         },{
            "name":filterNameAppFriends,
            "user_ids":giftingInfo.getAppFriends()
         }];
      }
   }
}
