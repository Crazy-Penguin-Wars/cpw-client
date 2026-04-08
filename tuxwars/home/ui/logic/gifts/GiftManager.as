package tuxwars.home.ui.logic.gifts
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class GiftManager
   {
      private static const GIFTtable:String = "Gift";
      
      private static const _gifts:Vector.<GiftReference> = new Vector.<GiftReference>();
      
      private static const _giftsShow:Vector.<GiftReference> = new Vector.<GiftReference>();
      
      public function GiftManager()
      {
         super();
         throw new Error("GiftManager is a static class!");
      }
      
      public static function getGifts(param1:Boolean = false) : Vector.<GiftReference>
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         reload(param1);
         if(_gifts.length <= 0)
         {
            _loc2_ = ProjectManager.findTable("Gift");
            for each(_loc3_ in _loc2_._rows)
            {
               _gifts.push(new GiftReference(_loc3_));
            }
            _gifts.sort(sortByPriority);
         }
         return _gifts;
      }
      
      public static function getGiftsShow(param1:Boolean = false) : Vector.<GiftReference>
      {
         var _loc2_:* = undefined;
         reload(param1);
         if(_giftsShow.length <= 0)
         {
            for each(_loc2_ in getGifts(param1))
            {
               if(_loc2_.show)
               {
                  _giftsShow.push(_loc2_);
               }
            }
         }
         return _giftsShow;
      }
      
      public static function getGiftReference(param1:String) : GiftReference
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in getGifts())
         {
            if(param1 == _loc2_.id)
            {
               return _loc2_;
            }
         }
         LogUtils.log("No gift with ID: " + param1 + " found in gifts","GiftManager",2,"Gift",false,false,false);
         return null;
      }
      
      private static function sortByPriority(param1:GiftReference, param2:GiftReference) : int
      {
         if(param1.sortPriority == param2.sortPriority)
         {
            return 0;
         }
         if(param1.sortPriority < param2.sortPriority)
         {
            return -1;
         }
         return 1;
      }
      
      private static function reload(param1:Boolean) : void
      {
         if(param1)
         {
            if(_gifts.length > 0)
            {
               _gifts.slice(0,_gifts.length);
            }
            if(_giftsShow.length > 0)
            {
               _giftsShow.slice(0,_giftsShow.length);
            }
         }
      }
      
      private static function get table() : Table
      {
         var _loc1_:String = "Gift";
         return ProjectManager.findTable(_loc1_);
      }
      
      private static function getRow(param1:String) : Row
      {
         var _loc5_:Row = null;
         var _loc2_:* = param1;
         var _loc3_:* = ProjectManager.findTable("Gift");
         if(!_loc3_.getCache[_loc2_])
         {
            _loc5_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc5_;
         }
         var _loc4_:Row = _loc3_.getCache[_loc2_];
         if(!_loc4_)
         {
            LogUtils.log("Couldn\'t for default row for BattleRewardConfig.",3);
         }
         return _loc4_;
      }
   }
}

