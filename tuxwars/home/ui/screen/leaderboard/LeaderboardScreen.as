package tuxwars.home.ui.screen.leaderboard
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.leaderboard.LeaderboardLogic;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.net.CRMService;
   
   public class LeaderboardScreen extends TuxPageSubTabScreen
   {
      
      private static const CONTENT_TEXT:String = "Container_Text";
      
      private static const CONTENT_BARS:String = "Container_Bars";
       
      
      private var personalStatsElement:PersonalStatsElement;
      
      private var leaderboardElement:LeaderboardElement;
      
      public function LeaderboardScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/leaderboard.swf","leaderboard_screen"),LeaderboardLogic.getStaticData());
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         cleanUp();
         super.dispose();
      }
      
      override public function cleanUp() : void
      {
         if(personalStatsElement)
         {
            personalStatsElement.dispose();
            personalStatsElement = null;
         }
         if(leaderboardElement)
         {
            leaderboardElement.dispose();
            leaderboardElement = null;
         }
         super.cleanUp();
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         createScreen(false);
      }
      
      override public function createScreen(onlyChangeContent:Boolean) : void
      {
         cleanUp();
         super.createScreen(onlyChangeContent);
         if(contentMoveClip.name == "Container_Text")
         {
            personalStatsElement = new PersonalStatsElement(contentMoveClip,tuxGame,this);
            leaderboardLogic.personalAllSelected();
         }
         else if(contentMoveClip.name == "Container_Bars")
         {
            leaderboardElement = new LeaderboardElement(contentMoveClip,tuxGame,this);
            leaderboardLogic.showLeaderboard();
         }
      }
      
      override public function updateSubTabContent(newTab:Row) : void
      {
         createScreen(true);
         CRMService.sendEvent("Game","Menu","Clicked","Stats",newTab.id);
      }
      
      override public function updatePageContent(row:Row) : void
      {
         super.updatePageContent(row);
         createScreen(false);
         CRMService.sendEvent("Game","Menu","Clicked","Stats",row.id);
      }
      
      public function get leaderboardLogic() : LeaderboardLogic
      {
         return logic;
      }
      
      public function showPersonalStats(stats:Object) : void
      {
         if(personalStatsElement)
         {
            personalStatsElement.showStats(stats);
         }
      }
      
      public function showLeaderboardStats(stats:Object, wornItems:Object) : void
      {
         if(leaderboardElement)
         {
            leaderboardElement.showStats(stats,getTab(),wornItems);
         }
      }
      
      private function getTab() : String
      {
         var _loc2_:* = leaderboardLogic.getCurrentTab();
         if(!_loc2_._cache["Categorys"])
         {
            _loc2_._cache["Categorys"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Categorys");
         }
         var _loc1_:Field = _loc2_._cache["Categorys"];
         var _loc3_:* = _loc1_;
         return (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)[0];
      }
   }
}
