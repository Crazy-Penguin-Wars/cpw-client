package no.olog
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   internal class OprefPane extends Sprite
   {
      private static const DELIMITER:String = "  |  ";
      
      private var _bg:Shape;
      
      private var _field:TextField;
      
      private var _menu:String = "";
      
      public function OprefPane()
      {
         super();
         this._init();
      }
      
      private function _init() : void
      {
         var _loc1_:uint = uint(Oplist.PADDING);
         this._bg = new Shape();
         this._bg.graphics.beginFill(Oplist.PREF_PANE_BG_COLOR);
         this._bg.graphics.drawRect(0,0,Oplist.DEFAULT_WIDTH,20);
         this._bg.graphics.endFill();
         addChild(this._bg);
         this._field = new TextField();
         this._field.autoSize = TextFieldAutoSize.LEFT;
         this._field.multiline = true;
         this._field.selectable = false;
         this._field.wordWrap = true;
         this._field.width = Oplist.DEFAULT_WIDTH;
         this._field.styleSheet = this._getStyleSheet();
         this._field.addEventListener(TextEvent.LINK,this._onTextLink);
         this._field.x = _loc1_;
         this._field.y = _loc1_;
         addChild(this._field);
         this._menu += "<menu>";
         this._menu += "<header>Utilities</header>";
         this._menu += "<a href=\"event:saveXml\">Save as XML</a>" + DELIMITER;
         this._menu += "<a href=\"event:saveText\">Save as Text</a>" + DELIMITER;
         this._menu += "<a href=\"event:updateCheck\">Check for update</a>" + DELIMITER;
         this._menu += "<a href=\"event:clear\">Clear</a>";
         this._menu += "</menu>";
         this._field.htmlText = this._menu;
         this._bg.height = this._field.height + _loc1_ * 2;
      }
      
      private function _onTextLink(param1:TextEvent) : void
      {
         switch(param1.text)
         {
            case "saveXml":
               Ocore.saveLogAsXML();
               break;
            case "saveText":
               Ocore.saveLogAsText();
               break;
            case "clear":
               Owindow.clear();
               break;
            case "updateCheck":
               Ocore.checkForUpdates();
               break;
            default:
               throw new Error("switch case unsupported");
         }
      }
      
      private function _getStyleSheet() : StyleSheet
      {
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.setStyle("menu",{
            "fontFamily":"_sans",
            "fontSize":14,
            "leading":4
         });
         _loc1_.setStyle("header",{
            "fontSize":12,
            "color":"#666666"
         });
         _loc1_.setStyle("a",{"fontFamily":"_typewriter"});
         _loc1_.setStyle("a:hover",{"color":"#000000"});
         _loc1_.setStyle("a:link",{"color":"#444444"});
         return _loc1_;
      }
      
      override public function set width(param1:Number) : void
      {
         this._field.width = param1;
         this._bg.width = param1;
         this._bg.height = this._field.height + Oplist.PADDING * 2;
      }
   }
}

