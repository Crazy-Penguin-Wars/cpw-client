package tuxwars.home.ui.screen.leaderboard
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.ui.progress.UIProgressIndicator;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.home.ui.screen.home.FriendSlot;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.player.Player;
   import tuxwars.player.TuxFriend;
   import tuxwars.utils.TuxUiUtils;
   
   public class BarElement extends UIStateComponent
   {
       
      
      private var slider:UIProgressIndicator;
      
      private var friendSlot:FriendSlot;
      
      private var friend:TuxFriend;
      
      private var avatar:TuxAvatar;
      
      private var game:TuxWarsGame;
      
      public function BarElement(design:MovieClip, statObj:Object, game:TuxWarsGame, maxValue:int, wornItems:Object, stat:String)
      {
         var _loc9_:int = 0;
         var value:int = 0;
         var max:int = 0;
         super(design);
         this.game = game;
         if(statObj)
         {
            friend = game.player.friends.getFriend(statObj.dcgId) as TuxFriend;
            _loc9_ = maxValue < 100 ? 100 : 1;
            value = Number(statObj.value) * _loc9_;
            max = maxValue * _loc9_;
            if(stat == "avg_position")
            {
               max = 300;
               switch(statObj.value)
               {
                  case 1:
                     value = 300;
                     break;
                  case 2:
                     value = 200;
                     break;
                  case 3:
                     value = 100;
                     break;
                  default:
                     value = 0;
               }
            }
            design.Slider_Highlight.visible = friend is Player;
            design.Slider_Normal.visible = !(friend is Player);
            slider = new UIProgressIndicator(friend is Player ? design.Slider_Highlight : design.Slider_Normal,0,max);
            slider.setValue(value);
         }
         else
         {
            design.Slider_Highlight.visible = false;
            design.Slider_Normal.visible = true;
            slider = new UIProgressIndicator(design.Slider_Normal,0,maxValue);
         }
         var _loc11_:UIProgressIndicator = slider;
         TuxUiUtils.createAutoTextFieldWithText(_loc11_._design.Fill.Value.Text,!!statObj ? statObj.value.toString() : "");
         friendSlot = new FriendSlot(design.Info);
         friendSlot.setFriend(friend);
         if(friend)
         {
            TuxUiUtils.createAutoTextFieldWithText(friendSlot.design.Slot_Default.Text_Place,statObj.position);
            setupAvatar(getWornItems(wornItems,statObj.dcgId));
         }
         LogicUpdater.register(this,"BarElement");
      }
      
      override public function dispose() : void
      {
         LogicUpdater.unregister(this,"BarElement");
         slider.dispose();
         slider = null;
         friendSlot = null;
         if(avatar)
         {
            avatar.dispose();
            avatar = null;
         }
         super.dispose();
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         slider.logicUpdate(deltaTime);
         if(avatar)
         {
            avatar.logicUpdate(deltaTime);
         }
      }
      
      private function setupAvatar(wornItems:Object) : void
      {
         var _loc3_:* = null;
         avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         avatar.animate(new AvatarAnimation("idle"));
         var _loc4_:UIProgressIndicator = slider;
         _loc4_._design.Fill.Item.addChild(avatar);
         wearDefaultValues();
         if(wornItems.worn_item)
         {
            _loc3_ = wornItems.worn_item is Array ? wornItems.worn_item : [wornItems.worn_item];
            for each(var itemData in _loc3_)
            {
               wearItem(itemData.item_id);
            }
         }
      }
      
      private function wearDefaultValues() : void
      {
         var _loc1_:Vector.<ItemData> = ItemManager.findItemDatas("Customization");
         for each(var i in _loc1_)
         {
            if(i.getCategoryDefault() == "TRUE")
            {
               wearItem(i.id);
            }
         }
      }
      
      private function wearItem(id:String) : void
      {
         var _loc2_:ClothingItem = ItemManager.createItem(id) as ClothingItem;
         if(_loc2_)
         {
            avatar.wearClothing(_loc2_);
         }
      }
      
      private function getWornItems(allItems:Object, id:String) : Object
      {
         var _loc3_:Array = allItems.user is Array ? allItems.user : [allItems.user];
         for each(var user in _loc3_)
         {
            if(user.dcgId == id)
            {
               return !!user.wornItems ? user.wornItems : {};
            }
         }
         return {};
      }
   }
}
