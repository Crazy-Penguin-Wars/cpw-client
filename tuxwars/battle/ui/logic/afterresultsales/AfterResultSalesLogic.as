package tuxwars.battle.ui.logic.afterresultsales
{
   import com.dchoc.net.ServerRequest;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import tuxwars.GameSettings;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.battle.ui.screen.afterresultsales.AfterResultSalesScreen;
   import tuxwars.home.states.customgame.CustomGameHostSubState;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.home.states.matchloading.MultiplayerMatchLoadingSubState;
   import tuxwars.home.states.matchloading.PracticeMatchLoadingSubState;
   import tuxwars.home.states.matchloading.TournamentMatchLoadingSubState;
   import tuxwars.home.states.shop.ShopState;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ItemManager;
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
      
      public function AfterResultSalesLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         _rematchIdentifier = params[2];
         _rematchPlayerCount = params[3];
         _rematchCustomGameName = params[4];
      }
      
      public function getShopItem(winner:Boolean, index:int) : ShopItem
      {
         var _loc4_:ProjectManager = ProjectManager;
         var _loc3_:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable("AfterResultsSalesWinner");
         var _loc9_:* = index.toString();
         var _loc5_:* = _loc3_;
         §§push(§§findproperty(ShopItem));
         §§push(ItemManager);
         if(!_loc5_._cache[_loc9_])
         {
            var _loc10_:Row = com.dchoc.utils.DCUtils.find(_loc5_.rows,"id",_loc9_);
            if(!_loc10_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc9_ + "\' was found in table: \'" + _loc5_.name + "\'",_loc5_,3);
            }
            _loc5_._cache[_loc9_] = _loc10_;
         }
         var _loc6_:* = _loc5_._cache[_loc9_];
         if(!_loc6_._cache["ItemId"])
         {
            _loc6_._cache["ItemId"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","ItemId");
         }
         var _loc7_:* = _loc6_._cache["ItemId"];
         return new §§pop().ShopItem(§§pop().getItemData(_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value));
      }
      
      public function goHome(immediately:Boolean = false) : void
      {
         game.changeState(new HomeState(game),immediately);
      }
      
      public function goToStore() : void
      {
         var _loc1_:TuxWarsGame = game;
         goHome(true);
         _loc1_.homeState.changeState(new ShopState(_loc1_));
      }
      
      public function playAgain(battleResults:BattleResults) : void
      {
         var _loc3_:* = null;
         var _loc2_:TuxWarsGame = game;
         if(!game.homeState)
         {
            _loc2_.changeState(new HomeState(_loc2_),true);
         }
         if(battleResults && battleResults.isPracticeMode)
         {
            GameSettings.setShowAllWeaponsInPractice(false);
            _loc2_.homeState.changeState(new PracticeMatchLoadingSubState(_loc2_));
         }
         else
         {
            _loc3_ = {};
            _loc3_["game_identifier"] = _rematchIdentifier;
            _loc3_["player_count"] = _rematchPlayerCount;
            if(battleResults && battleResults.isTournamentMode)
            {
               _loc3_["tournament"] = true;
               _loc2_.homeState.changeState(new TournamentMatchLoadingSubState(_loc2_,new ServerRequest("PlayNow",_loc3_)));
            }
            else if(_rematchCustomGameName)
            {
               _loc3_["private_game"] = true;
               _loc3_["private_game_rematch"] = true;
               _loc2_.homeState.changeState(new CustomGameHostSubState(_loc2_,_rematchCustomGameName,new ServerRequest("PlayNow",_loc3_)));
            }
            else
            {
               _loc2_.homeState.changeState(new MultiplayerMatchLoadingSubState(_loc2_,new ServerRequest("PlayNow",_loc3_)));
            }
         }
      }
      
      public function get afterResultSalesScreen() : AfterResultSalesScreen
      {
         return screen;
      }
   }
}
