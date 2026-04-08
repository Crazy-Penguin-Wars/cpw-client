package tuxwars.battle.ui.logic.afterresultsales
{
   import com.dchoc.net.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.*;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.ui.screen.afterresultsales.AfterResultSalesScreen;
   import tuxwars.home.states.customgame.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.states.shop.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
   import tuxwars.states.TuxState;
   
   public class AfterResultSalesLogic extends TuxUILogic
   {
      public static var GO_HOME:int = 0;
      
      public static var PLAY_AGAIN:int = 1;
      
      public static var PLAY_AGAIN_TOURNAMENT:int = 2;
      
      public static var PLAY_AGAIN_CUSTOM:int = 3;
      
      private var _rematchIdentifier:String;
      
      private var _rematchPlayerCount:int;
      
      private var _rematchCustomGameName:String;
      
      public function AfterResultSalesLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this._rematchIdentifier = param1[2];
         this._rematchPlayerCount = param1[3];
         this._rematchCustomGameName = param1[4];
      }
      
      public function getShopItem(param1:Boolean, param2:int) : ShopItem
      {
         var _loc9_:Row = null;
         var _loc3_:String = param1 ? "AfterResultsSalesWinner" : "AfterResultsSalesLoser";
         var _loc4_:Table = ProjectManager.findTable(_loc3_);
         var _loc5_:String = param2.toString();
         if(!_loc4_.getCache[_loc5_])
         {
            _loc9_ = DCUtils.find(_loc4_.rows,"id",_loc5_);
            if(!_loc9_)
            {
               LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc5_] = _loc9_;
         }
         var _loc6_:Row = _loc4_.getCache[_loc5_];
         if(!_loc6_.getCache["ItemId"])
         {
            _loc6_.getCache["ItemId"] = DCUtils.find(_loc6_.getFields(),"name","ItemId");
         }
         var _loc7_:Field = _loc6_.getCache["ItemId"];
         var _loc8_:* = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
         return new ShopItem(ItemManager.getItemData(_loc8_));
      }
      
      public function goHome(param1:Boolean = false) : void
      {
         game.changeState(new HomeState(game),param1);
      }
      
      public function goToStore() : void
      {
         var _loc1_:TuxWarsGame = game;
         this.goHome(true);
         _loc1_.homeState.changeState(new ShopState(_loc1_));
      }
      
      public function playAgain(param1:BattleResults) : void
      {
         var _loc2_:Object = null;
         var _loc3_:TuxWarsGame = game;
         if(!game.homeState)
         {
            _loc3_.changeState(new HomeState(_loc3_),true);
         }
         if(Boolean(param1) && param1.isPracticeMode)
         {
            GameSettings.setShowAllWeaponsInPractice(false);
            _loc3_.homeState.changeState(new PracticeMatchLoadingSubState(_loc3_));
         }
         else
         {
            _loc2_ = {};
            _loc2_["game_identifier"] = this._rematchIdentifier;
            _loc2_["player_count"] = this._rematchPlayerCount;
            if(Boolean(param1) && param1.isTournamentMode)
            {
               _loc2_["tournament"] = true;
               _loc3_.homeState.changeState(new TournamentMatchLoadingSubState(_loc3_,new ServerRequest("PlayNow",_loc2_)));
            }
            else if(this._rematchCustomGameName)
            {
               _loc2_["private_game"] = true;
               _loc2_["private_game_rematch"] = true;
               _loc3_.homeState.changeState(new CustomGameHostSubState(_loc3_,this._rematchCustomGameName,new ServerRequest("PlayNow",_loc2_)));
            }
            else
            {
               _loc3_.homeState.changeState(new MultiplayerMatchLoadingSubState(_loc3_,new ServerRequest("PlayNow",_loc2_)));
            }
         }
      }
      
      public function get afterResultSalesScreen() : AfterResultSalesScreen
      {
         return screen;
      }
   }
}

