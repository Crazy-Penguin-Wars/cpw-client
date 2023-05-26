package tuxwars.battle
{
   import org.as3commons.lang.StringUtils;
   import tuxwars.battle.data.BattleOptions;
   import tuxwars.battle.rewards.LootItem;
   import tuxwars.battle.rewards.RewardsHandler;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   
   public class BattleResults
   {
       
      
      private const _playerResults:Vector.<PlayerResult> = new Vector.<PlayerResult>();
      
      private const _itemsLooted:Vector.<LootItem> = new Vector.<LootItem>();
      
      private var _coinsGained:int;
      
      private var _expGained:int;
      
      private var _cashGained:int;
      
      private var _isPracticeMode:Boolean;
      
      private var _isTournamentMode:Boolean;
      
      private var _isZeroPointGame:Boolean;
      
      public function BattleResults(playerResults:Vector.<PlayerResult>, rewardsHandler:RewardsHandler, isPracticeMode:Boolean, isTournamentMode:Boolean)
      {
         super();
         _coinsGained = rewardsHandler.getInGameMoneyGained();
         _cashGained = rewardsHandler.getPremiumMoneyGained();
         _expGained = rewardsHandler.getExperienceGained();
         addToVector(_playerResults,playerResults);
         addToVector(_itemsLooted,rewardsHandler.itemsLooted);
         _playerResults.sort(sortPlayers);
         _isPracticeMode = isPracticeMode;
         _isTournamentMode = isTournamentMode;
         checkForZeroPointGame();
      }
      
      public function get playerResults() : Vector.<PlayerResult>
      {
         return _playerResults;
      }
      
      public function get coinsGained() : int
      {
         return _coinsGained;
      }
      
      public function get cashGained() : int
      {
         return _cashGained;
      }
      
      public function get expGained() : int
      {
         return _expGained;
      }
      
      public function get itemsLooted() : Vector.<LootItem>
      {
         return _itemsLooted;
      }
      
      public function get isPracticeMode() : Boolean
      {
         return _isPracticeMode;
      }
      
      public function get isTournamentMode() : Boolean
      {
         return _isTournamentMode;
      }
      
      public function getCouponLoot(ndx:int) : CouponData
      {
         var _loc3_:* = null;
         for each(var loot in _itemsLooted)
         {
            _loc3_ = ItemManager.getItemData(loot.id);
            if(_loc3_ && _loc3_ is CouponData)
            {
               return _loc3_ as CouponData;
            }
         }
         return null;
      }
      
      public function getExpPositionBonus(id:String) : int
      {
         var _loc2_:BattleOptions = BattleOptions;
         return getPositionBonus(id,tuxwars.battle.data.BattleOptions.getRow().findField("BonusExpModifier").value);
      }
      
      public function getCoinsPositionBonus(id:String) : int
      {
         var _loc2_:BattleOptions = BattleOptions;
         return getPositionBonus(id,tuxwars.battle.data.BattleOptions.getRow().findField("BonusCoinsModifier").value);
      }
      
      public function getPosition(id:String) : int
      {
         var i:int = 0;
         var _loc2_:* = null;
         for(i = 0; i < playerResults.length; )
         {
            _loc2_ = playerResults[i];
            if(_loc2_.player.id == id)
            {
               return i + 1;
            }
            i++;
         }
         throw new Error("The player wasn\'t in the results!");
      }
      
      private function getPositionBonus(id:String, modifier:int) : int
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(getRank(id) <= 4)
         {
            _loc3_ = findPlayerResults(id);
            _loc4_ = playerResults[playerResults.length - 1];
            return calculateBonus(_loc3_.score,_loc4_.score,modifier,getRankMultiplier(id));
         }
         return 0;
      }
      
      private function findPlayerResults(id:String) : PlayerResult
      {
         for each(var player in playerResults)
         {
            if(player.player.id == id)
            {
               return player;
            }
         }
         return null;
      }
      
      private function calculateBonus(score1:int, score2:int, modifier:int, multiplier:Number) : int
      {
         return ((score1 - score2) * 0.25 + modifier) * multiplier;
      }
      
      private function getRankMultiplier(id:String) : Number
      {
         var _loc2_:int = getRank(id);
         switch(_loc2_ - 1)
         {
            case 0:
               var _loc3_:BattleOptions = BattleOptions;
               return tuxwars.battle.data.BattleOptions.getRow().findField("RankMultiplier1").value;
            case 1:
               var _loc4_:BattleOptions = BattleOptions;
               return tuxwars.battle.data.BattleOptions.getRow().findField("RankMultiplier2").value;
            case 2:
               var _loc5_:BattleOptions = BattleOptions;
               return tuxwars.battle.data.BattleOptions.getRow().findField("RankMultiplier3").value;
            case 3:
               var _loc6_:BattleOptions = BattleOptions;
               return tuxwars.battle.data.BattleOptions.getRow().findField("RankMultiplier4").value;
            default:
               return 0;
         }
      }
      
      private function getRank(id:String) : int
      {
         return getPosition(id) + (4 - playerResults.length);
      }
      
      private function addToVector(to:*, from:*) : void
      {
         for each(var obj in from)
         {
            to.push(obj);
         }
      }
      
      private function sortPlayers(player1:PlayerResult, player2:PlayerResult) : int
      {
         var _loc4_:int = player2.score - player1.score;
         if(_loc4_ != 0)
         {
            return _loc4_;
         }
         var _loc3_:int = player2.coinsGained - player1.coinsGained;
         if(_loc3_ != 0)
         {
            return _loc3_;
         }
         var _loc5_:int = player2.expGained - player1.expGained;
         if(_loc5_ != 0)
         {
            return _loc5_;
         }
         return StringUtils.compareTo(player1.player.id,player2.player.id);
      }
      
      private function checkForZeroPointGame() : void
      {
         if(isPracticeMode)
         {
            _isZeroPointGame = false;
            BattleManager.setZeroPointGame(false);
            return;
         }
         for each(var pr in _playerResults)
         {
            if(pr.score != 0 || pr.coinsGained != 0 || pr.expGained != 0)
            {
               _isZeroPointGame = false;
               BattleManager.setZeroPointGame(false);
               return;
            }
         }
         _isZeroPointGame = true;
         BattleManager.setZeroPointGame(true);
      }
      
      public function get isZeroPointGame() : Boolean
      {
         return _isZeroPointGame;
      }
   }
}
