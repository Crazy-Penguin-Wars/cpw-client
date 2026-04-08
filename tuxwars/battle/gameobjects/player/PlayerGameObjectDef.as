package tuxwars.battle.gameobjects.player
{
   import com.dchoc.data.GameData;
   import nape.space.Space;
   import tuxwars.battle.data.player.*;
   import tuxwars.player.Inventory;
   import tuxwars.player.Player;
   
   public class PlayerGameObjectDef extends AvatarGameObjectDef
   {
      private var _inventory:Inventory;
      
      private var _wornItems:Object;
      
      public function PlayerGameObjectDef(param1:Space)
      {
         super(param1);
      }
      
      public function get inventory() : Inventory
      {
         return this._inventory;
      }
      
      public function get wornItems() : Object
      {
         return this._wornItems;
      }
      
      public function loadPlayer(param1:Player) : void
      {
         super.loadDataConf(Players.getPlayerData());
         this._inventory = param1.inventory;
         this._wornItems = param1.wornItemsContainer.getWornItems();
         objClass = param1.ai ? AIPlayerGameObject : PlayerGameObject;
         id = param1.id;
         name = param1.name;
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
      }
   }
}

