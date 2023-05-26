package tuxwars.ui.tooltips
{
   import com.dchoc.game.DCGame;
   import com.dchoc.utils.DCUtils;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.containers.shop.Content;
   
   public class TooltipContent extends Content
   {
      
      public static const RIGHT:String = "Right";
      
      public static const LEFT:String = "Left";
      
      public static const UP:String = "Up";
      
      public static const DOWN:String = "Down";
       
      
      public function TooltipContent(design:DisplayObject, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         super(design,data,game,parent);
         DCUtils.setBitmapSmoothing(true,getDesignMovieClip());
         if(shopItem.type == "Clothing")
         {
            containers.add("Up" + "Left",new TooltipContainerClothing(getDesignMovieClip().Tooltip_04,[data],game,parent));
            containers.add("Up" + "Right",new TooltipContainerClothing(getDesignMovieClip().Tooltip_03,[data],game,parent));
            containers.add("Down" + "Left",new TooltipContainerClothing(getDesignMovieClip().Tooltip_02,[data],game,parent));
            containers.add("Down" + "Right",new TooltipContainerClothing(getDesignMovieClip().Tooltip_01,[data],game,parent));
         }
         else if(shopItem.type == "Weapon")
         {
            containers.add("Up" + "Left",new TooltipContainerWeapon(getDesignMovieClip().Tooltip_04,[data],game,parent));
            containers.add("Up" + "Right",new TooltipContainerWeapon(getDesignMovieClip().Tooltip_03,[data],game,parent));
            containers.add("Down" + "Left",new TooltipContainerWeapon(getDesignMovieClip().Tooltip_02,[data],game,parent));
            containers.add("Down" + "Right",new TooltipContainerWeapon(getDesignMovieClip().Tooltip_01,[data],game,parent));
         }
         else
         {
            containers.add("Up" + "Left",new TooltipContainer(getDesignMovieClip().Tooltip_04,[data],game,parent));
            containers.add("Up" + "Right",new TooltipContainer(getDesignMovieClip().Tooltip_03,[data],game,parent));
            containers.add("Down" + "Left",new TooltipContainer(getDesignMovieClip().Tooltip_02,[data],game,parent));
            containers.add("Down" + "Right",new TooltipContainer(getDesignMovieClip().Tooltip_01,[data],game,parent));
         }
      }
      
      public function checkTooltipLocation() : void
      {
         var _loc6_:DCGame = DCGame;
         var _loc4_:int = int(com.dchoc.game.DCGame._stage.stageWidth);
         var _loc7_:DCGame = DCGame;
         var _loc2_:int = int(com.dchoc.game.DCGame._stage.stageHeight);
         var _loc1_:Rectangle = getDesignMovieClip().getBounds(DCGame.getMainMovieClip());
         var _loc5_:String = _loc1_.right > _loc4_ - (shopItem.type == "Clothing" || shopItem.type == "Trophy" ? 100 : 0) ? "Left" : "Right";
         var _loc8_:DCGame = DCGame;
         var _loc3_:String = _loc1_.bottom < com.dchoc.game.DCGame._stage.stageHeight ? (_loc1_.y < 180 ? "Down" : "Up") : "Up";
         containers.show(_loc3_ + _loc5_,false);
      }
      
      private function get shopItem() : ShopItem
      {
         return data as ShopItem;
      }
   }
}
