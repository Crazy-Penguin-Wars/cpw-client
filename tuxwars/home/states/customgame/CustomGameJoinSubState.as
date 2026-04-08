package tuxwars.home.states.customgame
{
   import com.dchoc.net.ServerRequest;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.privategame.join.*;
   import tuxwars.home.ui.logic.privategame.host.*;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
   import tuxwars.states.TuxState;
   
   public class CustomGameJoinSubState extends CustomGameConnectSubState
   {
      public function CustomGameJoinSubState(param1:TuxWarsGame, param2:String, param3:ServerRequest)
      {
         super(param1,param2,param3);
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
            _loc1_.matchData.matchTime = gameSettings.battle_time / 60;
         }
         if(gameSettings.turn_time)
         {
            _loc1_.matchData.turnTime = gameSettings.turn_time;
         }
         this.addOpponents(_loc1_);
         return new JoinPrivateGameState(tuxGame,_loc1_);
      }
      
      private function addOpponents(param1:PrivateGameModel) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:PlayerSlotData = null;
         var _loc3_:Array = this.getOpponents();
         for each(_loc4_ in _loc3_)
         {
            _loc2_ = new PlayerSlotData(_loc4_.id,_loc4_.name,_loc4_.level,_loc4_.pictureUrl);
            this.updatePlayerClothes(_loc2_,_loc4_.worn_items);
            param1.players.push(_loc2_);
         }
      }
      
      private function updatePlayerClothes(param1:PlayerSlotData, param2:Array) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:ClothingItem = null;
         for each(_loc4_ in param2)
         {
            _loc3_ = ItemManager.createItem(_loc4_) as ClothingItem;
            param1.clothes.push(_loc3_);
         }
      }
      
      private function getOpponents() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = [];
         for each(_loc2_ in gameSettings.players)
         {
            if(_loc2_.id != tuxGame.player.id)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
   }
}

