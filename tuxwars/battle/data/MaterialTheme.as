package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.BitmapData;
   import no.olog.utilfunctions.*;
   
   public class MaterialTheme
   {
      private static const LANDMASS_SWF:String = "LandmassSWF";
      
      private static const LANDMASS_TEXTURE:String = "landmass_bg_tile.png";
      
      private static const LANDMASS_LEFT_TILE:String = "landmass_end_left.png";
      
      private static const LANDMASS_RIGHT_TILE:String = "landmass_end_right.png";
      
      private static const LANDMASS_FILLER_TILE:String = "landmass_filler.png";
      
      private static const LANDMASS_TILE:String = "landmass_tile.png";
      
      private static const BORDER_COLOR:String = "BorderColor";
      
      private static const EXPLOSION_BORDER_COLOR:String = "ExplosionBorderColor";
      
      private static const ANGLE:String = "Angle";
      
      private static const CUSTOM_THEME_NAME:String = "CustomObjects";
      
      private var row:Row;
      
      public function MaterialTheme(param1:Row)
      {
         super();
         assert("Row is null.",true,param1 != null);
         this.row = param1;
         this.load();
      }
      
      public function dispose() : void
      {
         DCResourceManager.instance.unload("landmass_bg_tile.png");
         DCResourceManager.instance.unload("landmass_end_left.png");
         DCResourceManager.instance.unload("landmass_end_right.png");
         DCResourceManager.instance.unload("landmass_filler.png");
         DCResourceManager.instance.unload("landmass_tile.png");
      }
      
      public function getName() : String
      {
         return this.row.id;
      }
      
      public function isCustomTheme() : Boolean
      {
         return this.row.id == "CustomObjects";
      }
      
      public function getLandmassTexture() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(this.getLandmassSWF(),"landmass_bg_tile.png","BitmapData");
      }
      
      public function getLandmassLeftTile() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(this.getLandmassSWF(),"landmass_end_left.png","BitmapData");
      }
      
      public function getLandmassRightTile() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(this.getLandmassSWF(),"landmass_end_right.png","BitmapData");
      }
      
      public function getLandmassFillerTile() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(this.getLandmassSWF(),"landmass_filler.png","BitmapData");
      }
      
      public function getLandmassTile() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(this.getLandmassSWF(),"landmass_tile.png","BitmapData");
      }
      
      public function getBorderColor() : uint
      {
         var _loc1_:String = "BorderColor";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(!_loc3_)
         {
            return 0;
         }
         var _loc4_:* = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         return uint(parseInt(String(_loc4_)));
      }
      
      public function getExplosionBorderColor() : uint
      {
         var _loc1_:String = "ExplosionBorderColor";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(!_loc3_)
         {
            return 0;
         }
         var _loc4_:* = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         return uint(parseInt(String(_loc4_)));
      }
      
      public function getAngle() : int
      {
         var _loc1_:String = "Angle";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public function isLoaded() : Boolean
      {
         return DCResourceManager.instance.isLoaded(this.getLandmassSWF());
      }
      
      private function load() : void
      {
         this.loadSWF(this.getLandmassSWF());
      }
      
      private function loadSWF(param1:String) : void
      {
         if(param1)
         {
            if(!DCResourceManager.instance.isLoaded(param1))
            {
               DCResourceManager.instance.load(Config.getDataDir() + param1,param1,null,true);
            }
         }
      }
      
      private function getLandmassSWF() : String
      {
         var _loc1_:String = "LandmassSWF";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
   }
}

