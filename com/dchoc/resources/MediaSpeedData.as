package com.dchoc.resources
{
   public class MediaSpeedData
   {
       
      
      private var _file:String;
      
      private var _startTime:int;
      
      private var _endTime:int = -1;
      
      private var _size:int = -1;
      
      public function MediaSpeedData(file:String, startTime:int)
      {
         super();
         _file = file;
         _startTime = startTime;
      }
      
      public function get finished() : Boolean
      {
         return _endTime != -1 && _size != -1;
      }
      
      public function set endTime(value:int) : void
      {
         _endTime = value;
      }
      
      public function set size(value:int) : void
      {
         _size = value;
      }
      
      public function get speed() : Number
      {
         return _size / 1024 / duration;
      }
      
      public function get duration() : Number
      {
         assert();
         return (_endTime - _startTime) * 0.001;
      }
      
      public function get file() : String
      {
         return _file;
      }
      
      private function assert() : void
      {
         if(_endTime == -1)
         {
            throw new Error("End time hasn\'t been set. file: " + _file);
         }
         if(_size == -1 || _size == 0)
         {
            throw new Error("Size hasn\'t been set. file: " + _file);
         }
      }
   }
}
