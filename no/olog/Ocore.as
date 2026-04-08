package no.olog
{
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import no.olog.logtargets.*;
   import no.olog.utilfunctions.*;
   
   internal class Ocore
   {
      internal static var originalParent:DisplayObjectContainer;
      
      private static var _stage:Stage;
      
      private static var _versionLoader:URLLoader;
      
      private static var _versions:XML;
      
      private static var _password:String;
      
      private static var _pwPrompt:OpwPrompt;
      
      private static var _stageFocusRestore:InteractiveObject;
      
      private static var _pwPromptOpen:Boolean;
      
      private static var _numLinesPendingWrite:int;
      
      private static var _keyBindings:Dictionary;
      
      private static var _keyReleaseTimeout:uint;
      
      private static var _logTargets:Array;
      
      internal static var alwaysOnTop:Boolean = true;
      
      internal static var scrollOnNewline:Boolean = true;
      
      private static var _lineNumber:int = -1;
      
      private static var _passwordOk:Boolean = true;
      
      private static var _enableCMI:Boolean = true;
      
      private static var _lines:Array = new Array();
      
      private static var _linesFiltered:Array = new Array();
      
      private static var _linesAreFiltered:Boolean = false;
      
      private static var _levelFilter:int = -1;
      
      private static var _lastLine:Oline = new Oline("",0,null,"","",0,"","");
      
      private static var _runTimeMarkers:Array = new Array();
      
      private static var _keySequence:String = "";
      
      public function Ocore()
      {
         super();
      }
      
      internal static function colorTextLevel(param1:String, param2:int) : String
      {
         return "<font color=\"" + Oplist.TEXT_COLORS_HEX[param2] + "\">" + param1 + "</font>";
      }
      
      internal static function parseShorthandFormatting(param1:String) : String
      {
         return param1.replace(/\\\d.+\\/g,"<font color=\"" + Oplist.TEXT_COLORS_HEX[int(param1.charAt(1))] + "\">" + param1.substr(2,param1.length - 1) + "</font>");
      }
      
      internal static function getLogCSS() : StyleSheet
      {
         var _loc1_:uint = Capabilities.os.toLowerCase().indexOf("win") == -1 ? uint(Oplist.SIZE_MAC) : uint(Oplist.SIZE_WIN);
         var _loc2_:Object = {
            "fontFamily":Oplist.FONT,
            "fontSize":_loc1_,
            "leading":Oplist.LEADING
         };
         var _loc3_:Object = {
            "textDecoration":"underline",
            "color":Oplist.TEXT_COLORS_HEX[1]
         };
         var _loc4_:StyleSheet = new StyleSheet();
         _loc4_.setStyle("p",_loc2_);
         _loc4_.setStyle("a",_loc3_);
         return _loc4_;
      }
      
      internal static function getTitleBarCSS() : StyleSheet
      {
         var _loc1_:Object = {
            "fontFamily":Oplist.TB_FONT,
            "fontSize":Oplist.TB_FONT_SIZE,
            "textAlign":Oplist.TB_ALIGN
         };
         var _loc2_:StyleSheet = new StyleSheet();
         _loc2_.setStyle("p",_loc1_);
         return _loc2_;
      }
      
      internal static function getTitleBarText() : String
      {
         var _loc1_:String = colorTextLevel(Oplist.NAME + " " + Oplist.VERSION,1);
         var _loc2_:String = colorTextLevel(" - " + _getCurrentTime(),0);
         return "<p><b>" + _loc1_ + "</b>" + _loc2_ + "</p>";
      }
      
      internal static function onAddedToStage(param1:Event) : void
      {
         Owindow.exists = true;
         originalParent = Owindow.instance.parent;
         _stage = param1.target.stage;
         _stage.addChild(Owindow.instance);
         if(_stage.loaderInfo.hasOwnProperty("uncaughtErrorEvents"))
         {
            _stage.loaderInfo["uncaughtErrorEvents"].addEventListener("uncaughtError",trace);
         }
         _evalKeyboard();
         _evalCMI();
         _initPWPrompt();
         evalAlwaysOnTop();
         enableScrolling();
         Owindow.setDefaultBounds();
         if(_lines.length > 0)
         {
            refreshLog();
         }
      }
      
      private static function _evalKeyboard() : void
      {
         if(Oplist.keyBoardEnabled)
         {
            _stage.addEventListener(KeyboardEvent.KEY_DOWN,_onKeyDown);
         }
         else
         {
            _stage.removeEventListener(KeyboardEvent.KEY_DOWN,_onKeyDown);
         }
      }
      
      internal static function evalAlwaysOnTop() : void
      {
         if(_stage)
         {
            if(Oplist.alwaysOnTop)
            {
               _stage.addEventListener(Event.ADDED,Owindow.moveToTop);
            }
            else
            {
               _stage.removeEventListener(Event.ADDED,Owindow.moveToTop);
            }
         }
      }
      
      internal static function trace(param1:Object, param2:uint = 1, param3:Object = null, param4:Boolean = true, param5:Boolean = false) : void
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc6_:String = Otils.getClassName(param1);
         if(!param5)
         {
            _loc7_ = Otils.parseMsgType(param1);
            _loc8_ = Otils.getClassName(param1,true);
            _loc9_ = int(Otils.parseTypeAndLevel(_loc8_,param2));
            _loc10_ = Boolean(_evalTruncation(_loc7_));
         }
         else
         {
            _loc7_ = String(param1);
            _loc8_ = "String";
            _loc9_ = int(param2);
         }
         var _loc11_:String = Otils.parseOrigin(param3);
         var _loc12_:int = int(_getLineIndex());
         var _loc13_:String = _getCurrentTime();
         var _loc14_:String = _getRunTime();
         var _loc15_:Oline = new Oline(_loc7_,_loc9_,_loc11_,_loc13_,_loc14_,_loc12_,_loc6_,_loc8_,param4,param5);
         _loc15_.isTruncated = _loc10_;
         _loc15_.truncationEnabled = _loc15_.isTruncated;
         _lines[_loc12_] = _loc15_;
         _evalAddOrRepeat(_loc15_);
         _sendToTargets(_loc15_);
      }
      
      private static function _sendToTargets(param1:Oline) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ILogTarget = null;
         var _loc4_:int = 0;
         if(_logTargets)
         {
            _loc2_ = int(_logTargets.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = Ocore._logTargets[_loc4_];
               _loc3_.writeLogLine(param1);
               _loc4_++;
            }
         }
      }
      
      private static function _evalAddOrRepeat(param1:Oline) : void
      {
         if(param1.msg != _lastLine.msg || param1.level != _lastLine.level || !Oplist.stackRepeatedMessages)
         {
            _addLine(param1);
         }
         else
         {
            _incrementLastLineRepeat();
         }
      }
      
      private static function _incrementLastLineRepeat() : void
      {
         ++_lastLine.repeatCount;
         if(Owindow.exists)
         {
            Owindow.replaceLastLine(_getLogTextFromVO(_lastLine));
         }
      }
      
      internal static function traceRuntimeInfo() : void
      {
         var _loc1_:String = "RUNTIME INFORMATION\n";
         var _loc2_:String = !!Capabilities.isDebugger ? "Debugger" : "Standard";
         var _loc3_:* = "Platform: " + Capabilities.os + "\n";
         _loc3_ += "Language: " + Capabilities.language.toUpperCase() + "\n";
         _loc3_ += "HW Manufactorer: " + Capabilities.manufacturer + "\n";
         _loc3_ += "Player: " + Capabilities.version + " (" + Capabilities.playerType + ", " + _loc2_ + ")\n";
         _loc3_ += "Screen: " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + " @ " + Capabilities.screenDPI + " dpi\n";
         if(Owindow.exists)
         {
            _loc3_ += "Stage: " + _stage.stageWidth + "x" + _stage.stageHeight + "\n";
         }
         _loc3_ += "Accessibility aids: " + Capabilities.hasAccessibility + "\n";
         _loc3_ += "AV Hardware Disabled: " + Capabilities.avHardwareDisable + "\n";
         _loc3_ += "Audio: " + Capabilities.hasAudio + "\n";
         _loc3_ += "Audio Encoder: " + Capabilities.hasAudioEncoder + "\n";
         _loc3_ += "MP3 Decoder: " + Capabilities.hasMP3 + "\n";
         _loc3_ += "Video Encoder: " + Capabilities.hasVideoEncoder + "\n";
         _loc3_ += "Embedded Video: " + Capabilities.hasEmbeddedVideo + "\n";
         _loc3_ += "Screen Broadcast: " + Capabilities.hasScreenBroadcast + "\n";
         _loc3_ += "Screen Playback: " + Capabilities.hasScreenPlayback + "\n";
         _loc3_ += "Streaming Audio: " + Capabilities.hasStreamingAudio + "\n";
         _loc3_ += "Streaming Video: " + Capabilities.hasStreamingVideo + "\n";
         _loc3_ += "Native SSL Sockets: " + Capabilities.hasTLS + "\n";
         _loc3_ += "Input Method editor: " + Capabilities.hasIME + "\n";
         _loc3_ += "Local File Read Access: " + Capabilities.localFileReadDisable + "\n";
         _loc3_ += "Printing: " + Capabilities.hasPrinting + "\n";
         trace(_loc1_ + _loc3_,0,null,false);
      }
      
      internal static function describe(param1:Object, param2:int = 1, param3:Object = null, param4:Array = null) : void
      {
         var _loc5_:String = Otils.getDescriptionOf(param1,param4);
         trace(_loc5_,param2,param3,true,true);
      }
      
      internal static function writeHeader(param1:String, param2:uint = 1) : void
      {
         var _loc3_:* = "\n\t" + param1.toUpperCase() + "\n";
         trace(_loc3_,param2,null,false,true);
      }
      
      internal static function writeNewline(param1:int = 1) : void
      {
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += "<br>";
            _loc3_++;
         }
         trace(_loc2_,0,null,false,true);
      }
      
      private static function _addLine(param1:Oline) : void
      {
         _lastLine = param1;
         _filter(param1);
         if(Boolean(Owindow.exists) && Boolean(Owindow.isOpen))
         {
            _writeLine(param1);
         }
         else
         {
            ++_numLinesPendingWrite;
         }
      }
      
      private static function _filter(param1:Oline) : void
      {
         if(!_linesAreFiltered || param1.level == _levelFilter)
         {
            _linesFiltered.push(param1);
         }
      }
      
      internal static function setPassword(param1:String) : void
      {
         if(!param1 || param1 == "")
         {
            _password = null;
            _passwordOk = true;
         }
         else if(param1 != _password)
         {
            _password = param1;
            _passwordOk = false;
         }
      }
      
      internal static function getPassword() : String
      {
         return _password;
      }
      
      internal static function setCMI(param1:Boolean) : void
      {
         _enableCMI = param1;
         _evalCMI();
      }
      
      internal static function get hasCMI() : Boolean
      {
         return _enableCMI;
      }
      
      internal static function evalOpenClose(param1:Event = null) : void
      {
         if(!Owindow.isOpen && Boolean(_passwordOk))
         {
            _openWindow();
         }
         else if(Owindow.isOpen)
         {
            Owindow.close();
         }
         else if(!_pwPromptOpen && !_passwordOk)
         {
            _openPWPrompt();
         }
      }
      
      private static function _openWindow() : void
      {
         Owindow.open();
         _writePendingLines();
      }
      
      private static function _writePendingLines() : void
      {
         var _loc3_:Oline = null;
         var _loc1_:int = int(_lines.length);
         var _loc2_:int = _lines.length - _numLinesPendingWrite;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _lines[_loc2_];
            if(!_linesAreFiltered || _loc3_.level == _levelFilter)
            {
               _writeLine(_loc3_);
            }
            _loc2_++;
         }
      }
      
      internal static function validatePassword(param1:Event) : void
      {
         if(param1.target.text == _password)
         {
            _passwordOk = true;
            _closePWPrompt();
            Owindow.open();
            _writePendingLines();
         }
      }
      
      internal static function disableScrolling() : void
      {
         if(Owindow.exists)
         {
            _stage.removeEventListener(KeyboardEvent.KEY_DOWN,_scroll);
         }
      }
      
      internal static function enableScrolling() : void
      {
         if(Owindow.exists)
         {
            _stage.addEventListener(KeyboardEvent.KEY_DOWN,_scroll);
         }
      }
      
      private static function _scroll(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.DOWN)
         {
            Owindow.scrollDown();
         }
         else if(param1.keyCode == Keyboard.UP)
         {
            Owindow.scrollUp();
         }
         else if(param1.keyCode == Keyboard.HOME)
         {
            Owindow.scrollHome();
         }
         else if(param1.keyCode == Keyboard.END)
         {
            Owindow.scrollEnd();
         }
         Owindow.instance.addEventListener(MouseEvent.MOUSE_OVER,Owindow.onMouseOver);
      }
      
      internal static function refreshLog() : void
      {
         Owindow.clear();
         var _loc1_:int = int(_linesFiltered.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _writeLine(_linesFiltered[_loc2_]);
            _loc2_++;
         }
      }
      
      private static function _initPWPrompt() : void
      {
         _pwPrompt = new OpwPrompt();
      }
      
      private static function _closePWPrompt() : void
      {
         _stage.removeChild(_pwPrompt);
         _stage.focus = _stageFocusRestore;
         _pwPromptOpen = false;
      }
      
      private static function _openPWPrompt() : void
      {
         _stageFocusRestore = _stage.focus;
         _pwPrompt.x = (_stage.stageWidth - Ocore._pwPrompt.width) * 0.5;
         _pwPrompt.y = (_stage.stageHeight - Ocore._pwPrompt.height) * 0.5;
         _stage.addChild(_pwPrompt);
         _stage.focus = _pwPrompt.field;
         _pwPromptOpen = true;
      }
      
      private static function _evalCMI() : void
      {
         if(Boolean(Owindow.exists) && Capabilities.playerType != "Desktop")
         {
            if(_enableCMI)
            {
               Owindow.createCMI();
            }
            else
            {
               Owindow.removeCMI();
            }
         }
      }
      
      internal static function checkForUpdates() : void
      {
         _versionLoader = new URLLoader();
         _versionLoader.addEventListener(Event.COMPLETE,_onVersionHistoryResult);
         _versionLoader.addEventListener(IOErrorEvent.IO_ERROR,_onVersionHistoryResult);
         _versionLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_onVersionHistoryResult);
         try
         {
            _versionLoader.load(new URLRequest(Oplist.VERSION_CHECK_URL));
         }
         catch(e:Error)
         {
            trace("Check for updates not allowed by sandbox",3,"Olog");
         }
      }
      
      private static function _onVersionHistoryResult(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1.type == Event.COMPLETE)
         {
            _versions = new XML(param1.target.data);
            _loc2_ = _versions.version[0].@id;
            if(_loc2_ != Oplist.VERSION)
            {
               _loc3_ = Oplist.NEW_VERSION_MSG.replace("@version",_loc2_);
               trace("<p><a href=\"event:" + Oplist.EVENT_VERSION_DETAILS + "\">" + _loc3_ + "</a></p>",4,null,true,true);
               Otils.recordVersionCheckTime();
            }
            else
            {
               trace("You are using the current version of Olog",4);
            }
         }
      }
      
      internal static function onTextLink(param1:TextEvent) : void
      {
         var _loc2_:Array = param1.text.split("@");
         var _loc3_:String = _loc2_[0];
         switch(_loc3_)
         {
            case Oplist.EVENT_OPEN_TRUNCATED:
            case Oplist.EVENT_CLOSE_TRUNCATED:
               _toggleTruncation(int(_loc2_[1]));
               break;
            case Oplist.EVENT_VERSION_DETAILS:
               _traceVersionDetails();
               break;
            default:
               throw new Error("switch case unsupported");
         }
      }
      
      private static function _toggleTruncation(param1:int) : void
      {
         var _loc2_:Oline = _lines[param1] as Oline;
         _loc2_.truncationEnabled = !_loc2_.truncationEnabled;
         refreshLog();
      }
      
      private static function _traceVersionDetails() : void
      {
         var _loc2_:XML = null;
         var _loc3_:XML = null;
         var _loc1_:* = "<br><p>Version " + _versions.version[0].@id + " contains the following changes:</p>";
         if(_versions.version[0].hasOwnProperty("features"))
         {
            _loc1_ += "<br><p><b>" + Oplist.FEATURES + "</b></p>";
            for each(_loc2_ in _versions.version[0].features.feature)
            {
               _loc1_ += "<li>" + _loc2_ + "</li>";
            }
         }
         if(_versions.version[0].hasOwnProperty("fixes"))
         {
            _loc1_ += "<br><p><b>" + Oplist.FIXES + "</b></p>";
            for each(_loc3_ in _versions.version[0].fixes.fix)
            {
               _loc1_ += "<li>" + _loc3_ + "</li>";
            }
         }
         if(_versions.version[0].hasOwnProperty("notes"))
         {
            _loc1_ += "<br><p><b>" + Oplist.NOTES + "</b></p>";
            _loc1_ += "<p>" + _versions.version[0].notes.text() + "</p>";
         }
         _loc1_ += "<br><p><a href=\"" + Oplist.DL_LINK + "\">" + Oplist.DL_LABEL + "</a></p><br>";
         trace(colorTextLevel(_loc1_,1),1,null,false,true);
      }
      
      private static function _onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:int = int(_charCodeAsLevel(param1.charCode,param1.keyCode));
         if(param1.shiftKey && param1.keyCode == Keyboard.ENTER)
         {
            evalOpenClose();
         }
         else if(Boolean(_pwPromptOpen) && param1.keyCode == Keyboard.ESCAPE)
         {
            _closePWPrompt();
         }
         else if(Boolean(Owindow.hasFocus()) && _loc2_ > -1)
         {
            _levelFilter = _loc2_;
            _filterLines();
            refreshLog();
         }
         else if(Boolean(Owindow.hasFocus()) && Boolean(_linesAreFiltered) && param1.keyCode == Keyboard.ESCAPE)
         {
            _levelFilter = -1;
            _filterLines();
            refreshLog();
         }
         else if(_keyBindings)
         {
            _evalKeyBinding(param1.charCode);
         }
      }
      
      private static function _evalKeyBinding(param1:uint) : void
      {
         clearTimeout(_keyReleaseTimeout);
         _keySequence += String.fromCharCode(param1);
         if(_keyBindings.hasOwnProperty(_keySequence))
         {
            trace("Key binding \"" + _keySequence + "\" recognized",5,"Olog");
            _keyBindings[_keySequence]();
            _releaseKeySequence();
         }
         else
         {
            _keyReleaseTimeout = setTimeout(_releaseKeySequence,500);
         }
      }
      
      private static function _releaseKeySequence() : void
      {
         _keySequence = "";
      }
      
      private static function _charCodeAsLevel(param1:int, param2:int) : int
      {
         var _loc3_:int = int(parseInt(String.fromCharCode(param1)));
         if(!isNaN(_loc3_) && 48 <= param2 && param2 <= 53)
         {
            return _loc3_;
         }
         return -1;
      }
      
      private static function _filterLines() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _linesFiltered = new Array();
         if(_levelFilter == -1)
         {
            _linesFiltered = _lines;
            _linesAreFiltered = false;
         }
         else
         {
            _linesAreFiltered = true;
            _loc1_ = int(_lines.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(_lines[_loc2_].level == _levelFilter)
               {
                  _linesFiltered.push(_lines[_loc2_]);
               }
               _loc2_++;
            }
         }
      }
      
      private static function _writeLine(param1:Oline) : void
      {
         Owindow.write(_getLogTextFromVO(param1));
      }
      
      private static function _getLogTextFromVO(param1:Oline) : String
      {
         var _loc2_:String = null;
         if(!param1.isTruncated)
         {
            _loc2_ = param1.msg;
         }
         else
         {
            _loc2_ = param1.truncationEnabled ? _getTruncated(param1.msg,param1.index) : _getUntruncated(param1.msg,param1.index);
         }
         var _loc3_:String = param1.useLineStart ? colorTextLevel(Otils.getLineStart(param1.index,param1.timestamp,param1.runtime),0) : "";
         var _loc4_:String = param1.repeatCount == 1 ? "" : colorTextLevel(" (" + param1.repeatCount + ")",1);
         if(Oplist.colorizeColorStrings)
         {
            _loc2_ = _expandColorStrings(_loc2_);
         }
         var _loc5_:String = colorTextLevel(_loc2_,param1.level);
         var _loc6_:String = _getOrigin(param1.origin);
         return _loc3_ + _loc5_ + _loc4_ + _loc6_;
      }
      
      private static function _expandColorStrings(param1:String) : String
      {
         var wrapColor:* = undefined;
         var rawText:String = param1;
         wrapColor = function():String
         {
            return "<font color=\"#" + arguments[0].substr(2) + "\">" + arguments[0] + "</font>";
         };
         return rawText.replace(/0x[0-9abcdef]{6}/gi,wrapColor);
      }
      
      private static function _evalTruncation(param1:String) : Boolean
      {
         var _loc2_:Boolean = Oplist.maxUntruncatedLength > 0 && param1.length > Oplist.maxUntruncatedLength;
         var _loc3_:Boolean = Boolean(Oplist.truncateMultiline) && param1.indexOf("\n") != -1;
         return _loc2_ || _loc3_;
      }
      
      private static function _getTruncated(param1:String, param2:int) : String
      {
         if(Oplist.truncateMultiline)
         {
            param1 = param1.substr(0,param1.indexOf("\n")) + " [+] ";
         }
         if(Oplist.maxUntruncatedLength > -1)
         {
            param1 = param1.substr(0,Oplist.maxUntruncatedLength - 3) + "... ";
         }
         return param1 + "<a href=\"event:" + Oplist.EVENT_OPEN_TRUNCATED + "@" + param2 + "\">" + Oplist.OPEN_TRUNCATED_LABEL + "</a>";
      }
      
      private static function _getUntruncated(param1:String, param2:int) : String
      {
         return param1 + " <a href=\"event:" + Oplist.EVENT_OPEN_TRUNCATED + "@" + param2 + "\">" + Oplist.CLOSE_TRUNCATED_LABEL + "</a>";
      }
      
      private static function _getOrigin(param1:String) : String
      {
         return !!param1 ? colorTextLevel(Oplist.ORIGIN_DELIMITER + param1,0) : "";
      }
      
      private static function _getCurrentTime() : String
      {
         return new Date().toTimeString().substr(0,8);
      }
      
      private static function _getRunTime() : String
      {
         return Otils.formatTime(getTimer());
      }
      
      private static function _getLineIndex() : int
      {
         return ++_lineNumber;
      }
      
      internal static function newTimeMarker(param1:String = null, param2:Object = null, param3:uint = 0) : int
      {
         var _loc4_:String = !!param1 ? param1 : "Operation";
         var _loc5_:String = Otils.parseOrigin(param2);
         var _loc6_:int = int(getTimer());
         return _runTimeMarkers.push([_loc4_,_loc6_,_loc5_,param3]) - 1;
      }
      
      internal static function completeTimeMarker(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:* = false;
         var _loc8_:String = null;
         var _loc2_:Array = _runTimeMarkers[param1];
         if(_loc2_)
         {
            _loc3_ = getTimer() - _loc2_[1];
            _loc4_ = uint(_loc2_[3]);
            _loc5_ = Otils.formatTime(_loc3_);
            _loc6_ = uint(Oplist.MARKER_COLOR_INDEX);
            if(_loc4_ > 0)
            {
               _loc7_ = _loc3_ > _loc4_;
               _loc8_ = Otils.formatTime(Math.abs(_loc3_ - _loc2_[3]));
               _loc6_ = !_loc7_ ? 4 : 2;
               _loc5_ += " (" + _loc8_ + (_loc7_ ? " above allowed)" : " below allowed)");
            }
            trace(_loc2_[0] + " completed in " + _loc5_,_loc6_,_loc2_[2],true,true);
         }
         else
         {
            trace("Invalid time marker ID \"" + param1 + "\"",3,"Olog");
         }
      }
      
      internal static function saveLogAsXML(param1:MouseEvent = null) : void
      {
         var _loc8_:Oline = null;
         var _loc9_:XML = null;
         var _loc2_:Date = new Date();
         var _loc3_:String = _loc2_.getDate() + "" + _loc2_.getMonth() + "" + _loc2_.getFullYear();
         var _loc4_:String = _loc2_.toTimeString().substr(0,8).replace(/:/g,"");
         var _loc5_:XML = <olog_output></olog_output>;
         _loc5_.@date = _loc3_;
         _loc5_.@time = _loc4_;
         var _loc6_:int = int(_lines.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _lines[_loc7_];
            _loc9_ = <line>{_loc8_.msg}</line>;
            _loc9_.@timeStamp = _loc8_.timestamp;
            _loc9_.@runTime = _loc8_.runtime;
            _loc9_.@level = _loc8_.level;
            _loc9_.@originatingClass = _loc8_.origin;
            _loc9_.@dataType = _loc8_.type;
            _loc9_.@treatedAs = _loc8_.supportedType;
            _loc9_.@repeatCount = _loc8_.repeatCount;
            _loc5_.appendChild(_loc9_);
            _loc7_++;
         }
         _save(_loc5_);
      }
      
      internal static function saveLogAsText(param1:MouseEvent = null) : void
      {
         _save(Owindow.getLogText());
      }
      
      private static function _save(param1:*) : void
      {
         var contents:* = param1;
         var d:Date = new Date();
         var ds:String = d.getDate() + "" + d.getMonth() + "" + d.getFullYear();
         var ts:String = d.toTimeString().substr(0,8).replace(/:/g,"");
         var suff:String = contents is XML ? ".xml" : ".txt";
         var fr:FileReference = new FileReference();
         try
         {
            fr["save"](contents,Oplist.XML_OUTPUT_FILENAME + "_" + ds + "_" + ts + suff);
         }
         catch(e:Error)
         {
            trace("Save operation requires FlashPlayer 10",3,"Olog");
         }
      }
      
      internal static function setKeyboardEnabled(param1:Boolean) : void
      {
         Oplist.keyBoardEnabled = param1;
         _evalKeyboard();
      }
      
      internal static function getLastLineLevel() : int
      {
         return _lastLine.level;
      }
      
      internal static function addKeyBinding(param1:String, param2:Function) : void
      {
         if(!_keyBindings)
         {
            _keyBindings = new Dictionary(true);
         }
         if(_keyBindings[param1] != null)
         {
            Ocore.trace("Key binding \"" + param1 + "\" overwrite at " + getCallee(4),2,"Olog");
         }
         _keyBindings[param1] = param2;
      }
      
      internal static function forceExpandedArrayTrace(param1:Array, param2:int = 1) : void
      {
         var _loc3_:Boolean = Boolean(Oplist.expandArrayItems);
         Oplist.expandArrayItems = true;
         Ocore.trace(param1,param2);
         Oplist.expandArrayItems = _loc3_;
      }
      
      internal static function activateLogTargets(param1:Array) : void
      {
         var target:Object = null;
         var i:int = 0;
         var targets:Array = param1;
         var num:int = int(targets.length);
         i = 0;
         for(; i < num; i++)
         {
            if(targets[i] is Class)
            {
               try
               {
                  target = new targets[i]();
               }
               catch(e:Error)
               {
                  trace("Error activating log target: " + targets[i] + " constructor failed",3,"Olog");
                  continue;
               }
            }
            if(target is ILogTarget)
            {
               if(!_logTargets)
               {
                  _logTargets = [];
               }
               _logTargets.push(target);
            }
            else
            {
               trace("Error activating log target: " + targets[i] + " does not implement ILogTarget",3,"Olog");
            }
            target = null;
         }
      }
   }
}

