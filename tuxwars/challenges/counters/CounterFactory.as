package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   
   public class CounterFactory
   {
      
      public static const PLAYER_FLY_TIME:String = "player_fly_time";
      
      public static const MISSILE_FLY_TIME:String = "missile_fly_time";
      
      public static const PLAYER_DAMAGED_COUNTER:String = "player_damaged";
      
      public static const PLAYER_DAMAGED_WITHOUT_DYING:String = "player_damaged_without_dying";
      
      public static const DAMAGE_OPPONENTS_COUNTER:String = "damage_opponents";
      
      public static const DAMAGE_OPPONENTS_LESS_THAN_COUNTER:String = "damage_opponents_less_than";
      
      public static const DAMAGE_OPPONENTS_USING_WEAPON_ID:String = "damage_opponents_using_weapon_id";
      
      public static const DAMAGE_OPPONENTS_WEAPON_ID_AND_TAGGED:String = "damage_opponents_weapon_id_and_tagged";
      
      public static const KILLS_COUNTER:String = "kills";
      
      public static const KILLS_BY_OBJECT_OF_TYPE:String = "kills_by_affect_object";
      
      public static const KILLS_BY_DAMAGE_IDS:String = "kills_by_damage_ids";
      
      public static const KILLS_BY_DAMAGE_IDS_AND_TAGGED:String = "kills_by_damage_ids_and_tagged";
      
      public static const KILLS_BY_DAMAGE_IDS_WITH_STATUS_EFFECTS:String = "kills_by_damage_ids_with_status_effect";
      
      public static const KILLS_HAS_BETTER_EQUIPMENT:String = "kills_has_better_equipment";
      
      public static const HIT_OPPONENT_COUNTER:String = "hit_opponent";
      
      public static const HIT_OPPONENT_NOT_YOUR_TURN_COUNTER:String = "hit_opponent_not_your_turn";
      
      public static const HIT_OPPONENT_HAS_BETTER_EQUIPMENT:String = "hit_opponent_has_better_equipment";
      
      public static const DESTROYED_LEVEL_OBJECTS:String = "destroyed_level_objects";
      
      public static const DESTROY_ALL_LEVEL_OBJECTS:String = "destroy_all_level_objects";
      
      public static const DESTROY_ALL_TERRAIN_OBJECTS:String = "destroy_all_terrain_objects";
      
      public static const DEATHS:String = "deaths";
      
      public static const DEATHS_MATCH:String = "deaths_match";
      
      public static const DEATHS_BY_DAMAGE_IDS:String = "deaths_by_damage_ids";
      
      public static const BUY_ITEM_WEAPON:String = "buy_item_Weapon";
      
      public static const BUY_ITEM_CLOTHING:String = "buy_item_Clothing";
      
      public static const BUY_ITEM_BOOSTER:String = "buy_item_Booster";
      
      public static const HITS:String = "hits";
      
      public static const HITS_UNIQUES:String = "hits_uniques";
      
      public static const MISSES:String = "misses";
      
      public static const LONGEST_TURN:String = "longest_turn";
      
      public static const OWN_DAMAGE:String = "own_damage";
      
      public static const MATCHES_FOUGHT:String = "matches_fought";
      
      public static const MATCHES_WON:String = "matches_won";
      
      public static const MATCHES_WON_ROW:String = "matches_won_row";
      
      public static const BOOSTERS_USED:String = "boosters_used";
      
      public static const USE_ONLY_WEAPONS_LIST:String = "use_only_weapons_list";
      
      public static const RESTRICTED_BOOSTERS_LIST:String = "restricted_boosters_list";
      
      public static const RESTRICTED_WEAPONS_LIST:String = "restricted_weapons_list";
      
      public static const FAILING_WEAPONS_LIST:String = "failing_weapons_list";
      
      public static const ACCEPTABLE_WEAPONS_LIST:String = "acceptable_weapons_list";
      
      public static const COLLECTED_POWER_UPS:String = "collected_power_ups";
      
      public static const SAME_SCORE:String = "same_score";
      
      public static const SCORE:String = "score";
      
      public static const SCORE_HIGHEST:String = "score_highest";
      
      public static const USE_DIFFERENT_WEAPON:String = "use_different_weapon";
      
      public static const DISTANCE_GREATER_PLAYER_TO_EXPLOSION_WITH_OBJECT:String = "distance_greater_player_to_explosion_with_object";
      
      public static const DISTANCE_LESS_PLAYER_TO_EXPLOSION_WITH_OBJECT:String = "distance_less_player_to_explosion_with_object";
      
      public static const DISTANCE_GREATER_PLAYER_AND_OBJECT_IN_EXPLOSION:String = "distance_greater_player_and_object_in_explosion";
      
      public static const DISTANCE_LESS_PLAYER_AND_OBJECT_IN_EXPLOSION:String = "distance_less_player_and_object_in_explosion";
      
      public static const REACH_FIRST_FROM_POSITION_IN_TIME:String = "reach_first_from_position_in_time";
      
      public static const ADDED_STATUS_TO_OPPONENT:String = "added_status_to_opponent";
      
      public static const COLLISION_DAMAGE_TAKEN_COUNTER:String = "collision_damage_taken_counter";
      
      public static const COLLISION_DAMAGE_TAKEN_NOT_TAGGED_COUNTER:String = "collision_damage_taken_not_tagged_counter";
      
      public static const COLLISION_DAMAGE_USING_TAG_COUNTER:String = "collision_damage_using_tag_counter";
      
      public static const MATCH_END_HITPOINTS:String = "match_end_hitpoints";
      
      public static const WEAR_SAME_CLOTHES:String = "wear_same_clothes";
      
      public static const FIRE_WEAPON_COLLIDE_AFFECTED_NO_DAMAGE:String = "fire_weapon_collide_affected_no_damage";
      
      public static const GAINED_COINS:String = "gained_coins";
      
      public static const CRAFTED_ITEMS:String = "crafted_items";
      
      public static const HAS_RECIPES:String = "has_recipes";
      
      public static const HAS_RECIPE_IMPOSSIBLE:String = "has_an_impossible_recipe";
      
      public static const HAS_RECIPES_NON_IMPOSSIBLE:String = "has_all_nonimpossible_recipes";
      
      public static const REACH_LEVEL:String = "reached_level";
      
      public static const HAS_ITEM:String = "has_item_";
      
      public static const CRAFTED:String = "crafted_";
      
      public static const USE_WEAPON:String = "use_weapon_";
      
      public static const USE_BOOSTER:String = "use_booster_";
      
      public static const USE_ONLY_WEAPON:String = "use_only_weapon_";
      
      private static const SEPARATOR:String = "_";
      
      private static const BOOLEAN_COUNTER_MAP:Object = {};
      
      private static const COUNTER_MAP:Object = {};
      
      private static const SPECIAL_COUNTERS:Array = ["use_weapon_","use_booster_","use_only_weapon_","crafted_","has_item_"];
      
      {
         BOOLEAN_COUNTER_MAP["reach_first_from_position_in_time"] = ReachFirstFromPositionInTime;
         BOOLEAN_COUNTER_MAP["distance_less_player_to_explosion_with_object"] = DistanceLessPlayerToExplosionWithObjectCounter;
         BOOLEAN_COUNTER_MAP["distance_less_player_and_object_in_explosion"] = DistanceLessPlayerAndObjectInExplosionCounter;
         BOOLEAN_COUNTER_MAP["damage_opponents_less_than"] = DamageOpponentsLessThanCounter;
         COUNTER_MAP["player_fly_time"] = PlayerFlyTimeCounter;
         COUNTER_MAP["missile_fly_time"] = MissileFlyTimeCounter;
         COUNTER_MAP["player_damaged"] = PlayerDamagedCounter;
         COUNTER_MAP["player_damaged_without_dying"] = PlayerDamagedWithoutDying;
         COUNTER_MAP["damage_opponents"] = DamageOpponentsCounter;
         COUNTER_MAP["damage_opponents_less_than"] = DamageOpponentsLessThanCounter;
         COUNTER_MAP["damage_opponents_using_weapon_id"] = DamageOpponentsUsingWeaponIds;
         COUNTER_MAP["damage_opponents_weapon_id_and_tagged"] = DamageOpponentsWeaponIdsAndTagged;
         COUNTER_MAP["kills"] = KillsCounter;
         COUNTER_MAP["kills_by_affect_object"] = KillsByObjectOfTypeCounter;
         COUNTER_MAP["kills_by_damage_ids"] = KillsByDamageIdsCounter;
         COUNTER_MAP["kills_by_damage_ids_and_tagged"] = KillsByDamageIdAndTaggedCounter;
         COUNTER_MAP["kills_by_damage_ids_with_status_effect"] = KillsByDamageWithStatusEffectCounter;
         COUNTER_MAP["kills_has_better_equipment"] = KillsHasBetterEquipmentCounter;
         COUNTER_MAP["hit_opponent"] = HitOpponentCounter;
         COUNTER_MAP["hit_opponent_not_your_turn"] = HitOpponentNotYourTurnCounter;
         COUNTER_MAP["hit_opponent_has_better_equipment"] = HitOpponentHasBetterEquipmentCounter;
         COUNTER_MAP["destroyed_level_objects"] = DestroyedLevelObjectsCounter;
         COUNTER_MAP["deaths"] = DeathsCounter;
         COUNTER_MAP["deaths_match"] = DeathsMatchCounter;
         COUNTER_MAP["deaths_by_damage_ids"] = DeathsByDamageIdCounter;
         COUNTER_MAP["buy_item_Weapon"] = BuyItemWeaponCounter;
         COUNTER_MAP["buy_item_Clothing"] = BuyItemClothingCounter;
         COUNTER_MAP["buy_item_Booster"] = BuyItemBoosterCounter;
         COUNTER_MAP["use_weapon_"] = UseWeaponCounter;
         COUNTER_MAP["use_different_weapon"] = UseDifferentWeaponCounter;
         COUNTER_MAP["use_booster_"] = UseBoosterCounter;
         COUNTER_MAP["boosters_used"] = BoostersUsedCounter;
         COUNTER_MAP["use_only_weapon_"] = UseOnlyWeaponCounter;
         COUNTER_MAP["use_only_weapons_list"] = UseOnlyWeaponsListCounter;
         COUNTER_MAP["restricted_boosters_list"] = RestrictedBoostersListCounter;
         COUNTER_MAP["restricted_weapons_list"] = RestrictedWeaponsListCounter;
         COUNTER_MAP["failing_weapons_list"] = FailingWeaponsList;
         COUNTER_MAP["acceptable_weapons_list"] = AcceptableWeaponsList;
         COUNTER_MAP["hits"] = HitsCounter;
         COUNTER_MAP["hits_uniques"] = HitsUniqueTargetsCounter;
         COUNTER_MAP["misses"] = MissesCounter;
         COUNTER_MAP["longest_turn"] = LongestTurnCounter;
         COUNTER_MAP["own_damage"] = OwnDamageCounter;
         COUNTER_MAP["matches_fought"] = MatchesFoughtCounter;
         COUNTER_MAP["matches_won"] = MatchesWonCounter;
         COUNTER_MAP["matches_won_row"] = MatchesWonRowCounter;
         COUNTER_MAP["collected_power_ups"] = CollectedPowerUpsCounter;
         COUNTER_MAP["destroy_all_level_objects"] = DestroyAllLevelObjectsCounter;
         COUNTER_MAP["destroy_all_terrain_objects"] = DestroyAllTerrainObjectsCounter;
         COUNTER_MAP["same_score"] = SameScoreCounter;
         COUNTER_MAP["distance_greater_player_to_explosion_with_object"] = DistanceGreaterPlayerToExplosionWithObjectCounter;
         COUNTER_MAP["distance_less_player_to_explosion_with_object"] = DistanceLessPlayerToExplosionWithObjectCounter;
         COUNTER_MAP["distance_greater_player_and_object_in_explosion"] = DistanceGreaterPlayerAndObjectInExplosionCounter;
         COUNTER_MAP["distance_less_player_and_object_in_explosion"] = DistanceLessPlayerAndObjectInExplosionCounter;
         COUNTER_MAP["reach_first_from_position_in_time"] = ReachFirstFromPositionInTime;
         COUNTER_MAP["score"] = ScoreCounter;
         COUNTER_MAP["score_highest"] = ScoreHighestCounter;
         COUNTER_MAP["added_status_to_opponent"] = AddedStatusToOpponentCounter;
         COUNTER_MAP["collision_damage_taken_counter"] = CollisionDamageToSelfCounter;
         COUNTER_MAP["collision_damage_taken_not_tagged_counter"] = CollisionDamageToSelfNotTaggedCounter;
         COUNTER_MAP["collision_damage_using_tag_counter"] = CollisionDamageUsingTagCounter;
         COUNTER_MAP["match_end_hitpoints"] = MatchEndHitpointsCounter;
         COUNTER_MAP["wear_same_clothes"] = WearSameClothes;
         COUNTER_MAP["fire_weapon_collide_affected_no_damage"] = FireWeaponIDCollideAffectsIDNoDamage;
         COUNTER_MAP["gained_coins"] = GainedCoinsCounter;
         COUNTER_MAP["reached_level"] = ReachLevelCounter;
         COUNTER_MAP["has_recipes"] = HasRecipesCounter;
         COUNTER_MAP["has_an_impossible_recipe"] = HasRecipeImpossibleCounter;
         COUNTER_MAP["has_all_nonimpossible_recipes"] = HasRecipesNonImpossibleCounter;
         COUNTER_MAP["crafted_items"] = CraftedItemsCounter;
         COUNTER_MAP["crafted_"] = CraftedCounter;
         COUNTER_MAP["has_item_"] = HasItemCounter;
      }
      
      public function CounterFactory()
      {
         super();
         throw new Error("CounterFactory is a static class!");
      }
      
      public static function createCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:*) : Counter
      {
         var _loc6_:* = null;
         if(isSpecialCounter(id))
         {
            _loc6_ = getBaseId(id);
            if(COUNTER_MAP.hasOwnProperty(_loc6_))
            {
               return new COUNTER_MAP[_loc6_](challenge,id,targetValue,playerId,params);
            }
         }
         if(COUNTER_MAP.hasOwnProperty(id))
         {
            return new COUNTER_MAP[id](challenge,id,targetValue,playerId,params);
         }
         LogUtils.log("Trying to create a unknown counter: " + id,"CounterFactory",3,"Challenges",false,false,true);
         return null;
      }
      
      public static function isBooleanClass(id:String) : *
      {
         return BOOLEAN_COUNTER_MAP[id] != null;
      }
      
      private static function isSpecialCounter(id:String) : Boolean
      {
         var baseName:String = getBaseId(id);
         return SPECIAL_COUNTERS.indexOf(baseName) != -1;
      }
      
      private static function getBaseId(id:String) : String
      {
         var _loc2_:int = id.lastIndexOf("_") + 1;
         return id.substring(0,_loc2_);
      }
   }
}
