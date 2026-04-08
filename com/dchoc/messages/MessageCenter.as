package com.dchoc.messages
{
   import com.dchoc.events.*;
   import com.dchoc.utils.*;
   
   public class MessageCenter
   {
      private static var lastMessageType:String;
      
      private static const DEBUG_ALL_MESSAGES:Boolean = false;
      
      private static const eventListeners:Object = {};
      
      private static var listeners:Vector.<String> = new Vector.<String>();
      
      public function MessageCenter()
      {
         super();
         throw new Error("This is a static class!");
      }
      
      public static function addListener(param1:String, param2:Function) : void
      {
         if(Config.debugMode)
         {
            listeners.push(param1);
         }
         if(!eventListeners.hasOwnProperty(param1))
         {
            eventListeners[param1] = new Vector.<Function>();
         }
         if(eventListeners[param1].indexOf(param2) == -1)
         {
            eventListeners[param1].push(param2);
         }
      }
      
      public static function removeListener(param1:String, param2:Function) : void
      {
         var _loc3_:int = 0;
         if(Config.debugMode && listeners.indexOf(param1) != -1)
         {
            listeners.splice(listeners.indexOf(param1),1);
         }
         var _loc4_:Vector.<Function> = eventListeners[param1];
         if(_loc4_)
         {
            _loc3_ = int(_loc4_.indexOf(param2));
            if(_loc3_ >= 0)
            {
               _loc4_.splice(_loc3_,1);
            }
         }
      }
      
      public static function displayListeners() : void
      {
         var _loc1_:* = undefined;
         if(Config.debugMode)
         {
            LogUtils.log("Listener Count: " + listeners.length,null,0,"ListenerDebug",false);
            for each(_loc1_ in listeners)
            {
               LogUtils.log(_loc1_,null,0,"ListenerDebug",false);
            }
         }
      }
      
      public static function sendMessage(param1:String, param2:* = null) : void
      {
         var type:String = param1;
         var data:* = param2;
         //try
         //{
            sendEvent(new Message(type,data));
         //}
         //catch(e:Error)
         //{
         //   LogUtils.log(e.getStackTrace(),null,3,"Messages",false);
         //   sendEvent(new ErrorMessage("Message Center Exception",type,"type: " + type + " error: " + e.message.toString(),null,e));
         //}
      }
      
      public static function sendEvent(param1:Message) : void
      {
         var func:* = undefined;
         var msg:Message = param1;
         var _loc4_:* = undefined;
         var foundNull:Boolean = false;
         var i:int = 0;
         if(Config.debugMode && !eventListeners.hasOwnProperty(msg.type) && Boolean(checkLastType(msg.type)))
         {
            LogUtils.log("sendEvent: No eventListener for type: " + msg.type,null,2,"Messages",false,false,false);
         }
         //try
         //{
            _loc4_ = eventListeners[msg.type];
            if(_loc4_)
            {
               for each(func in _loc4_)
               {
                  if(func != null)
                  {
                     func(msg);
                  }
                  else
                  {
                     foundNull = true;
                  }
               }
               if(foundNull)
               {
                  i = _loc4_.length - 1;
                  while(i >= 0)
                  {
                     if(_loc4_[i] == null)
                     {
                        _loc4_.splice(i,1);
                     }
                     i--;
                  }
               }
            }
         //}
         //catch(e:Error)
         //{
         //   LogUtils.log(e.getStackTrace(),null,3,"Messages",true,true);
         //   trace(e.getStackTrace());
         //   if(msg)
         //   {
         //      sendEvent(new ErrorMessage("Message Center Exception",msg.type,"type: " + msg.type + " error: " + e.message.toString(),null,e));
         //   }
         //   else
         //   {
         //      sendEvent(new ErrorMessage("Message Center Exception","Unspecified","type: null error: " + e.message.toString(),null,e));
         //   }
         //}
      }
      
      private static function checkLastType(param1:String) : Boolean
      {
         var _loc2_:* = lastMessageType != param1;
         lastMessageType = param1;
         return _loc2_;
      }
   }
}

