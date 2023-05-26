package tuxwars.battle.world.loader
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import org.as3commons.lang.StringUtils;
   import tuxwars.items.references.EmissionReference;
   
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
       
      
      private const _results:Array = [];
      
      private const _resultItems:Array = [];
      
      private var _resultItemsRandomized:Boolean;
      
      private var _resultItemsAmountRandomized:Boolean;
      
      private var _resultItemAmount:int;
      
      private var _emissions:Array;
      
      private var _followers:Array;
      
      public function LevelPowerUpResult(row:Row)
      {
         var emissionsField:Field;
         var eArray:Array;
         var followersField:Field;
         var fArray:Array;
         var itemNameField:Field;
         var itemRow:Row;
         var items:Array;
         var r:Row;
         super();
         var _loc2_:Row = row;
         §§push(_results);
         §§push(0);
         if(!_loc2_._cache["Heal"])
         {
            _loc2_._cache["Heal"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Heal");
         }
         var _loc3_:* = _loc2_._cache["Heal"];
         §§pop()[§§pop()] = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         var _loc4_:Row = row;
         §§push(_results);
         §§push(1);
         if(!_loc4_._cache["GivePoints"])
         {
            _loc4_._cache["GivePoints"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","GivePoints");
         }
         var _loc5_:* = _loc4_._cache["GivePoints"];
         §§pop()[§§pop()] = _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
         var _loc6_:Row = row;
         §§push(_results);
         §§push(2);
         if(!_loc6_._cache["GiveCoins"])
         {
            _loc6_._cache["GiveCoins"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","GiveCoins");
         }
         var _loc7_:* = _loc6_._cache["GiveCoins"];
         §§pop()[§§pop()] = _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
         var _loc8_:Row = row;
         if(!_loc8_._cache["Emitters"])
         {
            _loc8_._cache["Emitters"] = com.dchoc.utils.DCUtils.find(_loc8_._fields,"name","Emitters");
         }
         emissionsField = _loc8_._cache["Emitters"];
         if(emissionsField)
         {
            var _loc10_:Field = emissionsField;
            var _loc11_:Field;
            var _loc12_:Field;
            eArray = (_loc10_.overrideValue != null ? _loc10_.overrideValue : _loc10_._value) is Array ? (_loc11_ = emissionsField, (_loc11_.overrideValue != null ? _loc11_.overrideValue : _loc11_._value) as Array) : (_loc12_ = emissionsField, [_loc12_.overrideValue != null ? _loc12_.overrideValue : _loc12_._value]);
            _emissions = eArray.slice();
            _emissions.sort(function(row1:Row, row2:Row):int
            {
               return StringUtils.compareTo(row1.id,row2.id);
            });
         }
         var _loc13_:Row = row;
         if(!_loc13_._cache["Followers"])
         {
            _loc13_._cache["Followers"] = com.dchoc.utils.DCUtils.find(_loc13_._fields,"name","Followers");
         }
         followersField = _loc13_._cache["Followers"];
         if(followersField)
         {
            var _loc14_:Field = followersField;
            var _loc15_:Field;
            var _loc16_:Field;
            fArray = (_loc14_.overrideValue != null ? _loc14_.overrideValue : _loc14_._value) is Array ? (_loc15_ = followersField, (_loc15_.overrideValue != null ? _loc15_.overrideValue : _loc15_._value) as Array) : (_loc16_ = followersField, [_loc16_.overrideValue != null ? _loc16_.overrideValue : _loc16_._value]);
            _followers = fArray.slice();
            _followers.sort(function(row1:Row, row2:Row):int
            {
               return StringUtils.compareTo(row1.id,row2.id);
            });
         }
         var _loc17_:Row = row;
         if(!_loc17_._cache["GiveItem"])
         {
            _loc17_._cache["GiveItem"] = com.dchoc.utils.DCUtils.find(_loc17_._fields,"name","GiveItem");
         }
         itemNameField = _loc17_._cache["GiveItem"];
         if(itemNameField)
         {
            var _loc18_:Field = itemNameField;
            itemRow = _loc18_.overrideValue != null ? _loc18_.overrideValue : _loc18_._value;
            var _loc19_:Row = itemRow;
            if(!_loc19_._cache["RandomizeItems"])
            {
               _loc19_._cache["RandomizeItems"] = com.dchoc.utils.DCUtils.find(_loc19_._fields,"name","RandomizeItems");
            }
            var _loc20_:* = _loc19_._cache["RandomizeItems"];
            _resultItemsRandomized = _loc20_.overrideValue != null ? _loc20_.overrideValue : _loc20_._value;
            var _loc21_:Row = itemRow;
            if(!_loc21_._cache["Amount"])
            {
               _loc21_._cache["Amount"] = com.dchoc.utils.DCUtils.find(_loc21_._fields,"name","Amount");
            }
            var _loc22_:* = _loc21_._cache["Amount"];
            _resultItemAmount = _loc22_.overrideValue != null ? _loc22_.overrideValue : _loc22_._value;
            var _loc23_:Row = itemRow;
            if(!_loc23_._cache["RandomizeAmount"])
            {
               _loc23_._cache["RandomizeAmount"] = com.dchoc.utils.DCUtils.find(_loc23_._fields,"name","RandomizeAmount");
            }
            var _loc24_:* = _loc23_._cache["RandomizeAmount"];
            _resultItemsAmountRandomized = _loc24_.overrideValue != null ? _loc24_.overrideValue : _loc24_._value;
            var _loc25_:Row = itemRow;
            if(!_loc25_._cache["Items"])
            {
               _loc25_._cache["Items"] = com.dchoc.utils.DCUtils.find(_loc25_._fields,"name","Items");
            }
            var _loc26_:* = _loc25_._cache["Items"];
            if((_loc26_.overrideValue != null ? _loc26_.overrideValue : _loc26_._value) is Array)
            {
               var _loc27_:Row = itemRow;
               if(!_loc27_._cache["Items"])
               {
                  _loc27_._cache["Items"] = com.dchoc.utils.DCUtils.find(_loc27_._fields,"name","Items");
               }
               var _loc28_:* = _loc27_._cache["Items"];
               §§push(_loc28_.overrideValue != null ? _loc28_.overrideValue : _loc28_._value);
            }
            else
            {
               var _loc29_:Row = itemRow;
               if(!_loc29_._cache["Items"])
               {
                  _loc29_._cache["Items"] = com.dchoc.utils.DCUtils.find(_loc29_._fields,"name","Items");
               }
               var _loc30_:* = _loc29_._cache["Items"];
               §§push([_loc30_.overrideValue != null ? _loc30_.overrideValue : _loc30_._value]);
            }
            items = §§pop();
            for each(r in items)
            {
               _resultItems.push(r.id);
            }
         }
      }
      
      public function dispose() : void
      {
         _results.splice(0,_results.length);
         _resultItems.splice(0,_resultItems.length);
         if(_emissions)
         {
            _emissions.splice(0,_emissions.length);
         }
         _emissions = null;
         if(_followers)
         {
            _followers.splice(0,_followers.length);
         }
         _followers = null;
      }
      
      public function get resultHeal() : int
      {
         return _results[0];
      }
      
      public function get resultPoints() : int
      {
         return _results[1];
      }
      
      public function get resultCoins() : int
      {
         return _results[2];
      }
      
      public function get emissions() : Array
      {
         if(_emissions)
         {
            return EmissionReference.getEmissionReferences(_emissions);
         }
         return null;
      }
      
      public function get followers() : Array
      {
         return _followers;
      }
      
      public function get resultItems() : Array
      {
         return _resultItems;
      }
      
      public function get resultItemAmount() : int
      {
         return _resultItemAmount;
      }
      
      public function areResultItemsRandomized() : Boolean
      {
         return _resultItemsRandomized;
      }
      
      public function areResultItemsAmountRandomized() : Boolean
      {
         return _resultItemsAmountRandomized;
      }
   }
}
