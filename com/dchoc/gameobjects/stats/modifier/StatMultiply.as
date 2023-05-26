package com.dchoc.gameobjects.stats.modifier
{
   import avmplus.getQualifiedClassName;
   import flash.utils.getDefinitionByName;
   
   public class StatMultiply extends StatModifier
   {
       
      
      public function StatMultiply(id:String, value:Number, group:String, type:String = "Normal", affects:String = "All")
      {
         super(id,value,10,group,type,affects);
      }
      
      override public function clone() : StatModifier
      {
         var _loc2_:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
         var _loc1_:StatModifier = new _loc2_(getId(),value,getGroup());
         _loc1_.setPriority(getPriority());
         _loc1_.setType(getType());
         _loc1_.affects = affects;
         return _loc1_;
      }
      
      override public function modify(inputValue:Number = 1) : Number
      {
         if(inputValue == 0)
         {
            inputValue = 1;
         }
         return inputValue * value;
      }
      
      override public function toString() : String
      {
         return "[Id: " + getId() + ", Multipliervalue: " + value + ", Group: " + getGroup() + ", Type: " + getType() + ", Affects: " + affects + "]";
      }
   }
}
