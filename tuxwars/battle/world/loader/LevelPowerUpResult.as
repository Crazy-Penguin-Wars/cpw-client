package tuxwars.battle.world.loader
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import org.as3commons.lang.*;
   import tuxwars.items.references.*;
   
   public class LevelPowerUpResult
   {
      public static const RESULT_INDEX_HEAL:int = 0;
      
      public static const RESULT_INDEX_GIVE_POINTS:int = 1;
      
      public static const RESULT_INDEX_GIVE_COINS:int = 2;
      
      private static const RESULT_FIELD_NAME_HEAL:String = "Heal";
      
      private static const RESULT_FIELD_NAME_GIVE_ITEM:String = "GiveItem";
      
      private static const RESULT_FIELD_NAME_GIVE_POINTS:String = "GivePoints";
      
      private static const RESULT_FIELD_NAME_GIVE_COINS:String = "GiveCoins";
      
      private static const RESULT_FIELD_NAME_EMITTERS:String = "Emitters";
      
      private static const RESULT_FIELD_NAME_FOLLOWERS:String = "Followers";
      
      private static const GIVE_ITEM_FIELD_NAME_ITEMS:String = "Items";
      
      private static const GIVE_ITEM_FIELD_NAME_AMOUNT:String = "Amount";
      
      private static const GIVE_ITEM_FIELD_NAME_RANDOMIZE_ITEMS:String = "RandomizeItems";
      
      private static const GIVE_ITEM_FIELD_NAME_RANDOMIZE_AMOUNT:String = "RandomizeAmount";
      
      private const _results:Array;
      
      private const _resultItems:Array;
      
      private var _resultItemsRandomized:Boolean;
      
      private var _resultItemsAmountRandomized:Boolean;
      
      private var _resultItemAmount:int;
      
      private var _emissions:Array;
      
      private var _followers:Array;
      
      public function LevelPowerUpResult(param1:Row)
      {
         var healField:Field;
         var pointsField:Field;
         var coinsField:Field;
         var emissionsField:Field;
         var followersField:Field;
         var itemNameField:Field;
         var rawEm:* = undefined;
         var eArray:Array = null;
         var rawF:* = undefined;
         var fArray:Array = null;
         var itemRow:Row = null;
         var randItemsField:Field = null;
         var amountField:Field = null;
         var randAmountField:Field = null;
         var itemsField:Field = null;
         var rawItems:* = undefined;
         var items:Array = null;
         var r:Row = null;
         var row:Row = param1;
         super();
         this._results = [];
         this._resultItems = [];
         if(!row.getCache[RESULT_FIELD_NAME_HEAL])
         {
            row.getCache[RESULT_FIELD_NAME_HEAL] = DCUtils.find(row.getFields(),"name",RESULT_FIELD_NAME_HEAL);
         }
         healField = row.getCache[RESULT_FIELD_NAME_HEAL];
         this._results[RESULT_INDEX_HEAL] = !!healField ? (healField.overrideValue != null ? healField.overrideValue : healField._value) : 0;
         if(!row.getCache[RESULT_FIELD_NAME_GIVE_POINTS])
         {
            row.getCache[RESULT_FIELD_NAME_GIVE_POINTS] = DCUtils.find(row.getFields(),"name",RESULT_FIELD_NAME_GIVE_POINTS);
         }
         pointsField = row.getCache[RESULT_FIELD_NAME_GIVE_POINTS];
         this._results[RESULT_INDEX_GIVE_POINTS] = !!pointsField ? (pointsField.overrideValue != null ? pointsField.overrideValue : pointsField._value) : 0;
         if(!row.getCache[RESULT_FIELD_NAME_GIVE_COINS])
         {
            row.getCache[RESULT_FIELD_NAME_GIVE_COINS] = DCUtils.find(row.getFields(),"name",RESULT_FIELD_NAME_GIVE_COINS);
         }
         coinsField = row.getCache[RESULT_FIELD_NAME_GIVE_COINS];
         this._results[RESULT_INDEX_GIVE_COINS] = !!coinsField ? (coinsField.overrideValue != null ? coinsField.overrideValue : coinsField._value) : 0;
         if(!row.getCache[RESULT_FIELD_NAME_EMITTERS])
         {
            row.getCache[RESULT_FIELD_NAME_EMITTERS] = DCUtils.find(row.getFields(),"name",RESULT_FIELD_NAME_EMITTERS);
         }
         emissionsField = row.getCache[RESULT_FIELD_NAME_EMITTERS];
         if(emissionsField)
         {
            rawEm = emissionsField.overrideValue != null ? emissionsField.overrideValue : emissionsField._value;
            eArray = rawEm is Array ? rawEm as Array : [rawEm];
            this._emissions = eArray.slice();
            this._emissions.sort(function(param1:Row, param2:Row):int
            {
               return StringUtils.compareTo(param1.id,param2.id);
            });
         }
         if(!row.getCache[RESULT_FIELD_NAME_FOLLOWERS])
         {
            row.getCache[RESULT_FIELD_NAME_FOLLOWERS] = DCUtils.find(row.getFields(),"name",RESULT_FIELD_NAME_FOLLOWERS);
         }
         followersField = row.getCache[RESULT_FIELD_NAME_FOLLOWERS];
         if(followersField)
         {
            rawF = followersField.overrideValue != null ? followersField.overrideValue : followersField._value;
            fArray = rawF is Array ? rawF as Array : [rawF];
            this._followers = fArray.slice();
            this._followers.sort(function(param1:Row, param2:Row):int
            {
               return StringUtils.compareTo(param1.id,param2.id);
            });
         }
         if(!row.getCache[RESULT_FIELD_NAME_GIVE_ITEM])
         {
            row.getCache[RESULT_FIELD_NAME_GIVE_ITEM] = DCUtils.find(row.getFields(),"name",RESULT_FIELD_NAME_GIVE_ITEM);
         }
         itemNameField = row.getCache[RESULT_FIELD_NAME_GIVE_ITEM];
         if(itemNameField)
         {
            itemRow = itemNameField.overrideValue != null ? itemNameField.overrideValue : itemNameField._value;
            if(itemRow)
            {
               if(!itemRow.getCache[GIVE_ITEM_FIELD_NAME_RANDOMIZE_ITEMS])
               {
                  itemRow.getCache[GIVE_ITEM_FIELD_NAME_RANDOMIZE_ITEMS] = DCUtils.find(itemRow.getFields(),"name",GIVE_ITEM_FIELD_NAME_RANDOMIZE_ITEMS);
               }
               randItemsField = itemRow.getCache[GIVE_ITEM_FIELD_NAME_RANDOMIZE_ITEMS];
               this._resultItemsRandomized = !!randItemsField ? Boolean(randItemsField.overrideValue != null ? randItemsField.overrideValue : randItemsField._value) : false;
               if(!itemRow.getCache[GIVE_ITEM_FIELD_NAME_AMOUNT])
               {
                  itemRow.getCache[GIVE_ITEM_FIELD_NAME_AMOUNT] = DCUtils.find(itemRow.getFields(),"name",GIVE_ITEM_FIELD_NAME_AMOUNT);
               }
               amountField = itemRow.getCache[GIVE_ITEM_FIELD_NAME_AMOUNT];
               this._resultItemAmount = !!amountField ? int(amountField.overrideValue != null ? amountField.overrideValue : amountField._value) : 0;
               if(!itemRow.getCache[GIVE_ITEM_FIELD_NAME_RANDOMIZE_AMOUNT])
               {
                  itemRow.getCache[GIVE_ITEM_FIELD_NAME_RANDOMIZE_AMOUNT] = DCUtils.find(itemRow.getFields(),"name",GIVE_ITEM_FIELD_NAME_RANDOMIZE_AMOUNT);
               }
               randAmountField = itemRow.getCache[GIVE_ITEM_FIELD_NAME_RANDOMIZE_AMOUNT];
               this._resultItemsAmountRandomized = !!randAmountField ? Boolean(randAmountField.overrideValue != null ? randAmountField.overrideValue : randAmountField._value) : false;
               if(!itemRow.getCache[GIVE_ITEM_FIELD_NAME_ITEMS])
               {
                  itemRow.getCache[GIVE_ITEM_FIELD_NAME_ITEMS] = DCUtils.find(itemRow.getFields(),"name",GIVE_ITEM_FIELD_NAME_ITEMS);
               }
               itemsField = itemRow.getCache[GIVE_ITEM_FIELD_NAME_ITEMS];
               if(itemsField)
               {
                  rawItems = itemsField.overrideValue != null ? itemsField.overrideValue : itemsField._value;
                  items = rawItems is Array ? rawItems as Array : [rawItems];
                  for each(r in items)
                  {
                     this._resultItems.push(r.id);
                  }
               }
            }
         }
      }
      
      public function dispose() : void
      {
         this._results.splice(0,this._results.length);
         this._resultItems.splice(0,this._resultItems.length);
         if(this._emissions)
         {
            this._emissions.splice(0,this._emissions.length);
         }
         this._emissions = null;
         if(this._followers)
         {
            this._followers.splice(0,this._followers.length);
         }
         this._followers = null;
      }
      
      public function get resultHeal() : int
      {
         return this._results[0];
      }
      
      public function get resultPoints() : int
      {
         return this._results[1];
      }
      
      public function get resultCoins() : int
      {
         return this._results[2];
      }
      
      public function get emissions() : Array
      {
         if(this._emissions)
         {
            return EmissionReference.getEmissionReferences(this._emissions);
         }
         return null;
      }
      
      public function get followers() : Array
      {
         return this._followers;
      }
      
      public function get resultItems() : Array
      {
         return this._resultItems;
      }
      
      public function get resultItemAmount() : int
      {
         return this._resultItemAmount;
      }
      
      public function areResultItemsRandomized() : Boolean
      {
         return this._resultItemsRandomized;
      }
      
      public function areResultItemsAmountRandomized() : Boolean
      {
         return this._resultItemsAmountRandomized;
      }
   }
}

