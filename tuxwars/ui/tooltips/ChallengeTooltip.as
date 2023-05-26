package tuxwars.ui.tooltips
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import org.as3commons.lang.StringUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.counters.Counter;
   import tuxwars.challenges.counters.CounterFactory;
   import tuxwars.data.assets.TooltipsData;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.utils.TuxUiUtils;
   
   public class ChallengeTooltip extends TuxTooltip
   {
       
      
      private var challengeData:ChallengeData;
      
      public function ChallengeTooltip(top:Boolean, challengeData:ChallengeData)
      {
         this.challengeData = challengeData;
         super(top ? TooltipsData.getChallengeTopTooltipGraphics() : TooltipsData.getChallengeBottomTooltipGraphics());
      }
      
      override protected function createContents() : void
      {
         TuxUiUtils.createAutoTextField(this._design.Text_Name,challengeData.getTID());
         var _loc2_:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Decription,challengeData.description);
         TuxUiUtils.createAutoTextField(this._design.Text_Number,"CHALLENGE_TOOLTIP_NUMBER",[challengeData.category]);
         var _loc3_:ChallengeManager = ChallengeManager;
         if(!tuxwars.challenges.ChallengeManager._instance)
         {
            tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
         }
         var _loc1_:Challenge = tuxwars.challenges.ChallengeManager._instance.getLocalPlayersChallenges().findChallenge(challengeData.id);
         if(_loc1_)
         {
            _loc2_.setText(_loc2_.getText() + "\n" + getCounterText(_loc1_));
         }
         else if(Config.isDev())
         {
            _loc2_.setText(_loc2_.getText() + "\n" + getCounterTextFromData(challengeData));
         }
      }
      
      private function getCounterTextFromData(challengeData:ChallengeData) : String
      {
         var i:int = 0;
         var _loc2_:* = null;
         var result:* = null;
         var _loc5_:int = 0;
         var str:String = "";
         for(i = 0; i < challengeData.counters.length; )
         {
            _loc2_ = challengeData.counters[i];
            if(CounterFactory.isBooleanClass(_loc2_))
            {
               result = ProjectManager.getText("INCOMPLETE");
               return ProjectManager.getText(_loc2_,[result]) + "\n";
            }
            _loc5_ = int(challengeData.targetValues[i]);
            str += ProjectManager.getText(_loc2_,["0 / " + _loc5_]) + "\n";
            i++;
         }
         return StringUtils.trim(str);
      }
      
      private function getCounterText(challenge:Challenge) : String
      {
         var str:String = "";
         for each(var counter in challenge.counters)
         {
            str += counter.getProgressString();
         }
         return StringUtils.trim(str);
      }
   }
}
