package
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.system.Capabilities;
   import flash.system.Security;
   import mx.utils.StringUtil;
   import nape.geom.Vec2;
   import no.olog.Olog;
   import org.as3commons.lang.StringUtils;
   
   public class Config
   {
      
      private static var loadingScreenClass:Class = §loading_swf$894ea72c2d67d57e1860bb23455de030-2127856406§;
      
      public static const VEC_UP:Vec2 = new Vec2(0,-1);
      
      public static const VEC_DOWN:Vec2 = new Vec2(0,1);
      
      public static const VEC_RIGHT:Vec2 = new Vec2(1,0);
      
      public static const VEC_LEFT:Vec2 = new Vec2(-1,0);
      
      public static const ZERO_VEC:Vec2 = new Vec2();
      
      public static const ZERO_POINT:Point = new Point();
      
      public static const CRM_SERVER_URL:String = "http://crm.digitalchocolate.com";
      
      public static const CRM_SERVER_STAGE_URL:String = "http://crm-stage.digitalchocolate.com";
      
      private static const DEFAULT_SERVER_URL:String = "http://tuxwars-dev.dchoc.com/tuxwars/";
      
      private static const DEFAULT_SERVER_STAGE_URL:String = "http://8.19.35.89:8080/tuxwars/";
      
      private static const INTRO_MOVIE:String = "intro/TuxWars-Intro_HD.f4v";
      
      public static const STAGE_WIDTH:int = 760;
      
      public static const STAGE_HEIGHT:int = 668;
      
      private static var gameCreatedDate:Date;
      
      private static var serverURL:String;
      
      private static var dataDir:String;
      
      private static var offlineMode:Boolean;
      
      private static var env:String;
      
      private static var token:String;
      
      private static var userId:String;
      
      private static var apiKey:String;
      
      private static var platform:String;
      
      private static var version:String;
      
      public static var platformUserId:String;
      
      private static var languageCode:String;
      
      public static var secure:Boolean;
      
      public static var debugMode:Boolean;
      
      private static var devMode:Boolean;
      
      private static var stageMode:Boolean;
      
      private static var smUseHomemadeFriendSelector:Boolean;
      
      public static const POWER_UP_ICON_SIZE:int = 50;
      
      public static var ENABLE_DEAL_SPOT_PROMOTION:Boolean = true;
       
      
      public function Config()
      {
         super();
      }
      
      public static function init(params:Object) : void
      {
         var _loc2_:* = null;
         serverURL = params.server;
         smUseHomemadeFriendSelector = true;
         secure = params.secure == "true";
         if(serverURL)
         {
            dataDir = params.data;
            token = params.token;
            userId = params.uid;
            platformUserId = params.platformUserId;
            languageCode = params.language;
            platform = params.platform;
            env = params.env;
            version = params.version;
            debugMode = params.env == "dev" || params.env == "dev_local" || params.env == "stage";
            devMode = params.env == "dev" || params.env == "dev_local";
            stageMode = params.env == "stage";
            MessageCenter.sendMessage("ConfigLoaded");
         }
         else
         {
            dataDir = "../../data/";
            languageCode = "en";
            debugMode = true;
            devMode = true;
            platform = "FB";
            env = "dev";
            DCResourceManager.instance.load("../config.txt","Config","VariablesTextFile",true);
            DCResourceManager.instance.addCustomEventListener("complete",loadConfigComplete,"Config");
            serverURL = "http://tuxwars-dev.dchoc.com/tuxwars/";
            offlineMode = true;
         }
         var _loc8_:Boolean = debugMode;
         var _loc4_:Olog = Olog;
         no.olog.Ocore.setCMI(_loc8_);
         var _loc9_:Boolean = debugMode;
         var _loc5_:Olog = Olog;
         no.olog.Oplist.loggingEnabled = _loc9_;
         if(params.platformServerUrl != null)
         {
            _loc2_ = params.platformServerUrl.split(",");
            for each(var url in _loc2_)
            {
               LogUtils.log("Allowing domain: " + url,"Config",0,"ConfigInit");
               Security.allowDomain(url);
            }
            Security.allowDomain("dchoc1-a.akamaihd.net/wcrm/v3/");
            Security.loadPolicyFile("dchoc1-a.akamaihd.net/wcrm/v3/crossdomain.xml");
         }
         LogUtils.log("Param:" + JSON.stringify(params),"Config",0,"ConfigInit");
         LogUtils.log("Config Initialized","Config",0,"ConfigInit");
         LogUtils.log("Game created at: " + gameCreatedDate,"Config",0,"ConfigInit");
         LogUtils.log("Env: " + getEnv(),"Config",0,"ConfigInit");
         LogUtils.log("Debug Mode: " + debugMode,"Config",0,"ConfigInit");
         LogUtils.log("Dev Mode: " + isDev(),"Config",0,"ConfigInit");
         LogUtils.log("Data dir: " + getDataDir(),"Config",0,"ConfigInit");
         LogUtils.log("Language Code: " + getLanguageCode(),"Config",0,"ConfigInit");
         LogUtils.log("Server URL: " + getServerURL(),"Config",0,"ConfigInit");
         LogUtils.log("Platform Server URL: " + params.platformServerUrl,"Config",0,"ConfigInit");
         LogUtils.log("secure : " + secure,"Config",0,"ConfigInit");
         LogUtils.log("platformUserId : " + platformUserId,"Config",0,"ConfigInit");
      }
      
      public static function setGameCreatedDate(value:Date) : void
      {
         gameCreatedDate = value;
      }
      
      public static function getEnv() : String
      {
         return env;
      }
      
      public static function useHomemadeFriendSelector() : Boolean
      {
         return smUseHomemadeFriendSelector;
      }
      
      public static function getVersion() : String
      {
         return version;
      }
      
      public static function isDev() : Boolean
      {
         return devMode;
      }
      
      public static function isStage() : Boolean
      {
         return stageMode;
      }
      
      public static function getLanguageCode() : String
      {
         return languageCode;
      }
      
      public static function setLanguageCode(value:String) : void
      {
         languageCode = value;
      }
      
      public static function getDataDir() : String
      {
         return dataDir;
      }
      
      public static function getServerURL() : String
      {
         return serverURL;
      }
      
      public static function getToken() : String
      {
         return token;
      }
      
      public static function getUserId() : String
      {
         return userId;
      }
      
      public static function setUserId(value:String) : void
      {
         userId = value;
      }
      
      public static function getApiKey() : String
      {
         return apiKey;
      }
      
      public static function getPlatform() : String
      {
         return platform;
      }
      
      public static function isOfflineMode() : Boolean
      {
         return offlineMode;
      }
      
      public static function getLoadingScreen() : DisplayObjectContainer
      {
         return new loadingScreenClass();
      }
      
      public static function getIntroMovie() : String
      {
         return getDataDir() + "intro/TuxWars-Intro_HD.f4v";
      }
      
      public static function getOS() : int
      {
         var _loc1_:String = Capabilities.os;
         if(StringUtils.startsWith(_loc1_,"Windows"))
         {
            return 1;
         }
         if(StringUtils.startsWith(_loc1_,"Mac"))
         {
            return 2;
         }
         if(StringUtils.startsWith(_loc1_,"Linux"))
         {
            return 3;
         }
         return 0;
      }
      
      public static function getOSStr() : String
      {
         var _loc1_:String = Capabilities.os;
         if(StringUtils.startsWith(_loc1_,"Windows"))
         {
            return "Windows";
         }
         if(StringUtils.startsWith(_loc1_,"Mac"))
         {
            return "MacOS";
         }
         if(StringUtils.startsWith(_loc1_,"Linux"))
         {
            return "Linux";
         }
         return _loc1_;
      }
      
      private static function loadConfigComplete(event:DCLoadingEvent) : void
      {
         var _loc2_:Object = DCResourceManager.instance.get(event.resourceName);
         token = StringUtil.trim(_loc2_["token"]);
         userId = StringUtil.trim(_loc2_["uid"]);
         apiKey = StringUtil.trim(_loc2_["apiKey"]);
         LogUtils.log("Token: " + getToken(),"Config",0,"ConfigInit");
         LogUtils.log("Used ID: " + getUserId(),"Config",0,"ConfigInit");
         MessageCenter.sendMessage("ConfigLoaded");
      }
      
      public static function get vectorUp() : Vec2
      {
         return VEC_UP.copy();
      }
      
      public static function get vectorDown() : Vec2
      {
         return VEC_DOWN.copy();
      }
      
      public static function get vectorRight() : Vec2
      {
         return VEC_RIGHT.copy();
      }
      
      public static function get vectorLeft() : Vec2
      {
         return VEC_LEFT.copy();
      }
   }
}
