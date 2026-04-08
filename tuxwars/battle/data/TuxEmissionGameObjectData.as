package tuxwars.battle.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import org.as3commons.lang.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.items.references.*;
   
   public class TuxEmissionGameObjectData extends TuxGameObjectData
   {
      protected static const EMISSIONS:String = "Emitters";
      
      protected static const SIMPLE_SCRIPT:String = "SimpleScript";
      
      protected var _emissions:Array;
      
      protected var _simpleScript:Array;
      
      public function TuxEmissionGameObjectData(param1:Row)
      {
         super(param1);
      }
      
      public function get emissions() : Array
      {
         var field:Field = null;
         var localEmissions:* = undefined;
         var emissionsArray:Array = null;
         var _loc2_:* = undefined;
         if(!this._emissions)
         {
            field = getField("Emitters");
            if(field)
            {
               _loc2_ = getField("Emitters");
               localEmissions = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
               emissionsArray = localEmissions is Array ? localEmissions as Array : [localEmissions];
               emissionsArray.sort(function(param1:Row, param2:Row):int
               {
                  return StringUtils.compareTo(param1.id,param2.id);
               });
               this._emissions = EmissionReference.getEmissionReferences(emissionsArray);
            }
         }
         return this._emissions;
      }
      
      public function get simpleScript() : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc1_:Field = null;
         if(!this._simpleScript)
         {
            _loc1_ = getField("SimpleScript");
            if(_loc1_)
            {
               _loc2_ = _loc1_;
               _loc4_ = _loc1_;
               this._simpleScript = (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) is Array ? (_loc3_ = _loc1_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : [_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value];
            }
         }
         return this._simpleScript;
      }
   }
}

