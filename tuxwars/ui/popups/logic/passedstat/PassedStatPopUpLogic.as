package tuxwars.ui.popups.logic.passedstat
{
   import com.dchoc.messages.*;
   import com.dchoc.net.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.net.*;
   import tuxwars.player.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   
   public class PassedStatPopUpLogic extends PopUpBaseLogic
   {
      public function PassedStatPopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("facebookFeedPostedCallback",this.feedPosted);
         super.dispose();
      }
      
      public function postFeed() : void
      {
         var _loc1_:String = this.getFeedId();
         if(_loc1_ != null)
         {
            MessageCenter.addListener("facebookFeedPostedCallback",this.feedPosted);
            FeedService.publishMessage(_loc1_,null,this.passedFriend.platformId);
         }
      }
      
      private function feedPosted(param1:Message) : void
      {
         MessageCenter.sendEvent(new ServerRequest("RewardGift",null,false,this.rewardCallback));
      }
      
      private function rewardCallback(param1:ServerResponse) : void
      {
         InboxManager.triggerContentUpdate();
      }
      
      public function get passedFriend() : TuxFriend
      {
         return game.player.friends.getFriend(this.data.previousPlayerId) as TuxFriend;
      }
      
      private function get data() : PassedStatData
      {
         return params;
      }
      
      private function getFeedId() : String
      {
         switch(this.data.stat)
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

