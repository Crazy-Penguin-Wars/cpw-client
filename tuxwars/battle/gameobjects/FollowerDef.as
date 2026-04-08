package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GameData;
   import nape.space.Space;
   import tuxwars.battle.data.follower.*;
   import tuxwars.items.references.StatBonusReference;
   
   public class FollowerDef extends PhysicsEmissionGameObjectDef
   {
      private var _type:String;
      
      private var _emitAt:String;
      
      private var _activations:int;
      
      private var _duration:int;
      
      private var _activateIn:int;
      
      private var _multipleEmissions:Boolean;
      
      private var _activationCooldown:int;
      
      private var _affectedObjects:Array;
      
      private var _applyToObjects:Array;
      
      private var _triggers:Array;
      
      private var _target:String;
      
      private var _targetSelection:String;
      
      private var _followers:Array;
      
      private var _statBonuses:StatBonusReference;
      
      private var _colorReference:ColorReference;
      
      public function FollowerDef(param1:Space)
      {
         super(param1);
         objClass = Follower;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get emitAt() : String
      {
         return this._emitAt;
      }
      
      public function get targetSelection() : String
      {
         return this._targetSelection;
      }
      
      public function get activations() : int
      {
         return this._activations;
      }
      
      public function get duration() : int
      {
         return this._duration;
      }
      
      public function get activateIn() : int
      {
         return this._activateIn;
      }
      
      public function get multipleEmissions() : Boolean
      {
         return this._multipleEmissions;
      }
      
      public function get activationCooldown() : int
      {
         return this._activationCooldown;
      }
      
      public function get affectedObjects() : Array
      {
         return this._affectedObjects;
      }
      
      public function get applyToObjects() : Array
      {
         return this._applyToObjects;
      }
      
      public function get triggers() : Array
      {
         return this._triggers;
      }
      
      public function get followers() : Array
      {
         return this._followers;
      }
      
      public function get target() : String
      {
         return this._target;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         return this._statBonuses;
      }
      
      public function get colorReference() : ColorReference
      {
         return this._colorReference;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._affectedObjects = null;
         this._applyToObjects = null;
         this._triggers = null;
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         var _loc2_:FollowerData = param1 as FollowerData;
         this._type = _loc2_.type;
         this._emitAt = _loc2_.emitAt;
         this._activations = _loc2_.activations;
         this._duration = _loc2_.duration;
         this._activateIn = _loc2_.activateIn;
         this._multipleEmissions = _loc2_.multipleEmissions;
         this._activationCooldown = _loc2_.activationCooldown;
         this._affectedObjects = _loc2_.affectedObjects;
         this._applyToObjects = _loc2_.applyToObjects;
         this._triggers = _loc2_.triggers;
         this._target = _loc2_.target;
         this._targetSelection = _loc2_.targetSelection;
         this._followers = _loc2_.followers;
         this._statBonuses = _loc2_.statBonuses;
         this._colorReference = _loc2_.colorReference;
      }
   }
}

