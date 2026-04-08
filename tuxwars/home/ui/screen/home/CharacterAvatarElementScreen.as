package tuxwars.home.ui.screen.home
{
   import com.dchoc.avatar.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.*;
   import tuxwars.net.messages.WornItemsUpdatedMessage;
   
   public class CharacterAvatarElementScreen extends TuxUIElementScreen
   {
      private static var tuxGame:TuxWarsGame;
      
      private static const CHARACTER_CONTAINER:String = "Container_Character";
      
      private var _avatar:TuxAvatar;
      
      private var _container:MovieClip;
      
      public function CharacterAvatarElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this._container = param1.getChildByName("Container_Character") as MovieClip;
         this.setupAvatar(this._container);
         MessageCenter.addListener("WornItemsUpdated",this.wornItemUpdate);
      }
      
      public function get avatar() : TuxAvatar
      {
         return this._avatar;
      }
      
      public function get avatarContainer() : MovieClip
      {
         return getDesignMovieClip();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("WornItemsUpdated",this.wornItemUpdate);
         this._avatar.dispose();
         this._avatar = null;
         super.dispose();
      }
      
      public function wornItemUpdate(param1:WornItemsUpdatedMessage) : void
      {
         this.fetchTuxGame();
         if(tuxGame.player.id == param1.player.id)
         {
            switch(param1.wearEvent)
            {
               case "ItemUnWear":
                  this._avatar.unWearClothing(game.player.inventory.getItem(param1.shopItem.id) as ClothingItem);
                  break;
               case "ItemUnWearPreview":
                  this._avatar.unWearClothing(game.player.inventory.getItem(param1.shopItem.id,true) as ClothingItem);
                  break;
               case "ItemWear":
                  this._avatar.wearClothing(game.player.inventory.getItem(param1.shopItem.id) as ClothingItem);
                  break;
               case "ItemWearPreview":
                  this._avatar.wearClothing(game.player.inventory.getItem(param1.shopItem.id,true) as ClothingItem);
                  break;
               default:
                  LogUtils.log("Unrecognized item wear event: " + param1.wearEvent,this,3,"Avatar",false,true);
            }
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this._avatar.logicUpdate(param1);
      }
      
      private function setupAvatar(param1:MovieClip) : void
      {
         var _loc3_:* = undefined;
         this._avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         this._avatar.animate(new AvatarAnimation("idle"));
         param1.addChild(this._avatar);
         var _loc2_:Object = game.player.wornItemsContainer.getWornItems();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_)
            {
               this._avatar.wearClothing(_loc3_);
            }
         }
      }
      
      private function fetchTuxGame() : void
      {
         if(!tuxGame)
         {
            MessageCenter.addListener("SendGame",this.sendGameHandler);
            MessageCenter.sendMessage("GetGame");
         }
      }
      
      private function sendGameHandler(param1:Message) : void
      {
         MessageCenter.removeListener("SendGame",this.sendGameHandler);
         tuxGame = param1.data;
      }
      
      public function playMovieClip() : void
      {
         DCUtils.playMovieClip(getDesignMovieClip().Container_Character);
      }
      
      public function stopMovieClip() : void
      {
         DCUtils.stopMovieClip(getDesignMovieClip().Container_Character);
      }
   }
}

