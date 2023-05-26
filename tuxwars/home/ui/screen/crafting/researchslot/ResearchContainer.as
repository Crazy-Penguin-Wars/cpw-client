package tuxwars.home.ui.screen.crafting.researchslot
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.ui.windows.UIContainers;
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.home.ui.screen.crafting.Research;
   import tuxwars.items.data.ItemData;
   import tuxwars.utils.TuxUiUtils;
   
   public class ResearchContainer extends UIContainer
   {
       
      
      protected const ingredientSlots:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      protected const addedMovieClips:Object = {};
      
      private var resultSlotMC:MovieClip;
      
      private var resultSlotContainers:UIContainers;
      
      public function ResearchContainer(design:MovieClip, titleTid:String, descriptionTid:String, parent:UIComponent = null)
      {
         var count:int = 0;
         var _loc5_:* = null;
         super(design,parent);
         TuxUiUtils.createAutoTextField(design.getChildByName("Text") as TextField,titleTid);
         if(design.getChildByName("Text_Description"))
         {
            TuxUiUtils.createAutoTextField(design.getChildByName("Text_Description") as TextField,descriptionTid);
         }
         count = 0;
         while(count < design.numChildren)
         {
            for each(var mc in design)
            {
               if(mc is MovieClip && mc.name && mc.name.indexOf("Slot_0" + count) > -1)
               {
                  _loc5_ = (mc as MovieClip).getChildByName("Icon") as MovieClip;
                  if(_loc5_)
                  {
                     ingredientSlots.push(_loc5_);
                     break;
                  }
               }
            }
            count++;
         }
         var _loc10_:Research = Research;
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         tuxwars.home.ui.screen.crafting.Research._instance.slots = ingredientSlots.length;
         resultSlotMC = design.getChildByName("Container_Result") as MovieClip;
         resultSlotContainers = new UIContainers();
         var _loc11_:Research = Research;
         §§push(§§findproperty(updateIconsInternal));
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         §§pop().updateIconsInternal(tuxwars.home.ui.screen.crafting.Research._instance.currentIngredients);
         MessageCenter.addListener("ResearchIngridientsUpdated",updateIcons);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         resultSlotContainers.dispose();
         resultSlotContainers = null;
         clearSlots();
         MessageCenter.removeListener("ResearchIngridientsUpdated",updateIcons);
      }
      
      private function updateIcons(msg:Message) : void
      {
         updateIconsInternal(msg.data);
      }
      
      private function updateIconsInternal(items:Vector.<ItemData>) : void
      {
         var count:int = 0;
         var icon:* = null;
         if(items && items.length > 0)
         {
            count = 0;
            for each(var mc in ingredientSlots)
            {
               icon = addedMovieClips[count];
               if(items.length > 0 && count < items.length && (icon == null || !mc.contains(icon)))
               {
                  icon = items[count].icon;
                  addedMovieClips[count] = icon;
                  mc.addChild(icon);
               }
               count++;
            }
            if(items.length > ingredientSlots.length)
            {
               LogUtils.log("Less slots than Items!",this,2,"Research",false,false,true);
            }
         }
         else
         {
            clearSlots();
         }
      }
      
      override public function shown() : void
      {
         clearSlots();
         var _loc1_:Research = Research;
         §§push(§§findproperty(updateIconsInternal));
         if(!tuxwars.home.ui.screen.crafting.Research._instance)
         {
            new tuxwars.home.ui.screen.crafting.Research();
         }
         §§pop().updateIconsInternal(tuxwars.home.ui.screen.crafting.Research._instance.currentIngredients);
      }
      
      protected function clearSlots() : void
      {
         var icon:* = null;
         var count:int = 0;
         for each(var mc in ingredientSlots)
         {
            icon = addedMovieClips[count];
            if(icon)
            {
               if(mc.contains(icon))
               {
                  mc.removeChild(icon);
               }
               delete addedMovieClips[count];
            }
            count++;
         }
      }
      
      public function get resultContainers() : UIContainers
      {
         return resultSlotContainers;
      }
      
      public function get resultMC() : MovieClip
      {
         return resultSlotMC;
      }
   }
}
