package tuxwars.battle.ui.screen.result.awards.container
{
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.tooltips.*;
   
   public class ItemSlot extends UIStateComponent
   {
      private var iconButton:IconButton;
      
      private var _itemName:String;
      
      private var _itemDescription:String;
      
      private var _amount:int;
      
      private var _shopItem:ShopItem;
      
      private var _game:TuxWarsGame;
      
      public function ItemSlot(param1:MovieClip, param2:TuxWarsGame, param3:Boolean = true)
      {
         super(param1);
         this.iconButton = new IconButton(param1);
         this.iconButton.setMouseClickFunction(this.lootButtonClick);
         this.iconButton.setText(" ");
         this._game = param2;
         if(param3)
         {
            param1.addEventListener("mouseOver",this.mouseOver,false,0,true);
            param1.addEventListener("mouseOut",this.mouseOut,false,0,true);
         }
      }
      
      public function lootButtonClick(param1:MouseEvent) : void
      {
         LogUtils.log("Loot Button pressed",this,2,"TODO");
      }
      
      public function init(param1:ItemData, param2:int = 1) : void
      {
         this._itemName = param1.name;
         this._itemDescription = param1.description;
         this.icon = param1.icon;
         param2 = param2;
         this._shopItem = ShopItemManager.getShopItem(param1);
      }
      
      public function set itemName(param1:String) : void
      {
         this._itemName = param1;
      }
      
      public function set itemDescription(param1:String) : void
      {
         this._itemDescription = param1;
      }
      
      public function set icon(param1:MovieClip) : void
      {
         this.iconButton.setIcon(param1);
      }
      
      public function set amount(param1:int) : void
      {
         if(this.iconButton)
         {
            if(param1 <= 1)
            {
               this.iconButton.setText("");
            }
            else
            {
               this.iconButton.setText(param1.toString());
            }
         }
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",this.mouseOver,false);
         this._design.removeEventListener("mouseOut",this.mouseOut,false);
         TooltipManager.removeTooltip();
         this._game = null;
         this._shopItem = null;
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         if(this._shopItem)
         {
            if(this._shopItem.itemData.type == "Weapon")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(this._shopItem,TooltipsData.getWeaponTooltipGraphics(),this._game),this._design);
            }
            else if(this._shopItem.itemData.type == "Clothing")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(this._shopItem,TooltipsData.getClothingTooltipGraphics(),this._game),this._design);
            }
            else
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(this._shopItem,TooltipsData.getBoosterTooltipGraphics(),this._game),this._design);
            }
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

