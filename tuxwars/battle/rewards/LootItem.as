package tuxwars.battle.rewards
{
   public class LootItem
   {
      private var _id:String;
      
      private var _amount:int;
      
      public function LootItem(param1:String, param2:int = 1)
      {
         super();
         this._id = param1;
         this._amount = param2;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function set amount(param1:int) : void
      {
         this._amount = param1;
      }
   }
}

