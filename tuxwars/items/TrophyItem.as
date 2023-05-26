package tuxwars.items
{
   import no.olog.utilfunctions.assert;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.definitions.TrophyDef;
   
   public class TrophyItem extends ClothingItem
   {
       
      
      private var _requiredChallenges:Array;
      
      private var _statTextOverrideDesc:String;
      
      public function TrophyItem()
      {
         super();
      }
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not TrophyDef",true,data is TrophyDef);
         var _loc2_:TrophyDef = data as TrophyDef;
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
