package tuxwars.items
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import no.olog.utilfunctions.*;
   import tuxwars.data.*;
   import tuxwars.data.challenges.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.items.references.PriceObject;
   import tuxwars.items.references.StatBonusReference;
   
   public class ShopItem
   {
      private static const TT:String = "TT_";
      
      private const _placeholders:Array = [];
      
      private var _itemData:ItemData;
      
      public function ShopItem(param1:ItemData)
      {
         super();
         assert("ItemData is null.",true,param1 != null);
         this._itemData = param1;
      }
      
      public function get id() : String
      {
         return this._itemData.id;
      }
      
      public function get type() : String
      {
         return this._itemData.type;
      }
      
      public function get icon() : MovieClip
      {
         var _loc1_:String = null;
         var _loc2_:Error = null;
         var _loc3_:* = undefined;
         var _loc4_:MovieClip = null;
         if(this._itemData.iconRef == null)
         {
            _loc1_ = "No configured icon for shopItem: " + this.toString();
            _loc2_ = new Error();
            MessageCenter.sendEvent(new ErrorMessage("Item Error","icon1",_loc1_,this.id,_loc2_));
            return null;
         }
         _loc3_ = DCResourceManager.instance.getFromSWF(this.itemData.iconRef.swf,this.itemData.iconRef.export);
         if(!_loc3_)
         {
            if(!DCResourceManager.instance.isAddedToLoadingList(this.itemData.iconRef.swf))
            {
               DCResourceManager.instance.load(Config.getDataDir() + this.itemData.iconRef.swf,this.itemData.iconRef.swf);
            }
            _loc4_ = new MovieClip();
            this._placeholders.push(_loc4_);
            LogUtils.log("Adding placeholder (count:" + this._placeholders.length + ") for id: " + this.id,this,3,"Assets",false,false,false);
            DCResourceManager.instance.addCustomEventListener("complete",this.fileLoaded,this.itemData.iconRef.swf);
            DCResourceManager.instance.addCustomEventListener("error",this.error,this.itemData.iconRef.swf);
            _loc4_.name = "PLACEHOLDER_LOADING";
            return _loc4_;
         }
         return _loc3_;
      }
      
      private function fileLoaded(param1:DCLoadingEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:* = undefined;
         if(param1 && this.itemData && this.itemData.iconRef && this.itemData.iconRef.swf == param1.resourceName && this._placeholders.length > 0)
         {
            LogUtils.log("Replacing placeholder (count:" + this._placeholders.length + ") for id: " + this.id,this,3,"Assets",false,false,false);
            DCResourceManager.instance.removeCustomEventListener("complete",this.fileLoaded,this.itemData.iconRef.swf);
            DCResourceManager.instance.removeCustomEventListener("error",this.error,this.itemData.iconRef.swf);
            for each(_loc3_ in this._placeholders)
            {
               _loc2_ = DCResourceManager.instance.getFromSWF(this.itemData.iconRef.swf,this.itemData.iconRef.export);
               if(_loc2_)
               {
                  DCUtils.replaceDisplayObject(_loc3_,_loc2_);
               }
            }
            this._placeholders.splice(0,this._placeholders.length);
         }
      }
      
      private function error(param1:DCLoadingEvent) : void
      {
         if(param1)
         {
            LogUtils.log("Failed to replace placeholder (count:" + this._placeholders.length + ") for id: " + this.id,this,3,"Assets",true,false,true);
            DCResourceManager.instance.removeCustomEventListener("complete",this.fileLoaded,this.itemData.iconRef.swf);
            DCResourceManager.instance.removeCustomEventListener("error",this.error,this.itemData.iconRef.swf);
         }
      }
      
      public function get sortPriority() : int
      {
         return this._itemData.sortPriority;
      }
      
      public function get priceObject() : PriceObject
      {
         if(this._itemData.priceInfoReference)
         {
            return this._itemData.priceInfoReference.priceObject;
         }
         return null;
      }
      
      public function isFree() : Boolean
      {
         if(this._itemData.priceInfoReference)
         {
            return this._itemData.priceInfoReference.priceObject.priceValue == 0;
         }
         return true;
      }
      
      public function hasEarlyUnlock() : Boolean
      {
         if(this._itemData.priceInfoReference)
         {
            return this._itemData.priceInfoReference.unlockPricePremium > 0;
         }
         return false;
      }
      
      public function get unlockPrice() : int
      {
         if(this._itemData.priceInfoReference)
         {
            return this._itemData.priceInfoReference.unlockPricePremium;
         }
         return 999;
      }
      
      public function get popularitySortOrder() : int
      {
         if(this._itemData.priceInfoReference)
         {
            return this._itemData.priceInfoReference.popularitySortOrder;
         }
         return 0;
      }
      
      public function get requiredLevel() : int
      {
         return this._itemData.requiredLevel;
      }
      
      public function get name() : String
      {
         return this._itemData.name;
      }
      
      public function get description() : String
      {
         var _loc5_:* = undefined;
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:ChallengeData = null;
         if(this._itemData && this._itemData.type == "Trophy" && this._itemData is TrophyData)
         {
            _loc1_ = "";
            if((this._itemData as TrophyData).statTextOverrideDesc != null)
            {
               _loc1_ += (this._itemData as TrophyData).statTextOverrideDesc;
            }
            _loc2_ = "";
            _loc3_ = ProjectManager.getText("SEPARATOR");
            for each(_loc5_ in (this._itemData as TrophyData).requiredChallenges)
            {
               _loc4_ = ChallengesData.getChallengeData(_loc5_);
               if(_loc4_)
               {
                  _loc2_ += ProjectManager.getText(_loc4_.getTID());
                  if((this._itemData as TrophyData).requiredChallenges.indexOf(_loc5_) < (this._itemData as TrophyData).requiredChallenges.length - 1)
                  {
                     _loc2_ += _loc3_;
                  }
               }
            }
            if(_loc1_.length == 0)
            {
               _loc1_ += ProjectManager.getText("REQUIRED_CHALLENGE",[_loc2_]);
            }
            else
            {
               _loc1_ += ". " + ProjectManager.getText("REQUIRED_CHALLENGE",[_loc2_]);
            }
            return _loc1_;
         }
         return this._itemData.description;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         return this._itemData.statBonuses;
      }
      
      public function get slot() : String
      {
         return this._itemData.slot;
      }
      
      public function isLevelLocked(param1:int) : Boolean
      {
         return param1 < this._itemData.requiredLevel && (!ItemManager.isUnlocked(this.id) || this.isTrophy());
      }
      
      public function isTrophy() : Boolean
      {
         return this.itemData is TrophyData;
      }
      
      public function toString() : String
      {
         return "<Id:" + this._itemData.id + " levelReq:" + this._itemData.requiredLevel + " " + (this._itemData.priceInfoReference == null ? null : this._itemData.priceInfoReference.toString()) + " icon:" + (this._itemData.iconRef == null ? null : this._itemData.iconRef.toString()) + ">";
      }
      
      public function get categoryDefault() : String
      {
         return this._itemData.getCategoryDefault();
      }
      
      public function get categories() : Array
      {
         return this._itemData.categories;
      }
      
      public function hasCategory(param1:String) : Boolean
      {
         return this._itemData.categories.indexOf(param1) != -1;
      }
      
      public function get itemData() : ItemData
      {
         return this._itemData;
      }
      
      public function get amountPurchased() : int
      {
         return this._itemData.amountPurchased;
      }
      
      public function get isVip() : Boolean
      {
         return this._itemData.isVip;
      }
      
      public function get isNew() : Boolean
      {
         return this._itemData.isNew;
      }
      
      public function get isSoldOut() : Boolean
      {
         return this._itemData.isSoldOut;
      }
      
      public function get showAmount() : Boolean
      {
         return this._itemData.type == "Booster" || this._itemData.type == "Crafting" || this._itemData.type == "Weapon";
      }
      
      public function get canBuyMoreThanOnce() : Boolean
      {
         return this.showAmount;
      }
      
      public function get autoEquip() : Boolean
      {
         switch(this._itemData.type)
         {
            case "Clothing":
            case "Customization":
            case "Trophy":
               return true;
            default:
               return false;
         }
      }
      
      public function get size() : int
      {
         return 1;
      }
      
      public function get tag() : String
      {
         if(Boolean(this.priceObject) && this.priceObject.isSale)
         {
            return "tag_sale";
         }
         if(this.isVip)
         {
            return "tag_vip";
         }
         if(this.isNew)
         {
            return "tag_new";
         }
         return null;
      }
      
      public function get tooltipType() : String
      {
         var _loc1_:int = 0;
         var _loc2_:* = "";
         if(this.categories)
         {
            _loc1_ = 0;
            while(_loc1_ < this.categories.length)
            {
               if(this.isTooltipType(this.categories[_loc1_]))
               {
                  _loc2_ += ProjectManager.getText("TT_" + this.categories[_loc1_]);
                  if(_loc1_ + 1 < this.categories.length)
                  {
                     _loc2_ += ", ";
                  }
               }
               else if(_loc1_ + 1 >= this.categories.length && _loc2_.charAt(_loc2_.length - 2) == ",")
               {
                  _loc2_ = _loc2_.slice(0,_loc2_.length - 2);
               }
               _loc1_++;
            }
         }
         return _loc2_;
      }
      
      private function isTooltipType(param1:String) : Boolean
      {
         return Tuner.getField("NotTooltipType").value.indexOf(param1) == -1;
      }
      
      public function get tooltipPower() : int
      {
         return this.itemData.tooltipPower;
      }
      
      public function get tooltipPowerWord() : String
      {
         return this.itemData.tooltipPowerWord;
      }
      
      public function get tooltipSkill() : int
      {
         return this.itemData.tooltipSkill;
      }
      
      public function get tooltipSkillWord() : String
      {
         return this.itemData.tooltipSkillWord;
      }
   }
}

