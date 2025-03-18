package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
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
            var _loc4_:String = "WinResult1";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "WinResult2";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "WinResult3";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Title";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Picture";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "Description";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "SortOrder";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "RewardXP";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "RewardCoin";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
            var _loc4_:String = "RewardCash";
            var _loc2_:Row = _row;
            if(!_loc2_._cache[_loc4_])
            {
               _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
            }
            §§push(_loc2_._cache[_loc4_]);
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
         var _loc4_:String = "RewardItem";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
   }
}

