package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.friends.Friend;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainers;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.inbox.RequestData;
   
   public class InboxContainers extends UIContainers
   {
      
      public static const TYPE_GIFT_EMPTY:String = "Gifts_Empty";
      
      public static const TYPE_GIFT:String = "Gifts_Default";
      
      public static const TYPE_NEIGHBOR_EMPTY:String = "Neighbor_Empty";
      
      public static const TYPE_NEIGHBOR:String = "Neighbor_Default";
      
      private static const DUMMY_PLAYER_PIC:String = "facebook/misc_images/dummy_friend_picture.png";
       
      
      private var _tuxGame:TuxWarsGame;
      
      public function InboxContainers(object:RequestData, design:MovieClip, game:TuxWarsGame, parent:UIComponent = null)
      {
         super();
         design.visible = true;
         _tuxGame = game;
         LogUtils.log("Adding slot of type: " + object.type,this,0,"Inbox",false,false,false);
         add("Gifts_Empty",new InboxNoGifts(object,design.getChildByName("Gifts_Empty") as MovieClip,parent));
         add("Gifts_Default",new InboxGift(object,design.getChildByName("Gifts_Default") as MovieClip,parent));
         add("Neighbor_Empty",new InboxNoNeighbors(object,design.getChildByName("Neighbor_Empty") as MovieClip,parent));
         add("Neighbor_Default",new InboxNeighbor(object,design.getChildByName("Neighbor_Default") as MovieClip,parent));
         switch((object as RequestData).type)
         {
            case "Gifts_Default":
               (getContainer("Gifts_Default") as InboxGift).setFriend(getFriendFromRequestData(object),_tuxGame.player.id);
               show("Gifts_Default",false);
               break;
            case "Gifts_Empty":
               show("Gifts_Empty",false);
               break;
            case "Neighbor_Default":
               (getContainer("Neighbor_Default") as InboxNeighbor).setFriend(getFriendFromRequestData(object),_tuxGame.player.id);
               show("Neighbor_Default",false);
               break;
            case "Neighbor_Empty":
               show("Neighbor_Empty",false);
               break;
            default:
               LogUtils.log("Unknown slot content for inbox type: " + (object as RequestData).type,this,2,"Inbox",false,false,false);
         }
      }
      
      private function getFriendFromRequestData(rData:RequestData) : Friend
      {
         var _loc2_:* = null;
         var friend:Friend = new Friend();
         if(rData.feedRewardGift)
         {
            _loc2_ = {"platforms_data":[{
               "name":ProjectManager.getText("BOSS_PENGUIN_NAME"),
               "pic_url":Config.getDataDir() + "facebook/misc_images/dummy_friend_picture.png"
            }]};
            friend.init(_loc2_);
         }
         else if(rData.senderID)
         {
            friend = _tuxGame.player.friends.getFriend(rData.senderID);
            if(!friend)
            {
               friend = new Friend();
               friend.name = ProjectManager.getText("DEFAULT_FRIEND_NAME");
            }
         }
         else
         {
            friend.init(!!rData.data.user ? rData.data.user : rData.data);
         }
         return friend;
      }
   }
}
