package tuxwars.states.tutorial
{
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import no.olog.utilfunctions.assert;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.events.PowerUpPickedUpMessage;
   import tuxwars.battle.gameobjects.PowerUpGameObject;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialMoveSubState extends TuxTutorialSubState
   {
       
      
      private var controlsClip:MovieClip;
      
      private var powerupPickedUp:Boolean;
      
      public function TuxTutorialMoveSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_MOVE");
      }
      
      override public function enter() : void
      {
         var _loc2_:* = null;
         super.enter();
         BattleManager.getSimulation().pause();
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.boosterButton.setVisible(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.setVisible(false);
         var _loc3_:* = tuxGame.world;
         var _loc1_:Vector.<GameObject> = _loc3_._gameObjects.findGameObjectsbyClass(PowerUpGameObject);
         if(_loc1_.length >= 1)
         {
            assert("Too many powerups.",1,_loc1_.length);
            _loc2_ = _loc1_[0].gameDisplayObject.parent.localToGlobal(new Point(_loc1_[0].gameDisplayObject.x,_loc1_[0].gameDisplayObject.y));
            addTutorialArrowAt("top",_loc2_);
            MessageCenter.addListener("PowerUpPickedUp",powerUpPickedUp);
            controlsClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_controls");
            DCUtils.setBitmapSmoothing(true,controlsClip);
            BattleManager.getCurrentActivePlayer().container.addChild(controlsClip);
         }
         else if(_loc1_.length == 0)
         {
            LogUtils.log("PowerUp missing in tutorial field OR it was picked up",this,2,"Tutorial",true,false,false);
            powerUpPickedUp(null);
         }
      }
      
      override public function exit() : void
      {
         if(tuxGame.battleState.hud)
         {
            tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(true);
         }
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","GotToSpecificSpot","Move");
         MessageCenter.removeListener("PowerUpPickedUp",powerUpPickedUp);
         super.exit();
      }
      
      private function powerUpPickedUp(msg:PowerUpPickedUpMessage) : void
      {
         powerupPickedUp = true;
         if(controlsClip != null && BattleManager.getCurrentActivePlayer().container.contains(controlsClip))
         {
            BattleManager.getCurrentActivePlayer().container.removeChild(controlsClip);
         }
         Tutorial.saveTutorialStep("TutorialMoved",false);
         parent.changeState(new TuxTutorialFireSubState(tuxGame));
      }
   }
}
