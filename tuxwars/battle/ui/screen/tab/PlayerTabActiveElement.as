package tuxwars.battle.ui.screen.tab
{
   import com.dchoc.game.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.progress.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.ui.windows.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.battle.data.player.*;
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
      
      public function PlayerTabActiveElement(param1:MovieClip, param2:String, param3:UIComponent = null)
      {
         super(param1,param2,param3);
         this.placeTags = new UIContainers();
         var _loc4_:MovieClip = param1.getChildByName("Place_Tag") as MovieClip;
         this.placeTags.add("Place_" + 1,new UIContainer(_loc4_.getChildByName("Place_" + 1) as MovieClip,this));
         this.placeTags.add("Place_" + 2,new UIContainer(_loc4_.getChildByName("Place_" + 2) as MovieClip,this));
         this.placeTags.add("Place_" + 3,new UIContainer(_loc4_.getChildByName("Place_" + 3) as MovieClip,this));
         this.placeTags.add("Place_" + 4,new UIContainer(_loc4_.getChildByName("Place_" + 4) as MovieClip,this));
         this.currentPlace = 4;
         this.placeTags.show("Place_" + this.currentPlace,false);
         this.updatePlaceText();
         this.backActive = param1.getChildByName("Back_Active") as MovieClip;
         this.backActive.visible = false;
         this.healthBar = new UIProgressIndicator(param1.getChildByName("Slider_Lifebar") as MovieClip,0,Players.getPlayerData().getHitPoints());
         this.healthBar.setValueWithoutBarAnimation(Players.getPlayerData().getHitPoints());
         LogicUpdater.register(this,"PlayerTabActiveElement");
      }
      
      override public function dispose() : void
      {
         LogicUpdater.unregister(this,"PlayerTabActiveElement");
         this.healthBar.dispose();
         this.healthBar = null;
         this.backActive = null;
         this.placeTags.dispose();
         this.placeTags = null;
         super.dispose();
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.healthBar.logicUpdate(param1);
      }
      
      override public function updatePlayer(param1:BattleHudPlayerData) : void
      {
         super.updatePlayer(param1);
         if(param1.place != this.currentPlace)
         {
            this.currentPlace = param1.place;
            this.placeTags.show("Place_" + this.currentPlace,false);
            this.updatePlaceText();
         }
         this.healthBar.setValue(param1.hitPoints);
         this.backActive.visible = param1.status == "Active";
      }
      
      private function updatePlaceText() : void
      {
         this.getPlaceTextField().setText(ProjectManager.getText("Place_" + this.currentPlace));
      }
      
      private function getPlaceTextField() : UIAutoTextField
      {
         var _loc1_:MovieClip = this.placeTags.getCurrentContainer().getDesignMovieClip();
         var _loc2_:TextField = _loc1_.getChildByName("Text_Place") as TextField;
         return new UIAutoTextField(_loc2_);
      }
   }
}

