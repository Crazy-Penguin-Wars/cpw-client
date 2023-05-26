package no.olog
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   internal class Owindow extends Sprite
   {
      
      internal static var exists:Boolean;
      
      private static var _i:Owindow;
      
      private static var _titleBarBg:Sprite;
      
      private static var _titleBarField:TextField;
      
      private static var _memUsageField:TextField;
      
      private static var _bg:Shape;
      
      private static var _field:TextField;
      
      private static var _dragger:Sprite;
      
      private static var _maximizeBtn:Sprite;
      
      private static var _closeBtn:Sprite;
      
      private static var _titlebarButtonWrapper:Sprite;
      
      private static var _minimizeBtn:Sprite;
      
      private static var _cmi:ContextMenuItem;
      
      private static var _isMinimized:Boolean;
      
      private static var _unreadCountDisplay:Sprite;
      
      private static var _unreadCountField:TextField;
      
      private static var _numUnread:int = 0;
      
      private static var _prefsButton:Sprite;
      
      private static var _prefPane:OprefPane;
      
      private static var _prefPaneOpen:Boolean;
      
      private static var _lastUnreadColorIndex:int = 0;
       
      
      public function Owindow()
      {
         super();
         _init();
         visible = false;
      }
      
      private static function _positionMemUsageField() : void
      {
         _memUsageField.x = _prefsButton.x - _prefsButton.width * 0.5 - _memUsageField.width - 5 * 2;
      }
      
      internal static function get instance() : Owindow
      {
         if(!_i)
         {
            _i = new Owindow();
         }
         return _i;
      }
      
      internal static function getLogText() : String
      {
         return _field.text;
      }
      
      internal static function get isOpen() : Boolean
      {
         return !!_i ? _i.visible : false;
      }
      
      internal static function get isMinimized() : Boolean
      {
         return _isMinimized;
      }
      
      internal static function open(e:Event = null) : void
      {
         _i.visible = true;
         _updateCMI();
         Otils.recordWindowState();
         Otils.startMemoryUsageUpdater();
      }
      
      internal static function displayMemoryUsage(memMB:Number) : void
      {
         _memUsageField.textColor = memMB < Oplist.memoryUsageLimitMB ? Oplist.TEXT_COLORS_UINT[0] : Oplist.TEXT_COLORS_UINT[3];
         _memUsageField.text = memMB + " MB";
         _positionMemUsageField();
      }
      
      internal static function close(e:Event = null) : void
      {
         _i.visible = false;
         _updateCMI();
         Otils.recordWindowState();
         Otils.stopMemoryUsageUpdater();
      }
      
      internal static function write(str:String) : void
      {
         _field.htmlText += "<p>" + str + "</p>";
         _updateUnread();
         if(Oplist.scrollOnNewLine)
         {
            scrollEnd();
         }
      }
      
      internal static function showNewVersionMsg(msg:String) : void
      {
         _titleBarField.htmlText += msg;
      }
      
      internal static function maximize() : void
      {
         if(no.olog.Owindow._isMinimized)
         {
            Owindow.unMinimize();
         }
         _i.x = 5;
         _i.y = 5;
         var w:int = _i.stage.stageWidth - 5 * 2;
         var h:int = _i.stage.stageHeight - 5 * 2;
         _resize(w,h);
      }
      
      internal static function resizeToDefault() : void
      {
         if(exists && !no.olog.Owindow._isMinimized)
         {
            _i.x = Oplist.x;
            _i.y = Oplist.y;
            _resize(Oplist.width,Oplist.height);
         }
      }
      
      internal static function updateTitleBar() : void
      {
         _titleBarField.htmlText = Ocore.getTitleBarText();
      }
      
      internal static function createCMI() : void
      {
         var target:* = null;
         if(_cmi)
         {
            return;
         }
         if(Ocore.originalParent is Stage)
         {
            target = Ocore.originalParent.getChildAt(0) as DisplayObjectContainer;
         }
         else
         {
            target = _i.parent;
         }
         try
         {
            _cmi = new ContextMenuItem("Open log");
            _cmi.addEventListener("menuItemSelect",Ocore.evalOpenClose);
            target.contextMenu = new ContextMenu();
            target.contextMenu["customItems"].push(_cmi);
         }
         catch(error:Error)
         {
            Ocore.trace("Unable to create context menu item",1,"Olog");
         }
      }
      
      internal static function removeCMI() : void
      {
         var i:int = 0;
         if(!_cmi)
         {
            return;
         }
         var cmis:Array = _i.stage.contextMenu["customItems"];
         var num:int = cmis.length;
         for(i = 0; i < num; )
         {
            if(cmis[i] == _cmi)
            {
               cmis.splice(i,1);
               break;
            }
            i++;
         }
         _cmi = null;
         _i.stage.contextMenu = null;
      }
      
      internal static function clear() : void
      {
         _field.text = "";
      }
      
      internal static function scrollHome() : void
      {
         _field.scrollV = 0;
      }
      
      internal static function scrollDown() : void
      {
         if(_field.scrollV < _field.maxScrollV)
         {
            _field.scrollV++;
         }
      }
      
      internal static function scrollUp() : void
      {
         if(_field.scrollV > 0)
         {
            _field.scrollV--;
         }
      }
      
      internal static function scrollEnd() : void
      {
         _field.scrollV = _field.maxScrollV;
      }
      
      internal static function minimize() : void
      {
         _bg.visible = false;
         _field.visible = false;
         _dragger.visible = false;
         _isMinimized = true;
         _prefsButton.visible = false;
         _prefPane.visible = false;
      }
      
      internal static function unMinimize() : void
      {
         _bg.visible = true;
         _field.visible = true;
         _dragger.visible = true;
         _isMinimized = false;
         _resetAndHideUnread();
         _prefsButton.visible = true;
         _prefPane.visible = _prefPaneOpen;
      }
      
      internal static function moveToTop(e:Event = null) : void
      {
         _i.parent.setChildIndex(_i,_i.parent.numChildren - 1);
      }
      
      private static function _updateCMI() : void
      {
         if(!_cmi)
         {
            return;
         }
         if(_i.visible)
         {
            _cmi.caption = "Close log";
         }
         else
         {
            _cmi.caption = "Open log";
         }
      }
      
      private static function _updateUnread() : void
      {
         if(_isMinimized)
         {
            _numUnread++;
            _unreadCountField.text = String(_numUnread);
            _unreadCountDisplay.visible = true;
            _updateUnreadBckgroundColor();
         }
      }
      
      private static function _updateUnreadBckgroundColor() : void
      {
         var color:* = 0;
         var lastLineLevel:int = Ocore.getLastLineLevel();
         if(lastLineLevel <= 3 && lastLineLevel > _lastUnreadColorIndex)
         {
            _lastUnreadColorIndex = lastLineLevel == 1 ? 0 : lastLineLevel;
            color = Otils.getLevelColorAsUint(_lastUnreadColorIndex);
            _drawUnreadBackground(color);
         }
      }
      
      private static function _resetAndHideUnread() : void
      {
         _numUnread = 0;
         _lastUnreadColorIndex = 0;
         _unreadCountDisplay.visible = false;
      }
      
      private static function _drawUnreadBackground(color:uint) : void
      {
         var margin:Number = (28 - 18) * 0.5;
         var backgroundRadius:Number = 18 * 0.5;
         var backgroundYPos:Number = backgroundRadius + margin;
         var g:Graphics = _unreadCountDisplay.graphics;
         g.clear();
         g.beginFill(color,0.8);
         g.drawCircle(backgroundRadius,backgroundYPos,backgroundRadius);
         g.endFill();
      }
      
      internal static function setLineWrapping(val:Boolean) : void
      {
         Oplist.wrapLines = val;
         if(_field)
         {
            _field.wordWrap = val;
         }
      }
      
      internal static function onMouseOver(e:MouseEvent) : void
      {
         _i.stage.focus = _field;
      }
      
      private static function _resize(w:int, h:int) : void
      {
         if(w > 100)
         {
            _drawTitleBarBg(w);
            _titleBarBg.width = w;
            _titleBarField.width = w - 5 * 2;
            _unreadCountDisplay.x = w - _unreadCountDisplay.width - 5;
            _bg.width = w;
            _field.width = w - 5 * 2;
            _dragger.x = w - _dragger.width;
            _prefsButton.x = w - _prefsButton.width * 0.5 - 5;
            _prefPane.width = w;
            _positionMemUsageField();
         }
         if(h > 100)
         {
            _bg.height = h - 28;
            _field.height = h - 28 - 5 * 2;
            _dragger.y = h - _dragger.height;
            _prefPane.y = h - _prefPane.height;
         }
      }
      
      private static function _drawTitleBarBg(w:int) : void
      {
         var matrix:Matrix = new Matrix();
         matrix.createGradientBox(w,28,1.5707963267948966);
         var g:Graphics = _titleBarBg.graphics;
         g.clear();
         g.beginGradientFill("linear",Oplist.TB_COLORS,Oplist.TB_ALPHAS,Oplist.TB_RATIOS,matrix);
         g.drawRoundRectComplex(0,0,w,28,5,5,0,0);
         g.endFill();
      }
      
      internal static function replaceLastLine(text:String) : void
      {
         _field.htmlText = Owindow._field.htmlText.replace(/<p>(?!.*<p>).+$/gi,_wrapForOutput(text));
      }
      
      private static function _wrapForOutput(text:String) : String
      {
         return "<p>" + text + "</p>";
      }
      
      internal static function setDefaultBounds() : void
      {
         var b:Rectangle = Otils.getDefaultWindowBounds();
         _i.x = b.x;
         _i.y = b.y;
         _resize(b.width,b.height);
         if(Otils.getSavedMinimizedState())
         {
            Owindow.minimize();
         }
         if(Otils.getSavedOpenState())
         {
            Owindow.open();
         }
      }
      
      public static function hasFocus() : Boolean
      {
         return exists && (_i.stage.focus == _i || _i.stage.focus == _field);
      }
      
      private function _init() : void
      {
         _initTitleBar();
         _initUnread();
         _initBg();
         _initField();
         _initPrefPane();
         _initMemUsageField();
         _initDragger();
         filters = [new DropShadowFilter(2,45,0,0.3,10,10)];
         addEventListener("addedToStage",Ocore.onAddedToStage);
      }
      
      private function _initMemUsageField() : void
      {
         _memUsageField = new TextField();
         _memUsageField.mouseEnabled = false;
         _memUsageField.defaultTextFormat = new TextFormat("_sans",10,Oplist.TEXT_COLORS_UINT[0]);
         _memUsageField.autoSize = "right";
         _memUsageField.text = "0 MB";
         _memUsageField.y = (28 - _memUsageField.textHeight) * 0.5 - 3;
         _positionMemUsageField();
         addChild(_memUsageField);
      }
      
      private function _initPrefPane() : void
      {
         _prefsButton = _getTitleBarButton();
         var g:Graphics = _prefsButton.graphics;
         g.beginFill(10066329,1);
         g.drawCircle(0,0,12.6 * 0.2);
         g.endFill();
         _addTitleBarButtonMouseOver(_prefsButton);
         _prefsButton.addEventListener("click",_onPrefsClick);
         _prefsButton.x = 400 - 12.6 * 0.5 - 5;
         _prefsButton.y = _titleBarBg.height * 0.5 - 1;
         _prefsButton.alpha = 0.7;
         addChild(_prefsButton);
         _prefPane = new OprefPane();
         _prefPane.y = _field.y + _field.height - _prefPane.height;
         _prefPane.visible = false;
         addChild(_prefPane);
      }
      
      private function _initTitleBar() : void
      {
         var g:* = null;
         _titleBarBg = new Sprite();
         _drawTitleBarBg(400);
         _titleBarBg.doubleClickEnabled = true;
         _titleBarBg.addEventListener("mouseDown",_onTitleBarDown);
         _titleBarBg.addEventListener("mouseUp",_onTitleBarUp);
         _titleBarBg.addEventListener("doubleClick",_onMinimizeClick);
         addChild(_titleBarBg);
         _titleBarField = new TextField();
         _titleBarField.mouseEnabled = false;
         _titleBarField.styleSheet = Ocore.getTitleBarCSS();
         _titleBarField.width = 393;
         _titleBarField.htmlText = Ocore.getTitleBarText();
         _titleBarField.x = 5 - 2;
         _titleBarField.y = (28 - _titleBarField.textHeight) * 0.5 - 3;
         addChild(_titleBarField);
         _titlebarButtonWrapper = new Sprite();
         _closeBtn = _getTitleBarButton();
         g = Owindow._closeBtn.graphics;
         g.lineStyle(2,16777215);
         g.moveTo(12.6 * -0.15,12.6 * -0.15);
         g.lineTo(12.6 * 0.15,12.6 * 0.15);
         g.moveTo(12.6 * 0.15,12.6 * -0.15);
         g.lineTo(12.6 * -0.15,12.6 * 0.15);
         _addTitleBarButtonMouseOver(_closeBtn);
         _closeBtn.addEventListener("click",close);
         _closeBtn.alpha = 0.7;
         _titlebarButtonWrapper.addChild(_closeBtn);
         _maximizeBtn = _getTitleBarButton();
         g = _maximizeBtn.graphics;
         g.lineStyle(2,16777215);
         g.moveTo(12.6 * -0.2,0);
         g.lineTo(12.6 * 0.2,0);
         g.moveTo(0,12.6 * -0.2);
         g.lineTo(0,12.6 * 0.2);
         _addTitleBarButtonMouseOver(_maximizeBtn);
         _maximizeBtn.addEventListener("click",_onMaximizeClick);
         _maximizeBtn.alpha = 0.7;
         _maximizeBtn.x = _closeBtn.x + _closeBtn.width + 5 * 0.5;
         _titlebarButtonWrapper.addChild(_maximizeBtn);
         _minimizeBtn = _getTitleBarButton();
         g = _minimizeBtn.graphics;
         g.lineStyle(2,16777215);
         g.moveTo(12.6 * -0.2,0);
         g.lineTo(12.6 * 0.2,0);
         _addTitleBarButtonMouseOver(_minimizeBtn);
         _minimizeBtn.addEventListener("click",_onMinimizeClick);
         _minimizeBtn.alpha = 0.7;
         _minimizeBtn.x = _maximizeBtn.x + _maximizeBtn.width + 5 * 0.5;
         _titlebarButtonWrapper.addChild(_minimizeBtn);
         _titlebarButtonWrapper.x = 13;
         _titlebarButtonWrapper.y = 13;
         addChild(_titlebarButtonWrapper);
      }
      
      private function _getTitleBarButton() : Sprite
      {
         var b:Sprite = new Sprite();
         var g:Graphics = b.graphics;
         g.lineStyle(1,10066329);
         g.beginFill(0,1);
         g.drawCircle(0,0,6.3);
         g.endFill();
         return b;
      }
      
      private function _addTitleBarButtonMouseOver(b:Sprite) : void
      {
         b.addEventListener("mouseOver",_onWindowBtnOver);
         b.addEventListener("mouseOut",_onWindowBtnOut);
      }
      
      private function _onMouseWheel(e:MouseEvent) : void
      {
         if(e.delta < 0)
         {
            scrollDown();
         }
         else if(e.delta > 0)
         {
            scrollUp();
         }
      }
      
      private function _onPrefsClick(e:MouseEvent) : void
      {
         _prefPane.visible = !_prefPane.visible;
         _prefPaneOpen = _prefPane.visible;
         if(_prefPaneOpen)
         {
            _field.height -= _prefPane.height;
         }
         else
         {
            _field.height += _prefPane.height;
         }
      }
      
      private function _onMinimizeClick(e:MouseEvent) : void
      {
         if(!_isMinimized)
         {
            minimize();
         }
         else
         {
            unMinimize();
         }
         Otils.recordWindowState();
      }
      
      private function _onWindowBtnOver(e:MouseEvent) : void
      {
         (e.target as Sprite).alpha = 1;
      }
      
      private function _onWindowBtnOut(e:MouseEvent) : void
      {
         (e.target as Sprite).alpha = 0.7;
      }
      
      private function _onMaximizeClick(e:MouseEvent) : void
      {
         maximize();
         Otils.recordWindowState();
      }
      
      private function _initUnread() : void
      {
         var fmt:TextFormat = new TextFormat("_sans",10,16777215,true);
         fmt.align = "center";
         _unreadCountField = new TextField();
         _unreadCountField.defaultTextFormat = fmt;
         _unreadCountField.text = "0";
         _unreadCountField.width = 20;
         _unreadCountField.height = 10 + 4;
         _unreadCountField.x -= 1;
         _unreadCountField.y = (28 - _unreadCountField.height) * 0.5;
         _unreadCountField.mouseEnabled = false;
         _unreadCountField.filters = [new DropShadowFilter(1,45,0,0.5,1,1)];
         var bgColor:uint = Otils.getLevelColorAsUint(_lastUnreadColorIndex);
         _unreadCountDisplay = new Sprite();
         _unreadCountDisplay.addChild(_unreadCountField);
         _unreadCountDisplay.visible = false;
         addChild(_unreadCountDisplay);
         _drawUnreadBackground(bgColor);
      }
      
      private function _initField() : void
      {
         var fmt:TextFormat = new TextFormat();
         fmt.tabStops = Oplist.TAB_STOPS;
         _field = new TextField();
         _field.useRichTextClipboard = true;
         _field.defaultTextFormat = fmt;
         _field.selectable = true;
         _field.multiline = true;
         _field.wordWrap = Oplist.wrapLines;
         _field.styleSheet = Ocore.getLogCSS();
         _field.width = 400 - 5 * 2;
         _field.height = 312;
         _field.gridFitType = "pixel";
         _field.x = 5;
         _field.y = 28 + 5;
         _field.mouseWheelEnabled = true;
         _field.addEventListener("mouseWheel",_onMouseWheel);
         _field.addEventListener("link",Ocore.onTextLink);
         addChild(_field);
      }
      
      private function _initDragger() : void
      {
         _dragger = new Sprite();
         var g:Graphics = _dragger.graphics;
         g.lineStyle(1,16777215,0.5);
         g.moveTo(10,0);
         g.lineTo(0,10);
         g.moveTo(10,4);
         g.lineTo(4,10);
         g.moveTo(10,8);
         g.lineTo(8,10);
         g.lineStyle(0,0,0);
         g.beginFill(0,0);
         g.drawRect(0,0,12,12);
         g.endFill();
         _dragger.x = 400 - _dragger.width;
         _dragger.y = 350 - _dragger.height;
         _dragger.addEventListener("mouseDown",_onDraggerDown);
         _dragger.addEventListener("mouseUp",_onDraggerUp);
         addChild(_dragger);
      }
      
      private function _onTitleBarDown(e:MouseEvent) : void
      {
         stage.addEventListener("mouseUp",_onTitleBarUp);
         _i.startDrag();
      }
      
      private function _onTitleBarUp(e:MouseEvent) : void
      {
         stage.removeEventListener("mouseUp",_onTitleBarUp);
         _i.stopDrag();
         Otils.recordWindowState();
      }
      
      private function _onDraggerDown(e:MouseEvent) : void
      {
         stage.addEventListener("enterFrame",_onDraggerMove);
         stage.addEventListener("mouseUp",_onDraggerUp);
      }
      
      private function _onDraggerMove(event:Event) : void
      {
         var w:int = stage.mouseX + _dragger.width * 0.5 - x;
         var h:int = stage.mouseY + _dragger.height * 0.5 - y;
         _resize(w,h);
      }
      
      private function _onDraggerUp(e:MouseEvent) : void
      {
         stage.removeEventListener("mouseUp",_onDraggerUp);
         stage.removeEventListener("enterFrame",_onDraggerMove);
         Otils.recordWindowState();
      }
      
      private function _initBg() : void
      {
         _bg = new Shape();
         var g:Graphics = _bg.graphics;
         g.beginFill(1842204,0.9);
         g.drawRect(0,0,400,350 - 28);
         g.endFill();
         _bg.y = 28;
         addChild(_bg);
      }
   }
}
