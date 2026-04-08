package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.data.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.player.Player;
   
   public class Research
   {
      private static var __instance:Research;
      
      private static const DEBUG_TO_CONSOLE:Boolean = false;
      
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
         if(!__instance)
         {
            this._canClear = true;
            this.ingridientSlots = 999;
            __instance = this;
         }
      }
      
      public static function get _instance() : Research
      {
         if(!__instance)
         {
            new Research();
         }
         return __instance;
      }
      
      public static function get instance() : Research
      {
         if(!__instance)
         {
            new Research();
         }
         return __instance;
      }
      
      public function load(param1:Object) : void
      {
         var _loc6_:* = undefined;
         var _loc2_:Array = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:int = int(param1.start_time);
         var _loc4_:int = int(param1.remaining_time);
         var _loc5_:String = param1.ingredients;
         if(this._currentIngredients.length > 0)
         {
            LogUtils.log("Reseach ongoing or not collected!",null,2,"Research",false,false,false);
            return;
         }
         if(Boolean(_loc5_) && _loc5_.length <= 0)
         {
            LogUtils.log("No ingridients given!",null,2,"Research",false,false,false);
            return;
         }
         _loc2_ = _loc5_.split(",");
         if(_loc2_.length <= 0)
         {
            LogUtils.log("No Ingredients for reseach! (after parse)",null,2,"Research",false,false,false);
            return;
         }
         for each(_loc6_ in _loc2_)
         {
            this.addIngridient(_loc6_);
         }
         if(this._currentIngredients.length <= 0)
         {
            LogUtils.log("No Ingredients for reseach! (after adding to array)",null,2,"Research",false,false,false);
            return;
         }
         this.setRemainingTime(_loc4_);
      }
      
      public function set slots(param1:int) : void
      {
         this.ingridientSlots = param1;
      }
      
      public function addIngridient(param1:String) : void
      {
         if(this._currentIngredients.length < this.ingridientSlots)
         {
            LogUtils.log("Adding ingredient: " + param1,null,0,"Research",false,false,false);
            this._currentIngredients.push(ItemManager.getItemData(param1));
            MessageCenter.sendMessage("ResearchIngridientsUpdated",this._currentIngredients);
         }
      }
      
      public function startResearch() : void
      {
         if(this._currentIngredients.length <= 0)
         {
            LogUtils.log("No Ingredients selected!",null,2,"Research",false,false,false);
         }
         else if(!this.hasTimeLeft && !this._completed && this._currentIngredients.length > 0)
         {
            this.setRemainingTime(Tuner.getField("ResearchDuration").value);
            MessageCenter.sendMessage("ResearchStart",this.currentIngredients);
         }
         else
         {
            LogUtils.log("Reseach ongoing or not collected!",null,2,"Research",false,false,false);
         }
      }
      
      public function completeResearch(param1:Player) : void
      {
         this.player = param1;
         if(!this.hasTimeLeft && Boolean(this._completed) && this._currentIngredients.length > 0)
         {
            this._canClear = true;
            MessageCenter.addListener("ResearchNoResult",this.noResult);
            MessageCenter.addListener("ResearchSuccess",this.success);
            if(this.instantReserchCompletionData == null)
            {
               MessageCenter.sendMessage("ResearchComplete",null);
            }
            else
            {
               if(this.instantReserchCompletionData.found_recipe_id != null)
               {
                  MessageCenter.sendMessage("ResearchSuccess",this.instantReserchCompletionData);
               }
               else
               {
                  MessageCenter.sendMessage("ResearchNoResult",this.instantReserchCompletionData);
               }
               this.cleanInstantResearchCompletionData();
            }
         }
         else
         {
            LogUtils.log("No ongoing research to collect!",null,2,"Research",false,false,false);
         }
      }
      
      private function removeCompleteReserchListeners() : void
      {
         MessageCenter.removeListener("ResearchNoResult",this.noResult);
         MessageCenter.removeListener("ResearchSuccess",this.success);
      }
      
      private function success(param1:Message) : void
      {
         this.removeCompleteReserchListeners();
         var _loc2_:Object = param1.data;
         var _loc3_:String = _loc2_.found_recipe_id;
         this.player.inventory.addItem(_loc3_);
         this.dispose();
         MessageCenter.sendMessage("ResearchUpdateScreen");
      }
      
      private function noResult(param1:Message) : void
      {
         this.removeCompleteReserchListeners();
         var _loc2_:Object = param1.data;
         var _loc3_:int = int(_loc2_.reward_coins);
         if(_loc3_ > 0)
         {
            this.player.addIngameMoney(_loc3_);
         }
         var _loc4_:int = int(_loc2_.reward_score);
         if(_loc4_ > 0)
         {
            this.player.addExp(_loc4_);
         }
         var _loc5_:int = int(_loc2_.reward_cash);
         if(_loc5_ > 0)
         {
            this.player.addPremiumMoney(_loc5_);
         }
         this.dispose();
         MessageCenter.sendMessage("ResearchUpdateScreen");
      }
      
      public function logicUpdate(param1:int) : void
      {
         this._remainingTime -= param1;
         if(!this.hasTimeLeft && !this._completed)
         {
            LogicUpdater.unregister(this);
            this._completed = true;
            MessageCenter.sendMessage("ResearchUpdateScreen");
         }
      }
      
      public function get hasTimeLeft() : Boolean
      {
         return this._remainingTime > 0;
      }
      
      public function get completed() : Boolean
      {
         return this._completed;
      }
      
      public function get currentIngredients() : Vector.<ItemData>
      {
         return this._currentIngredients;
      }
      
      public function get remainingTime() : int
      {
         return this.hasTimeLeft ? int(this._remainingTime) : 0;
      }
      
      public function instantComplete(param1:Object) : void
      {
         this._remainingTime = 0;
         this._instantReserchCompletionData = param1;
      }
      
      public function get instantReserchCompletionData() : Object
      {
         return this._instantReserchCompletionData;
      }
      
      public function cleanInstantResearchCompletionData() : void
      {
         this._instantReserchCompletionData = null;
      }
      
      private function setRemainingTime(param1:int) : void
      {
         this._canClear = false;
         this._completed = false;
         LogicUpdater.register(this);
         this._remainingTime = param1;
      }
      
      public function clearIngridients() : void
      {
         if(this._canClear)
         {
            LogUtils.log("Clearing Ingredients!","Research",0,"Research",false,false,false);
            this._currentIngredients.splice(0,this._currentIngredients.length);
            MessageCenter.sendMessage("ResearchIngridientsUpdated");
         }
      }
      
      private function dispose() : void
      {
         this.clearIngridients();
         this._completed = false;
         this._remainingTime = -1;
         LogicUpdater.unregister(this);
      }
      
      public function get receipe() : RecipeData
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<ItemData> = ItemManager.findItemDatas("Recipe");
         for each(_loc2_ in _loc1_)
         {
            if(this.isRecipe(_loc2_))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get isValidRecipe() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector.<ItemData> = ItemManager.findItemDatas("Recipe");
         for each(_loc2_ in _loc1_)
         {
            if(this.isRecipe(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      private function isRecipe(param1:RecipeData) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc2_ = false;
         var _loc3_:Array = param1.ingredients;
         var _loc4_:int = 0;
         var _loc5_:* = _loc3_;
         for each(_loc6_ in _loc5_)
         {
            _loc2_ = false;
            for each(_loc7_ in this._currentIngredients)
            {
               if(_loc7_.id == _loc6_)
               {
                  _loc2_ = true;
                  break;
               }
            }
         }
         return true;
      }
      
      public function ingredientsContainId(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this._currentIngredients)
         {
            if(_loc2_.id == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get failCoins() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for each(_loc2_ in this._currentIngredients)
         {
            _loc1_ += _loc2_.rewardCoins;
         }
         return _loc1_;
      }
      
      public function get failCash() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for each(_loc2_ in this._currentIngredients)
         {
            _loc1_ += _loc2_.rewardCash;
         }
         return _loc1_;
      }
      
      public function get failExp() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for each(_loc2_ in this._currentIngredients)
         {
            _loc1_ += _loc2_.rewardExp;
         }
         return _loc1_;
      }
   }
}

