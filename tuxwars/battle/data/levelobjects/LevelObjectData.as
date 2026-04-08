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
      
      public function LevelObjectData(param1:Row)
      {
         super(param1);
      }
      
      public function getToughness() : int
      {
         var _loc1_:String = "Toughness";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public function getPhysicsFile() : String
      {
         var _loc1_:String = "PhysicsFile";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function getScore() : int
      {
         var _loc1_:String = "Score";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      override public function getPhysics() : PhysicsReference
      {
         return null;
      }
   }
}

