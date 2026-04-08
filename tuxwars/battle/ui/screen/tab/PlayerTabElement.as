package tuxwars.battle.ui.screen.tab
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.ui.logic.BattleHudPlayerData;
   import tuxwars.utils.*;
   
   public class PlayerTabElement extends UIContainer
   {
      private static const TEXT_NAME:String = "Text_Name";
      
      private static const TEXT_SCORE:String = "Text_Scores";
      
      private static const CHARACTER_FRAME:String = "Character_Frame";
      
      private static const LAUREL:String = "Icon_Laurel";
      
      private static const CHARACTER_CONTAINER:String = "Container_Character";
      
      private var firstPlaceLaurel:MovieClip;
      
      private var characterContainer:MovieClip;
      
      private var nameField:UIAutoTextField;
      
      private var scoreField:UIAutoTextField;
      
      private var currentName:String;
      
      private var currentScore:int;
      
      private var currentAvatar:TuxAvatar;
      
      public function PlayerTabElement(param1:MovieClip, param2:String, param3:UIComponent = null)
      {
         super(param1,param3);
         this.currentName = param2;
         this.currentScore = 0;
         this.firstPlaceLaurel = (param1.getChildByName("Character_Frame") as MovieClip).getChildByName("Icon_Laurel") as MovieClip;
         this.firstPlaceLaurel.visible = false;
         this.characterContainer = (param1.getChildByName("Character_Frame") as MovieClip).getChildByName("Container_Character") as MovieClip;
         DCUtils.setBitmapSmoothing(true,param1);
         this.nameField = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Name") as TextField,"");
         this.scoreField = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Scores") as TextField,"");
         this.nameField.setText(this.currentName);
         this.scoreField.setText(this.currentScore.toString());
      }
      
      public function updatePlayer(param1:BattleHudPlayerData) : void
      {
         if(param1.name != this.currentName)
         {
            this.currentName = param1.name;
            this.nameField.setText(this.currentName);
         }
         if(param1.score != this.currentScore)
         {
            this.currentScore = param1.score;
            this.scoreField.setText(this.currentScore.toString());
         }
         if(param1.avatar != this.currentAvatar)
         {
            if(Boolean(this.currentAvatar) && Boolean(this.characterContainer.contains(this.currentAvatar)))
            {
               this.characterContainer.removeChild(this.currentAvatar);
            }
            this.currentAvatar = param1.avatar;
            this.characterContainer.addChild(this.currentAvatar);
         }
         this.firstPlaceLaurel.visible = param1.place == 1;
      }
   }
}

