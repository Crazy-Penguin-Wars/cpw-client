package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class Experience
   {
      private static var table:Table;
      
      private static const TABLE_NAME:String = "Experience";
      
      private static const SCORE:String = "Score";
      
      private static const REWARD_CASH:String = "RewardCash";
      
      private static const REWARD_COINS:String = "RewardCoins";
      
      private static const REWARD_ITEMS:String = "RewardItems";
      
      private static const REWARD_ITEMS_AMOUNT:String = "RewardItemsAmount";
      
      private static const REWARD_DAYS_OF_VIP:String = "RewardDaysOfVip";
      
      public function Experience()
      {
         super();
         throw new Error("Experience is a static class!");
      }
      
      public static function getLevel(param1:int) : int
      {
         var _loc2_:Row = findNextLevel(param1);
         return !!_loc2_ ? int(parseInt(_loc2_.id) - 1) : -1;
      }
      
      public static function getScore(param1:int) : int
      {
         var _loc5_:Row = null;
         var _loc6_:Field = null;
         var _loc2_:String = param1.toString();
         var _loc3_:Table = getTable();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc5_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc5_;
         }
         var _loc4_:Row = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            if(!_loc4_.getCache["Score"])
            {
               _loc4_.getCache["Score"] = DCUtils.find(_loc4_.getFields(),"name","Score");
            }
            _loc6_ = _loc4_.getCache["Score"];
            return !!_loc6_ ? int(_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : -1;
         }
         return -1;
      }
      
      public static function getRewardCoins(param1:int) : int
      {
         var _loc5_:Row = null;
         var _loc6_:Field = null;
         var _loc2_:String = param1.toString();
         var _loc3_:Table = getTable();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc5_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc5_;
         }
         var _loc4_:Row = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            if(!_loc4_.getCache["RewardCoins"])
            {
               _loc4_.getCache["RewardCoins"] = DCUtils.find(_loc4_.getFields(),"name","RewardCoins");
            }
            _loc6_ = _loc4_.getCache["RewardCoins"];
            return !!_loc6_ ? int(_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 0;
         }
         return 0;
      }
      
      public static function getRewardCash(param1:int) : int
      {
         var _loc5_:Row = null;
         var _loc6_:Field = null;
         var _loc2_:String = param1.toString();
         var _loc3_:Table = getTable();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc5_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc5_;
         }
         var _loc4_:Row = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            if(!_loc4_.getCache["RewardCash"])
            {
               _loc4_.getCache["RewardCash"] = DCUtils.find(_loc4_.getFields(),"name","RewardCash");
            }
            _loc6_ = _loc4_.getCache["RewardCash"];
            return !!_loc6_ ? int(_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 0;
         }
         return 0;
      }
      
      public static function getRewardItems(param1:int) : Array
      {
         var _loc5_:Row = null;
         var _loc6_:Field = null;
         var _loc2_:String = param1.toString();
         var _loc3_:Table = getTable();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc5_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc5_;
         }
         var _loc4_:Row = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            if(!_loc4_.getCache["RewardItems"])
            {
               _loc4_.getCache["RewardItems"] = DCUtils.find(_loc4_.getFields(),"name","RewardItems");
            }
            _loc6_ = _loc4_.getCache["RewardItems"];
            return !!_loc6_ ? (_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : null;
         }
         return null;
      }
      
      public static function getRewardItemsAmount(param1:int) : Array
      {
         var _loc5_:Row = null;
         var _loc6_:Field = null;
         var _loc2_:String = param1.toString();
         var _loc3_:Table = getTable();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc5_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc5_;
         }
         var _loc4_:Row = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            if(!_loc4_.getCache["RewardItemsAmount"])
            {
               _loc4_.getCache["RewardItemsAmount"] = DCUtils.find(_loc4_.getFields(),"name","RewardItemsAmount");
            }
            _loc6_ = _loc4_.getCache["RewardItemsAmount"];
            return !!_loc6_ ? (_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : null;
         }
         return null;
      }
      
      public static function getRewardDaysOfVip(param1:int) : int
      {
         var _loc5_:Row = null;
         var _loc6_:Field = null;
         var _loc2_:String = param1.toString();
         var _loc3_:Table = getTable();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc5_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc5_;
         }
         var _loc4_:Row = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            if(!_loc4_.getCache["RewardDaysOfVip"])
            {
               _loc4_.getCache["RewardDaysOfVip"] = DCUtils.find(_loc4_.getFields(),"name","RewardDaysOfVip");
            }
            _loc6_ = _loc4_.getCache["RewardDaysOfVip"];
            return !!_loc6_ ? int(_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : -1;
         }
         return -1;
      }
      
      public static function findNextLevel(param1:int) : Row
      {
         var _loc7_:String = null;
         var _loc8_:Row = null;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Row = null;
         var _loc4_:Field = null;
         var _loc5_:Table = getTable();
         var _loc6_:int = int(_loc5_._rows.length);
         _loc2_ = 1;
         while(_loc2_ <= _loc6_)
         {
            _loc7_ = _loc2_.toString();
            if(!_loc5_.getCache[_loc7_])
            {
               _loc8_ = DCUtils.find(_loc5_.rows,"id",_loc7_);
               if(!_loc8_)
               {
                  LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc5_.name + "\'",_loc5_,3);
               }
               _loc5_.getCache[_loc7_] = _loc8_;
            }
            _loc3_ = _loc5_.getCache[_loc7_];
            if(_loc3_)
            {
               if(!_loc3_.getCache["Score"])
               {
                  _loc3_.getCache["Score"] = DCUtils.find(_loc3_.getFields(),"name","Score");
               }
               _loc4_ = _loc3_.getCache["Score"];
               if(_loc4_)
               {
                  _loc9_ = int(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
                  if(_loc9_ > param1)
                  {
                     return _loc3_;
                  }
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function expNeededForNextLevel(param1:int) : int
      {
         var _loc3_:Field = null;
         var _loc2_:Row = findNextLevel(param1);
         if(_loc2_)
         {
            if(!_loc2_.getCache["Score"])
            {
               _loc2_.getCache["Score"] = DCUtils.find(_loc2_.getFields(),"name","Score");
            }
            _loc3_ = _loc2_.getCache["Score"];
            return !!_loc3_ ? int(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) - param1 : -1;
         }
         return -1;
      }
      
      public static function findHighestLevel() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:int = -2147483648;
         var _loc2_:Table = getTable();
         var _loc3_:* = _loc2_;
         for each(_loc4_ in _loc3_._rows)
         {
            _loc1_ = Math.max(_loc1_,parseInt(_loc4_.id));
         }
         return _loc1_;
      }
      
      private static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!table)
         {
            _loc1_ = "Experience";
            table = ProjectManager.findTable(_loc1_);
         }
         return table;
      }
   }
}

