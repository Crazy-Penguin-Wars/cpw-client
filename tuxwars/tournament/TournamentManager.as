package tuxwars.tournament
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.TournamentRewardItem;
   
   public class TournamentManager
   {
      
      private static const TOURNAMENT_TABLE:String = "TournamentConfiguration";
      
      private static const LEAGUE_TABLE:String = "League";
      
      private static const LEAGUE_REWARD_TABLE:String = "LeagueReward";
      
      private static var tournaments:Vector.<Tournament>;
      
      private static var leagues:Vector.<League>;
      
      private static var leagueRewardDatas:Vector.<LeagueRewardData>;
      
      private static var currentGame:TuxWarsGame;
       
      
      public function TournamentManager()
      {
         super();
      }
      
      public static function init(game:TuxWarsGame) : void
      {
         currentGame = game;
         installTournamentConfig();
         installLeagueRewards();
         installLeagues();
         MessageCenter.addListener("TournamentUpdated",tournamentUpdated);
      }
      
      public static function triggerContentUpdate(getOngoingTournament:Boolean, getAccount:Boolean, getAccountReward:Boolean) : void
      {
         var sectors:String = "";
         if(getOngoingTournament)
         {
            sectors += "tournament_ongoing";
         }
         if(getAccount)
         {
            sectors += sectors.length > 0 ? "," : "";
            sectors += "tournament_account_ongoing";
         }
         if(getAccountReward)
         {
            sectors += sectors.length > 0 ? "," : "";
            sectors += "tournament_account_reward";
         }
         var _loc4_:Object = {"sectors":sectors};
         MessageCenter.sendMessage("TournamentUpdate",_loc4_);
      }
      
      private static function installTournamentConfig() : void
      {
         var _loc2_:* = null;
         var _loc4_:ProjectManager = ProjectManager;
         var tournamentTable:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable("TournamentConfiguration");
         tournaments = new Vector.<Tournament>();
         var _loc5_:* = tournamentTable;
         for each(var row in _loc5_._rows)
         {
            _loc2_ = new TournamentData(row);
            tournaments.push(new Tournament(_loc2_));
         }
      }
      
      private static function installLeagueRewards() : void
      {
         var _loc3_:ProjectManager = ProjectManager;
         var leagueRewardsTable:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable("LeagueReward");
         leagueRewardDatas = new Vector.<LeagueRewardData>();
         var _loc4_:* = leagueRewardsTable;
         for each(var row in _loc4_._rows)
         {
            leagueRewardDatas.push(new LeagueRewardData(row));
         }
      }
      
      private static function installLeagues() : void
      {
         var _loc1_:* = null;
         var _loc4_:ProjectManager = ProjectManager;
         var leagueTable:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable("League");
         leagues = new Vector.<League>();
         var _loc5_:* = leagueTable;
         for each(var row in _loc5_._rows)
         {
            _loc1_ = new LeagueData(row);
            leagues.push(new League(currentGame,_loc1_));
         }
      }
      
      public static function getTournament(id:String) : Tournament
      {
         var i:int = 0;
         for(i = 0; i < tournaments.length; )
         {
            if(tournaments[i].id == id)
            {
               return tournaments[i];
            }
            i++;
         }
         return null;
      }
      
      public static function getLeague(id:String) : League
      {
         for each(var l in leagues)
         {
            if(l.id == id)
            {
               return l;
            }
         }
         return null;
      }
      
      public static function getLeagueSortPriority(id:String) : int
      {
         for each(var l in leagues)
         {
            if(l.id == id)
            {
               return l.sortPriority;
            }
         }
         return -1;
      }
      
      public static function getNeighborLeague(fromLeague:League, upperLeague:Boolean) : League
      {
         var i:int = 0;
         var _loc3_:int = fromLeague.sortPriority;
         for(i = 0; i < leagues.length; )
         {
            if(upperLeague && leagues[i].sortPriority == _loc3_ + 1)
            {
               return leagues[i];
            }
            if(!upperLeague && leagues[i].sortPriority == _loc3_ - 1)
            {
               return leagues[i];
            }
            i++;
         }
         return null;
      }
      
      public static function getLeagueRewardData(id:String) : LeagueRewardData
      {
         for each(var lrd in leagueRewardDatas)
         {
            if(lrd.id == id)
            {
               return lrd;
            }
         }
         return null;
      }
      
      private static function tournamentUpdated(msg:Message) : void
      {
         var tournament:* = null;
         var league:* = null;
         var _loc4_:Object = msg.data;
         if(_loc4_)
         {
            if(_loc4_.tournament_ongoing)
            {
               if(currentGame.player.tournament)
               {
                  currentGame.player.tournament.dispose();
               }
               tournament = getTournament(_loc4_.tournament_ongoing.config_id);
               tournament.tournamentTime = Number(_loc4_.tournament_ongoing.seconds_left) * 1000;
               tournament.status = _loc4_.tournament_ongoing.status;
               currentGame.player.tournament = tournament;
            }
            if(_loc4_.tournament_account_ongoing)
            {
               league = TournamentManager.getLeague(_loc4_.tournament_account_ongoing.league_id);
               league.playedGames = _loc4_.tournament_account_ongoing.played_matches;
               league.points = _loc4_.tournament_account_ongoing.points;
               league.score = _loc4_.tournament_account_ongoing.score;
               league.previousRank = _loc4_.tournament_account_ongoing.previous_rank;
               league.rank = _loc4_.tournament_account_ongoing.rank;
               league.status = _loc4_.tournament_account_ongoing.status;
               league.divisionId = _loc4_.tournament_account_ongoing.division_id;
               if(_loc4_.tournament_account_ongoing.determined_reward)
               {
                  if(_loc4_.tournament_account_ongoing.determined_reward.first_rank_reward && _loc4_.tournament_account_ongoing.determined_reward.first_rank_reward_amount > 0)
                  {
                     league.firstPositionReward = new TournamentRewardItem(_loc4_.tournament_account_ongoing.determined_reward.first_rank_reward,_loc4_.tournament_account_ongoing.determined_reward.first_rank_reward_amount);
                  }
                  if(_loc4_.tournament_account_ongoing.determined_reward.second_rank_reward && _loc4_.tournament_account_ongoing.determined_reward.second_rank_reward_amount > 0)
                  {
                     league.secondPositionReward = new TournamentRewardItem(_loc4_.tournament_account_ongoing.determined_reward.second_rank_reward,_loc4_.tournament_account_ongoing.determined_reward.second_rank_reward_amount);
                  }
                  if(_loc4_.tournament_account_ongoing.determined_reward.third_rank_reward && _loc4_.tournament_account_ongoing.determined_reward.third_rank_reward_amount > 0)
                  {
                     league.thirdPositionReward = new TournamentRewardItem(_loc4_.tournament_account_ongoing.determined_reward.third_rank_reward,_loc4_.tournament_account_ongoing.determined_reward.third_rank_reward_amount);
                  }
                  if(_loc4_.tournament_account_ongoing.determined_reward.fourth_rank_reward && _loc4_.tournament_account_ongoing.determined_reward.fourth_rank_reward_amount > 0)
                  {
                     league.fourthPositionReward = new TournamentRewardItem(_loc4_.tournament_account_ongoing.determined_reward.fourth_rank_reward,_loc4_.tournament_account_ongoing.determined_reward.fourth_rank_reward_amount);
                  }
               }
               league.clearPlayers();
               league.addPlayer(createPlayerFromData(_loc4_.tournament_account_ongoing));
               if(_loc4_.tournament_account_ongoing.user_data_in_division)
               {
                  for each(var userObject in _loc4_.tournament_account_ongoing.user_data_in_division.user)
                  {
                     league.addPlayer(new TournamentPlayer(userObject));
                  }
                  league.organizePlayersByRank();
               }
               currentGame.player.tournament.league = league;
            }
            if(_loc4_.tournament_account_reward)
            {
               if(currentGame.player.tournament)
               {
                  if(currentGame.player.tournament.league)
                  {
                     league = currentGame.player.tournament.league;
                  }
                  else
                  {
                     league = TournamentManager.getLeague(_loc4_.tournament_account_reward.league_id);
                  }
               }
               else
               {
                  currentGame.player.tournament = tournaments[0];
                  league = TournamentManager.getLeague(_loc4_.tournament_account_reward.league_id);
               }
               league.rewardId = _loc4_.tournament_account_reward.id;
               league.previousRank = _loc4_.tournament_account_reward.previous_rank;
               league.rank = _loc4_.tournament_account_reward.rank;
               if(_loc4_.tournament_account_reward.rank_reward && _loc4_.tournament_account_reward.rank_reward_amount > 0)
               {
                  league.rankReward = new TournamentRewardItem(_loc4_.tournament_account_reward.rank_reward,_loc4_.tournament_account_reward.rank_reward_amount);
               }
               else
               {
                  league.rankReward = null;
               }
               league.playedGames = _loc4_.tournament_account_reward.played_matches;
               league.points = _loc4_.tournament_account_reward.points;
               league.score = _loc4_.tournament_account_reward.score;
               league.status = _loc4_.tournament_account_reward.status;
               league.divisionId = _loc4_.tournament_account_reward.division_id;
               league.clearPlayers();
               league.addPlayer(createPlayerFromData(_loc4_.tournament_account_reward));
               if(_loc4_.tournament_account_reward.user_data_in_division)
               {
                  for each(userObject in _loc4_.tournament_account_reward.user_data_in_division.user)
                  {
                     league.addPlayer(new TournamentPlayer(userObject));
                  }
                  league.organizePlayersByRank();
               }
               currentGame.player.tournament.league = league;
            }
            MessageCenter.sendMessage("UpdateTournamentScreen");
         }
      }
      
      private static function createPlayerFromData(data:Object) : TournamentPlayer
      {
         var userObject:Object = {};
         userObject.dcg_id = currentGame.player.id;
         userObject.rank = data.rank;
         userObject.played_matches = data.played_matches;
         userObject.points = data.points;
         userObject.score = data.score;
         userObject.status = data.status;
         userObject.platform = Config.getPlatform();
         userObject.name = currentGame.player.name;
         userObject.pic_url = currentGame.player.picUrl;
         userObject.previous_rank = data.previous_rank;
         userObject.user_id = currentGame.player.id;
         return new TournamentPlayer(userObject);
      }
   }
}
