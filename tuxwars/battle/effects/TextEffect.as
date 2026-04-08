package tuxwars.battle.effects
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.utils.*;
   
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
      
      public function TextEffect(param1:int, param2:String, param3:int, param4:int, param5:* = null)
      {
         var _loc6_:int = 0;
         super();
         this.effectType = param1;
         switch(this.effectType)
         {
            case 0:
               this.createDamageComponent(param2);
               break;
            case 1:
               this.createGainHealthComponent(param2);
               break;
            case 2:
               this.createGainPointsComponent(param2);
               break;
            case 3:
               this.createItemAnimationComponent();
               break;
            case 4:
               this.createTurnStartComponent();
               break;
            case 5:
               this.createInfoComponent(param2);
               break;
            case 6:
               this.create1MinuteLeftComponent();
               break;
            case 7:
               this.create10SecondsLeftComponent(param5);
               break;
            case 8:
               this.createBetComponent();
         }
         if(this.component)
         {
            _loc6_ = int(DCUtils.indexOfLabel(this.component,"end"));
            this.component.addFrameScript(_loc6_,this.endClip);
            this.component.x = param3;
            this.component.y = param4;
            this.component.mouseChildren = false;
            this.component.mouseEnabled = false;
            this.component.cacheAsBitmap = true;
         }
      }
      
      private function createInfoComponent(param1:String) : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","player_turn_name");
         this.component.getChildByName("Player_Turn_1").visible = false;
         this.component.getChildByName("Player_Turn_2").visible = false;
         this.component.getChildByName("Player_Turn_3").visible = false;
         this.component.getChildByName("Player_Turn_4").visible = false;
         this.component.getChildByName("Timer_Turn").visible = false;
         var _loc2_:MovieClip = this.component.getChildByName("Timer_Turn") as MovieClip;
         _loc2_.visible = true;
         TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text_Name,param1);
      }
      
      private function createTurnStartComponent() : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","message_your_turn");
         var _loc1_:MovieClip = this.component.Message as MovieClip;
         _loc1_.visible = true;
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text_01,ProjectManager.getText("BATTLE_TEXT_MESSAGE_YOUR"));
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text_02,ProjectManager.getText("BATTLE_TEXT_MESSAGE_TURN"));
      }
      
      private function create1MinuteLeftComponent() : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","message_time_alert");
         var _loc1_:MovieClip = this.component.Message as MovieClip;
         _loc1_.visible = true;
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text_01,ProjectManager.getText("BATTLE_TEXT_MESSAGE_MINUTE"));
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text_02,ProjectManager.getText("BATTLE_TEXT_MESSAGE_LEFT"));
      }
      
      private function create10SecondsLeftComponent(param1:int) : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","match_count_0" + (param1 + 1)) as MovieClip;
         this.component.gotoAndPlay(0);
      }
      
      private function createGainHealthComponent(param1:String) : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","health_total_text");
         var _loc2_:MovieClip = this.component.getChildByName("Content") as MovieClip;
         TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text,param1);
      }
      
      private function createGainPointsComponent(param1:String) : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","points_total_text_animation");
         var _loc2_:MovieClip = this.component.getChildByName("Content") as MovieClip;
         TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text,param1);
      }
      
      private function createItemAnimationComponent() : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","item_animation");
      }
      
      private function createDamageComponent(param1:String) : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","damage_total_text");
         var _loc2_:MovieClip = this.component.getChildByName("Content") as MovieClip;
         if(Boolean(param1) && param1.indexOf("-") == -1)
         {
            param1 = "-" + param1;
         }
         TuxUiUtils.createAutoTextFieldWithText(_loc2_.Text,param1);
      }
      
      private function createBetComponent() : void
      {
         this.component = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","bet_text_animation");
         var _loc1_:MovieClip = this.component.getChildByName("Content") as MovieClip;
         TuxUiUtils.createAutoTextFieldWithText(_loc1_.Text,ProjectManager.getText("INGAME_BETTING_BET_EFFECT"));
      }
      
      public function get movieClip() : MovieClip
      {
         return this.component;
      }
      
      public function get type() : int
      {
         return this.effectType;
      }
      
      public function isFinished() : Boolean
      {
         return this.finished;
      }
      
      private function endClip() : void
      {
         if(this.component)
         {
            this.component.stop();
            this.component.addFrameScript(DCUtils.indexOfLabel(this.component,"end"),null);
         }
         this.finished = true;
      }
      
      public function dispose() : void
      {
         if(Boolean(this.component) && Boolean(this.component.parent))
         {
            this.component.addFrameScript(DCUtils.indexOfLabel(this.component,"end"),null);
            this.component.stop();
            this.component.parent.removeChild(this.component);
         }
         this.component = null;
      }
      
      public function setXY(param1:Number, param2:Number) : void
      {
         this.component.x = param1;
         this.component.y = param2;
      }
   }
}

