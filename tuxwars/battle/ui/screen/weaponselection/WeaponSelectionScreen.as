package tuxwars.battle.ui.screen.weaponselection
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.weaponselection.WeaponSelectionLogic;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.DarkBackgroundElementWindow;
   import tuxwars.home.ui.screen.shop.ItemDetailsElementScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.containers.slotitem.SlotElement;
   
   public class WeaponSelectionScreen extends TuxPageSubTabScreen
   {
      private static const WEAPON_SELECTION:String = "popup_choose_item";
      
      private static const BUTTON_CLOSE:String = "Button_Close";
      
      private static const TEXT_HEADER:String = "Text_Header";
      
      private static const TYPE:String = "Type";
      
      private var _objectContainer:ObjectContainer;
      
      private var itemDetails:ItemDetailsElementScreen;
      
      private var darkBackground:DarkBackgroundElementWindow;
      
      public function WeaponSelectionScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","popup_choose_item"),WeaponSelectionLogic.getStaticData());
         darkBackground = new DarkBackgroundElementWindow(this._design,game,"flash/ui/ingame.swf","ingame_hud",true);
         darkBackground.setVisible(true);
         itemDetails = new ItemDetailsElementScreen(contentMoveClip,game);
         ExternalInterface.call("console.log","[weaponSelectionScreen] create start");
      }
      
      public function get objectContainer() : ObjectContainer
      {
         return _objectContainer;
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
         ExternalInterface.call("console.log","[weaponSelectionScreen] dispose() start");
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
         var _loc2_:Row = weaponSelectionLogic.getCurrentTab();
         var _loc7_:String = "Categorys";
         var _loc3_:* = _loc2_;
         if(!_loc3_._cache[_loc7_])
         {
            _loc3_._cache[_loc7_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc7_);
         }
         var _loc1_:Field = _loc3_._cache[_loc7_];
         var _loc8_:String = "Type";
         var _loc4_:* = _loc2_;
         §§push(_objectContainer);
         §§push(weaponSelectionLogic);
         if(!_loc4_._cache[_loc8_])
         {
            _loc4_._cache[_loc8_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc8_);
         }
         var _loc5_:* = _loc4_._cache[_loc8_];
         var _loc6_:*;
         §§pop().init(§§pop().getItemsNoVIP(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value,!!_loc1_ ? (_loc6_ = _loc1_, _loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value) : null),true);
      }
      
      public function getButton(slotIndex:int, object:*, design:MovieClip) : *
      {
         return new SlotElement(design,_game,object as ShopItem,this,false);
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
         weaponSelectionLogic.exit();
      }
      
      private function get weaponSelectionLogic() : WeaponSelectionLogic
      {
         return logic;
      }
   }
}

