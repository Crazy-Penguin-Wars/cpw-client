package tuxwars.battle.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.assert;
   import tuxwars.data.TuxGameData;
   
   public class TuxGameObjectData extends TuxGameData
   {
      
      private static const PHYSICS:String = "Physics";
      
      private static const HIT_POINTS:String = "HitPoints";
       
      
      protected var physics:PhysicsReference;
      
      public function TuxGameObjectData(row:Row)
      {
         assert("Row is null.",true,row != null);
         super(row);
      }
      
      public function getHitPoints() : int
      {
         var _loc1_:Field = getField("HitPoints");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function getPhysics() : PhysicsReference
      {
         if(!physics && hasPhysicsToLoad())
         {
            var _loc1_:* = getField("Physics");
            physics = new PhysicsReference(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value);
         }
         return physics;
      }
      
      public function hasPhysicsToLoad() : Boolean
      {
         return true;
      }
   }
}
