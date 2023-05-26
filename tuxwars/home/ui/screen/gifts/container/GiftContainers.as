package tuxwars.home.ui.screen.gifts.container
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.gifts.GiftReference;
   
   public class GiftContainers extends UIContainers
   {
      
      public static const SHOW:String = "Slot_Default";
      
      public static const LOCK:String = "Slot_Disabled";
       
      
      public var selectedFriendID:String;
      
      public function GiftContainers(gift:GiftReference, design:MovieClip, game:TuxWarsGame, params:*)
      {
         super();
         design.visible = true;
         if(params)
         {
            selectedFriendID = params;
         }
         else
         {
            selectedFriendID = null;
         }
         add("Slot_Default",new GiftSend(design.getChildByName("Slot_Default") as MovieClip,gift,game,selectedFriendID));
         add("Slot_Disabled",new GiftLock(design.getChildByName("Slot_Disabled") as MovieClip,gift,game,selectedFriendID));
         if(game.player.level >= gift.requiredLevel)
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
