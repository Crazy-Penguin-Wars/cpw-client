package tuxwars.states.tutorial
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.boosterselection.*;
   import tuxwars.battle.ui.states.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialSelectBoosterSubState extends TuxTutorialSubState
   {
      private var arrowAdded:Boolean;
      
      public function TuxTutorialSelectBoosterSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_SELECT_BOOSTER");
      }
      
      override public function enter() : void
      {
         super.enter();
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(true);
         MessageCenter.addListener("BooserSelected",this.boosterSelected);
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.removeListener("BooserSelected",this.boosterSelected);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:HUDBoosterSelectionSubState = null;
         var _loc3_:BoosterSelectionScreen = null;
         super.logicUpdate(param1);
         if(!this.arrowAdded)
         {
            _loc2_ = tuxGame.battleState.hud.state as HUDBoosterSelectionSubState;
            if(_loc2_)
            {
               _loc3_ = _loc2_.screen as BoosterSelectionScreen;
               if(_loc3_)
               {
                  for each(_loc4_ in _loc3_.objectContainer.objects)
                  {
                     if(_loc4_.shopItem.id == "Shield")
                     {
                        _loc4_.itemContainers.enabled = true;
                        _loc5_ = _loc4_;
                        addTutorialArrow("bottom",_loc5_._design);
                     }
                     else
                     {
                        _loc4_.enabled = false;
                     }
                  }
                  this.arrowAdded = true;
               }
            }
         }
      }
      
      private function boosterSelected(param1:Message) : void
      {
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(false);
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","SelectBooster","Shield");
         Tutorial.saveTutorialStep("TutorialSelectBooster",false);
         parent.changeState(new TuxTutorialUseBoosterSubState(tuxGame));
      }
   }
}

