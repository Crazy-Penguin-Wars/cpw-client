package tuxwars.battle.gameobjects.player
{
   import com.dchoc.data.GameData;
   import nape.space.Space;
   import tuxwars.battle.data.player.Players;
   import tuxwars.player.Inventory;
   import tuxwars.player.Player;
   
   public class PlayerGameObjectDef extends AvatarGameObjectDef
   {
       
      
      private var _inventory:Inventory;
      
      private var _wornItems:Object;
      
      public function PlayerGameObjectDef(space:Space)
      {
         super(space);
      }
      
      public function get inventory() : Inventory
      {
         return _inventory;
      }
      
      public function get wornItems() : Object
      {
         return _wornItems;
      }
      
      public function loadPlayer(player:Player) : void
      {
         super.loadDataConf(Players.getPlayerData());
         _inventory = player.inventory;
         _wornItems = player.wornItemsContainer.getWornItems();
         objClass = player.ai ? AIPlayerGameObject : PlayerGameObject;
         id = player.id;
         name = player.name;
      }
      
      override public function loadDataConf(data:GameData) : void
      {
      }
   }
}
