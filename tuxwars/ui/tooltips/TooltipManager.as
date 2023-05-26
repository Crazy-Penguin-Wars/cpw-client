package tuxwars.ui.tooltips
{
   import com.dchoc.game.DCGame;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class TooltipManager
   {
      
      public static const DELAY:int = 250;
      
      public static const TOP:int = 0;
      
      public static const CENTER:int = 1;
      
      public static const BOTTOM:int = 2;
      
      private static var timer:Timer;
      
      private static var tooltip:TuxTooltip;
      
      private static var parent:DisplayObject;
      
      private static var startTime:int;
       
      
      public function TooltipManager()
      {
         super();
         throw new Error("TooltipManager is a static class!");
      }
      
      public static function showTooltip(_tooltip:TuxTooltip, _parent:DisplayObject, align:int = 1, setTime:int = 250) : TuxTooltip
      {
         removeTooltip();
         tooltip = _tooltip;
         parent = _parent;
         timer = new Timer(setTime,1);
         tooltip.setVisible(false);
         DCGame.getMainMovieClip().addChild(tooltip.getDesignMovieClip());
         var _loc5_:Point = parent.parent.localToGlobal(getParentLocation(parent,align));
         tooltip.setX(_loc5_.x);
         tooltip.setY(_loc5_.y);
         checkTooltipLocations();
         startTime = DCGame.getTime();
         timer.addEventListener("timer",displayTooltip,false,0,true);
         timer.reset();
         timer.start();
         return _tooltip;
      }
      
      private static function displayTooltip(event:TimerEvent) : void
      {
         if(tooltip)
         {
            tooltip.setVisible(true);
         }
      }
      
      public static function removeTooltip() : void
      {
         if(timer && timer.running)
         {
            timer.stop();
         }
         if(parent && tooltip && DCGame.getMainMovieClip().contains(tooltip.getDesignMovieClip()))
         {
            DCGame.getMainMovieClip().removeChild(tooltip.getDesignMovieClip());
         }
         if(tooltip)
         {
            tooltip.dispose();
         }
         tooltip = null;
         parent = null;
      }
      
      private static function getParentLocation(parent:DisplayObject, align:int) : Point
      {
         switch(align)
         {
            case 0:
               return new Point(parent.x,parent.y - parent.height * 0.5);
            case 1:
               return new Point(parent.x,parent.y);
            case 2:
               return new Point(parent.x,parent.y + parent.height * 0.5);
            default:
               return new Point(parent.x,parent.y);
         }
      }
      
      private static function checkTooltipLocations() : void
      {
         tooltip.checkTooltipLocation();
      }
   }
}
