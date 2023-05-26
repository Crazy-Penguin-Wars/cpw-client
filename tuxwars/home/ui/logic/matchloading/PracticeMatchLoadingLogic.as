package tuxwars.home.ui.logic.matchloading
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.MathUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.gameobjects.player.AIPlayerHelper;
   import tuxwars.battle.gameobjects.player.AIPlayerReference;
   import tuxwars.data.practice.Practice;
   import tuxwars.home.states.BattleAssetLoadingSubState;
   import tuxwars.home.states.matchloading.PracticeMatchLoadingSubState;
   import tuxwars.home.states.matchloading.levelloading.LevelLoadingSubState;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.tutorial.TutorialData;
   
   public class PracticeMatchLoadingLogic extends MatchLoadingLogic
   {
       
      
      public function PracticeMatchLoadingLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         loadingScreen.updateMessage(ProjectManager.getText("MATCH_LOADING_ASSETS"));
         MessageCenter.addListener("BattleAssetsLoaded",battleAssetsLoaded);
         state.changeState(new BattleAssetLoadingSubState(game));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("BattleAssetsLoaded",battleAssetsLoaded);
      }
      
      private function battleAssetsLoaded(msg:Message) : void
      {
         MessageCenter.removeListener("BattleAssetsLoaded",battleAssetsLoaded);
         var _loc3_:Object = getMatchData();
         var _loc2_:Object = {};
         _loc2_["players"] = getPlayers(Number(_loc3_.num_players) - 1,game.player.level,_loc3_);
         _loc2_["map"] = _loc3_.map;
         _loc2_["seed"] = MathUtils.randomNumber(0,2147483647);
         _loc2_["battle_time"] = _loc3_.match_time;
         _loc2_["turn_time"] = _loc3_.turn_time;
         _loc2_["practice_mode"] = true;
         state.changeState(new LevelLoadingSubState(game,_loc2_,false,false));
      }
      
      private function getMatchData() : Object
      {
         if(params)
         {
            return params;
         }
         var _loc1_:Tutorial = Tutorial;
         return !!tuxwars.tutorial.Tutorial._tutorial ? TutorialData.getTutorialMatchData() : Practice.getPracticeMatchData();
      }
      
      private function getPlayers(num:int, playerLevel:int, matchData:Object) : Array
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var i:int = 0;
         var _loc4_:* = null;
         var _loc5_:Array = [];
         _loc5_.push({"id":game.player.id});
         if(matchData.opponent)
         {
            _loc6_ = AIPlayerHelper.getAIPlayerReference(matchData.opponent);
            _loc5_.push(_loc6_.toObject());
         }
         else
         {
            _loc7_ = [];
            for(i = 0; i < num; )
            {
               _loc4_ = getRandomAIPlayer(playerLevel,_loc7_);
               _loc5_.push(_loc4_.toObject());
               _loc7_.push(_loc4_.AIID);
               i++;
            }
         }
         return _loc5_;
      }
      
      private function getRandomAIPlayer(playerLevel:int, nameArray:Array) : AIPlayerReference
      {
         var _loc3_:* = null;
         do
         {
            _loc3_ = AIPlayerHelper.getAIPlayerReference(AIPlayerReference.getRandomAI(playerLevel));
         }
         while(nameArray.indexOf(_loc3_.AIID) != -1);
         
         return _loc3_;
      }
      
      private function get matchLoadingState() : PracticeMatchLoadingSubState
      {
         return state.parent as PracticeMatchLoadingSubState;
      }
   }
}
