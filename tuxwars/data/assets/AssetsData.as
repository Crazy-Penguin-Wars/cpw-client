package tuxwars.data.assets
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
   public class AssetsData
   {
      
      private static const START_UP_SHARED:String = "StartUpShared";
      
      private static const START_UP:String = "StartUp";
      
      private static const START_UP_TUTORIAL:String = "StartUpTutorial";
      
      private static const MATCH_LOADING:String = "MatchLoading";
      
      private static const CUSTOM_GAME:String = "CustomGame";
      
      private static const RESULTS:String = "Results";
      
      private static const TROPHY:String = "Trophy";
      
      private static const SHOP:String = "Shop";
      
      private static const CRAFTING:String = "Crafting";
      
      private static const GIFT_SCREEN:String = "GiftScreen";
      
      private static const INBOX_SCREEN:String = "InboxScreen";
      
      private static const EQUIPMENT:String = "Equipment";
      
      private static const CHALLENGE:String = "ChallengeUI";
      
      private static const RESOURCE:String = "Resource";
      
      private static const BATTLE_SHARED:String = "BattleShared";
      
      private static const BATTLE:String = "Battle";
      
      private static const POPUPS:String = "PopUps";
      
      private static const NEIGHBORS_SCREEN:String = "NeighborsScreen";
      
      private static const MONEY_SCREEN:String = "MoneyScreen";
      
      private static const HELP_SCREEN:String = "HelpScreen";
      
      private static const VIP_SCREEN:String = "VIPScreen";
      
      private static const QUESTION_POP_UP:String = "QuestionPopUp";
      
      private static const MESSAGE_POP_UP:String = "MessagePopUp";
      
      private static const SLOT_MACHINE_SCREEN:String = "SlotMachineScreen";
      
      private static const DAILY_NEWS_SCREEN:String = "DailyNewsScreen";
      
      private static const FRIEND_SELECTOR_SCREEN:String = "FriendSelectorScreen";
      
      private static const LEADERBOARD_SCREEN:String = "LeaderboardScreen";
      
      private static const TOURNAMENT_SCREEN:String = "TournamentScreen";
      
      private static const SWF:String = "SWF";
      
      private static const USE_CONTEXT:String = "UseContext";
       
      
      private var tableName:String;
      
      private var useContext:Boolean;
      
      public function AssetsData(tableName:String, useContext:Boolean = false)
      {
         super();
         this.tableName = tableName;
         this.useContext = useContext;
      }
      
      public static function getVIPAssets() : AssetsData
      {
         return new AssetsData("VIPScreen");
      }
      
      public static function getStartUpSharedAssets() : AssetsData
      {
         return new AssetsData("StartUpShared",true);
      }
      
      public static function getStartUpAssets() : AssetsData
      {
         return new AssetsData("StartUp");
      }
      
      public static function getStartUpTutorialAssets() : AssetsData
      {
         return new AssetsData("StartUpTutorial");
      }
      
      public static function getMatchLoadingAssets() : AssetsData
      {
         return new AssetsData("MatchLoading");
      }
      
      public static function getCustomGameAssets() : AssetsData
      {
         return new AssetsData("CustomGame");
      }
      
      public static function getResultsAssets() : AssetsData
      {
         return new AssetsData("Results");
      }
      
      public static function getTrophyAssets() : AssetsData
      {
         return new AssetsData("Trophy");
      }
      
      public static function getShopAssets() : AssetsData
      {
         return new AssetsData("Shop");
      }
      
      public static function getCraftingAssets() : AssetsData
      {
         return new AssetsData("Crafting");
      }
      
      public static function getGiftScreenAssets() : AssetsData
      {
         return new AssetsData("GiftScreen");
      }
      
      public static function getInboxScreenAssets() : AssetsData
      {
         return new AssetsData("InboxScreen");
      }
      
      public static function getEquipmentAssets() : AssetsData
      {
         return new AssetsData("Equipment");
      }
      
      public static function getChallengeAssets() : AssetsData
      {
         return new AssetsData("ChallengeUI");
      }
      
      public static function getResourceAssets() : AssetsData
      {
         return new AssetsData("Resource");
      }
      
      public static function getBattleSharedAssets() : AssetsData
      {
         return new AssetsData("BattleShared",true);
      }
      
      public static function getBattleAssets() : AssetsData
      {
         return new AssetsData("Battle");
      }
      
      public static function getPopupAssets() : AssetsData
      {
         return new AssetsData("PopUps");
      }
      
      public static function getNeighborScreenAssets() : AssetsData
      {
         return new AssetsData("NeighborsScreen");
      }
      
      public static function getMoneyScreenAssets() : AssetsData
      {
         return new AssetsData("MoneyScreen");
      }
      
      public static function getHelpAssets() : AssetsData
      {
         return new AssetsData("HelpScreen");
      }
      
      public static function getSlotMachineAssets() : AssetsData
      {
         return new AssetsData("SlotMachineScreen");
      }
      
      public static function getQuestionPopupAssets() : AssetsData
      {
         return new AssetsData("QuestionPopUp");
      }
      
      public static function getMessagePopupAssets() : AssetsData
      {
         return new AssetsData("MessagePopUp");
      }
      
      public static function getDailyNewsAssets() : AssetsData
      {
         return new AssetsData("DailyNewsScreen");
      }
      
      public static function getFriendSelectorAssets() : AssetsData
      {
         return new AssetsData("FriendSelectorScreen");
      }
      
      public static function get leaderboardScreenAssets() : AssetsData
      {
         return new AssetsData("LeaderboardScreen");
      }
      
      public static function get tournamentScreenAssets() : AssetsData
      {
         return new AssetsData("TournamentScreen");
      }
      
      public function isUseContext() : Boolean
      {
         return useContext;
      }
      
      public function getAssets() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:Array = getTableRows(tableName);
         for each(var row in _loc3_)
         {
            var _loc4_:* = row;
            §§push(_loc1_);
            if(!_loc4_._cache["SWF"])
            {
               _loc4_._cache["SWF"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","SWF");
            }
            var _loc5_:* = _loc4_._cache["SWF"];
            §§pop().push(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value);
         }
         return _loc1_;
      }
      
      private function getTableRows(tableName:String) : Array
      {
         var _loc4_:* = tableName;
         var _loc2_:ProjectManager = ProjectManager;
         var _loc3_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc4_);
         return _loc3_._rows;
      }
   }
}
