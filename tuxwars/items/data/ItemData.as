package tuxwars.items.data
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.items.references.*;
   
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
      
      private var _dropRatio:int = -1;
      
      public var _amount:int;
      
      public function ItemData(param1:Row)
      {
         super(param1);
      }
      
      public function get icon() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(this.iconRef)
         {
            _loc1_ = DCResourceManager.instance.getFromSWF(this.iconRef.swf,this.iconRef.export);
            if(_loc1_)
            {
               _loc1_.name = this.iconRef.export;
            }
            return _loc1_;
         }
         return null;
      }
      
      public function get requiredLevel() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "RequiredLevel";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 1;
      }
      
      public function get priceInfoReference() : PriceInfoReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "PriceInfo";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new PriceInfoReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get amountPurchased() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "AmountPurchased";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 1;
      }
      
      public function get tooltipPower() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "TooltipPower";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get tooltipPowerWord() : String
      {
         return ProjectManager.getText("WEAPON_TOOLTIP_POWER_" + Math.floor(this.tooltipPower / 10));
      }
      
      public function get tooltipSkill() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "TooltipSkill";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get tooltipSkillWord() : String
      {
         return ProjectManager.getText("WEAPON_TOOLTIP_POWER_" + Math.floor(this.tooltipSkill / 10));
      }
      
      public function get unlockPricePremium() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "UnlockPricePremium";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get iconRef() : GraphicsReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Icon";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new GraphicsReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get special() : SpecialReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Special";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new SpecialReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get categories() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Category";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get isNew() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "IsNew";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Boolean(_loc4_.overrideValue) : Boolean(_loc4_._value)) : false;
      }
      
      public function get isSoldOut() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "IsSoldOut";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Boolean(_loc4_.overrideValue) : Boolean(_loc4_._value)) : false;
      }
      
      public function get isVip() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "IsVip";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Boolean(_loc4_.overrideValue) : Boolean(_loc4_._value)) : false;
      }
      
      public function set dropRatio(param1:int) : void
      {
         this._dropRatio = param1;
      }
      
      public function get dropRatio() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:Field = null;
         if(this._dropRatio != -1)
         {
            return this._dropRatio;
         }
         var _loc2_:String = "DropRatio";
         var _loc3_:Row = row;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         _loc1_ = _loc3_.getCache[_loc2_];
         _loc4_ = _loc1_;
         return !!_loc1_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function setAmount(param1:int) : void
      {
         this._amount = param1;
      }
      
      public function getCategoryDefault() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "CategoryDefault";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
   }
}

