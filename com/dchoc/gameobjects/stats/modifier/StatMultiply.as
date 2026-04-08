package com.dchoc.gameobjects.stats.modifier
{
   import avmplus.*;
   import flash.utils.*;
   
   public class StatMultiply extends StatModifier
   {
      public function StatMultiply(param1:String, param2:Number, param3:String, param4:String = "Normal", param5:String = "All")
      {
         super(param1,param2,10,param3,param4,param5);
      }
      
      override public function clone() : StatModifier
      {
         var _loc1_:Class = getDefinitionByName(flash.utils.getQualifiedClassName(this)) as Class;
         var _loc2_:StatModifier = new _loc1_(getId(),value,getGroup());
         _loc2_.setPriority(getPriority());
         _loc2_.setType(getType());
         _loc2_.affects = affects;
         return _loc2_;
      }
      
      override public function modify(param1:Number = 1) : Number
      {
         if(param1 == 0)
         {
            param1 = 1;
         }
         return param1 * value;
      }
      
      override public function toString() : String
      {
         return "[Id: " + getId() + ", Multipliervalue: " + value + ", Group: " + getGroup() + ", Type: " + getType() + ", Affects: " + affects + "]";
      }
   }
}

