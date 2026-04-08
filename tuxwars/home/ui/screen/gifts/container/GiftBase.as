package tuxwars.home.ui.screen.gifts.container
{
   import com.dchoc.game.DCGame;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class GiftBase extends UIContainer
   {
      private var _shopItem:ShopItem;
      
      private var _gift:GiftReference;
      
      private var _game:TuxWarsGame;
      
      private var name:UIAutoTextField;
      
      private var iconContainer:MovieClip;
      
      public function GiftBase(param1:MovieClip, param2:GiftReference, param3:TuxWarsGame, param4:UIComponent = null)
      {
         var _loc5_:MovieClip = null;
         super(param1,param4);
         this.iconContainer = param1.getChildByName("Icon") as MovieClip;
         if(param2.itemData)
         {
            this._shopItem = ShopItemManager.getShopItem(param2.itemData);
            this.name = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text") as TextField,this._shopItem.name);
            _loc5_ = this._shopItem.icon;
         }
         else
         {
            this.name = TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text") as TextField,param2.name);
            _loc5_ = param2.iconMovieClip;
         }
         DCUtils.replaceDisplayObject(this.iconContainer,_loc5_);
         if(param2.id == "MysteryGift")
         {
            _loc5_.gotoAndStop("Default");
         }
         this._gift = param2;
         this._game = param3;
         param1.addEventListener("mouseOver",this.mouseOver,false,0,true);
         param1.addEventListener("mouseOut",this.mouseOut,false,0,true);
      }
      
      public function get shopItem() : ShopItem
      {
         return this._shopItem;
      }
      
      public function get gift() : GiftReference
      {
         return this._gift;
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",this.mouseOver,false);
         this._design.removeEventListener("mouseOut",this.mouseOut,false);
         super.dispose();
         this._shopItem = null;
         this._gift = null;
         this._game = null;
         this.name = null;
         this.iconContainer = null;
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:TuxTooltip = null;
         var _loc3_:ShopItem = null;
         var _loc4_:* = false;
         if(this.gift.itemData)
         {
            _loc3_ = ShopItemManager.getShopItem(this.gift.itemData);
            if(_loc3_)
            {
               if(_loc3_.itemData.type == "Weapon")
               {
                  _loc2_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getWeaponTooltipGraphics(),this._game),this._design);
               }
               else if(_loc3_.itemData.type == "Clothing")
               {
                  _loc2_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getClothingTooltipGraphics(),this._game),this._design);
               }
               else
               {
                  _loc2_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getBoosterTooltipGraphics(),this._game),this._design);
               }
               _loc4_ = _loc2_.getX() > DCGame.getStage().width / 3;
               if(_loc4_)
               {
                  (_loc2_ as ItemBaseTooltip).content.containers.show((_loc2_.getY() > DCGame.getStage().height / 2 ? "Up" : "Down") + "Left",false);
               }
               _loc2_.setX(_loc2_.getX() + (_loc4_ ? 0 : this._design.width));
               _loc2_.setY(_loc2_.getY() + this._design.height / 2);
               ((_loc2_ as ItemBaseTooltip).content.containers.getCurrentContainer() as TooltipContainer).amountTextField.setText("");
            }
         }
         else
         {
            _loc2_ = TooltipManager.showTooltip(new ItemTooltip(this._gift.name,this._gift.description),this._design);
            _loc2_.setX(_loc2_.getX() + this._design.width * 0.5);
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function get game() : TuxWarsGame
      {
         return this._game;
      }
   }
}

