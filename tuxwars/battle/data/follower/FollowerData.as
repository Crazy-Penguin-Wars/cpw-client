package tuxwars.battle.data.follower
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import tuxwars.battle.data.TuxEmissionGameObjectData;
   import tuxwars.battle.gameobjects.ColorReference;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.items.references.StatBonusReference;
   
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
       
      
      public function FollowerData(row:Row)
      {
         super(row);
      }
      
      public function get type() : String
      {
         var _loc1_:Field = getField("Type");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "Agressive";
      }
      
      public function get emitAt() : String
      {
         var _loc1_:Field = getField("EmitAt");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "Target";
      }
      
      public function get targetSelection() : String
      {
         var _loc1_:Field = getField("TargetSelection");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "Random";
      }
      
      public function get activations() : int
      {
         var _loc1_:Field = getField("Activations");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get duration() : int
      {
         var _loc1_:Field = getField("Duration");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get activateIn() : int
      {
         var _loc1_:Field = getField("ActivateIn");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get multipleEmissions() : Boolean
      {
         var _loc1_:Field = getField("MultipleEmissions");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : false;
      }
      
      public function get target() : String
      {
         var _loc1_:Field = getField("Target");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : "All";
      }
      
      public function get activationCooldown() : int
      {
         var _loc1_:Field = getField("ActivationCooldown");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get affectedObjects() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["AffectsObjects"])
         {
            _loc2_._cache["AffectsObjects"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","AffectsObjects");
         }
         var _loc1_:Field = _loc2_._cache["AffectsObjects"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get applyToObjects() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["ApplyToObjects"])
         {
            _loc2_._cache["ApplyToObjects"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","ApplyToObjects");
         }
         var _loc1_:Field = _loc2_._cache["ApplyToObjects"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get followers() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Followers"])
         {
            _loc2_._cache["Followers"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Followers");
         }
         var _loc1_:Field = _loc2_._cache["Followers"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get triggers() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Trigger"])
         {
            _loc2_._cache["Trigger"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Trigger");
         }
         var _loc1_:Field = _loc2_._cache["Trigger"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : ["Enter"];
      }
      
      public function get simpleScripts() : Array
      {
         var _loc1_:Field = getField("SimpleScript");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value)) : null;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["StatBonuses"])
         {
            _loc2_._cache["StatBonuses"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","StatBonuses");
         }
         var _loc1_:Field = _loc2_._cache["StatBonuses"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new StatBonusReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value,type)) : null;
      }
      
      public function get colorReference() : ColorReference
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["ColorReference"])
         {
            _loc2_._cache["ColorReference"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","ColorReference");
         }
         var _loc1_:Field = _loc2_._cache["ColorReference"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new ColorReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
   }
}
