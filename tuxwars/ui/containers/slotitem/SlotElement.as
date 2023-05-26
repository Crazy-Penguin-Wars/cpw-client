package tuxwars.ui.containers.slotitem
{
   import com.dchoc.ui.base.UIStateComponent;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.containers.shop.IShopTutorial;
   import tuxwars.ui.containers.slotitem.uicontainers.ButtonContainers;
   import tuxwars.ui.containers.slotitem.uicontainers.ItemContainers;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   
   public class SlotElement extends UIStateComponent implements IShopTutorial
   {
       
      
      private var _game:TuxWarsGame;
      
      private var _shopItem:ShopItem;
      
      private var _parent:TuxUIScreen;
      
      private var _buttonContainers:ButtonContainers;
      
      private var _itemContainers:ItemContainers;
      
      public function SlotElement(design:MovieClip, game:TuxWarsGame, shopItem:ShopItem, parent:TuxUIScreen = null, showTooltip:Boolean = true, ignoreItemContainers:Boolean = false)
      {
         super(design);
         _game = game;
         _shopItem = shopItem;
         _parent = parent;
         if(!ignoreItemContainers)
         {
            _itemContainers = new ItemContainers(this);
         }
         _buttonContainers = new ButtonContainers(this);
         if(showTooltip)
         {
            design.addEventListener("mouseOver",mouseOver,false,0,true);
            design.addEventListener("mouseOut",mouseOut,false,0,true);
         }
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",mouseOver,false);
         this._design.removeEventListener("mouseOut",mouseOut,false);
         TooltipManager.removeTooltip();
         _game = null;
         _shopItem = null;
         if(_buttonContainers)
         {
            _buttonContainers.dispose();
            _buttonContainers = null;
         }
         if(_itemContainers)
         {
            _itemContainers.dispose();
            _itemContainers = null;
         }
         super.dispose();
      }
      
      public function set enabled(value:Boolean) : void
      {
         if(_itemContainers)
         {
            _itemContainers.enabled = value;
         }
         if(_buttonContainers)
         {
            _buttonContainers.enabled = value;
         }
      }
      
      public function get game() : TuxWarsGame
      {
         return _game;
      }
      
      public function get shopItem() : ShopItem
      {
         return _shopItem;
      }
      
      public function get buttonContainers() : ButtonContainers
      {
         return _buttonContainers;
      }
      
      public function get itemContainers() : ItemContainers
      {
         return _itemContainers;
      }
      
      public function get parent() : TuxUIScreen
      {
         return _parent;
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
         else
         {
            LogUtils.log("No tooltip configured for non shopItems",this,0,"Tooltips",false,false,false);
         }
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         if(shopItem && itemID)
         {
            enabled = shopItem.id == itemID;
            if(shopItem.id == itemID)
            {
               var _loc4_:* = buttonContainers.getCurrentContainer();
               addTutorialArrow(arrow,_loc4_._design);
               DCUtils.bringToFront(this._design.parent,this._design);
            }
         }
         else
         {
            enabled = false;
         }
      }
   }
}
