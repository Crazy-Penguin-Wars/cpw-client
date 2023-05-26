package tuxwars.items.data
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.items.references.PriceInfoReference;
   import tuxwars.items.references.SpecialReference;
   
   public class ItemData extends EquippableData
   {
      
      private static const PRICE_INFO:String = "PriceInfo";
      
      private static const UNLOCK_PRICE_PREMIUM:String = "UnlockPricePremium";
      
      private static const ICON:String = "Icon";
      
      private static const SPECIAL:String = "Special";
      
      public static const REQUIRED_LEVEL:String = "RequiredLevel";
      
      public static const AMOUNT_PURCHASED:String = "AmountPurchased";
      
      private static const DROP_RATIO:String = "DropRatio";
      
      private static const CATEGORY:String = "Category";
      
      private static const DEFAULT_VALUE:String = "CategoryDefault";
      
      private static const IS_VIP:String = "IsVip";
      
      private static const IS_NEW:String = "IsNew";
      
      private static const IS_SOLDOUT:String = "IsSoldOut";
      
      private static const TOOLTIP_POWER:String = "TooltipPower";
      
      private static const TOOLTIP_SKILL:String = "TooltipSkill";
       
      
      private var _dropRatio:int;
      
      public var _amount:int;
      
      public function ItemData(row:Row)
      {
         _dropRatio = -1;
         super(row);
      }
      
      public function get icon() : MovieClip
      {
         var _loc1_:* = null;
         if(iconRef)
         {
            _loc1_ = DCResourceManager.instance.getFromSWF(iconRef.swf,iconRef.export);
            if(_loc1_)
            {
               _loc1_.name = iconRef.export;
            }
            return _loc1_;
         }
         return null;
      }
      
      public function get requiredLevel() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RequiredLevel"])
         {
            _loc2_._cache["RequiredLevel"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RequiredLevel");
         }
         var _loc1_:Field = _loc2_._cache["RequiredLevel"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 1;
      }
      
      public function get priceInfoReference() : PriceInfoReference
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["PriceInfo"])
         {
            _loc2_._cache["PriceInfo"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","PriceInfo");
         }
         var _loc1_:Field = _loc2_._cache["PriceInfo"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new PriceInfoReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get amountPurchased() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["AmountPurchased"])
         {
            _loc2_._cache["AmountPurchased"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","AmountPurchased");
         }
         var _loc1_:Field = _loc2_._cache["AmountPurchased"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 1;
      }
      
      public function get tooltipPower() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["TooltipPower"])
         {
            _loc2_._cache["TooltipPower"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","TooltipPower");
         }
         var _loc1_:Field = _loc2_._cache["TooltipPower"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get tooltipPowerWord() : String
      {
         return ProjectManager.getText("WEAPON_TOOLTIP_POWER_" + Math.floor(tooltipPower / 10));
      }
      
      public function get tooltipSkill() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["TooltipSkill"])
         {
            _loc2_._cache["TooltipSkill"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","TooltipSkill");
         }
         var _loc1_:Field = _loc2_._cache["TooltipSkill"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get tooltipSkillWord() : String
      {
         return ProjectManager.getText("WEAPON_TOOLTIP_POWER_" + Math.floor(tooltipSkill / 10));
      }
      
      public function get unlockPricePremium() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["UnlockPricePremium"])
         {
            _loc2_._cache["UnlockPricePremium"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","UnlockPricePremium");
         }
         var _loc1_:Field = _loc2_._cache["UnlockPricePremium"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get iconRef() : GraphicsReference
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Icon"])
         {
            _loc2_._cache["Icon"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Icon");
         }
         var _loc1_:Field = _loc2_._cache["Icon"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new GraphicsReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get special() : SpecialReference
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Special"])
         {
            _loc2_._cache["Special"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Special");
         }
         var _loc1_:Field = _loc2_._cache["Special"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new SpecialReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get categories() : Array
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Category"])
         {
            _loc2_._cache["Category"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Category");
         }
         var _loc1_:Field = _loc2_._cache["Category"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get isNew() : Boolean
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["IsNew"])
         {
            _loc2_._cache["IsNew"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","IsNew");
         }
         var _loc1_:Field = _loc2_._cache["IsNew"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : false;
      }
      
      public function get isSoldOut() : Boolean
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["IsSoldOut"])
         {
            _loc2_._cache["IsSoldOut"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","IsSoldOut");
         }
         var _loc1_:Field = _loc2_._cache["IsSoldOut"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : false;
      }
      
      public function get isVip() : Boolean
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["IsVip"])
         {
            _loc2_._cache["IsVip"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","IsVip");
         }
         var _loc1_:Field = _loc2_._cache["IsVip"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : false;
      }
      
      public function set dropRatio(value:int) : void
      {
         _dropRatio = value;
      }
      
      public function get dropRatio() : int
      {
         var _loc1_:* = null;
         if(_dropRatio != -1)
         {
            return _dropRatio;
         }
         var _loc2_:Row = row;
         if(!_loc2_._cache["DropRatio"])
         {
            _loc2_._cache["DropRatio"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","DropRatio");
         }
         _loc1_ = _loc2_._cache["DropRatio"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function setAmount(value:int) : void
      {
         _amount = value;
      }
      
      public function getCategoryDefault() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["CategoryDefault"])
         {
            _loc2_._cache["CategoryDefault"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","CategoryDefault");
         }
         var _loc1_:Field = _loc2_._cache["CategoryDefault"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
   }
}
