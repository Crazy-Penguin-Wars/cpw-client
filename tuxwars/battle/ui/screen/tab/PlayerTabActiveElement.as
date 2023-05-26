package tuxwars.battle.ui.screen.tab
{
   import com.dchoc.game.LogicUpdater;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.progress.UIProgressIndicator;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.battle.data.player.Players;
   import tuxwars.battle.ui.logic.BattleHudPlayerData;
   
   public class PlayerTabActiveElement extends PlayerTabElement
   {
      
      private static const BACK_ACTIVE:String = "Back_Active";
      
      private static const PLACE_TAG:String = "Place_Tag";
      
      private static const PLACE:String = "Place_";
      
      private static const TEXT_PLACE:String = "Text_Place";
      
      private static const SLIDER_LIFEBAR:String = "Slider_Lifebar";
       
      
      private var placeTags:UIContainers;
      
      private var backActive:MovieClip;
      
      private var currentPlace:int;
      
      private var healthBar:UIProgressIndicator;
      
      public function PlayerTabActiveElement(design:MovieClip, name:String, parent:UIComponent = null)
      {
         super(design,name,parent);
         placeTags = new UIContainers();
         var _loc4_:MovieClip = design.getChildByName("Place_Tag") as MovieClip;
         placeTags.add("Place_" + 1,new UIContainer(_loc4_.getChildByName("Place_" + 1) as MovieClip,this));
         placeTags.add("Place_" + 2,new UIContainer(_loc4_.getChildByName("Place_" + 2) as MovieClip,this));
         placeTags.add("Place_" + 3,new UIContainer(_loc4_.getChildByName("Place_" + 3) as MovieClip,this));
         placeTags.add("Place_" + 4,new UIContainer(_loc4_.getChildByName("Place_" + 4) as MovieClip,this));
         currentPlace = 4;
         placeTags.show("Place_" + currentPlace,false);
         updatePlaceText();
         backActive = design.getChildByName("Back_Active") as MovieClip;
         backActive.visible = false;
         healthBar = new UIProgressIndicator(design.getChildByName("Slider_Lifebar") as MovieClip,0,Players.getPlayerData().getHitPoints());
         healthBar.setValueWithoutBarAnimation(Players.getPlayerData().getHitPoints());
         LogicUpdater.register(this,"PlayerTabActiveElement");
      }
      
      override public function dispose() : void
      {
         LogicUpdater.unregister(this,"PlayerTabActiveElement");
         healthBar.dispose();
         healthBar = null;
         backActive = null;
         placeTags.dispose();
         placeTags = null;
         super.dispose();
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         healthBar.logicUpdate(deltaTime);
      }
      
      override public function updatePlayer(player:BattleHudPlayerData) : void
      {
         super.updatePlayer(player);
         if(player.place != currentPlace)
         {
            currentPlace = player.place;
            placeTags.show("Place_" + currentPlace,false);
            updatePlaceText();
         }
         healthBar.setValue(player.hitPoints);
         backActive.visible = player.status == "Active";
      }
      
      private function updatePlaceText() : void
      {
         getPlaceTextField().setText(ProjectManager.getText("Place_" + currentPlace));
      }
      
      private function getPlaceTextField() : UIAutoTextField
      {
         var _loc1_:MovieClip = placeTags.getCurrentContainer().getDesignMovieClip();
         var _loc2_:TextField = _loc1_.getChildByName("Text_Place") as TextField;
         return new UIAutoTextField(_loc2_);
      }
   }
}
