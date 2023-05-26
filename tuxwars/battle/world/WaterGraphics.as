package tuxwars.battle.world
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import tuxwars.battle.data.LevelTheme;
   import tuxwars.battle.world.loader.Level;
   
   public class WaterGraphics extends Sprite
   {
      
      private static const TILE_WIDTH:int = 198;
      
      public static const TILE_HEIGHT:int = 106;
       
      
      public function WaterGraphics(level:Level)
      {
         super();
         tileWater(level);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function dispose() : void
      {
         DCUtils.disposeAllBitmapData(this);
      }
      
      private function tileWater(level:Level) : void
      {
         var curX:int = 0;
         while(curX < level.width)
         {
            addTile(curX,level.theme);
            curX += 198;
         }
         addTile(curX,level.theme);
         var _loc3_:int = level.height - level.waterLine;
         if(_loc3_ > 106)
         {
            graphics.beginFill(level.theme.waterColor);
            graphics.drawRect(0,106,level.width,_loc3_);
            graphics.endFill();
         }
      }
      
      private function addTile(x:int, theme:LevelTheme) : void
      {
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF(theme.waterSWF,theme.waterExport);
         if(_loc3_)
         {
            _loc3_.x = x;
            _loc3_.y = 106 * 0.7;
            addChild(_loc3_);
         }
         else
         {
            LogUtils.log("No water tile found: " + theme.waterExport + " from: " + theme.waterSWF,this,1,"Assets",false,false,false);
         }
      }
   }
}
