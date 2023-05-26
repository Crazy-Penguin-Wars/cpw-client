package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.crafting.CraftingLogic;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.RecipeData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class CraftingScreen extends TuxPageSubTabScreen
   {
       
      
      private const CRAFTING_SCREEN:String = "crafting_screen";
      
      private const TYPE:String = "Type";
      
      private const CONTENT_CRAFTING:String = "Content_Crafting";
      
      private const CONTENT_RESEARCH:String = "Content_Research";
      
      private var objectContainer:ObjectContainer;
      
      private var researchElement:ResearchElement;
      
      public function CraftingScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/crafting_screens.swf","crafting_screen"),CraftingLogic.getStaticData());
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         MessageCenter.addListener("ResearchIngridientsUpdated",updateObjectContainer);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         createScreen(false);
      }
      
      override public function createScreen(onlyChangeContent:Boolean) : void
      {
         cleanUp();
         super.createScreen(onlyChangeContent);
         if(contentMoveClip.name == "Content_Research")
         {
            researchElement = new ResearchElement(contentMoveClip,tuxGame);
         }
         initSubTabObjectContainer();
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         MessageCenter.removeListener("ResearchIngridientsUpdated",updateObjectContainer);
         cleanUp();
         super.dispose();
      }
      
      override public function cleanUp() : void
      {
         if(researchElement)
         {
            researchElement.dispose();
            researchElement = null;
         }
         if(objectContainer != null)
         {
            objectContainer.dispose();
         }
         objectContainer = null;
         super.cleanUp();
      }
      
      private function initSubTabObjectContainer() : void
      {
         var _loc2_:* = null;
         objectContainer = new ObjectContainer(contentMoveClip,_game,getSlotObject,"transition_slots_left","transition_slots_right",false);
         var _loc1_:Row = craftingLogic.getCurrentTab();
         if(_loc1_)
         {
            var _loc3_:* = _loc1_;
            if(!_loc3_._cache["Categorys"])
            {
               _loc3_._cache["Categorys"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Categorys");
            }
            _loc2_ = _loc3_._cache["Categorys"];
            var _loc4_:* = _loc1_;
            §§push(objectContainer);
            §§push(craftingLogic);
            if(!_loc4_._cache["Type"])
            {
               _loc4_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","Type");
            }
            var _loc5_:* = _loc4_._cache["Type"];
            var _loc6_:*;
            §§pop().init(§§pop().getItems(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value,_loc2_ != null ? (_loc6_ = _loc2_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : null),true);
         }
      }
      
      public function getSlotObject(slotIndex:int, object:*, design:MovieClip) : *
      {
         var _loc4_:* = null;
         if(contentMoveClip.name == "Content_Crafting")
         {
            return new RecipeContainers(slotIndex,ItemManager.getItemData((object as ShopItem).id) as RecipeData,design,this);
         }
         if(contentMoveClip.name == "Content_Research")
         {
            _loc4_ = new SlotElement(design,_game,object as ShopItem,this);
            if(_loc4_)
            {
               var _loc5_:Research = Research;
               §§push(_loc4_);
               if(!tuxwars.home.ui.screen.crafting.Research._instance)
               {
                  new tuxwars.home.ui.screen.crafting.Research();
               }
               §§pop().enabled = !tuxwars.home.ui.screen.crafting.Research._instance.ingredientsContainId((object as ShopItem).id);
            }
            return _loc4_;
         }
         return null;
      }
      
      public function updateObjectContainer(msg:Message) : void
      {
         var _loc3_:* = null;
         if(contentMoveClip.name == "Content_Research")
         {
            for each(var rc in objectContainer.getContainerForObjects())
            {
               _loc3_ = rc.shopItem.id;
               var _loc4_:Research = Research;
               §§push(rc);
               if(!tuxwars.home.ui.screen.crafting.Research._instance)
               {
                  new tuxwars.home.ui.screen.crafting.Research();
               }
               §§pop().enabled = !tuxwars.home.ui.screen.crafting.Research._instance.ingredientsContainId(_loc3_);
            }
         }
      }
      
      override public function updateSubTabContent(newTab:Row) : void
      {
         createScreen(true);
      }
      
      override public function updatePageContent(row:Row) : void
      {
         super.updatePageContent(row);
         createScreen(false);
      }
      
      private function get craftingLogic() : CraftingLogic
      {
         return logic;
      }
   }
}
