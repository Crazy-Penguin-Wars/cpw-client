package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.data.RecipeData;
   import tuxwars.player.Player;
   
   public class RecipeContainers extends UIContainers
   {
      
      public static const SHOW:String = "Slot_Default";
      
      public static const DISABLED:String = "Slot_Disabled";
       
      
      public function RecipeContainers(slotIndex:int, object:RecipeData, design:MovieClip, parent:TuxUIScreen)
      {
         design.visible = true;
         super();
         add("Slot_Default",new RecipeShow(slotIndex,object,design.getChildByName("Slot_Default") as MovieClip,parent));
         add("Slot_Disabled",new RecipeDisabled(slotIndex,object,design.getChildByName("Slot_Disabled") as MovieClip,parent));
         var _loc5_:Player = parent.tuxGame.player;
         if(_loc5_.inventory.getItem(object.id))
         {
            show("Slot_Default",false);
         }
         else
         {
            show("Slot_Disabled",false);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
