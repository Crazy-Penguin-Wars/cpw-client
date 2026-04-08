package tuxwars.ui.tooltips
{
   import com.dchoc.game.*;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.*;
   import flash.utils.*;
   
   public class TooltipManager
   {
      private static var timer:Timer;
      
      private static var tooltip:TuxTooltip;
      
      private static var parent:DisplayObject;
      
      private static var startTime:int;
      
      public static const DELAY:int = 250;
      
      public static const TOP:int = 0;
      
      public static const CENTER:int = 1;
      
      public static const BOTTOM:int = 2;
      
      public function TooltipManager()
      {
         super();
         throw new Error("TooltipManager is a static class!");
      }
      
      public static function showTooltip(param1:TuxTooltip, param2:DisplayObject, param3:int = 1, param4:int = 250) : TuxTooltip
      {
         removeTooltip();
         tooltip = param1;
         parent = param2;
         timer = new Timer(param4,1);
         tooltip.setVisible(false);
         DCGame.getMainMovieClip().addChild(tooltip.getDesignMovieClip());
         var _loc5_:Point = parent.parent.localToGlobal(getParentLocation(parent,param3));
         tooltip.setX(_loc5_.x);
         tooltip.setY(_loc5_.y);
         checkTooltipLocations();
         startTime = DCGame.getTime();
         timer.addEventListener("timer",displayTooltip,false,0,true);
         timer.reset();
         timer.start();
         return param1;
      }
      
      private static function displayTooltip(param1:TimerEvent) : void
      {
         if(tooltip)
         {
            tooltip.setVisible(true);
         }
      }
      
      public static function removeTooltip() : void
      {
         if(Boolean(timer) && Boolean(timer.running))
         {
            timer.stop();
         }
         if(parent && tooltip && Boolean(DCGame.getMainMovieClip().contains(tooltip.getDesignMovieClip())))
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
      
      private static function getParentLocation(param1:DisplayObject, param2:int) : Point
      {
         switch(param2)
         {
            case 0:
               return new Point(param1.x,param1.y - param1.height * 0.5);
            case 1:
               return new Point(param1.x,param1.y);
            case 2:
               return new Point(param1.x,param1.y + param1.height * 0.5);
            default:
               return new Point(param1.x,param1.y);
         }
      }
      
      private static function checkTooltipLocations() : void
      {
         tooltip.checkTooltipLocation();
      }
   }
}

