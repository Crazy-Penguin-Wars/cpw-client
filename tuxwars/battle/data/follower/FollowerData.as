package tuxwars.battle.data.follower
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.battle.data.TuxEmissionGameObjectData;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.items.references.*;
   
   public class FollowerData extends TuxEmissionGameObjectData
   {
      private static const TYPE:String = "Type";
      
      private static const EMIT_AT:String = "EmitAt";
      
      private static const ACTIVATIONS:String = "Activations";
      
      private static const DURATION:String = "Duration";
      
      private static const ACTIVATE_IN:String = "ActivateIn";
      
      private static const MULTIPLE_EMISSIONS:String = "MultipleEmissions";
      
      private static const ACTIVATION_COOLDOWN:String = "ActivationCooldown";
      
      private static const AFFECTS_OBJECTS:String = "AffectsObjects";
      
      private static const APPLY_TO_OBJECTS:String = "ApplyToObjects";
      
      private static const SIMPLE_SCRIPT:String = "SimpleScript";
      
      private static const TRIGGERS:String = "Trigger";
      
      private static const TARGET:String = "Target";
      
      private static const TARGET_SELECTION:String = "TargetSelection";
      
      private static const FOLLOWERS:String = "Followers";
      
      private static const STAT_BONUSES:String = "StatBonuses";
      
      private static const COLOR_REFERENCE:String = "ColorReference";
      
      public function FollowerData(param1:Row)
      {
         super(param1);
      }
      
      public function get type() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("Type");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "Agressive";
      }
      
      public function get emitAt() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("EmitAt");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "Target";
      }
      
      public function get targetSelection() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("TargetSelection");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "Random";
      }
      
      public function get activations() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("Activations");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get duration() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("Duration");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get activateIn() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("ActivateIn");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get multipleEmissions() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("MultipleEmissions");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? Boolean(_loc2_.overrideValue) : Boolean(_loc2_._value)) : false;
      }
      
      public function get target() : String
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("Target");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "All";
      }
      
      public function get activationCooldown() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("ActivationCooldown");
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get affectedObjects() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "AffectsObjects";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get applyToObjects() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "ApplyToObjects";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get followers() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Followers";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get triggers() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Trigger";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : ["Enter"];
      }
      
      public function get simpleScripts() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("SimpleScript");
         return !!_loc1_ ? (_loc2_ = _loc1_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value)) : null;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "StatBonuses";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new StatBonusReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value,this.type)) : null;
      }
      
      public function get colorReference() : ColorReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "ColorReference";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new ColorReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
   }
}

