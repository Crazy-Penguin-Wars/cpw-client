package tuxwars.battle.ui.screen.boosterselection
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.boosterselection.*;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.home.ui.screen.shop.*;
   import tuxwars.items.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.containers.slotitem.*;
   
   public class BoosterSelectionScreen extends TuxPageSubTabScreen
   {
      private static const BOOSTER_SELECTION:String = "popup_choose_item";
      
      private static const BUTTON_CLOSE:String = "Button_Close";
      
      private static const TEXT_HEADER:String = "Text_Header";
      
      private const TYPE:String = "Type";
      
      private var _objectContainer:ObjectContainer;
      
      private var itemDetails:ItemDetailsElementScreen;
      
      private var darkBackground:DarkBackgroundElementWindow;
      
      public function BoosterSelectionScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","popup_choose_item"),BoosterSelectionLogic.getStaticData());
         this.darkBackground = new DarkBackgroundElementWindow(this._design,param1,"flash/ui/ingame.swf","ingame_hud",true);
         this.darkBackground.setVisible(true);
         this.itemDetails = new ItemDetailsElementScreen(contentMoveClip,param1);
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
         this.initSubTabObjectContainer();
         moneyResourceElementScreen.hideButtons();
      }
      
      override public function dispose() : void
      {
         this.cleanUp();
         this.darkBackground.dispose();
         super.dispose();
      }
      
      override public function cleanUp() : void
      {
         if(this._objectContainer != null)
         {
            this._objectContainer.dispose();
         }
         this._objectContainer = null;
         super.cleanUp();
      }
      
      private function initSubTabObjectContainer() : void
      {
         this._objectContainer = new ObjectContainer(contentMoveClip,_game,this.getButton,"transition_slots_left","transition_slots_right",false);
         var _loc1_:Row = this.boosterSelectionLogic.getCurrentTab();
         if(!_loc1_.getCache["Categorys"])
         {
            _loc1_.getCache["Categorys"] = DCUtils.find(_loc1_.getFields(),"name","Categorys");
         }
         var _loc2_:Field = _loc1_.getCache["Categorys"];
         if(!_loc1_.getCache["Type"])
         {
            _loc1_.getCache["Type"] = DCUtils.find(_loc1_.getFields(),"name","Type");
         }
         var _loc3_:Field = _loc1_.getCache["Type"];
         var _loc4_:* = !!_loc3_ ? (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
         var _loc5_:* = !!_loc2_ ? (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null;
         this._objectContainer.init(this.boosterSelectionLogic.getItems(_loc4_,_loc5_),true);
      }
      
      public function getButton(param1:int, param2:*, param3:MovieClip) : *
      {
         return new SlotElement(param3,_game,param2 as ShopItem,this,false);
      }
      
      override public function logicUpdate(param1:int) : void
      {
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
      
      public function setItemDetails(param1:ShopItem) : void
      {
         this.itemDetails.setItem(param1);
      }
      
      override protected function closeScreen(param1:MouseEvent) : void
      {
         this.boosterSelectionLogic.exit();
         this.boosterSelectionLogic.exit();
      }
      
      private function get boosterSelectionLogic() : BoosterSelectionLogic
      {
         return logic;
      }
      
      public function get objectContainer() : ObjectContainer
      {
         return this._objectContainer;
      }
   }
}

