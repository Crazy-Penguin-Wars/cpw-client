package tuxwars.battle.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.follower.Followers;
   import tuxwars.battle.data.particles.ThemeParticleData;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
   public class LevelTheme
   {
      
      private static const BACKGROUND_SWF:String = "BackgroundSWF";
      
      private static const BACKGROUND_EXPORT:String = "background_gradient";
      
      private static const ANGLE:String = "Angle";
      
      private static const WATER_SWF:String = "WaterSWF";
      
      private static const WATER_EXPORT:String = "WaterExport";
      
      private static const WATER_COLOR:String = "WaterColor";
      
      private static const WATER_PARTICLE:String = "WaterParticle";
      
      private static const RAIN_PARTICLE:String = "RainParticle";
      
      private static const FOLLOWERS:String = "WaterFollowers";
       
      
      private var row:Row;
      
      private var _waterParticle:ThemeParticleData;
      
      private var _rainParticle:ThemeParticleData;
      
      public function LevelTheme(row:Row)
      {
         super();
         assert("Row is null.",true,row != null);
         this.row = row;
         load();
      }
      
      public function dispose() : void
      {
         DCResourceManager.instance.unload("background_gradient");
      }
      
      public function getName() : String
      {
         return row.id;
      }
      
      public function getBackground() : MovieClip
      {
         return DCResourceManager.instance.getFromSWF(getBackgroundSWF(),"background_gradient");
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
      
      public function get waterSWF() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["WaterSWF"])
         {
            _loc1_._cache["WaterSWF"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","WaterSWF");
         }
         var _loc2_:* = _loc1_._cache["WaterSWF"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get waterExport() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["WaterExport"])
         {
            _loc1_._cache["WaterExport"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","WaterExport");
         }
         var _loc2_:* = _loc1_._cache["WaterExport"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get waterColor() : uint
      {
         var _loc1_:Row = row;
         §§push(parseInt);
         §§push(global);
         if(!_loc1_._cache["WaterColor"])
         {
            _loc1_._cache["WaterColor"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","WaterColor");
         }
         var _loc2_:* = _loc1_._cache["WaterColor"];
         return §§pop()(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value);
      }
      
      public function isLoaded() : Boolean
      {
         if(getBackgroundSWF())
         {
            return DCResourceManager.instance.isLoaded(getBackgroundSWF());
         }
         return false;
      }
      
      private function load() : void
      {
         loadSWF(getBackgroundSWF());
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
      
      private function getBackgroundSWF() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["BackgroundSWF"])
         {
            _loc1_._cache["BackgroundSWF"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","BackgroundSWF");
         }
         if(_loc1_._cache["BackgroundSWF"])
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["BackgroundSWF"])
            {
               _loc2_._cache["BackgroundSWF"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","BackgroundSWF");
            }
            var _loc3_:* = _loc2_._cache["BackgroundSWF"];
            return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         }
         return null;
      }
      
      public function getLevelAmbienceSound() : SoundReference
      {
         return Sounds.getSoundReference(getName());
      }
      
      public function getWaterParticleData() : ThemeParticleData
      {
         var _loc1_:* = null;
         if(!_waterParticle)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["WaterParticle"])
            {
               _loc2_._cache["WaterParticle"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","WaterParticle");
            }
            _loc1_ = _loc2_._cache["WaterParticle"];
            if(_loc1_ != null)
            {
               var _loc3_:Row = row;
               §§push(§§findproperty(ThemeParticleData));
               if(!_loc3_._cache["WaterParticle"])
               {
                  _loc3_._cache["WaterParticle"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","WaterParticle");
               }
               var _loc4_:* = _loc3_._cache["WaterParticle"];
               _waterParticle = new §§pop().ThemeParticleData(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
            }
            else
            {
               _waterParticle = null;
            }
         }
         return _waterParticle;
      }
      
      public function getRainParticleData() : ThemeParticleData
      {
         var _loc1_:* = null;
         if(!_rainParticle)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["RainParticle"])
            {
               _loc2_._cache["RainParticle"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RainParticle");
            }
            _loc1_ = _loc2_._cache["RainParticle"];
            if(_loc1_ != null)
            {
               var _loc3_:Row = row;
               §§push(§§findproperty(ThemeParticleData));
               if(!_loc3_._cache["RainParticle"])
               {
                  _loc3_._cache["RainParticle"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","RainParticle");
               }
               var _loc4_:* = _loc3_._cache["RainParticle"];
               _rainParticle = new §§pop().ThemeParticleData(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
            }
            else
            {
               _rainParticle = null;
            }
         }
         return _rainParticle;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         if(row)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["WaterFollowers"])
            {
               _loc2_._cache["WaterFollowers"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","WaterFollowers");
            }
            §§push(_loc2_._cache["WaterFollowers"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return Followers.getFollowersData(!!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null);
      }
   }
}
