package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GameData;
   import com.dchoc.gameobjects.stats.Stat;
   import nape.space.Space;
   import tuxwars.battle.data.*;
   
   public class PhysicsEmissionGameObjectDef extends PhysicsGameObjectDef
   {
      private var _playerAttackValue:Stat;
      
      private var _emissions:Array;
      
      private var _simpleScript:Array;
      
      public function PhysicsEmissionGameObjectDef(param1:Space)
      {
         super(param1);
      }
      
      public function set playerAttackValue(param1:Stat) : void
      {
         this._playerAttackValue = param1;
      }
      
      public function get playerAttackValue() : Stat
      {
         return this._playerAttackValue;
      }
      
      public function set emissions(param1:Array) : void
      {
         this._emissions = param1;
      }
      
      public function get emissions() : Array
      {
         return this._emissions;
      }
      
      public function get simpleScript() : Array
      {
         return this._simpleScript;
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
         var _loc2_:TuxEmissionGameObjectData = param1 as TuxEmissionGameObjectData;
         this._emissions = _loc2_.emissions;
         this._simpleScript = _loc2_.simpleScript;
      }
   }
}

