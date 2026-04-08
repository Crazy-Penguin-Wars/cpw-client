package tuxwars.home.ui.logic.dailynews
{
   public class DailyNewsData
   {
      private const _addDatas:Vector.<AddData> = new Vector.<AddData>();
      
      private var _saleLeft:SaleData;
      
      private var _saleRight:SaleData;
      
      private var _shown:Boolean;
      
      public function DailyNewsData(param1:Array)
      {
         super();
         this.parse(param1);
         this._shown = false;
      }
      
      public function get shown() : Boolean
      {
         return this._shown;
      }
      
      public function set shown(param1:Boolean) : void
      {
         this._shown = param1;
      }
      
      public function get saleLeft() : SaleData
      {
         return this._saleLeft;
      }
      
      public function get saleRight() : SaleData
      {
         return this._saleRight;
      }
      
      public function get addDatas() : Vector.<AddData>
      {
         return this._addDatas;
      }
      
      private function parse(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Array = null;
         var _loc2_:Array = this.getAddData(param1);
         for each(_loc3_ in _loc2_)
         {
            this._addDatas.push(new AddData(_loc3_));
         }
         _loc4_ = this.getSaleData(param1);
         if(_loc4_.length > 0)
         {
            this._saleLeft = new SaleData(_loc4_[0]);
         }
         if(_loc4_.length > 1)
         {
            this._saleRight = new SaleData(_loc4_[1]);
         }
      }
      
      private function getAddData(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(_loc3_.actionButton.action == "")
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function getSaleData(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(_loc3_.actionButton.action != "")
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

