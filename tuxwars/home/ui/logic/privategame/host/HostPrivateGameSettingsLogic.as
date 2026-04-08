package tuxwars.home.ui.logic.privategame.host
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.data.*;
   import tuxwars.home.states.privategame.host.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class HostPrivateGameSettingsLogic extends TuxUILogic
   {
      public function HostPrivateGameSettingsLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function get gameModel() : PrivateGameModel
      {
         return params as PrivateGameModel;
      }
      
      public function exit() : void
      {
         state.parent.changeState(new HostPrivateGameUIState(game,this.gameModel));
      }
      
      public function updateModel(param1:*, param2:int, param3:int) : void
      {
         this.gameModel.matchData.mapId = param1 is String ? param1 : LevelData(param1).id;
         this.gameModel.matchData.matchTime = param2;
         this.gameModel.matchData.turnTime = param3;
         MessageCenter.sendEvent(new ChangeSettingsMessage(this.gameModel.matchData.mapId,this.gameModel.matchData.matchTime * 60,this.gameModel.matchData.turnTime));
      }
      
      public function getLevels() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = ["RANDOM"];
         for each(_loc2_ in Levels.getLevels())
         {
            if(_loc2_.minLevel < Experience.findHighestLevel())
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function indexForMapId(param1:String) : int
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in Levels.getLevels())
         {
            if(_loc2_.id == param1)
            {
               return Levels.getLevels().indexOf(_loc2_);
            }
         }
         return -1;
      }
   }
}

