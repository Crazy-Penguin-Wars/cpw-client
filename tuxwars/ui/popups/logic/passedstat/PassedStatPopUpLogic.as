package tuxwars.ui.popups.logic.passedstat
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.net.ServerRequest;
   import com.dchoc.net.ServerResponse;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.inbox.InboxManager;
   import tuxwars.net.FeedService;
   import tuxwars.player.TuxFriend;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   
   public class PassedStatPopUpLogic extends PopUpBaseLogic
   {
       
      
      public function PassedStatPopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("facebookFeedPostedCallback",feedPosted);
         super.dispose();
      }
      
      public function postFeed() : void
      {
         var _loc1_:String = getFeedId();
         if(_loc1_ != null)
         {
            MessageCenter.addListener("facebookFeedPostedCallback",feedPosted);
            FeedService.publishMessage(_loc1_,null,passedFriend.platformId);
         }
      }
      
      private function feedPosted(msg:Message) : void
      {
         MessageCenter.sendEvent(new ServerRequest("RewardGift",null,false,rewardCallback));
      }
      
      private function rewardCallback(response:ServerResponse) : void
      {
         InboxManager.triggerContentUpdate();
      }
      
      public function get passedFriend() : TuxFriend
      {
         return game.player.friends.getFriend(data.previousPlayerId) as TuxFriend;
      }
      
      private function get data() : PassedStatData
      {
         return params;
      }
      
      private function getFeedId() : String
      {
         switch(data.stat)
         {
            case "kills":
               return "LEADER_KILLS";
            case "wins":
               return "LEADER_WINS";
            case "avg_position":
               return "LEADER_AVG_POS";
            case "coins":
               return "LEADER_COINS";
            case "xp":
               return "LEADER_XP";
            case "score":
               return "LEADER_AVG_SCORE";
            default:
               return null;
         }
      }
   }
}
