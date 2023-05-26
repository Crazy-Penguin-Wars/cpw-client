package tuxwars.battle.ui.screen.boosterselection
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.boosterselection.BoosterSelectionLogic;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.DarkBackgroundElementWindow;
   import tuxwars.home.ui.screen.shop.ItemDetailsElementScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class BoosterSelectionScreen extends TuxPageSubTabScreen
   {
      
      private static const BOOSTER_SELECTION:String = "popup_choose_item";
      
      private static const BUTTON_CLOSE:String = "Button_Close";
      
      private static const TEXT_HEADER:String = "Text_Header";
       
      
      private const TYPE:String = "Type";
      
      private var _objectContainer:ObjectContainer;
      
      private var itemDetails:ItemDetailsElementScreen;
      
      private var darkBackground:DarkBackgroundElementWindow;
      
      public function BoosterSelectionScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","popup_choose_item"),BoosterSelectionLogic.getStaticData());
         darkBackground = new DarkBackgroundElementWindow(this._design,game,"flash/ui/ingame.swf","ingame_hud",true);
         darkBackground.setVisible(true);
         itemDetails = new ItemDetailsElementScreen(contentMoveClip,game);
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
         initSubTabObjectContainer();
         moneyResourceElementScreen.hideButtons();
      }
      
      override public function dispose() : void
      {
         cleanUp();
         darkBackground.dispose();
         super.dispose();
      }
      
      override public function cleanUp() : void
      {
         if(_objectContainer != null)
         {
            _objectContainer.dispose();
         }
         _objectContainer = null;
         super.cleanUp();
      }
      
      private function initSubTabObjectContainer() : void
      {
         _objectContainer = new ObjectContainer(contentMoveClip,_game,getButton,"transition_slots_left","transition_slots_right",false);
         var _loc2_:Row = boosterSelectionLogic.getCurrentTab();
         var _loc3_:* = _loc2_;
         if(!_loc3_._cache["Categorys"])
         {
            _loc3_._cache["Categorys"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Categorys");
         }
         var _loc1_:Field = _loc3_._cache["Categorys"];
         var _loc4_:* = boosterSelectionLogic.getCurrentTab();
         §§push(_objectContainer);
         §§push(boosterSelectionLogic);
         if(!_loc4_._cache["Type"])
         {
            _loc4_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","Type");
         }
         var _loc5_:* = _loc4_._cache["Type"];
         var _loc6_:*;
         §§pop().init(§§pop().getItems(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value,!!_loc1_ ? (_loc6_ = _loc1_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : null),true);
      }
      
      public function getButton(slotIndex:int, object:*, design:MovieClip) : *
      {
         return new SlotElement(design,_game,object as ShopItem,this,false);
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
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
      
      public function setItemDetails(item:ShopItem) : void
      {
         itemDetails.setItem(item);
      }
      
      override protected function closeScreen(event:MouseEvent) : void
      {
         boosterSelectionLogic.exit();
      }
      
      private function get boosterSelectionLogic() : BoosterSelectionLogic
      {
         return logic;
      }
      
      public function get objectContainer() : ObjectContainer
      {
         return _objectContainer;
      }
   }
}
