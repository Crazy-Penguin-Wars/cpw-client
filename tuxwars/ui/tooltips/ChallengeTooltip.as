package tuxwars.ui.tooltips
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import org.as3commons.lang.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.counters.*;
   import tuxwars.data.assets.*;
   import tuxwars.data.challenges.ChallengeData;
   import tuxwars.utils.*;
   
   public class ChallengeTooltip extends TuxTooltip
   {
      private var challengeData:ChallengeData;
      
      public function ChallengeTooltip(param1:Boolean, param2:ChallengeData)
      {
         this.challengeData = param2;
         super(param1 ? TooltipsData.getChallengeTopTooltipGraphics() : TooltipsData.getChallengeBottomTooltipGraphics());
      }
      
      override protected function createContents() : void
      {
         TuxUiUtils.createAutoTextField(this._design.Text_Name,this.challengeData.getTID());
         var _loc1_:UIAutoTextField = TuxUiUtils.createAutoTextFieldWithText(this._design.Text_Decription,this.challengeData.description);
         TuxUiUtils.createAutoTextField(this._design.Text_Number,"CHALLENGE_TOOLTIP_NUMBER",[this.challengeData.category]);
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         var _loc2_:Challenge = ChallengeManager.instance.getLocalPlayersChallenges().findChallenge(this.challengeData.id);
         if(_loc2_)
         {
            _loc1_.setText(_loc1_.getText() + "\n" + this.getCounterText(_loc2_));
         }
         else if(Config.isDev())
         {
            _loc1_.setText(_loc1_.getText() + "\n" + this.getCounterTextFromData(this.challengeData));
         }
      }
      
      private function getCounterTextFromData(param1:ChallengeData) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = "";
         _loc2_ = 0;
         while(_loc2_ < param1.counters.length)
         {
            _loc3_ = param1.counters[_loc2_];
            if(CounterFactory.isBooleanClass(_loc3_))
            {
               _loc4_ = ProjectManager.getText("INCOMPLETE");
               return ProjectManager.getText(_loc3_,[_loc4_]) + "\n";
            }
            _loc5_ = int(param1.targetValues[_loc2_]);
            _loc6_ += ProjectManager.getText(_loc3_,["0 / " + _loc5_]) + "\n";
            _loc2_++;
         }
         return StringUtils.trim(_loc6_);
      }
      
      private function getCounterText(param1:Challenge) : String
      {
         var _loc3_:* = undefined;
         var _loc2_:String = "";
         for each(_loc3_ in param1.counters)
         {
            _loc2_ += _loc3_.getProgressString();
         }
         return StringUtils.trim(_loc2_);
      }
   }
}

