package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.items.managers.ItemManager;
   
   public class RecipeData extends ItemData
   {
      private static const INGREDIENTS:String = "Ingredients";
      
      private static const RESULT:String = "Result";
      
      public function RecipeData(row:Row)
      {
         super(row);
      }
      
      public function get ingredients() : Array
      {
         var _loc4_:String = "Ingredients";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get result() : String
      {
         var _loc4_:String = "Result";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      override public function get name() : String
      {
         var itemData:ItemData = null;
         var itemName:String = super.name;
         if(itemName == null || itemName == "")
         {
            itemData = ItemManager.getItemData(result);
            if(itemData)
            {
               itemName = itemData.name;
            }
         }
         return itemName;
      }
      
      override public function get description() : String
      {
         return ProjectManager.getText("RESEARCH_DEFAULT");
      }
   }
}

