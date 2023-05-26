package starling.core
{
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.Stage3D;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DCompareMode;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.Program3D;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Mouse;
   import flash.ui.Multitouch;
   import flash.ui.MultitouchInputMode;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import starling.animation.Juggler;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.events.KeyboardEvent;
   import starling.events.ResizeEvent;
   import starling.events.TouchPhase;
   import starling.utils.HAlign;
   import starling.utils.VAlign;
   
   public class Starling extends EventDispatcher
   {
      
      public static const VERSION:String = "1.3";
      
      private static const PROGRAM_DATA_NAME:String = "Starling.programs";
      
      private static var sCurrent:Starling;
      
      private static var sHandleLostContext:Boolean;
      
      private static var sContextData:Dictionary = new Dictionary(true);
       
      
      private var mStage3D:Stage3D;
      
      private var mStage:starling.display.Stage;
      
      private var mRootClass:Class;
      
      private var mRoot:DisplayObject;
      
      private var mJuggler:Juggler;
      
      private var mStarted:Boolean;
      
      private var mSupport:RenderSupport;
      
      private var mTouchProcessor:TouchProcessor;
      
      private var mAntiAliasing:int;
      
      private var mSimulateMultitouch:Boolean;
      
      private var mEnableErrorChecking:Boolean;
      
      private var mLastFrameTimestamp:Number;
      
      private var mLeftMouseDown:Boolean;
      
      private var mStatsDisplay:StatsDisplay;
      
      private var mShareContext:Boolean;
      
      private var mProfile:String;
      
      private var mContext:Context3D;
      
      private var mViewPort:Rectangle;
      
      private var mPreviousViewPort:Rectangle;
      
      private var mClippedViewPort:Rectangle;
      
      private var mNativeStage:flash.display.Stage;
      
      private var mNativeOverlay:Sprite;
      
      public function Starling(rootClass:Class, stage:flash.display.Stage, viewPort:Rectangle = null, stage3D:Stage3D = null, renderMode:String = "auto", profile:String = "baselineConstrained")
      {
         var touchEventType:String = null;
         var requestContext3D:Function = null;
         super();
         if(stage == null)
         {
            throw new ArgumentError("Stage must not be null");
         }
         if(rootClass == null)
         {
            throw new ArgumentError("Root class must not be null");
         }
         if(viewPort == null)
         {
            viewPort = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
         }
         if(stage3D == null)
         {
            stage3D = stage.stage3Ds[0];
         }
         this.makeCurrent();
         this.mRootClass = rootClass;
         this.mViewPort = viewPort;
         this.mPreviousViewPort = new Rectangle();
         this.mStage3D = stage3D;
         this.mStage = new starling.display.Stage(viewPort.width,viewPort.height,stage.color);
         this.mNativeOverlay = new Sprite();
         this.mNativeStage = stage;
         this.mNativeStage.addChild(this.mNativeOverlay);
         this.mTouchProcessor = new TouchProcessor(this.mStage);
         this.mJuggler = new Juggler();
         this.mAntiAliasing = 0;
         this.mSimulateMultitouch = false;
         this.mEnableErrorChecking = false;
         this.mProfile = profile;
         this.mLastFrameTimestamp = getTimer() / 1000;
         this.mSupport = new RenderSupport();
         sContextData[stage3D] = new Dictionary();
         sContextData[stage3D][PROGRAM_DATA_NAME] = new Dictionary();
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         for each(touchEventType in this.touchEventTypes)
         {
            stage.addEventListener(touchEventType,this.onTouch,false,0,true);
         }
         stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKey,false,0,true);
         stage.addEventListener(Event.RESIZE,this.onResize,false,0,true);
         stage.addEventListener(Event.MOUSE_LEAVE,this.onMouseLeave,false,0,true);
         this.mStage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false,10,true);
         this.mStage3D.addEventListener(ErrorEvent.ERROR,this.onStage3DError,false,10,true);
         if(Boolean(this.mStage3D.context3D) && this.mStage3D.context3D.driverInfo != "Disposed")
         {
            this.mShareContext = true;
            setTimeout(this.initialize,1);
         }
         else
         {
            this.mShareContext = false;
            try
            {
               requestContext3D = this.mStage3D.requestContext3D;
               if(requestContext3D.length == 1)
               {
                  requestContext3D(renderMode);
               }
               else
               {
                  requestContext3D(renderMode,profile);
               }
            }
            catch(e:Error)
            {
               showFatalError("Context3D error: " + e.message);
            }
         }
      }
      
      public static function get current() : Starling
      {
         return sCurrent;
      }
      
      public static function get context() : Context3D
      {
         return Boolean(sCurrent) ? sCurrent.context : null;
      }
      
      public static function get juggler() : Juggler
      {
         return Boolean(sCurrent) ? sCurrent.juggler : null;
      }
      
      public static function get contentScaleFactor() : Number
      {
         return Boolean(sCurrent) ? sCurrent.contentScaleFactor : 1;
      }
      
      public static function get multitouchEnabled() : Boolean
      {
         return Multitouch.inputMode == MultitouchInputMode.TOUCH_POINT;
      }
      
      public static function set multitouchEnabled(value:Boolean) : void
      {
         if(Boolean(sCurrent))
         {
            throw new IllegalOperationError("\'multitouchEnabled\' must be set before Starling instance is created");
         }
         Multitouch.inputMode = value ? MultitouchInputMode.TOUCH_POINT : MultitouchInputMode.NONE;
      }
      
      public static function get handleLostContext() : Boolean
      {
         return sHandleLostContext;
      }
      
      public static function set handleLostContext(value:Boolean) : void
      {
         if(Boolean(sCurrent))
         {
            throw new IllegalOperationError("\'handleLostContext\' must be set before Starling instance is created");
         }
         sHandleLostContext = value;
      }
      
      public function dispose() : void
      {
         var touchEventType:String = null;
         this.stop();
         this.mNativeStage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame,false);
         this.mNativeStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKey,false);
         this.mNativeStage.removeEventListener(KeyboardEvent.KEY_UP,this.onKey,false);
         this.mNativeStage.removeEventListener(Event.RESIZE,this.onResize,false);
         this.mNativeStage.removeEventListener(Event.MOUSE_LEAVE,this.onMouseLeave,false);
         this.mNativeStage.removeChild(this.mNativeOverlay);
         this.mStage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContextCreated,false);
         this.mStage3D.removeEventListener(ErrorEvent.ERROR,this.onStage3DError,false);
         for each(touchEventType in this.touchEventTypes)
         {
            this.mNativeStage.removeEventListener(touchEventType,this.onTouch,false);
         }
         if(Boolean(this.mStage))
         {
            this.mStage.dispose();
         }
         if(Boolean(this.mSupport))
         {
            this.mSupport.dispose();
         }
         if(Boolean(this.mTouchProcessor))
         {
            this.mTouchProcessor.dispose();
         }
         if(Boolean(this.mContext) && !this.mShareContext)
         {
            this.mContext.dispose();
         }
         if(sCurrent == this)
         {
            sCurrent = null;
         }
      }
      
      private function initialize() : void
      {
         this.makeCurrent();
         this.initializeGraphicsAPI();
         this.initializeRoot();
         this.mTouchProcessor.simulateMultitouch = this.mSimulateMultitouch;
         this.mLastFrameTimestamp = getTimer() / 1000;
      }
      
      private function initializeGraphicsAPI() : void
      {
         this.mContext = this.mStage3D.context3D;
         this.mContext.enableErrorChecking = this.mEnableErrorChecking;
         this.contextData[PROGRAM_DATA_NAME] = new Dictionary();
         this.updateViewPort(true);
         trace("[Starling] Initialization complete.");
         trace("[Starling] Display Driver:",this.mContext.driverInfo);
         dispatchEventWith(Event.CONTEXT3D_CREATE,false,this.mContext);
      }
      
      private function initializeRoot() : void
      {
         if(this.mRoot == null)
         {
            this.mRoot = new this.mRootClass() as DisplayObject;
            if(this.mRoot == null)
            {
               throw new Error("Invalid root class: " + this.mRootClass);
            }
            this.mStage.addChildAt(this.mRoot,0);
            dispatchEventWith(Event.ROOT_CREATED,false,this.mRoot);
         }
      }
      
      public function nextFrame() : void
      {
         var now:Number = getTimer() / 1000;
         var passedTime:Number = now - this.mLastFrameTimestamp;
         this.mLastFrameTimestamp = now;
         this.advanceTime(passedTime);
         this.render();
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         this.makeCurrent();
         this.mTouchProcessor.advanceTime(passedTime);
         this.mStage.advanceTime(passedTime);
         this.mJuggler.advanceTime(passedTime);
      }
      
      public function render() : void
      {
         if(!this.contextValid)
         {
            return;
         }
         this.makeCurrent();
         this.updateViewPort();
         this.updateNativeOverlay();
         this.mSupport.nextFrame();
         if(!this.mShareContext)
         {
            RenderSupport.clear(this.mStage.color,1);
         }
         var scaleX:Number = this.mViewPort.width / this.mStage.stageWidth;
         var scaleY:Number = this.mViewPort.height / this.mStage.stageHeight;
         this.mContext.setDepthTest(false,Context3DCompareMode.ALWAYS);
         this.mContext.setCulling(Context3DTriangleFace.NONE);
         this.mSupport.renderTarget = null;
         this.mSupport.setOrthographicProjection(this.mViewPort.x < 0 ? -this.mViewPort.x / scaleX : 0,this.mViewPort.y < 0 ? -this.mViewPort.y / scaleY : 0,this.mClippedViewPort.width / scaleX,this.mClippedViewPort.height / scaleY);
         this.mStage.render(this.mSupport,1);
         this.mSupport.finishQuadBatch();
         if(Boolean(this.mStatsDisplay))
         {
            this.mStatsDisplay.drawCount = this.mSupport.drawCount;
         }
         if(!this.mShareContext)
         {
            this.mContext.present();
         }
      }
      
      private function updateViewPort(updateAliasing:Boolean = false) : void
      {
         if(updateAliasing || this.mPreviousViewPort.width != this.mViewPort.width || this.mPreviousViewPort.height != this.mViewPort.height || this.mPreviousViewPort.x != this.mViewPort.x || this.mPreviousViewPort.y != this.mViewPort.y)
         {
            this.mPreviousViewPort.setTo(this.mViewPort.x,this.mViewPort.y,this.mViewPort.width,this.mViewPort.height);
            this.mClippedViewPort = this.mViewPort.intersection(new Rectangle(0,0,this.mNativeStage.stageWidth,this.mNativeStage.stageHeight));
            if(!this.mShareContext)
            {
               if(this.mProfile == "baselineConstrained")
               {
                  this.mSupport.configureBackBuffer(32,32,this.mAntiAliasing,false);
               }
               this.mStage3D.x = this.mClippedViewPort.x;
               this.mStage3D.y = this.mClippedViewPort.y;
               this.mSupport.configureBackBuffer(this.mClippedViewPort.width,this.mClippedViewPort.height,this.mAntiAliasing,false);
            }
            else
            {
               this.mSupport.backBufferWidth = this.mClippedViewPort.width;
               this.mSupport.backBufferHeight = this.mClippedViewPort.height;
            }
         }
      }
      
      private function updateNativeOverlay() : void
      {
         this.mNativeOverlay.x = this.mViewPort.x;
         this.mNativeOverlay.y = this.mViewPort.y;
         this.mNativeOverlay.scaleX = this.mViewPort.width / this.mStage.stageWidth;
         this.mNativeOverlay.scaleY = this.mViewPort.height / this.mStage.stageHeight;
      }
      
      private function showFatalError(message:String) : void
      {
         var textField:TextField = new TextField();
         var textFormat:TextFormat = new TextFormat("Verdana",12,16777215);
         textFormat.align = TextFormatAlign.CENTER;
         textField.defaultTextFormat = textFormat;
         textField.wordWrap = true;
         textField.width = this.mStage.stageWidth * 0.75;
         textField.autoSize = TextFieldAutoSize.CENTER;
         textField.text = message;
         textField.x = (this.mStage.stageWidth - textField.width) / 2;
         textField.y = (this.mStage.stageHeight - textField.height) / 2;
         textField.background = true;
         textField.backgroundColor = 4456448;
         this.nativeOverlay.addChild(textField);
      }
      
      public function makeCurrent() : void
      {
         sCurrent = this;
      }
      
      public function start() : void
      {
         this.mStarted = true;
         this.mLastFrameTimestamp = getTimer() / 1000;
      }
      
      public function stop() : void
      {
         this.mStarted = false;
      }
      
      private function onStage3DError(event:ErrorEvent) : void
      {
         if(event.errorID == 3702)
         {
            this.showFatalError("This application is not correctly embedded (wrong wmode value)");
         }
         else
         {
            this.showFatalError("Stage3D error: " + event.text);
         }
      }
      
      private function onContextCreated(event:flash.events.Event) : void
      {
         if(!Starling.handleLostContext && Boolean(this.mContext))
         {
            this.stop();
            event.stopImmediatePropagation();
            this.showFatalError("Fatal error: The application lost the device context!");
            trace("[Starling] The device context was lost. " + "Enable \'Starling.handleLostContext\' to avoid this error.");
         }
         else
         {
            this.initialize();
         }
      }
      
      private function onEnterFrame(event:flash.events.Event) : void
      {
         if(!this.mShareContext)
         {
            if(this.mStarted)
            {
               this.nextFrame();
            }
            else
            {
               this.render();
            }
         }
      }
      
      private function onKey(event:flash.events.KeyboardEvent) : void
      {
         if(!this.mStarted)
         {
            return;
         }
         this.makeCurrent();
         this.mStage.dispatchEvent(new starling.events.KeyboardEvent(event.type,event.charCode,event.keyCode,event.keyLocation,event.ctrlKey,event.altKey,event.shiftKey));
      }
      
      private function onResize(event:flash.events.Event) : void
      {
         var stage:flash.display.Stage = event.target as Stage;
         this.mStage.dispatchEvent(new ResizeEvent(Event.RESIZE,stage.stageWidth,stage.stageHeight));
      }
      
      private function onMouseLeave(event:flash.events.Event) : void
      {
         this.mTouchProcessor.enqueueMouseLeftStage();
      }
      
      private function onTouch(event:flash.events.Event) : void
      {
         var globalX:Number = NaN;
         var globalY:Number = NaN;
         var touchID:int = 0;
         var phase:String = null;
         var mouseEvent:MouseEvent = null;
         var touchEvent:TouchEvent = null;
         if(!this.mStarted)
         {
            return;
         }
         var pressure:Number = 1;
         var width:Number = 1;
         var height:Number = 1;
         if(event is MouseEvent)
         {
            mouseEvent = event as MouseEvent;
            globalX = mouseEvent.stageX;
            globalY = mouseEvent.stageY;
            touchID = 0;
            if(event.type == MouseEvent.MOUSE_DOWN)
            {
               this.mLeftMouseDown = true;
            }
            else if(event.type == MouseEvent.MOUSE_UP)
            {
               this.mLeftMouseDown = false;
            }
         }
         else
         {
            touchEvent = event as TouchEvent;
            globalX = touchEvent.stageX;
            globalY = touchEvent.stageY;
            touchID = touchEvent.touchPointID;
            pressure = touchEvent.pressure;
            width = touchEvent.sizeX;
            height = touchEvent.sizeY;
         }
         switch(event.type)
         {
            case TouchEvent.TOUCH_BEGIN:
               phase = TouchPhase.BEGAN;
               break;
            case TouchEvent.TOUCH_MOVE:
               phase = TouchPhase.MOVED;
               break;
            case TouchEvent.TOUCH_END:
               phase = TouchPhase.ENDED;
               break;
            case MouseEvent.MOUSE_DOWN:
               phase = TouchPhase.BEGAN;
               break;
            case MouseEvent.MOUSE_UP:
               phase = TouchPhase.ENDED;
               break;
            case MouseEvent.MOUSE_MOVE:
               phase = this.mLeftMouseDown ? TouchPhase.MOVED : TouchPhase.HOVER;
         }
         globalX = this.mStage.stageWidth * (globalX - this.mViewPort.x) / this.mViewPort.width;
         globalY = this.mStage.stageHeight * (globalY - this.mViewPort.y) / this.mViewPort.height;
         this.mTouchProcessor.enqueue(touchID,phase,globalX,globalY,pressure,width,height);
      }
      
      private function get touchEventTypes() : Array
      {
         return Mouse.supportsCursor || !multitouchEnabled ? [MouseEvent.MOUSE_DOWN,MouseEvent.MOUSE_MOVE,MouseEvent.MOUSE_UP] : [TouchEvent.TOUCH_BEGIN,TouchEvent.TOUCH_MOVE,TouchEvent.TOUCH_END];
      }
      
      public function registerProgram(name:String, vertexProgram:ByteArray, fragmentProgram:ByteArray) : void
      {
         this.deleteProgram(name);
         var program:Program3D = this.mContext.createProgram();
         program.upload(vertexProgram,fragmentProgram);
         this.programs[name] = program;
      }
      
      public function deleteProgram(name:String) : void
      {
         var program:Program3D = this.getProgram(name);
         if(Boolean(program))
         {
            program.dispose();
            delete this.programs[name];
         }
      }
      
      public function getProgram(name:String) : Program3D
      {
         return this.programs[name] as Program3D;
      }
      
      public function hasProgram(name:String) : Boolean
      {
         return name in this.programs;
      }
      
      private function get programs() : Dictionary
      {
         return this.contextData[PROGRAM_DATA_NAME];
      }
      
      private function get contextValid() : Boolean
      {
         return Boolean(this.mContext) && this.mContext.driverInfo != "Disposed";
      }
      
      public function get isStarted() : Boolean
      {
         return this.mStarted;
      }
      
      public function get juggler() : Juggler
      {
         return this.mJuggler;
      }
      
      public function get context() : Context3D
      {
         return this.mContext;
      }
      
      public function get contextData() : Dictionary
      {
         return sContextData[this.mStage3D] as Dictionary;
      }
      
      public function get simulateMultitouch() : Boolean
      {
         return this.mSimulateMultitouch;
      }
      
      public function set simulateMultitouch(value:Boolean) : void
      {
         this.mSimulateMultitouch = value;
         if(Boolean(this.mContext))
         {
            this.mTouchProcessor.simulateMultitouch = value;
         }
      }
      
      public function get enableErrorChecking() : Boolean
      {
         return this.mEnableErrorChecking;
      }
      
      public function set enableErrorChecking(value:Boolean) : void
      {
         this.mEnableErrorChecking = value;
         if(Boolean(this.mContext))
         {
            this.mContext.enableErrorChecking = value;
         }
      }
      
      public function get antiAliasing() : int
      {
         return this.mAntiAliasing;
      }
      
      public function set antiAliasing(value:int) : void
      {
         if(this.mAntiAliasing != value)
         {
            this.mAntiAliasing = value;
            if(this.contextValid)
            {
               this.updateViewPort(true);
            }
         }
      }
      
      public function get viewPort() : Rectangle
      {
         return this.mViewPort;
      }
      
      public function set viewPort(value:Rectangle) : void
      {
         this.mViewPort = value.clone();
      }
      
      public function get contentScaleFactor() : Number
      {
         return this.mViewPort.width / this.mStage.stageWidth;
      }
      
      public function get nativeOverlay() : Sprite
      {
         return this.mNativeOverlay;
      }
      
      public function get showStats() : Boolean
      {
         return Boolean(this.mStatsDisplay) && Boolean(this.mStatsDisplay.parent);
      }
      
      public function set showStats(value:Boolean) : void
      {
         if(value == this.showStats)
         {
            return;
         }
         if(value)
         {
            if(Boolean(this.mStatsDisplay))
            {
               this.mStage.addChild(this.mStatsDisplay);
            }
            else
            {
               this.showStatsAt();
            }
         }
         else
         {
            this.mStatsDisplay.removeFromParent();
         }
      }
      
      public function showStatsAt(hAlign:String = "left", vAlign:String = "top", scale:Number = 1) : void
      {
         var onRootCreated:Function = null;
         var stageWidth:int = 0;
         var stageHeight:int = 0;
         onRootCreated = function():void
         {
            showStatsAt(hAlign,vAlign,scale);
            removeEventListener(Event.ROOT_CREATED,onRootCreated);
         };
         if(this.mContext == null)
         {
            addEventListener(Event.ROOT_CREATED,onRootCreated);
         }
         else
         {
            if(this.mStatsDisplay == null)
            {
               this.mStatsDisplay = new StatsDisplay();
               this.mStatsDisplay.touchable = false;
               this.mStage.addChild(this.mStatsDisplay);
            }
            stageWidth = this.mStage.stageWidth;
            stageHeight = this.mStage.stageHeight;
            this.mStatsDisplay.scaleX = this.mStatsDisplay.scaleY = scale;
            if(hAlign == HAlign.LEFT)
            {
               this.mStatsDisplay.x = 0;
            }
            else if(hAlign == HAlign.RIGHT)
            {
               this.mStatsDisplay.x = stageWidth - this.mStatsDisplay.width;
            }
            else
            {
               this.mStatsDisplay.x = int((stageWidth - this.mStatsDisplay.width) / 2);
            }
            if(vAlign == VAlign.TOP)
            {
               this.mStatsDisplay.y = 0;
            }
            else if(vAlign == VAlign.BOTTOM)
            {
               this.mStatsDisplay.y = stageHeight - this.mStatsDisplay.height;
            }
            else
            {
               this.mStatsDisplay.y = int((stageHeight - this.mStatsDisplay.height) / 2);
            }
         }
      }
      
      public function get stage() : starling.display.Stage
      {
         return this.mStage;
      }
      
      public function get stage3D() : Stage3D
      {
         return this.mStage3D;
      }
      
      public function get nativeStage() : flash.display.Stage
      {
         return this.mNativeStage;
      }
      
      public function get root() : DisplayObject
      {
         return this.mRoot;
      }
      
      public function get shareContext() : Boolean
      {
         return this.mShareContext;
      }
      
      public function set shareContext(value:Boolean) : void
      {
         this.mShareContext = value;
      }
      
      public function get profile() : String
      {
         return this.mProfile;
      }
   }
}
