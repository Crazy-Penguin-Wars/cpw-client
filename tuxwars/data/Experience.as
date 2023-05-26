package tuxwars.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class Experience
   {
      
      private static const TABLE_NAME:String = "Experience";
      
      private static const SCORE:String = "Score";
      
      private static const REWARD_CASH:String = "RewardCash";
      
      private static const REWARD_COINS:String = "RewardCoins";
      
      private static const REWARD_ITEMS:String = "RewardItems";
      
      private static const REWARD_ITEMS_AMOUNT:String = "RewardItemsAmount";
      
      private static const REWARD_DAYS_OF_VIP:String = "RewardDaysOfVip";
      
      private static var table:Table;
       
      
      public function Experience()
      {
         super();
         throw new Error("Experience is a static class!");
      }
      
      public static function getLevel(score:int) : int
      {
         var _loc2_:Row = findNextLevel(score);
         return !!_loc2_ ? parseInt(_loc2_.id) - 1 : -1;
      }
      
      public static function getScore(level:int) : int
      {
         var _loc6_:* = level.toString();
         var _loc3_:* = getTable();
         if(!_loc3_._cache[_loc6_])
         {
            var _loc7_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc6_);
            if(!_loc7_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc6_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc6_] = _loc7_;
         }
         var _loc2_:Row = _loc3_._cache[_loc6_];
         if(_loc2_)
         {
            var _loc4_:* = _loc2_;
            if(!_loc4_._cache["Score"])
            {
               _loc4_._cache["Score"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","Score");
            }
            var _loc5_:* = _loc4_._cache["Score"];
            §§push(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value);
         }
         else
         {
            §§push(-1);
         }
         return §§pop();
      }
      
      public static function getRewardCoins(level:int) : int
      {
         var _loc7_:* = level.toString();
         var _loc4_:* = getTable();
         if(!_loc4_._cache[_loc7_])
         {
            var _loc8_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc7_);
            if(!_loc8_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc7_] = _loc8_;
         }
         var _loc3_:Row = _loc4_._cache[_loc7_];
         if(_loc3_)
         {
            var _loc5_:* = _loc3_;
            if(!_loc5_._cache["RewardCoins"])
            {
               _loc5_._cache["RewardCoins"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","RewardCoins");
            }
            §§push(_loc5_._cache["RewardCoins"]);
         }
         else
         {
            §§push(null);
         }
         var _loc2_:Field = §§pop();
         var _loc6_:*;
         return !!_loc2_ ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 0;
      }
      
      public static function getRewardCash(level:int) : int
      {
         var _loc7_:* = level.toString();
         var _loc4_:* = getTable();
         if(!_loc4_._cache[_loc7_])
         {
            var _loc8_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc7_);
            if(!_loc8_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc7_] = _loc8_;
         }
         var _loc3_:Row = _loc4_._cache[_loc7_];
         if(_loc3_)
         {
            var _loc5_:* = _loc3_;
            if(!_loc5_._cache["RewardCash"])
            {
               _loc5_._cache["RewardCash"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","RewardCash");
            }
            §§push(_loc5_._cache["RewardCash"]);
         }
         else
         {
            §§push(null);
         }
         var _loc2_:Field = §§pop();
         var _loc6_:*;
         return !!_loc2_ ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : 0;
      }
      
      public static function getRewardItems(level:int) : Array
      {
         var _loc7_:* = level.toString();
         var _loc4_:* = getTable();
         if(!_loc4_._cache[_loc7_])
         {
            var _loc8_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc7_);
            if(!_loc8_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc7_] = _loc8_;
         }
         var _loc3_:Row = _loc4_._cache[_loc7_];
         if(_loc3_)
         {
            var _loc5_:* = _loc3_;
            if(!_loc5_._cache["RewardItems"])
            {
               _loc5_._cache["RewardItems"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","RewardItems");
            }
            §§push(_loc5_._cache["RewardItems"]);
         }
         else
         {
            §§push(null);
         }
         var _loc2_:Field = §§pop();
         var _loc6_:*;
         return !!_loc2_ ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : null;
      }
      
      public static function getRewardItemsAmount(level:int) : Array
      {
         var _loc7_:* = level.toString();
         var _loc4_:* = getTable();
         if(!_loc4_._cache[_loc7_])
         {
            var _loc8_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc7_);
            if(!_loc8_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc7_] = _loc8_;
         }
         var _loc3_:Row = _loc4_._cache[_loc7_];
         if(_loc3_)
         {
            var _loc5_:* = _loc3_;
            if(!_loc5_._cache["RewardItemsAmount"])
            {
               _loc5_._cache["RewardItemsAmount"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","RewardItemsAmount");
            }
            §§push(_loc5_._cache["RewardItemsAmount"]);
         }
         else
         {
            §§push(null);
         }
         var _loc2_:Field = §§pop();
         var _loc6_:*;
         return !!_loc2_ ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : null;
      }
      
      public static function getRewardDaysOfVip(level:int) : int
      {
         var _loc7_:* = level.toString();
         var _loc4_:* = getTable();
         if(!_loc4_._cache[_loc7_])
         {
            var _loc8_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc7_);
            if(!_loc8_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc7_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc7_] = _loc8_;
         }
         var _loc3_:Row = _loc4_._cache[_loc7_];
         if(_loc3_)
         {
            var _loc5_:* = _loc3_;
            if(!_loc5_._cache["RewardDaysOfVip"])
            {
               _loc5_._cache["RewardDaysOfVip"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","RewardDaysOfVip");
            }
            §§push(_loc5_._cache["RewardDaysOfVip"]);
         }
         else
         {
            §§push(null);
         }
         var _loc2_:Field = §§pop();
         var _loc6_:*;
         return !!_loc2_ ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : -1;
      }
      
      public static function findNextLevel(score:int) : Row
      {
         var i:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:Table = getTable();
         var _loc7_:* = _loc3_;
         var _loc4_:int = _loc7_._rows.length;
         for(i = 1; i <= _loc4_; )
         {
            var _loc11_:* = i.toString();
            var _loc8_:* = _loc3_;
            if(!_loc8_._cache[_loc11_])
            {
               var _loc12_:Row = com.dchoc.utils.DCUtils.find(_loc8_.rows,"id",_loc11_);
               if(!_loc12_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc11_ + "\' was found in table: \'" + _loc8_.name + "\'",_loc8_,3);
               }
               _loc8_._cache[_loc11_] = _loc12_;
            }
            _loc5_ = _loc8_._cache[_loc11_];
            if(_loc5_)
            {
               var _loc9_:* = _loc5_;
               if(!_loc9_._cache["Score"])
               {
                  _loc9_._cache["Score"] = com.dchoc.utils.DCUtils.find(_loc9_._fields,"name","Score");
               }
               §§push(_loc9_._cache["Score"]);
            }
            else
            {
               §§push(null);
            }
            _loc2_ = §§pop();
            if(_loc2_ && (_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value) > score)
            {
               return _loc5_;
            }
            i++;
         }
         return null;
      }
      
      public static function expNeededForNextLevel(curScore:int) : int
      {
         var _loc2_:Row = findNextLevel(curScore);
         if(_loc2_)
         {
            var _loc3_:* = _loc2_;
            §§push(parseInt);
            §§push(global);
            if(!_loc3_._cache["Score"])
            {
               _loc3_._cache["Score"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Score");
            }
            var _loc4_:* = _loc3_._cache["Score"];
            §§push(§§pop()(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) - curScore);
         }
         else
         {
            §§push(-1);
         }
         return §§pop();
      }
      
      public static function findHighestLevel() : int
      {
         var level:int = -2147483648;
         var _loc2_:Table = getTable();
         var _loc4_:* = _loc2_;
         for each(var row in _loc4_._rows)
         {
            level = Math.max(level,parseInt(row.id));
         }
         return level;
      }
      
      private static function getTable() : Table
      {
         if(!table)
         {
            var _loc1_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable("Experience");
         }
         return table;
      }
   }
}
