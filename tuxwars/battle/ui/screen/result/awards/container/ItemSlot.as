package tuxwars.battle.ui.screen.result.awards.container
{
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.ui.components.IconButton;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   
   public class ItemSlot extends UIStateComponent
   {
       
      
      private var iconButton:IconButton;
      
      private var _itemName:String;
      
      private var _itemDescription:String;
      
      private var _amount:int;
      
      private var _shopItem:ShopItem;
      
      private var _game:TuxWarsGame;
      
      public function ItemSlot(design:MovieClip, game:TuxWarsGame, showTooltip:Boolean = true)
      {
         super(design);
         iconButton = new IconButton(design);
         iconButton.setMouseClickFunction(lootButtonClick);
         iconButton.setText(" ");
         _game = game;
         if(showTooltip)
         {
            design.addEventListener("mouseOver",mouseOver,false,0,true);
            design.addEventListener("mouseOut",mouseOut,false,0,true);
         }
      }
      
      public function lootButtonClick(event:MouseEvent) : void
      {
         LogUtils.log("Loot Button pressed",this,2,"TODO");
      }
      
      public function init(data:ItemData, amount:int = 1) : void
      {
         _itemName = data.name;
         _itemDescription = data.description;
         icon = data.icon;
         amount = amount;
         _shopItem = ShopItemManager.getShopItem(data);
      }
      
      public function set itemName(value:String) : void
      {
         _itemName = value;
      }
      
      public function set itemDescription(value:String) : void
      {
         _itemDescription = value;
      }
      
      public function set icon(value:MovieClip) : void
      {
         iconButton.setIcon(value);
      }
      
      public function set amount(value:int) : void
      {
         if(iconButton)
         {
            if(value <= 1)
            {
               iconButton.setText("");
            }
            else
            {
               iconButton.setText(value.toString());
            }
         }
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",mouseOver,false);
         this._design.removeEventListener("mouseOut",mouseOut,false);
         TooltipManager.removeTooltip();
         _game = null;
         _shopItem = null;
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         if(_shopItem)
         {
            if(_shopItem.itemData.type == "Weapon")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_shopItem,TooltipsData.getWeaponTooltipGraphics(),_game),this._design);
            }
            else if(_shopItem.itemData.type == "Clothing")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_shopItem,TooltipsData.getClothingTooltipGraphics(),_game),this._design);
            }
            else
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(_shopItem,TooltipsData.getBoosterTooltipGraphics(),_game),this._design);
            }
         }
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
