package com.dchoc.gameobjects.stats.modifier
{
   public class StatAdd extends StatModifier
   {
      public function StatAdd(param1:String, param2:Number, param3:String = "Group_Base", param4:String = "Normal", param5:String = "All")
      {
         super(param1,param2,5,param3,param4,param5);
      }
      
      override public function modify(param1:Number = 0) : Number
      {
         return param1 + value;
      }
      
      override public function toString() : String
      {
         return "[Id: " + getId() + ", Addvalue: " + value + ", Group: " + getGroup() + ", Type: " + getType() + ", Affects: " + affects + "]";
      }
   }
}

