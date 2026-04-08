package tuxwars.battle.ui.screen.tab
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.*;
   import flash.display.*;
   import tuxwars.battle.ui.logic.BattleHudPlayerData;
   
   public class PlayerTabContainer extends UIContainers
   {
      public static const STATUS_ACTIVE:String = "Slot_Active";
      
      public static const STATUS_DISABLED:String = "Slot_Disabled";
      
      public static const STATUS_EMPTY:String = "Slot_Empty";
      
      public function PlayerTabContainer(param1:MovieClip, param2:UIComponent, param3:String)
      {
         super();
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
         add("Slot_Active",new PlayerTabActiveElement(param1.getChildByName("Slot_Active") as MovieClip,param3,param2));
         add("Slot_Disabled",new PlayerTabElement(param1.getChildByName("Slot_Disabled") as MovieClip,param3,param2));
         add("Slot_Empty",new UIContainer(param1.getChildByName("Slot_Empty") as MovieClip,param2));
         show("Slot_Empty",false);
      }
      
      private function updateContent(param1:BattleHudPlayerData) : void
      {
         switch(getCurrentContainerId())
         {
            case "Slot_Active":
               PlayerTabActiveElement(getContainer(getCurrentContainerId())).updatePlayer(param1);
               break;
            case "Slot_Disabled":
               PlayerTabElement(getContainer(getCurrentContainerId())).updatePlayer(param1);
         }
      }
      
      public function updateTabState(param1:BattleHudPlayerData) : void
      {
         switch(getCurrentContainerId())
         {
            case "Slot_Active":
               if(param1.status != "Active" && param1.status != "Idle")
               {
                  this.changeToNewState(param1.status);
               }
               break;
            case "Slot_Disabled":
               if(param1.status != "Disabled")
               {
                  this.changeToNewState(param1.status);
               }
               break;
            default:
               if(param1.status != "Empty")
               {
                  this.changeToNewState(param1.status);
               }
         }
         this.updateContent(param1);
      }
      
      private function changeToNewState(param1:String) : void
      {
         switch(param1)
         {
            case "Active":
            case "Idle":
               show("Slot_Active",false);
               break;
            case "Disabled":
               show("Slot_Disabled",false);
               break;
            default:
               show("Slot_Empty",false);
         }
      }
   }
}

