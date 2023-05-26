package tuxwars.home.ui.screen.home
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.ClothingItem;
   import tuxwars.net.messages.WornItemsUpdatedMessage;
   
   public class CharacterAvatarElementScreen extends TuxUIElementScreen
   {
      
      private static const CHARACTER_CONTAINER:String = "Container_Character";
      
      private static var tuxGame:TuxWarsGame;
       
      
      private var _avatar:TuxAvatar;
      
      private var _container:MovieClip;
      
      public function CharacterAvatarElementScreen(design:MovieClip, game:TuxWarsGame)
      {
         super(design,game);
         _container = design.getChildByName("Container_Character") as MovieClip;
         setupAvatar(_container);
         MessageCenter.addListener("WornItemsUpdated",wornItemUpdate);
      }
      
      public function get avatar() : TuxAvatar
      {
         return _avatar;
      }
      
      public function get avatarContainer() : MovieClip
      {
         return getDesignMovieClip();
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("WornItemsUpdated",wornItemUpdate);
         _avatar.dispose();
         _avatar = null;
         super.dispose();
      }
      
      public function wornItemUpdate(msg:WornItemsUpdatedMessage) : void
      {
         fetchTuxGame();
         if(tuxGame.player.id == msg.player.id)
         {
            switch(msg.wearEvent)
            {
               case "ItemUnWear":
                  _avatar.unWearClothing(game.player.inventory.getItem(msg.shopItem.id) as ClothingItem);
                  break;
               case "ItemUnWearPreview":
                  _avatar.unWearClothing(game.player.inventory.getItem(msg.shopItem.id,true) as ClothingItem);
                  break;
               case "ItemWear":
                  _avatar.wearClothing(game.player.inventory.getItem(msg.shopItem.id) as ClothingItem);
                  break;
               case "ItemWearPreview":
                  _avatar.wearClothing(game.player.inventory.getItem(msg.shopItem.id,true) as ClothingItem);
                  break;
               default:
                  LogUtils.log("Unrecognized item wear event: " + msg.wearEvent,this,3,"Avatar",false,true);
            }
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         _avatar.logicUpdate(deltaTime);
      }
      
      private function setupAvatar(container:MovieClip) : void
      {
         _avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         _avatar.animate(new AvatarAnimation("idle"));
         container.addChild(_avatar);
         var _loc2_:Object = game.player.wornItemsContainer.getWornItems();
         for each(var item in _loc2_)
         {
            if(item)
            {
               _avatar.wearClothing(item);
            }
         }
      }
      
      private function fetchTuxGame() : void
      {
         if(!tuxGame)
         {
            MessageCenter.addListener("SendGame",sendGameHandler);
            MessageCenter.sendMessage("GetGame");
         }
      }
      
      private function sendGameHandler(msg:Message) : void
      {
         MessageCenter.removeListener("SendGame",sendGameHandler);
         tuxGame = msg.data;
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
