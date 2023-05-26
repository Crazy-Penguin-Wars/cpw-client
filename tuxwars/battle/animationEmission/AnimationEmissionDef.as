package tuxwars.battle.animationEmission
{
   import com.dchoc.data.GameData;
   import com.dchoc.gameobjects.stats.Stat;
   import nape.space.Space;
   import tuxwars.battle.data.animationEmissions.AnimationEmissionData;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObjectDef;
   
   public class AnimationEmissionDef extends PhysicsEmissionGameObjectDef
   {
       
      
      private var _playerAttackValue:Stat;
      
      private var _emissions:Array;
      
      private var _activationTime:int;
      
      public function AnimationEmissionDef(space:Space)
      {
         super(space);
         objClass = AnimationEmission;
      }
      
      public function get activationTime() : int
      {
         return _activationTime;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _emissions = null;
         _playerAttackValue = null;
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         var _loc2_:AnimationEmissionData = data as AnimationEmissionData;
         _emissions = _loc2_.emissions;
         _activationTime = _loc2_.activationTime;
      }
   }
}
