package tuxwars.money
{
   import tuxwars.data.money.CoinPackageData;
   
   public class CoinPackage
   {
       
      
      private var _id:String;
      
      private var _amount:int;
      
      private var _creditCost:int;
      
      private var _extraAmount:int;
      
      private var _sortPriority:int;
      
      public function CoinPackage()
      {
         super();
      }
      
      public function loadDataConf(data:CoinPackageData) : void
      {
         _id = data.id;
         _amount = data.amount;
         _creditCost = data.creditCost;
         _extraAmount = data.extraAmount;
         _sortPriority = data.sortPriority;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get creditCost() : int
      {
         return _creditCost;
      }
      
      public function get extraAmount() : int
      {
         return _extraAmount;
      }
      
      public function get sortPriority() : int
      {
         return _sortPriority;
      }
   }
}
