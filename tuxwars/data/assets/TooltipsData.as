package tuxwars.data.assets
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class TooltipsData
   {
      private static var table:Table;
      
      private static const TABLE:String = "Tooltip";
      
      private static const CHALLENGE_TOP_TOOLTIP:String = "ChallengeTop";
      
      private static const CHALLENGE_BOTTOM_TOOLTIP:String = "ChallengeBottom";
      
      private static const GENERIC_TOOLTIP:String = "Generic";
      
      private static const ITEM:String = "Item";
      
      private static const WEAPON_TOOLTIP:String = "Weapon";
      
      private static const CLOTHES_TOOLTIP:String = "Clothes";
      
      private static const BOOSTER_TOOLTIP:String = "Booster";
      
      public function TooltipsData()
      {
         super();
         throw new Error("TooltipsData is a static class!");
      }
      
      public static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!table)
         {
            _loc1_ = "Tooltip";
            table = ProjectManager.findTable(_loc1_);
         }
         return table;
      }
      
      public static function getGenericTooltipGraphics() : GraphicsReference
      {
         var _loc3_:Row = null;
         var _loc1_:String = "Generic";
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return new GraphicsReference(_loc2_.getCache[_loc1_]);
      }
      
      public static function getChallengeTopTooltipGraphics() : GraphicsReference
      {
         var _loc3_:Row = null;
         var _loc1_:String = "ChallengeTop";
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return new GraphicsReference(_loc2_.getCache[_loc1_]);
      }
      
      public static function getChallengeBottomTooltipGraphics() : GraphicsReference
      {
         var _loc3_:Row = null;
         var _loc1_:String = "ChallengeBottom";
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return new GraphicsReference(_loc2_.getCache[_loc1_]);
      }
      
      public static function getWeaponTooltipGraphics() : GraphicsReference
      {
         var _loc3_:Row = null;
         var _loc1_:String = "Weapon";
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return new GraphicsReference(_loc2_.getCache[_loc1_]);
      }
      
      public static function getClothingTooltipGraphics() : GraphicsReference
      {
         var _loc3_:Row = null;
         var _loc1_:String = "Clothes";
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return new GraphicsReference(_loc2_.getCache[_loc1_]);
      }
      
      public static function getBoosterTooltipGraphics() : GraphicsReference
      {
         var _loc3_:Row = null;
         var _loc1_:String = "Booster";
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return new GraphicsReference(_loc2_.getCache[_loc1_]);
      }
      
      public static function getItemTooltipGraphics() : GraphicsReference
      {
         var _loc3_:Row = null;
         var _loc1_:String = "Item";
         var _loc2_:Table = getTable();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return new GraphicsReference(_loc2_.getCache[_loc1_]);
      }
   }
}

