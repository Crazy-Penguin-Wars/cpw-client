package com.dchoc.utils
{
   public final class Random
   {
      private static var _instance:Random;
      
      private var _seed:uint;
      
      private var _currentSeed:uint;
      
      private var debugMode:Boolean;
      
      private var _name:String;
      
      public function Random(param1:uint = 1, param2:String = "Random", param3:Boolean = false)
      {
         super();
         this._seed = this._currentSeed = param1;
         this._name = param2;
         this.debugMode = param3;
      }
      
      public static function getInstance() : Random
      {
         if(!_instance)
         {
            _instance = new Random();
         }
         return _instance;
      }
      
      public static function getSeed() : uint
      {
         return getInstance().getSeed();
      }
      
      public static function setSeed(param1:uint) : void
      {
         getInstance().setSeed(param1);
      }
      
      public static function getCurrentSeed() : uint
      {
         return getInstance().getCurrentSeed();
      }
      
      public static function random() : Number
      {
         return getInstance().random();
      }
      
      public static function float(param1:Number, param2:Number = NaN) : Number
      {
         return getInstance().float(param1,param2);
      }
      
      public static function boolean(param1:Number = 0.5) : Boolean
      {
         return getInstance().boolean(param1);
      }
      
      public static function sign(param1:Number = 0.5) : int
      {
         return getInstance().sign(param1);
      }
      
      public static function bit(param1:Number = 0.5) : int
      {
         return getInstance().bit(param1);
      }
      
      public static function integer(param1:Number, param2:Number = NaN) : int
      {
         return getInstance().integer(param1,param2);
      }
      
      public static function reset() : void
      {
         getInstance().reset();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function getSeed() : uint
      {
         return this._seed;
      }
      
      public function setSeed(param1:uint) : void
      {
         this._seed = this._currentSeed = param1;
      }
      
      public function getCurrentSeed() : uint
      {
         return this._currentSeed;
      }
      
      public function random() : Number
      {
         var _loc1_:Number = (this._currentSeed = this._currentSeed * 16807 % 2147483647) / 2147483647 + 2.33e-10;
         if(this.debugMode)
         {
            LogUtils.log("Random (" + this._name + ") next: " + _loc1_,this,1,"Random",false,false,false);
         }
         return _loc1_;
      }
      
      public function float(param1:Number, param2:Number = NaN) : Number
      {
         if(isNaN(param2))
         {
            param2 = param1;
            param1 = 0;
         }
         return this.random() * (param2 - param1) + param1;
      }
      
      public function boolean(param1:Number = 0.5) : Boolean
      {
         return this.random() < param1;
      }
      
      public function sign(param1:Number = 0.5) : int
      {
         return this.random() < param1 ? 1 : -1;
      }
      
      public function bit(param1:Number = 0.5) : int
      {
         return this.random() < param1 ? 1 : 0;
      }
      
      public function integer(param1:Number, param2:Number = NaN) : int
      {
         if(isNaN(param2))
         {
            param2 = param1;
            param1 = 0;
         }
         return Math.floor(this.float(param1,param2));
      }
      
      public function reset() : void
      {
         this._seed = this._currentSeed;
      }
   }
}

