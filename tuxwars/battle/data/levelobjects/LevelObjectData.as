package tuxwars.battle.data.levelobjects
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.PhysicsReference;
   import tuxwars.battle.data.TuxGameObjectData;
   
   public class LevelObjectData extends TuxGameObjectData
   {
      private static const TOUGHNESS:String = "Toughness";
      
      private static const PHYSICS_FILE:String = "PhysicsFile";
      
      private static const SCORE:String = "Score";
      
      public function LevelObjectData(row:Row)
      {
         super(row);
      }
      
      public function getToughness() : int
      {
         var _loc3_:String = "Toughness";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function getPhysicsFile() : String
      {
         var _loc3_:String = "PhysicsFile";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function getScore() : int
      {
         var _loc3_:String = "Score";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      override public function getPhysics() : PhysicsReference
      {
         return null;
      }
   }
}

