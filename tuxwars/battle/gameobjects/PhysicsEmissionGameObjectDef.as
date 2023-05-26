package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GameData;
   import com.dchoc.gameobjects.stats.Stat;
   import nape.space.Space;
   import tuxwars.battle.data.TuxEmissionGameObjectData;
   
   public class PhysicsEmissionGameObjectDef extends PhysicsGameObjectDef
   {
       
      
      private var _playerAttackValue:Stat;
      
      private var _emissions:Array;
      
      private var _simpleScript:Array;
      
      public function PhysicsEmissionGameObjectDef(space:Space)
      {
         super(space);
      }
      
      public function set playerAttackValue(value:Stat) : void
      {
         _playerAttackValue = value;
      }
      
      public function get playerAttackValue() : Stat
      {
         return _playerAttackValue;
      }
      
      public function set emissions(ar:Array) : void
      {
         _emissions = ar;
      }
      
      public function get emissions() : Array
      {
         return _emissions;
      }
      
      public function get simpleScript() : Array
      {
         return _simpleScript;
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
         var _loc2_:TuxEmissionGameObjectData = data as TuxEmissionGameObjectData;
         _emissions = _loc2_.emissions;
         _simpleScript = _loc2_.simpleScript;
      }
   }
}
