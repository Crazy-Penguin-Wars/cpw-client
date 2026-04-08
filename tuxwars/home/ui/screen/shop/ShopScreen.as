package tuxwars.home.ui.screen.shop
{
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.home.ui.logic.shop.*;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.equipment.*;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.net.*;
   import tuxwars.ui.components.ObjectContainer;
   import tuxwars.ui.containers.shop.*;
   import tuxwars.ui.containers.shop.container.item.*;
   import tuxwars.ui.containers.shop.container.slot.*;
   import tuxwars.ui.popups.*;
   import tuxwars.ui.popups.states.freeammopackage.*;
   import tuxwars.utils.*;
   
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
      
      public function ShopScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/shops_new.swf","shop_screen_new"),ShopLogic.getStaticData());
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
         this._homeButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Home",this.homeCallback,"HOME");
         this._homeButton.setVisible(true);
         this._playButton = TuxUiUtils.createButton(UIButton,getDesignMovieClip(),"Button_Play",this.playAgainCallback,"PLAY_AGAIN");
         this._playButton.setVisible(true);
         if(Boolean(getDesignMovieClip().Content) && Boolean(getDesignMovieClip().Content.Content_Equipment))
         {
            this._characterAvatarScreen = new CharacterAvatarElementScreen(getDesignMovieClip().Content.Content_Equipment,param1);
            this._statsElement = new EquipmentStats(getDesignMovieClip().Content.Content_Equipment,param1);
         }
         else
         {
            LogUtils.log("Unable to construct _characterAvatarScreen or _statsElement because graphics missing",this,2,"UI",true,false,true);
         }
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this._playButton.setVisible(param1 is BattleResults);
         this._homeButton.setVisible(param1 is BattleResults);
         this.createScreen(false);
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
         this._objectContainer = ShopHelper.initSubTabObjectContainer(contentMoveClip,_loc2_,_game,this.getButton,this.shopLogic);
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
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(Boolean(this._characterAvatarScreen) && contentMoveClip.name == "Content_Equipment")
         {
            this._characterAvatarScreen.logicUpdate(param1);
         }
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         this.cleanUp();
         if(this._homeButton)
         {
            this._homeButton.dispose();
            this._homeButton = null;
         }
         if(this._playButton)
         {
            this._playButton.dispose();
            this._playButton = null;
         }
         if(this._characterAvatarScreen)
         {
            this._characterAvatarScreen.dispose();
            this._characterAvatarScreen = null;
         }
         if(this._statsElement)
         {
            this._statsElement.dispose();
            this._statsElement = null;
         }
         if(_game.player.ingameMoney < 50 && _game.player.premiumMoney < 5 && _game.player.inventory.getTotalAmountOfAmmo() < (!!_loc4_ ? _loc4_.value : 0))
         {
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.addPopup(new FreeAmmoPopUpSubState(tuxGame));
            if(!PopUpManager.instance)
            {
               PopUpManager.instance = new PopUpManager();
            }
            PopUpManager.instance.showPopUps(_game.homeState);
         }
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
      
      override public function updateSubTabContent(param1:Row) : void
      {
         this.createScreen(true);
      }
      
      override public function updatePageContent(param1:Row) : void
      {
         super.updatePageContent(param1);
         this.createScreen(false);
      }
      
      private function get shopLogic() : ShopLogic
      {
         return logic;
      }
      
      public function getObjectContainer() : ObjectContainer
      {
         return this._objectContainer;
      }
      
      private function homeCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PressHome");
         close();
      }
      
      private function playAgainCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Battle_Ended","Clicked","PressReplay");
         this.shopLogic.playAgain();
      }
      
      public function get homeButton() : UIButton
      {
         return this._homeButton;
      }
      
      public function get playButton() : UIButton
      {
         return this._playButton;
      }
      
      public function getCharacterAvatarScreen() : CharacterAvatarElementScreen
      {
         return this._characterAvatarScreen;
      }
      
      override public function set logic(param1:*) : void
      {
         super.logic = param1;
         if(this._characterAvatarScreen)
         {
            this._characterAvatarScreen.logic = this.shopLogic.characterAvatarLogic;
         }
      }
      
      override public function activateTutorial(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:* = undefined;
         super.activateTutorial(param1,param2,param3);
         this._homeButton.setEnabled(false);
         this._playButton.setEnabled(false);
         if(Boolean(this._objectContainer) && Boolean(this._objectContainer.getContainerForObjects()))
         {
            for each(_loc4_ in this._objectContainer.getContainerForObjects())
            {
               if(_loc4_ is IShopTutorial)
               {
                  (_loc4_ as IShopTutorial).activateTutorial(param1,param2,param3);
               }
            }
         }
      }
   }
}

