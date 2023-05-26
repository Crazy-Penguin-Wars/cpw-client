package mx.managers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.display.StageQuality;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.text.Font;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   import mx.core.FlexSprite;
   import mx.core.IChildList;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModuleFactory;
   import mx.core.IInvalidating;
   import mx.core.IRawChildrenContainer;
   import mx.core.IUIComponent;
   import mx.core.RSLData;
   import mx.core.RSLItem;
   import mx.core.Singleton;
   import mx.core.mx_internal;
   import mx.events.DynamicEvent;
   import mx.events.FlexEvent;
   import mx.events.RSLEvent;
   import mx.events.Request;
   import mx.events.SandboxMouseEvent;
   import mx.preloaders.Preloader;
   import mx.utils.DensityUtil;
   import mx.utils.LoaderUtil;
   
   public class SystemManager extends MovieClip implements IChildList, IFlexDisplayObject, IFlexModuleFactory, ISystemManager
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
      
      private static const IDLE_THRESHOLD:Number = 1000;
      
      private static const IDLE_INTERVAL:Number = 100;
      
      mx_internal static var allSystemManagers:Dictionary = new Dictionary(true);
       
      
      mx_internal var topLevel:Boolean = true;
      
      private var isDispatchingResizeEvent:Boolean;
      
      mx_internal var isStageRoot:Boolean = true;
      
      mx_internal var isBootstrapRoot:Boolean = false;
      
      private var _topLevelSystemManager:ISystemManager;
      
      mx_internal var childManager:ISystemManagerChildManager;
      
      private var _stage:Stage;
      
      mx_internal var nestLevel:int = 0;
      
      mx_internal var preloader:Preloader;
      
      private var mouseCatcher:Sprite;
      
      mx_internal var topLevelWindow:IUIComponent;
      
      mx_internal var idleCounter:int = 0;
      
      private var idleTimer:Timer;
      
      private var nextFrameTimer:Timer = null;
      
      private var lastFrame:int;
      
      private var readyForKickOff:Boolean;
      
      public var _resourceBundles:Array;
      
      private var rslDataList:Array;
      
      private var _height:Number;
      
      private var _width:Number;
      
      private var _allowDomainsInNewRSLs:Boolean = true;
      
      private var _allowInsecureDomainsInNewRSLs:Boolean = true;
      
      private var _applicationIndex:int = 1;
      
      private var _cursorChildren:SystemChildrenList;
      
      private var _cursorIndex:int = 0;
      
      private var _densityScale:Number = NaN;
      
      private var _document:Object;
      
      private var _fontList:Object = null;
      
      private var _explicitHeight:Number;
      
      private var _explicitWidth:Number;
      
      private var _focusPane:Sprite;
      
      private var _noTopMostIndex:int = 0;
      
      private var _numModalWindows:int = 0;
      
      private var _popUpChildren:SystemChildrenList;
      
      private var _rawChildren:SystemRawChildrenList;
      
      mx_internal var _screen:Rectangle;
      
      private var _toolTipChildren:SystemChildrenList;
      
      private var _toolTipIndex:int = 0;
      
      private var _topMostIndex:int = 0;
      
      mx_internal var _mouseX;
      
      mx_internal var _mouseY;
      
      private var implMap:Object;
      
      public function SystemManager()
      {
         this.implMap = {};
         super();
         if(Boolean(this.stage))
         {
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            this.stage.align = StageAlign.TOP_LEFT;
            this.stage.quality = StageQuality.HIGH;
         }
         if(SystemManagerGlobals.topLevelSystemManagers.length > 0 && !this.stage)
         {
            this.mx_internal::topLevel = false;
         }
         if(!this.stage)
         {
            this.mx_internal::isStageRoot = false;
         }
         if(this.mx_internal::topLevel)
         {
            SystemManagerGlobals.topLevelSystemManagers.push(this);
         }
         stop();
         if(Boolean(root) && Boolean(root.loaderInfo))
         {
            root.loaderInfo.addEventListener(Event.INIT,this.initHandler);
         }
      }
      
      public static function getSWFRoot(object:Object) : DisplayObject
      {
         var p:* = undefined;
         var sm:ISystemManager = null;
         var domain:ApplicationDomain = null;
         var cls:Class = null;
         var className:String = getQualifiedClassName(object);
         for(p in mx_internal::allSystemManagers)
         {
            sm = p as ISystemManager;
            domain = sm.loaderInfo.applicationDomain;
            try
            {
               cls = Class(domain.getDefinition(className));
               if(object is cls)
               {
                  return sm as DisplayObject;
               }
            }
            catch(e:Error)
            {
               continue;
            }
         }
         return null;
      }
      
      private static function getChildListIndex(childList:IChildList, f:Object) : int
      {
         var index:int = -1;
         try
         {
            index = childList.getChildIndex(DisplayObject(f));
         }
         catch(e:ArgumentError)
         {
         }
         return index;
      }
      
      private function deferredNextFrame() : void
      {
         if(currentFrame + 1 > totalFrames)
         {
            return;
         }
         if(currentFrame + 1 <= framesLoaded)
         {
            nextFrame();
         }
         else
         {
            this.nextFrameTimer = new Timer(100);
            this.nextFrameTimer.addEventListener(TimerEvent.TIMER,this.nextFrameTimerHandler);
            this.nextFrameTimer.start();
         }
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function get stage() : Stage
      {
         var root:DisplayObject = null;
         if(Boolean(this._stage))
         {
            return this._stage;
         }
         var s:Stage = super.stage;
         if(Boolean(s))
         {
            this._stage = s;
            return s;
         }
         if(!this.mx_internal::topLevel && Boolean(this._topLevelSystemManager))
         {
            this._stage = this._topLevelSystemManager.stage;
            return this._stage;
         }
         if(!this.mx_internal::isStageRoot && this.mx_internal::topLevel)
         {
            root = this.getTopLevelRoot();
            if(Boolean(root))
            {
               this._stage = root.stage;
               return this._stage;
            }
         }
         return null;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get numChildren() : int
      {
         return this.mx_internal::noTopMostIndex - this.mx_internal::applicationIndex;
      }
      
      public function get allowDomainsInNewRSLs() : Boolean
      {
         return this._allowDomainsInNewRSLs;
      }
      
      public function set allowDomainsInNewRSLs(value:Boolean) : void
      {
         this._allowDomainsInNewRSLs = value;
      }
      
      public function get allowInsecureDomainsInNewRSLs() : Boolean
      {
         return this._allowInsecureDomainsInNewRSLs;
      }
      
      public function set allowInsecureDomainsInNewRSLs(value:Boolean) : void
      {
         this._allowInsecureDomainsInNewRSLs = value;
      }
      
      public function get application() : IUIComponent
      {
         return IUIComponent(this._document);
      }
      
      mx_internal function get applicationIndex() : int
      {
         return this._applicationIndex;
      }
      
      mx_internal function set applicationIndex(value:int) : void
      {
         this._applicationIndex = value;
      }
      
      public function get cursorChildren() : IChildList
      {
         if(!this.mx_internal::topLevel)
         {
            return this._topLevelSystemManager.cursorChildren;
         }
         if(!this._cursorChildren)
         {
            this._cursorChildren = new SystemChildrenList(this,new QName(mx_internal,"toolTipIndex"),new QName(mx_internal,"cursorIndex"));
         }
         return this._cursorChildren;
      }
      
      mx_internal function get cursorIndex() : int
      {
         return this._cursorIndex;
      }
      
      mx_internal function set cursorIndex(value:int) : void
      {
         var delta:int = value - this._cursorIndex;
         this._cursorIndex = value;
      }
      
      mx_internal function get densityScale() : Number
      {
         var applicationDPI:Number = NaN;
         var runtimeDPI:Number = NaN;
         if(isNaN(this._densityScale))
         {
            applicationDPI = Number(this.info()["applicationDPI"]);
            runtimeDPI = DensityUtil.getRuntimeDPI();
            this._densityScale = DensityUtil.getDPIScale(applicationDPI,runtimeDPI);
            if(isNaN(this._densityScale))
            {
               this._densityScale = 1;
            }
         }
         return this._densityScale;
      }
      
      public function get document() : Object
      {
         return this._document;
      }
      
      public function set document(value:Object) : void
      {
         this._document = value;
      }
      
      public function get embeddedFontList() : Object
      {
         var o:Object = null;
         var p:* = null;
         var fl:Object = null;
         if(this._fontList == null)
         {
            this._fontList = {};
            o = this.info()["fonts"];
            for(p in o)
            {
               this._fontList[p] = o[p];
            }
            if(!this.mx_internal::topLevel && Boolean(this._topLevelSystemManager))
            {
               fl = this._topLevelSystemManager.embeddedFontList;
               for(p in fl)
               {
                  this._fontList[p] = fl[p];
               }
            }
         }
         return this._fontList;
      }
      
      public function get explicitHeight() : Number
      {
         return this._explicitHeight;
      }
      
      public function set explicitHeight(value:Number) : void
      {
         this._explicitHeight = value;
      }
      
      public function get explicitWidth() : Number
      {
         return this._explicitWidth;
      }
      
      public function set explicitWidth(value:Number) : void
      {
         this._explicitWidth = value;
      }
      
      public function get focusPane() : Sprite
      {
         return this._focusPane;
      }
      
      public function set focusPane(value:Sprite) : void
      {
         if(Boolean(value))
         {
            this.addChild(value);
            value.x = 0;
            value.y = 0;
            value.scrollRect = null;
            this._focusPane = value;
         }
         else
         {
            this.removeChild(this._focusPane);
            this._focusPane = null;
         }
      }
      
      public function get isProxy() : Boolean
      {
         return false;
      }
      
      public function get measuredHeight() : Number
      {
         return Boolean(this.mx_internal::topLevelWindow) ? this.mx_internal::topLevelWindow.getExplicitOrMeasuredHeight() : loaderInfo.height;
      }
      
      public function get measuredWidth() : Number
      {
         return Boolean(this.mx_internal::topLevelWindow) ? this.mx_internal::topLevelWindow.getExplicitOrMeasuredWidth() : loaderInfo.width;
      }
      
      mx_internal function get noTopMostIndex() : int
      {
         return this._noTopMostIndex;
      }
      
      mx_internal function set noTopMostIndex(value:int) : void
      {
         var delta:int = value - this._noTopMostIndex;
         this._noTopMostIndex = value;
         this.mx_internal::topMostIndex += delta;
      }
      
      final mx_internal function get $numChildren() : int
      {
         return super.numChildren;
      }
      
      public function get numModalWindows() : int
      {
         return this._numModalWindows;
      }
      
      public function set numModalWindows(value:int) : void
      {
         this._numModalWindows = value;
      }
      
      public function get preloadedRSLs() : Dictionary
      {
         return null;
      }
      
      public function addPreloadedRSL(loaderInfo:LoaderInfo, rsl:Vector.<RSLData>) : void
      {
         var rslEvent:RSLEvent = null;
         this.preloadedRSLs[loaderInfo] = rsl;
         if(hasEventListener(RSLEvent.RSL_ADD_PRELOADED))
         {
            rslEvent = new RSLEvent(RSLEvent.RSL_ADD_PRELOADED);
            rslEvent.loaderInfo = loaderInfo;
            dispatchEvent(rslEvent);
         }
      }
      
      public function get preloaderBackgroundAlpha() : Number
      {
         return this.info()["backgroundAlpha"];
      }
      
      public function get preloaderBackgroundColor() : uint
      {
         var value:* = this.info()["backgroundColor"];
         if(value == undefined)
         {
            return 4294967295;
         }
         return value;
      }
      
      public function get preloaderBackgroundImage() : Object
      {
         return this.info()["backgroundImage"];
      }
      
      public function get preloaderBackgroundSize() : String
      {
         return this.info()["backgroundSize"];
      }
      
      public function get popUpChildren() : IChildList
      {
         if(!this.mx_internal::topLevel)
         {
            return this._topLevelSystemManager.popUpChildren;
         }
         if(!this._popUpChildren)
         {
            this._popUpChildren = new SystemChildrenList(this,new QName(mx_internal,"noTopMostIndex"),new QName(mx_internal,"topMostIndex"));
         }
         return this._popUpChildren;
      }
      
      public function get rawChildren() : IChildList
      {
         if(!this._rawChildren)
         {
            this._rawChildren = new SystemRawChildrenList(this);
         }
         return this._rawChildren;
      }
      
      public function get screen() : Rectangle
      {
         if(!this.mx_internal::_screen)
         {
            this.Stage_resizeHandler();
         }
         if(!this.mx_internal::isStageRoot)
         {
            this.Stage_resizeHandler();
         }
         return this.mx_internal::_screen;
      }
      
      public function get toolTipChildren() : IChildList
      {
         if(!this.mx_internal::topLevel)
         {
            return this._topLevelSystemManager.toolTipChildren;
         }
         if(!this._toolTipChildren)
         {
            this._toolTipChildren = new SystemChildrenList(this,new QName(mx_internal,"topMostIndex"),new QName(mx_internal,"toolTipIndex"));
         }
         return this._toolTipChildren;
      }
      
      mx_internal function get toolTipIndex() : int
      {
         return this._toolTipIndex;
      }
      
      mx_internal function set toolTipIndex(value:int) : void
      {
         var delta:int = value - this._toolTipIndex;
         this._toolTipIndex = value;
         this.mx_internal::cursorIndex += delta;
      }
      
      public function get topLevelSystemManager() : ISystemManager
      {
         if(this.mx_internal::topLevel)
         {
            return this;
         }
         return this._topLevelSystemManager;
      }
      
      mx_internal function get topMostIndex() : int
      {
         return this._topMostIndex;
      }
      
      mx_internal function set topMostIndex(value:int) : void
      {
         var delta:int = value - this._topMostIndex;
         this._topMostIndex = value;
         this.mx_internal::toolTipIndex += delta;
      }
      
      final mx_internal function $addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         super.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function get childAllowsParent() : Boolean
      {
         try
         {
            return loaderInfo.childAllowsParent;
         }
         catch(error:Error)
         {
            return false;
         }
      }
      
      public function get parentAllowsChild() : Boolean
      {
         try
         {
            return loaderInfo.parentAllowsChild;
         }
         catch(error:Error)
         {
            return false;
         }
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         var request:DynamicEvent = null;
         if(type == MouseEvent.MOUSE_MOVE || type == MouseEvent.MOUSE_UP || type == MouseEvent.MOUSE_DOWN || type == Event.ACTIVATE || type == Event.DEACTIVATE)
         {
            try
            {
               if(Boolean(this.stage))
               {
                  this.stage.addEventListener(type,this.stageEventHandler,false,0,true);
               }
            }
            catch(error:SecurityError)
            {
            }
         }
         if(hasEventListener("addEventListener"))
         {
            request = new DynamicEvent("addEventListener",false,true);
            request.eventType = type;
            request.listener = listener;
            request.useCapture = useCapture;
            request.priority = priority;
            request.useWeakReference = useWeakReference;
            if(!dispatchEvent(request))
            {
               return;
            }
         }
         if(type == SandboxMouseEvent.MOUSE_UP_SOMEWHERE)
         {
            try
            {
               if(Boolean(this.stage))
               {
                  this.stage.addEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler,false,0,true);
               }
               else
               {
                  super.addEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler,false,0,true);
               }
            }
            catch(error:SecurityError)
            {
               super.addEventListener(Event.MOUSE_LEAVE,mouseLeaveHandler,false,0,true);
            }
         }
         if(type == FlexEvent.RENDER || type == FlexEvent.ENTER_FRAME)
         {
            if(type == FlexEvent.RENDER)
            {
               type = Event.RENDER;
            }
            else
            {
               type = Event.ENTER_FRAME;
            }
            try
            {
               if(Boolean(this.stage))
               {
                  this.stage.addEventListener(type,listener,useCapture,priority,useWeakReference);
               }
               else
               {
                  super.addEventListener(type,listener,useCapture,priority,useWeakReference);
               }
            }
            catch(error:SecurityError)
            {
               super.addEventListener(type,listener,useCapture,priority,useWeakReference);
            }
            if(Boolean(this.stage) && type == Event.RENDER)
            {
               this.stage.invalidate();
            }
            return;
         }
         if(type == FlexEvent.IDLE && !this.idleTimer)
         {
            this.idleTimer = new Timer(IDLE_INTERVAL);
            this.idleTimer.addEventListener(TimerEvent.TIMER,this.idleTimer_timerHandler);
            this.idleTimer.start();
            this.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,true);
            this.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,true);
         }
         super.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      final mx_internal function $removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         super.removeEventListener(type,listener,useCapture);
      }
      
      override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         var request:DynamicEvent = null;
         if(hasEventListener("removeEventListener"))
         {
            request = new DynamicEvent("removeEventListener",false,true);
            request.eventType = type;
            request.listener = listener;
            request.useCapture = useCapture;
            if(!dispatchEvent(request))
            {
               return;
            }
         }
         if(type == FlexEvent.RENDER || type == FlexEvent.ENTER_FRAME)
         {
            if(type == FlexEvent.RENDER)
            {
               type = Event.RENDER;
            }
            else
            {
               type = Event.ENTER_FRAME;
            }
            try
            {
               if(Boolean(this.stage))
               {
                  this.stage.removeEventListener(type,listener,useCapture);
               }
            }
            catch(error:SecurityError)
            {
            }
            super.removeEventListener(type,listener,useCapture);
            return;
         }
         if(type == FlexEvent.IDLE)
         {
            super.removeEventListener(type,listener,useCapture);
            if(!hasEventListener(FlexEvent.IDLE) && Boolean(this.idleTimer))
            {
               this.idleTimer.stop();
               this.idleTimer = null;
               this.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
               this.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
            }
         }
         else
         {
            super.removeEventListener(type,listener,useCapture);
         }
         if(type == MouseEvent.MOUSE_MOVE || type == MouseEvent.MOUSE_UP || type == MouseEvent.MOUSE_DOWN || type == Event.ACTIVATE || type == Event.DEACTIVATE)
         {
            if(!hasEventListener(type))
            {
               try
               {
                  if(Boolean(this.stage))
                  {
                     this.stage.removeEventListener(type,this.stageEventHandler,false);
                  }
               }
               catch(error:SecurityError)
               {
               }
            }
         }
         if(type == SandboxMouseEvent.MOUSE_UP_SOMEWHERE)
         {
            if(!hasEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE))
            {
               try
               {
                  if(Boolean(this.stage))
                  {
                     this.stage.removeEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler);
                  }
               }
               catch(error:SecurityError)
               {
               }
               super.removeEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler);
            }
         }
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         var addIndex:int = this.numChildren;
         if(child.parent == this)
         {
            addIndex--;
         }
         return this.addChildAt(child,addIndex);
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         ++this.mx_internal::noTopMostIndex;
         var oldParent:DisplayObjectContainer = child.parent;
         if(Boolean(oldParent))
         {
            oldParent.removeChild(child);
         }
         return this.mx_internal::rawChildren_addChildAt(child,this.mx_internal::applicationIndex + index);
      }
      
      final mx_internal function $addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         return super.addChildAt(child,index);
      }
      
      final mx_internal function $removeChildAt(index:int) : DisplayObject
      {
         return super.removeChildAt(index);
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         --this.mx_internal::noTopMostIndex;
         return this.mx_internal::rawChildren_removeChild(child);
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         --this.mx_internal::noTopMostIndex;
         return this.mx_internal::rawChildren_removeChildAt(this.mx_internal::applicationIndex + index);
      }
      
      override public function getChildAt(index:int) : DisplayObject
      {
         return super.getChildAt(this.mx_internal::applicationIndex + index);
      }
      
      override public function getChildByName(name:String) : DisplayObject
      {
         return super.getChildByName(name);
      }
      
      override public function getChildIndex(child:DisplayObject) : int
      {
         return super.getChildIndex(child) - this.mx_internal::applicationIndex;
      }
      
      override public function setChildIndex(child:DisplayObject, newIndex:int) : void
      {
         super.setChildIndex(child,this.mx_internal::applicationIndex + newIndex);
      }
      
      override public function getObjectsUnderPoint(point:Point) : Array
      {
         var child:DisplayObject = null;
         var temp:Array = null;
         var children:Array = [];
         var n:int = this.mx_internal::topMostIndex;
         for(var i:int = 0; i < n; i++)
         {
            child = super.getChildAt(i);
            if(child is DisplayObjectContainer)
            {
               temp = DisplayObjectContainer(child).getObjectsUnderPoint(point);
               if(Boolean(temp))
               {
                  children = children.concat(temp);
               }
            }
         }
         return children;
      }
      
      override public function contains(child:DisplayObject) : Boolean
      {
         var childIndex:int = 0;
         var i:int = 0;
         var myChild:DisplayObject = null;
         if(super.contains(child))
         {
            if(child.parent == this)
            {
               childIndex = super.getChildIndex(child);
               if(childIndex < this.mx_internal::noTopMostIndex)
               {
                  return true;
               }
            }
            else
            {
               for(i = 0; i < this.mx_internal::noTopMostIndex; i++)
               {
                  myChild = super.getChildAt(i);
                  if(myChild is IRawChildrenContainer)
                  {
                     if(IRawChildrenContainer(myChild).rawChildren.contains(child))
                     {
                        return true;
                     }
                  }
                  if(myChild is DisplayObjectContainer)
                  {
                     if(DisplayObjectContainer(myChild).contains(child))
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
      
      public function callInContext(fn:Function, thisArg:Object, argArray:Array, returns:Boolean = true) : *
      {
         return undefined;
      }
      
      public function create(... params) : Object
      {
         var url:String = null;
         var dot:int = 0;
         var slash:int = 0;
         var mainClassName:String = this.info()["mainClassName"];
         if(mainClassName == null)
         {
            url = loaderInfo.loaderURL;
            dot = url.lastIndexOf(".");
            slash = url.lastIndexOf("/");
            mainClassName = url.substring(slash + 1,dot);
         }
         var mainClass:Class = Class(this.getDefinitionByName(mainClassName));
         return Boolean(mainClass) ? new mainClass() : null;
      }
      
      public function info() : Object
      {
         return {};
      }
      
      mx_internal function initialize() : void
      {
         var n:int = 0;
         var i:int = 0;
         var normalizedURL:String = null;
         var crossDomainRSLItem:Class = null;
         var rslWithFailovers:Array = null;
         var cdNode:Object = null;
         var node:RSLItem = null;
         var runtimeDPIProviderClass:Class = this.info()["runtimeDPIProvider"] as Class;
         if(Boolean(runtimeDPIProviderClass))
         {
            Singleton.registerClass("mx.core::RuntimeDPIProvider",runtimeDPIProviderClass);
         }
         if(this.mx_internal::isStageRoot)
         {
            this.Stage_resizeHandler();
         }
         else
         {
            this._width = loaderInfo.width;
            this._height = loaderInfo.height;
         }
         this.mx_internal::preloader = new Preloader();
         this.mx_internal::preloader.addEventListener(FlexEvent.PRELOADER_DOC_FRAME_READY,this.preloader_preloaderDocFrameReadyHandler);
         this.mx_internal::preloader.addEventListener(Event.COMPLETE,this.mx_internal::preloader_completeHandler);
         this.mx_internal::preloader.addEventListener(FlexEvent.PRELOADER_DONE,this.preloader_preloaderDoneHandler);
         this.mx_internal::preloader.addEventListener(RSLEvent.RSL_COMPLETE,this.preloader_rslCompleteHandler);
         if(!this._popUpChildren)
         {
            this._popUpChildren = new SystemChildrenList(this,new QName(mx_internal,"noTopMostIndex"),new QName(mx_internal,"topMostIndex"));
         }
         this._popUpChildren.addChild(this.mx_internal::preloader);
         var rsls:Array = this.info()["rsls"];
         var cdRsls:Array = this.info()["cdRsls"];
         var usePreloader:Boolean = true;
         if(this.info()["usePreloader"] != undefined)
         {
            usePreloader = Boolean(this.info()["usePreloader"]);
         }
         var preloaderDisplayClass:Class = this.info()["preloader"] as Class;
         var rslItemList:Array = [];
         if(Boolean(cdRsls) && cdRsls.length > 0)
         {
            if(this.isTopLevel())
            {
               this.rslDataList = cdRsls;
            }
            else
            {
               this.rslDataList = LoaderUtil.mx_internal::processRequiredRSLs(this,cdRsls);
            }
            normalizedURL = LoaderUtil.normalizeURL(this.loaderInfo);
            crossDomainRSLItem = Class(this.getDefinitionByName("mx.core::CrossDomainRSLItem"));
            n = this.rslDataList.length;
            for(i = 0; i < n; i++)
            {
               rslWithFailovers = this.rslDataList[i];
               cdNode = new crossDomainRSLItem(rslWithFailovers,normalizedURL,this);
               rslItemList.push(cdNode);
            }
         }
         if(rsls != null && rsls.length > 0)
         {
            if(this.rslDataList == null)
            {
               this.rslDataList = [];
            }
            if(normalizedURL == null)
            {
               normalizedURL = LoaderUtil.normalizeURL(this.loaderInfo);
            }
            n = rsls.length;
            for(i = 0; i < n; i++)
            {
               node = new RSLItem(rsls[i].url,normalizedURL,this);
               rslItemList.push(node);
               this.rslDataList.push([new RSLData(rsls[i].url,null,null,null,false,false,"current")]);
            }
         }
         var resourceModuleURLList:String = loaderInfo.parameters["resourceModuleURLs"];
         var resourceModuleURLs:Array = Boolean(resourceModuleURLList) ? resourceModuleURLList.split(",") : null;
         var domain:ApplicationDomain = !this.mx_internal::topLevel && this.parent is Loader ? Loader(this.parent).contentLoaderInfo.applicationDomain : this.info()["currentDomain"] as ApplicationDomain;
         this.mx_internal::preloader.initialize(usePreloader,preloaderDisplayClass,this.preloaderBackgroundColor,this.preloaderBackgroundAlpha,this.preloaderBackgroundImage,this.preloaderBackgroundSize,this.mx_internal::isStageRoot ? this.stage.stageWidth : loaderInfo.width,this.mx_internal::isStageRoot ? this.stage.stageHeight : loaderInfo.height,null,null,rslItemList,resourceModuleURLs,domain);
      }
      
      mx_internal function rawChildren_addChild(child:DisplayObject) : DisplayObject
      {
         this.mx_internal::childManager.addingChild(child);
         super.addChild(child);
         this.mx_internal::childManager.childAdded(child);
         return child;
      }
      
      mx_internal function rawChildren_addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         if(Boolean(this.mx_internal::childManager))
         {
            this.mx_internal::childManager.addingChild(child);
         }
         super.addChildAt(child,index);
         if(Boolean(this.mx_internal::childManager))
         {
            this.mx_internal::childManager.childAdded(child);
         }
         return child;
      }
      
      mx_internal function rawChildren_removeChild(child:DisplayObject) : DisplayObject
      {
         this.mx_internal::childManager.removingChild(child);
         super.removeChild(child);
         this.mx_internal::childManager.childRemoved(child);
         return child;
      }
      
      mx_internal function rawChildren_removeChildAt(index:int) : DisplayObject
      {
         var child:DisplayObject = super.getChildAt(index);
         this.mx_internal::childManager.removingChild(child);
         super.removeChildAt(index);
         this.mx_internal::childManager.childRemoved(child);
         return child;
      }
      
      mx_internal function rawChildren_getChildAt(index:int) : DisplayObject
      {
         return super.getChildAt(index);
      }
      
      mx_internal function rawChildren_getChildByName(name:String) : DisplayObject
      {
         return super.getChildByName(name);
      }
      
      mx_internal function rawChildren_getChildIndex(child:DisplayObject) : int
      {
         return super.getChildIndex(child);
      }
      
      mx_internal function rawChildren_setChildIndex(child:DisplayObject, newIndex:int) : void
      {
         super.setChildIndex(child,newIndex);
      }
      
      mx_internal function rawChildren_getObjectsUnderPoint(pt:Point) : Array
      {
         return super.getObjectsUnderPoint(pt);
      }
      
      mx_internal function rawChildren_contains(child:DisplayObject) : Boolean
      {
         return super.contains(child);
      }
      
      public function allowDomain(... domains) : void
      {
      }
      
      public function allowInsecureDomain(... domains) : void
      {
      }
      
      public function getExplicitOrMeasuredWidth() : Number
      {
         return !isNaN(this.explicitWidth) ? this.explicitWidth : this.measuredWidth;
      }
      
      public function getExplicitOrMeasuredHeight() : Number
      {
         return !isNaN(this.explicitHeight) ? this.explicitHeight : this.measuredHeight;
      }
      
      public function move(x:Number, y:Number) : void
      {
      }
      
      public function setActualSize(newWidth:Number, newHeight:Number) : void
      {
         if(this.mx_internal::isStageRoot)
         {
            return;
         }
         if(Boolean(this.mouseCatcher))
         {
            this.mouseCatcher.width = newWidth;
            this.mouseCatcher.height = newHeight;
         }
         if(this._width != newWidth || this._height != newHeight)
         {
            this._width = newWidth;
            this._height = newHeight;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function getDefinitionByName(name:String) : Object
      {
         var definition:Object = null;
         var domain:ApplicationDomain = !this.mx_internal::topLevel && this.parent is Loader ? Loader(this.parent).contentLoaderInfo.applicationDomain : this.info()["currentDomain"] as ApplicationDomain;
         if(domain.hasDefinition(name))
         {
            definition = domain.getDefinition(name);
         }
         return definition;
      }
      
      public function isTopLevel() : Boolean
      {
         return this.mx_internal::topLevel;
      }
      
      public function isTopLevelRoot() : Boolean
      {
         return this.mx_internal::isStageRoot || this.mx_internal::isBootstrapRoot;
      }
      
      public function isTopLevelWindow(object:DisplayObject) : Boolean
      {
         return object is IUIComponent && IUIComponent(object) == this.mx_internal::topLevelWindow;
      }
      
      public function isFontFaceEmbedded(textFormat:TextFormat) : Boolean
      {
         var font:Font = null;
         var style:String = null;
         var fontName:String = textFormat.font;
         var bold:Boolean = Boolean(textFormat.bold);
         var italic:Boolean = Boolean(textFormat.italic);
         var fontList:Array = Font.enumerateFonts();
         var n:int = fontList.length;
         for(var i:int = 0; i < n; i++)
         {
            font = Font(fontList[i]);
            if(font.fontName == fontName)
            {
               style = "regular";
               if(bold && italic)
               {
                  style = "boldItalic";
               }
               else if(bold)
               {
                  style = "bold";
               }
               else if(italic)
               {
                  style = "italic";
               }
               if(font.fontStyle == style)
               {
                  return true;
               }
            }
         }
         if(!fontName || !this.embeddedFontList || !this.embeddedFontList[fontName])
         {
            return false;
         }
         var info:Object = this.embeddedFontList[fontName];
         return !(bold && !info.bold || italic && !info.italic || !bold && !italic && !info.regular);
      }
      
      private function resizeMouseCatcher() : void
      {
         var g:Graphics = null;
         var s:Rectangle = null;
         if(Boolean(this.mouseCatcher))
         {
            try
            {
               g = this.mouseCatcher.graphics;
               s = this.screen;
               g.clear();
               g.beginFill(0,0);
               g.drawRect(0,0,s.width,s.height);
               g.endFill();
            }
            catch(e:SecurityError)
            {
            }
         }
      }
      
      private function initHandler(event:Event) : void
      {
         if(!this.mx_internal::isStageRoot)
         {
            if(root.loaderInfo.parentAllowsChild)
            {
               try
               {
                  if(!this.parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot",false,true)) || !root.loaderInfo.sharedEvents.hasEventListener("bridgeNewApplication"))
                  {
                     this.mx_internal::isBootstrapRoot = true;
                  }
               }
               catch(e:Error)
               {
               }
            }
         }
         mx_internal::allSystemManagers[this] = this.loaderInfo.url;
         root.loaderInfo.removeEventListener(Event.INIT,this.initHandler);
         if(!SystemManagerGlobals.info)
         {
            SystemManagerGlobals.info = this.info();
         }
         if(!SystemManagerGlobals.parameters)
         {
            SystemManagerGlobals.parameters = loaderInfo.parameters;
         }
         var docFrame:int = totalFrames == 1 ? 0 : 1;
         this.addEventListener(Event.ENTER_FRAME,this.docFrameListener);
         this.mx_internal::initialize();
      }
      
      private function docFrameListener(event:Event) : void
      {
         if(currentFrame == 2)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.docFrameListener);
            if(totalFrames > 2)
            {
               this.addEventListener(Event.ENTER_FRAME,this.extraFrameListener);
            }
            this.mx_internal::docFrameHandler();
         }
      }
      
      private function extraFrameListener(event:Event) : void
      {
         if(this.lastFrame == currentFrame)
         {
            return;
         }
         this.lastFrame = currentFrame;
         if(currentFrame + 1 > totalFrames)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.extraFrameListener);
         }
         this.extraFrameHandler();
      }
      
      private function preloader_preloaderDocFrameReadyHandler(event:Event) : void
      {
         this.mx_internal::preloader.removeEventListener(FlexEvent.PRELOADER_DOC_FRAME_READY,this.preloader_preloaderDocFrameReadyHandler);
         this.deferredNextFrame();
      }
      
      private function preloader_preloaderDoneHandler(event:Event) : void
      {
         var app:IUIComponent = this.mx_internal::topLevelWindow;
         this.mx_internal::preloader.removeEventListener(FlexEvent.PRELOADER_DONE,this.preloader_preloaderDoneHandler);
         this.mx_internal::preloader.removeEventListener(RSLEvent.RSL_COMPLETE,this.preloader_rslCompleteHandler);
         this._popUpChildren.removeChild(this.mx_internal::preloader);
         this.mx_internal::preloader = null;
         this.mouseCatcher = new FlexSprite();
         this.mouseCatcher.name = "mouseCatcher";
         ++this.mx_internal::noTopMostIndex;
         super.addChildAt(this.mouseCatcher,0);
         this.resizeMouseCatcher();
         if(!this.mx_internal::topLevel)
         {
            this.mouseCatcher.visible = false;
            mask = this.mouseCatcher;
         }
         ++this.mx_internal::noTopMostIndex;
         super.addChildAt(DisplayObject(app),1);
         app.dispatchEvent(new FlexEvent(FlexEvent.APPLICATION_COMPLETE));
         dispatchEvent(new FlexEvent(FlexEvent.APPLICATION_COMPLETE));
      }
      
      private function preloader_rslCompleteHandler(event:RSLEvent) : void
      {
         var rsl:Vector.<RSLData> = null;
         var moduleFactory:IFlexModuleFactory = null;
         if(!event.isResourceModule && Boolean(event.loaderInfo))
         {
            rsl = Vector.<RSLData>(this.rslDataList[event.rslIndex]);
            moduleFactory = this;
            if(Boolean(rsl) && Boolean(rsl[0].moduleFactory))
            {
               moduleFactory = rsl[0].moduleFactory;
            }
            if(moduleFactory == this)
            {
               this.preloadedRSLs[event.loaderInfo] = rsl;
            }
            else
            {
               moduleFactory.addPreloadedRSL(event.loaderInfo,rsl);
            }
         }
      }
      
      mx_internal function docFrameHandler(event:Event = null) : void
      {
         if(this.readyForKickOff)
         {
            this.mx_internal::kickOff();
         }
      }
      
      mx_internal function preloader_completeHandler(event:Event) : void
      {
         this.mx_internal::preloader.removeEventListener(Event.COMPLETE,this.mx_internal::preloader_completeHandler);
         this.readyForKickOff = true;
         if(currentFrame >= 2)
         {
            this.mx_internal::kickOff();
         }
      }
      
      mx_internal function kickOff() : void
      {
         var n:int = 0;
         var i:int = 0;
         var c:Class = null;
         if(Boolean(this.document))
         {
            return;
         }
         if(!this.isTopLevel())
         {
            SystemManagerGlobals.topLevelSystemManagers[0].dispatchEvent(new FocusEvent(FlexEvent.NEW_CHILD_APPLICATION,false,false,this));
         }
         Singleton.registerClass("mx.core::IEmbeddedFontRegistry",Class(this.getDefinitionByName("mx.core::EmbeddedFontRegistry")));
         Singleton.registerClass("mx.styles::IStyleManager",Class(this.getDefinitionByName("mx.styles::StyleManagerImpl")));
         Singleton.registerClass("mx.styles::IStyleManager2",Class(this.getDefinitionByName("mx.styles::StyleManagerImpl")));
         Singleton.registerClass("mx.managers::IBrowserManager",Class(this.getDefinitionByName("mx.managers::BrowserManagerImpl")));
         Singleton.registerClass("mx.managers::ICursorManager",Class(this.getDefinitionByName("mx.managers::CursorManagerImpl")));
         Singleton.registerClass("mx.managers::IHistoryManager",Class(this.getDefinitionByName("mx.managers::HistoryManagerImpl")));
         Singleton.registerClass("mx.managers::ILayoutManager",Class(this.getDefinitionByName("mx.managers::LayoutManager")));
         Singleton.registerClass("mx.managers::IPopUpManager",Class(this.getDefinitionByName("mx.managers::PopUpManagerImpl")));
         Singleton.registerClass("mx.managers::IToolTipManager2",Class(this.getDefinitionByName("mx.managers::ToolTipManagerImpl")));
         var dragManagerClass:Class = null;
         var dmInfo:Object = this.info()["useNativeDragManager"];
         var useNative:Boolean = dmInfo == null ? true : String(dmInfo) == "true";
         if(useNative)
         {
            dragManagerClass = Class(this.getDefinitionByName("mx.managers::NativeDragManagerImpl"));
         }
         if(dragManagerClass == null)
         {
            dragManagerClass = Class(this.getDefinitionByName("mx.managers::DragManagerImpl"));
         }
         Singleton.registerClass("mx.managers::IDragManager",dragManagerClass);
         Singleton.registerClass("mx.core::ITextFieldFactory",Class(this.getDefinitionByName("mx.core::TextFieldFactory")));
         var mixinList:Array = this.info()["mixins"];
         if(Boolean(mixinList) && mixinList.length > 0)
         {
            n = mixinList.length;
            for(i = 0; i < n; i++)
            {
               c = Class(this.getDefinitionByName(mixinList[i]));
               c["init"](this);
            }
         }
         c = Singleton.getClass("mx.managers::IActiveWindowManager");
         if(Boolean(c))
         {
            this.registerImplementation("mx.managers::IActiveWindowManager",new c(this));
         }
         c = Singleton.getClass("mx.managers::IMarshalSystemManager");
         if(Boolean(c))
         {
            this.registerImplementation("mx.managers::IMarshalSystemManager",new c(this));
         }
         this.initializeTopLevelWindow(null);
         this.deferredNextFrame();
      }
      
      private function keyDownHandler(e:KeyboardEvent) : void
      {
         var cancelableEvent:KeyboardEvent = null;
         if(!e.cancelable)
         {
            switch(e.keyCode)
            {
               case Keyboard.UP:
               case Keyboard.DOWN:
               case Keyboard.PAGE_UP:
               case Keyboard.PAGE_DOWN:
               case Keyboard.HOME:
               case Keyboard.END:
               case Keyboard.LEFT:
               case Keyboard.RIGHT:
               case Keyboard.ENTER:
                  e.stopImmediatePropagation();
                  cancelableEvent = new KeyboardEvent(e.type,e.bubbles,true,e.charCode,e.keyCode,e.keyLocation,e.ctrlKey,e.altKey,e.shiftKey);
                  e.target.dispatchEvent(cancelableEvent);
            }
         }
      }
      
      private function mouseEventHandler(e:MouseEvent) : void
      {
         var cancelableEvent:MouseEvent = null;
         var mouseEventClass:Class = null;
         if(!e.cancelable)
         {
            e.stopImmediatePropagation();
            cancelableEvent = null;
            if("clickCount" in e)
            {
               mouseEventClass = MouseEvent;
               cancelableEvent = new mouseEventClass(e.type,e.bubbles,true,e.localX,e.localY,e.relatedObject,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown,e.delta,e["commandKey"],e["controlKey"],e["clickCount"]);
            }
            else
            {
               cancelableEvent = new MouseEvent(e.type,e.bubbles,true,e.localX,e.localY,e.relatedObject,e.ctrlKey,e.altKey,e.shiftKey,e.buttonDown,e.delta);
            }
            e.target.dispatchEvent(cancelableEvent);
         }
      }
      
      private function extraFrameHandler(event:Event = null) : void
      {
         var c:Class = null;
         var frameList:Object = this.info()["frames"];
         if(Boolean(frameList) && Boolean(frameList[currentLabel]))
         {
            c = Class(this.getDefinitionByName(frameList[currentLabel]));
            c["frame"](this);
         }
         this.deferredNextFrame();
      }
      
      private function nextFrameTimerHandler(event:TimerEvent) : void
      {
         if(currentFrame + 1 <= framesLoaded)
         {
            nextFrame();
            this.nextFrameTimer.removeEventListener(TimerEvent.TIMER,this.nextFrameTimerHandler);
            this.nextFrameTimer.reset();
         }
      }
      
      private function initializeTopLevelWindow(event:Event) : void
      {
         var w:Number = NaN;
         var h:Number = NaN;
         var obj:DisplayObjectContainer = null;
         var sm:ISystemManager = null;
         var sandboxRoot:DisplayObject = null;
         if(this.getSandboxRoot() == this)
         {
            this.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,true,1000);
            this.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseEventHandler,true,1000);
            this.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseEventHandler,true,1000);
         }
         if(this.isTopLevelRoot() && Boolean(this.stage))
         {
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,false,1000);
            this.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseEventHandler,false,1000);
            this.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseEventHandler,false,1000);
         }
         if(!this.parent && this.parentAllowsChild)
         {
            return;
         }
         if(!this.mx_internal::topLevel)
         {
            if(!this.parent)
            {
               return;
            }
            obj = this.parent.parent;
            if(!obj)
            {
               return;
            }
            while(Boolean(obj))
            {
               if(obj is IUIComponent)
               {
                  sm = IUIComponent(obj).systemManager;
                  if(Boolean(sm) && !sm.isTopLevel())
                  {
                     sm = sm.topLevelSystemManager;
                  }
                  this._topLevelSystemManager = sm;
                  break;
               }
               obj = obj.parent;
            }
         }
         if(this.isTopLevelRoot() && Boolean(this.stage))
         {
            this.stage.addEventListener(Event.RESIZE,this.Stage_resizeHandler,false,0,true);
         }
         else if(this.mx_internal::topLevel && Boolean(this.stage))
         {
            sandboxRoot = this.getSandboxRoot();
            if(sandboxRoot != this)
            {
               sandboxRoot.addEventListener(Event.RESIZE,this.Stage_resizeHandler,false,0,true);
            }
         }
         if(this.mx_internal::isStageRoot && Boolean(this.stage))
         {
            this.Stage_resizeHandler();
            if(this._width == 0 && this._height == 0 && loaderInfo.width != this._width && loaderInfo.height != this._height)
            {
               this._width = loaderInfo.width;
               this._height = loaderInfo.height;
            }
            w = this._width;
            h = this._height;
         }
         else
         {
            w = loaderInfo.width;
            h = loaderInfo.height;
         }
         this.mx_internal::childManager.initializeTopLevelWindow(w,h);
      }
      
      private function appCreationCompleteHandler(event:FlexEvent) : void
      {
         this.invalidateParentSizeAndDisplayList();
      }
      
      public function invalidateParentSizeAndDisplayList() : void
      {
         var obj:DisplayObjectContainer = null;
         if(!this.mx_internal::topLevel && Boolean(this.parent))
         {
            obj = this.parent.parent;
            while(Boolean(obj))
            {
               if(obj is IInvalidating)
               {
                  IInvalidating(obj).invalidateSize();
                  IInvalidating(obj).invalidateDisplayList();
                  return;
               }
               obj = obj.parent;
            }
         }
         dispatchEvent(new Event("invalidateParentSizeAndDisplayList"));
      }
      
      private function Stage_resizeHandler(event:Event = null) : void
      {
         var w:Number;
         var h:Number;
         var align:String;
         var x:Number;
         var y:Number;
         var m:Number = NaN;
         var n:Number = NaN;
         var scale:Number = NaN;
         if(this.isDispatchingResizeEvent)
         {
            return;
         }
         w = 0;
         h = 0;
         try
         {
            m = loaderInfo.width;
            n = loaderInfo.height;
         }
         catch(error:Error)
         {
            if(!mx_internal::_screen)
            {
               mx_internal::_screen = new Rectangle();
            }
            return;
         }
         align = StageAlign.TOP_LEFT;
         try
         {
            if(Boolean(this.stage))
            {
               w = this.stage.stageWidth;
               h = this.stage.stageHeight;
               align = this.stage.align;
            }
         }
         catch(error:SecurityError)
         {
            if(hasEventListener("getScreen"))
            {
               dispatchEvent(new Event("getScreen"));
               if(Boolean(mx_internal::_screen))
               {
                  w = mx_internal::_screen.width;
                  h = mx_internal::_screen.height;
               }
            }
         }
         x = (m - w) / 2;
         y = (n - h) / 2;
         if(align == StageAlign.TOP)
         {
            y = 0;
         }
         else if(align == StageAlign.BOTTOM)
         {
            y = n - h;
         }
         else if(align == StageAlign.LEFT)
         {
            x = 0;
         }
         else if(align == StageAlign.RIGHT)
         {
            x = m - w;
         }
         else if(align == StageAlign.TOP_LEFT || align == "LT")
         {
            y = 0;
            x = 0;
         }
         else if(align == StageAlign.TOP_RIGHT)
         {
            y = 0;
            x = m - w;
         }
         else if(align == StageAlign.BOTTOM_LEFT)
         {
            y = n - h;
            x = 0;
         }
         else if(align == StageAlign.BOTTOM_RIGHT)
         {
            y = n - h;
            x = m - w;
         }
         if(!this.mx_internal::_screen)
         {
            this.mx_internal::_screen = new Rectangle();
         }
         this.mx_internal::_screen.x = x;
         this.mx_internal::_screen.y = y;
         this.mx_internal::_screen.width = w;
         this.mx_internal::_screen.height = h;
         if(this.mx_internal::isStageRoot)
         {
            scale = this.mx_internal::densityScale;
            root.scaleX = root.scaleY = scale;
            this._width = this.stage.stageWidth / scale;
            this._height = this.stage.stageHeight / scale;
            this.mx_internal::_screen.x /= scale;
            this.mx_internal::_screen.y /= scale;
            this.mx_internal::_screen.width /= scale;
            this.mx_internal::_screen.height /= scale;
         }
         if(Boolean(event))
         {
            this.resizeMouseCatcher();
            this.isDispatchingResizeEvent = true;
            dispatchEvent(event);
            this.isDispatchingResizeEvent = false;
         }
      }
      
      private function mouseMoveHandler(event:MouseEvent) : void
      {
         this.mx_internal::idleCounter = 0;
      }
      
      private function mouseUpHandler(event:MouseEvent) : void
      {
         this.mx_internal::idleCounter = 0;
      }
      
      private function idleTimer_timerHandler(event:TimerEvent) : void
      {
         ++this.mx_internal::idleCounter;
         if(this.mx_internal::idleCounter * IDLE_INTERVAL > IDLE_THRESHOLD)
         {
            dispatchEvent(new FlexEvent(FlexEvent.IDLE));
         }
      }
      
      override public function get mouseX() : Number
      {
         if(this.mx_internal::_mouseX === undefined)
         {
            return super.mouseX;
         }
         return this.mx_internal::_mouseX;
      }
      
      override public function get mouseY() : Number
      {
         if(this.mx_internal::_mouseY === undefined)
         {
            return super.mouseY;
         }
         return this.mx_internal::_mouseY;
      }
      
      private function getTopLevelSystemManager(parent:DisplayObject) : ISystemManager
      {
         var sm:ISystemManager = null;
         var localRoot:DisplayObjectContainer = DisplayObjectContainer(parent.root);
         if((!localRoot || localRoot is Stage) && parent is IUIComponent)
         {
            localRoot = DisplayObjectContainer(IUIComponent(parent).systemManager);
         }
         if(localRoot is ISystemManager)
         {
            sm = ISystemManager(localRoot);
            if(!sm.isTopLevel())
            {
               sm = sm.topLevelSystemManager;
            }
         }
         return sm;
      }
      
      override public function get parent() : DisplayObjectContainer
      {
         try
         {
            return super.parent;
         }
         catch(e:SecurityError)
         {
            return null;
         }
      }
      
      public function getTopLevelRoot() : DisplayObject
      {
         var sm:ISystemManager = null;
         var parent:DisplayObject = null;
         var lastParent:DisplayObject = null;
         try
         {
            sm = this;
            if(Boolean(sm.topLevelSystemManager))
            {
               sm = sm.topLevelSystemManager;
            }
            parent = DisplayObject(sm).parent;
            lastParent = DisplayObject(sm);
            while(Boolean(parent))
            {
               if(parent is Stage)
               {
                  return lastParent;
               }
               lastParent = parent;
               parent = parent.parent;
            }
         }
         catch(error:SecurityError)
         {
         }
         return null;
      }
      
      public function getSandboxRoot() : DisplayObject
      {
         var parent:DisplayObject = null;
         var lastParent:DisplayObject = null;
         var loader:Loader = null;
         var loaderInfo:LoaderInfo = null;
         var sm:ISystemManager = this;
         try
         {
            if(Boolean(sm.topLevelSystemManager))
            {
               sm = sm.topLevelSystemManager;
            }
            parent = DisplayObject(sm).parent;
            if(parent is Stage)
            {
               return DisplayObject(sm);
            }
            if(Boolean(parent) && !parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot",false,true)))
            {
               return this;
            }
            lastParent = this;
            while(Boolean(parent))
            {
               if(parent is Stage)
               {
                  return lastParent;
               }
               if(!parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot",false,true)))
               {
                  return lastParent;
               }
               if(parent is Loader)
               {
                  loader = Loader(parent);
                  loaderInfo = loader.contentLoaderInfo;
                  if(!loaderInfo.childAllowsParent)
                  {
                     return loaderInfo.content;
                  }
               }
               if(parent.hasEventListener("systemManagerRequest"))
               {
                  lastParent = parent;
               }
               parent = parent.parent;
            }
         }
         catch(error:Error)
         {
         }
         return lastParent != null ? lastParent : DisplayObject(sm);
      }
      
      public function registerImplementation(interfaceName:String, impl:Object) : void
      {
         var c:Object = this.implMap[interfaceName];
         if(!c)
         {
            this.implMap[interfaceName] = impl;
         }
      }
      
      public function getImplementation(interfaceName:String) : Object
      {
         return this.implMap[interfaceName];
      }
      
      public function getVisibleApplicationRect(bounds:Rectangle = null, skipToSandboxRoot:Boolean = false) : Rectangle
      {
         var request:Request = null;
         var sandboxRoot:DisplayObject = null;
         var s:Rectangle = null;
         var pt:Point = null;
         var obj:DisplayObjectContainer = null;
         var visibleRect:Rectangle = null;
         if(hasEventListener("getVisibleApplicationRect"))
         {
            request = new Request("getVisibleApplicationRect",false,true);
            request.value = {
               "bounds":bounds,
               "skipToSandboxRoot":skipToSandboxRoot
            };
            if(!dispatchEvent(request))
            {
               return Rectangle(request.value);
            }
         }
         if(skipToSandboxRoot && !this.mx_internal::topLevel)
         {
            return this.topLevelSystemManager.getVisibleApplicationRect(bounds,skipToSandboxRoot);
         }
         if(!bounds)
         {
            bounds = getBounds(DisplayObject(this));
            sandboxRoot = this.getSandboxRoot();
            s = this.screen.clone();
            s.topLeft = sandboxRoot.localToGlobal(this.screen.topLeft);
            s.bottomRight = sandboxRoot.localToGlobal(this.screen.bottomRight);
            pt = new Point(Math.max(0,bounds.x),Math.max(0,bounds.y));
            pt = localToGlobal(pt);
            bounds.x = pt.x;
            bounds.y = pt.y;
            bounds.width = s.width;
            bounds.height = s.height;
         }
         if(!this.mx_internal::topLevel)
         {
            obj = this.parent.parent;
            if("getVisibleApplicationRect" in obj)
            {
               visibleRect = obj["getVisibleApplicationRect"](true);
               bounds = bounds.intersection(visibleRect);
            }
         }
         return bounds;
      }
      
      public function deployMouseShields(deploy:Boolean) : void
      {
         var dynamicEvent:DynamicEvent = null;
         if(hasEventListener("deployMouseShields"))
         {
            dynamicEvent = new DynamicEvent("deployMouseShields");
            dynamicEvent.deploy = deploy;
            dispatchEvent(dynamicEvent);
         }
      }
      
      private function stageEventHandler(event:Event) : void
      {
         var mouseEvent:MouseEvent = null;
         var stagePoint:Point = null;
         var mouesCatcherLocalPoint:Point = null;
         if(event.target is Stage && Boolean(this.mouseCatcher))
         {
            if(event is MouseEvent)
            {
               mouseEvent = MouseEvent(event);
               stagePoint = new Point(mouseEvent.stageX,mouseEvent.stageY);
               mouesCatcherLocalPoint = this.mouseCatcher.globalToLocal(stagePoint);
               mouseEvent.localX = mouesCatcherLocalPoint.x;
               mouseEvent.localY = mouesCatcherLocalPoint.y;
            }
            this.mouseCatcher.dispatchEvent(event);
         }
      }
      
      private function mouseLeaveHandler(event:Event) : void
      {
         dispatchEvent(new SandboxMouseEvent(SandboxMouseEvent.MOUSE_UP_SOMEWHERE));
      }
   }
}
