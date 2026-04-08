package tuxwars.battle.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.*;
   import tuxwars.data.TuxGameData;
   
   public class TuxGameObjectData extends TuxGameData
   {
      private static const PHYSICS:String = "Physics";
      
      private static const HIT_POINTS:String = "HitPoints";
      
      protected var physics:PhysicsReference;
      
      public function TuxGameObjectData(param1:Row)
      {
         assert("Row is null.",true,param1 != null);
         super(param1);
      }
      
      public function getHitPoints() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("HitPoints");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function getPhysics() : PhysicsReference
      {
         var _loc1_:* = undefined;
         if(!this.physics && this.hasPhysicsToLoad())
         {
            _loc1_ = getField("Physics");
            this.physics = new PhysicsReference(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value);
         }
         return this.physics;
      }
      
      public function hasPhysicsToLoad() : Boolean
      {
         return true;
      }
   }
}

