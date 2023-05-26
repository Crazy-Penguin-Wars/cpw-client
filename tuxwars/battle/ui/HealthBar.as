package tuxwars.battle.ui
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.progress.UIProgressIndicator;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class HealthBar extends Sprite
   {
      
      private static const PLAYER_TAG:String = "player_tag";
      
      private static const PLAYER_TAG_INDEX:String = "Player_Tag_";
      
      private static const TEXT_FIELD:String = "Text_Name";
      
      private static const LIFE_BAR:String = "Life_Bar";
       
      
      private var healthBar:UIProgressIndicator;
      
      private var player:PlayerGameObject;
      
      public function HealthBar(player:PlayerGameObject)
      {
         super();
         this.player = player;
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","player_tag");
         var _loc2_:int = player.getTabIndex();
         var _loc5_:MovieClip = _loc4_.getChildByName("Player_Tag_" + _loc2_) as MovieClip;
         var _loc6_:* = player;
         _loc5_.Text_Name.text = _loc6_._name;
         var _loc3_:MovieClip = _loc5_.getChildByName("Life_Bar") as MovieClip;
         healthBar = new UIProgressIndicator(_loc3_,0,player.calculateMaxHitPoints());
         healthBar.setValueWithoutBarAnimation(player.calculateHitPoints());
         addChild(_loc5_);
         _loc5_.stop();
         _loc5_.cacheAsBitmap = true;
      }
      
      public function dispose() : void
      {
         player = null;
         healthBar.dispose();
         healthBar = null;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         if(player.calculateHitPoints() != healthBar.getCurrentValue())
         {
            healthBar.setValue(Math.max(player.calculateHitPoints(),0));
         }
         healthBar.logicUpdate(deltaTime);
      }
   }
}
