package tuxwars.states.tutorial
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.weaponselection.WeaponSelectionScreen;
   import tuxwars.battle.ui.states.HUDWeaponSelectionSubState;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class TuxTutorialSelectWeaponSubState extends TuxTutorialSubState
   {
       
      
      private var arrowAdded:Boolean;
      
      public function TuxTutorialSelectWeaponSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_SELECT_WEAPON");
      }
      
      override public function enter() : void
      {
         super.enter();
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(true);
         MessageCenter.addListener("WeaponSelected",weaponSelected);
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.removeListener("WeaponSelected",weaponSelected);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         super.logicUpdate(deltaTime);
         if(!arrowAdded)
         {
            _loc3_ = tuxGame.battleState.hud.state as HUDWeaponSelectionSubState;
            if(_loc3_)
            {
               _loc2_ = _loc3_.screen as WeaponSelectionScreen;
               if(_loc2_)
               {
                  for each(var slot in _loc2_.objectContainer.objects)
                  {
                     if(slot.shopItem.id == "ClusterRocket")
                     {
                        slot.itemContainers.enabled = true;
                        var _loc5_:* = slot;
                        addTutorialArrow("bottom",_loc5_._design);
                     }
                     else
                     {
                        slot.enabled = false;
                     }
                  }
                  arrowAdded = true;
               }
            }
         }
      }
      
      private function weaponSelected(msg:Message) : void
      {
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(false);
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","SelectWeapon","ClusterRocket");
         Tutorial.saveTutorialStep("TutorialSelectWeapon",false);
         parent.changeState(new TuxTutorialTurnTimerSubState(tuxGame));
      }
   }
}
