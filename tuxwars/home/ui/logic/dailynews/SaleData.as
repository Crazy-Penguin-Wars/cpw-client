package tuxwars.home.ui.logic.dailynews
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   
   public class SaleData
   {
      private var _itemId:String;
      
      private var _title:String;
      
      private var _time:int;
      
      private var _remainingTime:int;
      
      private var _action:String;
      
      private var _tooltipText:String;
      
      public function SaleData(param1:Object)
      {
         super();
         this._itemId = this.find(param1.actionButton.params as Array,"Id");
         this._title = param1.title;
         this._time = parseInt(this.find(param1.actionButton.params as Array,"Time"));
         this._action = param1.actionButton.action;
         this._tooltipText = param1.text;
         this._remainingTime = parseInt(this.find(param1.actionButton.params as Array,"TimeRemaining"));
      }
      
      public function get itemData() : ItemData
      {
         return ItemManager.getItemData(this.itemId);
      }
      
      public function get oldPrice() : int
      {
         return this.priceField.originalValue;
      }
      
      public function get newPrice() : int
      {
         var _loc1_:Field = this.priceField;
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : int(_loc1_._value);
      }
      
      public function get premium() : Boolean
      {
         return this.itemData.priceInfoReference.priceObject.isPremium;
      }
      
      public function get itemId() : String
      {
         return this._itemId;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get action() : String
      {
         return this._action;
      }
      
      public function get time() : int
      {
         return this._time;
      }
      
      private function get priceField() : Field
      {
         var _loc6_:Row = null;
         var _loc1_:String = "ItemPrice";
         var _loc2_:String = this.itemId;
         var _loc3_:* = ProjectManager.findTable(_loc1_);
         if(!_loc3_.getCache[_loc2_])
         {
            _loc6_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc6_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc6_;
         }
         var _loc4_:* = this.premium ? "Premium" : "InGame";
         var _loc5_:* = _loc3_.getCache[_loc2_];
         if(!_loc5_.getCache[_loc4_])
         {
            _loc5_.getCache[_loc4_] = DCUtils.find(_loc5_.getFields(),"name",_loc4_);
         }
         return _loc5_.getCache[_loc4_];
      }
      
      private function find(param1:Array, param2:String) : String
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1)
         {
            if(_loc3_.hasOwnProperty(param2))
            {
               return _loc3_[param2];
            }
         }
         return null;
      }
      
      public function get remainingTime() : int
      {
         return this._remainingTime;
      }
   }
}

