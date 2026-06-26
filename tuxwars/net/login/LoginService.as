package tuxwars.net.login {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.ErrorEvent;
    import flash.events.LocationChangeEvent;
    import flash.geom.Rectangle;
    import flash.media.StageWebView;
    import flash.display.Stage;

    public class LoginService extends EventDispatcher {
        private var webView:StageWebView;
        private var stage:Stage;

        public function LoginService(stage: Stage) {
            super();
            this.stage = stage;
        }

        public function showLogin() : void {
            var config:Object = {
                userAgent: "TuxWarsDesktop/1.0"
            };

            webView = new StageWebView(config);
            webView.stage = this.stage;

            resizeWebView();
            this.stage.addEventListener(Event.RESIZE, onStageResize);

            webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onLocationChanging);
            webView.addEventListener(ErrorEvent.ERROR, onWebViewError);

            webView.loadURL("http://127.0.0.1:8000/login");
        }

        private function resizeWebView() : void {
            if (webView) {
                trace("hi?");
                webView.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            }
        }

        private function onStageResize(event: Event) : void {
            resizeWebView();
        }

        // The server tries to redirect, we intercept it
        // doing it this way cuz it also works on android at some point:tm: (and externalinterface not appparently)
        private function onLocationChanging(event: LocationChangeEvent) : void {
            // Intercept your sentinel URL
            if (event.location.indexOf("success") != -1) {
                event.preventDefault(); // Stop the redirect
                handleLoginComplete(event.location);
            }
        }

        private function onWebViewError(event: ErrorEvent) : void {
            trace("WebView error: " + event.text);
        }

        private function handleLoginComplete(url: String) : void {
            var query:String = url.split("?")[1];
            loginParameters = parseQueryString(query);

            Config.initFromLogin(loginParameters);

            closeLogin();
            
            // start the game
            dispatchEvent(new Event(Event.COMPLETE));
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