package com.dchoc.gameobjects.stats.modifier
{
   public class StatAdd extends StatModifier
   {
       
      
      public function StatAdd(id:String, value:Number, group:String = "Group_Base", type:String = "Normal", affects:String = "All")
      {
         super(id,value,5,group,type,affects);
      }
      
      override public function modify(inputValue:Number = 0) : Number
      {
         return inputValue + value;
      }
      
      override public function toString() : String
      {
         return "[Id: " + getId() + ", Addvalue: " + value + ", Group: " + getGroup() + ", Type: " + getType() + ", Affects: " + affects + "]";
      }
   }
}
