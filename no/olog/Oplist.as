package no.olog
{
   internal class Oplist
   {
      
      internal static var loggingEnabled:Boolean = true;
      
      internal static var rememberWindowState:Boolean = true;
      
      internal static var alwaysOnTop:Boolean = true;
      
      internal static var enableTimeStamp:Boolean = false;
      
      internal static var enableLineNumbers:Boolean = true;
      
      internal static var enableRunTime:Boolean = true;
      
      internal static var keyBoardEnabled:Boolean = true;
      
      internal static var stackRepeatedMessages:Boolean = true;
      
      internal static var maxUntruncatedLength:int = -1;
      
      internal static var truncateMultiline:Boolean = false;
      
      internal static var wrapLines:Boolean = true;
      
      internal static var scrollOnNewLine:Boolean = true;
      
      internal static var showMemoryUsage:Boolean = true;
      
      internal static var memoryUsageLimitMB:uint = 70;
      
      internal static var colorizeColorStrings:Boolean = true;
      
      internal static var expandArrayItems:Boolean = false;
      
      internal static var dispatchOlogOutEvents:Boolean = false;
      
      internal static const DEFAULT_WIDTH:int = 400;
      
      internal static const DEFAULT_HEIGHT:int = 350;
      
      internal static var x:int = -1;
      
      internal static var y:int = -1;
      
      internal static var width:int = -1;
      
      internal static var height:int = -1;
      
      internal static const NAME:String = "Olog";
      
      internal static const VERSION:String = "1.3.0";
      
      internal static const TB_FONT:String = "_sans";
      
      internal static const TB_FONT_SIZE:uint = 10;
      
      internal static const TB_COLORS:Array = [5855577,2500134,1644825,460551];
      
      internal static const TB_RATIOS:Array = [0,128,129,255];
      
      internal static const TB_ALPHAS:Array = [1,1,1,1];
      
      internal static const TB_PADDING:int = 13;
      
      internal static const TB_HEIGHT:int = 28;
      
      internal static const TB_ALIGN:String = "center";
      
      internal static const VERSION_CHECK_URL:String = "http://www.oyvindnordhagen.com/olog/OlogVersionHistory.xml";
      
      internal static const NEW_VERSION_MSG:String = "Olog version @version available!";
      
      internal static const DAY_IN_MS:int = 86400000;
      
      internal static const VERSION_CHECK_INTERVAL_DAYS:int = 7;
      
      internal static const FEATURES:String = "New features:";
      
      internal static const FIXES:String = "Bug fixes:";
      
      internal static const NOTES:String = "Notes:";
      
      internal static const DL_LABEL:String = "Download here!";
      
      internal static const DL_LINK:String = "http://www.oyvindnordhagen.com/blog/olog/";
      
      internal static const EVENT_OPEN_TRUNCATED:String = "openTruncated";
      
      internal static const EVENT_CLOSE_TRUNCATED:String = "closeTruncated";
      
      internal static const EVENT_VERSION_DETAILS:String = "eventVersionDetails";
      
      internal static const OPEN_TRUNCATED_LABEL:String = "Show »";
      
      internal static const CLOSE_TRUNCATED_LABEL:String = "« Hide";
      
      internal static const PW_BOX_WIDTH:Number = 200;
      
      internal static const PW_BOX_HEIGHT:Number = 30;
      
      internal static const BG_ALPHA:Number = 0.9;
      
      internal static const BG_COL:uint = 1842204;
      
      internal static const BTN_LINE_COLOR:uint = 10066329;
      
      internal static const BTN_FILL_COLOR:uint = 0;
      
      internal static const BTN_UP_ALPHA:Number = 0.7;
      
      internal static const BTN_OVER_ALPHA:Number = 1;
      
      internal static const CORNER_RADIUS:int = 5;
      
      internal static const DRAGGER_SIZE:int = 10;
      
      internal static const MIN_WIDTH:int = 100;
      
      internal static const MIN_HEIGHT:int = 100;
      
      internal static const PADDING:int = 5;
      
      internal static const TEXT_INDENT:int = 10;
      
      internal static const PREF_PANE_BG_COLOR:uint = 10066329;
      
      internal static const PREFS_BUTTON_WIDTH:uint = 100;
      
      internal static const PREFS_BUTTON_HEIGHT:uint = 24;
      
      internal static const XML_OUTPUT_FILENAME:String = "OlogOutput";
      
      internal static const FONT:String = "_typewriter";
      
      internal static const SIZE_MAC:uint = 10;
      
      internal static const SIZE_WIN:uint = 11;
      
      internal static const LEADING:int = 1;
      
      internal static const LEVEL_STRINGS:Array = ["[info] ","[debug] ","[* warning] ","[** error] ","[success] ","[event] ","","","","[marker] "];
      
      internal static const TEXT_COLORS_HEX:Array = ["#9AB28E","#ffffff","#ffcc00","#FF7F7F","#42d73b","#4CDBFF","#ffffff","#ffffff","#ffffff","#00ffff"];
      
      internal static const TEXT_COLORS_UINT:Array = [10138254,16777215,16763904,16744319,4380475,5037055,16777215,16777215,16777215,65535];
      
      internal static const TEXT_COLOR_LAST_INDEX:int = 5;
      
      internal static const TEXT_COLOR_LAST_ERROR_INDEX:int = 3;
      
      internal static const MARKER_COLOR_INDEX:int = 9;
      
      internal static const TAB_STOPS:Array = [10,250,300,400,500,600,700];
      
      internal static const ORIGIN_DELIMITER:String = " › ";
      
      internal static const ORIGIN_DELIMITER_TXT:String = " ~ ";
      
      internal static const LINE_START_DELIMITER:String = " ";
      
      internal static const AFTER_LINE_START:String = " ";
      
      internal static const EMPTY_MSG_STRING:String = "[empty message]";
      
      internal static const LINE_START_TABS:String = "\t";
      
      internal static const CMI_OPEN_LABEL:String = "Open log";
      
      internal static const CMI_CLOSE_LABEL:String = "Close log";
      
      internal static const PWPROMPT_LABEL:String = "Password:";
      
      internal static const OLOG_EVENT:String = "OlogEvent";
      
      internal static const SUPPORTED_TYPES:Array = ["String","Number","int","Array","XML","XMLList","Vector","XML","Sprite","MovieClip","Event","ErrorEvent","Error","UncaughtErrorEvent","Object"];
       
      
      public function Oplist()
      {
         super();
      }
   }
}
