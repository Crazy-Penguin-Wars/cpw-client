package tuxwars.battle.data.explosions
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.assert;
   
   public class ExplosionShapeReference
   {
      
      private static const MIN_RADIUS:String = "MinRadius";
      
      private static const MAX_RADIUS:String = "MaxRadius";
      
      private static const ANGLE:String = "Angle";
       
      
      private var _fieldCache:Object;
      
      private var row:Row;
      
      public function ExplosionShapeReference(row:Row)
      {
         super();
         assert("Row is null.",true,row != null);
         _fieldCache = {};
         this.row = row;
      }
      
      public function getName() : String
      {
         return row.id;
      }
      
      private function getField(name:String) : Field
      {
         if(!_fieldCache.hasOwnProperty(name))
         {
            var _loc3_:* = name;
            var _loc2_:Row = row;
            §§push(_fieldCache);
            §§push(name);
            if(!_loc2_._cache[_loc3_])
            {
               _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
            }
            §§pop()[§§pop()] = _loc2_._cache[_loc3_];
         }
         return _fieldCache[name];
      }
      
      public function getMinRadius() : int
      {
         var _loc1_:* = getField("MinRadius");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public function getMaxRadius() : int
      {
         var _loc1_:* = getField("MaxRadius");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public function getAngle() : int
      {
         var _loc1_:* = getField("Angle");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
   }
}
