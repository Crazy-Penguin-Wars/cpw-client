package tuxwars.states.tutorial
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.weaponselection.*;
   import tuxwars.battle.ui.states.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialSelectWeaponSubState extends TuxTutorialSubState
   {
      private var arrowAdded:Boolean;
      
      public function TuxTutorialSelectWeaponSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_SELECT_WEAPON");
      }
      
      override public function enter() : void
      {
         super.enter();
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(true);
         MessageCenter.addListener("WeaponSelected",this.weaponSelected);
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.removeListener("WeaponSelected",this.weaponSelected);
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:HUDWeaponSelectionSubState = null;
         var _loc3_:WeaponSelectionScreen = null;
         super.logicUpdate(param1);
         if(!this.arrowAdded)
         {
            _loc2_ = tuxGame.battleState.hud.state as HUDWeaponSelectionSubState;
            if(_loc2_)
            {
               _loc3_ = _loc2_.screen as WeaponSelectionScreen;
               if(_loc3_)
               {
                  for each(_loc4_ in _loc3_.objectContainer.objects)
                  {
                     if(_loc4_.shopItem.id == "ClusterRocket")
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
      
      private function weaponSelected(param1:Message) : void
      {
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(false);
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","SelectWeapon","ClusterRocket");
         Tutorial.saveTutorialStep("TutorialSelectWeapon",false);
         parent.changeState(new TuxTutorialTurnTimerSubState(tuxGame));
      }
   }
}

