package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import com.dchoc.gameobjects.GameObjectDef;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.items.data.EquippableData;
   import tuxwars.items.references.StatBonusReference;
   
   public class EquippableDef extends GameObjectDef
   {
       
      
      private var _type:String;
      
      private var _description:String;
      
      private var _statBonuses:StatBonusReference;
      
      private var _slot:String;
      
      private var _followers:Vector.<FollowerData>;
      
      public function EquippableDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not EqippableData",true,data is EquippableData);
         var _loc2_:EquippableData = data as EquippableData;
         _description = _loc2_.description;
         _type = _loc2_.type;
         _statBonuses = _loc2_.statBonuses;
         _slot = _loc2_.slot;
         _followers = _loc2_.followers;
      }
      
      public function get slot() : String
      {
         return _slot;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         return _statBonuses;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         return _followers;
      }
   }
}
