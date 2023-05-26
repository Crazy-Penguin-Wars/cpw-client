package tuxwars.battle.effects
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import tuxwars.utils.TuxUiUtils;
   
   public class TextEffect extends Sprite
   {
      
      public static const TYPE_DAMAGE:int = 0;
      
      public static const TYPE_GAIN_HEALTH:int = 1;
      
      public static const TYPE_GAIN_POINTS:int = 2;
      
      public static const TYPE_ITEM_ANIMATION:int = 3;
      
      public static const TYPE_TURN_START:int = 4;
      
      public static const TYPE_INFO:int = 5;
      
      public static const TYPE_1MINUTE_LEFT:int = 6;
      
      public static const TYPE_10_SECONDS_LEFT:int = 7;
      
      public static const TYPE_BET:int = 8;
      
      private static const DAMAGE_TOTAL_TEXT:String = "damage_total_text";
      
      private static const HEALTH_TOTAL_TEXT:String = "health_total_text";
      
      private static const POINTS_TOTAL_TEXT:String = "points_total_text_animation";
      
      private static const ITEM_ANIMATION:String = "item_animation";
      
      private static const CONTENT:String = "Content";
      
      private static const TURN_START_TURN_NAME:String = "player_turn_name";
      
      private static const TURN_START_TURN_NAME_FANCY:String = "message_your_turn";
      
      public static const TURN_START_PLAYER:String = "Player_Turn_";
      
      public static const TURN_START_PLAYER_1:String = "Player_Turn_1";
      
      public static const TURN_START_PLAYER_2:String = "Player_Turn_2";
      
      public static const TURN_START_PLAYER_3:String = "Player_Turn_3";
      
      public static const TURN_START_PLAYER_4:String = "Player_Turn_4";
      
      public static const INFO_TEXT:String = "Timer_Turn";
      
      private static const MESSAGE_1MINUTE:String = "message_time_alert";
      
      private static const BET_TEXT:String = "bet_text_animation";
       
      
      private var component:MovieClip;
      
      private var finished:Boolean;
      
      private var effectType:int;
      
      public function TextEffect(type:int, text:String, x:int, y:int, params:* = null)
      {
         var _loc6_:int = 0;
         super();
         effectType = type;
         switch(effectType)
         {
            case 0:
               createDamageComponent(text);
               break;
            case 1:
               createGainHealthComponent(text);
               break;
            case 2:
               createGainPointsComponent(text);
               break;
            case 3:
               createItemAnimationComponent();
               break;
            case 4:
               createTurnStartComponent();
               break;
            case 5:
               createInfoComponent(text);
               break;
            case 6:
               create1MinuteLeftComponent();
               break;
            case 7:
               create10SecondsLeftComponent(params);
               break;
            case 8:
               createBetComponent();
         }
         if(component)
         {
            _loc6_ = DCUtils.indexOfLabel(component,"end");
            component.addFrameScript(_loc6_,endClip);
            component.x = x;
            component.y = y;
            component.mouseChildren = false;
            component.mouseEnabled = false;
            component.cacheAsBitmap = true;
         }
      }
      
      private function createInfoComponent(text:String) : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","player_turn_name");
         component.getChildByName("Player_Turn_1").visible = false;
         component.getChildByName("Player_Turn_2").visible = false;
         component.getChildByName("Player_Turn_3").visible = false;
         component.getChildByName("Player_Turn_4").visible = false;
         component.getChildByName("Timer_Turn").visible = false;
         var _loc2_:MovieClip = component.getChildByName("Timer_Turn") as MovieClip;
         _loc2_.visible = true;
         TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text_Name,text);
      }
      
      private function createTurnStartComponent() : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","message_your_turn");
         var _loc1_:MovieClip = component.Message as MovieClip;
         _loc1_.visible = true;
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text_01,ProjectManager.getText("BATTLE_TEXT_MESSAGE_YOUR"));
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text_02,ProjectManager.getText("BATTLE_TEXT_MESSAGE_TURN"));
      }
      
      private function create1MinuteLeftComponent() : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","message_time_alert");
         var _loc1_:MovieClip = component.Message as MovieClip;
         _loc1_.visible = true;
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text_01,ProjectManager.getText("BATTLE_TEXT_MESSAGE_MINUTE"));
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text_02,ProjectManager.getText("BATTLE_TEXT_MESSAGE_LEFT"));
      }
      
      private function create10SecondsLeftComponent(index:int) : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","match_count_0" + (index + 1)) as MovieClip;
         component.gotoAndPlay(0);
      }
      
      private function createGainHealthComponent(text:String) : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","health_total_text");
         var _loc2_:MovieClip = component.getChildByName("Content") as MovieClip;
         TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text,text);
      }
      
      private function createGainPointsComponent(text:String) : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","points_total_text_animation");
         var _loc2_:MovieClip = component.getChildByName("Content") as MovieClip;
         TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text,text);
      }
      
      private function createItemAnimationComponent() : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","item_animation");
      }
      
      private function createDamageComponent(text:String) : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","damage_total_text");
         var _loc2_:MovieClip = component.getChildByName("Content") as MovieClip;
         if(text && text.indexOf("-") == -1)
         {
            text = "-" + text;
         }
         TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text,text);
      }
      
      private function createBetComponent() : void
      {
         component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","bet_text_animation");
         var _loc1_:MovieClip = component.getChildByName("Content") as MovieClip;
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text,ProjectManager.getText("INGAME_BETTING_BET_EFFECT"));
      }
      
      public function get movieClip() : MovieClip
      {
         return component;
      }
      
      public function get type() : int
      {
         return effectType;
      }
      
      public function isFinished() : Boolean
      {
         return finished;
      }
      
      private function endClip() : void
      {
         if(component)
         {
            component.stop();
            component.addFrameScript(DCUtils.indexOfLabel(component,"end"),null);
         }
         finished = true;
      }
      
      public function dispose() : void
      {
         if(component && component.parent)
         {
            component.addFrameScript(DCUtils.indexOfLabel(component,"end"),null);
            component.stop();
            component.parent.removeChild(component);
         }
         component = null;
      }
      
      public function setXY(x:Number, y:Number) : void
      {
         component.x = x;
         component.y = y;
      }
   }
}
