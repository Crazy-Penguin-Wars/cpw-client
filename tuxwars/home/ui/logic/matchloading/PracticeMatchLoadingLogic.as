package tuxwars.home.ui.logic.matchloading
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.data.practice.*;
   import tuxwars.home.states.*;
   import tuxwars.home.states.matchloading.*;
   import tuxwars.home.states.matchloading.levelloading.*;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   
   public class PracticeMatchLoadingLogic extends MatchLoadingLogic
   {
      public function PracticeMatchLoadingLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         loadingScreen.updateMessage(ProjectManager.getText("MATCH_LOADING_ASSETS"));
         MessageCenter.addListener("BattleAssetsLoaded",this.battleAssetsLoaded);
         state.changeState(new BattleAssetLoadingSubState(game));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("BattleAssetsLoaded",this.battleAssetsLoaded);
      }
      
      private function battleAssetsLoaded(param1:Message) : void
      {
         MessageCenter.removeListener("BattleAssetsLoaded",this.battleAssetsLoaded);
         var _loc2_:Object = this.getMatchData();
         var _loc3_:Object = {};
         _loc3_["players"] = this.getPlayers(_loc2_.num_players - 1,game.player.level,_loc2_);
         _loc3_["map"] = _loc2_.map;
         _loc3_["seed"] = MathUtils.randomNumber(0,2147483647);
         _loc3_["battle_time"] = _loc2_.match_time;
         _loc3_["turn_time"] = _loc2_.turn_time;
         _loc3_["practice_mode"] = true;
         state.changeState(new LevelLoadingSubState(game,_loc3_,false,false));
      }
      
      private function getMatchData() : Object
      {
         if(params)
         {
            return params;
         }
         return !!Tutorial._tutorial ? TutorialData.getTutorialMatchData() : Practice.getPracticeMatchData();
      }
      
      private function getPlayers(param1:int, param2:int, param3:Object) : Array
      {
         var _loc4_:AIPlayerReference = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:AIPlayerReference = null;
         var _loc8_:Array = [];
         _loc8_.push({"id":game.player.id});
         if(param3.opponent)
         {
            _loc4_ = AIPlayerHelper.getAIPlayerReference(param3.opponent);
            _loc8_.push(_loc4_.toObject());
         }
         else
         {
            _loc5_ = [];
            _loc6_ = 0;
            while(_loc6_ < param1)
            {
               _loc7_ = this.getRandomAIPlayer(param2,_loc5_);
               _loc8_.push(_loc7_.toObject());
               _loc5_.push(_loc7_.AIID);
               _loc6_++;
            }
         }
         return _loc8_;
      }
      
      private function getRandomAIPlayer(param1:int, param2:Array) : AIPlayerReference
      {
         var _loc3_:AIPlayerReference = null;
         do
         {
            _loc3_ = AIPlayerHelper.getAIPlayerReference(AIPlayerReference.getRandomAI(param1));
         }
         while(param2.indexOf(_loc3_.AIID) != -1);
         
         return _loc3_;
      }
      
      private function get matchLoadingState() : PracticeMatchLoadingSubState
      {
         return state.parent as PracticeMatchLoadingSubState;
      }
   }
}

