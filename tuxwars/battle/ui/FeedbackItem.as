package tuxwars.battle.ui
{
   import com.dchoc.game.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.*;
   import tuxwars.battle.*;
   import tuxwars.battle.world.TuxWorld;
   import tuxwars.data.*;
   
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
      
      public function FeedbackItem(param1:String, param2:Number, param3:Number, param4:int, param5:Number, param6:Number, param7:int = -1, param8:int = -1, param9:int = -1, param10:String = null, param11:String = null, param12:MovieClip = null)
      {
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         super();
         if(param12 != null)
         {
            this.clip = param12;
         }
         else if(param10 != null && param11 != null)
         {
            this.clip = DCResourceManager.instance.getFromSWF(param10,param11);
         }
         else
         {
            this.clip = DCResourceManager.instance.getFromSWF("flash/ui/icons_drops.swf",param1);
         }
         if(!this.clip)
         {
            LogUtils.log("No clip for feedback item, type: " + param1 + " swf: " + param10 + " export: " + param11,"FeedbackItem",3,"Assets",true,true,true);
         }
         this.clip.mouseEnabled = true;
         this.clip.addEventListener("mouseOver",this.mouseOver,false,0,true);
         this.clip.x = param2;
         this.clip.y = param3;
         if(param4 <= 50)
         {
            this.scale = 1 + param4 / 50;
         }
         else
         {
            this.scale = 2;
         }
         this.clip.scaleX = this.scale;
         this.clip.scaleY = this.scale;
         this.apperaTimeDefault = param7 != -1 ? param7 : int(RewardConfig.getAppearTime());
         this.waitTimeDefault = param8 != -1 ? param8 : int(RewardConfig.getWaitTime());
         this.flyTimeDefault = param9 != -1 ? param9 : int(RewardConfig.getFlyTime());
         this.appearTime = this.apperaTimeDefault;
         this.waitTime = this.waitTimeDefault;
         this.flyTime = this.flyTimeDefault;
         this.effectTimer = 0;
         this.baseLoc = new Point(param2,param3);
         this.effectAnimTimeFactor = 0.6;
         this.effectOffset = new Point(Math.random() * 40 + 40,Math.random() * 10 + 40);
         this.effectAnimHeightFactor = 400 + Math.random() * 200;
         var _loc15_:* = int(Math.random() * 2) == 0;
         if(_loc15_)
         {
            this.effectOffset.x *= -1;
         }
         LogicUpdater.register(this);
      }
      
      public function get finished() : Boolean
      {
         return this._finished;
      }
      
      public function getMovieClip() : MovieClip
      {
         this.clip.play();
         return this.clip;
      }
      
      public function dispose() : void
      {
         LogicUpdater.unregister(this);
         if(this.clip)
         {
            this.clip.removeEventListener("mouseOver",this.mouseOver);
            if(this.clip.parent)
            {
               this.clip.parent.removeChild(this.clip);
            }
         }
      }
      
      public function logicUpdate(param1:int) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Number = Number(NaN);
         if(this.appearTime > 0)
         {
            this.appearTime -= param1;
            _loc4_ = 1.5 - (this.apperaTimeDefault - this.appearTime) / this.apperaTimeDefault;
            this.effectTimer += param1 * _loc4_ / 1000;
            _loc5_ = this.effectTimer * this.effectAnimTimeFactor;
            _loc5_ = Math.min(1,_loc5_);
            _loc6_ = 3 * _loc5_;
            while(_loc6_ > 1)
            {
               _loc6_--;
            }
            _loc2_ = _loc5_ * this.effectOffset.x;
            _loc3_ = (_loc6_ * _loc6_ - _loc6_) * this.effectAnimHeightFactor / (4 * _loc5_ + 1) + _loc5_ * this.effectOffset.y;
            this.clip.x = this.baseLoc.x + _loc2_;
            this.clip.y = this.baseLoc.y + _loc3_;
         }
         else if(this.waitTime > 0)
         {
            this.waitTime -= param1;
            if(this.waitTime <= 0)
            {
               this.clip.mouseEnabled = false;
               this.clip.mouseChildren = false;
            }
         }
         else if(this.flyTime > 0)
         {
            _loc7_ = (this.flyTimeDefault - this.flyTime) / this.flyTimeDefault;
            _loc8_ = this.flyTimeDefault / 20 * _loc7_;
            this.flyTime -= param1 + _loc8_;
            _loc9_ = BattleManager.getLocalPlayer().container.x - this.clip.x;
            _loc10_ = BattleManager.getLocalPlayer().container.y - this.clip.y;
            _loc2_ = _loc9_ / this.flyTime * param1;
            _loc3_ = _loc10_ / this.flyTime * param1;
            if(Math.abs(_loc9_) < Math.abs(_loc2_))
            {
               _loc2_ = _loc9_;
            }
            if(Math.abs(_loc10_) < Math.abs(_loc3_))
            {
               _loc3_ = _loc10_;
            }
            _loc11_ = _loc7_ - 0.2 < 0 ? 0 : _loc7_ - 0.2;
            this.clip.scaleX = this.scale - this.scale * _loc11_;
            this.clip.scaleY = this.scale - this.scale * _loc11_;
            this.clip.x += _loc2_;
            this.clip.y += _loc3_;
         }
         else
         {
            this._finished = true;
         }
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         this.clip.mouseEnabled = false;
         this.clip.mouseChildren = false;
         this.appearTime = 0;
         this.waitTime = 0;
      }
   }
}

