package tuxwars.ui.containers.shop.container.item
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.effects.BuyingAnimation;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import no.olog.utilfunctions.assert;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.MegaPackData;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.ui.components.IconTooltipButton;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.containers.shop.container.tags.ContainerTags;
   import tuxwars.ui.containers.slotitem.SlotElement;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function ItemMegaPack(design:MovieClip, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         var i:int = 0;
         var shopItemA:* = null;
         var itemAmount:int = 0;
         super(design,data,game,parent);
         assert("Data is not an array or lenght 1",true,data is Array && (data as Array).length == 1);
         _name = TuxUiUtils.createAutoTextFieldWithText(design.Text_Name as TextField,megaPackData.name);
         _normalPriceTitle = TuxUiUtils.createAutoTextField(design.Text_Price as TextField,"NORMAL_PRICE");
         _normalPriceTotalCoins = TuxUiUtils.createAutoTextFieldWithText(design.Text_Price_Coins as TextField,"" + megaPackData.normalCoinsCost);
         _normalPriceTotalCash = TuxUiUtils.createAutoTextFieldWithText(design.Text_Price_Cash as TextField,"" + megaPackData.normalCashCost);
         _iconContainer = design.Container_Icon;
         setIcon(shopItem.icon);
         _objectContaincer = new ObjectContainer(design,game,getSlotContentObject,null,null,false);
         var newArray:Array = [];
         for(i = 0; i < megaPackData.itemList.length; )
         {
            shopItemA = ShopItemManager.getShopItemWithId(megaPackData.itemList[i].id);
            itemAmount = int(megaPackData.itemAmountList[i]);
            newArray.push([shopItemA,itemAmount]);
            i++;
         }
         _objectContaincer.init(newArray);
         MessageCenter.addListener("ItemBought",triggerIconTransition);
         _slotElement = new SlotElement(design,game,shopItem,parent,false,true);
      }
      
      private function getSlotContentObject(slotIndex:int, object:*, movieclip:MovieClip) : IconTooltipButton
      {
         var shopItem:ShopItem = object[0];
         var itemAmount:int = int(object[1]);
         var button:IconTooltipButton = new IconTooltipButton(movieclip,shopItem,game);
         button.setIcon(shopItem.icon);
         button.setText("" + itemAmount);
         return button;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("ItemBought",triggerIconTransition);
         _name = null;
         _normalPriceTitle = null;
         _normalPriceTotalCoins = null;
         _normalPriceTotalCash = null;
         if(_objectContaincer)
         {
            _objectContaincer.dispose();
            _objectContaincer = null;
         }
         if(_slotElement)
         {
            _slotElement.dispose();
            _slotElement = null;
         }
      }
      
      private function get shopItem() : ShopItem
      {
         return data[0];
      }
      
      public function get megaPackData() : MegaPackData
      {
         return shopItem.itemData as MegaPackData;
      }
      
      public function setIcon(icon:MovieClip) : void
      {
         var i:int = 0;
         if(_iconContainer)
         {
            for(i = 0; i < _iconContainer.numChildren; )
            {
               _iconContainer.removeChildAt(i);
               i++;
            }
         }
         _icon = icon;
         if(icon && !_iconContainer.contains(icon))
         {
            if(icon.numChildren > 0 && icon.getChildAt(0) is Bitmap)
            {
               Bitmap(icon.getChildAt(0)).smoothing = true;
            }
            _iconContainer.addChild(icon);
         }
         updateTextField();
      }
      
      private function triggerIconTransition(msg:Message) : void
      {
         if(shopItem.id == msg.data.item.item_id)
         {
            BuyingAnimation.startAnimation(_icon,shopItem.amountPurchased,shopItem.icon);
         }
      }
   }
}
