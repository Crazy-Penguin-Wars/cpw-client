package tuxwars.items
{
   import no.olog.utilfunctions.*;
   import tuxwars.items.definitions.*;
   
   public class TrophyItem extends ClothingItem
   {
      private var _requiredChallenges:Array;
      
      private var _statTextOverrideDesc:String;
      
      public function TrophyItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not TrophyDef",true,param1 is TrophyDef);
         var _loc2_:TrophyDef = param1 as TrophyDef;
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

