package tuxwars.items
{
   import com.dchoc.projectdata.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   
   public class TournamentRewardItem
   {
      private var _type:String;
      
      private var _amount:int;
      
      private var _itemData:ItemData;
      
      public function TournamentRewardItem(param1:*, param2:int)
      {
         super();
         this._amount = param2;
         this._itemData = null;
         if(param1 == "Cash" || param1 == "Coins" || param1 == "VIP" || param1 == "XP")
         {
            this._type = param1;
         }
         else if(param1 != null)
         {
            this._type = "Item";
            if(param1 is Row)
            {
               this._itemData = new ItemData(param1 as Row);
            }
            else
            {
               this._itemData = ItemManager.getItemData(param1);
            }
         }
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function get itemData() : ItemData
      {
         return this._itemData;
      }
      
      public function get name() : String
      {
         if(this._type == "Item")
         {
            if(!this._itemData)
            {
               return "";
            }
            return this._itemData.name;
         }
         return this._type;
      }
      
      public function get description() : String
      {
         if(this._type == "Item")
         {
            if(!this._itemData)
            {
               return "";
            }
            return this._itemData.description;
         }
         return "" + this._amount;
      }
   }
}

