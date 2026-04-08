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
      
      public function loadDataConf(param1:CashPackageData) : void
      {
         this._id = param1.id;
         this._amount = param1.amount;
         this._creditCost = param1.creditCost;
         this._extraAmount = param1.extraAmount;
         this._sortPriority = param1.sortPriority;
         this._creditOld = param1.creditOld;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function get creditCost() : int
      {
         return this._creditCost;
      }
      
      public function get extraAmount() : int
      {
         return this._extraAmount;
      }
      
      public function get sortPriority() : int
      {
         return this._sortPriority;
      }
      
      public function get creditOld() : int
      {
         return this._creditOld;
      }
   }
}

