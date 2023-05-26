package tuxwars.ui.components
{
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.ItemBaseTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.ui.tooltips.TuxTooltip;
   
   public class IconToggleTooltipButton extends IconToggleButton
   {
      
      public static const GENERIC:String = "generic";
       
      
      private var _game:TuxWarsGame;
      
      private var _tooltipType:String;
      
      private var _tooltipParent:DisplayObject;
      
      private var _tooltipAlign:int;
      
      private var _tooltipTime:int;
      
      private var _tooltipObject:Object;
      
      public function IconToggleTooltipButton(design:MovieClip, game:TuxWarsGame, parameter:Object, showTooltip:Boolean = true, useDefaultSound:Boolean = true, sounds:Object = null, customSoundStatus:Boolean = false)
      {
         super(design,parameter,useDefaultSound,sounds,customSoundStatus);
         _game = game;
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
         _game = null;
         _tooltipParent = null;
         _tooltipObject = null;
         super.dispose();
      }
      
      public function get shopitem() : ShopItem
      {
         return getParameter() as ShopItem;
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         var tooltip:* = null;
         if(_tooltipParent)
         {
            if(_tooltipType == "generic")
            {
               tooltip = new GenericTooltip(_tooltipObject as String);
            }
            else
            {
               LogUtils.log("No recognized tooltip type",this,0,"Tooltips",false,false,false);
            }
            TooltipManager.showTooltip(tooltip,_tooltipParent,_tooltipAlign,_tooltipTime);
         }
         else if(shopitem)
         {
            if(shopitem.itemData.type == "Weapon")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(shopitem,TooltipsData.getWeaponTooltipGraphics(),_game),this._design);
            }
            else if(shopitem.itemData.type == "Clothing")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(shopitem,TooltipsData.getClothingTooltipGraphics(),_game),this._design);
            }
            else
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(shopitem,TooltipsData.getBoosterTooltipGraphics(),_game),this._design);
            }
         }
         else
         {
            LogUtils.log("No tooltip set, or incorrect parameter object",this,0,"Tooltips",false,false,false);
         }
      }
      
      public function setTooltip(parent:DisplayObject, tooltipObject:*, type:String = "generic", align:int = 1, setTime:int = 250) : void
      {
         _tooltipType = type;
         _tooltipParent = parent;
         _tooltipAlign = align;
         _tooltipTime = setTime;
         _tooltipObject = tooltipObject;
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
