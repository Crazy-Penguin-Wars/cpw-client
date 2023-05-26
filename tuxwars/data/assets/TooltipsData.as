package tuxwars.data.assets
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
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
            var _loc1_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable("Tooltip");
         }
         return table;
      }
      
      public static function getGenericTooltipGraphics() : GraphicsReference
      {
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache["Generic"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","Generic");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Generic" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["Generic"] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache["Generic"]);
      }
      
      public static function getChallengeTopTooltipGraphics() : GraphicsReference
      {
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache["ChallengeTop"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","ChallengeTop");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "ChallengeTop" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["ChallengeTop"] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache["ChallengeTop"]);
      }
      
      public static function getChallengeBottomTooltipGraphics() : GraphicsReference
      {
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache["ChallengeBottom"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","ChallengeBottom");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "ChallengeBottom" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["ChallengeBottom"] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache["ChallengeBottom"]);
      }
      
      public static function getWeaponTooltipGraphics() : GraphicsReference
      {
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache["Weapon"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","Weapon");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Weapon" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["Weapon"] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache["Weapon"]);
      }
      
      public static function getClothingTooltipGraphics() : GraphicsReference
      {
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache["Clothes"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","Clothes");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Clothes" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["Clothes"] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache["Clothes"]);
      }
      
      public static function getBoosterTooltipGraphics() : GraphicsReference
      {
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache["Booster"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","Booster");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Booster" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["Booster"] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache["Booster"]);
      }
      
      public static function getItemTooltipGraphics() : GraphicsReference
      {
         var _loc1_:* = getTable();
         §§push(§§findproperty(GraphicsReference));
         if(!_loc1_._cache["Item"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","Item");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Item" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["Item"] = _loc3_;
         }
         return new §§pop().GraphicsReference(_loc1_._cache["Item"]);
      }
   }
}
