package tuxwars.items.references
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.Random;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.follower.Followers;
   
   public class EmissionReference
   {
      
      private static const CACHE:Object = {};
      
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
      
      private static var _table:Table;
       
      
      public var id:String;
      
      private var row:Row;
      
      private var _field_cache:Object;
      
      private var _followers:Array;
      
      public function EmissionReference()
      {
         super();
      }
      
      public static function find(id:String) : EmissionReference
      {
         §§push(§§findproperty(get));
         if(!tuxwars.items.references.EmissionReference._table)
         {
            tuxwars.items.references.EmissionReference._table = com.dchoc.projectdata.ProjectManager.findTable("Emitter");
         }
         var _loc3_:* = id;
         var _loc2_:* = tuxwars.items.references.EmissionReference._table;
         if(!_loc2_._cache[_loc3_])
         {
            var _loc4_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc3_);
            if(!_loc4_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache[_loc3_] = _loc4_;
         }
         return §§pop().get(_loc2_._cache[_loc3_]);
      }
      
      public static function get(row:Row) : EmissionReference
      {
         var _loc2_:* = null;
         assert("EmissionReference row is null",true,row != null);
         if(!CACHE.hasOwnProperty(row.id))
         {
            _loc2_ = new EmissionReference();
            _loc2_.init(row);
            CACHE[row.id] = _loc2_;
         }
         return CACHE[row.id];
      }
      
      private static function get table() : Table
      {
         if(!_table)
         {
            var _loc1_:ProjectManager = ProjectManager;
            _table = com.dchoc.projectdata.ProjectManager.projectData.findTable("Emitter");
         }
         return _table;
      }
      
      public static function getEmissionReferences(array:Array) : Array
      {
         var i:int = 0;
         var _loc2_:Array = [];
         for(i = 0; i < array.length; )
         {
            _loc2_.push(EmissionReference.get(array[i]));
            i++;
         }
         return _loc2_;
      }
      
      public function init(row:Row) : void
      {
         _field_cache = {};
         this.row = row;
         id = row.id;
      }
      
      public function toString() : String
      {
         return "EmissionReference id: " + id + " table: " + tableName + " special type: " + specialType;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = row;
         var _loc2_:* = _loc1_._table;
         return _loc2_._name;
      }
      
      public function get specialEffect() : Row
      {
         var _loc3_:Row = row;
         if(!_loc3_._cache["SpecialEffect"])
         {
            _loc3_._cache["SpecialEffect"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","SpecialEffect");
         }
         var _loc1_:Field = _loc3_._cache["SpecialEffect"];
         return null;
      }
      
      public function get specialType() : String
      {
         var _loc3_:Row = row;
         if(!_loc3_._cache["SpecialType"])
         {
            _loc3_._cache["SpecialType"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","SpecialType");
         }
         var _loc1_:Field = _loc3_._cache["SpecialType"];
         return null;
      }
      
      public function get soundID() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["SoundID"])
         {
            _loc2_._cache["SoundID"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SoundID");
         }
         var _loc1_:Field = _loc2_._cache["SoundID"];
         if(_loc1_)
         {
            var _loc3_:* = _loc1_;
            return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         }
         return id;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Followers"])
         {
            _loc2_._cache["Followers"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Followers");
         }
         var _loc1_:Field = _loc2_._cache["Followers"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, Followers.getFollowersData(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get affectedObjects() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["AffectsObjects"])
         {
            _loc2_._cache["AffectsObjects"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","AffectsObjects");
         }
         var _loc1_:Field = _loc2_._cache["AffectsObjects"];
         if(_loc1_)
         {
            var _loc3_:* = _loc1_;
            return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         }
         return ["all"];
      }
      
      public function get number() : int
      {
         var _loc1_:Field = getField("Number");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 1;
      }
      
      public function get delay() : int
      {
         var _loc1_:Field = getField("Delay");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get spread() : int
      {
         var _loc1_:Field = getField("Spread");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get angleOne() : int
      {
         var _loc1_:Field = getField("AngleOne");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get angleTwo() : int
      {
         var _loc1_:Field = getField("AngleTwo");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get useHitDirection() : Boolean
      {
         var _loc1_:Field = getField("UseHitDirection");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : false;
      }
      
      private function get isRandomOffset() : Boolean
      {
         var _loc1_:Field = getField("RandomOffset");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : false;
      }
      
      public function getDirectionAndOffsetBy(random:Random) : int
      {
         var _loc2_:Field = getField("DirectionAndOffsetBy");
         if(_loc2_ && (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) != 0)
         {
            if(isRandomOffset)
            {
               if(random == BattleManager.getRandom())
               {
                  LogUtils.log("Call to random directionAndOffsetBy()",this,0,"Random",false,false,false);
               }
               var _loc4_:* = _loc2_;
               return random.integer(0,_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
            }
            var _loc5_:* = _loc2_;
            return _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
         }
         return 1;
      }
      
      private function getField(name:String) : Field
      {
         if(!_field_cache.hasOwnProperty(name))
         {
            var _loc3_:* = name;
            var _loc2_:Row = row;
            §§push(_field_cache);
            §§push(name);
            if(!_loc2_._cache[_loc3_])
            {
               _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
            }
            §§pop()[§§pop()] = _loc2_._cache[_loc3_];
         }
         return _field_cache[name];
      }
   }
}
