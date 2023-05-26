package tuxwars.battle.data
{
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.BitmapData;
   import no.olog.utilfunctions.assert;
   
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
      
      public function MaterialTheme(row:Row)
      {
         super();
         assert("Row is null.",true,row != null);
         this.row = row;
         load();
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
         return row.id;
      }
      
      public function isCustomTheme() : Boolean
      {
         return row.id == "CustomObjects";
      }
      
      public function getLandmassTexture() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(getLandmassSWF(),"landmass_bg_tile.png","BitmapData");
      }
      
      public function getLandmassLeftTile() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(getLandmassSWF(),"landmass_end_left.png","BitmapData");
      }
      
      public function getLandmassRightTile() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(getLandmassSWF(),"landmass_end_right.png","BitmapData");
      }
      
      public function getLandmassFillerTile() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(getLandmassSWF(),"landmass_filler.png","BitmapData");
      }
      
      public function getLandmassTile() : BitmapData
      {
         return DCResourceManager.instance.getFromSWF(getLandmassSWF(),"landmass_tile.png","BitmapData");
      }
      
      public function getBorderColor() : uint
      {
         var _loc1_:Row = row;
         §§push(parseInt);
         §§push(global);
         if(!_loc1_._cache["BorderColor"])
         {
            _loc1_._cache["BorderColor"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","BorderColor");
         }
         var _loc2_:* = _loc1_._cache["BorderColor"];
         return §§pop()(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public function getExplosionBorderColor() : uint
      {
         var _loc1_:Row = row;
         §§push(parseInt);
         §§push(global);
         if(!_loc1_._cache["ExplosionBorderColor"])
         {
            _loc1_._cache["ExplosionBorderColor"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","ExplosionBorderColor");
         }
         var _loc2_:* = _loc1_._cache["ExplosionBorderColor"];
         return §§pop()(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public function getAngle() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["Angle"])
         {
            _loc1_._cache["Angle"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Angle");
         }
         var _loc2_:* = _loc1_._cache["Angle"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function isLoaded() : Boolean
      {
         return DCResourceManager.instance.isLoaded(getLandmassSWF());
      }
      
      private function load() : void
      {
         loadSWF(getLandmassSWF());
      }
      
      private function loadSWF(swf:String) : void
      {
         if(swf)
         {
            if(!DCResourceManager.instance.isLoaded(swf))
            {
               DCResourceManager.instance.load(Config.getDataDir() + swf,swf,null,true);
            }
         }
      }
      
      private function getLandmassSWF() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["LandmassSWF"])
         {
            _loc1_._cache["LandmassSWF"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","LandmassSWF");
         }
         var _loc2_:* = _loc1_._cache["LandmassSWF"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
   }
}
