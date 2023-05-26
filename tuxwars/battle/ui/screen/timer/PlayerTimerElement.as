package tuxwars.battle.ui.screen.timer
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.avatar.TuxAvatar;
   
   public class PlayerTimerElement extends TimerElement
   {
      
      private static const CHARACTER_FRAME:String = "Character_Frame";
      
      private static const LAUREL:String = "Icon_Laurel";
      
      private static const CHARACTER_CONTAINER:String = "Container_Character";
       
      
      private var firstPlaceLaurel:MovieClip;
      
      private var characterContainer:MovieClip;
      
      private var isCharacterAvatarSet:Boolean;
      
      public function PlayerTimerElement(design:MovieClip, parent:UIComponent)
      {
         super(design,parent,0,BattleManager.getTurnDuration());
         firstPlaceLaurel = (design.getChildByName("Character_Frame") as MovieClip).getChildByName("Icon_Laurel") as MovieClip;
         firstPlaceLaurel.visible = false;
         characterContainer = (design.getChildByName("Character_Frame") as MovieClip).getChildByName("Container_Character") as MovieClip;
      }
      
      public function setPlayerAvatar(playerAvatar:TuxAvatar) : void
      {
         if(!isCharacterAvatarSet)
         {
            characterContainer.addChild(playerAvatar);
            playerAvatar.paperDoll.animation.clip.stop();
            playerAvatar.paperDoll.animation.clip.cacheAsBitmap = true;
            isCharacterAvatarSet = true;
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         if(BattleManager.isBattleInProgress())
         {
            setTime(BattleManager.getTurnTimeLeft());
            super.logicUpdate(deltaTime);
         }
      }
      
      public function update() : void
      {
         slider.setMaxValue(BattleManager.getTurnDuration());
         slider.setValueWithoutBarAnimation(BattleManager.getTurnTimeLeft());
      }
      
      public function setFirstPlayer(value:Boolean) : void
      {
         firstPlaceLaurel.visible = value;
      }
   }
}
