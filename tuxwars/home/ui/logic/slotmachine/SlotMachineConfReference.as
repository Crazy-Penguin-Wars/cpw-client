package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
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
         var _loc1_:* = getRow();
         if(!_loc1_._cache["CentralRowActiveFriends"])
         {
            _loc1_._cache["CentralRowActiveFriends"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","CentralRowActiveFriends");
         }
         var _loc2_:* = _loc1_._cache["CentralRowActiveFriends"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get friendAmount2() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["BottomRowActiveFriends"])
         {
            _loc1_._cache["BottomRowActiveFriends"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","BottomRowActiveFriends");
         }
         var _loc2_:* = _loc1_._cache["BottomRowActiveFriends"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get friendAmount3() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TopRowActiveFriends"])
         {
            _loc1_._cache["TopRowActiveFriends"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TopRowActiveFriends");
         }
         var _loc2_:* = _loc1_._cache["TopRowActiveFriends"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get friendAmount4() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["BottomLeftToTopRightActiveFriends"])
         {
            _loc1_._cache["BottomLeftToTopRightActiveFriends"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","BottomLeftToTopRightActiveFriends");
         }
         var _loc2_:* = _loc1_._cache["BottomLeftToTopRightActiveFriends"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get friendAmount5() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TopLeftToBottomRightActiveFriends"])
         {
            _loc1_._cache["TopLeftToBottomRightActiveFriends"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TopLeftToBottomRightActiveFriends");
         }
         var _loc2_:* = _loc1_._cache["TopLeftToBottomRightActiveFriends"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get spinPrice() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["PlayPriceInCash"])
         {
            _loc1_._cache["PlayPriceInCash"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PlayPriceInCash");
         }
         var _loc2_:* = _loc1_._cache["PlayPriceInCash"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getRow() : Row
      {
         if(!row)
         {
            var _loc1_:ProjectManager = ProjectManager;
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("SlotMachineConfiguration");
            if(!_loc2_._cache["Default"])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Default");
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache["Default"] = _loc5_;
            }
            row = _loc2_._cache["Default"];
            if(!row)
            {
               LogUtils.log("Couldn\'t for default row for SlotMachineConfReference.",3);
            }
         }
         return row;
      }
   }
}
