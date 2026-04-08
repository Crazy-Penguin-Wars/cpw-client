package tuxwars.ui.containers.player
{
   import com.dchoc.avatar.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.*;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.home.ui.logic.privategame.host.PlayerSlotData;
   import tuxwars.items.*;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.utils.*;
   
   public class PlayerReadySlotContainer extends UIContainer implements IResourceLoaderURL
   {
      private var avatar:TuxAvatar;
      
      private var pictureUrl:String;
      
      private var loader:URLResourceLoader;
      
      public function PlayerReadySlotContainer(param1:MovieClip, param2:int)
      {
         super(param1);
         this.createAvatar();
         TuxUiUtils.createAutoTextField(param1.Text_Player,"PLAYER_" + param2);
      }
      
      public function init(param1:PlayerSlotData) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:MovieClip = this._design.Slot_Default;
         _loc2_.Text_Name.text = param1.name;
         _loc2_.Icon_Level.Text_Level.text = param1.level.toString();
         this.pictureUrl = param1.pictureURL;
         this.loader = ResourceLoaderURL.getInstance().load(this);
         this.createAvatar();
         var _loc3_:Vector.<ItemData> = ItemManager.findItemDatas("Customization");
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.getCategoryDefault() == "TRUE")
            {
               this.avatar.wearClothing(ItemManager.createItem(_loc4_.id) as ClothingItem);
            }
         }
         for each(_loc5_ in param1.clothes)
         {
            this.avatar.wearClothing(_loc5_);
         }
      }
      
      override public function dispose() : void
      {
         this.avatar.dispose();
         this.loader = null;
         super.dispose();
      }
      
      public function getResourceUrl() : String
      {
         return this.pictureUrl;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return DisplayObjectContainer(getDesignMovieClip().getChildByName("Slot_Default")).getChildByName("Container_Profile_Picture") as MovieClip;
      }
      
      private function createAvatar() : void
      {
         if(this.avatar)
         {
            this.avatar.dispose();
         }
         this.avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         this.avatar.animate(new AvatarAnimation("idle"));
         this._design.Container_Character.addChild(this.avatar);
      }
   }
}

