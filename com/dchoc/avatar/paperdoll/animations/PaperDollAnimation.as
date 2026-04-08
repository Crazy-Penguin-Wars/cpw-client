package com.dchoc.avatar.paperdoll.animations
{
   import com.dchoc.utils.*;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   
   public class PaperDollAnimation extends MovieClip
   {
      private const FRAME_LABEL_IN:String = "in";
      
      private const FRAME_LABEL_LOOP:String = "loop";
      
      private const FRAME_LABEL_OUT:String = "out";
      
      private var loopAnim:Boolean;
      
      private var finishAnim:Boolean;
      
      private var finishAnimCallback:Function;
      
      private var _clip:MovieClip;
      
      private var finished:Boolean;
      
      public function PaperDollAnimation(param1:MovieClip, param2:Boolean = true, param3:Boolean = true, param4:Function = null)
      {
         super();
         this.finishAnimCallback = param4;
         this._clip = param1;
         this.loopAnim = param3;
         name = param1.name;
         addChild(param1);
         this.start(param2);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         this.clean();
         this.finishAnimCallback = null;
         if(this._clip)
         {
            removeChild(this._clip);
            this._clip = null;
         }
         _loc1_ = numChildren - 1;
         while(_loc1_ >= 0)
         {
            removeChildAt(_loc1_);
            _loc1_--;
         }
      }
      
      private function start(param1:Boolean = true) : void
      {
         var _loc2_:int = int(DCUtils.indexOfLabel(this._clip,"out"));
         this._clip.addFrameScript(_loc2_ != -1 ? _loc2_ : this._clip.totalFrames - 1,this.outFrame);
         if(param1)
         {
            if(DCUtils.movieClipContainsLabel(this._clip,"in"))
            {
               this._clip.gotoAndPlay("in");
            }
            else
            {
               this._clip.gotoAndPlay(0);
            }
         }
         else if(DCUtils.movieClipContainsLabel(this._clip,"loop"))
         {
            this._clip.gotoAndPlay("loop");
         }
         else
         {
            this._clip.gotoAndPlay(0);
         }
      }
      
      private function getFrameLabel(param1:String) : FrameLabel
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = this._clip.currentLabels;
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function finish(param1:Function = null, param2:Boolean = true) : void
      {
         var _loc3_:FrameLabel = null;
         this.finishAnim = true;
         this.finishAnimCallback = param1;
         if(param2)
         {
            _loc3_ = this.getFrameLabel("out");
            if(_loc3_)
            {
               if(this._clip.currentFrame < _loc3_.frame)
               {
                  this._clip.gotoAndPlay("out");
               }
            }
            else
            {
               this.onFinish();
            }
         }
         else
         {
            this.onFinish();
         }
      }
      
      private function onFinish() : void
      {
         var _loc1_:Function = null;
         this.clean();
         if(this.finishAnimCallback != null)
         {
            _loc1_ = this.finishAnimCallback;
            this.finishAnimCallback = null;
            _loc1_();
         }
      }
      
      public function clean() : void
      {
         var _loc1_:int = 0;
         super.stop();
         if(this._clip)
         {
            this._clip.stop();
            _loc1_ = int(DCUtils.indexOfLabel(this._clip,"out"));
            this._clip.addFrameScript(_loc1_ != -1 ? _loc1_ : this._clip.totalFrames - 1,null);
         }
         this.finished = true;
      }
      
      public function isFinished() : Boolean
      {
         return this.finished;
      }
      
      private function outFrame() : void
      {
         if(!this.finishAnim && Boolean(this.loopAnim))
         {
            try
            {
               if(DCUtils.movieClipContainsLabel(this._clip,"loop"))
               {
                  this._clip.gotoAndPlay("loop");
               }
               else
               {
                  this._clip.gotoAndPlay(0);
               }
            }
            catch(e:Error)
            {
               LogUtils.log(e.message.toString());
               LogUtils.log(e.getStackTrace());
            }
            return;
         }
         this.onFinish();
      }
      
      public function getAnimationElapsedPercentage() : int
      {
         return this._clip.currentFrame * 100 / this._clip.totalFrames;
      }
      
      public function get clip() : MovieClip
      {
         return this._clip;
      }
      
      public function isLooping() : Boolean
      {
         return this.loopAnim;
      }
      
      public function getCallback() : Function
      {
         return this.finishAnimCallback;
      }
      
      public function clearCallback() : void
      {
         this.finishAnimCallback = null;
      }
   }
}

