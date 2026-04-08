package tuxwars
{
   import com.dchoc.utils.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.world.*;
   import tuxwars.battle.world.loader.*;
   import tuxwars.challenges.*;
   import tuxwars.data.practice.*;
   import tuxwars.player.*;
   
   public class BattleLoader
   {
      private static var levelLoader:LevelLoader;
      
      private static var players:Array;
      
      private static var particleFile:Object;
      
      private static var data:Object;
      
      private static var vip:Boolean;
      
      private static var tournament:Boolean;
      
      private static const FAKE_PLAYER:String = "FakePlayer";
      
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
      
      public static function load(param1:Object, param2:Player, param3:Boolean, param4:Boolean) : void
      {
         DynamicBodyManagerPreLoader.preLoad();
         data = param1;
         players = loadPlayers(param2);
         loadLevel();
         vip = param3;
         tournament = param4;
      }
      
      private static function loadLevel() : void
      {
         var _loc1_:PracticeLevel = null;
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
      
      private static function loadPlayers(param1:Player) : Array
      {
         var _loc5_:* = undefined;
         var _loc2_:Player = null;
         var _loc3_:Challenges = null;
         var _loc4_:Array = [];
         for each(_loc5_ in data.players)
         {
            LogUtils.log("Loading player: " + _loc5_.id,"BattleLoader",1,"Player",true,false,true);
            if(_loc5_.id != param1.id)
            {
               if(_loc5_.id.indexOf("LocalPlayer") != -1)
               {
                  _loc2_ = new Player(true);
               }
               else
               {
                  _loc2_ = new Player(false);
               }
               addWornItemsToItems(_loc5_);
               _loc2_.init(_loc5_);
               if(_loc5_.id.indexOf("LocalPlayer") != -1)
               {
                  _loc2_.ai = false;
               }
               else
               {
                  _loc2_.ai = isPracticeMode();
               }
               _loc2_.setMatchLeagueInfo(_loc5_.tournamentBattle,_loc5_.league_id);
               if(_loc2_.name.indexOf("FakePlayer") != -1)
               {
                  LogUtils.addDebugLine("Player","Setting dummy player\'s challenges.");
                  if(!ChallengeManager._instance)
                  {
                     ChallengeManager._instance = new ChallengeManager();
                  }
                  _loc3_ = ChallengeManager._instance.getPlayerChallenges(param1.id);
                  if(!ChallengeManager._instance)
                  {
                     ChallengeManager._instance = new ChallengeManager();
                  }
                  ChallengeManager._instance.addPlayerChallenges(_loc2_.id,_loc3_.data,false);
                  _loc2_.ingameMoney = param1.ingameMoney;
                  _loc2_.premiumMoney = param1.premiumMoney;
               }
               _loc4_.push(_loc2_);
            }
            else
            {
               if(_loc5_.name != null && _loc5_.name != param1.name)
               {
                  param1.name = _loc5_.name;
               }
               param1.setMatchLeagueInfo(_loc5_.tournamentBattle,_loc5_.league_id);
               LogUtils.log("Adding local player " + param1,"BattleLoader",1,"Player",true,false,true);
               _loc4_.push(param1);
            }
         }
         return _loc4_;
      }
      
      private static function addWornItemsToItems(param1:Object) : void
      {
         var _loc2_:* = undefined;
         if(param1.worn_items)
         {
            if(!param1.items)
            {
               param1.items = [];
            }
            for each(_loc2_ in param1.worn_items)
            {
               param1.items.push({
                  "item_id":_loc2_,
                  "amount":1
               });
            }
         }
      }
   }
}

