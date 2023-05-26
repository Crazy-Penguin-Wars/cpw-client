package tuxwars.battle.ui.screen.tab
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.ui.logic.BattleHudPlayerData;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function PlayerTabElement(design:MovieClip, name:String, parent:UIComponent = null)
      {
         super(design,parent);
         currentName = name;
         currentScore = 0;
         firstPlaceLaurel = (design.getChildByName("Character_Frame") as MovieClip).getChildByName("Icon_Laurel") as MovieClip;
         firstPlaceLaurel.visible = false;
         characterContainer = (design.getChildByName("Character_Frame") as MovieClip).getChildByName("Container_Character") as MovieClip;
         DCUtils.setBitmapSmoothing(true,design);
         nameField = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Name") as TextField,"");
         scoreField = TuxUiUtils.createAutoTextField(getDesignMovieClip().getChildByName("Text_Scores") as TextField,"");
         nameField.setText(currentName);
         scoreField.setText(currentScore.toString());
      }
      
      public function updatePlayer(player:BattleHudPlayerData) : void
      {
         if(player.name != currentName)
         {
            currentName = player.name;
            nameField.setText(currentName);
         }
         if(player.score != currentScore)
         {
            currentScore = player.score;
            scoreField.setText(currentScore.toString());
         }
         if(player.avatar != currentAvatar)
         {
            if(currentAvatar && characterContainer.contains(currentAvatar))
            {
               characterContainer.removeChild(currentAvatar);
            }
            currentAvatar = player.avatar;
            characterContainer.addChild(currentAvatar);
         }
         firstPlaceLaurel.visible = player.place == 1;
      }
   }
}
