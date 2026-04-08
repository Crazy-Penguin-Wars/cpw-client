package tuxwars.battle.world.loader
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import flash.events.TimerEvent;
   import nape.geom.*;
   import tuxwars.battle.data.levelobjects.LevelObjectData;
   import tuxwars.battle.world.*;
   
   public class PowerUpObjectPhysics
   {
      private static const POWER_UPtable_NAME:String = "PowerUp";
      
      private static const FIELD_NAME_PHYSICS:String = "Physics";
      
      private static const FIELD_NAME_GRAPHICS:String = "Graphics";
      
      private static const FIELD_NAME_PARTICLE_EFFECT_SPAWN:String = "ParticleEffectSpawn";
      
      private static const FIELD_NAME_PARTICLE_EFFECT_USE:String = "ParticleEffectUse";
      
      private static const FIELD_NAME_ONLY_IN_THEMES:String = "OnlyInThemes";
      
      private static const FIELD_NAME_RESULT:String = "Result";
      
      private var name:String;
      
      private var row:Row;
      
      private var fixtureName:String;
      
      private var _id:String;
      
      private var levelObjectData:LevelObjectData;
      
      private var bodyManager:DynamicBodyManager;
      
      private var location:Vec2;
      
      protected var _graphics:GraphicsReference;
      
      protected var effectGraphics:GraphicsReference;
      
      private var angle:Number;
      
      public function PowerUpObjectPhysics(param1:Object)
      {
         var _loc5_:Row = null;
         super();
         this.name = param1.export_name;
         this.fixtureName = param1.export_name;
         this._id = param1.id.toString();
         this.location = new Vec2(param1.x,param1.y);
         this.angle = !!param1.angle ? Number(param1.angle) : 0;
         var _loc2_:String = "PowerUp";
         var _loc3_:String = this.name;
         var _loc4_:* = ProjectManager.findTable(_loc2_);
         if(!_loc4_.getCache[_loc3_])
         {
            _loc5_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc5_;
         }
         this.row = _loc4_.getCache[_loc3_];
         DynamicBodyManagerFactory.getInstance().createManager(this.getPhysicsFile(),this.managerCreated);
      }
      
      public function dispose() : void
      {
         this.row = null;
         this.bodyManager = null;
         this.levelObjectData = null;
         this._graphics = null;
         this.effectGraphics = null;
      }
      
      public function getLocation() : Vec2
      {
         return this.location;
      }
      
      public function setLocation(param1:Number, param2:Number) : void
      {
         this.location = new Vec2(param1,param2);
      }
      
      public function isLoaded() : Boolean
      {
         return this.bodyManager != null;
      }
      
      public function getPhysicsFile() : String
      {
         var _loc1_:String = "Physics";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function getOnlyInThemes() : Vector.<String>
      {
         var _loc5_:* = undefined;
         var _loc6_:Array = null;
         var _loc7_:Row = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         var _loc2_:String = "OnlyInThemes";
         var _loc3_:Row = this.row;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            _loc5_ = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
            _loc6_ = _loc5_ is Array ? _loc5_ as Array : [_loc5_];
            for each(_loc7_ in _loc6_)
            {
               _loc1_.push(_loc7_.id);
            }
         }
         return _loc1_;
      }
      
      public function getResultRow() : Row
      {
         var _loc1_:String = "Result";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get graphics() : GraphicsReference
      {
         var _loc1_:String = null;
         var _loc2_:Row = null;
         var _loc3_:Field = null;
         if(!this._graphics)
         {
            _loc1_ = "Graphics";
            _loc2_ = this.row;
            if(!_loc2_.getCache[_loc1_])
            {
               _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
            }
            _loc3_ = _loc2_.getCache[_loc1_];
            this._graphics = !!_loc3_ ? new GraphicsReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
         }
         return this._graphics;
      }
      
      public function getSpawnEffect() : String
      {
         var _loc3_:String = null;
         var _loc4_:Row = null;
         var _loc5_:* = undefined;
         var _loc1_:String = "ParticleEffectSpawn";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         if(_loc2_.getCache[_loc1_])
         {
            _loc3_ = "ParticleEffectSpawn";
            _loc4_ = this.row;
            if(!_loc4_.getCache[_loc3_])
            {
               _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
            }
            _loc5_ = _loc4_.getCache[_loc3_];
            return _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
         }
         return null;
      }
      
      public function getUseEffect() : String
      {
         var _loc3_:String = null;
         var _loc4_:Row = null;
         var _loc5_:* = undefined;
         var _loc1_:String = "ParticleEffectUse";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         if(_loc2_.getCache[_loc1_])
         {
            _loc3_ = "ParticleEffectUse";
            _loc4_ = this.row;
            if(!_loc4_.getCache[_loc3_])
            {
               _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
            }
            _loc5_ = _loc4_.getCache[_loc3_];
            return _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
         }
         return null;
      }
      
      public function getBodyManager() : DynamicBodyManager
      {
         return this.bodyManager;
      }
      
      public function getName() : String
      {
         return this.name;
      }
      
      public function getFixtureName() : String
      {
         return this.fixtureName;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function getAngle() : Number
      {
         return this.angle;
      }
      
      private function managerCreated(param1:TimerEvent) : void
      {
         this.bodyManager = DynamicBodyManagerFactory.getInstance().getManager(param1.type);
      }
   }
}

