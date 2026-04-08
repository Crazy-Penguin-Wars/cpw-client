package tuxwars.ui.containers.shop.container.item
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.effects.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.*;
   import flash.text.*;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.containers.shop.container.tags.ContainerTags;
   import tuxwars.ui.containers.slotitem.*;
   import tuxwars.utils.*;
   
   public class ItemMegaPack extends ContainerTags
   {
      private var _name:UIAutoTextField;
      
      private var _normalPriceTitle:UIAutoTextField;
      
      private var _normalPriceTotalCoins:UIAutoTextField;
      
      private var _normalPriceTotalCash:UIAutoTextField;
      
      private var _iconContainer:MovieClip;
      
      private var _icon:MovieClip;
      
      private var _objectContaincer:ObjectContainer;
      
      private var _slotElement:SlotElement;
      
      public function ItemMegaPack(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         var _loc5_:int = 0;
         var _loc6_:ShopItem = null;
         var _loc7_:int = 0;
         super(param1,param2,param3,param4);
         assert("Data is not an array or lenght 1",true,param2 is Array && (param2 as Array).length == 1);
         this._name = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Name as TextField,this.megaPackData.name);
         this._normalPriceTitle = TuxUiUtils.createAutoTextField(param1.Text_Price as TextField,"NORMAL_PRICE");
         this._normalPriceTotalCoins = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Price_Coins as TextField,"" + this.megaPackData.normalCoinsCost);
         this._normalPriceTotalCash = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Price_Cash as TextField,"" + this.megaPackData.normalCashCost);
         this._iconContainer = param1.Container_Icon;
         this.setIcon(this.shopItem.icon);
         this._objectContaincer = new ObjectContainer(param1,param3,this.getSlotContentObject,null,null,false);
         var _loc8_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < this.megaPackData.itemList.length)
         {
            _loc6_ = ShopItemManager.getShopItemWithId(this.megaPackData.itemList[_loc5_].id);
            _loc7_ = int(this.megaPackData.itemAmountList[_loc5_]);
            _loc8_.push([_loc6_,_loc7_]);
            _loc5_++;
         }
         this._objectContaincer.init(_loc8_);
         MessageCenter.addListener("ItemBought",this.triggerIconTransition);
         this._slotElement = new SlotElement(param1,param3,this.shopItem,param4,false,true);
      }
      
      private function getSlotContentObject(param1:int, param2:*, param3:MovieClip) : IconTooltipButton
      {
         var _loc4_:ShopItem = param2[0];
         var _loc5_:int = int(param2[1]);
         var _loc6_:IconTooltipButton = new IconTooltipButton(param3,_loc4_,game);
         _loc6_.setIcon(_loc4_.icon);
         _loc6_.setText("" + _loc5_);
         return _loc6_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("ItemBought",this.triggerIconTransition);
         this._name = null;
         this._normalPriceTitle = null;
         this._normalPriceTotalCoins = null;
         this._normalPriceTotalCash = null;
         if(this._objectContaincer)
         {
            this._objectContaincer.dispose();
            this._objectContaincer = null;
         }
         if(this._slotElement)
         {
            this._slotElement.dispose();
            this._slotElement = null;
         }
      }
      
      private function get shopItem() : ShopItem
      {
         return data[0];
      }
      
      public function get megaPackData() : MegaPackData
      {
         return this.shopItem.itemData as MegaPackData;
      }
      
      public function setIcon(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         if(this._iconContainer)
         {
            _loc2_ = 0;
            while(_loc2_ < this._iconContainer.numChildren)
            {
               this._iconContainer.removeChildAt(_loc2_);
               _loc2_++;
            }
         }
         this._icon = param1;
         if(Boolean(param1) && !this._iconContainer.contains(param1))
         {
            if(param1.numChildren > 0 && param1.getChildAt(0) is Bitmap)
            {
               Bitmap(param1.getChildAt(0)).smoothing = true;
            }
            this._iconContainer.addChild(param1);
         }
         updateTextField();
      }
      
      private function triggerIconTransition(param1:Message) : void
      {
         if(this.shopItem.id == param1.data.item.item_id)
         {
            BuyingAnimation.startAnimation(this._icon,this.shopItem.amountPurchased,this.shopItem.icon);
         }
      }
   }
}

