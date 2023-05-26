package com.dchoc.utils
{
   public final class Random
   {
      
      private static var _instance:Random;
       
      
      private var _seed:uint;
      
      private var _currentSeed:uint;
      
      private var debugMode:Boolean;
      
      private var _name:String;
      
      public function Random(seed:uint = 1, name:String = "Random", debugMode:Boolean = false)
      {
         super();
         _seed = _currentSeed = seed;
         _name = name;
         this.debugMode = debugMode;
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
      
      public static function setSeed(value:uint) : void
      {
         getInstance().setSeed(value);
      }
      
      public static function getCurrentSeed() : uint
      {
         return getInstance().getCurrentSeed();
      }
      
      public static function random() : Number
      {
         return getInstance().random();
      }
      
      public static function float(min:Number, max:Number = NaN) : Number
      {
         return getInstance().float(min,max);
      }
      
      public static function boolean(chance:Number = 0.5) : Boolean
      {
         return getInstance().boolean(chance);
      }
      
      public static function sign(chance:Number = 0.5) : int
      {
         return getInstance().sign(chance);
      }
      
      public static function bit(chance:Number = 0.5) : int
      {
         return getInstance().bit(chance);
      }
      
      public static function integer(min:Number, max:Number = NaN) : int
      {
         return getInstance().integer(min,max);
      }
      
      public static function reset() : void
      {
         getInstance().reset();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function getSeed() : uint
      {
         return _seed;
      }
      
      public function setSeed(value:uint) : void
      {
         _seed = _currentSeed = value;
      }
      
      public function getCurrentSeed() : uint
      {
         return _currentSeed;
      }
      
      public function random() : Number
      {
         var _loc1_:Number = (_currentSeed = _currentSeed * 16807 % 2147483647) / 2147483647 + 2.33e-10;
         if(debugMode)
         {
            LogUtils.log("Random (" + _name + ") next: " + _loc1_,this,1,"Random",false,false,false);
         }
         return _loc1_;
      }
      
      public function float(min:Number, max:Number = NaN) : Number
      {
         if(isNaN(max))
         {
            max = min;
            min = 0;
         }
         return random() * (max - min) + min;
      }
      
      public function boolean(chance:Number = 0.5) : Boolean
      {
         return random() < chance;
      }
      
      public function sign(chance:Number = 0.5) : int
      {
         return random() < chance ? 1 : -1;
      }
      
      public function bit(chance:Number = 0.5) : int
      {
         return random() < chance ? 1 : 0;
      }
      
      public function integer(min:Number, max:Number = NaN) : int
      {
         if(isNaN(max))
         {
            max = min;
            min = 0;
         }
         return Math.floor(float(min,max));
      }
      
      public function reset() : void
      {
         _seed = _currentSeed;
      }
   }
}
