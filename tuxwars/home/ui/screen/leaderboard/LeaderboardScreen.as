package tuxwars.home.ui.screen.leaderboard
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.leaderboard.*;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.net.*;
   
   public class LeaderboardScreen extends TuxPageSubTabScreen
   {
      private static const CONTENT_TEXT:String = "Container_Text";
      
      private static const CONTENT_BARS:String = "Container_Bars";
      
      private var personalStatsElement:PersonalStatsElement;
      
      private var leaderboardElement:LeaderboardElement;
      
      public function LeaderboardScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/leaderboard.swf","leaderboard_screen"),LeaderboardLogic.getStaticData());
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         this.cleanUp();
         super.dispose();
      }
      
      override public function cleanUp() : void
      {
         if(this.personalStatsElement)
         {
            this.personalStatsElement.dispose();
            this.personalStatsElement = null;
         }
         if(this.leaderboardElement)
         {
            this.leaderboardElement.dispose();
            this.leaderboardElement = null;
         }
         super.cleanUp();
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.createScreen(false);
      }
      
      override public function createScreen(param1:Boolean) : void
      {
         this.cleanUp();
         super.createScreen(param1);
         if(contentMoveClip.name == "Container_Text")
         {
            this.personalStatsElement = new PersonalStatsElement(contentMoveClip,tuxGame,this);
            this.leaderboardLogic.personalAllSelected();
         }
         else if(contentMoveClip.name == "Container_Bars")
         {
            this.leaderboardElement = new LeaderboardElement(contentMoveClip,tuxGame,this);
            this.leaderboardLogic.showLeaderboard();
         }
      }
      
      override public function updateSubTabContent(param1:Row) : void
      {
         this.createScreen(true);
         CRMService.sendEvent("Game","Menu","Clicked","Stats",param1.id);
      }
      
      override public function updatePageContent(param1:Row) : void
      {
         super.updatePageContent(param1);
         this.createScreen(false);
         CRMService.sendEvent("Game","Menu","Clicked","Stats",param1.id);
      }
      
      public function get leaderboardLogic() : LeaderboardLogic
      {
         return logic;
      }
      
      public function showPersonalStats(param1:Object) : void
      {
         if(this.personalStatsElement)
         {
            this.personalStatsElement.showStats(param1);
         }
      }
      
      public function showLeaderboardStats(param1:Object, param2:Object) : void
      {
         if(this.leaderboardElement)
         {
            this.leaderboardElement.showStats(param1,this.getTab(),param2);
         }
      }
      
      private function getTab() : String
      {
         var _loc1_:String = "Categorys";
         var _loc2_:* = this.leaderboardLogic.getCurrentTab();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         var _loc4_:* = _loc3_;
         return (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)[0];
      }
   }
}

