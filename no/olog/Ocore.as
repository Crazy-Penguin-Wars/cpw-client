package no.olog
{
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.text.StyleSheet;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import no.olog.logtargets.ILogTarget;
   import no.olog.utilfunctions.getCallee;
   
   internal class Ocore
   {
      
      internal static var alwaysOnTop:Boolean = true;
      
      internal static var scrollOnNewline:Boolean = true;
      
      internal static var originalParent:DisplayObjectContainer;
      
      private static var _stage:Stage;
      
      private static var _lineNumber:int = -1;
      
      private static var _versionLoader:URLLoader;
      
      private static var _versions:XML;
      
      private static var _password:String;
      
      private static var _passwordOk:Boolean = true;
      
      private static var _enableCMI:Boolean = true;
      
      private static var _pwPrompt:OpwPrompt;
      
      private static var _stageFocusRestore:InteractiveObject;
      
      private static var _pwPromptOpen:Boolean;
      
      private static var _lines:Array = [];
      
      private static var _linesFiltered:Array = [];
      
      private static var _linesAreFiltered:Boolean = false;
      
      private static var _levelFilter:int = -1;
      
      private static var _lastLine:Oline = new Oline("",0,null,"","",0,"","");
      
      private static var _runTimeMarkers:Array = [];
      
      private static var _numLinesPendingWrite:int;
      
      private static var _keyBindings:Dictionary;
      
      private static var _keyReleaseTimeout:uint;
      
      private static var _keySequence:String = "";
      
      private static var _logTargets:Array;
       
      
      public function Ocore()
      {
         super();
      }
      
      internal static function colorTextLevel(text:String, level:int) : String
      {
         return "<font color=\"" + Oplist.TEXT_COLORS_HEX[level] + "\">" + text + "</font>";
      }
      
      internal static function parseShorthandFormatting(text:String) : String
      {
         return text.replace(/\\\d.+\\/g,"<font color=\"" + Oplist.TEXT_COLORS_HEX[int(text.charAt(1))] + "\">" + text.substr(2,text.length - 1) + "</font>");
      }
      
      internal static function getLogCSS() : StyleSheet
      {
         var size:uint = Capabilities.os.toLowerCase().indexOf("win") == -1 ? 10 : 11;
         var p:Object = {
            "fontFamily":"_typewriter",
            "fontSize":size,
            "leading":1
         };
         var a:Object = {
            "textDecoration":"underline",
            "color":Oplist.TEXT_COLORS_HEX[1]
         };
         var css:StyleSheet = new StyleSheet();
         css.setStyle("p",p);
         css.setStyle("a",a);
         return css;
      }
      
      internal static function getTitleBarCSS() : StyleSheet
      {
         var p:Object = {
            "fontFamily":"_sans",
            "fontSize":10,
            "textAlign":"center"
         };
         var css:StyleSheet = new StyleSheet();
         css.setStyle("p",p);
         return css;
      }
      
      internal static function getTitleBarText() : String
      {
         var nameVersion:String = colorTextLevel("Olog 1.3.0",1);
         var initTime:String = colorTextLevel(" - " + _getCurrentTime(),0);
         return "<p><b>" + nameVersion + "</b>" + initTime + "</p>";
      }
      
      internal static function onAddedToStage(e:Event) : void
      {
         Owindow.exists = true;
         var _loc2_:Owindow = Owindow;
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         originalParent = no.olog.Owindow._i.parent;
         _stage = e.target.stage;
         var _loc3_:Owindow = Owindow;
         §§push(_stage);
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         §§pop().addChild(no.olog.Owindow._i);
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
            _stage.addEventListener("keyDown",_onKeyDown);
         }
         else
         {
            _stage.removeEventListener("keyDown",_onKeyDown);
         }
      }
      
      internal static function evalAlwaysOnTop() : void
      {
         if(_stage)
         {
            if(Oplist.alwaysOnTop)
            {
               _stage.addEventListener("added",Owindow.moveToTop);
            }
            else
            {
               _stage.removeEventListener("added",Owindow.moveToTop);
            }
         }
      }
      
      internal static function trace(message:Object, level:uint = 1, origin:Object = null, useLineStart:Boolean = true, bypassValidation:Boolean = false) : void
      {
         var m:* = null;
         var s:* = null;
         var l:int = 0;
         var isTruncated:Boolean = false;
         var c:String = Otils.getClassName(message);
         if(!bypassValidation)
         {
            m = Otils.parseMsgType(message);
            s = Otils.getClassName(message,true);
            l = Otils.parseTypeAndLevel(s,level);
            isTruncated = _evalTruncation(m);
         }
         else
         {
            m = String(message);
            s = "String";
            l = level;
         }
         var o:String = Otils.parseOrigin(origin);
         var i:int = _getLineIndex();
         var t:String = _getCurrentTime();
         var r:String = _getRunTime();
         var line:Oline = new Oline(m,l,o,t,r,i,c,s,useLineStart,bypassValidation);
         line.isTruncated = isTruncated;
         line.truncationEnabled = line.isTruncated;
         _lines[i] = line;
         _evalAddOrRepeat(line);
         _sendToTargets(line);
      }
      
      private static function _sendToTargets(line:Oline) : void
      {
         var target:* = null;
         var num:int = 0;
         var i:int = 0;
         if(_logTargets)
         {
            num = _logTargets.length;
            for(i = 0; i < num; )
            {
               target = Ocore._logTargets[i];
               target.writeLogLine(line);
               i++;
            }
         }
      }
      
      private static function _evalAddOrRepeat(line:Oline) : void
      {
         if(line.msg != _lastLine.msg || line.level != _lastLine.level || !Oplist.stackRepeatedMessages)
         {
            _addLine(line);
         }
         else
         {
            _incrementLastLineRepeat();
         }
      }
      
      private static function _incrementLastLineRepeat() : void
      {
         _lastLine.repeatCount++;
         if(Owindow.exists)
         {
            Owindow.replaceLastLine(_getLogTextFromVO(_lastLine));
         }
      }
      
      internal static function traceRuntimeInfo() : void
      {
         var type:String = Capabilities.isDebugger ? "Debugger" : "Standard";
         var msg:String = "Platform: " + Capabilities.os + "\n";
         msg += "Language: " + Capabilities.language.toUpperCase() + "\n";
         msg += "HW Manufactorer: " + Capabilities.manufacturer + "\n";
         msg += "Player: " + Capabilities.version + " (" + Capabilities.playerType + ", " + type + ")\n";
         msg += "Screen: " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + " @ " + Capabilities.screenDPI + " dpi\n";
         if(Owindow.exists)
         {
            msg += "Stage: " + _stage.stageWidth + "x" + _stage.stageHeight + "\n";
         }
         msg += "Accessibility aids: " + Capabilities.hasAccessibility + "\n";
         msg += "AV Hardware Disabled: " + Capabilities.avHardwareDisable + "\n";
         msg += "Audio: " + Capabilities.hasAudio + "\n";
         msg += "Audio Encoder: " + Capabilities.hasAudioEncoder + "\n";
         msg += "MP3 Decoder: " + Capabilities.hasMP3 + "\n";
         msg += "Video Encoder: " + Capabilities.hasVideoEncoder + "\n";
         msg += "Embedded Video: " + Capabilities.hasEmbeddedVideo + "\n";
         msg += "Screen Broadcast: " + Capabilities.hasScreenBroadcast + "\n";
         msg += "Screen Playback: " + Capabilities.hasScreenPlayback + "\n";
         msg += "Streaming Audio: " + Capabilities.hasStreamingAudio + "\n";
         msg += "Streaming Video: " + Capabilities.hasStreamingVideo + "\n";
         msg += "Native SSL Sockets: " + Capabilities.hasTLS + "\n";
         msg += "Input Method editor: " + Capabilities.hasIME + "\n";
         msg += "Local File Read Access: " + Capabilities.localFileReadDisable + "\n";
         msg += "Printing: " + Capabilities.hasPrinting + "\n";
         trace("RUNTIME INFORMATION\n" + msg,0,null,false);
      }
      
      internal static function describe(message:Object, level:int = 1, origin:Object = null, limitProperties:Array = null) : void
      {
         var m:String = Otils.getDescriptionOf(message,limitProperties);
         trace(m,level,origin,true,true);
      }
      
      internal static function writeHeader(message:String, level:uint = 1) : void
      {
         var m:String = "\n\t" + message.toUpperCase() + "\n";
         trace(m,level,null,false,true);
      }
      
      internal static function writeNewline(numLines:int = 1) : void
      {
         var i:int = 0;
         var m:String = "";
         for(i = 0; i < numLines; )
         {
            m += "<br>";
            i++;
         }
         trace(m,0,null,false,true);
      }
      
      private static function _addLine(line:Oline) : void
      {
         _lastLine = line;
         _filter(line);
         if(Owindow.exists && (!!no.olog.Owindow._i ? no.olog.Owindow._i.visible : false))
         {
            _writeLine(line);
         }
         else
         {
            _numLinesPendingWrite++;
         }
      }
      
      private static function _filter(line:Oline) : void
      {
         if(!_linesAreFiltered || line.level == _levelFilter)
         {
            _linesFiltered.push(line);
         }
      }
      
      internal static function setPassword(val:String) : void
      {
         if(!val || val == "")
         {
            _password = null;
            _passwordOk = true;
         }
         else if(val != _password)
         {
            _password = val;
            _passwordOk = false;
         }
      }
      
      internal static function getPassword() : String
      {
         return _password;
      }
      
      internal static function setCMI(val:Boolean) : void
      {
         _enableCMI = val;
         _evalCMI();
      }
      
      internal static function get hasCMI() : Boolean
      {
         return _enableCMI;
      }
      
      internal static function evalOpenClose(e:Event = null) : void
      {
         var _loc2_:Owindow = Owindow;
         if(_passwordOk)
         {
            _openWindow();
         }
         else
         {
            var _loc3_:Owindow = Owindow;
            if(!!no.olog.Owindow._i ? no.olog.Owindow._i.visible : false)
            {
               Owindow.close();
            }
            else if(!_pwPromptOpen && !_passwordOk)
            {
               _openPWPrompt();
            }
         }
      }
      
      private static function _openWindow() : void
      {
         Owindow.open();
         _writePendingLines();
      }
      
      private static function _writePendingLines() : void
      {
         var i:int = 0;
         var line:* = null;
         var num:int = _lines.length;
         for(i = _lines.length - _numLinesPendingWrite; i < num; )
         {
            line = _lines[i];
            if(!_linesAreFiltered || line.level == _levelFilter)
            {
               _writeLine(line);
            }
            i++;
         }
      }
      
      internal static function validatePassword(e:Event) : void
      {
         if(e.target.text == _password)
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
            _stage.removeEventListener("keyDown",_scroll);
         }
      }
      
      internal static function enableScrolling() : void
      {
         if(Owindow.exists)
         {
            _stage.addEventListener("keyDown",_scroll);
         }
      }
      
      private static function _scroll(e:KeyboardEvent) : void
      {
         if(e.keyCode == 40)
         {
            Owindow.scrollDown();
         }
         else if(e.keyCode == 38)
         {
            Owindow.scrollUp();
         }
         else if(e.keyCode == 36)
         {
            Owindow.scrollHome();
         }
         else if(e.keyCode == 35)
         {
            Owindow.scrollEnd();
         }
         var _loc2_:Owindow = Owindow;
         if(!no.olog.Owindow._i)
         {
            no.olog.Owindow._i = new no.olog.Owindow();
         }
         no.olog.Owindow._i.addEventListener("mouseOver",Owindow.onMouseOver);
      }
      
      internal static function refreshLog() : void
      {
         var i:int = 0;
         Owindow.clear();
         var num:int = _linesFiltered.length;
         for(i = 0; i < num; )
         {
            _writeLine(_linesFiltered[i]);
            i++;
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
         _pwPrompt.x = (_stage.stageWidth - Number(Ocore._pwPrompt.width)) * 0.5;
         _pwPrompt.y = (_stage.stageHeight - Number(Ocore._pwPrompt.height)) * 0.5;
         _stage.addChild(_pwPrompt);
         _stage.focus = _pwPrompt.field;
         _pwPromptOpen = true;
      }
      
      private static function _evalCMI() : void
      {
         if(Owindow.exists && Capabilities.playerType != "Desktop")
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
         _versionLoader.addEventListener("complete",_onVersionHistoryResult);
         _versionLoader.addEventListener("ioError",_onVersionHistoryResult);
         _versionLoader.addEventListener("securityError",_onVersionHistoryResult);
         try
         {
            _versionLoader.load(new URLRequest("http://www.oyvindnordhagen.com/olog/OlogVersionHistory.xml"));
         }
         catch(e:Error)
         {
            trace("Check for updates not allowed by sandbox",3,"Olog");
         }
      }
      
      private static function _onVersionHistoryResult(e:Event) : void
      {
         var newestVersion:* = null;
         var str:* = null;
         if(e.type == "complete")
         {
            _versions = new XML(e.target.data);
            newestVersion = _versions.version[0].@id;
            if(newestVersion != "1.3.0")
            {
               str = "Olog version @version available!".replace("@version",newestVersion);
               trace("<p><a href=\"event:eventVersionDetails\">" + str + "</a></p>",4,null,true,true);
               Otils.recordVersionCheckTime();
            }
            else
            {
               trace("You are using the current version of Olog",4);
            }
         }
      }
      
      internal static function onTextLink(e:TextEvent) : void
      {
         var linkParts:Array = e.text.split("@");
         var event:String = linkParts[0];
         switch(event)
         {
            case "openTruncated":
            case "closeTruncated":
               _toggleTruncation(int(linkParts[1]));
               break;
            case "eventVersionDetails":
               _traceVersionDetails();
               break;
            default:
               throw new Error("switch case unsupported");
         }
      }
      
      private static function _toggleTruncation(i:int) : void
      {
         var line:Oline = _lines[i] as Oline;
         line.truncationEnabled = !line.truncationEnabled;
         refreshLog();
      }
      
      private static function _traceVersionDetails() : void
      {
         var str:String = "<br><p>Version " + _versions.version[0].@id + " contains the following changes:</p>";
         if(_versions.version[0].hasOwnProperty("features"))
         {
            str += "<br><p><b>New features:</b></p>";
            for each(var feature in _versions.version[0].features.feature)
            {
               str += "<li>" + feature + "</li>";
            }
         }
         if(_versions.version[0].hasOwnProperty("fixes"))
         {
            str += "<br><p><b>Bug fixes:</b></p>";
            for each(var fix in _versions.version[0].fixes.fix)
            {
               str += "<li>" + fix + "</li>";
            }
         }
         if(_versions.version[0].hasOwnProperty("notes"))
         {
            str += "<br><p><b>Notes:</b></p>";
            str += "<p>" + _versions.version[0].notes.text() + "</p>";
         }
         str += "<br><p><a href=\"http://www.oyvindnordhagen.com/blog/olog/\">Download here!</a></p><br>";
         trace(colorTextLevel(str,1),1,null,false,true);
      }
      
      private static function _onKeyDown(e:KeyboardEvent) : void
      {
         var levelKey:int = _charCodeAsLevel(e.charCode,e.keyCode);
         if(e.shiftKey && e.keyCode == 13)
         {
            evalOpenClose();
         }
         else if(_pwPromptOpen && e.keyCode == 27)
         {
            _closePWPrompt();
         }
         else if(Owindow.hasFocus() && levelKey > -1)
         {
            _levelFilter = levelKey;
            _filterLines();
            refreshLog();
         }
         else if(Owindow.hasFocus() && _linesAreFiltered && e.keyCode == 27)
         {
            _levelFilter = -1;
            _filterLines();
            refreshLog();
         }
         else if(_keyBindings)
         {
            _evalKeyBinding(e.charCode);
         }
      }
      
      private static function _evalKeyBinding(charCode:uint) : void
      {
         clearTimeout(_keyReleaseTimeout);
         _keySequence += String.fromCharCode(charCode);
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
      
      private static function _charCodeAsLevel(charCode:int, keyCode:int) : int
      {
         var numberKey:int = parseInt(String.fromCharCode(charCode));
         if(!isNaN(numberKey) && 48 <= keyCode && keyCode <= 53)
         {
            return numberKey;
         }
         return -1;
      }
      
      private static function _filterLines() : void
      {
         var num:int = 0;
         var i:int = 0;
         _linesFiltered = [];
         if(_levelFilter == -1)
         {
            _linesFiltered = _lines;
            _linesAreFiltered = false;
         }
         else
         {
            _linesAreFiltered = true;
            num = _lines.length;
            for(i = 0; i < num; )
            {
               if(_lines[i].level == _levelFilter)
               {
                  _linesFiltered.push(_lines[i]);
               }
               i++;
            }
         }
      }
      
      private static function _writeLine(oline:Oline) : void
      {
         Owindow.write(_getLogTextFromVO(oline));
      }
      
      private static function _getLogTextFromVO(oline:Oline) : String
      {
         var rawText:* = null;
         if(!oline.isTruncated)
         {
            rawText = oline.msg;
         }
         else
         {
            rawText = oline.truncationEnabled ? _getTruncated(oline.msg,oline.index) : _getUntruncated(oline.msg,oline.index);
         }
         var lStart:String = oline.useLineStart ? colorTextLevel(Otils.getLineStart(oline.index,oline.timestamp,oline.runtime),0) : "";
         var repeatCount:String = oline.repeatCount == 1 ? "" : colorTextLevel(" (" + oline.repeatCount + ")",1);
         if(Oplist.colorizeColorStrings)
         {
            rawText = _expandColorStrings(rawText);
         }
         var msg:String = colorTextLevel(rawText,oline.level);
         var origin:String = _getOrigin(oline.origin);
         return lStart + msg + repeatCount + origin;
      }
      
      private static function _expandColorStrings(rawText:String) : String
      {
         var wrapColor:* = function():String
         {
            return "<font color=\"#" + arguments[0].substr(2) + "\">" + arguments[0] + "</font>";
         };
         return rawText.replace(/0x[0-9abcdef]{6}/gi,wrapColor);
      }
      
      private static function _evalTruncation(msg:String) : Boolean
      {
         var truncateChars:Boolean = Oplist.maxUntruncatedLength > 0 && msg.length > Oplist.maxUntruncatedLength;
         var truncateLines:Boolean = Oplist.truncateMultiline && msg.indexOf("\n") != -1;
         return truncateChars || truncateLines;
      }
      
      private static function _getTruncated(msg:String, index:int) : String
      {
         if(Oplist.truncateMultiline)
         {
            msg = msg.substr(0,msg.indexOf("\n")) + " [+] ";
         }
         if(Oplist.maxUntruncatedLength > -1)
         {
            msg = msg.substr(0,Oplist.maxUntruncatedLength - 3) + "... ";
         }
         return msg + "<a href=\"event:" + "openTruncated" + "@" + index + "\">" + "Show »" + "</a>";
      }
      
      private static function _getUntruncated(msg:String, index:int) : String
      {
         return msg + " <a href=\"event:" + "openTruncated" + "@" + index + "\">" + "« Hide" + "</a>";
      }
      
      private static function _getOrigin(origin:String) : String
      {
         return !!origin ? colorTextLevel(" › " + origin,0) : "";
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
      
      internal static function newTimeMarker(name:String = null, origin:Object = null, maxDuraion:uint = 0) : int
      {
         var n:String = !!name ? name : "Operation";
         var o:String = Otils.parseOrigin(origin);
         var t:int = getTimer();
         return _runTimeMarkers.push([n,t,o,maxDuraion]) - 1;
      }
      
      internal static function completeTimeMarker(id:int) : void
      {
         var markerDuration:int = 0;
         var markerMaxDuration:* = 0;
         var durationString:* = null;
         var level:* = 0;
         var overTime:Boolean = false;
         var overTimeString:* = null;
         var marker:Array = _runTimeMarkers[id];
         if(marker)
         {
            markerDuration = getTimer() - Number(marker[1]);
            markerMaxDuration = uint(marker[3]);
            durationString = Otils.formatTime(markerDuration);
            level = 9;
            if(markerMaxDuration > 0)
            {
               overTime = markerDuration > markerMaxDuration;
               overTimeString = Otils.formatTime(Math.abs(markerDuration - Number(marker[3])));
               level = !overTime ? 4 : 2;
               durationString += " (" + overTimeString + (overTime ? " above allowed)" : " below allowed)");
            }
            trace(marker[0] + " completed in " + durationString,level,marker[2],true,true);
         }
         else
         {
            trace("Invalid time marker ID \"" + id + "\"",3,"Olog");
         }
      }
      
      internal static function saveLogAsXML(e:MouseEvent = null) : void
      {
         var i:int = 0;
         var line:* = null;
         var node:* = null;
         var d:Date = new Date();
         var ds:String = d.getDate() + "" + d.getMonth() + "" + d.getFullYear();
         var ts:String = d.toTimeString().substr(0,8).replace(/:/g,"");
         var xml:XML = <olog_output></olog_output>;
         xml.@date = ds;
         xml.@time = ts;
         var num:int = _lines.length;
         for(i = 0; i < num; )
         {
            line = _lines[i];
            node = <line>{line.msg}</line>;
            node.@timeStamp = line.timestamp;
            node.@runTime = line.runtime;
            node.@level = line.level;
            node.@originatingClass = line.origin;
            node.@dataType = line.type;
            node.@treatedAs = line.supportedType;
            node.@repeatCount = line.repeatCount;
            xml.appendChild(node);
            i++;
         }
         _save(xml);
      }
      
      internal static function saveLogAsText(e:MouseEvent = null) : void
      {
         _save(Owindow.getLogText());
      }
      
      private static function _save(contents:*) : void
      {
         var d:Date = new Date();
         var ds:String = d.getDate() + "" + d.getMonth() + "" + d.getFullYear();
         var ts:String = d.toTimeString().substr(0,8).replace(/:/g,"");
         var suff:String = contents is XML ? ".xml" : ".txt";
         var fr:FileReference = new FileReference();
         try
         {
            fr["save"](contents,"OlogOutput_" + ds + "_" + ts + suff);
         }
         catch(e:Error)
         {
            trace("Save operation requires FlashPlayer 10",3,"Olog");
         }
      }
      
      internal static function setKeyboardEnabled(val:Boolean) : void
      {
         Oplist.keyBoardEnabled = val;
         _evalKeyboard();
      }
      
      internal static function getLastLineLevel() : int
      {
         return _lastLine.level;
      }
      
      internal static function addKeyBinding(keySequence:String, callback:Function) : void
      {
         if(!_keyBindings)
         {
            _keyBindings = new Dictionary(true);
         }
         if(_keyBindings[keySequence] != null)
         {
            Ocore.trace("Key binding \"" + keySequence + "\" overwrite at " + getCallee(4),2,"Olog");
         }
         _keyBindings[keySequence] = callback;
      }
      
      internal static function forceExpandedArrayTrace(args:Array, level:int = 1) : void
      {
         var valBefore:Boolean = Oplist.expandArrayItems;
         Oplist.expandArrayItems = true;
         Ocore.trace(args,level);
         Oplist.expandArrayItems = valBefore;
      }
      
      internal static function activateLogTargets(targets:Array) : void
      {
         var target:* = null;
         var i:int = 0;
         var num:int = targets.length;
         for(i = 0; i < num; i++)
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
