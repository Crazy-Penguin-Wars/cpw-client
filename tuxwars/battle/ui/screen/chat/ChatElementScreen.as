package tuxwars.battle.ui.screen.chat
{
   import com.dchoc.game.DCGame;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.chat.ChatLogic;
   import tuxwars.data.Tuner;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function ChatElementScreen(from:MovieClip, game:TuxWarsGame)
      {
         super(from.Chat_Window,game);
         this._design.mouseEnabled = false;
         chatText = getDesignMovieClip().getChildByName("Text_Chat") as TextField;
         chatText.text = "";
         messageText = getDesignMovieClip().getChildByName("Text_Message") as TextField;
         messageText.text = ProjectManager.getText("TID_CHAT_DEFAULT_INPUT");
         messageText.addEventListener("click",inputClick,false,0,true);
         scrollUpButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Scroll_Up");
         scrollUpButton.setMouseDownCallback(scrollUpMouseDown);
         scrollUpButton.setMouseUpCallback(scrollUpMouseUp);
         scrollDownButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Scroll_Down");
         scrollDownButton.setMouseDownCallback(scrollDownMouseDown);
         scrollDownButton.setMouseUpCallback(scrollDownMouseUp);
         enterButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Enter",enterPressed);
         fullscreenChanged(DCGame.isFullScreen());
      }
      
      override public function dispose() : void
      {
         messageText.removeEventListener("click",inputClick);
         messageText.removeEventListener("keyUp",keyUp);
         messageText.removeEventListener("keyDown",keyDown);
         chatText = null;
         messageText = null;
         scrollDownButton.dispose();
         scrollDownButton = null;
         scrollUpButton.dispose();
         scrollUpButton = null;
         enterButton.dispose();
         enterButton = null;
         super.dispose();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         if(scrollingDown)
         {
            chatText.scrollV++;
         }
         if(scrollingUp)
         {
            chatText.scrollV--;
         }
      }
      
      public function addMessage(id:String, name:String, message:String, isStatus:Boolean) : void
      {
         var _loc6_:* = null;
         message = parseMessage(message);
         var textToAppend:String = "";
         if(name)
         {
            var _loc8_:Tuner = Tuner;
            _loc6_ = tuxwars.data.Tuner.getField("ChatColors").value[game.tuxWorld.getIndexOfPlayerWithId(id)];
            var _loc9_:Tuner = Tuner;
            textToAppend += "<FONT COLOR=\"#" + _loc6_ + "\"><b>" + name + "</b></FONT><FONT COLOR=\"#" + tuxwars.data.Tuner.getField("ChatColors").value[4] + "\">: </FONT>";
         }
         var _loc10_:Tuner = Tuner;
         var _loc5_:String = tuxwars.data.Tuner.getField("ChatColors").value[isStatus ? 5 : 4];
         textToAppend += "<FONT COLOR=\"#" + _loc5_ + "\"><b> " + message + "\n" + "</FONT>";
         chatText.htmlText += textToAppend;
         if(!scrollingDown || !scrollingUp)
         {
            chatText.scrollV = chatText.numLines - 4;
         }
      }
      
      private function parseMessage(message:String) : String
      {
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var remove:Boolean = false;
         var i:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var subTag:* = null;
         var currentIndex:* = 0;
         var messageLowerCase:String = message.toLowerCase();
         while(messageLowerCase.indexOf(PARSE_TAGS[0],currentIndex) != -1)
         {
            _loc5_ = messageLowerCase.indexOf(PARSE_TAGS[0],currentIndex);
            _loc9_ = messageLowerCase.indexOf(PARSE_TAGS[2],currentIndex + 1);
            remove = true;
            if(_loc5_ < _loc9_)
            {
               i = 0;
               while(true)
               {
                  var _loc11_:Tuner = Tuner;
                  if(i >= tuxwars.data.Tuner.getField("ChatHtmlTags").value.length)
                  {
                     break;
                  }
                  var _loc12_:Tuner = Tuner;
                  _loc3_ = PARSE_TAGS[0] + tuxwars.data.Tuner.getField("ChatHtmlTags").value[i].toLowerCase();
                  var _loc13_:Tuner = Tuner;
                  _loc2_ = PARSE_TAGS[0] + PARSE_TAGS[1] + tuxwars.data.Tuner.getField("ChatHtmlTags").value[i].toLowerCase();
                  subTag = "";
                  var _loc14_:Tuner = Tuner;
                  if(tuxwars.data.Tuner.getField("ChatHtmlTags").value[i + 1])
                  {
                     var _loc15_:Tuner = Tuner;
                     subTag += " " + tuxwars.data.Tuner.getField("ChatHtmlTags").value[i + 1].toLowerCase();
                  }
                  if(messageLowerCase.indexOf(_loc3_,_loc5_) == _loc5_ && (!subTag || messageLowerCase.indexOf(_loc3_ + subTag,_loc5_) == _loc5_) || messageLowerCase.indexOf(_loc2_,_loc5_) == _loc5_)
                  {
                     remove = false;
                     break;
                  }
                  i += 2;
               }
               if(remove)
               {
                  message = removeTextBetween(message,_loc5_,_loc9_);
                  messageLowerCase = message.toLowerCase();
                  currentIndex = _loc5_;
               }
               else
               {
                  currentIndex = _loc9_;
               }
            }
            else
            {
               if(currentIndex >= message.length)
               {
                  break;
               }
               currentIndex = _loc5_ + 1;
            }
         }
         return message;
      }
      
      private function removeTextBetween(message:String, startIndex:int, endIndex:int) : String
      {
         var messageWorkString:String = "";
         if(startIndex > 0)
         {
            messageWorkString += message.slice(0,startIndex);
         }
         if(endIndex < message.length)
         {
            messageWorkString += message.slice(endIndex + 1,message.length);
         }
         return messageWorkString;
      }
      
      override public function fullscreenChanged(fullscreen:Boolean) : void
      {
         if(fullscreen)
         {
            addMessage(null,null,ProjectManager.getText("NO_KEYBOARD_IN_FULLSCREEN"),true);
         }
      }
      
      private function scrollUpMouseDown(event:MouseEvent) : void
      {
         scrollingUp = true;
      }
      
      private function scrollUpMouseUp(event:MouseEvent) : void
      {
         scrollingUp = false;
      }
      
      private function scrollDownMouseDown(event:MouseEvent) : void
      {
         scrollingDown = true;
      }
      
      private function scrollDownMouseUp(event:MouseEvent) : void
      {
         scrollingDown = false;
      }
      
      private function enterPressed(event:MouseEvent = null) : void
      {
         if(messageText.text)
         {
            chatLogic.sendMessage(messageText.text);
            messageText.text = "";
         }
      }
      
      private function inputClick(event:MouseEvent) : void
      {
         messageText.text = "";
         messageText.removeEventListener("click",inputClick);
         messageText.addEventListener("keyUp",keyUp,false,0,true);
         messageText.addEventListener("keyDown",keyDown,false,0,true);
      }
      
      private function keyDown(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
      }
      
      private function keyUp(event:KeyboardEvent) : void
      {
         switch(event.keyCode)
         {
            case 13:
               enterPressed();
            default:
               event.stopImmediatePropagation();
               return;
            case 65:
            case 87:
            case 68:
            case 32:
            case 38:
            case 37:
               break;
            case 39:
         }
      }
      
      private function get chatLogic() : ChatLogic
      {
         return logic;
      }
   }
}
