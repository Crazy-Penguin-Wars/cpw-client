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
      
      public static function Has(categories:uint, theCategory:uint) : Boolean
      {
         return Boolean(categories & theCategory);
      }
      
      public static function Add(categoryName:String) : void
      {
         if(_numCategories == 15)
         {
            throw new Error("You can only have 15 categories.");
         }
         if(_categoryNames[categoryName])
         {
            return;
         }
         _categoryNames[categoryName] = _categoryIndexes[_numCategories];
         _allCategories |= _categoryIndexes[_numCategories];
         _numCategories++;
      }
      
      public static function Get(... args) : uint
      {
         var category:* = 0;
         var categories:uint = 0;
         for each(var name in args)
         {
            category = uint(_categoryNames[name]);
            if(category == 0)
            {
               trace("Warning: " + name + " category does not exist.");
            }
            else
            {
               categories |= _categoryNames[name];
            }
         }
         return categories;
      }
      
      public static function GetArray(args:Array) : uint
      {
         var category:* = 0;
         var categories:uint = 0;
         for each(var name in args)
         {
            category = uint(_categoryNames[name]);
            if(category == 0)
            {
               trace("Warning: " + name + " category does not exist.");
            }
            else
            {
               categories |= _categoryNames[name];
            }
         }
         return categories;
      }
      
      public static function GetAll() : uint
      {
         return _allCategories;
      }
      
      public static function GetAllExcept(... args) : uint
      {
         var category:* = 0;
         var categories:uint = _allCategories;
         for each(var name in args)
         {
            category = uint(_categoryNames[name]);
            if(category == 0)
            {
               trace("Warning: " + name + " category does not exist.");
            }
            else
            {
               categories &= ~int(_categoryNames[name]);
            }
         }
         return categories;
      }
      
      public static function GetNone() : uint
      {
         return 0;
      }
   }
}
