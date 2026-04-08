package com.dchoc.avatar.paperdoll
{
   import com.dchoc.utils.*;
   
   public class ClothesSlot
   {
      public static const TYPE_SHOES:int = 0;
      
      public static const TYPE_BOTTOM:int = 1;
      
      public static const TYPE_TOP:int = 2;
      
      public static const TYPE_EYES:int = 3;
      
      public static const TYPE_EYEBROWS:int = 4;
      
      public static const TYPE_MOUTH:int = 5;
      
      public static const TYPE_HAIR:int = 6;
      
      public static const TYPE_EXTRAS:int = 7;
      
      public static const TYPE_TOOL:int = 8;
      
      public static const TYPE_STYLES:int = 9;
      
      public static const TYPE_LEFT_HAND:int = 10;
      
      public static const TYPE_RIGHT_HAND:int = 11;
      
      public static const TYPE_HANDS:int = 12;
      
      public static const TYPE_HEAD:int = 13;
      
      public static const TYPE_TORSO:int = 14;
      
      public static const TYPE_LEFT_FOOT:int = 15;
      
      public static const TYPE_RIGHT_FOOT:int = 16;
      
      public static const TYPE_COLOR:int = 17;
      
      public static const TYPE_FACE:int = 18;
      
      public static const TYPE_ACCESSORY_OVER_HAT:int = 19;
      
      public static const TYPE_ACCESSORY_UNDER_HAT:int = 20;
      
      private static const slots:Vector.<ClothesSlot> = new Vector.<ClothesSlot>();
      
      public static const TYPE_NAMES:Array = ["shoes","bottom","top","eyes","eyebrows","mouth","hair","extras","tool","styles","left_hand","right_hand","hands","head_gear","body_gear","left_foot_gear","right_foot_gear","color","face","accessory_over","accessory_under"];
      
      public static const SHOES:ClothesSlot = new ClothesSlot(0);
      
      public static const BOTTOM:ClothesSlot = new ClothesSlot(1);
      
      public static const TOP:ClothesSlot = new ClothesSlot(2);
      
      public static const EYES:ClothesSlot = new ClothesSlot(3);
      
      public static const EYEBROWS:ClothesSlot = new ClothesSlot(4);
      
      public static const MOUTH:ClothesSlot = new ClothesSlot(5);
      
      public static const HAIR:ClothesSlot = new ClothesSlot(6);
      
      public static const EXTRAS:ClothesSlot = new ClothesSlot(7);
      
      public static const TOOL:ClothesSlot = new ClothesSlot(8);
      
      public static const STYLES:ClothesSlot = new ClothesSlot(9);
      
      public static const LEFT_HAND:ClothesSlot = new ClothesSlot(10);
      
      public static const RIGHT_HAND:ClothesSlot = new ClothesSlot(11);
      
      public static const HANDS:ClothesSlot = new ClothesSlot(12);
      
      public static const HEAD:ClothesSlot = new ClothesSlot(13);
      
      public static const TORSO:ClothesSlot = new ClothesSlot(14);
      
      public static const LEFT_FOOT:ClothesSlot = new ClothesSlot(15);
      
      public static const RIGHT_FOOT:ClothesSlot = new ClothesSlot(16);
      
      public static const COLOR:ClothesSlot = new ClothesSlot(17);
      
      public static const FACE:ClothesSlot = new ClothesSlot(18);
      
      public static const ACCESSORY_OVER_HAT:ClothesSlot = new ClothesSlot(19);
      
      public static const ACCESSORY_UNDER_HAT:ClothesSlot = new ClothesSlot(20);
      
      private var identifier:int;
      
      public function ClothesSlot(param1:int)
      {
         super();
         this.identifier = param1;
         slots.push(this);
      }
      
      public static function getTypeName(param1:int) : String
      {
         return TYPE_NAMES[param1];
      }
      
      public static function getTypeIDFromName(param1:String) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < TYPE_NAMES.length)
         {
            if(TYPE_NAMES[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public static function getSlotByID(param1:int) : ClothesSlot
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in slots)
         {
            if(_loc2_.getID() == param1)
            {
               return _loc2_;
            }
         }
         LogUtils.log("ClothesSlot:getSlotById: could not find a slot with id: " + param1,ClothesSlot,2,"Items",true,false,false);
         return null;
      }
      
      public function getID() : int
      {
         return this.identifier;
      }
      
      public function toString() : String
      {
         return "ClothesSlot - " + this.identifier + ", " + TYPE_NAMES[this.identifier];
      }
   }
}

