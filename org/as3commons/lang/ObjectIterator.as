package org.as3commons.lang
{
   internal final class ObjectIterator implements IIterator
   {
      private static var descriptions:Object = {};
      
      private var index:int;
      
      private var keys:Object;
      
      private var target:Object;
      
      private var _targetClassName:String;
      
      public function ObjectIterator(param1:Object, param2:Object)
      {
         super();
         if(param2 is XMLList || param2 is Array)
         {
            this.target = param1;
            this.keys = param2;
            this.index = 0;
            return;
         }
         throw new IllegalArgumentError("Argument \'keys\' must be of one of the following types: [Array, XMLList]");
      }
      
      public static function getDescription(param1:String) : XMLList
      {
         return descriptions[param1];
      }
      
      public static function setDescription(param1:String, param2:XMLList) : void
      {
         descriptions[param1] = param2;
      }
      
      public function get targetClassName() : String
      {
         if(this._targetClassName == null)
         {
            this._targetClassName = ObjectUtils.getFullyQualifiedClassName(this.target);
         }
         return this._targetClassName;
      }
      
      public function first() : void
      {
         this.index = 0;
      }
      
      public function last() : void
      {
         this.index = this.keys is Array ? int(this.keys.length) : int(this.keys.length());
      }
      
      public function next() : Object
      {
         var _loc1_:String = this.keys[this.index];
         ++this.index;
         if(_loc1_ == null)
         {
            return false;
         }
         return this.target[_loc1_];
      }
   }
}

