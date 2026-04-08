package tuxwars.states.tutorial
{
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.geom.*;
   import no.olog.utilfunctions.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.events.PowerUpPickedUpMessage;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialMoveSubState extends TuxTutorialSubState
   {
      private var controlsClip:MovieClip;
      
      private var powerupPickedUp:Boolean;
      
      public function TuxTutorialMoveSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_MOVE");
      }
      
      override public function enter() : void
      {
         var _loc1_:Point = null;
         super.enter();
         BattleManager.getSimulation().pause();
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.boosterButton.setVisible(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.setVisible(false);
         var _loc2_:* = tuxGame.world;
         var _loc3_:Vector.<GameObject> = _loc2_._gameObjects.findGameObjectsbyClass(PowerUpGameObject);
         if(_loc3_.length >= 1)
         {
            assert("Too many powerups.",1,_loc3_.length);
            _loc1_ = _loc3_[0].gameDisplayObject.parent.localToGlobal(new Point(_loc3_[0].gameDisplayObject.x,_loc3_[0].gameDisplayObject.y));
            addTutorialArrowAt("top",_loc1_);
            MessageCenter.addListener("PowerUpPickedUp",this.powerUpPickedUp);
            this.controlsClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_controls");
            DCUtils.setBitmapSmoothing(true,this.controlsClip);
            BattleManager.getCurrentActivePlayer().container.addChild(this.controlsClip);
         }
         else if(_loc3_.length == 0)
         {
            LogUtils.log("PowerUp missing in tutorial field OR it was picked up",this,2,"Tutorial",true,false,false);
            this.powerUpPickedUp(null);
         }
      }
      
      override public function exit() : void
      {
         if(tuxGame.battleState.hud)
         {
            tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(true);
         }
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","GotToSpecificSpot","Move");
         MessageCenter.removeListener("PowerUpPickedUp",this.powerUpPickedUp);
         super.exit();
      }
      
      private function powerUpPickedUp(param1:PowerUpPickedUpMessage) : void
      {
         this.powerupPickedUp = true;
         if(this.controlsClip != null && Boolean(BattleManager.getCurrentActivePlayer().container.contains(this.controlsClip)))
         {
            BattleManager.getCurrentActivePlayer().container.removeChild(this.controlsClip);
         }
         Tutorial.saveTutorialStep("TutorialMoved",false);
         parent.changeState(new TuxTutorialFireSubState(tuxGame));
      }
   }
}

