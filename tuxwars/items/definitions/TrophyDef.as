package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.TrophyData;
   
   public class TrophyDef extends ClothingDef
   {
       
      
      private var _requiredChallenges:Array;
      
      private var _statTextOverrideDesc:String;
      
      public function TrophyDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not TrophyData",true,data is TrophyData);
         var _loc2_:TrophyData = data as TrophyData;
         _requiredChallenges = _loc2_.requiredChallenges;
         _statTextOverrideDesc = _loc2_.statTextOverrideDesc;
      }
      
      public function get requiredChallenges() : Array
      {
         return _requiredChallenges;
      }
      
      public function get statTextOverrideDesc() : String
      {
         return _statTextOverrideDesc;
      }
   }
}
