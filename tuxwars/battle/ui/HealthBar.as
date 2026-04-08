package tuxwars.battle.ui
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.progress.*;
   import flash.display.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class HealthBar extends Sprite
   {
      private static const PLAYER_TAG:String = "player_tag";
      
      private static const PLAYER_TAG_INDEX:String = "Player_Tag_";
      
      private static const TEXT_FIELD:String = "Text_Name";
      
      private static const LIFE_BAR:String = "Life_Bar";
      
      private var healthBar:UIProgressIndicator;
      
      private var player:PlayerGameObject;
      
      public function HealthBar(param1:PlayerGameObject)
      {
         super();
         this.player = param1;
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","player_tag");
         var _loc3_:int = param1.getTabIndex();
         var _loc4_:MovieClip = _loc2_.getChildByName("Player_Tag_" + _loc3_) as MovieClip;
         var _loc5_:* = param1;
         _loc4_.Text_Name.text = _loc5_._name;
         var _loc6_:MovieClip = _loc4_.getChildByName("Life_Bar") as MovieClip;
         this.healthBar = new UIProgressIndicator(_loc6_,0,param1.calculateMaxHitPoints());
         this.healthBar.setValueWithoutBarAnimation(param1.calculateHitPoints());
         addChild(_loc4_);
         _loc4_.stop();
         _loc4_.cacheAsBitmap = true;
      }
      
      public function dispose() : void
      {
         this.player = null;
         this.healthBar.dispose();
         this.healthBar = null;
      }
      
      public function logicUpdate(param1:int) : void
      {
         if(this.player.calculateHitPoints() != this.healthBar.getCurrentValue())
         {
            this.healthBar.setValue(Math.max(this.player.calculateHitPoints(),0));
         }
         this.healthBar.logicUpdate(param1);
      }
   }
}

