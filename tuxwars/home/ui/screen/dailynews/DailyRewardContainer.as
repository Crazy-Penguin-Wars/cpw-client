package tuxwars.home.ui.screen.dailynews
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.ItemTooltip;
   import tuxwars.ui.tooltips.TooltipContainer;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class DailyRewardContainer extends UIContainer
   {
       
      
      private var _design:MovieClip;
      
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
      
      public function DailyRewardContainer(design:MovieClip, dailyRewardContainers:DailyRewardContainers, dayNumber:int, text:String, textValue:String, textMessage:String, icon:String, game:TuxWarsGame)
      {
         super(design,parent);
         _design = design;
         _dayNumber = dayNumber;
         _text = text;
         _textValue = textValue;
         _textMessage = textMessage;
         _game = game;
         TuxUiUtils.createAutoTextFieldWithText((design as MovieClip).getChildByName("Text") as TextField,_text);
         TuxUiUtils.createAutoTextFieldWithText((design as MovieClip).getChildByName("Text_Value") as TextField,_textValue);
         TuxUiUtils.createAutoTextFieldWithText((design as MovieClip).getChildByName("Text_Message") as TextField,_textMessage);
         design.addEventListener("mouseOver",mouseOver,false,0,true);
         design.addEventListener("mouseOut",mouseOut,false,0,true);
         if(icon != "xp" && icon != "coin" && icon != "cash")
         {
            _iconData = ItemManager.getItemData(icon);
            setItem(_iconData.icon);
            _itemName = _iconData.name;
            _itemDescription = _iconData.description;
         }
         else
         {
            if(icon == "cash")
            {
               _iconDataNotItem = "slot_icon_cash";
               _itemName = ProjectManager.getText("CASH_TITLE_DAILY");
               _itemDescription = ProjectManager.getText("CASH_DESCRIPTION_DAILY");
            }
            else if(icon == "coin")
            {
               _iconDataNotItem = "slot_icon_coin";
               _itemName = ProjectManager.getText("COINS_TITLE");
               _itemDescription = ProjectManager.getText("COINS_DESCRIPTION");
            }
            else if(icon == "xp")
            {
               _iconDataNotItem = "slot_icon_exp";
               _itemName = ProjectManager.getText("XP_TITLE");
               _itemDescription = ProjectManager.getText("XP_DESCRIPTION");
            }
            _icon = getIcon(_iconDataNotItem);
            (_design.getChildByName("Container_Icon") as MovieClip).addChild(_icon);
         }
      }
      
      public function get dayNumber() : int
      {
         return _dayNumber;
      }
      
      public function setItem(value:MovieClip) : void
      {
         var mc:MovieClip = getDesignMovieClip().getChildByName("Container_Icon") as MovieClip;
         if(_icon != null && mc.contains(_icon))
         {
            mc.removeChild(_icon);
         }
         _icon = value;
         mc.addChild(_icon);
      }
      
      private function getIcon(picture:String) : MovieClip
      {
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/daily_news.swf",picture);
         _loc2_.name = picture;
         return _loc2_;
      }
      
      public function playIconAnim() : void
      {
         var index:int = DCUtils.indexOfLabel(_design,"Stop");
         _design.addFrameScript(index,stopIconAnim);
         _design.gotoAndPlay("Win");
      }
      
      public function stopIconAnim() : void
      {
         var _loc1_:int = DCUtils.indexOfLabel(_design,"Default");
         _design.addFrameScript(_loc1_,null);
         _design.gotoAndStop("Default");
      }
      
      override public function dispose() : void
      {
         _design = null;
         _icon = null;
         this._design.removeEventListener("mouseOver",mouseOver,false);
         this._design.removeEventListener("mouseOut",mouseOut,false);
         TooltipManager.removeTooltip();
         _game = null;
         super.dispose();
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         var _loc3_:* = null;
         var tt:* = null;
         if(_iconData)
         {
            _loc3_ = ShopItemManager.getShopItem(_iconData);
            if(_loc3_)
            {
               if(_loc3_.itemData.type == "Weapon")
               {
                  tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getWeaponTooltipGraphics(),_game),this._design) as ItemBaseTooltip;
               }
               else if(_loc3_.itemData.type == "Clothing")
               {
                  tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getClothingTooltipGraphics(),_game),this._design) as ItemBaseTooltip;
               }
               else
               {
                  tt = TooltipManager.showTooltip(new ItemBaseTooltip(_loc3_,TooltipsData.getBoosterTooltipGraphics(),_game),this._design) as ItemBaseTooltip;
               }
               (tt.content.containers.getCurrentContainer() as TooltipContainer).amountTextField.setText("x" + _textValue);
            }
         }
         else if(_itemName != null && _itemDescription != null)
         {
            TooltipManager.showTooltip(new ItemTooltip(_itemName,_itemDescription),this._design);
         }
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
      
      public function get graphicsReference() : GraphicsReference
      {
         return _graphicsReference;
      }
   }
}
