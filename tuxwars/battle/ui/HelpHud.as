package tuxwars.battle.ui
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   
   public class HelpHud
   {
      public static const ARROW_TOP:String = "top";
      
      public static const ARROW_0:String = "arrow_pink_anim";
      
      public static const ARROW_1:String = "arrow_orange_anim";
      
      public static const ARROW_2:String = "arrow_blue_anim";
      
      public static const ARROW_3:String = "arrow_green_anim";
      
      private var infoArrow:MovieClip;
      
      private var helpArrow:MovieClip;
      
      private var controlsClip:MovieClip;
      
      private var _game:TuxWarsGame;
      
      private var helpMoveCheck:Boolean;
      
      private var currentPlayer:int;
      
      public function HelpHud(game:TuxWarsGame)
      {
         ExternalInterface.call("console.log","[MichiDebug] Start creating HelpHud");
         super();
         _game = game;
         MessageCenter.addListener("HelpHudStartInfoArrow",createInfoArrow);
         MessageCenter.addListener("HelpHudStartShoot",createHelpArrow);
         MessageCenter.addListener("HelpHudStartMove",createHelpMove);
         MessageCenter.addListener("HelpHudStartMoveTimer",waitHelpMove);
         ExternalInterface.call("console.log","[MichiDebug] End creating HelpHud");
      }
      
      private function waitHelpMove(msg:Message) : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start waitHelpMove");
         helpMoveCheck = true;
         MessageCenter.addListener("HelpHudCancelMoveTimer",cancelHelpMove);
         ExternalInterface.call("console.log","[MichiDebug] End waitHelpMove");
      }
      
      private function cancelHelpMove(msg:Message) : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start cancelHelpMove");
         helpMoveCheck = false;
         MessageCenter.removeListener("HelpHudCancelMoveTimer",cancelHelpMove);
         ExternalInterface.call("console.log","[MichiDebug] End cancelHelpMove");
      }
      
      private function createHelpArrow(msg:Message) : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start createHelpArrow");
         var _loc2_:UIButton = _game.battleState.hud.screen.controlsElement.weaponButton;
         helpArrow = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_arrow_top");
         helpArrow.mouseEnabled = false;
         DCUtils.setBitmapSmoothing(true,helpArrow);
         _loc2_.getDesignMovieClip().addChild(helpArrow);
         MessageCenter.addListener("HelpHudEndShoot",removeHelpArrow);
         ExternalInterface.call("console.log","[MichiDebug] End createHelpArrow");
      }
      
      private function removeHelpArrow(msg:Message) : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start removeHelpArrow");
         if(helpArrow)
         {
            if(helpArrow.parent && helpArrow.parent.contains(helpArrow))
            {
               helpArrow.parent.removeChild(helpArrow);
               ExternalInterface.call("console.log","[MichiDebug] true");
            }
            helpArrow = null;
            MessageCenter.removeListener("HelpHudEndShoot",removeHelpArrow);
         }
         ExternalInterface.call("console.log","[MichiDebug] End removeHelpArrow");
      }
      
      private function createHelpMove(msg:Message) : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start createHelpMove");
         if(helpMoveCheck)
         {
            helpMoveCheck = false;
            controlsClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_controls");
            DCUtils.setBitmapSmoothing(true,controlsClip);
            BattleManager.getCurrentActivePlayer().container.addChild(controlsClip);
            MessageCenter.addListener("HelpHudEndMove",removeHelpMove);
            MessageCenter.removeListener("HelpHudCancelMoveTimer",cancelHelpMove);
         }
         ExternalInterface.call("console.log","[MichiDebug] End createHelpMove");
      }
      
      private function removeHelpMove(msg:Message) : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start removeHelpMove");
         if(controlsClip != null && BattleManager.getCurrentActivePlayer().container.contains(controlsClip))
         {
            BattleManager.getCurrentActivePlayer().container.removeChild(controlsClip);
            ExternalInterface.call("console.log","[MichiDebug] true");
         }
         MessageCenter.addListener("HelpHudEndMove",removeHelpMove);
         ExternalInterface.call("console.log","[MichiDebug] End removeHelpMove");
      }
      
      private function createInfoArrow(msg:Message) : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start createInfoArrow");
         currentPlayer = BattleManager.getCurrentActivePlayerIndex();
         if(currentPlayer == 0)
         {
            infoArrow = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","arrow_pink_anim");
         }
         else if(currentPlayer == 1)
         {
            infoArrow = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","arrow_orange_anim");
         }
         else if(currentPlayer == 2)
         {
            infoArrow = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","arrow_blue_anim");
         }
         else if(currentPlayer == 3)
         {
            infoArrow = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","arrow_green_anim");
         }
         DCUtils.setBitmapSmoothing(true,infoArrow);
         BattleManager.getCurrentActivePlayer().container.addChild(infoArrow);
         MessageCenter.addListener("HelpHudEndInfoArrow",removeInfoArrow);
         ExternalInterface.call("console.log","[MichiDebug] End createInfoArrow");
      }
      
      private function removeInfoArrow(msg:Message) : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start removeInfoArrow");
         if(infoArrow != null && BattleManager.getCurrentActivePlayer().container.contains(infoArrow))
         {
            BattleManager.getCurrentActivePlayer().container.removeChild(infoArrow);
         }
         MessageCenter.addListener("HelpHudEndInfoArrow",removeInfoArrow);
         ExternalInterface.call("console.log","[MichiDebug] End removeInfoArrow");
      }
      
      public function dispose() : void
      {
         ExternalInterface.call("console.log","[MichiDebug] Start dispose");
         MessageCenter.removeListener("HelpHudStartInfoArrow",createInfoArrow);
         MessageCenter.addListener("HelpHudEndInfoArrow",removeInfoArrow);
         MessageCenter.removeListener("HelpHudStartShoot",createHelpArrow);
         MessageCenter.removeListener("HelpHudEndShoot",removeHelpArrow);
         MessageCenter.removeListener("HelpHudStartMove",createHelpMove);
         MessageCenter.removeListener("HelpHudEndMove",removeHelpMove);
         helpArrow = null;
         controlsClip = null;
         ExternalInterface.call("console.log","[MichiDebug] End dispose");
      }
   }
}

