package tuxwars
{
   public class Assets
   {
      
      public static const CHARACTER_UI:String = "flash/ui/character_ui.swf";
      
      public static const INGAME_BATTLE_HUD:String = "flash/ui/ingame.swf";
      
      public static const ICONS_DROPS:String = "flash/ui/icons_drops.swf";
      
      public static const MULTIPLAYER_SCREEN:String = "flash/ui/multiplayer.swf";
      
      public static const HOME_SCREEN:String = "flash/ui/home_screen.swf";
      
      public static const LOADING_ANIM:String = "flash/ui/loading_anim.swf";
      
      public static const HUD_SHARED:String = "flash/ui/hud_shared.swf";
      
      public static const HUD_TROPHIES:String = "flash/hud/hud_trophies.swf";
      
      public static const SHOPS_NEW:String = "flash/ui/shops_new.swf";
      
      public static const CRAFTING:String = "flash/ui/crafting_screens.swf";
      
      public static const TOP_BAR_POPUPS:String = "flash/ui/top_bar_popups.swf";
      
      public static const CHALLENGE_SCREEN:String = "flash/ui/challenges_screen.swf";
      
      public static const POPUPS:String = "flash/ui/popups.swf";
      
      public static const SLOTMACHINE:String = "flash/ui/slot_machine.swf";
      
      public static const DAILY_NEWS:String = "flash/ui/daily_news.swf";
      
      public static const FRIEND_SELECTOR:String = "flash/ui/select_friends.swf";
      
      public static const LEADERBOARD:String = "flash/ui/leaderboard.swf";
      
      public static const TOURNAMENT:String = "flash/ui/tournament.swf";
      
      public static const DYNAMIC_OBJECTS:String = "dynamicobjects/";
      
      public static const CONFIG_DATA_FILE:String = "json/tuxwars_config_base.json";
      
      public static const PARTICLES:String = "particles/particles.xml";
      
      public static const MAP_ICONS:String = "flash/ui/icons_maps.swf";
      
      public static const BOOSTER_EFFECTS:String = "flash/fx/boosters.swf";
      
      public static const PENGUIN_ANIMATIONS:String = "flash/characters/penguin_animations.swf";
      
      public static const OVERHEAD_ANIMATIONS:String = "flash/characters/penguin_overhead_animations.swf";
       
      
      public function Assets()
      {
         super();
      }
      
      public static function getLanguageFile() : String
      {
         return "json/tuxwars_config_" + Config.getLanguageCode() + ".json";
      }
   }
}
