package tuxwars.battle.ui
{
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   
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
      
      public function HelpHud(param1:TuxWarsGame)
      {
         super();
         this._game = param1;
         MessageCenter.addListener("HelpHudStartInfoArrow",this.createInfoArrow);
         MessageCenter.addListener("HelpHudStartShoot",this.createHelpArrow);
         MessageCenter.addListener("HelpHudStartMove",this.createHelpMove);
         MessageCenter.addListener("HelpHudStartMoveTimer",this.waitHelpMove);
      }
      
      private function waitHelpMove(param1:Message) : void
      {
         this.helpMoveCheck = true;
         MessageCenter.addListener("HelpHudCancelMoveTimer",this.cancelHelpMove);
      }
      
      private function cancelHelpMove(param1:Message) : void
      {
         this.helpMoveCheck = false;
         MessageCenter.removeListener("HelpHudCancelMoveTimer",this.cancelHelpMove);
      }
      
      private function createHelpArrow(param1:Message) : void
      {
         var _loc2_:UIButton = this._game.battleState.hud.screen.controlsElement.weaponButton;
         this.helpArrow = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_arrow_top");
         this.helpArrow.mouseEnabled = false;
         DCUtils.setBitmapSmoothing(true,this.helpArrow);
         _loc2_.getDesignMovieClip().addChild(this.helpArrow);
         MessageCenter.addListener("HelpHudEndShoot",this.removeHelpArrow);
      }
      
      private function removeHelpArrow(param1:Message) : void
      {
         if(this.helpArrow)
         {
            if(Boolean(this.helpArrow.parent) && Boolean(this.helpArrow.parent.contains(this.helpArrow)))
            {
               this.helpArrow.parent.removeChild(this.helpArrow);
            }
            this.helpArrow = null;
            MessageCenter.removeListener("HelpHudEndShoot",this.removeHelpArrow);
         }
      }
      
      private function createHelpMove(param1:Message) : void
      {
         if(this.helpMoveCheck)
         {
            this.helpMoveCheck = false;
            this.controlsClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","tutorial_controls");
            DCUtils.setBitmapSmoothing(true,this.controlsClip);
            BattleManager.getCurrentActivePlayer().container.addChild(this.controlsClip);
            MessageCenter.addListener("HelpHudEndMove",this.removeHelpMove);
            MessageCenter.removeListener("HelpHudCancelMoveTimer",this.cancelHelpMove);
         }
      }
      
      private function removeHelpMove(param1:Message) : void
      {
         if(this.controlsClip != null && Boolean(BattleManager.getCurrentActivePlayer().container.contains(this.controlsClip)))
         {
            BattleManager.getCurrentActivePlayer().container.removeChild(this.controlsClip);
         }
         MessageCenter.addListener("HelpHudEndMove",this.removeHelpMove);
      }
      
      private function createInfoArrow(param1:Message) : void
      {
         this.currentPlayer = BattleManager.getCurrentActivePlayerIndex();
         if(this.currentPlayer == 0)
         {
            this.infoArrow = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","arrow_pink_anim");
         }
         else if(this.currentPlayer == 1)
         {
            this.infoArrow = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","arrow_orange_anim");
         }
         else if(this.currentPlayer == 2)
         {
            this.infoArrow = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","arrow_blue_anim");
         }
         else if(this.currentPlayer == 3)
         {
            this.infoArrow = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","arrow_green_anim");
         }
         DCUtils.setBitmapSmoothing(true,this.infoArrow);
         BattleManager.getCurrentActivePlayer().container.addChild(this.infoArrow);
         MessageCenter.addListener("HelpHudEndInfoArrow",this.removeInfoArrow);
      }
      
      private function removeInfoArrow(param1:Message) : void
      {
         if(this.infoArrow != null && Boolean(BattleManager.getCurrentActivePlayer().container.contains(this.infoArrow)))
         {
            BattleManager.getCurrentActivePlayer().container.removeChild(this.infoArrow);
         }
         MessageCenter.addListener("HelpHudEndInfoArrow",this.removeInfoArrow);
      }
      
      public function dispose() : void
      {
         MessageCenter.removeListener("HelpHudStartInfoArrow",this.createInfoArrow);
         MessageCenter.addListener("HelpHudEndInfoArrow",this.removeInfoArrow);
         MessageCenter.removeListener("HelpHudStartShoot",this.createHelpArrow);
         MessageCenter.removeListener("HelpHudEndShoot",this.removeHelpArrow);
         MessageCenter.removeListener("HelpHudStartMove",this.createHelpMove);
         MessageCenter.removeListener("HelpHudEndMove",this.removeHelpMove);
         this.helpArrow = null;
         this.controlsClip = null;
      }
   }
}

