package com.dchoc.messages
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.utils.LogUtils;
   
   public class MessageCenter
   {
      
      private static const eventListeners:Object = {};
      
      private static const DEBUG_ALL_MESSAGES:Boolean = false;
      
      private static var lastMessageType:String;
      
      private static var listeners:Vector.<String> = new Vector.<String>();
       
      
      public function MessageCenter()
      {
         super();
         throw new Error("This is a static class!");
      }
      
      public static function addListener(type:String, callback:Function) : void
      {
         if(Config.debugMode)
         {
            listeners.push(type);
         }
         if(!eventListeners.hasOwnProperty(type))
         {
            eventListeners[type] = new Vector.<Function>();
         }
         if(eventListeners[type].indexOf(callback) == -1)
         {
            eventListeners[type].push(callback);
         }
      }
      
      public static function removeListener(type:String, callback:Function) : void
      {
         var _loc3_:int = 0;
         if(Config.debugMode && listeners.indexOf(type) != -1)
         {
            listeners.splice(listeners.indexOf(type),1);
         }
         var _loc4_:Vector.<Function> = eventListeners[type];
         if(_loc4_)
         {
            _loc3_ = _loc4_.indexOf(callback);
            if(_loc3_ >= 0)
            {
               _loc4_.splice(_loc3_,1);
            }
         }
      }
      
      public static function displayListeners() : void
      {
         if(Config.debugMode)
         {
            LogUtils.log("Listener Count: " + listeners.length,null,0,"ListenerDebug",false);
            for each(var s in listeners)
            {
               LogUtils.log(s,null,0,"ListenerDebug",false);
            }
         }
      }
      
      public static function sendMessage(type:String, data:* = null) : void
      {
         try
         {
            sendEvent(new Message(type,data));
         }
         catch(e:Error)
         {
            LogUtils.log(e.getStackTrace(),null,3,"Messages",false);
            sendEvent(new ErrorMessage("Message Center Exception",type,"type: " + type + " error: " + e.message.toString(),null,e));
         }
      }
      
      public static function sendEvent(msg:Message) : void
      {
         var _loc4_:* = undefined;
         var foundNull:Boolean = false;
         var i:int = 0;
         if(Config.debugMode && !eventListeners.hasOwnProperty(msg.type) && checkLastType(msg.type))
         {
            LogUtils.log("sendEvent: No eventListener for type: " + msg.type,null,2,"Messages",false,false,false);
         }
         try
         {
            _loc4_ = eventListeners[msg.type];
            if(_loc4_)
            {
               for each(var func in _loc4_)
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
                  for(i = _loc4_.length - 1; i >= 0; )
                  {
                     if(_loc4_[i] == null)
                     {
                        _loc4_.splice(i,1);
                     }
                     i--;
                  }
               }
            }
         }
         catch(e:Error)
         {
            LogUtils.log(e.getStackTrace(),null,3,"Messages",true,true);
            if(msg)
            {
               sendEvent(new ErrorMessage("Message Center Exception",msg.type,"type: " + msg.type + " error: " + e.message.toString(),null,e));
            }
            else
            {
               sendEvent(new ErrorMessage("Message Center Exception","Unspecified","type: null error: " + e.message.toString(),null,e));
            }
         }
      }
      
      private static function checkLastType(type:String) : Boolean
      {
         var _loc2_:Boolean = lastMessageType != type;
         lastMessageType = type;
         return _loc2_;
      }
   }
}
