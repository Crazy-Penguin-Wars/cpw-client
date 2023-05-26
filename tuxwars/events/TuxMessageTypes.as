package tuxwars.events
{
   public class TuxMessageTypes
   {
      
      public static const TEXT_ID:String = "TextID";
      
      public static const ERROR_MESSAGE:String = "ErrorMessage";
      
      public static const WRONG_VERSION:String = "Wrong Version";
      
      public static const PLAYER_FIRED:String = "PlayerFired";
      
      public static const MATCH_STARTED:String = "MatchStarted";
      
      public static const MATCH_ENDED:String = "MatchEnded";
      
      public static const BATTLE_SERVER_CONNECTED:String = "BattleServerConnected";
      
      public static const BATTLE_SERVER_CONNECTION_FAILED:String = "BattleServerConnectionFailed";
      
      public static const IS_MAINTENANCE_MODE:String = "MaintenanceMode";
      
      public static const IS_MAINTENANCE_MODE_REPLY:String = "MaintenanceModeReply";
      
      public static const ACTION_RESPONSE:String = "ActionResponse";
      
      public static const GET_GAME:String = "GetGame";
      
      public static const SEND_GAME:String = "SendGame";
      
      public static const VIP_STATUS_CHANGED:String = "VipStatusChanged";
      
      public static const WEAPON_PUT_AWAY:String = "WeaponPutAwayAnimPlayed";
      
      public static const FIRE_EMISSIONS:String = "FireEmissions";
      
      public static const PLAYER_TURN_STARTED:String = "PlayerTurnStarted";
      
      public static const PLAYER_TURN_ENDED:String = "PlayerTurnEnded";
      
      public static const PLAYER_DISCONNECTED:String = "PlayerDisconnected";
      
      public static const PLAYER_REMOVED:String = "PlayerRemoved";
      
      public static const PLAYER_WALK_MODE_ACTIVATED:String = "PlayerWalkMode";
      
      public static const PLAYER_FIRE_MODE_ACTIVATED:String = "PlayerFireMode";
      
      public static const HUD_MOUSE_OVER:String = "HUDMouseOver";
      
      public static const HUD_MOUSE_OUT:String = "HUDMouseOut";
      
      public static const HUD_REQUEST_MOUSE_OVER_STATUS:String = "HUDRequestMouseOverStatus";
      
      public static const UPDATE_GAME_WORLD:String = "UpdateGameWorld";
      
      public static const POWER_UP_OBJECT_CREATED:String = "PowerUpObjectCreated";
      
      public static const POWER_UP_PICKED_UP:String = "PowerUpPickedUp";
      
      public static const ITEM_SELECTED:String = "ItemSelected";
      
      public static const WEAPON_SELECTED:String = "WeaponSelected";
      
      public static const BOOSTER_BOUGHT:String = "BoosterBought";
      
      public static const BOOSTER_SELECTED:String = "BooserSelected";
      
      public static const BOOSTER_ACTIVATED:String = "BoosterActivated";
      
      public static const BOOSTER_READY_SHINE:String = "BoosterReadyShine";
      
      public static const EMOTICON_SELECTED:String = "EmoticonSelected";
      
      public static const EMOTICON_USED:String = "EmoticonUsed";
      
      public static const EMOTICON_READY_SHINE:String = "EmoticonReadyShine";
      
      public static const ITEM_SELECTED_SHOP:String = "ItemSelectedShop";
      
      public static const SEND_FPS:String = "SendFps";
      
      public static const UNLOCK_ITEM:String = "UnlockItem";
      
      public static const ITEM_UNLOCKED:String = "ItemUnlocked";
      
      public static const EQUIP_ITEM:String = "EquipItem";
      
      public static const UNEQUIP_ITEM:String = "UnequipItem";
      
      public static const ITEM_EQUIPPED:String = "ItemEquipped";
      
      public static const ITEM_UNEQUIPPED:String = "ItemUnEquipped";
      
      public static const BUY_ITEM:String = "BuyItem";
      
      public static const ITEM_BOUGHT:String = "ItemBought";
      
      public static const BUY_ITEM_LEVEL_UP_SALES:String = "BuyItemLevelUpSales";
      
      public static const ITEM_BOUGHT_LEVEL_UP_SALES:String = "ItemBoughtLevelUpSales";
      
      public static const BUY_ITEM_COUPON_SALES:String = "BuyItemCouponSales";
      
      public static const ITEM_BOUGHT_COUPON_SALES:String = "ItemBoughtCouponSales";
      
      public static const CLOSE_LEVEL_UP_SALES:String = "ClearLevelUpSale";
      
      public static const ITEM_DETAILS:String = "ItemDetails";
      
      public static const ITEM_UNLOCK_ICON:String = "UnlockIcon";
      
      public static const ITEM_LOCK_ICON:String = "LockIcon";
      
      public static const INVENTORY_UPDATED:String = "InventoryUpdated";
      
      public static const WORN_ITEMS_UPDATED:String = "WornItemsUpdated";
      
      public static const BATTLE_ASSETS_LOADED:String = "BattleAssetsLoaded";
      
      public static const INGAME_MONEY_CHANGED:String = "IngameMoneyChanged";
      
      public static const PREMIUM_MONEY_CHANGED:String = "PremiumMoneyChanged";
      
      public static const EXP_CHANGED:String = "ExperienceChanged";
      
      public static const LEVEL_UP:String = "LevelUp";
      
      public static const CHALLENGE_AMMO_HIT:String = "ChallengeAmmoHit";
      
      public static const CHALLENGE_PHYSICS_OBJECT_CONTACT:String = "ChallengePhysicsObjectContact";
      
      public static const CHALLENGE_PLAYER_DIED:String = "ChallengePlayerDied";
      
      public static const CHALLENGE_LEVEL_OBJECT_DESTROYED:String = "ChallengeLevelObjectDestroyed";
      
      public static const CHALLENGE_ITEM_BOUGHT:String = "ChallengeItemBought";
      
      public static const CHALLENGE_ITEM_GAINED:String = "ChallengeItemGained";
      
      public static const CHALLENGE_GAINED_COINS:String = "ChallengeGainedCoins";
      
      public static const CHALLENGE_REACH_LEVEL:String = "ChallengeReachedLevel";
      
      public static const CHALLENGE_ITEM_CRAFTED:String = "ChallengeItemCrafted";
      
      public static const CHALLENGE_WEAPON_USED:String = "ChallengeWeaponUsed";
      
      public static const CHALLENGE_BOOSTER_USED:String = "ChallengeBoosterUsed";
      
      public static const CHALLENGE_COMPLETED:String = "ChallengeCompleted";
      
      public static const CHALLENGE_END_GAME_CONFIRM:String = "ChallengeEndGameConfirm";
      
      public static const CHALLENGE_SCORE_CHANGE:String = "ChallengeScoreChange";
      
      public static const CHALLENGES_UPDATED:String = "ChallengesUpdated";
      
      public static const CHALLENGE_TAKE_COLLISION_DAMAGE:String = "ChallengeTakeCollisionDamage";
      
      public static const EMISSION_NOTIFICATION:String = "EmissionNotification";
      
      public static const FREE_WEAPON_PACKAGE:String = "FreeWeaponPackage";
      
      public static const FREE_WEAPON_PACKAGE_RESPONSE:String = "FreeWeaponPackageResponse";
      
      public static const MISSILE_EMITTER:String = "MissileEmitter";
      
      public static const EXPLOSION_EMITTER:String = "ExplosionEmitter";
      
      public static const ANIMATION_EMITTER:String = "AnimationEmitter";
      
      public static const TURN_COMPLETED:String = "TurnCompleted";
      
      public static const PLAY_START_MUSIC:String = "PlayMusic";
      
      public static const PLAY_LOOP_MUSIC:String = "LoopMusic";
      
      public static const PLAY_START_SOUND:String = "PlaySound";
      
      public static const PLAY_COLLISION_SOUND:String = "PlayCollisionSound";
      
      public static const PLAY_LOOP_SOUND:String = "LoopSound";
      
      public static const PLAY_END_SOUND:String = "EndSound";
      
      public static const STOP_SOUND:String = "StopSound";
      
      public static const STOP_ALL_SOUND:String = "StopAllSound";
      
      public static const MUTE_MUSIC:String = "MuteMusic";
      
      public static const MUTE_SFX:String = "MuteSfx";
      
      public static const PLAYER_DIED:String = "PlayerDied";
      
      public static const PLAYER_SPAWNED:String = "PlayerSpawned";
      
      public static const CRAFT_ITEM:String = "CraftItem";
      
      public static const ITEM_CRAFTED:String = "ItemCrafted";
      
      public static const RESEARCH_START:String = "ResearchStart";
      
      public static const RESEARCH_COMPLETE:String = "ResearchComplete";
      
      public static const RESEARCH_COMPLETE_INSTANT:String = "ResearchCompleteInstant";
      
      public static const RESEARCH_NO_RESULT:String = "ResearchNoResult";
      
      public static const RESEARCH_SUCCESS:String = "ResearchSuccess";
      
      public static const RESEARCH_UPDATE_SCREEN:String = "ResearchUpdateScreen";
      
      public static const RESEARCH_INGRIDIENTS_UPDATED:String = "ResearchIngridientsUpdated";
      
      public static const RESEARCH_COLLECT_REWARDS:String = "CollectResearchRewards";
      
      public static const RESEARCH_COLLECT_REWARDS_RESPONSE:String = "CollectResearchRewardsResponse";
      
      public static const START_COLLISION_PLAYBACK:String = "StartCollisionPlayback";
      
      public static const SIMPLE_SCRIPT_RUN:String = "SimpleScriptRun";
      
      public static const GIFT_ACCEPT:String = "InboxGiftAccept";
      
      public static const GIFT_ACCEPT_RECEIPT:String = "InboxGiftAcceptReceipt";
      
      public static const CHECK_GIFT_STATUS:String = "CheckGiftStatus";
      
      public static const GIFT_STATUS_CHECKED:String = "GiftStatusChecked";
      
      public static const CAN_SEND_GIFT_BACK:String = "CanSendGiftBackToSender";
      
      public static const CAN_SEND_GIFT_BACK_CHECKED:String = "CanSendGiftBackToSenderChecked";
      
      public static const NEIGHBOR_REJECT:String = "NeighborIgnore";
      
      public static const NEIGHBOR_CANCEL:String = "NeighbourCancel";
      
      public static const NEIGHBOR_ACCEPT:String = "NeighborAccept";
      
      public static const NEIGHBOR_REMOVE:String = "NeighbourRemove";
      
      public static const INBOX_CONTENT_UPDATE:String = "InboxContentUpdate";
      
      public static const INBOX_UPDATE:String = "InboxUpdate";
      
      public static const INBOX_UPDATED:String = "InboxUpdated";
      
      public static const INBOX_UPDATE_COUNTER:String = "InboxUpdateCounter";
      
      public static const TOURNAMENT_UPDATE:String = "TournamentUpdate";
      
      public static const TOURNAMENT_UPDATED:String = "TournamentUpdated";
      
      public static const UPDATE_TOURNAMENT_SCREEN:String = "UpdateTournamentScreen";
      
      public static const TOURNAMENT_REWARD_CLAIM:String = "CollectTournamentRewards";
      
      public static const TOURNAMENT_REWARD_CLAIMED:String = "TournamentRewardClaimed";
      
      public static const FULL_SCREEN:String = "FullScreen";
      
      public static const SCORE_CHANGED:String = "ScoreChanged";
      
      public static const SLOTMACHINE_STOP_REEL:String = "SlotMachineStopReel";
      
      public static const SLOTMACHINE_CHECK_LINE:String = "SlotMachineCheckLine";
      
      public static const SLOTMACHINE_NEXT_WIN_LINE:String = "NextWinLine";
      
      public static const SLOTMACHINE_SERVER_PLAY:String = "SlotMachineServerPlay";
      
      public static const SLOTMACHINE_SERVER_PLAY_RESPONSE:String = "SlotMachineServerPlayResponse";
      
      public static const SLOTMACHINE_SERVER_RESET_SPINS:String = "SlotMachineServerResetSpins";
      
      public static const SLOTMACHINE_SERVER_RESET_SPINS_RESPONSE:String = "SlotMachineServerResetSpinsResponse";
      
      public static const SLOTMACHINE_FREE_SPINS_USED:String = "SlotMachineFreeSpinsUsed";
      
      public static const CHALLENGES_UPDATE_SERVER_RESPONSE:String = "ChallengesUpdateServerResponse";
      
      public static const CHALLENGES_COMPLETE_UPDATE_NOT_IN_BATTLE:String = "ChallengeCompleteUpdateNotInBattle";
      
      public static const CHALLENGES_STATE_CHANGED:String = "ChallengeStateChanged";
      
      public static const MISSILE_MARKED_FOR_EXPLOSION:String = "MissileMarkedForExplosion";
      
      public static const TUTORIAL_END:String = "TutorialEnd";
      
      public static const HELP_HUD_START_INFOARROW:String = "HelpHudStartInfoArrow";
      
      public static const HELP_HUD_END_INFOARROW:String = "HelpHudEndInfoArrow";
      
      public static const HELP_HUD_START_SHOOT:String = "HelpHudStartShoot";
      
      public static const HELP_HUD_END_SHOOT:String = "HelpHudEndShoot";
      
      public static const HELP_HUD_START_MOVE:String = "HelpHudStartMove";
      
      public static const HELP_HUD_END_MOVE:String = "HelpHudEndMove";
      
      public static const HELP_HUD_START_MOVE_TIMER:String = "HelpHudStartMoveTimer";
      
      public static const HELP_HUD_CANCEL_MOVE_TIMER:String = "HelpHudCancelMoveTimer";
      
      public static const REPORT_EXPLOSION:String = "ReportExplosion";
      
      public static const REPORT_LEVEL_OBJECT_DESTROYED:String = "LevelObjectDestroyed";
      
      public static const REPORT_MISSILE_CONTACT:String = "MissileContact";
      
      public static const REPORT_TERRAIN_DESTROYED:String = "TerrainDestroyed";
      
      public static const REPORT_EMOTICONS:String = "Emoticons";
      
      public static const REPORT_JUMPS:String = "Jumps";
      
      public static const REPORT_EXITS:String = "Exits";
      
      public static const SHOW_MONEY_STATE:String = "showMoneyState";
      
      public static const INGAME_BET_PLACED:String = "ingameBetPlaced";
      
      public static const INGAME_BET_MULTIPLIER_UPDATED:String = "ingameBetMultiplierChanged";
       
      
      public function TuxMessageTypes()
      {
         super();
         throw new Error("TuxMessageTypes is a static class!");
      }
   }
}
