package tuxwars.battle.ui.screen.timer
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.battle.BattleManager;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   
   public class MatchTimerElement extends TimerElement
   {
      
      private static const MATCH_TIMER:String = "Round_Timer";
       
      
      public function MatchTimerElement(from:MovieClip, parent:UIComponent = null)
      {
         super(from.getChildByName("Round_Timer") as MovieClip,parent,0,BattleManager.getMatchDuration());
         setText(ProjectManager.getText("MATCH_TIMER"));
         slider.addEventListener("mouseOut",mouseOut,false,0,true);
         slider.addEventListener("mouseOver",mouseOver,false,0,true);
         slider.getDesignMovieClip().mouseEnabled = true;
         slider.getDesignMovieClip().mouseChildren = true;
         getDesignMovieClip().stop();
         getDesignMovieClip().cacheAsBitmap = true;
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         var _loc2_:int = 0;
         if(BattleManager.isBattleInProgress())
         {
            _loc2_ = BattleManager.getMatchTimeLeft();
            setTime(_loc2_);
            super.logicUpdate(deltaTime);
         }
      }
      
      private function mouseOver(event:MouseEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip("TOOLTIP_BATTLE_MATCH_TIMER"),slider.getDesignMovieClip(),0);
      }
      
      private function mouseOut(event:MouseEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}
