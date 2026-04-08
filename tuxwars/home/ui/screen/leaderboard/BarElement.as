package tuxwars.home.ui.screen.leaderboard
{
   import com.dchoc.avatar.*;
   import com.dchoc.game.*;
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.ui.progress.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.items.*;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.player.*;
   import tuxwars.utils.*;
   
   public class BarElement extends UIStateComponent
   {
      private var slider:UIProgressIndicator;
      
      private var friendSlot:FriendSlot;
      
      private var friend:TuxFriend;
      
      private var avatar:TuxAvatar;
      
      private var game:TuxWarsGame;
      
      public function BarElement(param1:MovieClip, param2:Object, param3:TuxWarsGame, param4:int, param5:Object, param6:String)
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         super(param1);
         this.game = param3;
         if(param2)
         {
            this.friend = param3.player.friends.getFriend(param2.dcgId) as TuxFriend;
            _loc7_ = param4 < 100 ? 100 : 1;
            _loc8_ = param2.value * _loc7_;
            _loc9_ = param4 * _loc7_;
            if(param6 == "avg_position")
            {
               _loc9_ = 300;
               switch(param2.value)
               {
                  case 1:
                     _loc8_ = 300;
                     break;
                  case 2:
                     _loc8_ = 200;
                     break;
                  case 3:
                     _loc8_ = 100;
                     break;
                  default:
                     _loc8_ = 0;
               }
            }
            param1.Slider_Highlight.visible = this.friend is Player;
            param1.Slider_Normal.visible = !(this.friend is Player);
            this.slider = new UIProgressIndicator(this.friend is Player ? param1.Slider_Highlight : param1.Slider_Normal,0,_loc9_);
            this.slider.setValue(_loc8_);
         }
         else
         {
            param1.Slider_Highlight.visible = false;
            param1.Slider_Normal.visible = true;
            this.slider = new UIProgressIndicator(param1.Slider_Normal,0,param4);
         }
         var _loc10_:UIProgressIndicator = this.slider;
         TuxUiUtils.createAutoTextFieldWithText(_loc10_._design.Fill.Value.Text,!!param2 ? param2.value.toString() : "");
         this.friendSlot = new FriendSlot(param1.Info);
         this.friendSlot.setFriend(this.friend);
         if(this.friend)
         {
            TuxUiUtils.createAutoTextFieldWithText(this.friendSlot.design.Slot_Default.Text_Place,param2.position);
            this.setupAvatar(this.getWornItems(param5,param2.dcgId));
         }
         LogicUpdater.register(this,"BarElement");
      }
      
      override public function dispose() : void
      {
         LogicUpdater.unregister(this,"BarElement");
         this.slider.dispose();
         this.slider = null;
         this.friendSlot = null;
         if(this.avatar)
         {
            this.avatar.dispose();
            this.avatar = null;
         }
         super.dispose();
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.slider.logicUpdate(param1);
         if(this.avatar)
         {
            this.avatar.logicUpdate(param1);
         }
      }
      
      private function setupAvatar(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Array = null;
         this.avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         this.avatar.animate(new AvatarAnimation("idle"));
         var _loc3_:UIProgressIndicator = this.slider;
         _loc3_._design.Fill.Item.addChild(this.avatar);
         this.wearDefaultValues();
         if(param1.worn_item)
         {
            _loc2_ = param1.worn_item is Array ? param1.worn_item : [param1.worn_item];
            for each(_loc4_ in _loc2_)
            {
               this.wearItem(_loc4_.item_id);
            }
         }
      }
      
      private function wearDefaultValues() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<ItemData> = ItemManager.findItemDatas("Customization");
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.getCategoryDefault() == "TRUE")
            {
               this.wearItem(_loc2_.id);
            }
         }
      }
      
      private function wearItem(param1:String) : void
      {
         var _loc2_:ClothingItem = ItemManager.createItem(param1) as ClothingItem;
         if(_loc2_)
         {
            this.avatar.wearClothing(_loc2_);
         }
      }
      
      private function getWornItems(param1:Object, param2:String) : Object
      {
         var _loc4_:* = undefined;
         var _loc3_:Array = param1.user is Array ? param1.user : [param1.user];
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.dcgId == param2)
            {
               return !!_loc4_.wornItems ? _loc4_.wornItems : {};
            }
         }
         return {};
      }
   }
}

