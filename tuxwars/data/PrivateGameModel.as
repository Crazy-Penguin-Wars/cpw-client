package tuxwars.data
{
   import com.dchoc.utils.DCUtils;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.managers.ItemManager;
   
   public class PrivateGameModel
   {
       
      
      private const _players:Vector.<PlayerSlotData> = new Vector.<PlayerSlotData>();
      
      private var _name:String;
      
      private var _matchData:MatchData;
      
      private var _matchKey:String;
      
      private var _owner:String;
      
      private var _vip:Boolean;
      
      public function PrivateGameModel(name:String, matchData:MatchData, matchKey:String, vip:Boolean)
      {
         super();
         _name = name;
         _matchData = matchData;
         _matchKey = matchKey;
         _vip = vip;
      }
      
      public function get vip() : Boolean
      {
         return _vip;
      }
      
      public function get matchKey() : String
      {
         return _matchKey;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get matchData() : MatchData
      {
         return _matchData;
      }
      
      public function get players() : Vector.<PlayerSlotData>
      {
         return _players;
      }
      
      public function get owner() : String
      {
         return _owner;
      }
      
      public function hasOwnerLeft() : Boolean
      {
         return !DCUtils.find(players,"id",owner);
      }
      
      public function update(data:Object) : void
      {
         _matchData.update(data);
         _owner = data.owner;
         updatePlayers(data.players is Array ? data.players : [data.players]);
      }
      
      private function updatePlayers(playerDatas:Array) : void
      {
         var _loc2_:* = null;
         _players.splice(0,_players.length);
         for each(var playerData in playerDatas)
         {
            _loc2_ = createPlayerSlotData(playerData);
            updatePlayerClothes(_loc2_,playerData.worn_items);
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
      
      private function createPlayerSlotData(playerData:Object) : PlayerSlotData
      {
         var _loc2_:PlayerSlotData = new PlayerSlotData(playerData.id,playerData.name,playerData.level,playerData.pictureUrl);
         _players.push(_loc2_);
         return _loc2_;
      }
   }
}
