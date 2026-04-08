package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GameData;
   import com.dchoc.gameobjects.GameObjectDef;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.*;
   
   public class TuxGameObjectDef extends GameObjectDef
   {
      private var _hitPoints:int;
      
      public function TuxGameObjectDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("data is not a TuxGameObjectData.",true,param1 is TuxGameObjectData);
         var _loc2_:TuxGameObjectData = param1 as TuxGameObjectData;
         this._hitPoints = _loc2_.getHitPoints();
      }
      
      public function get hitPoints() : int
      {
         return this._hitPoints;
      }
      
      public function set hitPoints(param1:int) : void
      {
         this._hitPoints = param1;
      }
   }
}

