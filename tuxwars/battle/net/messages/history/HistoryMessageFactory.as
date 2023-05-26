package tuxwars.battle.net.messages.history
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class HistoryMessageFactory
   {
      
      private static const LATEST_HISTORY_MESSAGES:Object = {};
       
      
      public function HistoryMessageFactory()
      {
         super();
         throw new Error("HistoryMessageFactory is a static class!");
      }
      
      public static function sendOSMessage(playerId:String, os:String) : void
      {
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(playerId != _loc3_._id)
         {
            return;
         }
         sendMessage(playerId,"os",os);
      }
      
      public static function sendChallengeCounterMessage(playerId:String, counter:String, value:int) : void
      {
         var _loc5_:* = BattleManager.getLocalPlayer();
         if(playerId != _loc5_._id)
         {
            return;
         }
         var _loc4_:Object = {};
         _loc4_[counter] = value;
         sendMessage(playerId,"challengeCounters",_loc4_);
      }
      
      public static function sendReportMessage(playerId:String, reportId:String, value:int) : void
      {
         var _loc5_:* = BattleManager.getLocalPlayer();
         if(playerId != _loc5_._id)
         {
            return;
         }
         var _loc4_:Object = {};
         _loc4_[reportId] = value;
         sendMessage(playerId,"statistics",_loc4_);
      }
      
      public static function sendCompletedChallengeMessage(playerId:String, challengeId:String) : void
      {
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(playerId != _loc3_._id)
         {
            return;
         }
         sendMessage(playerId,"challenges",[challengeId]);
      }
      
      public static function sendEarnedItemsMessage(player:PlayerGameObject, itemId:String, amount:int = 1) : void
      {
         var _loc4_:* = player;
         var _loc5_:* = BattleManager.getLocalPlayer();
         if(_loc4_._id != _loc5_._id)
         {
            return;
         }
         var _loc6_:* = player;
         sendMessage(_loc6_._id,"earnedItems",parseArray([{
            "id":itemId,
            "amount":amount
         }]));
      }
      
      public static function sendUsedItemsMessage(playerId:String, itemId:String) : void
      {
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(playerId != _loc3_._id)
         {
            return;
         }
         sendMessage(playerId,"usedItems",parseArray([{
            "id":itemId,
            "amount":1
         }]));
      }
      
      public static function sendScoreMessage(player:PlayerGameObject) : void
      {
         var _loc2_:* = player;
         sendMessage(_loc2_._id,"score",player.getScore());
      }
      
      public static function sendHitPointsMessage(player:PlayerGameObject) : void
      {
         var _loc2_:* = player;
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(_loc2_._id != _loc3_._id)
         {
            return;
         }
         var _loc4_:* = player;
         sendMessage(_loc4_._id,"hitPoints",player.calculateHitPoints());
      }
      
      public static function sendGainedExpMessage(player:PlayerGameObject) : void
      {
         var _loc2_:* = player;
         sendMessage(_loc2_._id,"experience",player.rewardsHandler.getExperienceGained());
      }
      
      public static function sendGainedCoinsMessage(player:PlayerGameObject) : void
      {
         var _loc2_:* = player;
         sendMessage(_loc2_._id,"coins",player.rewardsHandler.getInGameMoneyGained());
      }
      
      public static function sendGainedCashMessage(player:PlayerGameObject) : void
      {
         var _loc2_:* = player;
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(_loc2_._id != _loc3_._id)
         {
            return;
         }
         var _loc4_:* = player;
         sendMessage(_loc4_._id,"cash",player.rewardsHandler.getPremiumMoneyGained());
      }
      
      private static function sendMessage(id:String, type:String, value:*) : void
      {
         var _loc4_:Object = {};
         _loc4_[id] = {};
         _loc4_[id][type] = value;
         MessageCenter.sendEvent(new HistoryMessage(_loc4_));
      }
      
      private static function parseArray(array:Array) : Object
      {
         var _loc2_:Object = {};
         for each(var obj in array)
         {
            if(Config.debugMode && (!obj.hasOwnProperty("id") || !obj.hasOwnProperty("amount")))
            {
               LogUtils.log("Warning! No id or amount defined for history message!","HistoryMessageFactory",3,"Messages",false,false,true);
            }
            else
            {
               _loc2_[obj.id] = obj.amount;
            }
         }
         return _loc2_;
      }
   }
}
