package tuxwars.home.ui.logic.slotmachine
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
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
      
      public function SlotWinReference(param1:Row)
      {
         super();
         assert("SlotMachineReference is null",true,param1 != null);
         this._row = param1;
      }
      
      public function get id() : String
      {
         return this._row.id;
      }
      
      public function get winResult1() : GraphicsReference
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "WinResult1";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? new GraphicsReference(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get winResult2() : GraphicsReference
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "WinResult2";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? new GraphicsReference(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get winResult3() : GraphicsReference
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "WinResult3";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? new GraphicsReference(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get title() : String
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "Title";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? ProjectManager.getText(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get picture() : String
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "Picture";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? Config.getDataDir() + (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get description() : String
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "Description";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? ProjectManager.getText(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
      }
      
      public function get sortOrder() : int
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "SortOrder";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? int(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : 0;
      }
      
      public function get rewardXP() : int
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "RewardXP";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? int(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : 0;
      }
      
      public function get rewardCoin() : int
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "RewardCoin";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? int(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : 0;
      }
      
      public function get rewardCash() : int
      {
         var _loc2_:String = null;
         var _loc1_:Field = null;
         if(this._row)
         {
            _loc2_ = "RewardCash";
            if(!this._row.getCache[_loc2_])
            {
               this._row.getCache[_loc2_] = DCUtils.find(this._row.getFields(),"name",_loc2_);
            }
            _loc1_ = this._row.getCache[_loc2_];
         }
         return !!_loc1_ ? int(_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : 0;
      }
      
      public function get rewardItems() : Array
      {
         var _loc1_:String = "RewardItem";
         if(!this._row.getCache[_loc1_])
         {
            this._row.getCache[_loc1_] = DCUtils.find(this._row.getFields(),"name",_loc1_);
         }
         var _loc2_:Field = this._row.getCache[_loc1_];
         return !!_loc2_ ? (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
      }
   }
}

