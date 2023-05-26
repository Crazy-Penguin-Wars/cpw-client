package mx.managers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Mouse;
   import mx.core.EventPriority;
   import mx.core.FlexGlobals;
   import mx.core.FlexSprite;
   import mx.core.IFlexModuleFactory;
   import mx.core.ISystemCursorClient;
   import mx.core.mx_internal;
   import mx.events.Request;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class CursorManagerImpl extends EventDispatcher implements ICursorManager
   {
      
      mx_internal static const VERSION:String = "4.5.1.21489";
      
      private static var instance:ICursorManager;
      
      public static var mixins:Array;
       
      
      private var nextCursorID:int = 1;
      
      private var cursorList:Array;
      
      private var busyCursorList:Array;
      
      mx_internal var initialized:Boolean = false;
      
      mx_internal var cursorHolder:Sprite;
      
      private var currentCursor:DisplayObject;
      
      private var listenForContextMenu:Boolean = false;
      
      private var overTextField:Boolean = false;
      
      private var overLink:Boolean = false;
      
      private var showSystemCursor:Boolean = false;
      
      private var showCustomCursor:Boolean = false;
      
      private var customCursorLeftStage:Boolean = false;
      
      mx_internal var systemManager:ISystemManager = null;
      
      mx_internal var sandboxRoot:IEventDispatcher = null;
      
      private var sourceArray:Array;
      
      mx_internal var _currentCursorID:int = 0;
      
      mx_internal var _currentCursorXOffset:Number = 0;
      
      mx_internal var _currentCursorYOffset:Number = 0;
      
      public function CursorManagerImpl(systemManager:ISystemManager = null)
      {
         var n:int = 0;
         var i:int = 0;
         this.cursorList = [];
         this.busyCursorList = [];
         this.sourceArray = [];
         super();
         if(Boolean(instance) && !systemManager)
         {
            throw new Error("Instance already exists.");
         }
         if(Boolean(systemManager))
         {
            this.mx_internal::systemManager = systemManager as ISystemManager;
         }
         else
         {
            this.mx_internal::systemManager = SystemManagerGlobals.topLevelSystemManagers[0] as ISystemManager;
         }
         if(Boolean(mixins))
         {
            n = mixins.length;
            for(i = 0; i < n; i++)
            {
               new mixins[i](this);
            }
         }
      }
      
      public static function getInstance() : ICursorManager
      {
         if(!instance)
         {
            instance = new CursorManagerImpl();
         }
         return instance;
      }
      
      public function get currentCursorID() : int
      {
         return this.mx_internal::_currentCursorID;
      }
      
      public function set currentCursorID(value:int) : void
      {
         this.mx_internal::_currentCursorID = value;
         if(hasEventListener("currentCursorID"))
         {
            dispatchEvent(new Event("currentCursorID"));
         }
      }
      
      public function get currentCursorXOffset() : Number
      {
         return this.mx_internal::_currentCursorXOffset;
      }
      
      public function set currentCursorXOffset(value:Number) : void
      {
         this.mx_internal::_currentCursorXOffset = value;
         if(hasEventListener("currentCursorXOffset"))
         {
            dispatchEvent(new Event("currentCursorXOffset"));
         }
      }
      
      public function get currentCursorYOffset() : Number
      {
         return this.mx_internal::_currentCursorYOffset;
      }
      
      public function set currentCursorYOffset(value:Number) : void
      {
         this.mx_internal::_currentCursorYOffset = value;
         if(hasEventListener("currentCursorYOffset"))
         {
            dispatchEvent(new Event("currentCursorYOffset"));
         }
      }
      
      public function showCursor() : void
      {
         if(Boolean(this.mx_internal::cursorHolder))
         {
            this.mx_internal::cursorHolder.visible = true;
         }
         if(hasEventListener("showCursor"))
         {
            dispatchEvent(new Event("showCursor"));
         }
      }
      
      public function hideCursor() : void
      {
         if(Boolean(this.mx_internal::cursorHolder))
         {
            this.mx_internal::cursorHolder.visible = false;
         }
         if(hasEventListener("hideCursor"))
         {
            dispatchEvent(new Event("hideCursor"));
         }
      }
      
      public function setCursor(cursorClass:Class, priority:int = 2, xOffset:Number = 0, yOffset:Number = 0) : int
      {
         var event:Request = null;
         if(hasEventListener("setCursor"))
         {
            event = new Request("setCursor",false,true);
            event.value = [cursorClass,priority,xOffset,yOffset];
            if(!dispatchEvent(event))
            {
               return event.value as int;
            }
         }
         var cursorID:int = this.nextCursorID++;
         var item:CursorQueueItem = new CursorQueueItem();
         item.cursorID = cursorID;
         item.cursorClass = cursorClass;
         item.priority = priority;
         item.x = xOffset;
         item.y = yOffset;
         if(Boolean(this.mx_internal::systemManager))
         {
            item.systemManager = this.mx_internal::systemManager;
         }
         else
         {
            item.systemManager = FlexGlobals.topLevelApplication.systemManager;
         }
         this.cursorList.push(item);
         this.cursorList.sort(this.priorityCompare);
         this.showCurrentCursor();
         return cursorID;
      }
      
      private function priorityCompare(a:CursorQueueItem, b:CursorQueueItem) : int
      {
         if(a.priority < b.priority)
         {
            return -1;
         }
         if(a.priority == b.priority)
         {
            return 0;
         }
         return 1;
      }
      
      public function removeCursor(cursorID:int) : void
      {
         var i:* = null;
         var item:CursorQueueItem = null;
         if(hasEventListener("removeCursor"))
         {
            if(!dispatchEvent(new Request("removeCursor",false,true,cursorID)))
            {
               return;
            }
         }
         for(i in this.cursorList)
         {
            item = this.cursorList[i];
            if(item.cursorID == cursorID)
            {
               this.cursorList.splice(i,1);
               this.showCurrentCursor();
               break;
            }
         }
      }
      
      public function removeAllCursors() : void
      {
         if(hasEventListener("removeAllCursors"))
         {
            if(!dispatchEvent(new Event("removeAllCursors",false,true)))
            {
               return;
            }
         }
         this.cursorList.splice(0);
         this.showCurrentCursor();
      }
      
      public function setBusyCursor() : void
      {
         if(hasEventListener("setBusyCursor"))
         {
            if(!dispatchEvent(new Event("setBusyCursor",false,true)))
            {
               return;
            }
         }
         var cursorManagerStyleDeclaration:CSSStyleDeclaration = StyleManager.getStyleManager(this.mx_internal::systemManager as IFlexModuleFactory).getMergedStyleDeclaration("mx.managers.CursorManager");
         var busyCursorClass:Class = cursorManagerStyleDeclaration.getStyle("busyCursor");
         this.busyCursorList.push(this.setCursor(busyCursorClass,CursorManagerPriority.LOW));
      }
      
      public function removeBusyCursor() : void
      {
         if(hasEventListener("removeBusyCursor"))
         {
            if(!dispatchEvent(new Event("removeBusyCursor",false,true)))
            {
               return;
            }
         }
         if(this.busyCursorList.length > 0)
         {
            this.removeCursor(int(this.busyCursorList.pop()));
         }
      }
      
      private function showCurrentCursor() : void
      {
         var item:CursorQueueItem = null;
         var e:Event = null;
         var pt:Point = null;
         var e2:Event = null;
         var e3:Event = null;
         var e4:Event = null;
         var e5:Event = null;
         if(this.cursorList.length > 0)
         {
            if(!this.mx_internal::initialized)
            {
               this.mx_internal::initialized = true;
               if(hasEventListener("initialize"))
               {
                  e = new Event("initialize",false,true);
               }
               if(!e || dispatchEvent(e))
               {
                  this.mx_internal::cursorHolder = new FlexSprite();
                  this.mx_internal::cursorHolder.name = "cursorHolder";
                  this.mx_internal::cursorHolder.mouseEnabled = false;
                  this.mx_internal::cursorHolder.mouseChildren = false;
                  this.mx_internal::systemManager.cursorChildren.addChild(this.mx_internal::cursorHolder);
               }
            }
            item = this.cursorList[0];
            if(this.currentCursorID == CursorManager.NO_CURSOR)
            {
               Mouse.hide();
            }
            if(item.cursorID != this.currentCursorID)
            {
               if(this.mx_internal::cursorHolder.numChildren > 0)
               {
                  this.mx_internal::cursorHolder.removeChildAt(0);
               }
               this.currentCursor = new item.cursorClass();
               if(Boolean(this.currentCursor))
               {
                  if(this.currentCursor is InteractiveObject)
                  {
                     InteractiveObject(this.currentCursor).mouseEnabled = false;
                  }
                  if(this.currentCursor is DisplayObjectContainer)
                  {
                     DisplayObjectContainer(this.currentCursor).mouseChildren = false;
                  }
                  this.mx_internal::cursorHolder.addChild(this.currentCursor);
                  this.addContextMenuHandlers();
                  if(this.mx_internal::systemManager is SystemManager)
                  {
                     pt = new Point(SystemManager(this.mx_internal::systemManager).mouseX + item.x,SystemManager(this.mx_internal::systemManager).mouseY + item.y);
                     pt = SystemManager(this.mx_internal::systemManager).localToGlobal(pt);
                     pt = this.mx_internal::cursorHolder.parent.globalToLocal(pt);
                     this.mx_internal::cursorHolder.x = pt.x;
                     this.mx_internal::cursorHolder.y = pt.y;
                  }
                  else if(this.mx_internal::systemManager is DisplayObject)
                  {
                     pt = new Point(DisplayObject(this.mx_internal::systemManager).mouseX + item.x,DisplayObject(this.mx_internal::systemManager).mouseY + item.y);
                     pt = DisplayObject(this.mx_internal::systemManager).localToGlobal(pt);
                     pt = this.mx_internal::cursorHolder.parent.globalToLocal(pt);
                     this.mx_internal::cursorHolder.x = DisplayObject(this.mx_internal::systemManager).mouseX + item.x;
                     this.mx_internal::cursorHolder.y = DisplayObject(this.mx_internal::systemManager).mouseY + item.y;
                  }
                  else
                  {
                     this.mx_internal::cursorHolder.x = item.x;
                     this.mx_internal::cursorHolder.y = item.y;
                  }
                  if(hasEventListener("addMouseMoveListener"))
                  {
                     e2 = new Event("addMouseMoveListener",false,true);
                  }
                  if(!e2 || dispatchEvent(e2))
                  {
                     this.mx_internal::systemManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mx_internal::mouseMoveHandler,true,EventPriority.CURSOR_MANAGEMENT);
                  }
                  if(hasEventListener("addMouseOutListener"))
                  {
                     e3 = new Event("addMouseOutListener",false,true);
                  }
                  if(!e3 || dispatchEvent(e3))
                  {
                     this.mx_internal::systemManager.stage.addEventListener(MouseEvent.MOUSE_OUT,this.mx_internal::mouseOutHandler,true,EventPriority.CURSOR_MANAGEMENT);
                  }
               }
               this.currentCursorID = item.cursorID;
               this.currentCursorXOffset = item.x;
               this.currentCursorYOffset = item.y;
            }
         }
         else
         {
            this.showCustomCursor = false;
            if(this.currentCursorID != CursorManager.NO_CURSOR)
            {
               this.currentCursorID = CursorManager.NO_CURSOR;
               this.currentCursorXOffset = 0;
               this.currentCursorYOffset = 0;
               if(hasEventListener("removeMouseMoveListener"))
               {
                  e4 = new Event("removeMouseMoveListener",false,true);
               }
               if(!e4 || dispatchEvent(e4))
               {
                  this.mx_internal::systemManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mx_internal::mouseMoveHandler,true);
               }
               if(hasEventListener("removeMouseMoveListener"))
               {
                  e5 = new Event("removeMouseOutListener",false,true);
               }
               if(!e5 || dispatchEvent(e5))
               {
                  this.mx_internal::systemManager.stage.removeEventListener(MouseEvent.MOUSE_OUT,this.mx_internal::mouseOutHandler,true);
               }
               this.mx_internal::cursorHolder.removeChild(this.currentCursor);
               this.removeContextMenuHandlers();
            }
            Mouse.show();
         }
      }
      
      private function addContextMenuHandlers() : void
      {
         var app:InteractiveObject = null;
         var sm:InteractiveObject = null;
         if(!this.listenForContextMenu)
         {
            app = this.mx_internal::systemManager.document as InteractiveObject;
            sm = this.mx_internal::systemManager as InteractiveObject;
            if(Boolean(app) && Boolean(app.contextMenu))
            {
               app.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT,this.contextMenu_menuSelectHandler,true,EventPriority.CURSOR_MANAGEMENT);
               this.listenForContextMenu = true;
            }
            if(Boolean(sm) && Boolean(sm.contextMenu))
            {
               sm.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT,this.contextMenu_menuSelectHandler,true,EventPriority.CURSOR_MANAGEMENT);
               this.listenForContextMenu = true;
            }
         }
      }
      
      private function removeContextMenuHandlers() : void
      {
         var app:InteractiveObject = null;
         var sm:InteractiveObject = null;
         if(this.listenForContextMenu)
         {
            app = this.mx_internal::systemManager.document as InteractiveObject;
            sm = this.mx_internal::systemManager as InteractiveObject;
            if(Boolean(app) && Boolean(app.contextMenu))
            {
               app.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,this.contextMenu_menuSelectHandler,true);
            }
            if(Boolean(sm) && Boolean(sm.contextMenu))
            {
               sm.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,this.contextMenu_menuSelectHandler,true);
            }
            this.listenForContextMenu = false;
         }
      }
      
      public function registerToUseBusyCursor(source:Object) : void
      {
         if(hasEventListener("registerToUseBusyCursor"))
         {
            if(!dispatchEvent(new Request("registerToUseBusyCursor",false,true,source)))
            {
               return;
            }
         }
         if(Boolean(source) && source is EventDispatcher)
         {
            source.addEventListener(ProgressEvent.PROGRESS,this.progressHandler);
            source.addEventListener(Event.COMPLETE,this.completeHandler);
            source.addEventListener(IOErrorEvent.IO_ERROR,this.completeHandler);
         }
      }
      
      public function unRegisterToUseBusyCursor(source:Object) : void
      {
         if(hasEventListener("unRegisterToUseBusyCursor"))
         {
            if(!dispatchEvent(new Request("unRegisterToUseBusyCursor",false,true,source)))
            {
               return;
            }
         }
         if(Boolean(source) && source is EventDispatcher)
         {
            source.removeEventListener(ProgressEvent.PROGRESS,this.progressHandler);
            source.removeEventListener(Event.COMPLETE,this.completeHandler);
            source.removeEventListener(IOErrorEvent.IO_ERROR,this.completeHandler);
         }
      }
      
      private function contextMenu_menuSelectHandler(event:ContextMenuEvent) : void
      {
         this.showCustomCursor = true;
         this.mx_internal::sandboxRoot.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
      }
      
      private function mouseOverHandler(event:MouseEvent) : void
      {
         this.mx_internal::sandboxRoot.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this.mx_internal::mouseMoveHandler(event);
      }
      
      private function findSource(target:Object) : int
      {
         var n:int = this.sourceArray.length;
         for(var i:int = 0; i < n; i++)
         {
            if(this.sourceArray[i] === target)
            {
               return i;
            }
         }
         return -1;
      }
      
      mx_internal function mouseOutHandler(event:MouseEvent) : void
      {
         if(event.relatedObject == null && this.cursorList.length > 0)
         {
            this.customCursorLeftStage = true;
            this.hideCursor();
            Mouse.show();
         }
      }
      
      mx_internal function mouseMoveHandler(event:MouseEvent) : void
      {
         var pt:Point = new Point(event.stageX,event.stageY);
         pt = this.mx_internal::cursorHolder.parent.globalToLocal(pt);
         pt.x += this.currentCursorXOffset;
         pt.y += this.currentCursorYOffset;
         this.mx_internal::cursorHolder.x = pt.x;
         this.mx_internal::cursorHolder.y = pt.y;
         var target:Object = event.target;
         var isInputTextField:Boolean = target is TextField && target.type == TextFieldType.INPUT || target is ISystemCursorClient && Boolean(ISystemCursorClient(target).showSystemCursor);
         if(!this.overTextField && isInputTextField)
         {
            this.overTextField = true;
            this.showSystemCursor = true;
         }
         else if(this.overTextField && !isInputTextField)
         {
            this.overTextField = false;
            this.showCustomCursor = true;
         }
         else
         {
            this.showCustomCursor = true;
         }
         if(this.showSystemCursor)
         {
            this.showSystemCursor = false;
            this.mx_internal::cursorHolder.visible = false;
            Mouse.show();
         }
         if(this.showCustomCursor)
         {
            this.showCustomCursor = false;
            this.mx_internal::cursorHolder.visible = true;
            Mouse.hide();
            if(hasEventListener("showCustomCursor"))
            {
               dispatchEvent(new Event("showCustomCursor"));
            }
         }
      }
      
      private function progressHandler(event:ProgressEvent) : void
      {
         var sourceIndex:int = this.findSource(event.target);
         if(sourceIndex == -1)
         {
            this.sourceArray.push(event.target);
            this.setBusyCursor();
         }
      }
      
      private function completeHandler(event:Event) : void
      {
         var sourceIndex:int = this.findSource(event.target);
         if(sourceIndex != -1)
         {
            this.sourceArray.splice(sourceIndex,1);
            this.removeBusyCursor();
         }
      }
   }
}

import mx.core.mx_internal;
import mx.managers.ISystemManager;

class CursorQueueItem
{
   
   mx_internal static const VERSION:String = "4.5.1.21489";
    
   
   public var cursorID:int = 0;
   
   public var cursorClass:Class = null;
   
   public var priority:int = 2;
   
   public var systemManager:ISystemManager;
   
   public var x:Number;
   
   public var y:Number;
   
   public function CursorQueueItem()
   {
      super();
   }
}
