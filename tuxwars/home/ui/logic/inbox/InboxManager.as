package tuxwars.home.ui.logic.inbox
{
   import com.dchoc.messages.*;
   
   public class InboxManager
   {
      private static var skipFirst:Boolean = true;
      
      private static const _gifts:Vector.<RequestData> = new Vector.<RequestData>();
      
      private static const _neighborRequests:Vector.<RequestData> = new Vector.<RequestData>();
      
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
      
      public static function updateFromAccountInfo(param1:Object) : void
      {
         inboxUpdated(new Message("",param1));
      }
      
      private static function inboxUpdated(param1:Message) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(param1.data)
         {
            if(param1.data.incoming_gift_requests)
            {
               _gifts.splice(0,_gifts.length);
               for each(_loc2_ in param1.data.incoming_gift_requests)
               {
                  if(_loc2_ is Array)
                  {
                     for each(_loc3_ in _loc2_)
                     {
                        _gifts.push(new RequestData("Gifts_Default",_loc3_));
                     }
                  }
                  else
                  {
                     _gifts.push(new RequestData("Gifts_Default",_loc2_));
                  }
               }
            }
            if(param1.data.incoming_neighbor_requests)
            {
               _neighborRequests.splice(0,_neighborRequests.length);
               for each(_loc4_ in param1.data.incoming_neighbor_requests)
               {
                  if(_loc4_ is Array)
                  {
                     for each(_loc5_ in _loc4_)
                     {
                        addToNeighborRequest(new RequestData("Neighbor_Default",_loc5_));
                     }
                  }
                  else
                  {
                     addToNeighborRequest(new RequestData("Neighbor_Default",_loc4_));
                  }
               }
            }
            MessageCenter.sendMessage("InboxUpdateCounter",messageCount);
         }
      }
      
      private static function addToNeighborRequest(param1:RequestData) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in _neighborRequests)
         {
            if(_loc2_.senderID == param1.senderID)
            {
               return;
            }
         }
         _neighborRequests.push(param1);
      }
      
      public static function get messages() : Vector.<RequestData>
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc1_:Vector.<RequestData> = new Vector.<RequestData>();
         var _loc2_:Boolean = false;
         if(_neighborRequests.length > 0)
         {
            for each(_loc4_ in _neighborRequests)
            {
               if(_loc4_.state != "Done")
               {
                  _loc1_.push(_loc4_);
                  _loc2_ = true;
               }
            }
         }
         if(!_loc2_)
         {
            _loc1_.push(new RequestData("Neighbor_Empty",null));
         }
         var _loc3_:Boolean = false;
         if(_gifts.length > 0)
         {
            for each(_loc5_ in _gifts)
            {
               if(_loc5_.state != "Done")
               {
                  _loc1_.push(_loc5_);
                  _loc3_ = true;
               }
            }
         }
         if(!_loc3_)
         {
            _loc1_.push(new RequestData("Gifts_Empty",null));
         }
         return _loc1_;
      }
      
      public static function get messageCount() : int
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc1_:Vector.<RequestData> = new Vector.<RequestData>();
         var _loc2_:Vector.<RequestData> = new Vector.<RequestData>();
         for each(_loc3_ in _neighborRequests)
         {
            if(_loc3_.state != "New")
            {
               _loc1_.push(_loc3_);
            }
         }
         if(_loc1_.length > 0)
         {
            for each(_loc5_ in _loc1_)
            {
               _neighborRequests.splice(_neighborRequests.indexOf(_loc5_),1);
            }
         }
         for each(_loc4_ in _gifts)
         {
            if(_loc4_.state != "New")
            {
               _loc2_.push(_loc4_);
            }
         }
         if(_loc2_.length > 0)
         {
            for each(_loc6_ in _loc2_)
            {
               _gifts.splice(_gifts.indexOf(_loc6_),1);
            }
         }
         return _neighborRequests.length + _gifts.length;
      }
   }
}

