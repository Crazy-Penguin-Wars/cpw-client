package tuxwars.challenges
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.loot.LootPopupSubState;
   
   public class ChallengeRewardsManager
   {
      
      private static var _instance:ChallengeRewardsManager;
      
      private static var _tuxGame:TuxWarsGame;
       
      
      public function ChallengeRewardsManager()
      {
         super();
      }
      
      public static function get instance() : ChallengeRewardsManager
      {
         if(!_instance)
         {
            _instance = new ChallengeRewardsManager();
         }
         return _instance;
      }
      
      public function init(game:TuxWarsGame) : void
      {
         _tuxGame = game;
         addListeners();
      }
      
      public function dispose() : void
      {
         _tuxGame = null;
         removeListeners();
      }
      
      private function updateChallengesServerResponse(msg:Message) : void
      {
         var completedChallenges:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(msg.data)
         {
            if(msg.data.confirmation_results && msg.data.confirmation_results.earned_trophies)
            {
               giveTrophies(msg.data.confirmation_results.earned_trophies);
            }
            if(msg.data.confirmation_results && msg.data.confirmation_results.completed_challenges && msg.data.confirmation_results.completed_challenges.challenge)
            {
               completedChallenges = msg.data.confirmation_results.completed_challenges.challenge;
            }
            else if(msg.data.completed_challenge_id)
            {
               completedChallenges = {};
               completedChallenges["challenge_id"] = msg.data.completed_challenge_id;
            }
            if(completedChallenges)
            {
               var _loc7_:ChallengeManager = ChallengeManager;
               if(!tuxwars.challenges.ChallengeManager._instance)
               {
                  tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
               }
               _loc2_ = tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(_tuxGame.player.id);
               _loc4_ = completedChallenges.challenge_id is Array ? completedChallenges.challenge_id : [completedChallenges.challenge_id];
               for each(var challengeId in _loc4_)
               {
                  _loc3_ = _loc2_.findChallenge(challengeId);
                  if(_loc3_)
                  {
                     LogUtils.log("Giving rewards for challenge " + _loc3_.id,"ResultLogic",1,"Challenges",true,false,true);
                     giveChallengeRewards(_loc3_);
                     _loc2_.removeChallenge(_loc3_);
                  }
               }
            }
            var _loc10_:Tutorial = Tutorial;
            if(!tuxwars.tutorial.Tutorial._tutorial)
            {
               if(msg.data.confirmation_results)
               {
                  activateNewChallenges(msg.data.confirmation_results.active_challenges);
               }
               else
               {
                  activateNewChallenges(msg.data.active_challenges);
               }
            }
            MessageCenter.sendMessage("ChallengesUpdated");
         }
      }
      
      private function activateNewChallenges(data:Object) : void
      {
         var _loc2_:* = null;
         if(data)
         {
            var _loc3_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            _loc2_ = tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(_tuxGame.player.id);
            if(_loc2_)
            {
               _loc2_.update(data);
            }
            else
            {
               LogUtils.log("Cannot update challenges!!",this,3,"Challenges");
            }
         }
      }
      
      private function giveTrophies(data:Object) : void
      {
         var _loc3_:* = null;
         if(data)
         {
            _loc3_ = data.item is Array ? data.item : [data.item];
            for each(var itemData in _loc3_)
            {
               LogUtils.log("Giving trophy " + itemData.item_id,"ResultLogic",1,"Trophies",true,false,true);
               _tuxGame.player.inventory.addItem(itemData.item_id);
               var _loc4_:PopUpManager = PopUpManager;
               if(!tuxwars.ui.popups.PopUpManager._instance)
               {
                  tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
               }
               tuxwars.ui.popups.PopUpManager._instance.addPopup(new LootPopupSubState(_tuxGame,ItemManager.getItemData(itemData.item_id)));
            }
         }
      }
      
      private function giveChallengeRewards(challenge:Challenge) : void
      {
         if(challenge)
         {
            _tuxGame.player.addExp(challenge.rewardExp);
            _tuxGame.player.addIngameMoney(challenge.rewardCoins);
            _tuxGame.player.addPremiumMoney(challenge.rewardCash);
         }
         else
         {
            LogUtils.log("Challenge data missing when trying to give reward","ChallengeRewardsManager",2,"Challenges");
         }
      }
      
      private function addListeners() : void
      {
         MessageCenter.addListener("ChallengesUpdateServerResponse",updateChallengesServerResponse);
      }
      
      private function removeListeners() : void
      {
         MessageCenter.removeListener("ChallengesUpdateServerResponse",updateChallengesServerResponse);
      }
   }
}
