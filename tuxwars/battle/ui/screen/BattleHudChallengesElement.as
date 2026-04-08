package tuxwars.battle.ui.screen
{
   import com.dchoc.messages.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.*;
   import tuxwars.data.challenges.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.ui.components.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
   public class BattleHudChallengesElement extends TuxUIElementScreen
   {
      private static const CHALLENGES_CONTAINER:String = "Container_Challenges";
      
      private static const CHALLENGE:String = "Button_Challenge_";
      
      private static const DEFAULT_BUTTON:String = "Challenge_Default";
      
      private static const NEW_BUTTON:String = "Challenge_New";
      
      private static const COMPLETED_BUTTON:String = "Challenge_Done";
      
      private static const NUMBER_OF_CHALLENGES:int = 4;
      
      private static const ELEMENT_MAP:Object = {};
      
      ELEMENT_MAP["Battle"] = 0;
      ELEMENT_MAP["Grind"] = 1;
      ELEMENT_MAP["Skill"] = 2;
      ELEMENT_MAP["Impossible"] = 3;
      
      private const challengeButtonsDefault:Vector.<IconButton>;
      
      private const challengeButtonsCompleted:Vector.<IconButton>;
      
      public function BattleHudChallengesElement(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Challenge = null;
         var _loc6_:IconButton = null;
         this.challengeButtonsDefault = new Vector.<IconButton>();
         this.challengeButtonsCompleted = new Vector.<IconButton>();
         super(param1.getChildByName("Container_Challenges") as MovieClip,param2);
         this._design.mouseChildren = true;
         this._design.mouseEnabled = true;
         this.createButtons();
         if(!ChallengeManager.instance)
         {
            ChallengeManager.instance = new ChallengeManager();
         }
         var _loc7_:Challenges = ChallengeManager.instance.getPlayerChallenges(param2.player.id);
         if(_loc7_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc7_.activeChallenges.length)
            {
               _loc5_ = _loc7_.activeChallenges[_loc4_];
               _loc6_ = this.challengeButtonsDefault[ELEMENT_MAP[_loc5_.type]];
               _loc6_.setParameter(_loc5_);
               _loc6_.setIcon(_loc5_.icon);
               _loc6_.setEnabled(true);
               _loc6_.setVisible(true);
               _loc6_ = this.challengeButtonsCompleted[ELEMENT_MAP[_loc5_.type]];
               _loc6_.setParameter(_loc5_);
               _loc6_.setIcon(_loc5_.icon);
               _loc6_.setEnabled(false);
               _loc6_.setVisible(false);
               _loc4_++;
            }
            _loc3_ = int(_loc7_.activeChallenges.length);
         }
         MessageCenter.addListener("ChallengeStateChanged",this.updateChallenges);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         MessageCenter.removeListener("ChallengeStateChanged",this.updateChallenges);
         for each(_loc1_ in this.challengeButtonsDefault)
         {
            _loc1_.dispose();
         }
         this.challengeButtonsDefault.slice(0,this.challengeButtonsDefault.length);
         for each(_loc1_ in this.challengeButtonsCompleted)
         {
            _loc1_.dispose();
         }
         this.challengeButtonsCompleted.slice(0,this.challengeButtonsCompleted.length);
         super.dispose();
      }
      
      private function createButtons() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:IconButton = null;
         var _loc4_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.getButtonContainer(_loc1_);
            _loc3_ = TuxUiUtils.createButton(IconButton,_loc2_,"Challenge_Default");
            _loc3_.setEnabled(false);
            _loc3_.setVisible(false);
            _loc3_.addEventListener("out",this.mouseOut,false,0,true);
            _loc3_.addEventListener("over",this.mouseOver,false,0,true);
            this.challengeButtonsDefault.push(_loc3_);
            _loc4_ = _loc2_.getChildByName("Challenge_New") as MovieClip;
            _loc4_.visible = false;
            DCUtils.stopMovieClip(_loc4_);
            _loc3_ = TuxUiUtils.createButton(IconButton,_loc2_,"Challenge_Done");
            _loc3_.setEnabled(false);
            _loc3_.setVisible(false);
            _loc3_.addEventListener("out",this.mouseOut,false,0,true);
            _loc3_.addEventListener("over",this.mouseOver,false,0,true);
            this.challengeButtonsCompleted.push(_loc3_);
            _loc1_++;
         }
      }
      
      private function getButtonContainer(param1:int) : MovieClip
      {
         return getDesignMovieClip().getChildByName("Button_Challenge_" + (param1 + 1)) as MovieClip;
      }
      
      private function updateChallenges(param1:Message) : void
      {
         var _loc2_:Challenges = null;
         var _loc3_:int = 0;
         var _loc4_:Challenge = null;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         if((param1.data as Challenge).playerId == game.player.id)
         {
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            _loc2_ = ChallengeManager.instance.getPlayerChallenges(game.player.id);
            if(_loc2_)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.activeChallenges.length)
               {
                  _loc4_ = _loc2_.activeChallenges[_loc3_];
                  if(_loc4_.id == (param1.data as Challenge).id)
                  {
                     _loc5_ = int(ELEMENT_MAP[_loc4_.type]);
                     _loc6_ = this.getButtonContainer(_loc5_);
                     if((param1.data as Challenge).areCountersCompleted())
                     {
                        if(Boolean(this.challengeButtonsDefault[_loc5_].getVisible()) && !this.challengeButtonsCompleted[_loc5_].getVisible())
                        {
                           this.challengeButtonsDefault[_loc5_].setEnabled(false);
                           this.challengeButtonsDefault[_loc5_].setVisible(false);
                           this.challengeButtonsCompleted[_loc5_].setEnabled(true);
                           this.challengeButtonsCompleted[_loc5_].setVisible(true);
                           _loc7_ = _loc6_.getChildByName("Challenge_Done") as MovieClip;
                           DCUtils.playMovieClip(_loc7_);
                           _loc7_.visible = true;
                        }
                     }
                     else if(!this.challengeButtonsDefault[_loc5_].getVisible() && Boolean(this.challengeButtonsCompleted[_loc5_].getVisible()))
                     {
                        this.challengeButtonsDefault[_loc5_].setEnabled(true);
                        this.challengeButtonsDefault[_loc5_].setVisible(true);
                        this.challengeButtonsCompleted[_loc5_].setEnabled(false);
                        this.challengeButtonsCompleted[_loc5_].setVisible(false);
                        _loc8_ = _loc6_.getChildByName("Challenge_Default") as MovieClip;
                        _loc8_.visible = true;
                     }
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         if(param1.getParameter())
         {
            TooltipManager.showTooltip(new ChallengeTooltip(false,ChallengesData.getChallengeData(param1.getParameter().id)),param1.getButton().getDesignMovieClip(),1,1);
         }
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
      }
   }
}

