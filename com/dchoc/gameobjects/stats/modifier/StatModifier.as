package com.dchoc.gameobjects.stats.modifier
{
   import com.dchoc.utils.*;
   import flash.utils.*;
   
   public class StatModifier
   {
      private var id:String;
      
      private var group:String;
      
      private var type:String;
      
      public var affects:String;
      
      public var value:Number;
      
      private var priority:int;
      
      public function StatModifier(param1:String, param2:Number, param3:int, param4:String = "Group_Base", param5:String = "Normal", param6:String = "All")
      {
         super();
         this.id = param1;
         this.group = param4;
         this.type = param5;
         this.value = param2;
         this.priority = param3;
         this.affects = param6;
      }
      
      public function clone() : StatModifier
      {
         var _loc1_:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
         var _loc2_:StatModifier = new _loc1_(this.id,this.value);
         _loc2_.priority = this.priority;
         _loc2_.group = this.group;
         _loc2_.type = this.type;
         _loc2_.affects = this.affects;
         return _loc2_;
      }
      
      public function modify(param1:Number = 0) : Number
      {
         LogUtils.log("Override method modify() in extending class, otherwise it will do nothing.",this,3,"Stats",false,true,true);
         return this.value;
      }
      
      public function getId() : String
      {
         return this.id;
      }
      
      public function setId(param1:String) : void
      {
         this.id = param1;
      }
      
      public function getPriority() : Number
      {
         return this.priority;
      }
      
      public function setPriority(param1:int) : void
      {
         this.priority = param1;
      }
      
      public function getGroup() : String
      {
         return this.group;
      }
      
      public function setGroup(param1:String) : void
      {
         this.group = param1;
      }
      
      public function getType() : String
      {
         return this.type;
      }
      
      public function setType(param1:String) : void
      {
         this.type = param1;
      }
      
      public function toString() : String
      {
         return "[Id: " + this.id + ", Value: " + this.value + ", Group: " + this.group + ", Type: " + this.type + ", Affects: " + this.affects + "]";
      }
      
      public function dispose() : void
      {
      }
   }
}

