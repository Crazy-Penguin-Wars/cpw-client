package tuxwars.home.ui.logic.gifts
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.LogUtils;
   
   public class GiftManager
   {
      
      private static const GIFT_TABLE:String = "Gift";
      
      private static const _gifts:Vector.<GiftReference> = new Vector.<GiftReference>();
      
      private static const _giftsShow:Vector.<GiftReference> = new Vector.<GiftReference>();
       
      
      public function GiftManager()
      {
         super();
         throw new Error("GiftManager is a static class!");
      }
      
      public static function getGifts(reloadData:Boolean = false) : Vector.<GiftReference>
      {
         reload(reloadData);
         if(_gifts.length <= 0)
         {
            var _loc3_:* = com.dchoc.projectdata.ProjectManager.findTable("Gift");
            for each(var row in _loc3_._rows)
            {
               _gifts.push(new GiftReference(row));
            }
            _gifts.sort(sortByPriority);
         }
         return _gifts;
      }
      
      public static function getGiftsShow(reloadData:Boolean = false) : Vector.<GiftReference>
      {
         reload(reloadData);
         if(_giftsShow.length <= 0)
         {
            for each(var giftRef in getGifts(reloadData))
            {
               if(giftRef.show)
               {
                  _giftsShow.push(giftRef);
               }
            }
         }
         return _giftsShow;
      }
      
      public static function getGiftReference(id:String) : GiftReference
      {
         for each(var giftRef in getGifts())
         {
            if(id == giftRef.id)
            {
               return giftRef;
            }
         }
         LogUtils.log("No gift with ID: " + id + " found in gifts","GiftManager",2,"Gift",false,false,false);
         return null;
      }
      
      private static function sortByPriority(a:GiftReference, b:GiftReference) : int
      {
         if(a.sortPriority == b.sortPriority)
         {
            return 0;
         }
         if(a.sortPriority < b.sortPriority)
         {
            return -1;
         }
         return 1;
      }
      
      private static function reload(value:Boolean) : void
      {
         if(value)
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
         var _loc1_:ProjectManager = ProjectManager;
         return com.dchoc.projectdata.ProjectManager.projectData.findTable("Gift");
      }
      
      private static function getRow(id:String) : Row
      {
         var _loc4_:* = id;
         var _loc3_:* = com.dchoc.projectdata.ProjectManager.findTable("Gift");
         if(!_loc3_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc4_] = _loc5_;
         }
         var row:Row = _loc3_._cache[_loc4_];
         if(!row)
         {
            LogUtils.log("Couldn\'t for default row for BattleRewardConfig.",3);
         }
         return row;
      }
   }
}
