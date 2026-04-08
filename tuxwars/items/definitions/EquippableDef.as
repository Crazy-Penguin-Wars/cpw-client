package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import com.dchoc.gameobjects.GameObjectDef;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.items.data.*;
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
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not EqippableData",true,param1 is EquippableData);
         var _loc2_:EquippableData = param1 as EquippableData;
         this._description = _loc2_.description;
         this._type = _loc2_.type;
         this._statBonuses = _loc2_.statBonuses;
         this._slot = _loc2_.slot;
         this._followers = _loc2_.followers;
      }
      
      public function get slot() : String
      {
         return this._slot;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         return this._statBonuses;
      }
      
      public function get followers() : Vector.<FollowerData>
      {
         return this._followers;
      }
   }
}

