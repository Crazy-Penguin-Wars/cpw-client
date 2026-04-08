package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class TrophyDef extends ClothingDef
   {
      private var _requiredChallenges:Array;
      
      private var _statTextOverrideDesc:String;
      
      public function TrophyDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not TrophyData",true,param1 is TrophyData);
         var _loc2_:TrophyData = param1 as TrophyData;
         this._requiredChallenges = _loc2_.requiredChallenges;
         this._statTextOverrideDesc = _loc2_.statTextOverrideDesc;
      }
      
      public function get requiredChallenges() : Array
      {
         return this._requiredChallenges;
      }
      
      public function get statTextOverrideDesc() : String
      {
         return this._statTextOverrideDesc;
      }
   }
}

