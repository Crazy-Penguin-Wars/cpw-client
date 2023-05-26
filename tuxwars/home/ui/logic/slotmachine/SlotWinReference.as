package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.assert;
   
   public class SlotWinReference
   {
      
      public static const TABLE:String = "SlotWin";
      
      private static const WINREEL1:String = "WinResult1";
      
      private static const WINREEL2:String = "WinResult2";
      
      private static const WINREEL3:String = "WinResult3";
      
      private static const TITLE:String = "Title";
      
      private static const PICTURE:String = "Picture";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const SORT_ORDER:String = "SortOrder";
      
      private static const REWARD_XP:String = "RewardXP";
      
      private static const REWARD_COIN:String = "RewardCoin";
      
      private static const REWARD_CASH:String = "RewardCash";
      
      private static const REWARD_ITEM:String = "RewardItem";
       
      
      private var _row:Row;
      
      public function SlotWinReference(row:Row)
      {
         super();
         assert("SlotMachineReference is null",true,row != null);
         _row = row;
      }
      
      public function get id() : String
      {
         return _row.id;
      }
      
      public function get winResult1() : GraphicsReference
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["WinResult1"])
            {
               _loc2_._cache["WinResult1"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","WinResult1");
            }
            §§push(_loc2_._cache["WinResult1"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new GraphicsReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get winResult2() : GraphicsReference
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["WinResult2"])
            {
               _loc2_._cache["WinResult2"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","WinResult2");
            }
            §§push(_loc2_._cache["WinResult2"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new GraphicsReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get winResult3() : GraphicsReference
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["WinResult3"])
            {
               _loc2_._cache["WinResult3"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","WinResult3");
            }
            §§push(_loc2_._cache["WinResult3"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new GraphicsReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get title() : String
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["Title"])
            {
               _loc2_._cache["Title"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Title");
            }
            §§push(_loc2_._cache["Title"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get picture() : String
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["Picture"])
            {
               _loc2_._cache["Picture"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Picture");
            }
            §§push(_loc2_._cache["Picture"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, Config.getDataDir() + (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get description() : String
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["Description"])
            {
               _loc2_._cache["Description"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Description");
            }
            §§push(_loc2_._cache["Description"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get sortOrder() : int
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["SortOrder"])
            {
               _loc2_._cache["SortOrder"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SortOrder");
            }
            §§push(_loc2_._cache["SortOrder"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get rewardXP() : int
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["RewardXP"])
            {
               _loc2_._cache["RewardXP"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardXP");
            }
            §§push(_loc2_._cache["RewardXP"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get rewardCoin() : int
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["RewardCoin"])
            {
               _loc2_._cache["RewardCoin"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardCoin");
            }
            §§push(_loc2_._cache["RewardCoin"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get rewardCash() : int
      {
         if(_row)
         {
            var _loc2_:Row = _row;
            if(!_loc2_._cache["RewardCash"])
            {
               _loc2_._cache["RewardCash"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardCash");
            }
            §§push(_loc2_._cache["RewardCash"]);
         }
         else
         {
            §§push(null);
         }
         var _loc1_:Field = §§pop();
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get rewardItems() : Array
      {
         var _loc2_:Row = _row;
         if(!_loc2_._cache["RewardItem"])
         {
            _loc2_._cache["RewardItem"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RewardItem");
         }
         var _loc1_:Field = _loc2_._cache["RewardItem"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
   }
}
