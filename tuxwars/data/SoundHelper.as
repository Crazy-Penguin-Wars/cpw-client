package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class SoundHelper
   {
      private static var _instance:SoundHelper;
      
      private static const TABLE_AREA:String = "Area";
      
      private static const TABLE_SPEED:String = "Speed";
      
      private var area:Array;
      
      private var speed:Array;
      
      public function SoundHelper()
      {
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc1_:Table = null;
         var _loc2_:Array = null;
         var _loc3_:Table = null;
         var _loc4_:Array = null;
         this.area = [];
         this.speed = [];
         super();
         if(_instance == null)
         {
            _loc5_ = "Area";
            _loc1_ = ProjectManager.findTable(_loc5_);
            _loc6_ = _loc1_;
            _loc2_ = _loc6_._rows;
            _loc2_.sort(this.sortByValue);
            this.area = _loc2_;
            _loc7_ = "Speed";
            _loc3_ = ProjectManager.findTable(_loc7_);
            _loc8_ = _loc3_;
            _loc4_ = _loc8_._rows;
            _loc4_.sort(this.sortByValue);
            this.speed = _loc4_;
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
      
      private function sortByValue(param1:Row, param2:Row) : int
      {
         var _loc6_:* = undefined;
         var _loc11_:* = undefined;
         var _loc3_:String = "Value";
         var _loc4_:* = param1;
         if(!_loc4_.getCache[_loc3_])
         {
            _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
         }
         var _loc5_:Field = _loc4_.getCache[_loc3_];
         _loc6_ = _loc5_;
         var _loc7_:Number = Number(!!_loc5_ ? (_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 0);
         var _loc8_:String = "Value";
         var _loc9_:* = param2;
         if(!_loc9_.getCache[_loc8_])
         {
            _loc9_.getCache[_loc8_] = DCUtils.find(_loc9_.getFields(),"name",_loc8_);
         }
         var _loc10_:Field = _loc9_.getCache[_loc8_];
         _loc11_ = _loc10_;
         var _loc12_:Number = Number(!!_loc10_ ? (_loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value) : 0);
         if(_loc7_ == _loc12_)
         {
            return 0;
         }
         if(_loc7_ > _loc12_)
         {
            return -1;
         }
         return 1;
      }
      
      public function AreaReceiver(param1:Number) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:Field = null;
         var _loc3_:Number = Number(NaN);
         for each(_loc4_ in this.area)
         {
            _loc5_ = "Value";
            _loc6_ = _loc4_;
            if(!_loc6_.getCache[_loc5_])
            {
               _loc6_.getCache[_loc5_] = DCUtils.find(_loc6_.getFields(),"name",_loc5_);
            }
            _loc2_ = _loc6_.getCache[_loc5_];
            _loc7_ = _loc2_;
            _loc3_ = Number(!!_loc2_ ? (_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) : 0);
            if(param1 >= _loc3_)
            {
               return _loc4_.id;
            }
         }
         return _loc4_.id;
      }
      
      public function SpeedReceiver(param1:Number) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:Field = null;
         var _loc3_:Number = Number(NaN);
         for each(_loc4_ in this.speed)
         {
            _loc5_ = "Value";
            _loc6_ = _loc4_;
            if(!_loc6_.getCache[_loc5_])
            {
               _loc6_.getCache[_loc5_] = DCUtils.find(_loc6_.getFields(),"name",_loc5_);
            }
            _loc2_ = _loc6_.getCache[_loc5_];
            _loc7_ = _loc2_;
            _loc3_ = Number(!!_loc2_ ? (_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) : 0);
            if(param1 >= _loc3_)
            {
               return _loc4_.id;
            }
         }
         return _loc4_.id;
      }
   }
}

