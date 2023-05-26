package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.data.challenges.ChallengesData;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class ChallengeElementScreen extends TuxUIElementScreen
   {
       
      
      private var nameField:UIAutoTextField;
      
      private var descField:UIAutoTextField;
      
      private var numberField:UIAutoTextField;
      
      private var typeField:UIAutoTextField;
      
      private var iconContainer:MovieClip;
      
      public function ChallengeElementScreen(design:MovieClip, game:TuxWarsGame)
      {
         super(design,game);
         nameField = TuxUiUtils.createAutoTextFieldWithText(design.Text_Name,"");
         descField = TuxUiUtils.createAutoTextFieldWithText(design.Text_Description,"");
         numberField = TuxUiUtils.createAutoTextFieldWithText(design.Text_Number,"");
         typeField = TuxUiUtils.createAutoTextFieldWithText(design.Text_Category,"");
         iconContainer = design.Container_Icon;
         TuxUiUtils.createAutoTextField(design.Text_Challenge,"CHALLENGE_TEXT");
      }
      
      public function init(challenge:Challenge, challengeType:String = null) : void
      {
         if(challenge)
         {
            nameField.setText(challenge.name);
            descField.setText(challenge.description);
            numberField.setText(getNumberText(challenge));
            typeField.setText(ProjectManager.getText(challenge.type));
            DCUtils.replaceDisplayObject(iconContainer,challenge.icon);
         }
         else if(challengeType)
         {
            typeField.setText(challengeType);
         }
      }
      
      private function getNumberText(challenge:Challenge) : String
      {
         var _loc3_:Vector.<ChallengeData> = ChallengesData.findChallengesOfType(challenge.type);
         var _loc2_:int = ChallengesData.findIndex(ChallengesData.getChallengeData(challenge.id));
         return _loc2_ + "/" + _loc3_.length;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         nameField = null;
         descField = null;
         numberField = null;
         typeField = null;
         iconContainer = null;
      }
   }
}
