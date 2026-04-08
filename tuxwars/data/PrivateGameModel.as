package tuxwars.data
{
   import com.dchoc.utils.*;
   import tuxwars.home.ui.logic.privategame.host.*;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
   
   public class PrivateGameModel
   {
      private const _players:Vector.<PlayerSlotData> = new Vector.<PlayerSlotData>();
      
      private var _name:String;
      
      private var _matchData:MatchData;
      
      private var _matchKey:String;
      
      private var _owner:String;
      
      private var _vip:Boolean;
      
      public function PrivateGameModel(param1:String, param2:MatchData, param3:String, param4:Boolean)
      {
         super();
         this._name = param1;
         this._matchData = param2;
         this._matchKey = param3;
         this._vip = param4;
      }
      
      public function get vip() : Boolean
      {
         return this._vip;
      }
      
      public function get matchKey() : String
      {
         return this._matchKey;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get matchData() : MatchData
      {
         return this._matchData;
      }
      
      public function get players() : Vector.<PlayerSlotData>
      {
         return this._players;
      }
      
      public function get owner() : String
      {
         return this._owner;
      }
      
      public function hasOwnerLeft() : Boolean
      {
         return !DCUtils.find(this.players,"id",this.owner);
      }
      
      public function update(param1:Object) : void
      {
         this._matchData.update(param1);
         this._owner = param1.owner;
         this.updatePlayers(param1.players is Array ? param1.players : [param1.players]);
      }
      
      private function updatePlayers(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:PlayerSlotData = null;
         this._players.splice(0,this._players.length);
         for each(_loc3_ in param1)
         {
            _loc2_ = this.createPlayerSlotData(_loc3_);
            this.updatePlayerClothes(_loc2_,_loc3_.worn_items);
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
      
      private function createPlayerSlotData(param1:Object) : PlayerSlotData
      {
         var _loc2_:PlayerSlotData = new PlayerSlotData(param1.id,param1.name,param1.level,param1.pictureUrl);
         this._players.push(_loc2_);
         return _loc2_;
      }
   }
}

