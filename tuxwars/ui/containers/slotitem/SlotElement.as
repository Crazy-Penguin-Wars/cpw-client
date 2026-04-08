package tuxwars.ui.containers.slotitem
{
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.containers.slotitem.uicontainers.*;
   import tuxwars.ui.tooltips.*;
   
   public class SlotElement extends UIStateComponent implements IShopTutorial
   {
      private var _game:TuxWarsGame;
      
      private var _shopItem:ShopItem;
      
      private var _parent:TuxUIScreen;
      
      private var _buttonContainers:ButtonContainers;
      
      private var _itemContainers:ItemContainers;
      
      public function SlotElement(param1:MovieClip, param2:TuxWarsGame, param3:ShopItem, param4:TuxUIScreen = null, param5:Boolean = true, param6:Boolean = false)
      {
         super(param1);
         this._game = param2;
         this._shopItem = param3;
         this._parent = param4;
         if(!param6)
         {
            this._itemContainers = new ItemContainers(this);
         }
         this._buttonContainers = new ButtonContainers(this);
         if(param5)
         {
            param1.addEventListener("mouseOver",this.mouseOver,false,0,true);
            param1.addEventListener("mouseOut",this.mouseOut,false,0,true);
         }
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",this.mouseOver,false);
         this._design.removeEventListener("mouseOut",this.mouseOut,false);
         TooltipManager.removeTooltip();
         this._game = null;
         this._shopItem = null;
         if(this._buttonContainers)
         {
            this._buttonContainers.dispose();
            this._buttonContainers = null;
         }
         if(this._itemContainers)
         {
            this._itemContainers.dispose();
            this._itemContainers = null;
         }
         super.dispose();
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(this._itemContainers)
         {
            this._itemContainers.enabled = param1;
         }
         if(this._buttonContainers)
         {
            this._buttonContainers.enabled = param1;
         }
      }
      
      public function get game() : TuxWarsGame
      {
         return this._game;
      }
      
      public function get shopItem() : ShopItem
      {
         return this._shopItem;
      }
      
      public function get buttonContainers() : ButtonContainers
      {
         return this._buttonContainers;
      }
      
      public function get itemContainers() : ItemContainers
      {
         return this._itemContainers;
      }
      
      public function get parent() : TuxUIScreen
      {
         return this._parent;
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
         else
         {
            LogUtils.log("No tooltip configured for non shopItems",this,0,"Tooltips",false,false,false);
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:* = undefined;
         if(Boolean(this.shopItem) && Boolean(param1))
         {
            this.enabled = this.shopItem.id == param1;
            if(this.shopItem.id == param1)
            {
               _loc4_ = this.buttonContainers.getCurrentContainer();
               param3(param2,_loc4_._design);
               DCUtils.bringToFront(this._design.parent,this._design);
            }
         }
         else
         {
            this.enabled = false;
         }
      }
   }
}

