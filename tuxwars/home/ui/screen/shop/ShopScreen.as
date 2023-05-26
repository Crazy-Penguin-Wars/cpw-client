package tuxwars.home.ui.screen.shop
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.data.Tuner;
   import tuxwars.home.ui.logic.shop.ShopLogic;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.equipment.EquipmentStats;
   import tuxwars.home.ui.screen.home.CharacterAvatarElementScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.net.CRMService;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.containers.shop.ContentSizeTwelve;
   import tuxwars.ui.containers.shop.IShopTutorial;
   import tuxwars.ui.containers.shop.container.item.ItemMegaPack;
   import tuxwars.ui.containers.shop.container.slot.SlotsBig;
   import tuxwars.ui.popups.PopUpManager;
   import tuxwars.ui.popups.states.freeammopackage.FreeAmmoPopUpSubState;
   import tuxwars.utils.TuxUiUtils;
   
   public class ShopScreen extends TuxPageSubTabScreen
   {
      
      public static const CONTENT_BUNDLES:String = "Content_Packs";
      
      public static const CONTENT_SUPPLIES:String = "Content_Supplies";
      
      public static const CONTENT_EQUIPMENT:String = "Content_Equipment";
      
      public static const SHOP_SCREEN:String = "shop_screen_new";
       
      
      private var _objectContainer:ObjectContainer;
      
      private var _homeButton:UIButton;
      
      private var _playButton:UIButton;
      
      private var _characterAvatarScreen:CharacterAvatarElementScreen;
      
      private var _statsElement:EquipmentStats;
      
      public function ShopScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/shops_new.swf","shop_screen_new"),ShopLogic.getStaticData());
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         _homeButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Home",homeCallback,"HOME");
         _homeButton.setVisible(true);
         _playButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Play",playAgainCallback,"PLAY_AGAIN");
         _playButton.setVisible(true);
         if(getDesignMovieClip().Content && getDesignMovieClip().Content.Content_Equipment)
         {
            _characterAvatarScreen = new CharacterAvatarElementScreen(getDesignMovieClip().Content.Content_Equipment,game);
            _statsElement = new EquipmentStats(getDesignMovieClip().Content.Content_Equipment,game);
         }
         else
         {
            LogUtils.log("Unable to construct _characterAvatarScreen or _statsElement because graphics missing",this,2,"UI",true,false,true);
         }
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         _playButton.setVisible(params is BattleResults);
         _homeButton.setVisible(params is BattleResults);
         createScreen(false);
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
         _objectContainer = ShopHelper.initSubTabObjectContainer(contentMoveClip,oldPage,_game,getButton,shopLogic);
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
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(_characterAvatarScreen && contentMoveClip.name == "Content_Equipment")
         {
            _characterAvatarScreen.logicUpdate(deltaTime);
         }
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         cleanUp();
         if(_homeButton)
         {
            _homeButton.dispose();
            _homeButton = null;
         }
         if(_playButton)
         {
            _playButton.dispose();
            _playButton = null;
         }
         if(_characterAvatarScreen)
         {
            _characterAvatarScreen.dispose();
            _characterAvatarScreen = null;
         }
         if(_statsElement)
         {
            _statsElement.dispose();
            _statsElement = null;
         }
         if(_game.player.ingameMoney < 50 && _game.player.premiumMoney < 5 && _game.player.inventory.getTotalAmountOfAmmo() < (!!_loc4_ ? _loc4_.value : 0))
         {
            var _loc2_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.addPopup(new FreeAmmoPopUpSubState(tuxGame));
            var _loc3_:PopUpManager = PopUpManager;
            if(!tuxwars.ui.popups.PopUpManager._instance)
            {
               tuxwars.ui.popups.PopUpManager._instance = new tuxwars.ui.popups.PopUpManager();
            }
            tuxwars.ui.popups.PopUpManager._instance.showPopUps(_game.homeState);
         }
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
      
      override public function updateSubTabContent(newTab:Row) : void
      {
         createScreen(true);
      }
      
      override public function updatePageContent(row:Row) : void
      {
         super.updatePageContent(row);
         createScreen(false);
      }
      
      private function get shopLogic() : ShopLogic
      {
         return logic;
      }
      
      public function getObjectContainer() : ObjectContainer
      {
         return _objectContainer;
      }
      
      private function homeCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PressHome");
         close();
      }
      
      private function playAgainCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PressReplay");
         shopLogic.playAgain();
      }
      
      public function get homeButton() : UIButton
      {
         return _homeButton;
      }
      
      public function get playButton() : UIButton
      {
         return _playButton;
      }
      
      public function getCharacterAvatarScreen() : CharacterAvatarElementScreen
      {
         return _characterAvatarScreen;
      }
      
      override public function set logic(logic:*) : void
      {
         super.logic = logic;
         if(_characterAvatarScreen)
         {
            _characterAvatarScreen.logic = shopLogic.characterAvatarLogic;
         }
      }
      
      override public function activateTutorial(itemID:String, arrow:String, addTutorialArrow:Function) : void
      {
         super.activateTutorial(itemID,arrow,addTutorialArrow);
         _homeButton.setEnabled(false);
         _playButton.setEnabled(false);
         if(_objectContainer && _objectContainer.getContainerForObjects())
         {
            for each(var cst in _objectContainer.getContainerForObjects())
            {
               if(cst is IShopTutorial)
               {
                  (cst as IShopTutorial).activateTutorial(itemID,arrow,addTutorialArrow);
               }
            }
         }
      }
   }
}
