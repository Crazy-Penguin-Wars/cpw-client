package tuxwars.money
{
   import tuxwars.data.money.CashPackageData;
   
   public class CashPackage
   {
       
      
      private var _id:String;
      
      private var _amount:int;
      
      private var _creditCost:int;
      
      private var _extraAmount:int;
      
      private var _sortPriority:int;
      
      private var _creditOld:int;
      
      public function CashPackage()
      {
         super();
      }
      
      public function loadDataConf(data:CashPackageData) : void
      {
         _id = data.id;
         _amount = data.amount;
         _creditCost = data.creditCost;
         _extraAmount = data.extraAmount;
         _sortPriority = data.sortPriority;
         _creditOld = data.creditOld;
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
      
      public function get creditOld() : int
      {
         return _creditOld;
      }
   }
}
