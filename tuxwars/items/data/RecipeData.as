package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.items.managers.*;
   
   public class RecipeData extends ItemData
   {
      private static const INGREDIENTS:String = "Ingredients";
      
      private static const RESULT:String = "Result";
      
      public function RecipeData(param1:Row)
      {
         super(param1);
      }
      
      public function get ingredients() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Ingredients";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get result() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Result";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      override public function get name() : String
      {
         var _loc1_:ItemData = null;
         var _loc2_:String = super.name;
         if(_loc2_ == null || _loc2_ == "")
         {
            _loc1_ = ItemManager.getItemData(this.result);
            if(_loc1_)
            {
               _loc2_ = _loc1_.name;
            }
         }
         return _loc2_;
      }
      
      override public function get description() : String
      {
         return ProjectManager.getText("RESEARCH_DEFAULT");
      }
   }
}

