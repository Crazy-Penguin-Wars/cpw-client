package com.citrusengine.physics
{
   public class PhysicsCollisionCategories
   {
      private static var _allCategories:uint = 0;
      
      private static var _numCategories:uint = 0;
      
      private static var _categoryIndexes:Array = [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384];
      
      private static var _categoryNames:Object = {};
      
      public function PhysicsCollisionCategories()
      {
         super();
      }
      
      public static function Has(param1:uint, param2:uint) : Boolean
      {
         return Boolean(param1 & param2);
      }
      
      public static function Add(param1:String) : void
      {
         if(_numCategories == 15)
         {
            throw new Error("You can only have 15 categories.");
         }
         if(_categoryNames[param1])
         {
            return;
         }
         _categoryNames[param1] = _categoryIndexes[_numCategories];
         _allCategories |= _categoryIndexes[_numCategories];
         ++_numCategories;
      }
      
      public static function Get(... rest) : uint
      {
         var _loc4_:* = undefined;
         var _loc2_:* = 0;
         var _loc3_:uint = 0;
         for each(_loc4_ in rest)
         {
            _loc2_ = uint(_categoryNames[_loc4_]);
            if(_loc2_ == 0)
            {
               trace("Warning: " + _loc4_ + " category does not exist.");
            }
            else
            {
               _loc3_ |= _categoryNames[_loc4_];
            }
         }
         return _loc3_;
      }
      
      public static function GetArray(param1:Array) : uint
      {
         var _loc4_:* = undefined;
         var _loc2_:* = 0;
         var _loc3_:uint = 0;
         for each(_loc4_ in param1)
         {
            _loc2_ = uint(_categoryNames[_loc4_]);
            if(_loc2_ == 0)
            {
               trace("Warning: " + _loc4_ + " category does not exist.");
            }
            else
            {
               _loc3_ |= _categoryNames[_loc4_];
            }
         }
         return _loc3_;
      }
      
      public static function GetAll() : uint
      {
         return _allCategories;
      }
      
      public static function GetAllExcept(... rest) : uint
      {
         var _loc4_:* = undefined;
         var _loc2_:* = 0;
         var _loc3_:uint = uint(_allCategories);
         for each(_loc4_ in rest)
         {
            _loc2_ = uint(_categoryNames[_loc4_]);
            if(_loc2_ == 0)
            {
               trace("Warning: " + _loc4_ + " category does not exist.");
            }
            else
            {
               _loc3_ &= ~_categoryNames[_loc4_];
            }
         }
         return _loc3_;
      }
      
      public static function GetNone() : uint
      {
         return 0;
      }
   }
}

