package tuxwars
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.data.Levels;
   import tuxwars.battle.world.DynamicBodyManagerPreLoader;
   import tuxwars.battle.world.loader.Level;
   import tuxwars.battle.world.loader.LevelLoader;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.Challenges;
   import tuxwars.data.practice.PracticeLevel;
   import tuxwars.player.Player;
   
   public class BattleLoader
   {
      
      private static const FAKE_PLAYER:String = "FakePlayer";
      
      private static var levelLoader:LevelLoader;
      
      private static var players:Array;
      
      private static var particleFile:Object;
      
      private static var data:Object;
      
      private static var vip:Boolean;
      
      private static var tournament:Boolean;
       
      
      public function BattleLoader()
      {
         super();
         throw new Error("BattleLoader is a static class!");
      }
      
      public static function dispose() : void
      {
         levelLoader.dispose();
         levelLoader = null;
         players.splice(0,players.length);
         data = null;
      }
      
      public static function isLoaded() : Boolean
      {
         if(!players || players.length == 0)
         {
            return false;
         }
         if(!levelLoader || !levelLoader.getLevel() || !levelLoader.getLevel().isLoaded())
         {
            return false;
         }
         return true;
      }
      
      public static function getPlayers() : Array
      {
         return players;
      }
      
      public static function getLevel() : Level
      {
         return levelLoader.getLevel();
      }
      
      public static function getBattleDuration() : int
      {
         return data.battle_time;
      }
      
      public static function getTurnDuration() : int
      {
         return data.turn_time;
      }
      
      public static function getSeed() : int
      {
         return data.seed;
      }
      
      public static function isPracticeMode() : Boolean
      {
         return data.practice_mode;
      }
      
      public static function isTournament() : Boolean
      {
         return tournament;
      }
      
      public static function isVIP() : Boolean
      {
         return vip;
      }
      
      public static function load(_data:Object, localPlayer:Player, _vip:Boolean, _tournament:Boolean) : void
      {
         DynamicBodyManagerPreLoader.preLoad();
         data = _data;
         players = loadPlayers(localPlayer);
         loadLevel();
         vip = _vip;
         tournament = _tournament;
      }
      
      private static function loadLevel() : void
      {
         var _loc1_:* = null;
         levelLoader = new LevelLoader();
         if(data.map is PracticeLevel)
         {
            _loc1_ = data.map;
            levelLoader.loadLevel(_loc1_.levelFile,"Practice");
         }
         else
         {
            levelLoader.loadLevel(Levels.findLevelData(data.map).levelFile,data.map);
         }
      }
      
      private static function loadPlayers(localPlayer:Player) : Array
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:Array = [];
         for each(var playerData in data.players)
         {
            LogUtils.log("Loading player: " + playerData.id,"BattleLoader",1,"Player",true,false,true);
            if(playerData.id != localPlayer.id)
            {
               _loc3_ = new Player(false);
               addWornItemsToItems(playerData);
               _loc3_.init(playerData);
               _loc3_.ai = isPracticeMode();
               _loc3_.setMatchLeagueInfo(playerData.tournamentBattle,playerData.league_id);
               if(_loc3_.name.indexOf("FakePlayer") != -1)
               {
                  LogUtils.addDebugLine("Player","Setting dummy player\'s challenges.");
                  var _loc6_:ChallengeManager = ChallengeManager;
                  if(!tuxwars.challenges.ChallengeManager._instance)
                  {
                     tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
                  }
                  _loc2_ = tuxwars.challenges.ChallengeManager._instance.getPlayerChallenges(localPlayer.id);
                  var _loc7_:ChallengeManager = ChallengeManager;
                  if(!tuxwars.challenges.ChallengeManager._instance)
                  {
                     tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
                  }
                  tuxwars.challenges.ChallengeManager._instance.addPlayerChallenges(_loc3_.id,_loc2_.data,false);
                  _loc3_.ingameMoney = localPlayer.ingameMoney;
                  _loc3_.premiumMoney = localPlayer.premiumMoney;
               }
               _loc4_.push(_loc3_);
            }
            else
            {
               if(playerData.name != null && playerData.name != localPlayer.name)
               {
                  localPlayer.name = playerData.name;
               }
               localPlayer.setMatchLeagueInfo(playerData.tournamentBattle,playerData.league_id);
               LogUtils.log("Adding local player " + localPlayer,"BattleLoader",1,"Player",true,false,true);
               _loc4_.push(localPlayer);
            }
         }
         return _loc4_;
      }
      
      private static function addWornItemsToItems(playerData:Object) : void
      {
         if(playerData.worn_items)
         {
            if(!playerData.items)
            {
               playerData.items = [];
            }
            for each(var itemId in playerData.worn_items)
            {
               playerData.items.push({
                  "item_id":itemId,
                  "amount":1
               });
            }
         }
      }
   }
}
