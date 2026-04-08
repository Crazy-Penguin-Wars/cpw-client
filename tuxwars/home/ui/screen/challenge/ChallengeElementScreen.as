package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   import tuxwars.data.challenges.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.utils.*;
   
   public class ChallengeElementScreen extends TuxUIElementScreen
   {
      private var nameField:UIAutoTextField;
      
      private var descField:UIAutoTextField;
      
      private var numberField:UIAutoTextField;
      
      private var typeField:UIAutoTextField;
      
      private var iconContainer:MovieClip;
      
      public function ChallengeElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1,param2);
         this.nameField = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Name,"");
         this.descField = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Description,"");
         this.numberField = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Number,"");
         this.typeField = TuxUiUtils.createAutoTextFieldWithText(param1.Text_Category,"");
         this.iconContainer = param1.Container_Icon;
         TuxUiUtils.createAutoTextField(param1.Text_Challenge,"CHALLENGE_TEXT");
      }
      
      public function init(param1:Challenge, param2:String = null) : void
      {
         if(param1)
         {
            this.nameField.setText(param1.name);
            this.descField.setText(param1.description);
            this.numberField.setText(this.getNumberText(param1));
            this.typeField.setText(ProjectManager.getText(param1.type));
            DCUtils.replaceDisplayObject(this.iconContainer,param1.icon);
         }
         else if(param2)
         {
            this.typeField.setText(param2);
         }
      }
      
      private function getNumberText(param1:Challenge) : String
      {
         var _loc2_:Vector.<ChallengeData> = ChallengesData.findChallengesOfType(param1.type);
         var _loc3_:int = int(ChallengesData.findIndex(ChallengesData.getChallengeData(param1.id)));
         return _loc3_ + "/" + _loc2_.length;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.nameField = null;
         this.descField = null;
         this.numberField = null;
         this.typeField = null;
         this.iconContainer = null;
      }
   }
}

