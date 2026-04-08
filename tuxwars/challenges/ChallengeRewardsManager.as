package tuxwars.challenges
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.managers.*;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.loot.*;
   
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
      
      public function init(param1:TuxWarsGame) : void
      {
         _tuxGame = param1;
         this.addListeners();
      }
      
      public function dispose() : void
      {
         _tuxGame = null;
         this.removeListeners();
      }
      
      private function updateChallengesServerResponse(param1:Message) : void
      {
         var _loc6_:* = undefined;
         var _loc2_:Object = null;
         var _loc3_:Challenges = null;
         var _loc4_:Array = null;
         var _loc5_:Challenge = null;
         if(param1.data)
         {
            if(Boolean(param1.data.confirmation_results) && Boolean(param1.data.confirmation_results.earned_trophies))
            {
               this.giveTrophies(param1.data.confirmation_results.earned_trophies);
            }
            if(Boolean(param1.data.confirmation_results) && Boolean(param1.data.confirmation_results.completed_challenges) && Boolean(param1.data.confirmation_results.completed_challenges.challenge))
            {
               _loc2_ = param1.data.confirmation_results.completed_challenges.challenge;
            }
            else if(param1.data.completed_challenge_id)
            {
               _loc2_ = {};
               _loc2_["challenge_id"] = param1.data.completed_challenge_id;
            }
            if(_loc2_)
            {
               if(!ChallengeManager.instance)
               {
                  ChallengeManager.instance = new ChallengeManager();
               }
               _loc3_ = ChallengeManager.instance.getPlayerChallenges(_tuxGame.player.id);
               _loc4_ = _loc2_.challenge_id is Array ? _loc2_.challenge_id : [_loc2_.challenge_id];
               for each(_loc6_ in _loc4_)
               {
                  _loc5_ = _loc3_.findChallenge(_loc6_);
                  if(_loc5_)
                  {
                     LogUtils.log("Giving rewards for challenge " + _loc5_.id,"ResultLogic",1,"Challenges",true,false,true);
                     this.giveChallengeRewards(_loc5_);
                     _loc3_.removeChallenge(_loc5_);
                  }
               }
            }
            if(!Tutorial._tutorial)
            {
               if(param1.data.confirmation_results)
               {
                  this.activateNewChallenges(param1.data.confirmation_results.active_challenges);
               }
               else
               {
                  this.activateNewChallenges(param1.data.active_challenges);
               }
            }
            MessageCenter.sendMessage("ChallengesUpdated");
         }
      }
      
      private function activateNewChallenges(param1:Object) : void
      {
         var _loc2_:Challenges = null;
         if(param1)
         {
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            _loc2_ = ChallengeManager.instance.getPlayerChallenges(_tuxGame.player.id);
            if(_loc2_)
            {
               _loc2_.update(param1);
            }
            else
            {
               LogUtils.log("Cannot update challenges!!",this,3,"Challenges");
            }
         }
      }
      
      private function giveTrophies(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = null;
         if(param1)
         {
            _loc2_ = param1.item is Array ? param1.item : [param1.item];
            for each(_loc3_ in _loc2_)
            {
               LogUtils.log("Giving trophy " + _loc3_.item_id,"ResultLogic",1,"Trophies",true,false,true);
               _tuxGame.player.inventory.addItem(_loc3_.item_id);
               if(!PopUpManager.instance)
               {
                  PopUpManager.instance = new PopUpManager();
               }
               PopUpManager.instance.addPopup(new LootPopupSubState(_tuxGame,ItemManager.getItemData(_loc3_.item_id)));
            }
         }
      }
      
      private function giveChallengeRewards(param1:Challenge) : void
      {
         if(param1)
         {
            _tuxGame.player.addExp(param1.rewardExp);
            _tuxGame.player.addIngameMoney(param1.rewardCoins);
            _tuxGame.player.addPremiumMoney(param1.rewardCash);
         }
         else
         {
            LogUtils.log("Challenge data missing when trying to give reward","ChallengeRewardsManager",2,"Challenges");
         }
      }
      
      private function addListeners() : void
      {
         MessageCenter.addListener("ChallengesUpdateServerResponse",this.updateChallengesServerResponse);
      }
      
      private function removeListeners() : void
      {
         MessageCenter.removeListener("ChallengesUpdateServerResponse",this.updateChallengesServerResponse);
      }
   }
}

