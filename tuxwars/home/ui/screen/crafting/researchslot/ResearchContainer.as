package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.home.ui.screen.crafting.*;
   import tuxwars.items.data.ItemData;
   import tuxwars.utils.*;
   
   public class ResearchContainer extends UIContainer
   {
      protected const ingredientSlots:Vector.<MovieClip>;
      
      protected const addedMovieClips:Object;
      
      private var resultSlotMC:MovieClip;
      
      private var resultSlotContainers:UIContainers;
      
      public function ResearchContainer(param1:MovieClip, param2:String, param3:String, param4:UIComponent = null)
      {
         var _loc7_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         this.ingredientSlots = new Vector.<MovieClip>();
         this.addedMovieClips = {};
         super(param1,param4);
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text") as TextField,param2);
         if(param1.getChildByName("Text_Description"))
         {
            TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Description") as TextField,param3);
         }
         _loc5_ = 0;
         while(_loc5_ < param1.numChildren)
         {
            for each(_loc7_ in param1)
            {
               if(_loc7_ is MovieClip && _loc7_.name && _loc7_.name.indexOf("Slot_0" + _loc5_) > -1)
               {
                  _loc6_ = (_loc7_ as MovieClip).getChildByName("Icon") as MovieClip;
                  if(_loc6_)
                  {
                     this.ingredientSlots.push(_loc6_);
                     break;
                  }
               }
            }
            _loc5_++;
         }
         if(!Research._instance)
         {
            new Research();
         }
         Research._instance.slots = this.ingredientSlots.length;
         this.resultSlotMC = param1.getChildByName("Container_Result") as MovieClip;
         this.resultSlotContainers = new UIContainers();
         if(!Research._instance)
         {
            new Research();
         }
         this.updateIconsInternal(Research._instance.currentIngredients);
         MessageCenter.addListener("ResearchIngridientsUpdated",this.updateIcons);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.resultSlotContainers.dispose();
         this.resultSlotContainers = null;
         this.clearSlots();
         MessageCenter.removeListener("ResearchIngridientsUpdated",this.updateIcons);
      }
      
      private function updateIcons(param1:Message) : void
      {
         this.updateIconsInternal(param1.data);
      }
      
      private function updateIconsInternal(param1:Vector.<ItemData>) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(Boolean(param1) && param1.length > 0)
         {
            _loc2_ = 0;
            for each(_loc4_ in this.ingredientSlots)
            {
               _loc3_ = this.addedMovieClips[_loc2_];
               if(param1.length > 0 && _loc2_ < param1.length && (_loc3_ == null || !_loc4_.contains(_loc3_)))
               {
                  _loc3_ = param1[_loc2_].icon;
                  this.addedMovieClips[_loc2_] = _loc3_;
                  _loc4_.addChild(_loc3_);
               }
               _loc2_++;
            }
            if(param1.length > this.ingredientSlots.length)
            {
               LogUtils.log("Less slots than Items!",this,2,"Research",false,false,true);
            }
         }
         else
         {
            this.clearSlots();
         }
      }
      
      override public function shown() : void
      {
         this.clearSlots();
         if(!Research._instance)
         {
            new Research();
         }
         this.updateIconsInternal(Research._instance.currentIngredients);
      }
      
      protected function clearSlots() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.ingredientSlots)
         {
            _loc1_ = this.addedMovieClips[_loc2_];
            if(_loc1_)
            {
               if(_loc3_.contains(_loc1_))
               {
                  _loc3_.removeChild(_loc1_);
               }
               delete this.addedMovieClips[_loc2_];
            }
            _loc2_++;
         }
      }
      
      public function get resultContainers() : UIContainers
      {
         return this.resultSlotContainers;
      }
      
      public function get resultMC() : MovieClip
      {
         return this.resultSlotMC;
      }
   }
}

