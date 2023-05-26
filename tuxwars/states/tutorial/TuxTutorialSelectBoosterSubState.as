package tuxwars.states.tutorial
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.boosterselection.BoosterSelectionScreen;
   import tuxwars.battle.ui.states.HUDBoosterSelectionSubState;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class TuxTutorialSelectBoosterSubState extends TuxTutorialSubState
   {
       
      
      private var arrowAdded:Boolean;
      
      public function TuxTutorialSelectBoosterSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_SELECT_BOOSTER");
      }
      
      override public function enter() : void
      {
         super.enter();
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(true);
         MessageCenter.addListener("BooserSelected",boosterSelected);
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.removeListener("BooserSelected",boosterSelected);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         super.logicUpdate(deltaTime);
         if(!arrowAdded)
         {
            _loc3_ = tuxGame.battleState.hud.state as HUDBoosterSelectionSubState;
            if(_loc3_)
            {
               _loc2_ = _loc3_.screen as BoosterSelectionScreen;
               if(_loc2_)
               {
                  for each(var slot in _loc2_.objectContainer.objects)
                  {
                     if(slot.shopItem.id == "Shield")
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
      
      private function boosterSelected(msg:Message) : void
      {
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(false);
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","SelectBooster","Shield");
         Tutorial.saveTutorialStep("TutorialSelectBooster",false);
         parent.changeState(new TuxTutorialUseBoosterSubState(tuxGame));
      }
   }
}
