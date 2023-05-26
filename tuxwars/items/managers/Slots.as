package tuxwars.items.managers
{
   public class Slots
   {
      
      public static const HEAD:String = "Head";
      
      public static const TORSO:String = "Torso";
      
      public static const FEET:String = "Feet";
      
      public static const RIGHT_FOOT:String = "RightFoot";
      
      public static const WEAPON:String = "Weapon";
      
      public static const BOOSTER:String = "Booster";
      
      public static const COLOR:String = "Color";
      
      public static const FACE:String = "Face";
      
      public static const ACCESSORY_OVER_HAT:String = "AccessoryOverHat";
      
      public static const ACCESSORY_UNDER_HAT:String = "AccessoryUnderHat";
      
      private static const SLOTS:Array = ["Head","Torso","Feet","Weapon","Booster","Color","Face","AccessoryOverHat","AccessoryUnderHat"];
       
      
      public function Slots()
      {
         super();
         throw new Error("Slots is a static class!");
      }
      
      public static function isSlot(slot:String) : Boolean
      {
         return SLOTS.indexOf(slot) != -1;
      }
      
      public static function getWearableSlot(slot:String) : int
      {
         switch(slot)
         {
            case "Head":
               return 13;
            case "Torso":
               return 14;
            case "Feet":
               return 15;
            case "RightFoot":
               return 16;
            case "Weapon":
               return 8;
            case "Color":
               return 17;
            case "Face":
               return 18;
            case "AccessoryOverHat":
               return 19;
            case "AccessoryUnderHat":
               return 20;
            default:
               return -1;
         }
      }
   }
}
