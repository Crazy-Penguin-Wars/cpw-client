package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
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
         var _loc3_:String = "Angle";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get waterSWF() : String
      {
         var _loc3_:String = "WaterSWF";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get waterExport() : String
      {
         var _loc3_:String = "WaterExport";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get waterColor() : uint
      {
         var _loc3_:String = "WaterColor";
         var _loc1_:Row = row;
         §§push(parseInt);
         §§push(global);
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
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
         var _loc4_:String = "BackgroundSWF";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc4_])
         {
            _loc1_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc4_);
         }
         if(_loc1_._cache[_loc4_])
         {
            var _loc5_:String = "BackgroundSWF";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc5_])
            {
               _loc2_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc5_);
            }
            var _loc3_:* = _loc2_._cache[_loc5_];
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
         var _loc1_:Field = null;
         if(!_waterParticle)
         {
            var _loc5_:String = "WaterParticle";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc5_])
            {
               _loc2_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc5_);
            }
            _loc1_ = _loc2_._cache[_loc5_];
            if(_loc1_ != null)
            {
               var _loc6_:String = "WaterParticle";
               var _loc3_:Row = row;
               §§push(§§findproperty(ThemeParticleData));
               if(!_loc3_._cache[_loc6_])
               {
                  _loc3_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc6_);
               }
               var _loc4_:* = _loc3_._cache[_loc6_];
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
         var _loc1_:Field = null;
         if(!_rainParticle)
         {
            var _loc5_:String = "RainParticle";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc5_])
            {
               _loc2_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc5_);
            }
            _loc1_ = _loc2_._cache[_loc5_];
            if(_loc1_ != null)
            {
               var _loc6_:String = "RainParticle";
               var _loc3_:Row = row;
               §§push(§§findproperty(ThemeParticleData));
               if(!_loc3_._cache[_loc6_])
               {
                  _loc3_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc6_);
               }
               var _loc4_:* = _loc3_._cache[_loc6_];
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
            var _loc4_:String = "WaterFollowers";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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

