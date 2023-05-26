package starling.display
{
   import flash.errors.IllegalOperationError;
   import flash.media.Sound;
   import starling.animation.IAnimatable;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class MovieClip extends Image implements IAnimatable
   {
       
      
      private var mTextures:Vector.<Texture>;
      
      private var mSounds:Vector.<Sound>;
      
      private var mDurations:Vector.<Number>;
      
      private var mStartTimes:Vector.<Number>;
      
      private var mDefaultFrameDuration:Number;
      
      private var mTotalTime:Number;
      
      private var mCurrentTime:Number;
      
      private var mCurrentFrame:int;
      
      private var mLoop:Boolean;
      
      private var mPlaying:Boolean;
      
      public function MovieClip(textures:Vector.<Texture>, fps:Number = 12)
      {
         if(textures.length > 0)
         {
            super(textures[0]);
            this.init(textures,fps);
            return;
         }
         throw new ArgumentError("Empty texture array");
      }
      
      private function init(textures:Vector.<Texture>, fps:Number) : void
      {
         if(fps <= 0)
         {
            throw new ArgumentError("Invalid fps: " + fps);
         }
         var numFrames:int = textures.length;
         this.mDefaultFrameDuration = 1 / fps;
         this.mLoop = true;
         this.mPlaying = true;
         this.mCurrentTime = 0;
         this.mCurrentFrame = 0;
         this.mTotalTime = this.mDefaultFrameDuration * numFrames;
         this.mTextures = textures.concat();
         this.mSounds = new Vector.<Sound>(numFrames);
         this.mDurations = new Vector.<Number>(numFrames);
         this.mStartTimes = new Vector.<Number>(numFrames);
         for(var i:int = 0; i < numFrames; i++)
         {
            this.mDurations[i] = this.mDefaultFrameDuration;
            this.mStartTimes[i] = i * this.mDefaultFrameDuration;
         }
      }
      
      public function addFrame(texture:Texture, sound:Sound = null, duration:Number = -1) : void
      {
         this.addFrameAt(this.numFrames,texture,sound,duration);
      }
      
      public function addFrameAt(frameID:int, texture:Texture, sound:Sound = null, duration:Number = -1) : void
      {
         if(frameID < 0 || frameID > this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         if(duration < 0)
         {
            duration = this.mDefaultFrameDuration;
         }
         this.mTextures.splice(frameID,0,texture);
         this.mSounds.splice(frameID,0,sound);
         this.mDurations.splice(frameID,0,duration);
         this.mTotalTime += duration;
         if(frameID > 0 && frameID == this.numFrames)
         {
            this.mStartTimes[frameID] = this.mStartTimes[frameID - 1] + this.mDurations[frameID - 1];
         }
         else
         {
            this.updateStartTimes();
         }
      }
      
      public function removeFrameAt(frameID:int) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         if(this.numFrames == 1)
         {
            throw new IllegalOperationError("Movie clip must not be empty");
         }
         this.mTotalTime -= this.getFrameDuration(frameID);
         this.mTextures.splice(frameID,1);
         this.mSounds.splice(frameID,1);
         this.mDurations.splice(frameID,1);
         this.updateStartTimes();
      }
      
      public function getFrameTexture(frameID:int) : Texture
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         return this.mTextures[frameID];
      }
      
      public function setFrameTexture(frameID:int, texture:Texture) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         this.mTextures[frameID] = texture;
      }
      
      public function getFrameSound(frameID:int) : Sound
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         return this.mSounds[frameID];
      }
      
      public function setFrameSound(frameID:int, sound:Sound) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         this.mSounds[frameID] = sound;
      }
      
      public function getFrameDuration(frameID:int) : Number
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         return this.mDurations[frameID];
      }
      
      public function setFrameDuration(frameID:int, duration:Number) : void
      {
         if(frameID < 0 || frameID >= this.numFrames)
         {
            throw new ArgumentError("Invalid frame id");
         }
         this.mTotalTime -= this.getFrameDuration(frameID);
         this.mTotalTime += duration;
         this.mDurations[frameID] = duration;
         this.updateStartTimes();
      }
      
      public function play() : void
      {
         this.mPlaying = true;
      }
      
      public function pause() : void
      {
         this.mPlaying = false;
      }
      
      public function stop() : void
      {
         this.mPlaying = false;
         this.currentFrame = 0;
      }
      
      private function updateStartTimes() : void
      {
         var numFrames:int = this.numFrames;
         this.mStartTimes.length = 0;
         this.mStartTimes[0] = 0;
         for(var i:int = 1; i < numFrames; i++)
         {
            this.mStartTimes[i] = this.mStartTimes[i - 1] + this.mDurations[i - 1];
         }
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var finalFrame:int = 0;
         var sound:Sound = null;
         var previousFrame:int = this.mCurrentFrame;
         var restTime:Number = 0;
         var breakAfterFrame:Boolean = false;
         if(this.mLoop && this.mCurrentTime == this.mTotalTime)
         {
            this.mCurrentTime = 0;
            this.mCurrentFrame = 0;
         }
         if(this.mPlaying && passedTime > 0 && this.mCurrentTime < this.mTotalTime)
         {
            this.mCurrentTime += passedTime;
            finalFrame = this.mTextures.length - 1;
            while(this.mCurrentTime >= this.mStartTimes[this.mCurrentFrame] + this.mDurations[this.mCurrentFrame])
            {
               if(this.mCurrentFrame == finalFrame)
               {
                  if(hasEventListener(Event.COMPLETE))
                  {
                     if(this.mCurrentFrame != previousFrame)
                     {
                        texture = this.mTextures[this.mCurrentFrame];
                     }
                     restTime = this.mCurrentTime - this.mTotalTime;
                     this.mCurrentTime = this.mTotalTime;
                     dispatchEventWith(Event.COMPLETE);
                     breakAfterFrame = true;
                  }
                  if(this.mLoop)
                  {
                     this.mCurrentTime -= this.mTotalTime;
                     this.mCurrentFrame = 0;
                  }
                  else
                  {
                     this.mCurrentTime = this.mTotalTime;
                     breakAfterFrame = true;
                  }
               }
               else
               {
                  ++this.mCurrentFrame;
               }
               sound = this.mSounds[this.mCurrentFrame];
               if(Boolean(sound))
               {
                  sound.play();
               }
               if(breakAfterFrame)
               {
                  break;
               }
            }
         }
         if(this.mCurrentFrame != previousFrame)
         {
            texture = this.mTextures[this.mCurrentFrame];
         }
         if(Boolean(restTime))
         {
            this.advanceTime(restTime);
         }
      }
      
      public function get isComplete() : Boolean
      {
         return !this.mLoop && this.mCurrentTime >= this.mTotalTime;
      }
      
      public function get totalTime() : Number
      {
         return this.mTotalTime;
      }
      
      public function get numFrames() : int
      {
         return this.mTextures.length;
      }
      
      public function get loop() : Boolean
      {
         return this.mLoop;
      }
      
      public function set loop(value:Boolean) : void
      {
         this.mLoop = value;
      }
      
      public function get currentFrame() : int
      {
         return this.mCurrentFrame;
      }
      
      public function set currentFrame(value:int) : void
      {
         this.mCurrentFrame = value;
         this.mCurrentTime = 0;
         for(var i:int = 0; i < value; i++)
         {
            this.mCurrentTime += this.getFrameDuration(i);
         }
         texture = this.mTextures[this.mCurrentFrame];
         if(Boolean(this.mSounds[this.mCurrentFrame]))
         {
            this.mSounds[this.mCurrentFrame].play();
         }
      }
      
      public function get fps() : Number
      {
         return 1 / this.mDefaultFrameDuration;
      }
      
      public function set fps(value:Number) : void
      {
         var duration:Number = NaN;
         if(value <= 0)
         {
            throw new ArgumentError("Invalid fps: " + value);
         }
         var newFrameDuration:Number = 1 / value;
         var acceleration:Number = newFrameDuration / this.mDefaultFrameDuration;
         this.mCurrentTime *= acceleration;
         this.mDefaultFrameDuration = newFrameDuration;
         for(var i:int = 0; i < this.numFrames; i++)
         {
            duration = this.mDurations[i] * acceleration;
            this.mTotalTime = this.mTotalTime - this.mDurations[i] + duration;
            this.mDurations[i] = duration;
         }
         this.updateStartTimes();
      }
      
      public function get isPlaying() : Boolean
      {
         if(this.mPlaying)
         {
            return this.mLoop || this.mCurrentTime < this.mTotalTime;
         }
         return false;
      }
   }
}
