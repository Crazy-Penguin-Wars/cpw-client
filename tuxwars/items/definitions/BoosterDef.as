package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import flash.filters.GlowFilter;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.BoosterData;
   
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
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not BoosterData",true,data is BoosterData);
         var _loc2_:BoosterData = data as BoosterData;
         _durationType = _loc2_.durationType;
         _durationAmount = _loc2_.durationAmount;
         _glowFilter = _loc2_.glowFilter;
         _emissions = _loc2_.emissions;
         _missileBoostingEmissions = _loc2_.missileBoostingEmissions;
         _explosionBoostingEmissions = _loc2_.explosionBoostingEmissions;
         _simpleScript = _loc2_.simpleScript;
      }
      
      public function get durationType() : String
      {
         return _durationType;
      }
      
      public function get durationAmount() : int
      {
         return _durationAmount;
      }
      
      public function get glowFilter() : GlowFilter
      {
         return _glowFilter;
      }
      
      public function get emissions() : Array
      {
         return _emissions;
      }
      
      public function get missileBoostingEmissions() : Array
      {
         return _missileBoostingEmissions;
      }
      
      public function get explosionBoostingEmissions() : Array
      {
         return _explosionBoostingEmissions;
      }
      
      public function get simpleScript() : Array
      {
         return _simpleScript;
      }
   }
}
