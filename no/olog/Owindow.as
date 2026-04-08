package no.olog
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.ui.*;
   
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
      
      private static var _prefsButton:Sprite;
      
      private static var _prefPane:OprefPane;
      
      private static var _prefPaneOpen:Boolean;
      
      private static var _numUnread:int = 0;
      
      private static var _lastUnreadColorIndex:int = 0;
      
      public function Owindow()
      {
         super();
         this._init();
         visible = false;
      }
      
      private static function _positionMemUsageField() : void
      {
         _memUsageField.x = _prefsButton.x - _prefsButton.width * 0.5 - _memUsageField.width - Oplist.PADDING * 2;
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
         return !!_i ? Boolean(_i.visible) : false;
      }
      
      internal static function get isMinimized() : Boolean
      {
         return _isMinimized;
      }
      
      internal static function open(param1:Event = null) : void
      {
         _i.visible = true;
         _updateCMI();
         Otils.recordWindowState();
         Otils.startMemoryUsageUpdater();
      }
      
      internal static function displayMemoryUsage(param1:Number) : void
      {
         _memUsageField.textColor = param1 < Oplist.memoryUsageLimitMB ? uint(Oplist.TEXT_COLORS_UINT[0]) : uint(Oplist.TEXT_COLORS_UINT[3]);
         _memUsageField.text = param1 + " MB";
         _positionMemUsageField();
      }
      
      internal static function close(param1:Event = null) : void
      {
         _i.visible = false;
         _updateCMI();
         Otils.recordWindowState();
         Otils.stopMemoryUsageUpdater();
      }
      
      internal static function write(param1:String) : void
      {
         _field.htmlText += "<p>" + param1 + "</p>";
         _updateUnread();
         if(Oplist.scrollOnNewLine)
         {
            scrollEnd();
         }
      }
      
      internal static function showNewVersionMsg(param1:String) : void
      {
         _titleBarField.htmlText += param1;
      }
      
      internal static function maximize() : void
      {
         if(isMinimized)
         {
            Owindow.unMinimize();
         }
         _i.x = Oplist.PADDING;
         _i.y = Oplist.PADDING;
         var _loc1_:int = _i.stage.stageWidth - Oplist.PADDING * 2;
         var _loc2_:int = _i.stage.stageHeight - Oplist.PADDING * 2;
         _resize(_loc1_,_loc2_);
      }
      
      internal static function resizeToDefault() : void
      {
         if(Boolean(exists) && !isMinimized)
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
         var target:DisplayObjectContainer = null;
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
            _cmi = new ContextMenuItem(Oplist.CMI_OPEN_LABEL);
            _cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Ocore.evalOpenClose);
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
         if(!_cmi)
         {
            return;
         }
         var _loc1_:Array = _i.stage.contextMenu["customItems"];
         var _loc2_:int = int(_loc1_.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(_loc1_[_loc3_] == _cmi)
            {
               _loc1_.splice(_loc3_,1);
               break;
            }
            _loc3_++;
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
            ++_field.scrollV;
         }
      }
      
      internal static function scrollUp() : void
      {
         if(_field.scrollV > 0)
         {
            --_field.scrollV;
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
      
      internal static function moveToTop(param1:Event = null) : void
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
            _cmi.caption = Oplist.CMI_CLOSE_LABEL;
         }
         else
         {
            _cmi.caption = Oplist.CMI_OPEN_LABEL;
         }
      }
      
      private static function _updateUnread() : void
      {
         if(_isMinimized)
         {
            ++_numUnread;
            _unreadCountField.text = String(_numUnread);
            _unreadCountDisplay.visible = true;
            _updateUnreadBckgroundColor();
         }
      }
      
      private static function _updateUnreadBckgroundColor() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:int = int(Ocore.getLastLineLevel());
         if(_loc1_ <= Oplist.TEXT_COLOR_LAST_ERROR_INDEX && _loc1_ > _lastUnreadColorIndex)
         {
            _lastUnreadColorIndex = _loc1_ == 1 ? 0 : _loc1_;
            _loc2_ = uint(Otils.getLevelColorAsUint(_lastUnreadColorIndex));
            _drawUnreadBackground(_loc2_);
         }
      }
      
      private static function _resetAndHideUnread() : void
      {
         _numUnread = 0;
         _lastUnreadColorIndex = 0;
         _unreadCountDisplay.visible = false;
      }
      
      private static function _drawUnreadBackground(param1:uint) : void
      {
         var _loc2_:Number = Oplist.TB_HEIGHT - Oplist.PADDING * 2;
         var _loc3_:Number = (Oplist.TB_HEIGHT - _loc2_) * 0.5;
         var _loc4_:Number = _loc2_ * 0.5;
         var _loc5_:Number = _loc4_ + _loc3_;
         var _loc6_:Graphics = _unreadCountDisplay.graphics;
         _loc6_.clear();
         _loc6_.beginFill(param1,0.8);
         _loc6_.drawCircle(_loc4_,_loc5_,_loc4_);
         _loc6_.endFill();
      }
      
      internal static function setLineWrapping(param1:Boolean) : void
      {
         Oplist.wrapLines = param1;
         if(_field)
         {
            _field.wordWrap = param1;
         }
      }
      
      internal static function onMouseOver(param1:MouseEvent) : void
      {
         _i.stage.focus = _field;
      }
      
      private static function _resize(param1:int, param2:int) : void
      {
         var _loc3_:int = int(Oplist.TB_HEIGHT);
         var _loc4_:int = int(Oplist.PADDING);
         if(param1 > Oplist.MIN_WIDTH)
         {
            _drawTitleBarBg(param1);
            _titleBarBg.width = param1;
            _titleBarField.width = param1 - _loc4_ * 2;
            _unreadCountDisplay.x = param1 - _unreadCountDisplay.width - _loc4_;
            _bg.width = param1;
            _field.width = param1 - _loc4_ * 2;
            _dragger.x = param1 - _dragger.width;
            _prefsButton.x = param1 - _prefsButton.width * 0.5 - _loc4_;
            _prefPane.width = param1;
            _positionMemUsageField();
         }
         if(param2 > Oplist.MIN_HEIGHT)
         {
            _bg.height = param2 - _loc3_;
            _field.height = param2 - _loc3_ - _loc4_ * 2;
            _dragger.y = param2 - _dragger.height;
            _prefPane.y = param2 - _prefPane.height;
         }
      }
      
      private static function _drawTitleBarBg(param1:int) : void
      {
         var _loc2_:int = int(Oplist.TB_HEIGHT);
         var _loc3_:Matrix = new Matrix();
         _loc3_.createGradientBox(param1,_loc2_,Math.PI / 180 * 90);
         var _loc4_:Graphics = _titleBarBg.graphics;
         _loc4_.clear();
         _loc4_.beginGradientFill(GradientType.LINEAR,Oplist.TB_COLORS,Oplist.TB_ALPHAS,Oplist.TB_RATIOS,_loc3_);
         _loc4_.drawRoundRectComplex(0,0,param1,_loc2_,Oplist.CORNER_RADIUS,Oplist.CORNER_RADIUS,0,0);
         _loc4_.endFill();
      }
      
      internal static function replaceLastLine(param1:String) : void
      {
         _field.htmlText = Owindow._field.htmlText.replace(/<p>(?!.*<p>).+$/gi,_wrapForOutput(param1));
      }
      
      private static function _wrapForOutput(param1:String) : String
      {
         return "<p>" + param1 + "</p>";
      }
      
      internal static function setDefaultBounds() : void
      {
         var _loc1_:flash.geom.Rectangle = Otils.getDefaultWindowBounds();
         _i.x = _loc1_.x;
         _i.y = _loc1_.y;
         _resize(_loc1_.width,_loc1_.height);
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
         return Boolean(exists) && (_i.stage.focus == _i || _i.stage.focus == _field);
      }
      
      private function _init() : void
      {
         this._initTitleBar();
         this._initUnread();
         this._initBg();
         this._initField();
         this._initPrefPane();
         this._initMemUsageField();
         this._initDragger();
         filters = [new DropShadowFilter(2,45,0,0.3,10,10)];
         addEventListener(Event.ADDED_TO_STAGE,Ocore.onAddedToStage);
      }
      
      private function _initMemUsageField() : void
      {
         _memUsageField = new TextField();
         _memUsageField.mouseEnabled = false;
         _memUsageField.defaultTextFormat = new TextFormat("_sans",10,Oplist.TEXT_COLORS_UINT[0]);
         _memUsageField.autoSize = TextFieldAutoSize.RIGHT;
         _memUsageField.text = "0 MB";
         _memUsageField.y = (Oplist.TB_HEIGHT - _memUsageField.textHeight) * 0.5 - 3;
         _positionMemUsageField();
         addChild(_memUsageField);
      }
      
      private function _initPrefPane() : void
      {
         var _loc1_:Number = Oplist.TB_HEIGHT * 0.45;
         _prefsButton = this._getTitleBarButton();
         var _loc2_:Graphics = _prefsButton.graphics;
         _loc2_.beginFill(Oplist.BTN_LINE_COLOR,1);
         _loc2_.drawCircle(0,0,_loc1_ * 0.2);
         _loc2_.endFill();
         this._addTitleBarButtonMouseOver(_prefsButton);
         _prefsButton.addEventListener(MouseEvent.CLICK,this._onPrefsClick);
         _prefsButton.x = Oplist.DEFAULT_WIDTH - _loc1_ * 0.5 - Oplist.PADDING;
         _prefsButton.y = _titleBarBg.height * 0.5 - 1;
         _prefsButton.alpha = Oplist.BTN_UP_ALPHA;
         addChild(_prefsButton);
         _prefPane = new OprefPane();
         _prefPane.y = _field.y + _field.height - _prefPane.height;
         _prefPane.visible = false;
         addChild(_prefPane);
      }
      
      private function _initTitleBar() : void
      {
         var _loc3_:Graphics = null;
         var _loc1_:int = int(Oplist.DEFAULT_WIDTH);
         _titleBarBg = new Sprite();
         _drawTitleBarBg(_loc1_);
         _titleBarBg.doubleClickEnabled = true;
         _titleBarBg.addEventListener(MouseEvent.MOUSE_DOWN,this._onTitleBarDown);
         _titleBarBg.addEventListener(MouseEvent.MOUSE_UP,this._onTitleBarUp);
         _titleBarBg.addEventListener(MouseEvent.DOUBLE_CLICK,this._onMinimizeClick);
         addChild(_titleBarBg);
         _titleBarField = new TextField();
         _titleBarField.mouseEnabled = false;
         _titleBarField.styleSheet = Ocore.getTitleBarCSS();
         _titleBarField.width = Oplist.DEFAULT_WIDTH - Oplist.PADDING - 2;
         _titleBarField.htmlText = Ocore.getTitleBarText();
         _titleBarField.x = Oplist.PADDING - 2;
         _titleBarField.y = (Oplist.TB_HEIGHT - _titleBarField.textHeight) * 0.5 - 3;
         addChild(_titleBarField);
         _titlebarButtonWrapper = new Sprite();
         var _loc2_:Number = Oplist.TB_HEIGHT * 0.45;
         _closeBtn = this._getTitleBarButton();
         _loc3_ = Owindow._closeBtn.graphics;
         _loc3_.lineStyle(2,16777215);
         _loc3_.moveTo(_loc2_ * -0.15,_loc2_ * -0.15);
         _loc3_.lineTo(_loc2_ * 0.15,_loc2_ * 0.15);
         _loc3_.moveTo(_loc2_ * 0.15,_loc2_ * -0.15);
         _loc3_.lineTo(_loc2_ * -0.15,_loc2_ * 0.15);
         this._addTitleBarButtonMouseOver(_closeBtn);
         _closeBtn.addEventListener(MouseEvent.CLICK,close);
         _closeBtn.alpha = Oplist.BTN_UP_ALPHA;
         _titlebarButtonWrapper.addChild(_closeBtn);
         _maximizeBtn = this._getTitleBarButton();
         _loc3_ = _maximizeBtn.graphics;
         _loc3_.lineStyle(2,16777215);
         _loc3_.moveTo(_loc2_ * -0.2,0);
         _loc3_.lineTo(_loc2_ * 0.2,0);
         _loc3_.moveTo(0,_loc2_ * -0.2);
         _loc3_.lineTo(0,_loc2_ * 0.2);
         this._addTitleBarButtonMouseOver(_maximizeBtn);
         _maximizeBtn.addEventListener(MouseEvent.CLICK,this._onMaximizeClick);
         _maximizeBtn.alpha = Oplist.BTN_UP_ALPHA;
         _maximizeBtn.x = _closeBtn.x + _closeBtn.width + Oplist.PADDING * 0.5;
         _titlebarButtonWrapper.addChild(_maximizeBtn);
         _minimizeBtn = this._getTitleBarButton();
         _loc3_ = _minimizeBtn.graphics;
         _loc3_.lineStyle(2,16777215);
         _loc3_.moveTo(_loc2_ * -0.2,0);
         _loc3_.lineTo(_loc2_ * 0.2,0);
         this._addTitleBarButtonMouseOver(_minimizeBtn);
         _minimizeBtn.addEventListener(MouseEvent.CLICK,this._onMinimizeClick);
         _minimizeBtn.alpha = Oplist.BTN_UP_ALPHA;
         _minimizeBtn.x = _maximizeBtn.x + _maximizeBtn.width + Oplist.PADDING * 0.5;
         _titlebarButtonWrapper.addChild(_minimizeBtn);
         _titlebarButtonWrapper.x = Oplist.TB_PADDING;
         _titlebarButtonWrapper.y = Oplist.TB_HEIGHT * 0.5 - 1;
         addChild(_titlebarButtonWrapper);
      }
      
      private function _getTitleBarButton() : Sprite
      {
         var _loc1_:Number = Oplist.TB_HEIGHT * 0.225;
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Graphics = _loc2_.graphics;
         _loc3_.lineStyle(1,Oplist.BTN_LINE_COLOR);
         _loc3_.beginFill(Oplist.BTN_FILL_COLOR,1);
         _loc3_.drawCircle(0,0,_loc1_);
         _loc3_.endFill();
         return _loc2_;
      }
      
      private function _addTitleBarButtonMouseOver(param1:Sprite) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_OVER,this._onWindowBtnOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this._onWindowBtnOut);
      }
      
      private function _onMouseWheel(param1:MouseEvent) : void
      {
         if(param1.delta < 0)
         {
            scrollDown();
         }
         else if(param1.delta > 0)
         {
            scrollUp();
         }
      }
      
      private function _onPrefsClick(param1:MouseEvent) : void
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
      
      private function _onMinimizeClick(param1:MouseEvent) : void
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
      
      private function _onWindowBtnOver(param1:MouseEvent) : void
      {
         (param1.target as Sprite).alpha = Oplist.BTN_OVER_ALPHA;
      }
      
      private function _onWindowBtnOut(param1:MouseEvent) : void
      {
         (param1.target as Sprite).alpha = Oplist.BTN_UP_ALPHA;
      }
      
      private function _onMaximizeClick(param1:MouseEvent) : void
      {
         maximize();
         Otils.recordWindowState();
      }
      
      private function _initUnread() : void
      {
         var _loc1_:TextFormat = new TextFormat(Oplist.TB_FONT,Oplist.TB_FONT_SIZE,16777215,true);
         _loc1_.align = TextFormatAlign.CENTER;
         _unreadCountField = new TextField();
         _unreadCountField.defaultTextFormat = _loc1_;
         _unreadCountField.text = "0";
         _unreadCountField.width = 20;
         _unreadCountField.height = Oplist.TB_FONT_SIZE + 4;
         --_unreadCountField.x;
         _unreadCountField.y = (Oplist.TB_HEIGHT - _unreadCountField.height) * 0.5;
         _unreadCountField.mouseEnabled = false;
         _unreadCountField.filters = [new DropShadowFilter(1,45,0,0.5,1,1)];
         var _loc2_:uint = uint(Otils.getLevelColorAsUint(_lastUnreadColorIndex));
         _unreadCountDisplay = new Sprite();
         _unreadCountDisplay.addChild(_unreadCountField);
         _unreadCountDisplay.visible = false;
         addChild(_unreadCountDisplay);
         _drawUnreadBackground(_loc2_);
      }
      
      private function _initField() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.tabStops = Oplist.TAB_STOPS;
         _field = new TextField();
         _field.useRichTextClipboard = true;
         _field.defaultTextFormat = _loc1_;
         _field.selectable = true;
         _field.multiline = true;
         _field.wordWrap = Oplist.wrapLines;
         _field.styleSheet = Ocore.getLogCSS();
         _field.width = Oplist.DEFAULT_WIDTH - Oplist.PADDING * 2;
         _field.height = Oplist.DEFAULT_HEIGHT - Oplist.TB_HEIGHT - Oplist.PADDING * 2;
         _field.gridFitType = GridFitType.PIXEL;
         _field.x = Oplist.PADDING;
         _field.y = Oplist.TB_HEIGHT + Oplist.PADDING;
         _field.mouseWheelEnabled = true;
         _field.addEventListener(MouseEvent.MOUSE_WHEEL,this._onMouseWheel);
         _field.addEventListener(TextEvent.LINK,Ocore.onTextLink);
         addChild(_field);
      }
      
      private function _initDragger() : void
      {
         _dragger = new Sprite();
         var _loc1_:Graphics = _dragger.graphics;
         _loc1_.lineStyle(1,16777215,0.5);
         _loc1_.moveTo(10,0);
         _loc1_.lineTo(0,10);
         _loc1_.moveTo(10,4);
         _loc1_.lineTo(4,10);
         _loc1_.moveTo(10,8);
         _loc1_.lineTo(8,10);
         _loc1_.lineStyle(0,0,0);
         _loc1_.beginFill(0,0);
         _loc1_.drawRect(0,0,12,12);
         _loc1_.endFill();
         _dragger.x = Oplist.DEFAULT_WIDTH - _dragger.width;
         _dragger.y = Oplist.DEFAULT_HEIGHT - _dragger.height;
         _dragger.addEventListener(MouseEvent.MOUSE_DOWN,this._onDraggerDown);
         _dragger.addEventListener(MouseEvent.MOUSE_UP,this._onDraggerUp);
         addChild(_dragger);
      }
      
      private function _onTitleBarDown(param1:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,this._onTitleBarUp);
         _i.startDrag();
      }
      
      private function _onTitleBarUp(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this._onTitleBarUp);
         _i.stopDrag();
         Otils.recordWindowState();
      }
      
      private function _onDraggerDown(param1:MouseEvent) : void
      {
         stage.addEventListener(Event.ENTER_FRAME,this._onDraggerMove);
         stage.addEventListener(MouseEvent.MOUSE_UP,this._onDraggerUp);
      }
      
      private function _onDraggerMove(param1:Event) : void
      {
         var _loc2_:int = stage.mouseX + _dragger.width * 0.5 - x;
         var _loc3_:int = stage.mouseY + _dragger.height * 0.5 - y;
         _resize(_loc2_,_loc3_);
      }
      
      private function _onDraggerUp(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this._onDraggerUp);
         stage.removeEventListener(Event.ENTER_FRAME,this._onDraggerMove);
         Otils.recordWindowState();
      }
      
      private function _initBg() : void
      {
         _bg = new Shape();
         var _loc1_:Graphics = _bg.graphics;
         _loc1_.beginFill(Oplist.BG_COL,Oplist.BG_ALPHA);
         _loc1_.drawRect(0,0,Oplist.DEFAULT_WIDTH,Oplist.DEFAULT_HEIGHT - Oplist.TB_HEIGHT);
         _loc1_.endFill();
         _bg.y = Oplist.TB_HEIGHT;
         addChild(_bg);
      }
   }
}

