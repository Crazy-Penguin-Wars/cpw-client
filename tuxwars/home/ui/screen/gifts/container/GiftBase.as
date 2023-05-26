package tuxwars.home.ui.screen.gifts.container
{
   import com.dchoc.game.DCGame;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.ItemTooltip;
   import tuxwars.ui.tooltips.TooltipContainer;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.ui.tooltips.TuxTooltip;
   import tuxwars.utils.TuxUiUtils;
   
   public class GiftBase extends UIContainer
   {
       
      
      private var _shopItem:ShopItem;
      
      private var _gift:GiftReference;
      
      private var _game:TuxWarsGame;
      
      private var name:UIAutoTextField;
      
      private var iconContainer:MovieClip;
      
      public function GiftBase(design:MovieClip, gift:GiftReference, game:TuxWarsGame, parent:UIComponent = null)
      {
         var icon:* = null;
         super(design,parent);
         iconContainer = design.getChildByName("Icon") as MovieClip;
         if(gift.itemData)
         {
            _shopItem = ShopItemManager.getShopItem(gift.itemData);
            name = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text") as TextField,_shopItem.name);
            icon = _shopItem.icon;
         }
         else
         {
            name = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text") as TextField,gift.name);
            icon = gift.iconMovieClip;
         }
         DCUtils.replaceDisplayObject(iconContainer,icon);
         if(gift.id == "MysteryGift")
         {
            icon.gotoAndStop("Default");
         }
         _gift = gift;
         _game = game;
         design.addEventListener("mouseOver",mouseOver,false,0,true);
         design.addEventListener("mouseOut",mouseOut,false,0,true);
      }
      
      public function get shopItem() : ShopItem
      {
         return _shopItem;
      }
      
      public function get gift() : GiftReference
      {
         return _gift;
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",mouseOver,false);
         this._design.removeEventListener("mouseOut",mouseOut,false);
         super.dispose();
         _shopItem = null;
         _gift = null;
         _game = null;
         name = null;
         iconContainer = null;
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         var tooltip:* = null;
         var _loc3_:* = null;
         var b:Boolean = false;
         if(gift.itemData)
         {
            _loc3_ = ShopItemManager.getShopItem(gift.itemData);
            if(_loc3_)
            {
               if(_loc3_.itemData.type == "Weapon")
               {
                  tooltip = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getWeaponTooltipGraphics(),_game),this._design);
               }
               else if(_loc3_.itemData.type == "Clothing")
               {
                  tooltip = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getClothingTooltipGraphics(),_game),this._design);
               }
               else
               {
                  tooltip = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getBoosterTooltipGraphics(),_game),this._design);
               }
               var _loc5_:DCGame = DCGame;
               b = tooltip.getX() > Number(com.dchoc.game.DCGame._stage.width) / 3;
               if(b)
               {
                  var _loc6_:DCGame = DCGame;
                  (tooltip as ItemBaseTooltip).content.containers.show((tooltip.getY() > Number(com.dchoc.game.DCGame._stage.height) / 2 ? "Up" : "Down") + "Left",false);
               }
               tooltip.setX(tooltip.getX() + (b ? 0 : this._design.width));
               tooltip.setY(tooltip.getY() + Number(this._design.height) / 2);
               ((tooltip as ItemBaseTooltip).content.containers.getCurrentContainer() as TooltipContainer).amountTextField.setText("");
            }
         }
         else
         {
            tooltip = TooltipManager.showTooltip(new ItemTooltip(_gift.name,_gift.description),this._design);
            tooltip.setX(tooltip.getX() + Number(this._design.width) * 0.5);
         }
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function get game() : TuxWarsGame
      {
         return _game;
      }
   }
}
