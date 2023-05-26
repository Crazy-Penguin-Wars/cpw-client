package starling.core
{
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import starling.display.Stage;
   import starling.events.KeyboardEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   internal class TouchProcessor
   {
      
      private static const MULTITAP_TIME:Number = 0.3;
      
      private static const MULTITAP_DISTANCE:Number = 25;
      
      private static var sProcessedTouchIDs:Vector.<int> = new Vector.<int>(0);
      
      private static var sHoveringTouchData:Vector.<Object> = new Vector.<Object>(0);
       
      
      private var mStage:Stage;
      
      private var mElapsedTime:Number;
      
      private var mTouchMarker:TouchMarker;
      
      private var mCurrentTouches:Vector.<Touch>;
      
      private var mQueue:Vector.<Array>;
      
      private var mLastTaps:Vector.<Touch>;
      
      private var mShiftDown:Boolean = false;
      
      private var mCtrlDown:Boolean = false;
      
      public function TouchProcessor(stage:Stage)
      {
         super();
         this.mStage = stage;
         this.mElapsedTime = 0;
         this.mCurrentTouches = new Vector.<Touch>(0);
         this.mQueue = new Vector.<Array>(0);
         this.mLastTaps = new Vector.<Touch>(0);
         this.mStage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         this.mStage.addEventListener(KeyboardEvent.KEY_UP,this.onKey);
         this.monitorInterruptions(true);
      }
      
      public function dispose() : void
      {
         this.monitorInterruptions(false);
         this.mStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         this.mStage.removeEventListener(KeyboardEvent.KEY_UP,this.onKey);
         if(Boolean(this.mTouchMarker))
         {
            this.mTouchMarker.dispose();
         }
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         var i:int = 0;
         var touchID:int = 0;
         var touch:Touch = null;
         var touchEvent:TouchEvent = null;
         var touchData:Object = null;
         var touchArgs:Array = null;
         this.mElapsedTime += passedTime;
         if(this.mLastTaps.length > 0)
         {
            for(i = this.mLastTaps.length - 1; i >= 0; i--)
            {
               if(this.mElapsedTime - this.mLastTaps[i].timestamp > MULTITAP_TIME)
               {
                  this.mLastTaps.splice(i,1);
               }
            }
         }
         while(this.mQueue.length > 0)
         {
            sProcessedTouchIDs.length = sHoveringTouchData.length = 0;
            for each(touch in this.mCurrentTouches)
            {
               if(touch.phase == TouchPhase.BEGAN || touch.phase == TouchPhase.MOVED)
               {
                  touch.starling_internal::setPhase(TouchPhase.STATIONARY);
               }
            }
            while(this.mQueue.length > 0 && sProcessedTouchIDs.indexOf(this.mQueue[this.mQueue.length - 1][0]) == -1)
            {
               touchArgs = this.mQueue.pop();
               touchID = touchArgs[0] as int;
               touch = this.getCurrentTouch(touchID);
               if(touch && touch.phase == TouchPhase.HOVER && Boolean(touch.target))
               {
                  sHoveringTouchData.push({
                     "touch":touch,
                     "target":touch.target,
                     "bubbleChain":touch.starling_internal::bubbleChain
                  });
               }
               this.processTouch.apply(this,touchArgs);
               sProcessedTouchIDs.push(touchID);
            }
            touchEvent = new TouchEvent(TouchEvent.TOUCH,this.mCurrentTouches,this.mShiftDown,this.mCtrlDown);
            for each(touchData in sHoveringTouchData)
            {
               if(touchData.touch.target != touchData.target)
               {
                  touchEvent.starling_internal::dispatch(touchData.bubbleChain);
               }
            }
            for each(touchID in sProcessedTouchIDs)
            {
               this.getCurrentTouch(touchID).starling_internal::dispatchEvent(touchEvent);
            }
            for(i = this.mCurrentTouches.length - 1; i >= 0; i--)
            {
               if(this.mCurrentTouches[i].phase == TouchPhase.ENDED)
               {
                  this.mCurrentTouches.splice(i,1);
               }
            }
         }
      }
      
      public function enqueue(touchID:int, phase:String, globalX:Number, globalY:Number, pressure:Number = 1, width:Number = 1, height:Number = 1) : void
      {
         this.mQueue.unshift(arguments);
         if(this.mCtrlDown && this.simulateMultitouch && touchID == 0)
         {
            this.mTouchMarker.moveMarker(globalX,globalY,this.mShiftDown);
            this.mQueue.unshift([1,phase,this.mTouchMarker.mockX,this.mTouchMarker.mockY]);
         }
      }
      
      public function enqueueMouseLeftStage() : void
      {
         var mouse:Touch = this.getCurrentTouch(0);
         if(mouse == null || mouse.phase != TouchPhase.HOVER)
         {
            return;
         }
         var exitX:Number = mouse.globalX;
         var exitY:Number = mouse.globalY;
         var distLeft:Number = mouse.globalX;
         var distRight:Number = this.mStage.stageWidth - distLeft;
         var distTop:Number = mouse.globalY;
         var distBottom:Number = this.mStage.stageHeight - distTop;
         var minDist:Number = Math.min(distLeft,distRight,distTop,distBottom);
         if(minDist == distLeft)
         {
            exitX = -1;
         }
         else if(minDist == distRight)
         {
            exitX = this.mStage.stageWidth + 1;
         }
         else if(minDist == distTop)
         {
            exitY = -1;
         }
         else
         {
            exitY = this.mStage.stageHeight + 1;
         }
         this.enqueue(0,TouchPhase.HOVER,exitX,exitY);
      }
      
      private function processTouch(touchID:int, phase:String, globalX:Number, globalY:Number, pressure:Number = 1, width:Number = 1, height:Number = 1) : void
      {
         var position:Point = new Point(globalX,globalY);
         var touch:Touch = this.getCurrentTouch(touchID);
         if(touch == null)
         {
            touch = new Touch(touchID,globalX,globalY,phase,null);
            this.addCurrentTouch(touch);
         }
         touch.starling_internal::setPosition(globalX,globalY);
         touch.starling_internal::setPhase(phase);
         touch.starling_internal::setTimestamp(this.mElapsedTime);
         touch.starling_internal::setPressure(pressure);
         touch.starling_internal::setSize(width,height);
         if(phase == TouchPhase.HOVER || phase == TouchPhase.BEGAN)
         {
            touch.starling_internal::setTarget(this.mStage.hitTest(position,true));
         }
         if(phase == TouchPhase.BEGAN)
         {
            this.processTap(touch);
         }
      }
      
      private function onKey(event:KeyboardEvent) : void
      {
         var wasCtrlDown:Boolean = false;
         var mouseTouch:Touch = null;
         var mockedTouch:Touch = null;
         if(event.keyCode == 17 || event.keyCode == 15)
         {
            wasCtrlDown = this.mCtrlDown;
            this.mCtrlDown = event.type == KeyboardEvent.KEY_DOWN;
            if(this.simulateMultitouch && wasCtrlDown != this.mCtrlDown)
            {
               this.mTouchMarker.visible = this.mCtrlDown;
               this.mTouchMarker.moveCenter(this.mStage.stageWidth / 2,this.mStage.stageHeight / 2);
               mouseTouch = this.getCurrentTouch(0);
               mockedTouch = this.getCurrentTouch(1);
               if(Boolean(mouseTouch))
               {
                  this.mTouchMarker.moveMarker(mouseTouch.globalX,mouseTouch.globalY);
               }
               if(wasCtrlDown && mockedTouch && mockedTouch.phase != TouchPhase.ENDED)
               {
                  this.mQueue.unshift([1,TouchPhase.ENDED,mockedTouch.globalX,mockedTouch.globalY]);
               }
               else if(this.mCtrlDown && Boolean(mouseTouch))
               {
                  if(mouseTouch.phase == TouchPhase.HOVER || mouseTouch.phase == TouchPhase.ENDED)
                  {
                     this.mQueue.unshift([1,TouchPhase.HOVER,this.mTouchMarker.mockX,this.mTouchMarker.mockY]);
                  }
                  else
                  {
                     this.mQueue.unshift([1,TouchPhase.BEGAN,this.mTouchMarker.mockX,this.mTouchMarker.mockY]);
                  }
               }
            }
         }
         else if(event.keyCode == 16)
         {
            this.mShiftDown = event.type == KeyboardEvent.KEY_DOWN;
         }
      }
      
      private function processTap(touch:Touch) : void
      {
         var tap:Touch = null;
         var sqDist:Number = NaN;
         var nearbyTap:Touch = null;
         var minSqDist:Number = MULTITAP_DISTANCE * MULTITAP_DISTANCE;
         for each(tap in this.mLastTaps)
         {
            sqDist = Math.pow(tap.globalX - touch.globalX,2) + Math.pow(tap.globalY - touch.globalY,2);
            if(sqDist <= minSqDist)
            {
               nearbyTap = tap;
               break;
            }
         }
         if(Boolean(nearbyTap))
         {
            touch.starling_internal::setTapCount(nearbyTap.tapCount + 1);
            this.mLastTaps.splice(this.mLastTaps.indexOf(nearbyTap),1);
         }
         else
         {
            touch.starling_internal::setTapCount(1);
         }
         this.mLastTaps.push(touch.clone());
      }
      
      private function addCurrentTouch(touch:Touch) : void
      {
         for(var i:int = this.mCurrentTouches.length - 1; i >= 0; i--)
         {
            if(this.mCurrentTouches[i].id == touch.id)
            {
               this.mCurrentTouches.splice(i,1);
            }
         }
         this.mCurrentTouches.push(touch);
      }
      
      private function getCurrentTouch(touchID:int) : Touch
      {
         var touch:Touch = null;
         for each(touch in this.mCurrentTouches)
         {
            if(touch.id == touchID)
            {
               return touch;
            }
         }
         return null;
      }
      
      public function get simulateMultitouch() : Boolean
      {
         return this.mTouchMarker != null;
      }
      
      public function set simulateMultitouch(value:Boolean) : void
      {
         if(this.simulateMultitouch == value)
         {
            return;
         }
         if(value)
         {
            this.mTouchMarker = new TouchMarker();
            this.mTouchMarker.visible = false;
            this.mStage.addChild(this.mTouchMarker);
         }
         else
         {
            this.mTouchMarker.removeFromParent(true);
            this.mTouchMarker = null;
         }
      }
      
      private function monitorInterruptions(enable:Boolean) : void
      {
         var nativeAppClass:Object = null;
         var nativeApp:Object = null;
         try
         {
            nativeAppClass = getDefinitionByName("flash.desktop::NativeApplication");
            nativeApp = nativeAppClass["nativeApplication"];
            if(enable)
            {
               nativeApp.addEventListener("deactivate",this.onInterruption,false,0,true);
            }
            else
            {
               nativeApp.removeEventListener("activate",this.onInterruption);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onInterruption(event:Object) : void
      {
         var touch:Touch = null;
         var touchEvent:TouchEvent = null;
         for each(touch in this.mCurrentTouches)
         {
            if(touch.phase == TouchPhase.BEGAN || touch.phase == TouchPhase.MOVED || touch.phase == TouchPhase.STATIONARY)
            {
               touch.starling_internal::setPhase(TouchPhase.ENDED);
            }
         }
         touchEvent = new TouchEvent(TouchEvent.TOUCH,this.mCurrentTouches,this.mShiftDown,this.mCtrlDown);
         for each(touch in this.mCurrentTouches)
         {
            touch.starling_internal::dispatchEvent(touchEvent);
         }
         this.mCurrentTouches.length = 0;
      }
   }
}
