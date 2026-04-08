package tuxwars.battle.net.messages.history
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class HistoryMessageFactory
   {
      private static const LATEST_HISTORY_MESSAGES:Object = {};
      
      public function HistoryMessageFactory()
      {
         super();
         throw new Error("HistoryMessageFactory is a static class!");
      }
      
      public static function sendOSMessage(param1:String, param2:String) : void
      {
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(param1 != _loc3_._id)
         {
            return;
         }
         sendMessage(param1,"os",param2);
      }
      
      public static function sendChallengeCounterMessage(param1:String, param2:String, param3:int) : void
      {
         var _loc4_:* = BattleManager.getLocalPlayer();
         if(param1 != _loc4_._id)
         {
            return;
         }
         var _loc5_:Object = {};
         _loc5_[param2] = param3;
         sendMessage(param1,"challengeCounters",_loc5_);
      }
      
      public static function sendReportMessage(param1:String, param2:String, param3:int) : void
      {
         var _loc4_:* = BattleManager.getLocalPlayer();
         if(param1 != _loc4_._id)
         {
            return;
         }
         var _loc5_:Object = {};
         _loc5_[param2] = param3;
         sendMessage(param1,"statistics",_loc5_);
      }
      
      public static function sendCompletedChallengeMessage(param1:String, param2:String) : void
      {
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(param1 != _loc3_._id)
         {
            return;
         }
         sendMessage(param1,"challenges",[param2]);
      }
      
      public static function sendEarnedItemsMessage(param1:PlayerGameObject, param2:String, param3:int = 1) : void
      {
         var _loc4_:* = param1;
         var _loc5_:* = BattleManager.getLocalPlayer();
         if(_loc4_._id != _loc5_._id)
         {
            return;
         }
         var _loc6_:* = param1;
         sendMessage(_loc6_._id,"earnedItems",parseArray([{
            "id":param2,
            "amount":param3
         }]));
      }
      
      public static function sendUsedItemsMessage(param1:String, param2:String) : void
      {
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(param1 != _loc3_._id)
         {
            return;
         }
         sendMessage(param1,"usedItems",parseArray([{
            "id":param2,
            "amount":1
         }]));
      }
      
      public static function sendScoreMessage(param1:PlayerGameObject) : void
      {
         var _loc2_:* = param1;
         sendMessage(_loc2_._id,"score",param1.getScore());
      }
      
      public static function sendHitPointsMessage(param1:PlayerGameObject) : void
      {
         var _loc2_:* = param1;
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(_loc2_._id != _loc3_._id)
         {
            return;
         }
         var _loc4_:* = param1;
         sendMessage(_loc4_._id,"hitPoints",param1.calculateHitPoints());
      }
      
      public static function sendGainedExpMessage(param1:PlayerGameObject) : void
      {
         var _loc2_:* = param1;
         sendMessage(_loc2_._id,"experience",param1.rewardsHandler.getExperienceGained());
      }
      
      public static function sendGainedCoinsMessage(param1:PlayerGameObject) : void
      {
         var _loc2_:* = param1;
         sendMessage(_loc2_._id,"coins",param1.rewardsHandler.getInGameMoneyGained());
      }
      
      public static function sendGainedCashMessage(param1:PlayerGameObject) : void
      {
         var _loc2_:* = param1;
         var _loc3_:* = BattleManager.getLocalPlayer();
         if(_loc2_._id != _loc3_._id)
         {
            return;
         }
         var _loc4_:* = param1;
         sendMessage(_loc4_._id,"cash",param1.rewardsHandler.getPremiumMoneyGained());
      }
      
      private static function sendMessage(param1:String, param2:String, param3:*) : void
      {
         var _loc4_:Object = {};
         _loc4_[param1] = {};
         _loc4_[param1][param2] = param3;
         MessageCenter.sendEvent(new HistoryMessage(_loc4_));
      }
      
      private static function parseArray(param1:Array) : Object
      {
         var _loc3_:* = undefined;
         var _loc2_:Object = {};
         for each(_loc3_ in param1)
         {
            if(Config.debugMode && (!_loc3_.hasOwnProperty("id") || !_loc3_.hasOwnProperty("amount")))
            {
               LogUtils.log("Warning! No id or amount defined for history message!","HistoryMessageFactory",3,"Messages",false,false,true);
            }
            else
            {
               _loc2_[_loc3_.id] = _loc3_.amount;
            }
         }
         return _loc2_;
      }
   }
}

