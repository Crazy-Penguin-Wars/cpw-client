package org.as3commons.lang
{
   internal final class ObjectIterator implements IIterator
   {
      
      private static var descriptions:Object = {};
       
      
      private var index:int;
      
      private var keys:Object;
      
      private var target:Object;
      
      private var _targetClassName:String;
      
      public function ObjectIterator(object:Object, keys:Object)
      {
         super();
         if(keys is XMLList || keys is Array)
         {
            this.target = object;
            this.keys = keys;
            this.index = 0;
            return;
         }
         throw new IllegalArgumentError("Argument \'keys\' must be of one of the following types: [Array, XMLList]");
      }
      
      public static function getDescription(name:String) : XMLList
      {
         return descriptions[name];
      }
      
      public static function setDescription(name:String, keys:XMLList) : void
      {
         descriptions[name] = keys;
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
         var key:String = this.keys[this.index];
         ++this.index;
         if(key == null)
         {
            return false;
         }
         return this.target[key];
      }
   }
}
