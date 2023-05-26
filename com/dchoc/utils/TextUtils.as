package com.dchoc.utils
{
   import com.dchoc.projectdata.ProjectManager;
   
   public class TextUtils
   {
       
      
      public function TextUtils()
      {
         super();
      }
      
      public static function getShortTimeTextFromSeconds(seconds:int) : String
      {
         var _loc2_:Time = new Time(seconds);
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
      
      public static function getTournamentTimeTextFromSeconds(seconds:int) : String
      {
         var _loc2_:Time = new Time(seconds);
         return ProjectManager.getText("TOURNAMENT_DAY",[_loc2_.days]) + " " + ProjectManager.getText("TOURNAMENT_HOUR",[_loc2_.hours]) + " " + ProjectManager.getText("TOURNAMENT_MIN",[_loc2_.minutes]) + " " + ProjectManager.getText("TOURNAMENT_SEC",[_loc2_.seconds]);
      }
      
      public static function getBiggestTimeUnitTextFromSeconds(seconds:int) : String
      {
         var _loc2_:Time = new Time(seconds);
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
      
      public static function getTimeTextFromSeconds(seconds:int) : String
      {
         var _loc2_:Time = new Time(seconds);
         return getTimeText(_loc2_.days,_loc2_.hours,_loc2_.minutes,_loc2_.seconds);
      }
      
      public static function getTimeTextFromMinutes(minutes:int) : String
      {
         var _loc2_:Time = new Time(minutes * 60);
         return getTimeText(_loc2_.days,_loc2_.hours,_loc2_.minutes,_loc2_.seconds);
      }
      
      public static function getTimeTextFromObject(workObject:Object) : String
      {
         var days:int = 0;
         var hours:int = 0;
         var minutes:int = 0;
         var seconds:int = 0;
         if(workObject.Days)
         {
            days = int(workObject.Days);
         }
         if(workObject.Hours)
         {
            hours = int(workObject.Hours);
         }
         if(workObject.Minutes)
         {
            minutes = int(workObject.Minutes);
         }
         if(workObject.Seconds)
         {
            seconds = int(workObject.Seconds);
         }
         return getTimeText(days,hours,minutes,seconds);
      }
      
      public static function getTimeText(days:int, hours:int, minutes:int, seconds:int = 0) : String
      {
         var _loc6_:Array = [];
         var tid:String = "TID_TIME";
         if(days != 0)
         {
            tid += "_DAYS";
            _loc6_.push(days.toString());
         }
         if(hours != 0)
         {
            tid += "_HOURS";
            _loc6_.push(hours.toString());
         }
         if(minutes != 0)
         {
            tid += "_MINUTES";
            _loc6_.push(minutes.toString());
         }
         if(seconds != 0)
         {
            tid += "_SECONDS";
            _loc6_.push(seconds.toString());
         }
         if(tid == "TID_TIME")
         {
            return "";
         }
         return ProjectManager.getText(tid,_loc6_);
      }
   }
}

class Time
{
    
   
   public var days:int;
   
   public var hours:int;
   
   public var minutes:int;
   
   public var seconds:int;
   
   public function Time(timeInSeconds:int)
   {
      super();
      if(timeInSeconds < 0)
      {
         timeInSeconds = 0;
      }
      seconds = timeInSeconds;
      days = Number(seconds) / 86400;
      seconds -= Number(days) * 60 * 60 * 24;
      hours = Number(seconds) / 3600;
      seconds -= Number(hours) * 60 * 60;
      minutes = Number(seconds) / 60;
      seconds -= Number(minutes) * 60;
   }
   
   public function getPaddedDays() : String
   {
      return days > 9 ? days.toString() : "0" + days;
   }
   
   public function getPaddedHours() : String
   {
      return hours > 9 ? hours.toString() : "0" + hours;
   }
   
   public function getPaddedMinutes() : String
   {
      return minutes > 9 ? minutes.toString() : "0" + minutes;
   }
   
   public function getPaddedSeconds() : String
   {
      return seconds > 9 ? seconds.toString() : "0" + seconds;
   }
}
