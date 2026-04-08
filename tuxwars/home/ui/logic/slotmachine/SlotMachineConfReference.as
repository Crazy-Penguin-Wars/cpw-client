package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class SlotMachineConfReference
   {
      private static var row:Row;
      
      private static const DEFAULT:String = "Default";
      
      private static const TABLE:String = "SlotMachineConfiguration";
      
      private static const FRIEND_AMOUNT_1:String = "CentralRowActiveFriends";
      
      private static const FRIEND_AMOUNT_2:String = "BottomRowActiveFriends";
      
      private static const FRIEND_AMOUNT_3:String = "TopRowActiveFriends";
      
      private static const FRIEND_AMOUNT_4:String = "BottomLeftToTopRightActiveFriends";
      
      private static const FRIEND_AMOUNT_5:String = "TopLeftToBottomRightActiveFriends";
      
      private static const SPIN_PRICE:String = "PlayPriceInCash";
      
      public function SlotMachineConfReference()
      {
         super();
         throw new Error("SlotMachineConfReference is a static class!");
      }
      
      public static function get friendAmount1() : int
      {
         var _loc1_:String = "CentralRowActiveFriends";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get friendAmount2() : int
      {
         var _loc1_:String = "BottomRowActiveFriends";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get friendAmount3() : int
      {
         var _loc1_:String = "TopRowActiveFriends";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get friendAmount4() : int
      {
         var _loc1_:String = "BottomLeftToTopRightActiveFriends";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get friendAmount5() : int
      {
         var _loc1_:String = "TopLeftToBottomRightActiveFriends";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get spinPrice() : int
      {
         var _loc1_:String = "PlayPriceInCash";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getRow() : Row
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         if(!row)
         {
            _loc1_ = "SlotMachineConfiguration";
            _loc2_ = "Default";
            _loc3_ = ProjectManager.findTable(_loc1_);
            if(!_loc3_.getCache[_loc2_])
            {
               _loc4_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
               if(!_loc4_)
               {
                  LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
               }
               _loc3_.getCache[_loc2_] = _loc4_;
            }
            row = _loc3_.getCache[_loc2_];
            if(!row)
            {
               LogUtils.log("Couldn\'t for default row for SlotMachineConfReference.",3);
            }
         }
         return row;
      }
   }
}

