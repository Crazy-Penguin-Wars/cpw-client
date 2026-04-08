package tuxwars.data
{
   import com.dchoc.avatar.*;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class RematchData
   {
      private static var _rematchReadyPlayers:Vector.<RematchDataPlayer>;
      
      private static var _customGameName:String;
      
      public static const STATUS_WAITING:int = 0;
      
      public static const STATUS_READY:int = 1;
      
      public static const STATUS_LEFT:int = 2;
      
      public static const STATUS_NONE:int = 3;
      
      public function RematchData()
      {
         super();
         throw new Error("RematchData is a static class!");
      }
      
      public static function isRematchSet() : Boolean
      {
         return Boolean(_rematchReadyPlayers) && _rematchReadyPlayers.length > 0;
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
      
      public static function setRematchPlayer(param1:PlayerGameObject) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:TuxAvatar = null;
         var _loc4_:Object = null;
         if(!_rematchReadyPlayers)
         {
            _rematchReadyPlayers = new Vector.<RematchDataPlayer>();
         }
         var _loc5_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _rematchReadyPlayers.length)
         {
            _loc6_ = param1;
            if(_rematchReadyPlayers[_loc2_].id == _loc6_._id)
            {
               _loc5_ = true;
               break;
            }
            _loc2_++;
         }
         if(!_loc5_)
         {
            _loc3_ = new TuxAvatar(Players.getPlayerData().graphics.swf);
            _loc3_.animate(new AvatarAnimation("idle"));
            _loc3_.paperDoll.animation.clip.stop();
            _loc3_.paperDoll.animation.clip.cacheAsBitmap = true;
            _loc4_ = param1.wornItemsContainer.getWornItems();
            for each(_loc7_ in _loc4_)
            {
               if(_loc7_ != null)
               {
                  _loc3_.wearClothing(_loc7_);
               }
            }
            _loc8_ = param1;
            _loc9_ = param1;
            _rematchReadyPlayers.push(new RematchDataPlayer(_loc8_._id,_loc9_._name,_loc3_));
         }
      }
      
      public static function setCustomGameName(param1:String) : void
      {
         _customGameName = param1;
      }
      
      public static function getCustomGameName() : String
      {
         return _customGameName;
      }
   }
}

