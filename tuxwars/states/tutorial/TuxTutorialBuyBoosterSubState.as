package tuxwars.states.tutorial
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.boosterselection.*;
   import tuxwars.battle.ui.states.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialBuyBoosterSubState extends TuxTutorialSubState
   {
      private var arrowAdded:Boolean;
      
      public function TuxTutorialBuyBoosterSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_BUY_BOOSTER");
      }
      
      override public function enter() : void
      {
         super.enter();
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(true);
         MessageCenter.addListener("BuyItem",this.boosterBought);
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.removeListener("BuyItem",this.boosterBought);
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
                        if(_loc4_.buttonContainers.getCurrentContainer())
                        {
                           _loc4_.itemContainers.enabled = false;
                           _loc4_.buttonContainers.enabled = true;
                           _loc5_ = _loc4_.buttonContainers.getCurrentContainer();
                           addTutorialArrow("bottom",_loc5_._design);
                           this.arrowAdded = true;
                        }
                     }
                     else
                     {
                        _loc4_.enabled = false;
                     }
                  }
               }
            }
         }
      }
      
      private function boosterBought(param1:Message) : void
      {
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","BuyBooster","Shield");
         Tutorial.saveTutorialStep("TutorialBuyBooster",false);
         parent.changeState(new TuxTutorialSelectBoosterSubState(tuxGame));
      }
   }
}

