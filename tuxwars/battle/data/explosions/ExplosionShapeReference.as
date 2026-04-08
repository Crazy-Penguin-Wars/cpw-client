package tuxwars.battle.data.explosions
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
   public class ExplosionShapeReference
   {
      private static const MIN_RADIUS:String = "MinRadius";
      
      private static const MAX_RADIUS:String = "MaxRadius";
      
      private static const ANGLE:String = "Angle";
      
      private var _fieldCache:Object;
      
      private var row:Row;
      
      public function ExplosionShapeReference(param1:Row)
      {
         super();
         assert("Row is null.",true,param1 != null);
         this._fieldCache = {};
         this.row = param1;
      }
      
      public function getName() : String
      {
         return this.row.id;
      }
      
      private function getField(param1:String) : Field
      {
         var _loc2_:Row = null;
         if(!this._fieldCache.hasOwnProperty(param1))
         {
            _loc2_ = this.row;
            if(!_loc2_.getCache[param1])
            {
               _loc2_.getCache[param1] = DCUtils.find(_loc2_.getFields(),"name",param1);
            }
            this._fieldCache[param1] = _loc2_.getCache[param1];
         }
         return this._fieldCache[param1];
      }
      
      public function getMinRadius() : int
      {
         var _loc1_:* = this.getField("MinRadius");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public function getMaxRadius() : int
      {
         var _loc1_:* = this.getField("MaxRadius");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public function getAngle() : int
      {
         var _loc1_:* = this.getField("Angle");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
   }
}

