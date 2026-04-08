package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.follower.*;
   import tuxwars.battle.data.particles.*;
   import tuxwars.data.*;
   
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
      
      public function LevelTheme(param1:Row)
      {
         super();
         assert("Row is null.",true,param1 != null);
         this.row = param1;
         this.load();
      }
      
      public function dispose() : void
      {
         DCResourceManager.instance.unload("background_gradient");
      }
      
      public function getName() : String
      {
         return this.row.id;
      }
      
      public function getBackground() : MovieClip
      {
         return DCResourceManager.instance.getFromSWF(this.getBackgroundSWF(),"background_gradient");
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
      
      public function get waterSWF() : String
      {
         var _loc1_:String = "WaterSWF";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get waterExport() : String
      {
         var _loc1_:String = "WaterExport";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get waterColor() : uint
      {
         var _loc1_:String = "WaterColor";
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
         return uint(parseInt(_loc4_));
      }
      
      public function isLoaded() : Boolean
      {
         if(this.getBackgroundSWF())
         {
            return DCResourceManager.instance.isLoaded(this.getBackgroundSWF());
         }
         return false;
      }
      
      private function load() : void
      {
         this.loadSWF(this.getBackgroundSWF());
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
      
      private function getBackgroundSWF() : String
      {
         var _loc1_:String = "BackgroundSWF";
         if(!this.row.getCache[_loc1_])
         {
            this.row.getCache[_loc1_] = DCUtils.find(this.row.getFields(),"name",_loc1_);
         }
         var _loc2_:Field = this.row.getCache[_loc1_];
         return !!_loc2_ ? (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
      
      public function getLevelAmbienceSound() : SoundReference
      {
         return Sounds.getSoundReference(this.getName());
      }
      
      public function getWaterParticleData() : ThemeParticleData
      {
         var _loc1_:String = null;
         var _loc2_:Field = null;
         var _loc3_:* = undefined;
         if(!this._waterParticle)
         {
            _loc1_ = "WaterParticle";
            if(!this.row.getCache[_loc1_])
            {
               this.row.getCache[_loc1_] = DCUtils.find(this.row.getFields(),"name",_loc1_);
            }
            _loc2_ = this.row.getCache[_loc1_];
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
               this._waterParticle = new ThemeParticleData(_loc3_);
            }
            else
            {
               this._waterParticle = null;
            }
         }
         return this._waterParticle;
      }
      
      public function getRainParticleData() : ThemeParticleData
      {
         var _loc1_:String = null;
         var _loc2_:Field = null;
         var _loc3_:* = undefined;
         if(!this._rainParticle)
         {
            _loc1_ = "RainParticle";
            if(!this.row.getCache[_loc1_])
            {
               this.row.getCache[_loc1_] = DCUtils.find(this.row.getFields(),"name",_loc1_);
            }
            _loc2_ = this.row.getCache[_loc1_];
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
               this._rainParticle = new ThemeParticleData(_loc3_);
            }
            else
            {
               this._rainParticle = null;
            }
         }
         return this._rainParticle;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc1_:String = "WaterFollowers";
         if(this.row)
         {
            if(!this.row.getCache[_loc1_])
            {
               this.row.getCache[_loc1_] = DCUtils.find(this.row.getFields(),"name",_loc1_);
            }
         }
         var _loc2_:Field = !!this.row ? this.row.getCache[_loc1_] : null;
         var _loc3_:* = !!_loc2_ ? (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
         return Followers.getFollowersData(_loc3_);
      }
   }
}

