package tuxwars.items
{
   import com.dchoc.projectdata.Row;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   
   public class TournamentRewardItem
   {
       
      
      private var _type:String;
      
      private var _amount:int;
      
      private var _itemData:ItemData;
      
      public function TournamentRewardItem(data:*, amount:int)
      {
         super();
         _amount = amount;
         _itemData = null;
         if(data == "Cash" || data == "Coins" || data == "VIP" || data == "XP")
         {
            _type = data;
         }
         else if(data != null)
         {
            _type = "Item";
            if(data is Row)
            {
               _itemData = new ItemData(data as Row);
            }
            else
            {
               _itemData = ItemManager.getItemData(data);
            }
         }
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get itemData() : ItemData
      {
         return _itemData;
      }
      
      public function get name() : String
      {
         if(_type == "Item")
         {
            if(!_itemData)
            {
               return "";
            }
            return _itemData.name;
         }
         return _type;
      }
      
      public function get description() : String
      {
         if(_type == "Item")
         {
            if(!_itemData)
            {
               return "";
            }
            return _itemData.description;
         }
         return "" + _amount;
      }
   }
}
