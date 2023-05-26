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
   
   public class TuxTutorialBuyWeaponSubState extends TuxTutorialSubState
   {
       
      
      private var arrowAdded:Boolean;
      
      public function TuxTutorialBuyWeaponSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_BUY_WEAPON");
      }
      
      override public function enter() : void
      {
         super.enter();
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(true);
         MessageCenter.addListener("BuyItem",weaponBought);
      }
      
      override public function exit() : void
      {
         super.exit();
         MessageCenter.removeListener("BuyItem",weaponBought);
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
                        if(slot.buttonContainers.getCurrentContainer())
                        {
                           slot.itemContainers.enabled = false;
                           slot.buttonContainers.enabled = true;
                           var _loc5_:* = slot.buttonContainers.getCurrentContainer();
                           addTutorialArrow("bottom",_loc5_._design);
                           arrowAdded = true;
                        }
                     }
                     else
                     {
                        slot.enabled = false;
                     }
                  }
               }
            }
         }
      }
      
      private function weaponBought(msg:Message) : void
      {
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","BuyWeapon","ClusterRocket");
         Tutorial.saveTutorialStep("TutorialBuyWeapon",false);
         parent.changeState(new TuxTutorialSelectWeaponSubState(tuxGame));
      }
   }
}
