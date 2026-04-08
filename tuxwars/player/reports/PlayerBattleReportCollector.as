package tuxwars.player.reports
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.history.*;
   import tuxwars.battle.utils.*;
   import tuxwars.player.Player;
   import tuxwars.player.reports.events.ReportExplosionMessage;
   import tuxwars.player.reports.events.ReportLevelObjectDestroyedMessage;
   import tuxwars.player.reports.events.ReportTerrainDestroyedMessage;
   
   public class PlayerBattleReportCollector
   {
      private static var player:Player;
      
      public static const KILLS:String = "kills";
      
      public static const DEATHS:String = "deaths";
      
      public static const MISSILE_AIRTIME:String = "missile_airtime";
      
      public static const SUICIDE:String = "suicide";
      
      public static const DISTANCE_WALKED:String = "distance_walked";
      
      public static const DYNAMIC_OBJECT_DESTROYED:String = "dynamic_object_destroyed";
      
      public static const TERRAIN_DESTROYED:String = "terrain_destroyed";
      
      public static const EMOTICONS:String = "emoticons";
      
      public static const JUMPS:String = "jumps";
      
      public static const DAMAGE_TO_OPPONENT:String = "damage_to_opponent";
      
      public static const DAMAGE_TO_MULTIPLE_OPPONENTS:String = "damage_to_multiple_opponents";
      
      public static const DAMAGE_TO_SELF:String = "damage_to_self";
      
      public static const TURNS:String = "turns";
      
      private static const MISSILE_CONTACT_TIMES:Object = {};
      
      public function PlayerBattleReportCollector()
      {
         super();
      }
      
      public static function init(param1:Player) : void
      {
         player = param1;
         DCUtils.deleteProperties(MISSILE_CONTACT_TIMES);
         MessageCenter.addListener("MatchStarted",matchStarted);
      }
      
      private static function matchStarted(param1:Message) : void
      {
         MessageCenter.removeListener("MatchStarted",matchStarted);
         MessageCenter.addListener("MatchEnded",matchEnded);
         if(!BattleManager.isPracticeMode())
         {
            MessageCenter.addListener("PlayerDied",playerDied);
            MessageCenter.addListener("LevelObjectDestroyed",levelObjectDestroyed);
            MessageCenter.addListener("PlayerTurnStarted",turnStarted);
            MessageCenter.addListener("PlayerTurnEnded",turnEnded);
            MessageCenter.addListener("MissileContact",missileContact);
            MessageCenter.addListener("TerrainDestroyed",terrainDestroyed);
            MessageCenter.addListener("Emoticons",emoticonUsed);
            MessageCenter.addListener("Jumps",jumped);
            MessageCenter.addListener("ReportExplosion",explosion);
         }
      }
      
      private static function matchEnded(param1:Message) : void
      {
         MessageCenter.removeListener("MatchEnded",matchEnded);
         MessageCenter.addListener("MatchStarted",matchStarted);
         MessageCenter.removeListener("PlayerDied",playerDied);
         MessageCenter.removeListener("LevelObjectDestroyed",levelObjectDestroyed);
         MessageCenter.removeListener("PlayerTurnStarted",turnStarted);
         MessageCenter.removeListener("PlayerTurnEnded",turnEnded);
         MessageCenter.removeListener("MissileContact",missileContact);
         MessageCenter.removeListener("TerrainDestroyed",terrainDestroyed);
         MessageCenter.removeListener("Emoticons",emoticonUsed);
         MessageCenter.removeListener("Jumps",jumped);
         MessageCenter.removeListener("ReportExplosion",explosion);
      }
      
      private static function playerDied(param1:Message) : void
      {
         var _loc2_:PlayerGameObject = param1.data;
         var _loc3_:Tagger = _loc2_.tag.findLatestPlayerTagger();
         var _loc4_:* = _loc2_;
         if(_loc4_._id == player.id)
         {
            HistoryMessageFactory.sendReportMessage(player.id,"deaths",1);
            if(_loc2_.suicide)
            {
               HistoryMessageFactory.sendReportMessage(player.id,"suicide",1);
            }
         }
         else if(_loc3_ && _loc3_.gameObject && _loc5_._id == player.id)
         {
            HistoryMessageFactory.sendReportMessage(player.id,"kills",1);
         }
      }
      
      private static function levelObjectDestroyed(param1:ReportLevelObjectDestroyedMessage) : void
      {
         var _loc2_:Tagger = param1.levelObject.tag.findLatestPlayerTagger();
         if(_loc2_ && _loc2_.gameObject && _loc3_._id == player.id)
         {
            HistoryMessageFactory.sendReportMessage(player.id,"dynamic_object_destroyed",1);
         }
      }
      
      private static function turnStarted(param1:Message) : void
      {
         param1.data.walkDistance = 0;
      }
      
      private static function turnEnded(param1:PlayerTurnEndedMessage) : void
      {
         var _loc2_:* = param1.player;
         if(BattleManager.isLocalPlayer(_loc2_._id))
         {
            if(param1.player.walkDistance > 0)
            {
               HistoryMessageFactory.sendReportMessage(player.id,"distance_walked",int(param1.player.walkDistance));
            }
            HistoryMessageFactory.sendReportMessage(player.id,"turns",1);
         }
      }
      
      private static function missileContact(param1:Message) : void
      {
         if(!BattleManager.isLocalPlayersTurn())
         {
            return;
         }
         var _loc2_:PhysicsEmissionGameObject = param1.data;
         var _loc3_:* = _loc2_;
         if(MISSILE_CONTACT_TIMES.hasOwnProperty(_loc3_._uniqueId))
         {
            return;
         }
         var _loc4_:* = _loc2_;
         MISSILE_CONTACT_TIMES[_loc4_._uniqueId] = _loc2_.elapsedTime;
         HistoryMessageFactory.sendReportMessage(player.id,"missile_airtime",_loc2_.elapsedTime);
      }
      
      private static function terrainDestroyed(param1:ReportTerrainDestroyedMessage) : void
      {
         if(!BattleManager.isLocalPlayersTurn())
         {
            return;
         }
         HistoryMessageFactory.sendReportMessage(player.id,"terrain_destroyed",Math.round(param1.terrain.lastDestroyedArea));
      }
      
      private static function calculateAreas(param1:Vector.<Vector.<Vec2>>) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc2_ += Math.abs(GeomUtils.calculatePolygonArea(_loc3_));
         }
         return _loc2_;
      }
      
      private static function jumped(param1:Message) : void
      {
         if(player.id == param1.data.id)
         {
            HistoryMessageFactory.sendReportMessage(player.id,"jumps",1);
         }
      }
      
      private static function emoticonUsed(param1:Message) : void
      {
         if(player.id == param1.data.id)
         {
            HistoryMessageFactory.sendReportMessage(player.id,"emoticons",1);
         }
      }
      
      private static function explosion(param1:ReportExplosionMessage) : void
      {
         handleDamageToOpponent(param1);
         handleDamageToMultipleOpponents(param1);
         handleDamageToSelf(param1);
      }
      
      private static function handleDamageToSelf(param1:ReportExplosionMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = param1.firingPlayer;
         if(_loc3_._id == player.id && param1.containsPlayer(player.id))
         {
            _loc2_ = param1.damageTo(player.id);
            if(_loc2_ > 0)
            {
               HistoryMessageFactory.sendReportMessage(player.id,"damage_to_self",_loc2_);
            }
         }
      }
      
      private static function handleDamageToMultipleOpponents(param1:ReportExplosionMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = param1.firingPlayer;
         if(_loc3_._id == player.id)
         {
            _loc2_ = int(calculateDamageToOpponents(param1));
            if(_loc2_ > 0)
            {
               HistoryMessageFactory.sendReportMessage(player.id,"damage_to_multiple_opponents",_loc2_);
            }
         }
      }
      
      private static function handleDamageToOpponent(param1:ReportExplosionMessage) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:* = param1.firingPlayer;
         if(_loc3_._id == player.id)
         {
            for each(_loc4_ in param1.affectedPlayers)
            {
               _loc5_ = _loc4_;
               if(_loc5_._id != player.id)
               {
                  _loc6_ = _loc4_;
                  _loc2_ = param1.damageTo(_loc6_._id);
                  if(_loc2_ > 0)
                  {
                     HistoryMessageFactory.sendReportMessage(player.id,"damage_to_opponent",_loc2_);
                  }
               }
            }
         }
      }
      
      private static function calculateDamageToOpponents(param1:ReportExplosionMessage) : int
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in param1.affectedPlayers)
         {
            _loc4_ = _loc3_;
            if(_loc4_._id != player.id)
            {
               _loc5_ = _loc3_;
               _loc2_ += param1.damageTo(_loc5_._id);
            }
         }
         return _loc2_;
      }
   }
}

