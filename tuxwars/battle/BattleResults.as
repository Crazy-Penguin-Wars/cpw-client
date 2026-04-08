package tuxwars.battle
{
   import org.as3commons.lang.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.rewards.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   
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
      
      public function BattleResults(param1:Vector.<PlayerResult>, param2:RewardsHandler, param3:Boolean, param4:Boolean)
      {
         super();
         this._coinsGained = param2.getInGameMoneyGained();
         this._cashGained = param2.getPremiumMoneyGained();
         this._expGained = param2.getExperienceGained();
         this.addToVector(this._playerResults,param1);
         this.addToVector(this._itemsLooted,param2.itemsLooted);
         this._playerResults.sort(this.sortPlayers);
         this._isPracticeMode = param3;
         this._isTournamentMode = param4;
         this.checkForZeroPointGame();
      }
      
      public function get playerResults() : Vector.<PlayerResult>
      {
         return this._playerResults;
      }
      
      public function get coinsGained() : int
      {
         return this._coinsGained;
      }
      
      public function get cashGained() : int
      {
         return this._cashGained;
      }
      
      public function get expGained() : int
      {
         return this._expGained;
      }
      
      public function get itemsLooted() : Vector.<LootItem>
      {
         return this._itemsLooted;
      }
      
      public function get isPracticeMode() : Boolean
      {
         return this._isPracticeMode;
      }
      
      public function get isTournamentMode() : Boolean
      {
         return this._isTournamentMode;
      }
      
      public function getCouponLoot(param1:int) : CouponData
      {
         var _loc4_:* = undefined;
         var _loc2_:ItemData = null;
         var _loc3_:int = 0;
         for each(_loc4_ in this._itemsLooted)
         {
            _loc2_ = ItemManager.getItemData(_loc4_.id);
            if(Boolean(_loc2_) && _loc2_ is CouponData)
            {
               return _loc2_ as CouponData;
            }
         }
         return null;
      }
      
      public function getExpPositionBonus(param1:String) : int
      {
         return this.getPositionBonus(param1,BattleOptions.getRow().findField("BonusExpModifier").value);
      }
      
      public function getCoinsPositionBonus(param1:String) : int
      {
         return this.getPositionBonus(param1,BattleOptions.getRow().findField("BonusCoinsModifier").value);
      }
      
      public function getPosition(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:PlayerResult = null;
         _loc2_ = 0;
         while(_loc2_ < this.playerResults.length)
         {
            _loc3_ = this.playerResults[_loc2_];
            if(_loc3_.player.id == param1)
            {
               return _loc2_ + 1;
            }
            _loc2_++;
         }
         throw new Error("The player wasn\'t in the results!");
      }
      
      private function getPositionBonus(param1:String, param2:int) : int
      {
         var _loc3_:PlayerResult = null;
         var _loc4_:PlayerResult = null;
         if(this.getRank(param1) <= 4)
         {
            _loc3_ = this.findPlayerResults(param1);
            _loc4_ = this.playerResults[this.playerResults.length - 1];
            return this.calculateBonus(_loc3_.score,_loc4_.score,param2,this.getRankMultiplier(param1));
         }
         return 0;
      }
      
      private function findPlayerResults(param1:String) : PlayerResult
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.playerResults)
         {
            if(_loc2_.player.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function calculateBonus(param1:int, param2:int, param3:int, param4:Number) : int
      {
         return ((param1 - param2) * 0.25 + param3) * param4;
      }
      
      private function getRankMultiplier(param1:String) : Number
      {
         var _loc2_:int = int(this.getRank(param1));
         switch(_loc2_ - 1)
         {
            case 0:
               return BattleOptions.getRow().findField("RankMultiplier1").value;
            case 1:
               return BattleOptions.getRow().findField("RankMultiplier2").value;
            case 2:
               return BattleOptions.getRow().findField("RankMultiplier3").value;
            case 3:
               return BattleOptions.getRow().findField("RankMultiplier4").value;
            default:
               return 0;
         }
      }
      
      private function getRank(param1:String) : int
      {
         return this.getPosition(param1) + (4 - this.playerResults.length);
      }
      
      private function addToVector(param1:*, param2:*) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param2)
         {
            param1.push(_loc3_);
         }
      }
      
      private function sortPlayers(param1:PlayerResult, param2:PlayerResult) : int
      {
         var _loc3_:int = param2.score - param1.score;
         if(_loc3_ != 0)
         {
            return _loc3_;
         }
         var _loc4_:int = param2.coinsGained - param1.coinsGained;
         if(_loc4_ != 0)
         {
            return _loc4_;
         }
         var _loc5_:int = param2.expGained - param1.expGained;
         if(_loc5_ != 0)
         {
            return _loc5_;
         }
         return StringUtils.compareTo(param1.player.id,param2.player.id);
      }
      
      private function checkForZeroPointGame() : void
      {
         var _loc1_:* = undefined;
         if(this.isPracticeMode)
         {
            this._isZeroPointGame = false;
            BattleManager.setZeroPointGame(false);
            return;
         }
         for each(_loc1_ in this._playerResults)
         {
            if(_loc1_.score != 0 || _loc1_.coinsGained != 0 || _loc1_.expGained != 0)
            {
               this._isZeroPointGame = false;
               BattleManager.setZeroPointGame(false);
               return;
            }
         }
         this._isZeroPointGame = true;
         BattleManager.setZeroPointGame(true);
      }
      
      public function get isZeroPointGame() : Boolean
      {
         return this._isZeroPointGame;
      }
   }
}

