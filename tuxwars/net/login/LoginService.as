package tuxwars.net.login {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.ErrorEvent;
    import flash.events.LocationChangeEvent;
    import flash.geom.Rectangle;
    import flash.media.StageWebView;
    import flash.display.Stage;
	import flash.net.SharedObject;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLRequestHeader;
    import flash.net.URLLoaderDataFormat;
    import flash.events.IOErrorEvent;

    public class LoginService extends EventDispatcher {
        private var webView:StageWebView;
        private var stage:Stage;
		private var serverurl:String;

        public function LoginService(stage: Stage) {
            super();
            this.stage = stage;

            if (CONFIG::LOCAL_SERVER_MODE){
                this.serverurl = "http://127.0.0.1:8000"
            } else {
                this.serverurl = "https://web.crazypenguinwars.app"
            }
        }

        public function startLogin() : void {
            var sharedobj:SharedObject = SharedObject.getLocal("CPWClientData");
            if (sharedobj && sharedobj.data.client_password != "" && sharedobj.data.expiration != "" && sharedobj.data.userid != "") {
                var expiration:Date = new Date(sharedobj.data.expiration);
                if (expiration > new Date()) {
                    // Log in with client password instead
                    doFastLogin(sharedobj.data.userid, sharedobj.data.client_password);
                    return;
                }
            }

            showLogin();
        }

        public function showLogin() : void {
            var config:Object = {
                userAgent: "TuxWarsDesktop/1.0",
                enableDevTools: false,
                enableContextMenu: false,
                enableKeyboardShortcuts: false,
                enableStatusBar: false,
                enableZoom: false
            };

            webView = new StageWebView(config);
            webView.stage = this.stage;

            resizeWebView();
            this.stage.addEventListener(Event.RESIZE, onStageResize);

            webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChanging);
            webView.addEventListener(ErrorEvent.ERROR, onWebViewError);

            webView.loadURL(this.serverurl + "/login");
        }

        private function resizeWebView() : void {
            if (webView) {
                webView.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            }
        }

        private function onStageResize(event: Event) : void {
            resizeWebView();
        }

        // The server tries to redirect, we intercept it
        // doing it this way cuz it also works on android at some point:tm: (and externalinterface not appparently)
        private function onLocationChanging(event: LocationChangeEvent) : void {
            if (event.location.indexOf("success") != -1) {
                event.preventDefault(); // Stop the redirect
                handleLoginComplete(event.location);
            }
        }

        private function onWebViewError(event: ErrorEvent) : void {
            trace("WebView error: " + event.text);
        }

        private function handleLoginComplete(url:String):void
        {
            var query:String = url.split("?")[1];
            var params:Object = parseQueryString(query);

            if (!params.code)
            {
                trace("Missing auth code");
                closeLogin();
                return;
            }

            exchangeParams(params.code);
        }

        private function exchangeParams(code:String):void
        {
            var request:URLRequest = new URLRequest(this.serverurl + "/exchange");
            
            request.method = URLRequestMethod.POST;

            request.requestHeaders = [
                new URLRequestHeader("Content-Type", "application/json")
            ];

            request.data = JSON.stringify({
                code: code
            });

            var loader:URLLoader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;

            loader.addEventListener(Event.COMPLETE, onExchangeComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onExchangeError);

            loader.load(request);
        }

        private function onExchangeComplete(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            var loginParameters:Object = JSON.parse(loader.data);

            Config.initFromLogin(loginParameters);

            if (loginParameters.rememberme) {
                var sharedobj:SharedObject = SharedObject.getLocal("CPWClientData");
                sharedobj.data.client_password = loginParameters.client_password.password;
                sharedobj.data.expiration = loginParameters.client_password.expiration;
                sharedobj.data.userid = loginParameters.userId;
            }

            closeLogin();

            // start the game
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function onExchangeError(event:IOErrorEvent):void
        {
            trace("Exchange failed: " + event.text);
            closeLogin();
        }

        private function doFastLogin(userid: String, client_password):void
        {
            var request:URLRequest = new URLRequest(this.serverurl + "/fastlogin");
            request.method = URLRequestMethod.POST;

            request.requestHeaders = [
                new URLRequestHeader("Content-Type", "application/json")
            ];

            request.data = JSON.stringify({
                userid: userid,
                client_password: client_password
            });

            var loader:URLLoader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;

            loader.addEventListener(Event.COMPLETE, onFastLoginComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onFastLoginError);

            loader.load(request);
        }

        private function onFastLoginComplete(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            var loginParameters:Object = JSON.parse(loader.data);

            if(loginParameters.error) {
                var sharedobj:SharedObject = SharedObject.getLocal("CPWClientData");
                sharedobj.data.userid = ""
                sharedobj.data.client_password = ""
                sharedobj.data.expiration = ""
                showLogin()
                return
            }

            Config.initFromLogin(loginParameters);

            closeLogin();

            // start the game
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function onFastLoginError(event:IOErrorEvent):void
        {
            trace("Fast login failed, show regular login page");
            showLogin();
        }

        public function closeLogin() : void {
            if (webView) {
                webView.removeEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChanging);
                webView.removeEventListener(ErrorEvent.ERROR, onWebViewError);
                webView.stage = null;
                webView.dispose();
                webView = null;
            }
            stage.removeEventListener(Event.RESIZE, onStageResize);
        }

        private function parseQueryString(qs: String) : Object {
            var result: Object = {};
            if (!qs) return result;
            for each (var pair: String in qs.split("&")) {
                var kv: Array = pair.split("=");
                result[decodeURIComponent(kv[0])] = decodeURIComponent(kv[1] || "");
            }
            return result;
        }
    }
}