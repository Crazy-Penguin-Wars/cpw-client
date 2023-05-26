package com.dchoc.avatar.paperdoll.animations
{
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
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
      
      public function PaperDollAnimation(clip:MovieClip, showIntro:Boolean = true, loopAnim:Boolean = true, finishAnimCallback:Function = null)
      {
         super();
         this.finishAnimCallback = finishAnimCallback;
         this._clip = clip;
         this.loopAnim = loopAnim;
         name = clip.name;
         addChild(clip);
         start(showIntro);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         clean();
         finishAnimCallback = null;
         if(_clip)
         {
            removeChild(_clip);
            _clip = null;
         }
         for(i = numChildren - 1; i >= 0; )
         {
            removeChildAt(i);
            i--;
         }
      }
      
      private function start(showIntro:Boolean = true) : void
      {
         var _loc2_:int = DCUtils.indexOfLabel(_clip,"out");
         _clip.addFrameScript(_loc2_ != -1 ? _loc2_ : _clip.totalFrames - 1,outFrame);
         if(showIntro)
         {
            if(DCUtils.movieClipContainsLabel(_clip,"in"))
            {
               _clip.gotoAndPlay("in");
            }
            else
            {
               _clip.gotoAndPlay(0);
            }
         }
         else if(DCUtils.movieClipContainsLabel(_clip,"loop"))
         {
            _clip.gotoAndPlay("loop");
         }
         else
         {
            _clip.gotoAndPlay(0);
         }
      }
      
      private function getFrameLabel(labelName:String) : FrameLabel
      {
         var _loc2_:Array = _clip.currentLabels;
         for each(var label in _loc2_)
         {
            if(label.name == labelName)
            {
               return label;
            }
         }
         return null;
      }
      
      public function finish(callback:Function = null, showOutro:Boolean = true) : void
      {
         var _loc3_:* = null;
         finishAnim = true;
         finishAnimCallback = callback;
         if(showOutro)
         {
            _loc3_ = getFrameLabel("out");
            if(_loc3_)
            {
               if(_clip.currentFrame < _loc3_.frame)
               {
                  _clip.gotoAndPlay("out");
               }
            }
            else
            {
               onFinish();
            }
         }
         else
         {
            onFinish();
         }
      }
      
      private function onFinish() : void
      {
         var _loc1_:* = null;
         clean();
         if(finishAnimCallback != null)
         {
            _loc1_ = finishAnimCallback;
            finishAnimCallback = null;
            _loc1_();
         }
      }
      
      public function clean() : void
      {
         var _loc1_:int = 0;
         super.stop();
         if(_clip)
         {
            _clip.stop();
            _loc1_ = DCUtils.indexOfLabel(_clip,"out");
            _clip.addFrameScript(_loc1_ != -1 ? _loc1_ : _clip.totalFrames - 1,null);
         }
         finished = true;
      }
      
      public function isFinished() : Boolean
      {
         return finished;
      }
      
      private function outFrame() : void
      {
         if(!finishAnim && loopAnim)
         {
            try
            {
               if(DCUtils.movieClipContainsLabel(_clip,"loop"))
               {
                  _clip.gotoAndPlay("loop");
               }
               else
               {
                  _clip.gotoAndPlay(0);
               }
            }
            catch(e:Error)
            {
               LogUtils.log(e.message.toString());
               LogUtils.log(e.getStackTrace());
            }
            return;
         }
         onFinish();
      }
      
      public function getAnimationElapsedPercentage() : int
      {
         return _clip.currentFrame * 100 / _clip.totalFrames;
      }
      
      public function get clip() : MovieClip
      {
         return _clip;
      }
      
      public function isLooping() : Boolean
      {
         return loopAnim;
      }
      
      public function getCallback() : Function
      {
         return finishAnimCallback;
      }
      
      public function clearCallback() : void
      {
         finishAnimCallback = null;
      }
   }
}
