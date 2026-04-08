package tuxwars.items.references
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.animationEmissions.*;
   
   public class EmissionAnimationReference
   {
      private static const ANIMATION:String = "Animation";
      
      private static const TARGET:String = "Target";
      
      private static const SOUND_ID:String = "SoundID";
      
      private var row:Row;
      
      public function EmissionAnimationReference(param1:Row)
      {
         super();
         assert("EmitTargetReference row is null",true,param1 != null);
         this.row = param1;
      }
      
      public function getID() : String
      {
         return this.row.id;
      }
      
      public function get tableName() : String
      {
         var _loc1_:Row = this.row;
         var _loc2_:* = _loc1_.table;
         return _loc2_._name;
      }
      
      public function getAnimationEmissionData() : AnimationEmissionData
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Animation";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         var _loc5_:Row = _loc3_ != null ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) as Row : null;
         return _loc5_ != null ? AnimationEmissions.getAnimationEmissionData(_loc5_.id) : null;
      }
      
      public function getTarget() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Target";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return _loc3_ != null ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get soundID() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SoundID";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
   }
}

