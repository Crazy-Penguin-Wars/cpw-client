package com.dchoc.utils
{
   import com.dchoc.projectdata.*;
   
   public class TextUtils
   {
      public function TextUtils()
      {
         super();
      }
      
      public static function getShortTimeTextFromSeconds(param1:int) : String
      {
         var _loc2_:Time = new Time(param1);
         if(_loc2_.days > 0)
         {
            return _loc2_.days + ":" + _loc2_.getPaddedHours() + ":" + _loc2_.getPaddedMinutes() + ":" + _loc2_.getPaddedSeconds();
         }
         if(_loc2_.hours > 0)
         {
            return _loc2_.hours + ":" + _loc2_.getPaddedMinutes() + ":" + _loc2_.getPaddedSeconds();
         }
         if(_loc2_.minutes > 0)
         {
            return _loc2_.minutes + ":" + _loc2_.getPaddedSeconds();
         }
         return _loc2_.seconds.toString();
      }
      
      public static function getTournamentTimeTextFromSeconds(param1:int) : String
      {
         var _loc2_:Time = new Time(param1);
         return ProjectManager.getText("TOURNAMENT_DAY",[_loc2_.days]) + " " + ProjectManager.getText("TOURNAMENT_HOUR",[_loc2_.hours]) + " " + ProjectManager.getText("TOURNAMENT_MIN",[_loc2_.minutes]) + " " + ProjectManager.getText("TOURNAMENT_SEC",[_loc2_.seconds]);
      }
      
      public static function getBiggestTimeUnitTextFromSeconds(param1:int) : String
      {
         var _loc2_:Time = new Time(param1);
         if(_loc2_.days > 0)
         {
            return ProjectManager.getText("TID_TIME_DAYS",[_loc2_.days.toString()]);
         }
         if(_loc2_.hours > 0)
         {
            return ProjectManager.getText("TID_TIME_HOURS",[_loc2_.hours.toString()]);
         }
         if(_loc2_.minutes > 0)
         {
            return ProjectManager.getText("TID_TIME_MINUTES",[_loc2_.minutes.toString()]);
         }
         return ProjectManager.getText("TID_TIME_SECONDS",[_loc2_.seconds.toString()]);
      }
      
      public static function getTimeTextFromSeconds(param1:int) : String
      {
         var _loc2_:Time = new Time(param1);
         return getTimeText(_loc2_.days,_loc2_.hours,_loc2_.minutes,_loc2_.seconds);
      }
      
      public static function getTimeTextFromMinutes(param1:int) : String
      {
         var _loc2_:Time = new Time(param1 * 60);
         return getTimeText(_loc2_.days,_loc2_.hours,_loc2_.minutes,_loc2_.seconds);
      }
      
      public static function getTimeTextFromObject(param1:Object) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1.Days)
         {
            _loc2_ = int(param1.Days);
         }
         if(param1.Hours)
         {
            _loc3_ = int(param1.Hours);
         }
         if(param1.Minutes)
         {
            _loc4_ = int(param1.Minutes);
         }
         if(param1.Seconds)
         {
            _loc5_ = int(param1.Seconds);
         }
         return getTimeText(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      public static function getTimeText(param1:int, param2:int, param3:int, param4:int = 0) : String
      {
         var _loc5_:Array = [];
         var _loc6_:* = "TID_TIME";
         if(param1 != 0)
         {
            _loc6_ += "_DAYS";
            _loc5_.push(param1.toString());
         }
         if(param2 != 0)
         {
            _loc6_ += "_HOURS";
            _loc5_.push(param2.toString());
         }
         if(param3 != 0)
         {
            _loc6_ += "_MINUTES";
            _loc5_.push(param3.toString());
         }
         if(param4 != 0)
         {
            _loc6_ += "_SECONDS";
            _loc5_.push(param4.toString());
         }
         if(_loc6_ == "TID_TIME")
         {
            return "";
         }
         return ProjectManager.getText(_loc6_,_loc5_);
      }
   }
}

class Time
{
   public var days:int;
   
   public var hours:int;
   
   public var minutes:int;
   
   public var seconds:int;
   
   public function Time(param1:int)
   {
      super();
      if(param1 < 0)
      {
         param1 = 0;
      }
      this.seconds = param1;
      this.days = this.seconds / 86400;
      this.seconds -= this.days * 60 * 60 * 24;
      this.hours = this.seconds / 3600;
      this.seconds -= this.hours * 60 * 60;
      this.minutes = this.seconds / 60;
      this.seconds -= this.minutes * 60;
   }
   
   public function getPaddedDays() : String
   {
      return this.days > 9 ? this.days.toString() : "0" + this.days;
   }
   
   public function getPaddedHours() : String
   {
      return this.hours > 9 ? this.hours.toString() : "0" + this.hours;
   }
   
   public function getPaddedMinutes() : String
   {
      return this.minutes > 9 ? this.minutes.toString() : "0" + this.minutes;
   }
   
   public function getPaddedSeconds() : String
   {
      return this.seconds > 9 ? this.seconds.toString() : "0" + this.seconds;
   }
}
