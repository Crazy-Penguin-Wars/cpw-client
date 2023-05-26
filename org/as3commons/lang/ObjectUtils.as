package org.as3commons.lang
{
   import flash.net.ObjectEncoding;
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
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
      
      public static function isSimple(object:Object) : Boolean
      {
         switch(typeof object)
         {
            case NUMBER_CLASSNAME:
            case STRING_FIELD_NAME:
            case BOOLEAN_FIELD_NAME:
               return true;
            case OBJECT_FIELD_NAME:
               return object is Date || object is Array;
            default:
               return false;
         }
      }
      
      public static function toDictionary(instance:Object) : Dictionary
      {
         var key:* = undefined;
         var result:Dictionary = new Dictionary();
         for each(key in getKeys(instance))
         {
            result[key] = instance[key];
         }
         return result;
      }
      
      public static function getKeys(object:Object) : Array
      {
         var k:* = undefined;
         var result:Array = [];
         for(k in object)
         {
            result.push(k);
         }
         return result;
      }
      
      public static function getNumProperties(object:Object) : int
      {
         var p:* = null;
         var result:int = 0;
         for(p in object)
         {
            result++;
         }
         return result;
      }
      
      public static function getProperties(object:Object) : Array
      {
         var p:Object = null;
         var result:Array = [];
         for each(p in object)
         {
            result.push(p);
         }
         return result;
      }
      
      public static function clone(object:Object) : *
      {
         var byteArray:ByteArray = new ByteArray();
         byteArray.writeObject(object);
         byteArray.position = 0;
         return byteArray.readObject();
      }
      
      public static function toInstance(object:Object, clazz:Class) : *
      {
         var bytes:ByteArray = new ByteArray();
         bytes.objectEncoding = ObjectEncoding.AMF0;
         var objBytes:ByteArray = new ByteArray();
         objBytes.objectEncoding = ObjectEncoding.AMF0;
         objBytes.writeObject(object);
         var typeInfo:XML = describeType(clazz);
         var fullyQualifiedName:String = typeInfo.@name.toString().replace(/::/,".");
         registerClassAlias(fullyQualifiedName,clazz);
         var len:int = fullyQualifiedName.length;
         bytes.writeByte(16);
         bytes.writeUTF(fullyQualifiedName);
         bytes.writeBytes(objBytes,1);
         bytes.position = 0;
         return bytes.readObject();
      }
      
      public static function isExplicitInstanceOf(object:Object, clazz:Class) : Boolean
      {
         var c:Class = ClassUtils.forInstance(object);
         return c === clazz;
      }
      
      public static function getClassName(object:Object) : String
      {
         return ClassUtils.getName(ClassUtils.forInstance(object));
      }
      
      public static function getFullyQualifiedClassName(object:Object, replaceColons:Boolean = false) : String
      {
         return ClassUtils.getFullyQualifiedName(ClassUtils.forInstance(object),replaceColons);
      }
      
      public static function getIterator(instance:Object) : IIterator
      {
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
      
      public static function resolvePropertyChain(chain:String, targetInstance:Object) : *
      {
         var propName:String = null;
         var propertyNames:Array = chain.split(DOT);
         var field:String = String(propertyNames.pop());
         for each(propName in propertyNames)
         {
            targetInstance = targetInstance[propName];
         }
         return targetInstance[field];
      }
      
      public static function merge(objectA:Object, objectB:Object) : Object
      {
         var prop:* = null;
         var result:Object = {};
         for(prop in objectB)
         {
            result[prop] = objectB[prop];
         }
         for(prop in objectA)
         {
            result[prop] = objectA[prop];
         }
         return result;
      }
   }
}
