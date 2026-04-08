package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class DailyRewardContainer extends UIContainer
   {
      private var __design:MovieClip;
      
      private var _dayNumber:int;
      
      private var _graphicsReference:GraphicsReference;
      
      private var _icon:MovieClip;
      
      private var _iconDataNotItem:String;
      
      private var _itemName:String;
      
      private var _itemDescription:String;
      
      private var _iconData:ItemData;
      
      private var _text:String;
      
      private var _textValue:String;
      
      private var _textMessage:String;
      
      private var _textField:UIAutoTextField;
      
      private var _textValueField:UIAutoTextField;
      
      private var _textMessageField:UIAutoTextField;
      
      private var _game:TuxWarsGame;
      
      public function DailyRewardContainer(param1:MovieClip, param2:DailyRewardContainers, param3:int, param4:String, param5:String, param6:String, param7:String, param8:TuxWarsGame)
      {
         super(param1,parent);
         this.__design = param1;
         this._dayNumber = param3;
         this._text = param4;
         this._textValue = param5;
         this._textMessage = param6;
         this._game = param8;
         TuxUiUtils.createAutoTextFieldWithText((param1 as MovieClip).getChildByName("Text") as TextField,this._text);
         TuxUiUtils.createAutoTextFieldWithText((param1 as MovieClip).getChildByName("Text_Value") as TextField,this._textValue);
         TuxUiUtils.createAutoTextFieldWithText((param1 as MovieClip).getChildByName("Text_Message") as TextField,this._textMessage);
         param1.addEventListener("mouseOver",this.mouseOver,false,0,true);
         param1.addEventListener("mouseOut",this.mouseOut,false,0,true);
         if(param7 != "xp" && param7 != "coin" && param7 != "cash")
         {
            this._iconData = ItemManager.getItemData(param7);
            this.setItem(this._iconData.icon);
            this._itemName = this._iconData.name;
            this._itemDescription = this._iconData.description;
         }
         else
         {
            if(param7 == "cash")
            {
               this._iconDataNotItem = "slot_icon_cash";
               this._itemName = ProjectManager.getText("CASH_TITLE_DAILY");
               this._itemDescription = ProjectManager.getText("CASH_DESCRIPTION_DAILY");
            }
            else if(param7 == "coin")
            {
               this._iconDataNotItem = "slot_icon_coin";
               this._itemName = ProjectManager.getText("COINS_TITLE");
               this._itemDescription = ProjectManager.getText("COINS_DESCRIPTION");
            }
            else if(param7 == "xp")
            {
               this._iconDataNotItem = "slot_icon_exp";
               this._itemName = ProjectManager.getText("XP_TITLE");
               this._itemDescription = ProjectManager.getText("XP_DESCRIPTION");
            }
            this._icon = this.getIcon(this._iconDataNotItem);
            (this.__design.getChildByName("Container_Icon") as MovieClip).addChild(this._icon);
         }
      }
      
      public function get dayNumber() : int
      {
         return this._dayNumber;
      }
      
      public function setItem(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = getDesignMovieClip().getChildByName("Container_Icon") as MovieClip;
         if(this._icon != null && _loc2_.contains(this._icon))
         {
            _loc2_.removeChild(this._icon);
         }
         this._icon = param1;
         _loc2_.addChild(this._icon);
      }
      
      private function getIcon(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/daily_news.swf",param1);
         _loc2_.name = param1;
         return _loc2_;
      }
      
      public function playIconAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this.__design,"Stop"));
         this.__design.addFrameScript(_loc1_,this.stopIconAnim);
         this.__design.gotoAndPlay("Win");
      }
      
      public function stopIconAnim() : void
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this.__design,"Default"));
         this.__design.addFrameScript(_loc1_,null);
         this.__design.gotoAndStop("Default");
      }
      
      override public function dispose() : void
      {
         this.__design = null;
         this._icon = null;
         this._design.removeEventListener("mouseOver",this.mouseOver,false);
         this._design.removeEventListener("mouseOut",this.mouseOut,false);
         TooltipManager.removeTooltip();
         this._game = null;
         super.dispose();
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ShopItem = null;
         var _loc3_:ItemBaseTooltip = null;
         if(this._iconData)
         {
            _loc2_ = ShopItemManager.getShopItem(this._iconData);
            if(_loc2_)
            {
               if(_loc2_.itemData.type == "Weapon")
               {
                  _loc3_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getWeaponTooltipGraphics(),this._game),this._design) as ItemBaseTooltip;
               }
               else if(_loc2_.itemData.type == "Clothing")
               {
                  _loc3_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getClothingTooltipGraphics(),this._game),this._design) as ItemBaseTooltip;
               }
               else
               {
                  _loc3_ = TooltipManager.showTooltip(new ItemBaseTooltip(_loc2_,TooltipsData.getBoosterTooltipGraphics(),this._game),this._design) as ItemBaseTooltip;
               }
               (_loc3_.content.containers.getCurrentContainer() as TooltipContainer).amountTextField.setText("x" + this._textValue);
            }
         }
         else if(this._itemName != null && this._itemDescription != null)
         {
            TooltipManager.showTooltip(new ItemTooltip(this._itemName,this._itemDescription),this._design);
         }
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function get graphicsReference() : GraphicsReference
      {
         return this._graphicsReference;
      }
   }
}

