package tuxwars.home.ui.logic.privategame.host
{
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.LevelData;
   import tuxwars.battle.data.Levels;
   import tuxwars.battle.net.messages.control.ChangeSettingsMessage;
   import tuxwars.data.Experience;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.privategame.host.HostPrivateGameUIState;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class HostPrivateGameSettingsLogic extends TuxUILogic
   {
       
      
      public function HostPrivateGameSettingsLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function get gameModel() : PrivateGameModel
      {
         return params as PrivateGameModel;
      }
      
      public function exit() : void
      {
         state.parent.changeState(new HostPrivateGameUIState(game,gameModel));
      }
      
      public function updateModel(map:*, matchTime:int, turnTime:int) : void
      {
         gameModel.matchData.mapId = map is String ? map : LevelData(map).id;
         gameModel.matchData.matchTime = matchTime;
         gameModel.matchData.turnTime = turnTime;
         MessageCenter.sendEvent(new ChangeSettingsMessage(gameModel.matchData.mapId,gameModel.matchData.matchTime * 60,gameModel.matchData.turnTime));
      }
      
      public function getLevels() : Array
      {
         var _loc1_:Array = ["RANDOM"];
         for each(var levelData in Levels.getLevels())
         {
            if(levelData.minLevel < Experience.findHighestLevel())
            {
               _loc1_.push(levelData);
            }
         }
         return _loc1_;
      }
      
      public function indexForMapId(mapId:String) : int
      {
         for each(var levelData in Levels.getLevels())
         {
            if(levelData.id == mapId)
            {
               return Levels.getLevels().indexOf(levelData);
            }
         }
         return -1;
      }
   }
}
