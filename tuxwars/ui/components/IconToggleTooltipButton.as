package tuxwars.ui.components
{
   import com.dchoc.utils.*;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.items.*;
   import tuxwars.ui.tooltips.*;
   
   public class IconToggleTooltipButton extends IconToggleButton
   {
      public static const GENERIC:String = "generic";
      
      private var _game:TuxWarsGame;
      
      private var _tooltipType:String;
      
      private var _tooltipParent:DisplayObject;
      
      private var _tooltipAlign:int;
      
      private var _tooltipTime:int;
      
      private var _tooltipObject:Object;
      
      public function IconToggleTooltipButton(param1:MovieClip, param2:TuxWarsGame, param3:Object, param4:Boolean = true, param5:Boolean = true, param6:Object = null, param7:Boolean = false)
      {
         super(param1,param3,param5,param6,param7);
         this._game = param2;
         if(param4)
         {
            param1.addEventListener("mouseOver",this.mouseOver,false,0,true);
            param1.addEventListener("mouseOut",this.mouseOut,false,0,true);
         }
      }
      
      override public function dispose() : void
      {
         this._design.removeEventListener("mouseOver",this.mouseOver,false);
         this._design.removeEventListener("mouseOut",this.mouseOut,false);
         this._game = null;
         this._tooltipParent = null;
         this._tooltipObject = null;
         super.dispose();
      }
      
      public function get shopitem() : ShopItem
      {
         return getParameter() as ShopItem;
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:TuxTooltip = null;
         if(this._tooltipParent)
         {
            if(this._tooltipType == "generic")
            {
               _loc2_ = new GenericTooltip(this._tooltipObject as String);
            }
            else
            {
               LogUtils.log("No recognized tooltip type",this,0,"Tooltips",false,false,false);
            }
            TooltipManager.showTooltip(_loc2_,this._tooltipParent,this._tooltipAlign,this._tooltipTime);
         }
         else if(this.shopitem)
         {
            if(this.shopitem.itemData.type == "Weapon")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(this.shopitem,TooltipsData.getWeaponTooltipGraphics(),this._game),this._design);
            }
            else if(this.shopitem.itemData.type == "Clothing")
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(this.shopitem,TooltipsData.getClothingTooltipGraphics(),this._game),this._design);
            }
            else
            {
               TooltipManager.showTooltip(new ItemBaseTooltip(this.shopitem,TooltipsData.getBoosterTooltipGraphics(),this._game),this._design);
            }
         }
         else
         {
            LogUtils.log("No tooltip set, or incorrect parameter object",this,0,"Tooltips",false,false,false);
         }
      }
      
      public function setTooltip(param1:DisplayObject, param2:*, param3:String = "generic", param4:int = 1, param5:int = 250) : void
      {
         this._tooltipType = param3;
         this._tooltipParent = param1;
         this._tooltipAlign = param4;
         this._tooltipTime = param5;
         this._tooltipObject = param2;
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

