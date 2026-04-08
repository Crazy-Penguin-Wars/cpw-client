package com.dchoc.resources
{
   public class MediaSpeedData
   {
      private var _file:String;
      
      private var _startTime:int;
      
      private var _endTime:int = -1;
      
      private var _size:int = -1;
      
      public function MediaSpeedData(param1:String, param2:int)
      {
         super();
         this._file = param1;
         this._startTime = param2;
      }
      
      public function get finished() : Boolean
      {
         return this._endTime != -1 && this._size != -1;
      }
      
      public function set endTime(param1:int) : void
      {
         this._endTime = param1;
      }
      
      public function set size(param1:int) : void
      {
         this._size = param1;
      }
      
      public function get speed() : Number
      {
         return this._size / 1024 / this.duration;
      }
      
      public function get duration() : Number
      {
         this.assert();
         return (this._endTime - this._startTime) * 0.001;
      }
      
      public function get file() : String
      {
         return this._file;
      }
      
      private function assert() : void
      {
         if(this._endTime == -1)
         {
            throw new Error("End time hasn\'t been set. file: " + this._file);
         }
         if(this._size == -1 || this._size == 0)
         {
            throw new Error("Size hasn\'t been set. file: " + this._file);
         }
      }
   }
}

