package com.dchoc.gameobjects.stats
{
   import com.dchoc.utils.LogUtils;
   
   public class StatTypes
   {
      
      public static const GROUP_BASE:String = "Group_Base";
      
      public static const GROUP_ITEM:String = "Group_Item";
      
      public static const GROUP_BOOSTER:String = "Group_Booster";
      
      public static const GROUP_EMOTICONS:String = "Group_Emoticons";
      
      public static const GROUP_TEMP:String = "Group_Temp";
      
      public static const TYPE_NORMAL:String = "Normal";
      
      public static const AFFECTS_ALL:String = "All";
      
      public static const ADD:String = "Add";
      
      public static const MULTIPLY:String = "Multiply";
      
      public static const CALCULATE_ALL:String = "Calculate_All";
      
      public static const SORT_ORDER:Array = ["Group_Base","Group_Item","Group_Booster","Group_Emoticons","Group_Temp"];
       
      
      public function StatTypes()
      {
         super();
      }
      
      public static function getStatGroupByType(type:String) : String
      {
         switch(type)
         {
            case "Weapon":
               return "Group_Base";
            case "Clothing":
            case "Trophy":
               break;
            case "ClothingSet":
               break;
            case "Status":
            case "Booster":
               return "Group_Booster";
            case "Emoticon":
               return "Group_Emoticons";
            default:
               LogUtils.log("No defined type name: " + type + " check typing, so using GROUP_BASE","StatTypes",2,"Stats",false,false);
               return "Group_Base";
         }
         return "Group_Item";
      }
   }
}
