package tuxwars.home.ui.screen.equipment
{
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.equipment.*;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.home.ui.screen.shop.*;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.containers.shop.container.item.*;
   import tuxwars.ui.containers.shop.container.slot.*;
   import tuxwars.utils.*;
   
   public class EquipmentScreen extends TuxPageSubTabScreen
   {
      private static const CONTENT_BUNDLES:String = "Content_Packs";
      
      private static const CONTENT_SUPPLIES:String = "Content_Supplies";
      
      private static const CONTENT_EQUIPMENT:String = "Content_Equipment";
      
      private static const SHOP_SCREEN:String = "shop_screen_new";
      
      private var _objectContainer:ObjectContainer;
      
      private var _characterAvatarScreen:CharacterAvatarElementScreen;
      
      private var _statsElement:EquipmentStats;
      
      public function EquipmentScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/shops_new.swf","shop_screen_new"),EquipmentLogic.getStaticData());
         this._characterAvatarScreen = new CharacterAvatarElementScreen(contentMoveClip,param1);
         this._statsElement = new EquipmentStats(contentMoveClip,param1);
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         var _loc2_:UIButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Home");
         _loc2_.setVisible(false);
         var _loc3_:UIButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Play");
         _loc3_.setVisible(false);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.createScreen(false);
      }
      
      override protected function closeScreen(param1:MouseEvent) : void
      {
         this.equipmentLogic.exit();
         super.closeScreen(param1);
      }
      
      override public function createScreen(param1:Boolean) : void
      {
         var _loc2_:int = -1;
         if(param1 && Boolean(this._objectContainer))
         {
            _loc2_ = int(this._objectContainer.curPage);
         }
         this.cleanUp();
         super.createScreen(param1);
         this._objectContainer = ShopHelper.initSubTabObjectContainer(contentMoveClip,_loc2_,_game,this.getButton,this.equipmentLogic);
         if(this._characterAvatarScreen)
         {
            if(contentMoveClip.name == "Content_Equipment")
            {
               this._characterAvatarScreen.playMovieClip();
               if(this._statsElement)
               {
                  this._statsElement.playMovieClip();
               }
            }
            else
            {
               this._characterAvatarScreen.stopMovieClip();
               if(this._statsElement)
               {
                  this._statsElement.stopMovieClip();
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         this.cleanUp();
         this._characterAvatarScreen.dispose();
         this._characterAvatarScreen = null;
         this._statsElement.dispose();
         this._statsElement = null;
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
      
      public function getButton(param1:int, param2:*, param3:MovieClip) : *
      {
         if(contentMoveClip.name == "Content_Supplies")
         {
            return new ContentSizeTwelve(param3,ShopHelper.sortingMagic(param2),_game,this);
         }
         if(contentMoveClip.name == "Content_Equipment")
         {
            param3.visible = true;
            return new SlotsBig(param3.Slots,ShopHelper.sortingMagic(param2),_game,2,this);
         }
         if(contentMoveClip.name == "Content_Packs")
         {
            return new ItemMegaPack(param3,param2,_game,this);
         }
         return null;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this._characterAvatarScreen.logicUpdate(param1);
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
      
      public function getCharacterAvatarScreen() : CharacterAvatarElementScreen
      {
         return this._characterAvatarScreen;
      }
      
      public function getObjectContainer() : ObjectContainer
      {
         return this._objectContainer;
      }
      
      override public function set logic(param1:*) : void
      {
         super.logic = param1;
         this._characterAvatarScreen.logic = this.equipmentLogic.characterAvatarLogic;
      }
      
      private function get equipmentLogic() : EquipmentLogic
      {
         return logic;
      }
   }
}

