package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class SlotMachineConfReference
   {
      private static const DEFAULT:String = "Default";
      
      private static const TABLE:String = "SlotMachineConfiguration";
      
      private static const FRIEND_AMOUNT_1:String = "CentralRowActiveFriends";
      
      private static const FRIEND_AMOUNT_2:String = "BottomRowActiveFriends";
      
      private static const FRIEND_AMOUNT_3:String = "TopRowActiveFriends";
      
      private static const FRIEND_AMOUNT_4:String = "BottomLeftToTopRightActiveFriends";
      
      private static const FRIEND_AMOUNT_5:String = "TopLeftToBottomRightActiveFriends";
      
      private static const SPIN_PRICE:String = "PlayPriceInCash";
      
      private static var row:Row;
      
      public function SlotMachineConfReference()
      {
         super();
         throw new Error("SlotMachineConfReference is a static class!");
      }
      
      public static function get friendAmount1() : int
      {
         var _loc3_:String = "CentralRowActiveFriends";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get friendAmount2() : int
      {
         var _loc3_:String = "BottomRowActiveFriends";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get friendAmount3() : int
      {
         var _loc3_:String = "TopRowActiveFriends";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get friendAmount4() : int
      {
         var _loc3_:String = "BottomLeftToTopRightActiveFriends";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get friendAmount5() : int
      {
         var _loc3_:String = "TopLeftToBottomRightActiveFriends";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get spinPrice() : int
      {
         var _loc3_:String = "PlayPriceInCash";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getRow() : Row
      {
         if(!row)
         {
            var _loc3_:String = "SlotMachineConfiguration";
            var _loc1_:ProjectManager = ProjectManager;
            var _loc4_:String = "Default";
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc3_);
            if(!_loc2_._cache[_loc4_])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc4_);
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache[_loc4_] = _loc5_;
            }
            row = _loc2_._cache[_loc4_];
            if(!row)
            {
               LogUtils.log("Couldn\'t for default row for SlotMachineConfReference.",3);
            }
         }
         return row;
      }
   }
}

