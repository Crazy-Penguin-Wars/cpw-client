package tuxwars.battle.emitters
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.items.references.EmissionReference;
   
   public interface Emission
   {
       
      
      function get id() : String;
      
      function get uniqueId() : String;
      
      function get shortName() : String;
      
      function get emissions() : Array;
      
      function setEmissionsParams(param1:String, param2:*) : void;
      
      function getEmissionsParams(param1:String) : *;
      
      function hasEmissionsParams(param1:String) : Boolean;
      
      function setEmissionData(param1:EmissionReference, param2:String, param3:*) : void;
      
      function getEmissionData(param1:EmissionReference, param2:String) : *;
      
      function hasEmissionData(param1:EmissionReference, param2:String) : Boolean;
      
      function setExplosionPrecalculationsWrapper(param1:ExplosionPreCalculationsWrapper) : void;
      
      function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper;
      
      function get tagger() : Tagger;
      
      function get locationOriginal() : Vec2;
      
      function get location() : Vec2;
      
      function set location(param1:Vec2) : void;
      
      function get emitLocation() : Vec2;
      
      function set emitLocation(param1:Vec2) : void;
      
      function get radius() : Number;
      
      function get playerAttackValueStat() : Stat;
      
      function set playerAttackValue(param1:int) : void;
      
      function findStat(param1:String) : Stat;
      
      function get playerBoosterStats() : Stats;
      
      function set playerBoosterStats(param1:Stats) : void;
      
      function set soundId(param1:String) : void;
      
      function playSound() : void;
      
      function playEndSound(param1:String) : void;
      
      function playLoopSound() : void;
      
      function readyToEmit() : Boolean;
      
      function setEmittingDone() : void;
      
      function isEmittingDone() : Boolean;
      
      function isFinished() : Boolean;
      
      function triggerEmission() : void;
      
      function getBoosterMissileEmissions() : Array;
      
      function getBoosterExplosionEmissions() : Array;
   }
}
