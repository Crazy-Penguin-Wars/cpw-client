package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class SoundHelper
   {
      private static const TABLE_AREA:String = "Area";
      
      private static const TABLE_SPEED:String = "Speed";
      
      private static var _instance:SoundHelper;
      
      private var area:Array;
      
      private var speed:Array;
      
      public function SoundHelper()
      {
         var _loc1_:Table = null;
         var rowsArea:Array = null;
         var _loc2_:Table = null;
         var rowsSpeed:Array = null;
         area = [];
         speed = [];
         super();
         if(_instance == null)
         {
            var _loc9_:String = "Area";
            var _loc5_:ProjectManager = ProjectManager;
            _loc1_ = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc9_);
            var _loc6_:* = _loc1_;
            rowsArea = _loc6_._rows;
            rowsArea.sort(sortByValue);
            area = rowsArea;
            var _loc10_:String = "Speed";
            var _loc7_:ProjectManager = ProjectManager;
            _loc2_ = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc10_);
            var _loc8_:* = _loc2_;
            rowsSpeed = _loc8_._rows;
            rowsSpeed.sort(sortByValue);
            speed = rowsSpeed;
            _instance = this;
         }
      }
      
      public static function get instance() : SoundHelper
      {
         if(_instance == null)
         {
            new SoundHelper();
         }
         return _instance;
      }
      
      private function sortByValue(a:Row, b:Row) : int
      {
         var _loc11_:String = "Value";
         var _loc7_:* = a;
         if(!_loc7_._cache[_loc11_])
         {
            _loc7_._cache[_loc11_] = com.dchoc.utils.DCUtils.find(_loc7_._fields,"name",_loc11_);
         }
         var _loc3_:Field = _loc7_._cache[_loc11_];
         var _loc8_:*;
         var _loc6_:Number = Number(!!_loc3_ ? (_loc8_ = _loc3_, _loc8_.overrideValue != null ? _loc8_.overrideValue : _loc8_._value) : 0);
         var _loc12_:String = "Value";
         var _loc9_:* = b;
         if(!_loc9_._cache[_loc12_])
         {
            _loc9_._cache[_loc12_] = com.dchoc.utils.DCUtils.find(_loc9_._fields,"name",_loc12_);
         }
         var _loc4_:Field = _loc9_._cache[_loc12_];
         var _loc10_:*;
         var _loc5_:Number = Number(!!_loc4_ ? (_loc10_ = _loc4_, _loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value) : 0);
         if(_loc6_ == _loc5_)
         {
            return 0;
         }
         if(_loc6_ > _loc5_)
         {
            return -1;
         }
         return 1;
      }
      
      public function AreaReceiver(value:Number) : String
      {
         var _loc2_:Field = null;
         var _loc3_:Number = NaN;
         for each(var row in area)
         {
            var _loc9_:String = "Value";
            var _loc5_:* = row;
            if(!_loc5_._cache[_loc9_])
            {
               _loc5_._cache[_loc9_] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name",_loc9_);
            }
            _loc2_ = _loc5_._cache[_loc9_];
            var _loc6_:*;
            _loc3_ = Number(!!_loc2_ ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 0);
            if(value >= _loc3_)
            {
               return row.id;
            }
         }
         return row.id;
      }
      
      public function SpeedReceiver(value:Number) : String
      {
         var _loc2_:Field = null;
         var _loc3_:Number = NaN;
         for each(var row in speed)
         {
            var _loc9_:String = "Value";
            var _loc5_:* = row;
            if(!_loc5_._cache[_loc9_])
            {
               _loc5_._cache[_loc9_] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name",_loc9_);
            }
            _loc2_ = _loc5_._cache[_loc9_];
            var _loc6_:*;
            _loc3_ = Number(!!_loc2_ ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 0);
            if(value >= _loc3_)
            {
               return row.id;
            }
         }
         return row.id;
      }
   }
}

