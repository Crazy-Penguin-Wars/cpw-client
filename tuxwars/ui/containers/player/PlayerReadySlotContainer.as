package tuxwars.ui.containers.player
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class PlayerReadySlotContainer extends UIContainer implements IResourceLoaderURL
   {
       
      
      private var avatar:TuxAvatar;
      
      private var pictureUrl:String;
      
      private var loader:URLResourceLoader;
      
      public function PlayerReadySlotContainer(design:MovieClip, index:int)
      {
         super(design);
         createAvatar();
         TuxUiUtils.createAutoTextField(design.Text_Player,"PLAYER_" + index);
      }
      
      public function init(playerData:PlayerSlotData) : void
      {
         var _loc5_:MovieClip = this._design.Slot_Default;
         _loc5_.Text_Name.text = playerData.name;
         _loc5_.Icon_Level.Text_Level.text = playerData.level.toString();
         pictureUrl = playerData.pictureURL;
         loader = ResourceLoaderURL.getInstance().load(this);
         createAvatar();
         var _loc4_:Vector.<ItemData> = ItemManager.findItemDatas("Customization");
         for each(var cutomizationItem in _loc4_)
         {
            if(cutomizationItem.getCategoryDefault() == "TRUE")
            {
               avatar.wearClothing(ItemManager.createItem(cutomizationItem.id) as ClothingItem);
            }
         }
         for each(var clothing in playerData.clothes)
         {
            avatar.wearClothing(clothing);
         }
      }
      
      override public function dispose() : void
      {
         avatar.dispose();
         loader = null;
         super.dispose();
      }
      
      public function getResourceUrl() : String
      {
         return pictureUrl;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return DisplayObjectContainer(getDesignMovieClip().getChildByName("Slot_Default")).getChildByName("Container_Profile_Picture") as MovieClip;
      }
      
      private function createAvatar() : void
      {
         if(avatar)
         {
            this._design.Container_Character.removeChild(avatar);
            avatar.dispose();
         }
         avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         avatar.animate(new AvatarAnimation("idle"));
         this._design.Container_Character.addChild(avatar);
      }
   }
}
