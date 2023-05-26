package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import tuxwars.data.Tuner;
   import tuxwars.items.data.CraftingData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.RecipeData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.player.Player;
   
   public class Research
   {
      
      private static const DEBUG_TO_CONSOLE:Boolean = false;
      
      private static var _instance:Research;
       
      
      private const _currentIngredients:Vector.<ItemData> = new Vector.<ItemData>();
      
      private var _remainingTime:int = -1;
      
      private var player:Player;
      
      private var ingridientSlots:int;
      
      private var _completed:Boolean;
      
      private var _canClear:Boolean;
      
      private var _instantReserchCompletionData:Object;
      
      public function Research()
      {
         super();
         if(!_instance)
         {
            _canClear = true;
            ingridientSlots = 999;
            _instance = this;
         }
      }
      
      public static function get instance() : Research
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      public function load(data:Object) : void
      {
         var items:* = null;
         if(!data)
         {
            return;
         }
         var _loc4_:int = int(data.start_time);
         var _loc3_:int = int(data.remaining_time);
         var _loc2_:String = data.ingredients;
         if(_currentIngredients.length > 0)
         {
            LogUtils.log("Reseach ongoing or not collected!",null,2,"Research",false,false,false);
            return;
         }
         if(_loc2_ && _loc2_.length <= 0)
         {
            LogUtils.log("No ingridients given!",null,2,"Research",false,false,false);
            return;
         }
         items = _loc2_.split(",");
         if(items.length <= 0)
         {
            LogUtils.log("No Ingredients for reseach! (after parse)",null,2,"Research",false,false,false);
            return;
         }
         for each(var itemId in items)
         {
            addIngridient(itemId);
         }
         if(_currentIngredients.length <= 0)
         {
            LogUtils.log("No Ingredients for reseach! (after adding to array)",null,2,"Research",false,false,false);
            return;
         }
         setRemainingTime(_loc3_);
      }
      
      public function set slots(value:int) : void
      {
         ingridientSlots = value;
      }
      
      public function addIngridient(itemId:String) : void
      {
         if(_currentIngredients.length < ingridientSlots)
         {
            LogUtils.log("Adding ingredient: " + itemId,null,0,"Research",false,false,false);
            _currentIngredients.push(ItemManager.getItemData(itemId));
            MessageCenter.sendMessage("ResearchIngridientsUpdated",_currentIngredients);
         }
      }
      
      public function startResearch() : void
      {
         if(_currentIngredients.length <= 0)
         {
            LogUtils.log("No Ingredients selected!",null,2,"Research",false,false,false);
         }
         else if(!hasTimeLeft && !_completed && _currentIngredients.length > 0)
         {
            var _loc1_:Tuner = Tuner;
            setRemainingTime(tuxwars.data.Tuner.getField("ResearchDuration").value);
            MessageCenter.sendMessage("ResearchStart",currentIngredients);
         }
         else
         {
            LogUtils.log("Reseach ongoing or not collected!",null,2,"Research",false,false,false);
         }
      }
      
      public function completeResearch(player:Player) : void
      {
         this.player = player;
         if(!hasTimeLeft && _completed && _currentIngredients.length > 0)
         {
            _canClear = true;
            MessageCenter.addListener("ResearchNoResult",noResult);
            MessageCenter.addListener("ResearchSuccess",success);
            if(instantReserchCompletionData == null)
            {
               MessageCenter.sendMessage("ResearchComplete",null);
            }
            else
            {
               if(instantReserchCompletionData.found_recipe_id != null)
               {
                  MessageCenter.sendMessage("ResearchSuccess",instantReserchCompletionData);
               }
               else
               {
                  MessageCenter.sendMessage("ResearchNoResult",instantReserchCompletionData);
               }
               cleanInstantResearchCompletionData();
            }
         }
         else
         {
            LogUtils.log("No ongoing research to collect!",null,2,"Research",false,false,false);
         }
      }
      
      private function removeCompleteReserchListeners() : void
      {
         MessageCenter.removeListener("ResearchNoResult",noResult);
         MessageCenter.removeListener("ResearchSuccess",success);
      }
      
      private function success(msg:Message) : void
      {
         removeCompleteReserchListeners();
         var _loc3_:Object = msg.data;
         var _loc2_:String = _loc3_.found_recipe_id;
         player.inventory.addItem(_loc2_);
         dispose();
         MessageCenter.sendMessage("ResearchUpdateScreen");
      }
      
      private function noResult(msg:Message) : void
      {
         removeCompleteReserchListeners();
         var _loc5_:Object = msg.data;
         var _loc3_:int = int(_loc5_.reward_coins);
         if(_loc3_ > 0)
         {
            player.addIngameMoney(_loc3_);
         }
         var _loc2_:int = int(_loc5_.reward_score);
         if(_loc2_ > 0)
         {
            player.addExp(_loc2_);
         }
         var _loc4_:int = int(_loc5_.reward_cash);
         if(_loc4_ > 0)
         {
            player.addPremiumMoney(_loc4_);
         }
         dispose();
         MessageCenter.sendMessage("ResearchUpdateScreen");
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         _remainingTime -= deltaTime;
         if(!hasTimeLeft && !_completed)
         {
            LogicUpdater.unregister(this);
            _completed = true;
            MessageCenter.sendMessage("ResearchUpdateScreen");
         }
      }
      
      public function get hasTimeLeft() : Boolean
      {
         return _remainingTime > 0;
      }
      
      public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function get currentIngredients() : Vector.<ItemData>
      {
         return _currentIngredients;
      }
      
      public function get remainingTime() : int
      {
         return hasTimeLeft ? _remainingTime : 0;
      }
      
      public function instantComplete(data:Object) : void
      {
         _remainingTime = 0;
         _instantReserchCompletionData = data;
      }
      
      public function get instantReserchCompletionData() : Object
      {
         return _instantReserchCompletionData;
      }
      
      public function cleanInstantResearchCompletionData() : void
      {
         _instantReserchCompletionData = null;
      }
      
      private function setRemainingTime(value:int) : void
      {
         _canClear = false;
         _completed = false;
         LogicUpdater.register(this);
         _remainingTime = value;
      }
      
      public function clearIngridients() : void
      {
         if(_canClear)
         {
            LogUtils.log("Clearing Ingredients!","Research",0,"Research",false,false,false);
            _currentIngredients.splice(0,_currentIngredients.length);
            MessageCenter.sendMessage("ResearchIngridientsUpdated");
         }
      }
      
      private function dispose() : void
      {
         clearIngridients();
         _completed = false;
         _remainingTime = -1;
         LogicUpdater.unregister(this);
      }
      
      public function get receipe() : RecipeData
      {
         var v:Vector.<ItemData> = ItemManager.findItemDatas("Recipe");
         for each(var r in v)
         {
            if(isRecipe(r))
            {
               return r;
            }
         }
         return null;
      }
      
      public function get isValidRecipe() : Boolean
      {
         var v:Vector.<ItemData> = ItemManager.findItemDatas("Recipe");
         for each(var r in v)
         {
            if(isRecipe(r))
            {
               return true;
            }
         }
         return false;
      }
      
      private function isRecipe(recipeData:RecipeData) : Boolean
      {
         var found:Boolean = false;
         var array:Array = recipeData.ingredients;
         var _loc9_:int = 0;
         var _loc8_:* = array;
         do
         {
            for each(var s in _loc8_)
            {
               found = false;
               for each(var c in _currentIngredients)
               {
                  if(c.id == s)
                  {
                     found = true;
                     break;
                  }
               }
            }
            return true;
         }
         while(found);
         
         return false;
      }
      
      public function ingredientsContainId(id:String) : Boolean
      {
         for each(var i in _currentIngredients)
         {
            if(i.id == id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get failCoins() : int
      {
         var coins:int = 0;
         for each(var c in _currentIngredients)
         {
            coins += c.rewardCoins;
         }
         return coins;
      }
      
      public function get failCash() : int
      {
         var cash:int = 0;
         for each(var c in _currentIngredients)
         {
            cash += c.rewardCash;
         }
         return cash;
      }
      
      public function get failExp() : int
      {
         var exp:int = 0;
         for each(var c in _currentIngredients)
         {
            exp += c.rewardExp;
         }
         return exp;
      }
   }
}
