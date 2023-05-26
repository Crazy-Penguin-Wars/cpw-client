package tuxwars.home.states.customgame
{
   import com.dchoc.net.ServerRequest;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.privategame.join.JoinPrivateGameState;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.states.TuxState;
   
   public class CustomGameJoinSubState extends CustomGameConnectSubState
   {
       
      
      public function CustomGameJoinSubState(game:TuxWarsGame, gameName:String, request:ServerRequest)
      {
         super(game,gameName,request);
      }
      
      override protected function get isOwner() : Boolean
      {
         return false;
      }
      
      override protected function get nextState() : TuxState
      {
         var _loc1_:PrivateGameModel = createGameModel(params);
         if(gameSettings.map)
         {
            _loc1_.matchData.mapId = gameSettings.map;
         }
         if(gameSettings.battle_time)
         {
            _loc1_.matchData.matchTime = Number(gameSettings.battle_time) / 60;
         }
         if(gameSettings.turn_time)
         {
            _loc1_.matchData.turnTime = gameSettings.turn_time;
         }
         addOpponents(_loc1_);
         return new JoinPrivateGameState(tuxGame,_loc1_);
      }
      
      private function addOpponents(gameModel:PrivateGameModel) : void
      {
         var _loc4_:* = null;
         var _loc3_:Array = getOpponents();
         for each(var opponent in _loc3_)
         {
            _loc4_ = new PlayerSlotData(opponent.id,opponent.name,opponent.level,opponent.pictureUrl);
            updatePlayerClothes(_loc4_,opponent.worn_items);
            gameModel.players.push(_loc4_);
         }
      }
      
      private function updatePlayerClothes(playerSlotData:PlayerSlotData, wornItems:Array) : void
      {
         var _loc3_:* = null;
         for each(var itemId in wornItems)
         {
            _loc3_ = ItemManager.createItem(itemId) as ClothingItem;
            playerSlotData.clothes.push(_loc3_);
         }
      }
      
      private function getOpponents() : Array
      {
         var _loc2_:Array = [];
         for each(var opponent in gameSettings.players)
         {
            if(opponent.id != tuxGame.player.id)
            {
               _loc2_.push(opponent);
            }
         }
         return _loc2_;
      }
   }
}
