package tuxwars.battle.ui.screen.timer
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.*;
   import tuxwars.battle.*;
   import tuxwars.battle.avatar.TuxAvatar;
   
   public class PlayerTimerElement extends TimerElement
   {
      private static const CHARACTER_FRAME:String = "Character_Frame";
      
      private static const LAUREL:String = "Icon_Laurel";
      
      private static const CHARACTER_CONTAINER:String = "Container_Character";
      
      private var firstPlaceLaurel:MovieClip;
      
      private var characterContainer:MovieClip;
      
      private var isCharacterAvatarSet:Boolean;
      
      public function PlayerTimerElement(param1:MovieClip, param2:UIComponent)
      {
         super(param1,param2,0,BattleManager.getTurnDuration());
         this.firstPlaceLaurel = (param1.getChildByName("Character_Frame") as MovieClip).getChildByName("Icon_Laurel") as MovieClip;
         this.firstPlaceLaurel.visible = false;
         this.characterContainer = (param1.getChildByName("Character_Frame") as MovieClip).getChildByName("Container_Character") as MovieClip;
      }
      
      public function setPlayerAvatar(param1:TuxAvatar) : void
      {
         if(!this.isCharacterAvatarSet)
         {
            this.characterContainer.addChild(param1);
            param1.paperDoll.animation.clip.stop();
            param1.paperDoll.animation.clip.cacheAsBitmap = true;
            this.isCharacterAvatarSet = true;
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         if(BattleManager.isBattleInProgress())
         {
            setTime(BattleManager.getTurnTimeLeft());
            super.logicUpdate(param1);
         }
      }
      
      public function update() : void
      {
         slider.setMaxValue(BattleManager.getTurnDuration());
         slider.setValueWithoutBarAnimation(BattleManager.getTurnTimeLeft());
      }
      
      public function setFirstPlayer(param1:Boolean) : void
      {
         this.firstPlaceLaurel.visible = param1;
      }
   }
}

