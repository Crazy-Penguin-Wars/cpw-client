package tuxwars.battle.gameobjects
{
   import com.dchoc.data.GameData;
   import nape.space.Space;
   import tuxwars.battle.data.follower.FollowerData;
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
      
      public function FollowerDef(space:Space)
      {
         super(space);
         objClass = Follower;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get emitAt() : String
      {
         return _emitAt;
      }
      
      public function get targetSelection() : String
      {
         return _targetSelection;
      }
      
      public function get activations() : int
      {
         return _activations;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function get activateIn() : int
      {
         return _activateIn;
      }
      
      public function get multipleEmissions() : Boolean
      {
         return _multipleEmissions;
      }
      
      public function get activationCooldown() : int
      {
         return _activationCooldown;
      }
      
      public function get affectedObjects() : Array
      {
         return _affectedObjects;
      }
      
      public function get applyToObjects() : Array
      {
         return _applyToObjects;
      }
      
      public function get triggers() : Array
      {
         return _triggers;
      }
      
      public function get followers() : Array
      {
         return _followers;
      }
      
      public function get target() : String
      {
         return _target;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         return _statBonuses;
      }
      
      public function get colorReference() : ColorReference
      {
         return _colorReference;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _affectedObjects = null;
         _applyToObjects = null;
         _triggers = null;
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         var _loc2_:FollowerData = data as FollowerData;
         _type = _loc2_.type;
         _emitAt = _loc2_.emitAt;
         _activations = _loc2_.activations;
         _duration = _loc2_.duration;
         _activateIn = _loc2_.activateIn;
         _multipleEmissions = _loc2_.multipleEmissions;
         _activationCooldown = _loc2_.activationCooldown;
         _affectedObjects = _loc2_.affectedObjects;
         _applyToObjects = _loc2_.applyToObjects;
         _triggers = _loc2_.triggers;
         _target = _loc2_.target;
         _targetSelection = _loc2_.targetSelection;
         _followers = _loc2_.followers;
         _statBonuses = _loc2_.statBonuses;
         _colorReference = _loc2_.colorReference;
      }
   }
}
