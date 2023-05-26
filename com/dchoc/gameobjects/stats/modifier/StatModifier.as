package com.dchoc.gameobjects.stats.modifier
{
   import com.dchoc.utils.LogUtils;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class StatModifier
   {
       
      
      private var id:String;
      
      private var group:String;
      
      private var type:String;
      
      public var affects:String;
      
      public var value:Number;
      
      private var priority:int;
      
      public function StatModifier(id:String, value:Number, priority:int, group:String = "Group_Base", type:String = "Normal", affects:String = "All")
      {
         super();
         this.id = id;
         this.group = group;
         this.type = type;
         this.value = value;
         this.priority = priority;
         this.affects = affects;
      }
      
      public function clone() : StatModifier
      {
         var _loc2_:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
         var _loc1_:StatModifier = new _loc2_(id,value);
         _loc1_.priority = priority;
         _loc1_.group = group;
         _loc1_.type = type;
         _loc1_.affects = affects;
         return _loc1_;
      }
      
      public function modify(value:Number = 0) : Number
      {
         LogUtils.log("Override method modify() in extending class, otherwise it will do nothing.",this,3,"Stats",false,true,true);
         return this.value;
      }
      
      public function getId() : String
      {
         return id;
      }
      
      public function setId(id:String) : void
      {
         this.id = id;
      }
      
      public function getPriority() : Number
      {
         return priority;
      }
      
      public function setPriority(value:int) : void
      {
         this.priority = value;
      }
      
      public function getGroup() : String
      {
         return group;
      }
      
      public function setGroup(value:String) : void
      {
         group = value;
      }
      
      public function getType() : String
      {
         return type;
      }
      
      public function setType(value:String) : void
      {
         type = value;
      }
      
      public function toString() : String
      {
         return "[Id: " + id + ", Value: " + value + ", Group: " + group + ", Type: " + type + ", Affects: " + affects + "]";
      }
      
      public function dispose() : void
      {
      }
   }
}
