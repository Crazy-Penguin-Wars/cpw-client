package tuxwars.tournament
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.*;
   
   public class TournamentManager
   {
      private static var tournaments:Vector.<Tournament>;
      
      private static var leagues:Vector.<League>;
      
      private static var leagueRewardDatas:Vector.<LeagueRewardData>;
      
      private static var currentGame:TuxWarsGame;
      
      private static const TOURNAMENTtable:String = "TournamentConfiguration";
      
      private static const LEAGUEtable:String = "League";
      
      private static const LEAGUE_REWARDtable:String = "LeagueReward";
      
      public function TournamentManager()
      {
         super();
      }
      
      public static function init(param1:TuxWarsGame) : void
      {
         currentGame = param1;
         installTournamentConfig();
         installLeagueRewards();
         installLeagues();
         MessageCenter.addListener("TournamentUpdated",tournamentUpdated);
      }
      
      public static function triggerContentUpdate(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:* = "";
         if(param1)
         {
            _loc4_ += "tournament_ongoing";
         }
         if(param2)
         {
            _loc4_ += _loc4_.length > 0 ? "," : "";
            _loc4_ = _loc4_ + "tournament_account_ongoing";
         }
         if(param3)
         {
            _loc4_ += _loc4_.length > 0 ? "," : "";
            _loc4_ = _loc4_ + "tournament_account_reward";
         }
         var _loc5_:Object = {"sectors":_loc4_};
         MessageCenter.sendMessage("TournamentUpdate",_loc5_);
      }
      
      private static function installTournamentConfig() : void
      {
         var _loc5_:* = undefined;
         var _loc1_:TournamentData = null;
         var _loc2_:String = "TournamentConfiguration";
         var _loc3_:Table = ProjectManager.findTable(_loc2_);
         tournaments = new Vector.<Tournament>();
         var _loc4_:* = _loc3_;
         for each(_loc5_ in _loc4_._rows)
         {
            _loc1_ = new TournamentData(_loc5_);
            tournaments.push(new Tournament(_loc1_));
         }
      }
      
      private static function installLeagueRewards() : void
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "LeagueReward";
         var _loc2_:Table = ProjectManager.findTable(_loc1_);
         leagueRewardDatas = new Vector.<LeagueRewardData>();
         var _loc3_:* = _loc2_;
         for each(_loc4_ in _loc3_._rows)
         {
            leagueRewardDatas.push(new LeagueRewardData(_loc4_));
         }
      }
      
      private static function installLeagues() : void
      {
         var _loc5_:* = undefined;
         var _loc1_:LeagueData = null;
         var _loc2_:String = "League";
         var _loc3_:Table = ProjectManager.findTable(_loc2_);
         leagues = new Vector.<League>();
         var _loc4_:* = _loc3_;
         for each(_loc5_ in _loc4_._rows)
         {
            _loc1_ = new LeagueData(_loc5_);
            leagues.push(new League(currentGame,_loc1_));
         }
      }
      
      public static function getTournament(param1:String) : Tournament
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < tournaments.length)
         {
            if(tournaments[_loc2_].id == param1)
            {
               return tournaments[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getLeague(param1:String) : League
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in leagues)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getLeagueSortPriority(param1:String) : int
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in leagues)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_.sortPriority;
            }
         }
         return -1;
      }
      
      public static function getNeighborLeague(param1:League, param2:Boolean) : League
      {
         var _loc3_:int = 0;
         var _loc4_:int = param1.sortPriority;
         _loc3_ = 0;
         while(_loc3_ < leagues.length)
         {
            if(param2 && leagues[_loc3_].sortPriority == _loc4_ + 1)
            {
               return leagues[_loc3_];
            }
            if(!param2 && leagues[_loc3_].sortPriority == _loc4_ - 1)
            {
               return leagues[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function getLeagueRewardData(param1:String) : LeagueRewardData
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in leagueRewardDatas)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private static function tournamentUpdated(param1:Message) : void
      {
         var _loc5_:* = undefined;
         var _loc2_:Tournament = null;
         var _loc3_:League = null;
         var _loc4_:Object = param1.data;
         if(_loc4_)
         {
            if(_loc4_.tournament_ongoing)
            {
               if(currentGame.player.tournament)
               {
                  currentGame.player.tournament.dispose();
               }
               _loc2_ = getTournament(_loc4_.tournament_ongoing.config_id);
               _loc2_.tournamentTime = _loc4_.tournament_ongoing.seconds_left * 1000;
               _loc2_.status = _loc4_.tournament_ongoing.status;
               currentGame.player.tournament = _loc2_;
            }
            if(_loc4_.tournament_account_ongoing)
            {
               _loc3_ = TournamentManager.getLeague(_loc4_.tournament_account_ongoing.league_id);
               _loc3_.playedGames = _loc4_.tournament_account_ongoing.played_matches;
               _loc3_.points = _loc4_.tournament_account_ongoing.points;
               _loc3_.score = _loc4_.tournament_account_ongoing.score;
               _loc3_.previousRank = _loc4_.tournament_account_ongoing.previous_rank;
               _loc3_.rank = _loc4_.tournament_account_ongoing.rank;
               _loc3_.status = _loc4_.tournament_account_ongoing.status;
               _loc3_.divisionId = _loc4_.tournament_account_ongoing.division_id;
               if(_loc4_.tournament_account_ongoing.determined_reward)
               {
                  if(Boolean(_loc4_.tournament_account_ongoing.determined_reward.first_rank_reward) && _loc4_.tournament_account_ongoing.determined_reward.first_rank_reward_amount > 0)
                  {
                     _loc3_.firstPositionReward = new TournamentRewardItem(_loc4_.tournament_account_ongoing.determined_reward.first_rank_reward,_loc4_.tournament_account_ongoing.determined_reward.first_rank_reward_amount);
                  }
                  if(Boolean(_loc4_.tournament_account_ongoing.determined_reward.second_rank_reward) && _loc4_.tournament_account_ongoing.determined_reward.second_rank_reward_amount > 0)
                  {
                     _loc3_.secondPositionReward = new TournamentRewardItem(_loc4_.tournament_account_ongoing.determined_reward.second_rank_reward,_loc4_.tournament_account_ongoing.determined_reward.second_rank_reward_amount);
                  }
                  if(Boolean(_loc4_.tournament_account_ongoing.determined_reward.third_rank_reward) && _loc4_.tournament_account_ongoing.determined_reward.third_rank_reward_amount > 0)
                  {
                     _loc3_.thirdPositionReward = new TournamentRewardItem(_loc4_.tournament_account_ongoing.determined_reward.third_rank_reward,_loc4_.tournament_account_ongoing.determined_reward.third_rank_reward_amount);
                  }
                  if(Boolean(_loc4_.tournament_account_ongoing.determined_reward.fourth_rank_reward) && _loc4_.tournament_account_ongoing.determined_reward.fourth_rank_reward_amount > 0)
                  {
                     _loc3_.fourthPositionReward = new TournamentRewardItem(_loc4_.tournament_account_ongoing.determined_reward.fourth_rank_reward,_loc4_.tournament_account_ongoing.determined_reward.fourth_rank_reward_amount);
                  }
               }
               _loc3_.clearPlayers();
               _loc3_.addPlayer(createPlayerFromData(_loc4_.tournament_account_ongoing));
               if(_loc4_.tournament_account_ongoing.user_data_in_division)
               {
                  for each(_loc5_ in _loc4_.tournament_account_ongoing.user_data_in_division.user)
                  {
                     _loc3_.addPlayer(new TournamentPlayer(_loc5_));
                  }
                  _loc3_.organizePlayersByRank();
               }
               currentGame.player.tournament.league = _loc3_;
            }
            if(_loc4_.tournament_account_reward)
            {
               if(currentGame.player.tournament)
               {
                  if(currentGame.player.tournament.league)
                  {
                     _loc3_ = currentGame.player.tournament.league;
                  }
                  else
                  {
                     _loc3_ = TournamentManager.getLeague(_loc4_.tournament_account_reward.league_id);
                  }
               }
               else
               {
                  currentGame.player.tournament = tournaments[0];
                  _loc3_ = TournamentManager.getLeague(_loc4_.tournament_account_reward.league_id);
               }
               _loc3_.rewardId = _loc4_.tournament_account_reward.id;
               _loc3_.previousRank = _loc4_.tournament_account_reward.previous_rank;
               _loc3_.rank = _loc4_.tournament_account_reward.rank;
               if(Boolean(_loc4_.tournament_account_reward.rank_reward) && _loc4_.tournament_account_reward.rank_reward_amount > 0)
               {
                  _loc3_.rankReward = new TournamentRewardItem(_loc4_.tournament_account_reward.rank_reward,_loc4_.tournament_account_reward.rank_reward_amount);
               }
               else
               {
                  _loc3_.rankReward = null;
               }
               _loc3_.playedGames = _loc4_.tournament_account_reward.played_matches;
               _loc3_.points = _loc4_.tournament_account_reward.points;
               _loc3_.score = _loc4_.tournament_account_reward.score;
               _loc3_.status = _loc4_.tournament_account_reward.status;
               _loc3_.divisionId = _loc4_.tournament_account_reward.division_id;
               _loc3_.clearPlayers();
               _loc3_.addPlayer(createPlayerFromData(_loc4_.tournament_account_reward));
               if(_loc4_.tournament_account_reward.user_data_in_division)
               {
                  for each(_loc5_ in _loc4_.tournament_account_reward.user_data_in_division.user)
                  {
                     _loc3_.addPlayer(new TournamentPlayer(_loc5_));
                  }
                  _loc3_.organizePlayersByRank();
               }
               currentGame.player.tournament.league = _loc3_;
            }
            MessageCenter.sendMessage("UpdateTournamentScreen");
         }
      }
      
      private static function createPlayerFromData(param1:Object) : TournamentPlayer
      {
         var _loc2_:Object = {};
         _loc2_.dcg_id = currentGame.player.id;
         _loc2_.rank = param1.rank;
         _loc2_.played_matches = param1.played_matches;
         _loc2_.points = param1.points;
         _loc2_.score = param1.score;
         _loc2_.status = param1.status;
         _loc2_.platform = Config.getPlatform();
         _loc2_.name = currentGame.player.name;
         _loc2_.pic_url = currentGame.player.picUrl;
         _loc2_.previous_rank = param1.previous_rank;
         _loc2_.user_id = currentGame.player.id;
         return new TournamentPlayer(_loc2_);
      }
   }
}

