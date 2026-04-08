package tuxwars.battle.ui.logic
{
   import com.dchoc.avatar.*;
   import com.dchoc.gameobjects.*;
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.ui.BattleHud;
   import tuxwars.battle.ui.logic.chat.*;
   import tuxwars.battle.ui.screen.BattleHudScreen;
   import tuxwars.battle.ui.states.*;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   import tuxwars.utils.*;
   
   public class BattleHudLogic extends TuxUILogic implements IBattleHudLogic
   {
      public static const PLAYER:String = "Player_";
      
      public static const MAX_PLAYERS:int = 4;
      
      private var playersData:Object;
      
      private var hudState:BattleHud;
      
      private var chatLogic:ChatLogic;
      
      public function BattleHudLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         this.chatLogic = new ChatLogic(param1,param2);
         this.createPlayerData();
         MessageCenter.addListener("PlayerRemoved",this.playerRemoved);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.hudState = param1;
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("PlayerRemoved",this.playerRemoved);
         this.chatLogic.dispose();
         this.chatLogic = null;
         super.dispose();
      }
      
      override public function set screen(param1:*) : void
      {
         super.screen = param1;
         this.chatLogic.screen = param1.chatElementScreen;
      }
      
      public function getChatLogic() : ChatLogic
      {
         return this.chatLogic;
      }
      
      public function getHudPlayersData() : Object
      {
         return this.playersData;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this.updatePlayers();
      }
      
      public function get battleHudScreen() : BattleHudScreen
      {
         return screen;
      }
      
      public function showWeaponSelection() : void
      {
         this.hudState.changeState(new HUDWeaponSelectionSubState(game));
      }
      
      public function showBoosterSelection() : void
      {
         this.hudState.changeState(new HUDBoosterSelectionSubState(game));
      }
      
      private function createPlayerData() : void
      {
         var _loc1_:int = 0;
         this.playersData = {};
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            this.playersData["Player_" + _loc1_] = new BattleHudPlayerData();
            _loc1_++;
         }
         this.updatePlayers();
      }
      
      private function updatePlayers() : void
      {
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:PlayerGameObject = null;
         var _loc3_:BattleHudPlayerData = null;
         var _loc4_:TuxAvatar = null;
         var _loc5_:Object = null;
         var _loc6_:TuxAvatar = null;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:Array = game.tuxWorld.players;
         var _loc11_:Array = TuxUiUtils.getPlayersSortedByScore(_loc10_);
         var _loc12_:int = BattleManager.getCurrentActivePlayerIndex() + 1;
         var _loc13_:int = Math.min(4,_loc10_.length);
         _loc1_ = 1;
         while(_loc1_ <= _loc13_)
         {
            _loc2_ = _loc10_[_loc1_ - 1];
            _loc3_ = this.playersData["Player_" + _loc2_.getTabIndex()];
            _loc3_.tabIndex = _loc2_.getTabIndex();
            if(_loc2_)
            {
               if(_loc1_ == _loc12_)
               {
                  _loc3_.status = "Active";
               }
               else
               {
                  _loc3_.status = "Idle";
               }
               _loc14_ = GameObject(_loc2_);
               if(_loc3_.name != _loc14_._name)
               {
                  _loc15_ = GameObject(_loc2_);
                  _loc3_.name = _loc15_._name;
               }
               if(!_loc3_.avatar)
               {
                  _loc4_ = new TuxAvatar(Players.getPlayerData().graphics.swf);
                  _loc4_.animate(new AvatarAnimation("idle"));
                  _loc4_.paperDoll.animation.clip.stop();
                  _loc4_.paperDoll.animation.clip.cacheAsBitmap = true;
                  _loc5_ = _loc2_.wornItemsContainer.getWornItems();
                  for each(_loc16_ in _loc5_)
                  {
                     if(_loc16_ != null)
                     {
                        _loc4_.wearClothing(_loc16_);
                     }
                  }
                  _loc3_.avatar = _loc4_;
                  _loc6_ = new TuxAvatar(Players.getPlayerData().graphics.swf);
                  _loc6_.animate(new AvatarAnimation("idle"));
                  _loc6_.flip();
                  for each(_loc17_ in _loc5_)
                  {
                     if(_loc17_)
                     {
                        _loc6_.wearClothing(_loc17_);
                     }
                  }
                  _loc3_.avatarTimer = _loc6_;
               }
               _loc3_.score = _loc2_.getScore();
               _loc3_.hitPoints = _loc2_.calculateHitPoints();
               _loc7_ = 1;
               while(_loc7_ <= _loc13_)
               {
                  _loc18_ = _loc11_[_loc7_ - 1] as PlayerGameObject;
                  _loc19_ = _loc2_;
                  if(_loc18_._id == _loc19_._id)
                  {
                     if(_loc7_ == 1)
                     {
                        _loc3_.place = _loc7_;
                     }
                     else
                     {
                        _loc8_ = _loc7_;
                        while(_loc8_ > 0)
                        {
                           _loc9_ = int((_loc11_[_loc8_ - 1] as PlayerGameObject).getScore());
                           if(_loc9_ > _loc3_.score)
                           {
                              _loc3_.place = _loc8_ + 1;
                              break;
                           }
                           _loc3_.place = _loc8_;
                           _loc8_--;
                        }
                     }
                     break;
                  }
                  _loc7_++;
               }
            }
            else if(_loc3_.status == "Active" || _loc3_.status == "Idle")
            {
               _loc3_.status = "Disabled";
            }
            _loc1_++;
         }
      }
      
      private function playerRemoved(param1:Message) : void
      {
         this.createPlayerData();
      }
   }
}

