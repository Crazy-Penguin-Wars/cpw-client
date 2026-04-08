package tuxwars.ui.tooltips
{
   import com.dchoc.game.*;
   import com.dchoc.utils.*;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.*;
   import tuxwars.ui.containers.shop.Content;
   
   public class TooltipContent extends Content
   {
      public static const RIGHT:String = "Right";
      
      public static const LEFT:String = "Left";
      
      public static const UP:String = "Up";
      
      public static const DOWN:String = "Down";
      
      public function TooltipContent(param1:DisplayObject, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         super(param1,param2,param3,param4);
         DCUtils.setBitmapSmoothing(true,getDesignMovieClip());
         if(this.shopItem.type == "Clothing")
         {
            containers.add("Up" + "Left",new TooltipContainerClothing(getDesignMovieClip().Tooltip_04,[param2],param3,param4));
            containers.add("Up" + "Right",new TooltipContainerClothing(getDesignMovieClip().Tooltip_03,[param2],param3,param4));
            containers.add("Down" + "Left",new TooltipContainerClothing(getDesignMovieClip().Tooltip_02,[param2],param3,param4));
            containers.add("Down" + "Right",new TooltipContainerClothing(getDesignMovieClip().Tooltip_01,[param2],param3,param4));
         }
         else if(this.shopItem.type == "Weapon")
         {
            containers.add("Up" + "Left",new TooltipContainerWeapon(getDesignMovieClip().Tooltip_04,[param2],param3,param4));
            containers.add("Up" + "Right",new TooltipContainerWeapon(getDesignMovieClip().Tooltip_03,[param2],param3,param4));
            containers.add("Down" + "Left",new TooltipContainerWeapon(getDesignMovieClip().Tooltip_02,[param2],param3,param4));
            containers.add("Down" + "Right",new TooltipContainerWeapon(getDesignMovieClip().Tooltip_01,[param2],param3,param4));
         }
         else
         {
            containers.add("Up" + "Left",new TooltipContainer(getDesignMovieClip().Tooltip_04,[param2],param3,param4));
            containers.add("Up" + "Right",new TooltipContainer(getDesignMovieClip().Tooltip_03,[param2],param3,param4));
            containers.add("Down" + "Left",new TooltipContainer(getDesignMovieClip().Tooltip_02,[param2],param3,param4));
            containers.add("Down" + "Right",new TooltipContainer(getDesignMovieClip().Tooltip_01,[param2],param3,param4));
         }
      }
      
      public function checkTooltipLocation() : void
      {
         var _loc1_:int = int(DCGame.getStage().stageWidth);
         var _loc2_:int = int(DCGame.getStage().stageHeight);
         var _loc3_:flash.geom.Rectangle = getDesignMovieClip().getBounds(DCGame.getMainMovieClip());
         var _loc4_:String = _loc3_.right > _loc1_ - (this.shopItem.type == "Clothing" || this.shopItem.type == "Trophy" ? 100 : 0) ? "Left" : "Right";
         var _loc5_:String = _loc3_.bottom < DCGame.getStage().stageHeight ? (_loc3_.y < 180 ? "Down" : "Up") : "Up";
         containers.show(_loc5_ + _loc4_,false);
      }
      
      private function get shopItem() : ShopItem
      {
         return data as ShopItem;
      }
   }
}

