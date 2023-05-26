package tuxwars.battle.data.levelobjects
{
   import com.dchoc.projectdata.Row;
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
         var _loc1_:Row = row;
         if(!_loc1_._cache["Toughness"])
         {
            _loc1_._cache["Toughness"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Toughness");
         }
         var _loc2_:* = _loc1_._cache["Toughness"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function getPhysicsFile() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["PhysicsFile"])
         {
            _loc1_._cache["PhysicsFile"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PhysicsFile");
         }
         var _loc2_:* = _loc1_._cache["PhysicsFile"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function getScore() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["Score"])
         {
            _loc1_._cache["Score"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Score");
         }
         var _loc2_:* = _loc1_._cache["Score"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      override public function getPhysics() : PhysicsReference
      {
         return null;
      }
   }
}
