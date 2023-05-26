package tuxwars.player.reports
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.events.PlayerTurnEndedMessage;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.history.HistoryMessageFactory;
   import tuxwars.battle.utils.GeomUtils;
   import tuxwars.player.Player;
   import tuxwars.player.reports.events.ReportExplosionMessage;
   import tuxwars.player.reports.events.ReportLevelObjectDestroyedMessage;
   import tuxwars.player.reports.events.ReportTerrainDestroyedMessage;
   
   public class PlayerBattleReportCollector
   {
      
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
      
      private static var player:Player;
       
      
      public function PlayerBattleReportCollector()
      {
         super();
      }
      
      public static function init(_player:Player) : void
      {
         player = _player;
         DCUtils.deleteProperties(MISSILE_CONTACT_TIMES);
         MessageCenter.addListener("MatchStarted",matchStarted);
      }
      
      private static function matchStarted(msg:Message) : void
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
      
      private static function matchEnded(msg:Message) : void
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
      
      private static function playerDied(msg:Message) : void
      {
         var _loc2_:PlayerGameObject = msg.data;
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
      
      private static function levelObjectDestroyed(msg:ReportLevelObjectDestroyedMessage) : void
      {
         var _loc2_:Tagger = msg.levelObject.tag.findLatestPlayerTagger();
         if(_loc2_ && _loc2_.gameObject && _loc3_._id == player.id)
         {
            HistoryMessageFactory.sendReportMessage(player.id,"dynamic_object_destroyed",1);
         }
      }
      
      private static function turnStarted(msg:Message) : void
      {
         msg.data.walkDistance = 0;
      }
      
      private static function turnEnded(msg:PlayerTurnEndedMessage) : void
      {
         var _loc2_:* = msg.player;
         if(BattleManager.isLocalPlayer(_loc2_._id))
         {
            if(msg.player.walkDistance > 0)
            {
               HistoryMessageFactory.sendReportMessage(player.id,"distance_walked",msg.player.walkDistance);
            }
            HistoryMessageFactory.sendReportMessage(player.id,"turns",1);
         }
      }
      
      private static function missileContact(msg:Message) : void
      {
         if(!BattleManager.isLocalPlayersTurn())
         {
            return;
         }
         var _loc2_:PhysicsEmissionGameObject = msg.data;
         var _loc3_:* = _loc2_;
         if(MISSILE_CONTACT_TIMES.hasOwnProperty(_loc3_._uniqueId))
         {
            return;
         }
         var _loc4_:* = _loc2_;
         MISSILE_CONTACT_TIMES[_loc4_._uniqueId] = _loc2_.elapsedTime;
         HistoryMessageFactory.sendReportMessage(player.id,"missile_airtime",_loc2_.elapsedTime);
      }
      
      private static function terrainDestroyed(msg:ReportTerrainDestroyedMessage) : void
      {
         if(!BattleManager.isLocalPlayersTurn())
         {
            return;
         }
         HistoryMessageFactory.sendReportMessage(player.id,"terrain_destroyed",Math.round(msg.terrain.lastDestroyedArea));
      }
      
      private static function calculateAreas(polys:Vector.<Vector.<Vec2>>) : int
      {
         var area:int = 0;
         for each(var poly in polys)
         {
            area += Math.abs(GeomUtils.calculatePolygonArea(poly));
         }
         return area;
      }
      
      private static function jumped(msg:Message) : void
      {
         if(player.id == msg.data.id)
         {
            HistoryMessageFactory.sendReportMessage(player.id,"jumps",1);
         }
      }
      
      private static function emoticonUsed(msg:Message) : void
      {
         if(player.id == msg.data.id)
         {
            HistoryMessageFactory.sendReportMessage(player.id,"emoticons",1);
         }
      }
      
      private static function explosion(msg:ReportExplosionMessage) : void
      {
         handleDamageToOpponent(msg);
         handleDamageToMultipleOpponents(msg);
         handleDamageToSelf(msg);
      }
      
      private static function handleDamageToSelf(msg:ReportExplosionMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = msg.firingPlayer;
         if(_loc3_._id == player.id && msg.containsPlayer(player.id))
         {
            _loc2_ = msg.damageTo(player.id);
            if(_loc2_ > 0)
            {
               HistoryMessageFactory.sendReportMessage(player.id,"damage_to_self",_loc2_);
            }
         }
      }
      
      private static function handleDamageToMultipleOpponents(msg:ReportExplosionMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = msg.firingPlayer;
         if(_loc3_._id == player.id)
         {
            _loc2_ = calculateDamageToOpponents(msg);
            if(_loc2_ > 0)
            {
               HistoryMessageFactory.sendReportMessage(player.id,"damage_to_multiple_opponents",_loc2_);
            }
         }
      }
      
      private static function handleDamageToOpponent(msg:ReportExplosionMessage) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = msg.firingPlayer;
         if(_loc4_._id == player.id)
         {
            for each(var opponent in msg.affectedPlayers)
            {
               var _loc5_:* = opponent;
               if(_loc5_._id != player.id)
               {
                  var _loc6_:* = opponent;
                  _loc3_ = msg.damageTo(_loc6_._id);
                  if(_loc3_ > 0)
                  {
                     HistoryMessageFactory.sendReportMessage(player.id,"damage_to_opponent",_loc3_);
                  }
               }
            }
         }
      }
      
      private static function calculateDamageToOpponents(msg:ReportExplosionMessage) : int
      {
         var damage:int = 0;
         for each(var opponent in msg.affectedPlayers)
         {
            var _loc4_:* = opponent;
            if(_loc4_._id != player.id)
            {
               var _loc5_:* = opponent;
               damage += msg.damageTo(_loc5_._id);
            }
         }
         return damage;
      }
   }
}
