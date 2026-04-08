package tuxwars.home.ui.screen.inbox.container
{
   import com.dchoc.friends.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainers;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.inbox.*;
   
   public class InboxContainers extends UIContainers
   {
      public static const TYPE_GIFT_EMPTY:String = "Gifts_Empty";
      
      public static const TYPE_GIFT:String = "Gifts_Default";
      
      public static const TYPE_NEIGHBOR_EMPTY:String = "Neighbor_Empty";
      
      public static const TYPE_NEIGHBOR:String = "Neighbor_Default";
      
      private static const DUMMY_PLAYER_PIC:String = "facebook/misc_images/dummy_friend_picture.png";
      
      private var _tuxGame:TuxWarsGame;
      
      public function InboxContainers(param1:RequestData, param2:MovieClip, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super();
         param2.visible = true;
         this._tuxGame = param3;
         LogUtils.log("Adding slot of type: " + param1.type,this,0,"Inbox",false,false,false);
         add("Gifts_Empty",new InboxNoGifts(param1,param2.getChildByName("Gifts_Empty") as MovieClip,param4));
         add("Gifts_Default",new InboxGift(param1,param2.getChildByName("Gifts_Default") as MovieClip,param4));
         add("Neighbor_Empty",new InboxNoNeighbors(param1,param2.getChildByName("Neighbor_Empty") as MovieClip,param4));
         add("Neighbor_Default",new InboxNeighbor(param1,param2.getChildByName("Neighbor_Default") as MovieClip,param4));
         switch((param1 as RequestData).type)
         {
            case "Gifts_Default":
               (getContainer("Gifts_Default") as InboxGift).setFriend(this.getFriendFromRequestData(param1),this._tuxGame.player.id);
               show("Gifts_Default",false);
               break;
            case "Gifts_Empty":
               show("Gifts_Empty",false);
               break;
            case "Neighbor_Default":
               (getContainer("Neighbor_Default") as InboxNeighbor).setFriend(this.getFriendFromRequestData(param1),this._tuxGame.player.id);
               show("Neighbor_Default",false);
               break;
            case "Neighbor_Empty":
               show("Neighbor_Empty",false);
               break;
            default:
               LogUtils.log("Unknown slot content for inbox type: " + (param1 as RequestData).type,this,2,"Inbox",false,false,false);
         }
      }
      
      private function getFriendFromRequestData(param1:RequestData) : Friend
      {
         var _loc2_:Object = null;
         var _loc3_:Friend = new Friend();
         if(param1.feedRewardGift)
         {
            _loc2_ = {"platforms_data":[{
               "name":ProjectManager.getText("BOSS_PENGUIN_NAME"),
               "pic_url":Config.getDataDir() + "facebook/misc_images/dummy_friend_picture.png"
            }]};
            _loc3_.init(_loc2_);
         }
         else if(param1.senderID)
         {
            _loc3_ = this._tuxGame.player.friends.getFriend(param1.senderID);
            if(!_loc3_)
            {
               _loc3_ = new Friend();
               _loc3_.name = ProjectManager.getText("DEFAULT_FRIEND_NAME");
            }
         }
         else
         {
            _loc3_.init(!!param1.data.user ? param1.data.user : param1.data);
         }
         return _loc3_;
      }
   }
}

