package tuxwars.battle.ui.screen.tab
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import tuxwars.battle.ui.logic.BattleHudPlayerData;
   
   public class PlayerTabContainer extends UIContainers
   {
      
      public static const STATUS_ACTIVE:String = "Slot_Active";
      
      public static const STATUS_DISABLED:String = "Slot_Disabled";
      
      public static const STATUS_EMPTY:String = "Slot_Empty";
       
      
      public function PlayerTabContainer(design:MovieClip, parent:UIComponent, playerName:String)
      {
         super();
         design.mouseEnabled = false;
         design.mouseChildren = false;
         add("Slot_Active",new PlayerTabActiveElement(design.getChildByName("Slot_Active") as MovieClip,playerName,parent));
         add("Slot_Disabled",new PlayerTabElement(design.getChildByName("Slot_Disabled") as MovieClip,playerName,parent));
         add("Slot_Empty",new UIContainer(design.getChildByName("Slot_Empty") as MovieClip,parent));
         show("Slot_Empty",false);
      }
      
      private function updateContent(player:BattleHudPlayerData) : void
      {
         switch(getCurrentContainerId())
         {
            case "Slot_Active":
               PlayerTabActiveElement(getContainer(getCurrentContainerId())).updatePlayer(player);
               break;
            case "Slot_Disabled":
               PlayerTabElement(getContainer(getCurrentContainerId())).updatePlayer(player);
         }
      }
      
      public function updateTabState(player:BattleHudPlayerData) : void
      {
         switch(getCurrentContainerId())
         {
            case "Slot_Active":
               if(player.status != "Active" && player.status != "Idle")
               {
                  changeToNewState(player.status);
                  break;
               }
               break;
            case "Slot_Disabled":
               if(player.status != "Disabled")
               {
                  changeToNewState(player.status);
                  break;
               }
               break;
            default:
               if(player.status != "Empty")
               {
                  changeToNewState(player.status);
                  break;
               }
         }
         updateContent(player);
      }
      
      private function changeToNewState(playerState:String) : void
      {
         switch(playerState)
         {
            case "Active":
            case "Idle":
               show("Slot_Active");
               break;
            case "Disabled":
               show("Slot_Disabled");
               break;
            default:
               show("Slot_Empty");
         }
      }
   }
}
