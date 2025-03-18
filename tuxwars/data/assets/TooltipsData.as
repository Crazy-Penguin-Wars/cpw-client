package tuxwars.data.assets
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class TooltipsData
   {
      private static const TABLE:String = "Tooltip";
      
      private static const CHALLENGE_TOP_TOOLTIP:String = "ChallengeTop";
      
      private static const CHALLENGE_BOTTOM_TOOLTIP:String = "ChallengeBottom";
      
      private static const GENERIC_TOOLTIP:String = "Generic";
      
      private static const ITEM:String = "Item";
      
      private static const WEAPON_TOOLTIP:String = "Weapon";
      
      private static const CLOTHES_TOOLTIP:String = "Clothes";
      
      private static const BOOSTER_TOOLTIP:String = "Booster";
      
      private static var table:Table;
      
      public function TooltipsData()
      {
         super();
         throw new Error("TooltipsData is a static class!");
      }
      
      public static function getTable() : Table
      {
         if(!table)
         {
            var _loc2_:String = "Tooltip";
            var _loc1_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc2_);
         }
         return table;
      }
      
      public static function getGenericTooltipGraphics() : GraphicsReference
      {
         var _loc2_:String = "Generic";
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache[_loc2_])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache[_loc2_] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache[_loc2_]);
      }
      
      public static function getChallengeTopTooltipGraphics() : GraphicsReference
      {
         var _loc2_:String = "ChallengeTop";
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache[_loc2_])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache[_loc2_] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache[_loc2_]);
      }
      
      public static function getChallengeBottomTooltipGraphics() : GraphicsReference
      {
         var _loc2_:String = "ChallengeBottom";
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache[_loc2_])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache[_loc2_] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache[_loc2_]);
      }
      
      public static function getWeaponTooltipGraphics() : GraphicsReference
      {
         var _loc2_:String = "Weapon";
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache[_loc2_])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache[_loc2_] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache[_loc2_]);
      }
      
      public static function getClothingTooltipGraphics() : GraphicsReference
      {
         var _loc2_:String = "Clothes";
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache[_loc2_])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache[_loc2_] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache[_loc2_]);
      }
      
      public static function getBoosterTooltipGraphics() : GraphicsReference
      {
         var _loc2_:String = "Booster";
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache[_loc2_])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache[_loc2_] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache[_loc2_]);
      }
      
      public static function getItemTooltipGraphics() : GraphicsReference
      {
         var _loc2_:String = "Item";
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache[_loc2_])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache[_loc2_] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache[_loc2_]);
      }
   }
}

