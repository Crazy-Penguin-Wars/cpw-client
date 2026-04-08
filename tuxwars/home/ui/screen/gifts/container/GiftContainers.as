package tuxwars.home.ui.screen.gifts.container
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   
   public class GiftContainers extends UIContainers
   {
      public static const SHOW:String = "Slot_Default";
      
      public static const LOCK:String = "Slot_Disabled";
      
      public var selectedFriendID:String;
      
      public function GiftContainers(param1:GiftReference, param2:MovieClip, param3:TuxWarsGame, param4:*)
      {
         super();
         param2.visible = true;
         if(param4)
         {
            this.selectedFriendID = param4;
         }
         else
         {
            this.selectedFriendID = null;
         }
         add("Slot_Default",new GiftSend(param2.getChildByName("Slot_Default") as MovieClip,param1,param3,this.selectedFriendID));
         add("Slot_Disabled",new GiftLock(param2.getChildByName("Slot_Disabled") as MovieClip,param1,param3,this.selectedFriendID));
         if(param3.player.level >= param1.requiredLevel)
         {
            show("Slot_Default");
         }
         else
         {
            show("Slot_Disabled");
         }
      }
   }
}

