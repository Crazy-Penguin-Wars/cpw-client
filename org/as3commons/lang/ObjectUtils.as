package org.as3commons.lang
{
   import flash.net.*;
   import flash.utils.*;
   
   public final class ObjectUtils
   {
      public static const DOT:String = ".";
      
      public static const NUMBER_CLASSNAME:String = "number";
      
      public static const STRING_FIELD_NAME:String = "string";
      
      public static const BOOLEAN_FIELD_NAME:String = "boolean";
      
      public static const OBJECT_FIELD_NAME:String = "object";
      
      public static const VARIABLE_ELEMENT_NAME:String = "variable";
      
      public function ObjectUtils()
      {
         super();
      }
      
      public static function isSimple(param1:Object) : Boolean
      {
         switch(typeof param1)
         {
            case NUMBER_CLASSNAME:
            case STRING_FIELD_NAME:
            case BOOLEAN_FIELD_NAME:
               return true;
            case OBJECT_FIELD_NAME:
               return param1 is Date || param1 is Array;
            default:
               return false;
         }
      }
      
      public static function toDictionary(param1:Object) : Dictionary
      {
         var _loc2_:* = undefined;
         var _loc3_:Dictionary = new Dictionary();
         for each(_loc2_ in getKeys(param1))
         {
            _loc3_[_loc2_] = param1[_loc2_];
         }
         return _loc3_;
      }
      
      public static function getKeys(param1:Object) : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:Array = [];
         for(_loc2_ in param1)
         {
            _loc3_.push(_loc2_);
         }
         return _loc3_;
      }
      
      public static function getNumProperties(param1:Object) : int
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         for(_loc2_ in param1)
         {
            _loc3_++;
         }
         return _loc3_;
      }
      
      public static function getProperties(param1:Object) : Array
      {
         var _loc2_:Object = null;
         var _loc3_:Array = [];
         for each(_loc2_ in param1)
         {
            _loc3_.push(_loc2_);
         }
         return _loc3_;
      }
      
      public static function clone(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function toInstance(param1:Object, param2:Class) : *
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.objectEncoding = ObjectEncoding.AMF0;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.objectEncoding = ObjectEncoding.AMF0;
         _loc4_.writeObject(param1);
         var _loc5_:XML = describeType(param2);
         var _loc6_:String = _loc5_.@name.toString().replace(/::/,".");
         registerClassAlias(_loc6_,param2);
         var _loc7_:int = _loc6_.length;
         _loc3_.writeByte(16);
         _loc3_.writeUTF(_loc6_);
         _loc3_.writeBytes(_loc4_,1);
         _loc3_.position = 0;
         return _loc3_.readObject();
      }
      
      public static function isExplicitInstanceOf(param1:Object, param2:Class) : Boolean
      {
         var _loc3_:Class = ClassUtils.forInstance(param1);
         return _loc3_ === param2;
      }
      
      public static function getClassName(param1:Object) : String
      {
         return ClassUtils.getName(ClassUtils.forInstance(param1));
      }
      
      public static function getFullyQualifiedClassName(param1:Object, param2:Boolean = false) : String
      {
         return ClassUtils.getFullyQualifiedName(ClassUtils.forInstance(param1),param2);
      }
      
      public static function getIterator(param1:Object) : IIterator
      {
         var instance:Object = param1;
         var keys:XMLList = null;
         var description:XML = null;
         var name:String = getFullyQualifiedClassName(instance);
         if((keys = ObjectIterator.getDescription(name)) == null)
         {
            description = describeType(instance);
            keys = description.descendants(VARIABLE_ELEMENT_NAME).@name + description.descendants("accessor").(@access == "readwrite").@name;
            ObjectIterator.setDescription(name,keys);
         }
         return new ObjectIterator(instance,keys);
      }
      
      public static function resolvePropertyChain(param1:String, param2:Object) : *
      {
         var _loc3_:String = null;
         var _loc4_:Array = param1.split(DOT);
         var _loc5_:String = String(_loc4_.pop());
         for each(_loc3_ in _loc4_)
         {
            param2 = param2[_loc3_];
         }
         return param2[_loc5_];
      }
      
      public static function merge(param1:Object, param2:Object) : Object
      {
         var _loc3_:String = null;
         var _loc4_:Object = {};
         for(_loc3_ in param2)
         {
            _loc4_[_loc3_] = param2[_loc3_];
         }
         for(_loc3_ in param1)
         {
            _loc4_[_loc3_] = param1[_loc3_];
         }
         return _loc4_;
      }
   }
}

