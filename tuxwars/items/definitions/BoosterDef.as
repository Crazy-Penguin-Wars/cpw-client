package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import flash.filters.GlowFilter;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class BoosterDef extends ItemDef
   {
      private var _durationType:String;
      
      private var _durationAmount:int;
      
      private var _glowFilter:GlowFilter;
      
      private var _emissions:Array;
      
      private var _missileBoostingEmissions:Array;
      
      private var _explosionBoostingEmissions:Array;
      
      private var _simpleScript:Array;
      
      public function BoosterDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not BoosterData",true,param1 is BoosterData);
         var _loc2_:BoosterData = param1 as BoosterData;
         this._durationType = _loc2_.durationType;
         this._durationAmount = _loc2_.durationAmount;
         this._glowFilter = _loc2_.glowFilter;
         this._emissions = _loc2_.emissions;
         this._missileBoostingEmissions = _loc2_.missileBoostingEmissions;
         this._explosionBoostingEmissions = _loc2_.explosionBoostingEmissions;
         this._simpleScript = _loc2_.simpleScript;
      }
      
      public function get durationType() : String
      {
         return this._durationType;
      }
      
      public function get durationAmount() : int
      {
         return this._durationAmount;
      }
      
      public function get glowFilter() : GlowFilter
      {
         return this._glowFilter;
      }
      
      public function get emissions() : Array
      {
         return this._emissions;
      }
      
      public function get missileBoostingEmissions() : Array
      {
         return this._missileBoostingEmissions;
      }
      
      public function get explosionBoostingEmissions() : Array
      {
         return this._explosionBoostingEmissions;
      }
      
      public function get simpleScript() : Array
      {
         return this._simpleScript;
      }
   }
}

