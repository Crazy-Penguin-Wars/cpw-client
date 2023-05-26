package tuxwars.home.ui.logic.dailynews
{
   public class DailyNewsData
   {
       
      
      private const _addDatas:Vector.<AddData> = new Vector.<AddData>();
      
      private var _saleLeft:SaleData;
      
      private var _saleRight:SaleData;
      
      private var _shown:Boolean;
      
      public function DailyNewsData(data:Array)
      {
         super();
         parse(data);
         _shown = false;
      }
      
      public function get shown() : Boolean
      {
         return _shown;
      }
      
      public function set shown(shown:Boolean) : void
      {
         _shown = shown;
      }
      
      public function get saleLeft() : SaleData
      {
         return _saleLeft;
      }
      
      public function get saleRight() : SaleData
      {
         return _saleRight;
      }
      
      public function get addDatas() : Vector.<AddData>
      {
         return _addDatas;
      }
      
      private function parse(data:Array) : void
      {
         var _loc2_:Array = getAddData(data);
         for each(var add in _loc2_)
         {
            _addDatas.push(new AddData(add));
         }
         var _loc4_:Array = getSaleData(data);
         if(_loc4_.length > 0)
         {
            _saleLeft = new SaleData(_loc4_[0]);
         }
         if(_loc4_.length > 1)
         {
            _saleRight = new SaleData(_loc4_[1]);
         }
      }
      
      private function getAddData(data:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var obj in data)
         {
            if(obj.actionButton.action == "")
            {
               _loc2_.push(obj);
            }
         }
         return _loc2_;
      }
      
      private function getSaleData(data:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var obj in data)
         {
            if(obj.actionButton.action != "")
            {
               _loc2_.push(obj);
            }
         }
         return _loc2_;
      }
   }
}
