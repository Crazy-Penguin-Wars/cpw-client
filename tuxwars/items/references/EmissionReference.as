package tuxwars.items.references
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.*;
   import tuxwars.battle.data.follower.*;
   
   public class EmissionReference
   {
      private static var _table:Table;
      
      private static const TABLE:String = "Emitter";
      
      private static const SPECIAL_EFFECT:String = "SpecialEffect";
      
      private static const SPECIAL_TYPE:String = "SpecialType";
      
      private static const AFFECTED_OBJECTS:String = "AffectsObjects";
      
      private static const SOUND_ID:String = "SoundID";
      
      private static const FOLLOWERS:String = "Followers";
      
      private static const NUMBER:String = "Number";
      
      private static const DELAY:String = "Delay";
      
      private static const SPREAD:String = "Spread";
      
      private static const ANGLE_ONE:String = "AngleOne";
      
      private static const ANGLE_TWO:String = "AngleTwo";
      
      private static const USE_HIT_DIRECTION:String = "UseHitDirection";
      
      private static const DIRECTION_AND_OFFSET_BY:String = "DirectionAndOffsetBy";
      
      private static const RANDOM_OFFSET:String = "RandomOffset";
      
      private static const CACHE:Object = {};
      
      public var id:String;
      
      private var row:Row;
      
      private var _field_cache:Object;
      
      private var _followers:Array;
      
      public function EmissionReference()
      {
         super();
      }
      
      public static function find(param1:String) : EmissionReference
      {
         var _loc3_:Row = null;
         if(!EmissionReference.table)
         {
            EmissionReference.table = ProjectManager.findTable("Emitter");
         }
         var _loc2_:Table = EmissionReference.table;
         if(!_loc2_.getCache[param1])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",param1);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + param1 + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[param1] = _loc3_;
         }
         return get(_loc2_.getCache[param1]);
      }
      
      public static function get(param1:Row) : EmissionReference
      {
         var _loc2_:EmissionReference = null;
         assert("EmissionReference row is null",true,param1 != null);
         if(!CACHE.hasOwnProperty(param1.id))
         {
            _loc2_ = new EmissionReference();
            _loc2_.init(param1);
            CACHE[param1.id] = _loc2_;
         }
         return CACHE[param1.id];
      }
      
      private static function get table() : Table
      {
         var _loc1_:String = null;
         if(!_table)
         {
            _loc1_ = "Emitter";
            _table = ProjectManager.findTable(_loc1_);
         }
         return _table;
      }
      
      public static function getEmissionReferences(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_.push(EmissionReference.get(param1[_loc2_]));
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function init(param1:Row) : void
      {
         this._field_cache = {};
         this.row = param1;
         this.id = param1.id;
      }
      
      public function toString() : String
      {
         return "EmissionReference id: " + this.id + " table: " + this.tableName + " special type: " + this.specialType;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = this.row;
         var _loc2_:* = _loc1_.table;
         return _loc2_._name;
      }
      
      public function get specialEffect() : Row
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SpecialEffect";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         var _loc5_:* = !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) as Row : null;
         if(_loc5_ != null)
         {
            assert("SpecialEffect for emission: " + this.id + " is null",true,_loc5_ != null);
         }
         return _loc5_;
      }
      
      public function get specialType() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SpecialType";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         var _loc5_:* = !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
         if(_loc5_ != null)
         {
            assert("SpecialType for emission: " + this.id + " is null",true,_loc5_ != null);
         }
         return _loc5_;
      }
      
      public function get soundID() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SoundID";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(_loc3_)
         {
            _loc4_ = _loc3_;
            return _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
         }
         return this.id;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Followers";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, Followers.getFollowersData(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get affectedObjects() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "AffectsObjects";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(_loc3_)
         {
            _loc4_ = _loc3_;
            return _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
         }
         return ["all"];
      }
      
      public function get number() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Number");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 1;
      }
      
      public function get delay() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Delay");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get spread() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("Spread");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get angleOne() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("AngleOne");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get angleTwo() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("AngleTwo");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get useHitDirection() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("UseHitDirection");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : false;
      }
      
      private function get isRandomOffset() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("RandomOffset");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : false;
      }
      
      public function getDirectionAndOffsetBy(param1:Random) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Field = this.getField("DirectionAndOffsetBy");
         if(_loc2_)
         {
            _loc3_ = _loc2_.overrideValue != null ? _loc2_.overrideValue : int(_loc2_._value);
            if(_loc3_ != 0)
            {
               if(this.isRandomOffset)
               {
                  if(param1 == BattleManager.getRandom())
                  {
                     LogUtils.log("Call to random directionAndOffsetBy()",this,0,"Random",false,false,false);
                  }
                  return param1.integer(0,_loc3_);
               }
               return _loc3_;
            }
         }
         return 1;
      }
      
      private function getField(param1:String) : Field
      {
         var _loc2_:Row = null;
         if(!this._field_cache.hasOwnProperty(param1))
         {
            _loc2_ = this.row;
            if(!_loc2_.getCache[param1])
            {
               _loc2_.getCache[param1] = DCUtils.find(_loc2_.getFields(),"name",param1);
            }
            this._field_cache[param1] = _loc2_.getCache[param1];
         }
         return this._field_cache[param1];
      }
   }
}

