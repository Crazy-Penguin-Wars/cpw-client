package tuxwars.home.ui.screen.equipment
{
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.equipment.EquipmentLogic;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.home.CharacterAvatarElementScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.home.ui.screen.shop.ShopHelper;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.containers.shop.ContentSizeTwelve;
   import tuxwars.ui.containers.shop.container.item.ItemMegaPack;
   import tuxwars.ui.containers.shop.container.slot.SlotsBig;
   import tuxwars.utils.TuxUiUtils;
   
   public class EquipmentScreen extends TuxPageSubTabScreen
   {
      
      private static const CONTENT_BUNDLES:String = "Content_Packs";
      
      private static const CONTENT_SUPPLIES:String = "Content_Supplies";
      
      private static const CONTENT_EQUIPMENT:String = "Content_Equipment";
      
      private static const SHOP_SCREEN:String = "shop_screen_new";
       
      
      private var _objectContainer:ObjectContainer;
      
      private var _characterAvatarScreen:CharacterAvatarElementScreen;
      
      private var _statsElement:EquipmentStats;
      
      public function EquipmentScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/shops_new.swf","shop_screen_new"),EquipmentLogic.getStaticData());
         _characterAvatarScreen = new CharacterAvatarElementScreen(contentMoveClip,game);
         _statsElement = new EquipmentStats(contentMoveClip,game);
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         var _loc2_:UIButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Home");
         _loc2_.setVisible(false);
         var _loc3_:UIButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Play");
         _loc3_.setVisible(false);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         createScreen(false);
      }
      
      override protected function closeScreen(event:MouseEvent) : void
      {
         equipmentLogic.exit();
         super.closeScreen(event);
      }
      
      override public function createScreen(onlyChangeContent:Boolean) : void
      {
         var oldPage:int = -1;
         if(onlyChangeContent && _objectContainer)
         {
            oldPage = _objectContainer.curPage;
         }
         cleanUp();
         super.createScreen(onlyChangeContent);
         _objectContainer = ShopHelper.initSubTabObjectContainer(contentMoveClip,oldPage,_game,getButton,equipmentLogic);
         if(_characterAvatarScreen)
         {
            if(contentMoveClip.name == "Content_Equipment")
            {
               _characterAvatarScreen.playMovieClip();
               if(_statsElement)
               {
                  _statsElement.playMovieClip();
               }
            }
            else
            {
               _characterAvatarScreen.stopMovieClip();
               if(_statsElement)
               {
                  _statsElement.stopMovieClip();
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         cleanUp();
         _characterAvatarScreen.dispose();
         _characterAvatarScreen = null;
         _statsElement.dispose();
         _statsElement = null;
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
      
      public function getButton(slotIndex:int, object:*, design:MovieClip) : *
      {
         if(contentMoveClip.name == "Content_Supplies")
         {
            return new ContentSizeTwelve(design,ShopHelper.sortingMagic(object),_game,this);
         }
         if(contentMoveClip.name == "Content_Equipment")
         {
            design.visible = true;
            return new SlotsBig(design.Slots,ShopHelper.sortingMagic(object),_game,2,this);
         }
         if(contentMoveClip.name == "Content_Packs")
         {
            return new ItemMegaPack(design,object,_game,this);
         }
         return null;
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         _characterAvatarScreen.logicUpdate(deltaTime);
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
      
      public function getCharacterAvatarScreen() : CharacterAvatarElementScreen
      {
         return _characterAvatarScreen;
      }
      
      public function getObjectContainer() : ObjectContainer
      {
         return _objectContainer;
      }
      
      override public function set logic(logic:*) : void
      {
         super.logic = logic;
         _characterAvatarScreen.logic = equipmentLogic.characterAvatarLogic;
      }
      
      private function get equipmentLogic() : EquipmentLogic
      {
         return logic;
      }
   }
}
