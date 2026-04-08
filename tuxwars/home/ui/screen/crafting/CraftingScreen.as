package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.crafting.*;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.items.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.containers.slotitem.*;
   
   public class CraftingScreen extends TuxPageSubTabScreen
   {
      private const CRAFTING_SCREEN:String = "crafting_screen";
      
      private const TYPE:String = "Type";
      
      private const CONTENT_CRAFTING:String = "Content_Crafting";
      
      private const CONTENT_RESEARCH:String = "Content_Research";
      
      private var objectContainer:ObjectContainer;
      
      private var researchElement:ResearchElement;
      
      public function CraftingScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/crafting_screens.swf","crafting_screen"),CraftingLogic.getStaticData());
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         MessageCenter.addListener("ResearchIngridientsUpdated",this.updateObjectContainer);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.createScreen(false);
      }
      
      override public function createScreen(param1:Boolean) : void
      {
         this.cleanUp();
         super.createScreen(param1);
         if(contentMoveClip.name == "Content_Research")
         {
            this.researchElement = new ResearchElement(contentMoveClip,tuxGame);
         }
         this.initSubTabObjectContainer();
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         MessageCenter.removeListener("ResearchIngridientsUpdated",this.updateObjectContainer);
         this.cleanUp();
         super.dispose();
      }
      
      override public function cleanUp() : void
      {
         if(this.researchElement)
         {
            this.researchElement.dispose();
            this.researchElement = null;
         }
         if(this.objectContainer != null)
         {
            this.objectContainer.dispose();
         }
         this.objectContainer = null;
         super.cleanUp();
      }
      
      private function initSubTabObjectContainer() : void
      {
         var _loc2_:Field = null;
         var _loc3_:Field = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         this.objectContainer = new ObjectContainer(contentMoveClip,_game,this.getSlotObject,"transition_slots_left","transition_slots_right",false);
         var _loc1_:Row = this.craftingLogic.getCurrentTab();
         if(_loc1_)
         {
            if(!_loc1_.getCache["Categorys"])
            {
               _loc1_.getCache["Categorys"] = DCUtils.find(_loc1_.getFields(),"name","Categorys");
            }
            _loc2_ = _loc1_.getCache["Categorys"];
            if(!_loc1_.getCache["Type"])
            {
               _loc1_.getCache["Type"] = DCUtils.find(_loc1_.getFields(),"name","Type");
            }
            _loc3_ = _loc1_.getCache["Type"];
            _loc4_ = !!_loc3_ ? (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
            _loc5_ = !!_loc2_ ? (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
            this.objectContainer.init(this.craftingLogic.getItems(_loc4_,_loc5_),true);
         }
      }
      
      public function getSlotObject(param1:int, param2:*, param3:MovieClip) : *
      {
         var _loc4_:SlotElement = null;
         if(contentMoveClip.name == "Content_Crafting")
         {
            return new RecipeContainers(param1,ItemManager.getItemData((param2 as ShopItem).id) as RecipeData,param3,this);
         }
         if(contentMoveClip.name == "Content_Research")
         {
            _loc4_ = new SlotElement(param3,_game,param2 as ShopItem,this);
            if(!Research._instance)
            {
               new Research();
            }
            _loc4_.enabled = !Research._instance.ingredientsContainId((param2 as ShopItem).id);
            return _loc4_;
         }
         return null;
      }
      
      public function updateObjectContainer(param1:Message) : void
      {
         var _loc2_:* = undefined;
         if(contentMoveClip.name == "Content_Research")
         {
            if(!Research._instance)
            {
               new Research();
            }
            for each(_loc2_ in this.objectContainer.getContainerForObjects())
            {
               _loc2_.enabled = !Research._instance.ingredientsContainId(_loc2_.shopItem.id);
            }
         }
      }
      
      override public function updateSubTabContent(param1:Row) : void
      {
         this.createScreen(true);
      }
      
      override public function updatePageContent(param1:Row) : void
      {
         super.updatePageContent(param1);
         this.createScreen(false);
      }
      
      private function get craftingLogic() : CraftingLogic
      {
         return logic;
      }
   }
}

