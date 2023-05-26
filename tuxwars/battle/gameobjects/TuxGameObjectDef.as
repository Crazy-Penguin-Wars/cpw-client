package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GameData;
   import com.dchoc.gameobjects.GameObjectDef;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.TuxGameObjectData;
   
   public class TuxGameObjectDef extends GameObjectDef
   {
       
      
      private var _hitPoints:int;
      
      public function TuxGameObjectDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("data is not a TuxGameObjectData.",true,data is TuxGameObjectData);
         var _loc2_:TuxGameObjectData = data as TuxGameObjectData;
         _hitPoints = _loc2_.getHitPoints();
      }
      
      public function get hitPoints() : int
      {
         return _hitPoints;
      }
      
      public function set hitPoints(value:int) : void
      {
         _hitPoints = value;
      }
   }
}
