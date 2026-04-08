package tuxwars.battle.ui.screen.chat
{
   import com.dchoc.game.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.chat.ChatLogic;
   import tuxwars.data.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.utils.*;
   
   public class ChatElementScreen extends TuxUIElementScreen
   {
      private static const MAX_LINES:int = 4;
      
      private static const TEXT_CHAT:String = "Text_Chat";
      
      private static const TEXT_MESSAGE:String = "Text_Message";
      
      private static const BUTTON_MAXIMIZE:String = "Button_Maximize";
      
      private static const BUTTON_SCROLL_UP:String = "Button_Scroll_Up";
      
      private static const BUTTON_SCROLL_DOWN:String = "Button_Scroll_Down";
      
      private static const BUTTON_ENTER:String = "Button_Enter";
      
      private static const PARSE_TAGS:Array = ["<","/",">"];
      
      private var chatText:TextField;
      
      private var messageText:TextField;
      
      private var scrollUpButton:UIButton;
      
      private var scrollDownButton:UIButton;
      
      private var enterButton:UIButton;
      
      private var scrollingDown:Boolean;
      
      private var scrollingUp:Boolean;
      
      public function ChatElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1.Chat_Window,param2);
         this._design.mouseEnabled = false;
         this.chatText = getDesignMovieClip().getChildByName("Text_Chat") as TextField;
         this.chatText.text = "";
         this.messageText = getDesignMovieClip().getChildByName("Text_Message") as TextField;
         this.messageText.text = ProjectManager.getText("TID_CHAT_DEFAULT_INPUT");
         this.messageText.addEventListener("click",this.inputClick,false,0,true);
         this.scrollUpButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Scroll_Up");
         this.scrollUpButton.setMouseDownCallback(this.scrollUpMouseDown);
         this.scrollUpButton.setMouseUpCallback(this.scrollUpMouseUp);
         this.scrollDownButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Scroll_Down");
         this.scrollDownButton.setMouseDownCallback(this.scrollDownMouseDown);
         this.scrollDownButton.setMouseUpCallback(this.scrollDownMouseUp);
         this.enterButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Enter",this.enterPressed);
         this.fullscreenChanged(DCGame.isFullScreen());
      }
      
      override public function dispose() : void
      {
         this.messageText.removeEventListener("click",this.inputClick);
         this.messageText.removeEventListener("keyUp",this.keyUp);
         this.messageText.removeEventListener("keyDown",this.keyDown);
         this.chatText = null;
         this.messageText = null;
         this.scrollDownButton.dispose();
         this.scrollDownButton = null;
         this.scrollUpButton.dispose();
         this.scrollUpButton = null;
         this.enterButton.dispose();
         this.enterButton = null;
         super.dispose();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         if(this.scrollingDown)
         {
            ++this.chatText.scrollV;
         }
         if(this.scrollingUp)
         {
            --this.chatText.scrollV;
         }
      }
      
      public function addMessage(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         var _loc5_:String = null;
         param3 = this.parseMessage(param3);
         var _loc6_:String = "";
         if(param2)
         {
            _loc5_ = Tuner.getField("ChatColors").value[game.tuxWorld.getIndexOfPlayerWithId(param1)];
            _loc6_ += "<FONT COLOR=\"#" + _loc5_ + "\"><b>" + param2 + "</b></FONT><FONT COLOR=\"#" + Tuner.getField("ChatColors").value[4] + "\">: </FONT>";
         }
         var _loc7_:String = Tuner.getField("ChatColors").value[param4 ? 5 : 4];
         _loc6_ += "<FONT COLOR=\"#" + _loc7_ + "\"><b> " + param3 + "\n" + "</FONT>";
         this.chatText.htmlText += _loc6_;
         if(!this.scrollingDown || !this.scrollingUp)
         {
            this.chatText.scrollV = this.chatText.numLines - 4;
         }
      }
      
      private function parseMessage(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:* = 0;
         var _loc10_:String = param1.toLowerCase();
         while(_loc10_.indexOf(PARSE_TAGS[0],_loc9_) != -1)
         {
            _loc2_ = int(_loc10_.indexOf(PARSE_TAGS[0],_loc9_));
            _loc3_ = int(_loc10_.indexOf(PARSE_TAGS[2],_loc9_ + 1));
            _loc4_ = true;
            if(_loc2_ < _loc3_)
            {
               _loc5_ = 0;
               while(_loc5_ < Tuner.getField("ChatHtmlTags").value.length)
               {
                  _loc6_ = PARSE_TAGS[0] + Tuner.getField("ChatHtmlTags").value[_loc5_].toLowerCase();
                  _loc7_ = PARSE_TAGS[0] + PARSE_TAGS[1] + Tuner.getField("ChatHtmlTags").value[_loc5_].toLowerCase();
                  _loc8_ = "";
                  if(Tuner.getField("ChatHtmlTags").value[_loc5_ + 1])
                  {
                     _loc8_ += " " + Tuner.getField("ChatHtmlTags").value[_loc5_ + 1].toLowerCase();
                  }
                  if(_loc10_.indexOf(_loc6_,_loc2_) == _loc2_ && (!_loc8_ || _loc10_.indexOf(_loc6_ + _loc8_,_loc2_) == _loc2_) || _loc10_.indexOf(_loc7_,_loc2_) == _loc2_)
                  {
                     _loc4_ = false;
                     break;
                  }
                  _loc5_ += 2;
               }
               if(_loc4_)
               {
                  param1 = this.removeTextBetween(param1,_loc2_,_loc3_);
                  _loc10_ = param1.toLowerCase();
                  _loc9_ = _loc2_;
               }
               else
               {
                  _loc9_ = _loc3_;
               }
            }
            else
            {
               if(_loc9_ >= param1.length)
               {
                  break;
               }
               _loc9_ = _loc2_ + 1;
            }
         }
         return param1;
      }
      
      private function removeTextBetween(param1:String, param2:int, param3:int) : String
      {
         var _loc4_:String = "";
         if(param2 > 0)
         {
            _loc4_ += param1.slice(0,param2);
         }
         if(param3 < param1.length)
         {
            _loc4_ += param1.slice(param3 + 1,param1.length);
         }
         return _loc4_;
      }
      
      override public function fullscreenChanged(param1:Boolean) : void
      {
         if(param1)
         {
            this.addMessage(null,null,ProjectManager.getText("NO_KEYBOARD_IN_FULLSCREEN"),true);
         }
      }
      
      private function scrollUpMouseDown(param1:MouseEvent) : void
      {
         this.scrollingUp = true;
      }
      
      private function scrollUpMouseUp(param1:MouseEvent) : void
      {
         this.scrollingUp = false;
      }
      
      private function scrollDownMouseDown(param1:MouseEvent) : void
      {
         this.scrollingDown = true;
      }
      
      private function scrollDownMouseUp(param1:MouseEvent) : void
      {
         this.scrollingDown = false;
      }
      
      private function enterPressed(param1:MouseEvent = null) : void
      {
         if(this.messageText.text)
         {
            this.chatLogic.sendMessage(this.messageText.text);
            this.messageText.text = "";
         }
      }
      
      private function inputClick(param1:MouseEvent) : void
      {
         this.messageText.text = "";
         this.messageText.removeEventListener("click",this.inputClick);
         this.messageText.addEventListener("keyUp",this.keyUp,false,0,true);
         this.messageText.addEventListener("keyDown",this.keyDown,false,0,true);
      }
      
      private function keyDown(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function keyUp(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case 13:
               this.enterPressed();
               break;
            default:
               break;
            case 65:
            case 87:
            case 68:
            case 32:
            case 38:
            case 37:
            case 39:
               return;
         }
         param1.stopImmediatePropagation();
      }
      
      private function get chatLogic() : ChatLogic
      {
         return logic;
      }
   }
}

