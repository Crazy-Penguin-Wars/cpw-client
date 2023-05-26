package tuxwars.battle.ui
{
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.data.RewardConfig;
   
   public class FeedbackItem
   {
      
      private static const REWARDS_GO_TO_PLAYER:Boolean = true;
      
      private static const SCALE_ITEMS:Boolean = true;
      
      private static const SHRINK_ICON_WHEN_FLYING:Boolean = true;
      
      private static const ITEM_MAX_SCALE_AMOUNT:int = 50;
      
      public static const TYPE_CASH:String = "drop_cash";
      
      public static const TYPE_COINS:String = "drop_coins";
      
      public static const TYPE_ITEM:String = "drop_generic_item";
      
      public static const TYPE_EXP:String = "drop_exp";
      
      public static const TYPE_COUPON:String = "drop_coupon";
      
      public static const NOT_SET:int = -1;
       
      
      private var apperaTimeDefault:int;
      
      private var waitTimeDefault:int;
      
      private var flyTimeDefault:int;
      
      private var appearTime:int;
      
      private var waitTime:int;
      
      private var flyTime:int;
      
      private var effectAnimTimeFactor:Number;
      
      private var effectTimer:Number;
      
      private var effectOffset:Point;
      
      private var effectAnimHeightFactor:Number;
      
      private var tuxWorldInstance:TuxWorld;
      
      private var clip:MovieClip;
      
      private var baseLoc:Point;
      
      private var destLoc:Point;
      
      private var scale:Number;
      
      private var _finished:Boolean;
      
      public function FeedbackItem(type:String, x:Number, y:Number, gain:int, levelWidth:Number, levelHeight:Number, appearTime:int = -1, waitTime:int = -1, flyTime:int = -1, swf:String = null, export:String = null, icon:MovieClip = null)
      {
         var dx:Number = NaN;
         var dy:Number = NaN;
         super();
         if(icon != null)
         {
            clip = icon;
         }
         else if(swf != null && export != null)
         {
            clip = DCResourceManager.instance.getFromSWF(swf,export);
         }
         else
         {
            clip = DCResourceManager.instance.getFromSWF("flash/ui/icons_drops.swf",type);
         }
         if(!clip)
         {
            LogUtils.log("No clip for feedback item, type: " + type + " swf: " + swf + " export: " + export,"FeedbackItem",3,"Assets",true,true,true);
         }
         clip.mouseEnabled = true;
         clip.addEventListener("mouseOver",mouseOver,false,0,true);
         clip.x = x;
         clip.y = y;
         if(gain <= 50)
         {
            scale = 1 + gain / 50;
         }
         else
         {
            scale = 2;
         }
         clip.scaleX = scale;
         clip.scaleY = scale;
         apperaTimeDefault = appearTime != -1 ? appearTime : RewardConfig.getAppearTime();
         waitTimeDefault = waitTime != -1 ? waitTime : RewardConfig.getWaitTime();
         flyTimeDefault = flyTime != -1 ? flyTime : RewardConfig.getFlyTime();
         this.appearTime = apperaTimeDefault;
         this.waitTime = waitTimeDefault;
         this.flyTime = flyTimeDefault;
         effectTimer = 0;
         baseLoc = new Point(x,y);
         effectAnimTimeFactor = 0.6;
         effectOffset = new Point(Math.random() * 40 + 40,Math.random() * 10 + 40);
         effectAnimHeightFactor = 400 + Math.random() * 200;
         var directionLeft:Boolean = Math.random() * 2 == 0;
         if(directionLeft)
         {
            effectOffset.x *= -1;
         }
         LogicUpdater.register(this);
      }
      
      public function get finished() : Boolean
      {
         return _finished;
      }
      
      public function getMovieClip() : MovieClip
      {
         clip.play();
         return clip;
      }
      
      public function dispose() : void
      {
         LogicUpdater.unregister(this);
         if(clip)
         {
            clip.removeEventListener("mouseOver",mouseOver);
            if(clip.parent)
            {
               clip.parent.removeChild(clip);
            }
         }
      }
      
      public function logicUpdate(dt:int) : void
      {
         var dx:Number = NaN;
         var dy:Number = NaN;
         var speedAdjuster:Number = NaN;
         var t:Number = NaN;
         var f:Number = NaN;
         var prc:Number = NaN;
         var additionalTime:int = 0;
         var distX:int = 0;
         var distY:int = 0;
         var _loc3_:Number = NaN;
         if(appearTime > 0)
         {
            appearTime -= dt;
            speedAdjuster = 1.5 - (apperaTimeDefault - appearTime) / apperaTimeDefault;
            effectTimer += dt * speedAdjuster / 1000;
            t = effectTimer * effectAnimTimeFactor;
            t = Math.min(1,t);
            f = 3 * t;
            while(f > 1)
            {
               f -= 1;
            }
            dx = t * effectOffset.x;
            dy = (f * f - f) * effectAnimHeightFactor / (4 * t + 1) + t * effectOffset.y;
            clip.x = baseLoc.x + dx;
            clip.y = baseLoc.y + dy;
         }
         else if(waitTime > 0)
         {
            waitTime -= dt;
            if(waitTime <= 0)
            {
               clip.mouseEnabled = false;
               clip.mouseChildren = false;
            }
         }
         else if(flyTime > 0)
         {
            prc = (flyTimeDefault - flyTime) / flyTimeDefault;
            additionalTime = flyTimeDefault / 20 * prc;
            flyTime -= dt + additionalTime;
            distX = BattleManager.getLocalPlayer().container.x - clip.x;
            distY = BattleManager.getLocalPlayer().container.y - clip.y;
            dx = distX / flyTime * dt;
            dy = distY / flyTime * dt;
            if(Math.abs(distX) < Math.abs(dx))
            {
               dx = distX;
            }
            if(Math.abs(distY) < Math.abs(dy))
            {
               dy = distY;
            }
            _loc3_ = prc - 0.2 < 0 ? 0 : prc - 0.2;
            clip.scaleX = scale - scale * _loc3_;
            clip.scaleY = scale - scale * _loc3_;
            clip.x += dx;
            clip.y += dy;
         }
         else
         {
            _finished = true;
         }
      }
      
      private function mouseOver(e:MouseEvent) : void
      {
         clip.mouseEnabled = false;
         clip.mouseChildren = false;
         appearTime = 0;
         waitTime = 0;
      }
   }
}
