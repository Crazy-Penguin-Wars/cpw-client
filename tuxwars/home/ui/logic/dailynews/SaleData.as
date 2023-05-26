package tuxwars.home.ui.logic.dailynews
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   
   public class SaleData
   {
       
      
      private var _itemId:String;
      
      private var _title:String;
      
      private var _time:int;
      
      private var _remainingTime:int;
      
      private var _action:String;
      
      private var _tooltipText:String;
      
      public function SaleData(data:Object)
      {
         super();
         _itemId = find(data.actionButton.params as Array,"Id");
         _title = data.title;
         _time = parseInt(find(data.actionButton.params as Array,"Time"));
         _action = data.actionButton.action;
         _tooltipText = data.text;
         _remainingTime = parseInt(find(data.actionButton.params as Array,"TimeRemaining"));
      }
      
      public function get itemData() : ItemData
      {
         return ItemManager.getItemData(itemId);
      }
      
      public function get oldPrice() : int
      {
         return priceField.originalValue;
      }
      
      public function get newPrice() : int
      {
         var _loc1_:Field = priceField;
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public function get premium() : Boolean
      {
         return itemData.priceInfoReference.priceObject.isPremium;
      }
      
      public function get itemId() : String
      {
         return _itemId;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get action() : String
      {
         return _action;
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      private function get priceField() : Field
      {
         var _loc1_:ProjectManager = ProjectManager;
         var _loc5_:String = itemId;
         var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("ItemPrice");
         if(!_loc2_._cache[_loc5_])
         {
            var _loc6_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc5_);
            if(!_loc6_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc5_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_._cache[_loc5_] = _loc6_;
         }
         var _loc3_:* = _loc2_._cache[_loc5_];
         if(!_loc3_._cache["Premium"])
         {
            _loc3_._cache["Premium"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Premium");
         }
         return _loc3_._cache["Premium"];
      }
      
      private function find(data:Array, str:String) : String
      {
         for each(var obj in data)
         {
            if(obj.hasOwnProperty(str))
            {
               return obj[str];
            }
         }
         return null;
      }
      
      public function get remainingTime() : int
      {
         return _remainingTime;
      }
   }
}
