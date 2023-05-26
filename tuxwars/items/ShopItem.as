package tuxwars.items
{
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import no.olog.utilfunctions.assert;
   import tuxwars.data.Tuner;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.data.challenges.ChallengesData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.TrophyData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.items.references.PriceObject;
   import tuxwars.items.references.StatBonusReference;
   
   public class ShopItem
   {
      
      private static const TT:String = "TT_";
       
      
      private const _placeholders:Array = [];
      
      private var _itemData:ItemData;
      
      public function ShopItem(itemData:ItemData)
      {
         super();
         assert("ItemData is null.",true,itemData != null);
         _itemData = itemData;
      }
      
      public function get id() : String
      {
         return _itemData.id;
      }
      
      public function get type() : String
      {
         return _itemData.type;
      }
      
      public function get icon() : MovieClip
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = undefined;
         var _loc1_:* = null;
         if(_itemData.iconRef == null)
         {
            _loc2_ = "No configured icon for shopItem: " + toString();
            _loc4_ = new Error();
            MessageCenter.sendEvent(new ErrorMessage("Item Error","icon1",_loc2_,id,_loc4_));
            return null;
         }
         _loc3_ = DCResourceManager.instance.getFromSWF(itemData.iconRef.swf,itemData.iconRef.export);
         if(!_loc3_)
         {
            if(!DCResourceManager.instance.isAddedToLoadingList(itemData.iconRef.swf))
            {
               DCResourceManager.instance.load(Config.getDataDir() + itemData.iconRef.swf,itemData.iconRef.swf);
            }
            _loc1_ = new MovieClip();
            _placeholders.push(_loc1_);
            LogUtils.log("Adding placeholder (count:" + _placeholders.length + ") for id: " + id,this,3,"Assets",false,false,false);
            DCResourceManager.instance.addCustomEventListener("complete",fileLoaded,itemData.iconRef.swf);
            DCResourceManager.instance.addCustomEventListener("error",error,itemData.iconRef.swf);
            _loc1_.name = "PLACEHOLDER_LOADING";
            return _loc1_;
         }
         return _loc3_;
      }
      
      private function fileLoaded(event:DCLoadingEvent) : void
      {
         var _loc3_:* = undefined;
         if(event && itemData && itemData.iconRef && itemData.iconRef.swf == event.resourceName && _placeholders.length > 0)
         {
            LogUtils.log("Replacing placeholder (count:" + _placeholders.length + ") for id: " + id,this,3,"Assets",false,false,false);
            DCResourceManager.instance.removeCustomEventListener("complete",fileLoaded,itemData.iconRef.swf);
            DCResourceManager.instance.removeCustomEventListener("error",error,itemData.iconRef.swf);
            for each(var mc in _placeholders)
            {
               _loc3_ = DCResourceManager.instance.getFromSWF(itemData.iconRef.swf,itemData.iconRef.export);
               if(_loc3_)
               {
                  DCUtils.replaceDisplayObject(mc,_loc3_);
               }
            }
            _placeholders.splice(0,_placeholders.length);
         }
      }
      
      private function error(event:DCLoadingEvent) : void
      {
         if(event)
         {
            LogUtils.log("Failed to replace placeholder (count:" + _placeholders.length + ") for id: " + id,this,3,"Assets",true,false,true);
            DCResourceManager.instance.removeCustomEventListener("complete",fileLoaded,itemData.iconRef.swf);
            DCResourceManager.instance.removeCustomEventListener("error",error,itemData.iconRef.swf);
         }
      }
      
      public function get sortPriority() : int
      {
         return _itemData.sortPriority;
      }
      
      public function get priceObject() : PriceObject
      {
         if(_itemData.priceInfoReference)
         {
            return _itemData.priceInfoReference.priceObject;
         }
         return null;
      }
      
      public function isFree() : Boolean
      {
         if(_itemData.priceInfoReference)
         {
            return _itemData.priceInfoReference.priceObject.priceValue == 0;
         }
         return true;
      }
      
      public function hasEarlyUnlock() : Boolean
      {
         if(_itemData.priceInfoReference)
         {
            return _itemData.priceInfoReference.unlockPricePremium > 0;
         }
         return false;
      }
      
      public function get unlockPrice() : int
      {
         if(_itemData.priceInfoReference)
         {
            return _itemData.priceInfoReference.unlockPricePremium;
         }
         return 999;
      }
      
      public function get popularitySortOrder() : int
      {
         if(_itemData.priceInfoReference)
         {
            return _itemData.priceInfoReference.popularitySortOrder;
         }
         return 0;
      }
      
      public function get requiredLevel() : int
      {
         return _itemData.requiredLevel;
      }
      
      public function get name() : String
      {
         return _itemData.name;
      }
      
      public function get description() : String
      {
         var s:* = null;
         var requierdChallenges:* = null;
         var _loc5_:* = null;
         var challengeData:* = null;
         if(_itemData && _itemData.type == "Trophy" && _itemData is TrophyData)
         {
            s = "";
            if((_itemData as TrophyData).statTextOverrideDesc != null)
            {
               s += (_itemData as TrophyData).statTextOverrideDesc;
            }
            requierdChallenges = "";
            _loc5_ = ProjectManager.getText("SEPARATOR");
            for each(var requierdChallenge in (_itemData as TrophyData).requiredChallenges)
            {
               challengeData = ChallengesData.getChallengeData(requierdChallenge);
               if(challengeData)
               {
                  requierdChallenges += ProjectManager.getText(challengeData.getTID());
                  if((_itemData as TrophyData).requiredChallenges.indexOf(requierdChallenge) < (_itemData as TrophyData).requiredChallenges.length - 1)
                  {
                     requierdChallenges += _loc5_;
                  }
               }
            }
            if(s.length == 0)
            {
               s += ProjectManager.getText("REQUIRED_CHALLENGE",[requierdChallenges]);
            }
            else
            {
               s += ". " + ProjectManager.getText("REQUIRED_CHALLENGE",[requierdChallenges]);
            }
            return s;
         }
         return _itemData.description;
      }
      
      public function get statBonuses() : StatBonusReference
      {
         return _itemData.statBonuses;
      }
      
      public function get slot() : String
      {
         return _itemData.slot;
      }
      
      public function isLevelLocked(level:int) : Boolean
      {
         return level < _itemData.requiredLevel && (!ItemManager.isUnlocked(id) || isTrophy());
      }
      
      public function isTrophy() : Boolean
      {
         return itemData is TrophyData;
      }
      
      public function toString() : String
      {
         return "<Id:" + _itemData.id + " levelReq:" + _itemData.requiredLevel + " " + (_itemData.priceInfoReference == null ? null : _itemData.priceInfoReference.toString()) + " icon:" + (_itemData.iconRef == null ? null : _itemData.iconRef.toString()) + ">";
      }
      
      public function get categoryDefault() : String
      {
         return _itemData.getCategoryDefault();
      }
      
      public function get categories() : Array
      {
         return _itemData.categories;
      }
      
      public function hasCategory(categoryId:String) : Boolean
      {
         return _itemData.categories.indexOf(categoryId) != -1;
      }
      
      public function get itemData() : ItemData
      {
         return _itemData;
      }
      
      public function get amountPurchased() : int
      {
         return _itemData.amountPurchased;
      }
      
      public function get isVip() : Boolean
      {
         return _itemData.isVip;
      }
      
      public function get isNew() : Boolean
      {
         return _itemData.isNew;
      }
      
      public function get isSoldOut() : Boolean
      {
         return _itemData.isSoldOut;
      }
      
      public function get showAmount() : Boolean
      {
         return _itemData.type == "Booster" || _itemData.type == "Crafting" || _itemData.type == "Weapon";
      }
      
      public function get canBuyMoreThanOnce() : Boolean
      {
         return showAmount;
      }
      
      public function get autoEquip() : Boolean
      {
         switch(_itemData.type)
         {
            case "Clothing":
            case "Customization":
               break;
            case "Trophy":
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function get size() : int
      {
         return 1;
      }
      
      public function get tag() : String
      {
         if(priceObject && priceObject.isSale)
         {
            return "tag_sale";
         }
         if(isVip)
         {
            return "tag_vip";
         }
         if(isNew)
         {
            return "tag_new";
         }
         return null;
      }
      
      public function get tooltipType() : String
      {
         var i:int = 0;
         var returnString:String = "";
         if(categories)
         {
            for(i = 0; i < categories.length; )
            {
               if(isTooltipType(categories[i]))
               {
                  returnString += ProjectManager.getText("TT_" + categories[i]);
                  if(i + 1 < categories.length)
                  {
                     returnString += ", ";
                  }
               }
               else if(i + 1 >= categories.length && returnString.charAt(returnString.length - 2) == ",")
               {
                  returnString = returnString.slice(0,returnString.length - 2);
               }
               i++;
            }
         }
         return returnString;
      }
      
      private function isTooltipType(category:String) : Boolean
      {
         var _loc2_:Tuner = Tuner;
         return tuxwars.data.Tuner.getField("NotTooltipType").value.indexOf(category) == -1;
      }
      
      public function get tooltipPower() : int
      {
         return itemData.tooltipPower;
      }
      
      public function get tooltipPowerWord() : String
      {
         return itemData.tooltipPowerWord;
      }
      
      public function get tooltipSkill() : int
      {
         return itemData.tooltipSkill;
      }
      
      public function get tooltipSkillWord() : String
      {
         return itemData.tooltipSkillWord;
      }
   }
}
