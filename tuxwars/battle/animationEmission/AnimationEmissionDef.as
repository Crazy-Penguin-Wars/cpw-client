package tuxwars.battle.animationEmission
{
   import com.dchoc.data.GameData;
   import com.dchoc.gameobjects.stats.Stat;
   import nape.space.Space;
   import tuxwars.battle.data.animationEmissions.*;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObjectDef;
   
   public class AnimationEmissionDef extends PhysicsEmissionGameObjectDef
   {
      private var _playerAttackValue:Stat;
      
      private var _emissions:Array;
      
      private var _activationTime:int;
      
      public function AnimationEmissionDef(param1:Space)
      {
         super(param1);
         objClass = AnimationEmission;
      }
      
      public function get activationTime() : int
      {
         return this._activationTime;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._emissions = null;
         this._playerAttackValue = null;
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         var _loc2_:AnimationEmissionData = param1 as AnimationEmissionData;
         this._emissions = _loc2_.emissions;
         this._activationTime = _loc2_.activationTime;
      }
   }
}

