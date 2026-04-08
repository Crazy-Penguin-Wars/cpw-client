package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.data.RecipeData;
   import tuxwars.player.Player;
   
   public class RecipeContainers extends UIContainers
   {
      public static const SHOW:String = "Slot_Default";
      
      public static const DISABLED:String = "Slot_Disabled";
      
      public function RecipeContainers(param1:int, param2:RecipeData, param3:MovieClip, param4:TuxUIScreen)
      {
         param3.visible = true;
         super();
         add("Slot_Default",new RecipeShow(param1,param2,param3.getChildByName("Slot_Default") as MovieClip,param4));
         add("Slot_Disabled",new RecipeDisabled(param1,param2,param3.getChildByName("Slot_Disabled") as MovieClip,param4));
         var _loc5_:Player = param4.tuxGame.player;
         if(_loc5_.inventory.getItem(param2.id))
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

