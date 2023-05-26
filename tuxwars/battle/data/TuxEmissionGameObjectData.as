package tuxwars.battle.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import org.as3commons.lang.StringUtils;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.items.references.EmissionReference;
   
   public class TuxEmissionGameObjectData extends TuxGameObjectData
   {
      
      protected static const EMISSIONS:String = "Emitters";
      
      protected static const SIMPLE_SCRIPT:String = "SimpleScript";
       
      
      protected var _emissions:Array;
      
      protected var _simpleScript:Array;
      
      public function TuxEmissionGameObjectData(row:Row)
      {
         super(row);
      }
      
      public function get emissions() : Array
      {
         var field:Field;
         var localEmissions:*;
         var emissionsArray:Array;
         if(!_emissions)
         {
            field = getField("Emitters");
            if(field)
            {
               var _loc2_:* = getField("Emitters");
               localEmissions = _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
               emissionsArray = localEmissions is Array ? localEmissions as Array : [localEmissions];
               emissionsArray.sort(function(row1:Row, row2:Row):int
               {
                  return StringUtils.compareTo(row1.id,row2.id);
               });
               _emissions = EmissionReference.getEmissionReferences(emissionsArray);
            }
         }
         return _emissions;
      }
      
      public function get simpleScript() : Array
      {
         var _loc1_:* = null;
         if(!_simpleScript)
         {
            _loc1_ = getField("SimpleScript");
            if(_loc1_)
            {
               var _loc2_:* = _loc1_;
               var _loc3_:*;
               var _loc4_:*;
               _simpleScript = (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) is Array ? (_loc3_ = _loc1_, SimpleScriptManager.parseSimpleScriptFromOdsData(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : (_loc4_ = _loc1_, [_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value]);
            }
         }
         return _simpleScript;
      }
   }
}
