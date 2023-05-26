package tuxwars.home.ui.logic.inbox
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   
   public class InboxManager
   {
      
      private static const _gifts:Vector.<RequestData> = new Vector.<RequestData>();
      
      private static const _neighborRequests:Vector.<RequestData> = new Vector.<RequestData>();
      
      private static var skipFirst:Boolean = true;
       
      
      public function InboxManager()
      {
         super();
         throw new Error("InboxManager is a static class!");
      }
      
      public static function triggerContentUpdate() : void
      {
         if(!skipFirst)
         {
            MessageCenter.sendMessage("InboxUpdate");
         }
         skipFirst = false;
      }
      
      public static function init() : void
      {
         MessageCenter.addListener("InboxUpdated",inboxUpdated);
      }
      
      public static function updateFromAccountInfo(data:Object) : void
      {
         inboxUpdated(new Message("",data));
      }
      
      private static function inboxUpdated(msg:Message) : void
      {
         if(msg.data)
         {
            if(msg.data.incoming_gift_requests)
            {
               _gifts.splice(0,_gifts.length);
               for each(var gRequest in msg.data.incoming_gift_requests)
               {
                  if(gRequest is Array)
                  {
                     for each(var giftR in gRequest)
                     {
                        _gifts.push(new RequestData("Gifts_Default",giftR));
                     }
                  }
                  else
                  {
                     _gifts.push(new RequestData("Gifts_Default",gRequest));
                  }
               }
            }
            if(msg.data.incoming_neighbor_requests)
            {
               _neighborRequests.splice(0,_neighborRequests.length);
               for each(var nRequest in msg.data.incoming_neighbor_requests)
               {
                  if(nRequest is Array)
                  {
                     for each(var neighborR in nRequest)
                     {
                        addToNeighborRequest(new RequestData("Neighbor_Default",neighborR));
                     }
                  }
                  else
                  {
                     addToNeighborRequest(new RequestData("Neighbor_Default",nRequest));
                  }
               }
            }
            MessageCenter.sendMessage("InboxUpdateCounter",messageCount);
         }
      }
      
      private static function addToNeighborRequest(data:RequestData) : void
      {
         for each(var request in _neighborRequests)
         {
            if(request.senderID == data.senderID)
            {
               return;
            }
         }
         _neighborRequests.push(data);
      }
      
      public static function get messages() : Vector.<RequestData>
      {
         var messages:Vector.<RequestData> = new Vector.<RequestData>();
         var hadNeighborRequests:Boolean = false;
         if(_neighborRequests.length > 0)
         {
            for each(var nRequest in _neighborRequests)
            {
               if(nRequest.state != "Done")
               {
                  messages.push(nRequest);
                  hadNeighborRequests = true;
               }
            }
         }
         if(!hadNeighborRequests)
         {
            messages.push(new RequestData("Neighbor_Empty",null));
         }
         var hadGifts:Boolean = false;
         if(_gifts.length > 0)
         {
            for each(var gRequest in _gifts)
            {
               if(gRequest.state != "Done")
               {
                  messages.push(gRequest);
                  hadGifts = true;
               }
            }
         }
         if(!hadGifts)
         {
            messages.push(new RequestData("Gifts_Empty",null));
         }
         return messages;
      }
      
      public static function get messageCount() : int
      {
         var _removeNeighborRequests:Vector.<RequestData> = new Vector.<RequestData>();
         var _removeGiftRequests:Vector.<RequestData> = new Vector.<RequestData>();
         for each(var nRequest in _neighborRequests)
         {
            if(nRequest.state != "New")
            {
               _removeNeighborRequests.push(nRequest);
            }
         }
         if(_removeNeighborRequests.length > 0)
         {
            for each(var removeNRequest in _removeNeighborRequests)
            {
               _neighborRequests.splice(_neighborRequests.indexOf(removeNRequest),1);
            }
         }
         for each(var gRequest in _gifts)
         {
            if(gRequest.state != "New")
            {
               _removeGiftRequests.push(gRequest);
            }
         }
         if(_removeGiftRequests.length > 0)
         {
            for each(var removeGRequest in _removeGiftRequests)
            {
               _gifts.splice(_gifts.indexOf(removeGRequest),1);
            }
         }
         return _neighborRequests.length + _gifts.length;
      }
   }
}
