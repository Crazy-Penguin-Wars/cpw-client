package tuxwars.battle.ui.logic
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.ui.BattleHud;
   import tuxwars.battle.ui.logic.chat.ChatLogic;
   import tuxwars.battle.ui.screen.BattleHudScreen;
   import tuxwars.battle.ui.states.HUDBoosterSelectionSubState;
   import tuxwars.battle.ui.states.HUDWeaponSelectionSubState;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.items.ClothingItem;
   import tuxwars.states.TuxState;
   import tuxwars.utils.TuxUiUtils;
   
   public class BattleHudLogic extends TuxUILogic implements IBattleHudLogic
   {
      
      public static const PLAYER:String = "Player_";
      
      public static const MAX_PLAYERS:int = 4;
       
      
      private var playersData:Object;
      
      private var hudState:BattleHud;
      
      private var chatLogic:ChatLogic;
      
      public function BattleHudLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         chatLogic = new ChatLogic(game,state);
         createPlayerData();
         MessageCenter.addListener("PlayerRemoved",playerRemoved);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         hudState = params;
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("PlayerRemoved",playerRemoved);
         chatLogic.dispose();
         chatLogic = null;
         super.dispose();
      }
      
      override public function set screen(screen:*) : void
      {
         super.screen = screen;
         chatLogic.screen = screen.chatElementScreen;
      }
      
      public function getChatLogic() : ChatLogic
      {
         return chatLogic;
      }
      
      public function getHudPlayersData() : Object
      {
         return playersData;
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         updatePlayers();
      }
      
      public function get battleHudScreen() : BattleHudScreen
      {
         return screen;
      }
      
      public function showWeaponSelection() : void
      {
         hudState.changeState(new HUDWeaponSelectionSubState(game));
      }
      
      public function showBoosterSelection() : void
      {
         hudState.changeState(new HUDBoosterSelectionSubState(game));
      }
      
      private function createPlayerData() : void
      {
         var i:int = 0;
         playersData = {};
         for(i = 1; i <= 4; )
         {
            playersData["Player_" + i] = new BattleHudPlayerData();
            i++;
         }
         updatePlayers();
      }
      
      private function updatePlayers() : void
      {
         var i:int = 0;
         var player:* = null;
         var playerData:* = null;
         var _loc5_:* = null;
         var _loc10_:* = null;
         var _loc15_:* = null;
         var j:int = 0;
         var k:* = 0;
         var score:int = 0;
         var _loc11_:Array = game.tuxWorld.players;
         var _loc14_:Array = TuxUiUtils.getPlayersSortedByScore(_loc11_);
         var _loc13_:int = BattleManager.getCurrentActivePlayerIndex() + 1;
         var _loc9_:int = Math.min(4,_loc11_.length);
         for(i = 1; i <= _loc9_; )
         {
            player = _loc11_[i - 1];
            playerData = playersData["Player_" + player.getTabIndex()];
            playerData.tabIndex = player.getTabIndex();
            if(player)
            {
               if(i == _loc13_)
               {
                  playerData.status = "Active";
               }
               else
               {
                  playerData.status = "Idle";
               }
               var _loc16_:* = GameObject(player);
               if(playerData.name != _loc16_._name)
               {
                  var _loc17_:* = GameObject(player);
                  playerData.name = _loc17_._name;
               }
               if(!playerData.avatar)
               {
                  _loc5_ = new TuxAvatar(Players.getPlayerData().graphics.swf);
                  _loc5_.animate(new AvatarAnimation("idle"));
                  _loc5_.paperDoll.animation.clip.stop();
                  _loc5_.paperDoll.animation.clip.cacheAsBitmap = true;
                  _loc10_ = player.wornItemsContainer.getWornItems();
                  for each(var item in _loc10_)
                  {
                     if(item != null)
                     {
                        _loc5_.wearClothing(item);
                     }
                  }
                  playerData.avatar = _loc5_;
                  _loc15_ = new TuxAvatar(Players.getPlayerData().graphics.swf);
                  _loc15_.animate(new AvatarAnimation("idle"));
                  _loc15_.flip();
                  for each(var item2 in _loc10_)
                  {
                     if(item2)
                     {
                        _loc15_.wearClothing(item2);
                     }
                  }
                  playerData.avatarTimer = _loc15_;
               }
               playerData.score = player.getScore();
               playerData.hitPoints = player.calculateHitPoints();
               loop3:
               for(j = 1; j <= _loc9_; j++)
               {
                  var _loc22_:* = _loc14_[j - 1] as PlayerGameObject;
                  var _loc23_:* = player;
                  if(_loc22_._id != _loc23_._id)
                  {
                     continue;
                  }
                  if(j == 1)
                  {
                     playerData.place = j;
                     break;
                  }
                  k = j;
                  while(true)
                  {
                     if(k <= 0)
                     {
                        break loop3;
                     }
                     score = (_loc14_[k - 1] as PlayerGameObject).getScore();
                     if(score > playerData.score)
                     {
                        playerData.place = k + 1;
                        break loop3;
                     }
                     playerData.place = k;
                     k--;
                  }
               }
            }
            else if(playerData.status == "Active" || playerData.status == "Idle")
            {
               playerData.status = "Disabled";
            }
            i++;
         }
      }
      
      private function playerRemoved(msg:Message) : void
      {
         createPlayerData();
      }
   }
}
