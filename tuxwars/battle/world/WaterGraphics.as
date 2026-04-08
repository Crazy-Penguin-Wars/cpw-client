package tuxwars.battle.world
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import tuxwars.battle.data.LevelTheme;
   import tuxwars.battle.world.loader.Level;
   
   public class WaterGraphics extends Sprite
   {
      private static const TILE_WIDTH:int = 198;
      
      public static const TILE_HEIGHT:int = 106;
      
      public function WaterGraphics(param1:Level)
      {
         super();
         this.tileWater(param1);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function dispose() : void
      {
         DCUtils.disposeAllBitmapData(this);
      }
      
      private function tileWater(param1:Level) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.width)
         {
            this.addTile(_loc2_,param1.theme);
            _loc2_ += 198;
         }
         this.addTile(_loc2_,param1.theme);
         var _loc3_:int = param1.height - param1.waterLine;
         if(_loc3_ > 106)
         {
            graphics.beginFill(param1.theme.waterColor);
            graphics.drawRect(0,106,param1.width,_loc3_);
            graphics.endFill();
         }
      }
      
      private function addTile(param1:int, param2:LevelTheme) : void
      {
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF(param2.waterSWF,param2.waterExport);
         if(_loc3_)
         {
            _loc3_.x = param1;
            _loc3_.y = 106 * 0.7;
            addChild(_loc3_);
         }
         else
         {
            LogUtils.log("No water tile found: " + param2.waterExport + " from: " + param2.waterSWF,this,1,"Assets",false,false,false);
         }
      }
   }
}

