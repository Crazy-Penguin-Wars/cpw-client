package tuxwars.battle.rewards
{
   public class LootItem
   {
       
      
      private var _id:String;
      
      private var _amount:int;
      
      public function LootItem(id:String, amount:int = 1)
      {
         super();
         _id = id;
         _amount = amount;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function set amount(value:int) : void
      {
         _amount = value;
      }
   }
}
