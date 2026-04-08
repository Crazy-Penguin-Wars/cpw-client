package tuxwars.battle.ui.screen.timer
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.*;
   import flash.events.MouseEvent;
   import tuxwars.battle.*;
   import tuxwars.ui.tooltips.*;
   
   public class MatchTimerElement extends TimerElement
   {
      private static const MATCH_TIMER:String = "Round_Timer";
      
      public function MatchTimerElement(param1:MovieClip, param2:UIComponent = null)
      {
         super(param1.getChildByName("Round_Timer") as MovieClip,param2,0,BattleManager.getMatchDuration());
         setText(ProjectManager.getText("MATCH_TIMER"));
         slider.addEventListener("mouseOut",this.mouseOut,false,0,true);
         slider.addEventListener("mouseOver",this.mouseOver,false,0,true);
         slider.getDesignMovieClip().mouseEnabled = true;
         slider.getDesignMovieClip().mouseChildren = true;
         getDesignMovieClip().stop();
         getDesignMovieClip().cacheAsBitmap = true;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc2_:int = 0;
         if(BattleManager.isBattleInProgress())
         {
            _loc2_ = int(BattleManager.getMatchTimeLeft());
            setTime(_loc2_);
            super.logicUpdate(param1);
         }
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip("TOOLTIP_BATTLE_MATCH_TIMER"),slider.getDesignMovieClip(),0);
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

