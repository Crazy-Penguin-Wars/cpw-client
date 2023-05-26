package tuxwars.data
{
   import com.dchoc.avatar.AvatarAnimation;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.items.ClothingItem;
   
   public class RematchData
   {
      
      public static const STATUS_WAITING:int = 0;
      
      public static const STATUS_READY:int = 1;
      
      public static const STATUS_LEFT:int = 2;
      
      public static const STATUS_NONE:int = 3;
      
      private static var _rematchReadyPlayers:Vector.<RematchDataPlayer>;
      
      private static var _customGameName:String;
       
      
      public function RematchData()
      {
         super();
         throw new Error("RematchData is a static class!");
      }
      
      public static function isRematchSet() : Boolean
      {
         return _rematchReadyPlayers && _rematchReadyPlayers.length > 0;
      }
      
      public static function clearRematchPlayers() : void
      {
         if(_rematchReadyPlayers)
         {
            _rematchReadyPlayers.splice(0,_rematchReadyPlayers.length);
         }
      }
      
      public static function getRematchPlayers() : Vector.<RematchDataPlayer>
      {
         return _rematchReadyPlayers;
      }
      
      public static function setRematchPlayer(playerObject:PlayerGameObject) : void
      {
         var i:int = 0;
         var avatar:* = null;
         var wornItems:* = null;
         if(!_rematchReadyPlayers)
         {
            _rematchReadyPlayers = new Vector.<RematchDataPlayer>();
         }
         var found:Boolean = false;
         for(i = 0; i < _rematchReadyPlayers.length; )
         {
            var _loc7_:* = playerObject;
            if(_rematchReadyPlayers[i].id == _loc7_._id)
            {
               found = true;
               break;
            }
            i++;
         }
         if(!found)
         {
            avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
            avatar.animate(new AvatarAnimation("idle"));
            avatar.paperDoll.animation.clip.stop();
            avatar.paperDoll.animation.clip.cacheAsBitmap = true;
            wornItems = playerObject.wornItemsContainer.getWornItems();
            for each(var item in wornItems)
            {
               if(item != null)
               {
                  avatar.wearClothing(item);
               }
            }
            var _loc10_:* = playerObject;
            var _loc11_:* = playerObject;
            _rematchReadyPlayers.push(new RematchDataPlayer(_loc10_._id,_loc11_._name,avatar));
         }
      }
      
      public static function setCustomGameName(name:String) : void
      {
         _customGameName = name;
      }
      
      public static function getCustomGameName() : String
      {
         return _customGameName;
      }
   }
}
