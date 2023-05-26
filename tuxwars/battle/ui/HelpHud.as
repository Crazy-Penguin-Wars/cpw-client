package tuxwars.battle.ui
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
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
         super();
         _game = game;
         MessageCenter.addListener("HelpHudStartInfoArrow",createInfoArrow);
         MessageCenter.addListener("HelpHudStartShoot",createHelpArrow);
         MessageCenter.addListener("HelpHudStartMove",createHelpMove);
         MessageCenter.addListener("HelpHudStartMoveTimer",waitHelpMove);
      }
      
      private function waitHelpMove(msg:Message) : void
      {
         helpMoveCheck = true;
         MessageCenter.addListener("HelpHudCancelMoveTimer",cancelHelpMove);
      }
      
      private function cancelHelpMove(msg:Message) : void
      {
         helpMoveCheck = false;
         MessageCenter.removeListener("HelpHudCancelMoveTimer",cancelHelpMove);
      }
      
      private function createHelpArrow(msg:Message) : void
      {
         var _loc2_:UIButton = _game.battleState.hud.screen.controlsElement.weaponButton;
         helpArrow = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_arrow_top");
         helpArrow.mouseEnabled = false;
         DCUtils.setBitmapSmoothing(true,helpArrow);
         _loc2_.getDesignMovieClip().addChild(helpArrow);
         MessageCenter.addListener("HelpHudEndShoot",removeHelpArrow);
      }
      
      private function removeHelpArrow(msg:Message) : void
      {
         if(helpArrow)
         {
            if(helpArrow.parent && helpArrow.parent.contains(helpArrow))
            {
               helpArrow.parent.removeChild(helpArrow);
            }
            helpArrow = null;
            MessageCenter.removeListener("HelpHudEndShoot",removeHelpArrow);
         }
      }
      
      private function createHelpMove(msg:Message) : void
      {
         if(helpMoveCheck)
         {
            helpMoveCheck = false;
            controlsClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_controls");
            DCUtils.setBitmapSmoothing(true,controlsClip);
            BattleManager.getCurrentActivePlayer().container.addChild(controlsClip);
            MessageCenter.addListener("HelpHudEndMove",removeHelpMove);
            MessageCenter.removeListener("HelpHudCancelMoveTimer",cancelHelpMove);
         }
      }
      
      private function removeHelpMove(msg:Message) : void
      {
         if(controlsClip != null && BattleManager.getCurrentActivePlayer().container.contains(controlsClip))
         {
            BattleManager.getCurrentActivePlayer().container.removeChild(controlsClip);
         }
         MessageCenter.addListener("HelpHudEndMove",removeHelpMove);
      }
      
      private function createInfoArrow(msg:Message) : void
      {
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
      }
      
      private function removeInfoArrow(msg:Message) : void
      {
         if(infoArrow != null && BattleManager.getCurrentActivePlayer().container.contains(infoArrow))
         {
            BattleManager.getCurrentActivePlayer().container.removeChild(infoArrow);
         }
         MessageCenter.addListener("HelpHudEndInfoArrow",removeInfoArrow);
      }
      
      public function dispose() : void
      {
         MessageCenter.removeListener("HelpHudStartInfoArrow",createInfoArrow);
         MessageCenter.addListener("HelpHudEndInfoArrow",removeInfoArrow);
         MessageCenter.removeListener("HelpHudStartShoot",createHelpArrow);
         MessageCenter.removeListener("HelpHudEndShoot",removeHelpArrow);
         MessageCenter.removeListener("HelpHudStartMove",createHelpMove);
         MessageCenter.removeListener("HelpHudEndMove",removeHelpMove);
         helpArrow = null;
         controlsClip = null;
      }
   }
}
