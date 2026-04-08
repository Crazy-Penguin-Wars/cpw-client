package tuxwars.home.ui.screen.tournament
{
   import com.dchoc.avatar.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.text.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.home.ui.logic.tournament.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.items.TournamentRewardItem;
   import tuxwars.net.*;
   import tuxwars.tournament.*;
   import tuxwars.utils.*;
   
   public class TournamentEndScreen extends TuxUIScreen
   {
      private static const LEAGUE_AMOUNT:int = 5;
      
      private static const LEAGUE_SLOT_AMOUNT:int = 3;
      
      private static const OK_BUTTON:String = "Button_Ok";
      
      private static const SHARE_BUTTON:String = "Button_Share";
      
      private static const CLOSE_BUTTON:String = "Button_Close";
      
      private var _tournament:Tournament;
      
      private var _league:League;
      
      private var _okButton:UIButton;
      
      private var _shareButton:UIButton;
      
      private var _closeButton:UIButton;
      
      private var _rankTextField:TextField;
      
      private var _messageTextField:TextField;
      
      private var _textRewardsTitle:TextField;
      
      private var _rewardDefaultMC:MovieClip;
      
      private var _rewardSpecialMC:MovieClip;
      
      private var _characterWinMC:MovieClip;
      
      private var _characterLoseMC:MovieClip;
      
      private var _characterStayMC:MovieClip;
      
      private var _qualification:MovieClip;
      
      private var _qualificationText:TextField;
      
      private var _noRewards:MovieClip;
      
      private var _noRewardsText:TextField;
      
      private var _avatar:TuxAvatar;
      
      private var _leagueSlots:Vector.<LeagueSlot>;
      
      public function TournamentEndScreen(param1:TuxWarsGame)
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/tournament.swf","tournament_result");
         super(param1,_loc4_);
         this._okButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Ok",this.okCallback,"BUTTON_OK");
         this._shareButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Share",this.shareCallback,"BUTTON_SHARE");
         this._closeButton = TuxUiUtils.createButton(UIButton,_loc4_,"Button_Close",this.closeCallback);
         var _loc5_:UIAutoTextField = new UIAutoTextField();
         _loc5_.setTextField(_loc4_.Text_Header);
         _loc5_.setText(ProjectManager.getText("TOURNAMENT_OVER_HEADER"));
         this._leagueSlots = new Vector.<LeagueSlot>();
         var _loc6_:MovieClip = (_loc4_ as MovieClip).getChildByName("slots") as MovieClip;
         var _loc7_:MovieClip = _loc6_.getChildByName("Slots") as MovieClip;
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            _loc3_ = _loc7_.getChildByName("Slot_0" + _loc2_) as MovieClip;
            this._leagueSlots.push(new LeagueSlot(_loc3_));
            _loc2_++;
         }
         var _loc8_:MovieClip = (_loc4_ as MovieClip).getChildByName("Character") as MovieClip;
         this._characterWinMC = (_loc8_ as MovieClip).getChildByName("Character_Win") as MovieClip;
         this._characterWinMC.visible = false;
         this._characterStayMC = (_loc8_ as MovieClip).getChildByName("Character_Stay") as MovieClip;
         this._characterStayMC.visible = false;
         this._characterLoseMC = (_loc8_ as MovieClip).getChildByName("Character_Lose") as MovieClip;
         this._characterLoseMC.visible = false;
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(param1:*) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         super.init(param1);
         _loc4_ = 1;
         while(_loc4_ <= 5)
         {
            if(_loc4_ - 1 > 0)
            {
               _loc2_ = (this._design as MovieClip).getChildByName("Arrow_" + _loc4_ + "_to_" + (_loc4_ - 1)) as MovieClip;
               _loc2_.visible = false;
            }
            if(_loc4_ + 1 <= 5)
            {
               _loc2_ = (this._design as MovieClip).getChildByName("Arrow_" + _loc4_ + "_to_" + (_loc4_ + 1)) as MovieClip;
               _loc2_.visible = false;
            }
            _loc3_ = (this._design as MovieClip).getChildByName("Icon_League_0" + _loc4_) as MovieClip;
            _loc3_.gotoAndStop("Disabled");
            _loc4_++;
         }
         this._rankTextField = MovieClip(this._design).getChildByName("Text_Rank") as TextField;
         this._rankTextField.text = "";
         this._messageTextField = MovieClip(this._design).getChildByName("Text_Message") as TextField;
         this._messageTextField.text = "";
         this._qualification = (this._design as MovieClip).getChildByName("qualification") as MovieClip;
         this._qualification.visible = false;
         this._qualificationText = this._qualification.getChildByName("Text") as TextField;
         this._qualificationText.text = "";
         this._noRewards = (this._design as MovieClip).getChildByName("no_rewards") as MovieClip;
         this._noRewards.visible = false;
         this._noRewardsText = this._noRewards.getChildByName("Text") as TextField;
         this._noRewardsText.text = "";
         var _loc5_:MovieClip = MovieClip(this._design).getChildByName("rewards") as MovieClip;
         this._textRewardsTitle = _loc5_.getChildByName("Text_Reward") as TextField;
         this._textRewardsTitle.text = ProjectManager.getText("TOURNAMENT_RESULT_REWARDS");
         var _loc6_:MovieClip = _loc5_.getChildByName("Reward") as MovieClip;
         this._rewardDefaultMC = (_loc6_ as MovieClip).getChildByName("Reward_Default") as MovieClip;
         this._rewardDefaultMC.visible = false;
         this._rewardSpecialMC = (_loc6_ as MovieClip).getChildByName("Reward_Special") as MovieClip;
         this._rewardSpecialMC.visible = false;
         this.initResultInfo();
      }
      
      private function initResultInfo() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:League = null;
         var _loc9_:League = null;
         var _loc10_:TournamentRewardItem = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         var _loc13_:TextField = null;
         var _loc14_:TextField = null;
         this._tournament = _game.player.tournament;
         this._league = this._tournament.league;
         var _loc15_:int = 5 - this._league.sortPriority + 1;
         var _loc16_:int = int(this._league.findMyIndex());
         var _loc17_:TournamentPlayer = this._league.getPlayers()[_loc16_];
         var _loc18_:* = this._league.playedGames >= this._tournament.requiredPlacementForLeague;
         var _loc19_:Boolean = Boolean(this._league.divisionId) && this._league.rank > 0;
         if(_loc18_)
         {
            if(_loc19_)
            {
               this._rankTextField.text = ProjectManager.getText("TOURNAMENT_RESULT_RANK",[this._league.rank]);
               this._qualification.visible = false;
            }
            else
            {
               this._rankTextField.text = ProjectManager.getText("TOURNAMENT_DID_NOT_GET_RANK_TITLE");
               this._qualification.visible = true;
               this._qualificationText.text = ProjectManager.getText("TOURNAMENT_DID_NOT_GET_RANK_TEXT");
            }
         }
         else
         {
            this._rankTextField.text = ProjectManager.getText("TOURNAMENT_DID_NOT_QUALIFY_TITLE");
            this._qualification.visible = true;
            if(this._league.relegatedPlayers > 0)
            {
               this._qualificationText.text = ProjectManager.getText("TOURNAMENT_DID_NOT_QUALIFY_TEXT");
            }
            else
            {
               this._qualificationText.text = ProjectManager.getText("TOURNAMENT_DID_NOT_QUALIFY_BRONZE_TEXT");
            }
         }
         if(_loc18_ && _loc19_)
         {
            if(_loc16_ == 0)
            {
               _loc6_ = 0;
               _loc5_ = 1;
            }
            else if(_loc16_ == this._league.getPlayers().length - 1)
            {
               _loc6_ = _loc16_ - 1;
               _loc5_ = 0;
            }
            else
            {
               _loc6_ = _loc16_ - 1;
               _loc5_ = 0;
            }
            _loc7_ = _loc6_;
            while(_loc5_ < 3 && _loc7_ < this._league.getPlayers().length)
            {
               this._leagueSlots[_loc5_].setPlayer(this._league.getPlayers()[_loc7_],this._tournament,_loc7_);
               _loc7_++;
               _loc5_++;
            }
         }
         var _loc20_:Boolean = true;
         if(_loc18_ && _loc19_ && this._league.rank <= this._league.promotedPlayers)
         {
            _loc8_ = TournamentManager.getNeighborLeague(this._league,true);
            if(_loc8_)
            {
               _loc20_ = false;
               this._messageTextField.text = ProjectManager.getText("TOURNAMENT_RESULT_MOVE_UP",[_loc8_.name]);
               _loc1_ = (this._design as MovieClip).getChildByName("Icon_League_0" + _loc15_) as MovieClip;
               _loc1_.gotoAndPlay("Visible_To_Disabled");
               _loc2_ = (this._design as MovieClip).getChildByName("Icon_League_0" + (_loc15_ - 1)) as MovieClip;
               _loc2_.gotoAndPlay("Disabled_To_Visible");
               _loc4_ = (this._design as MovieClip).getChildByName("Arrow_" + _loc15_ + "_to_" + (_loc15_ - 1)) as MovieClip;
               _loc4_.visible = true;
               this.setupAvatar(this._characterWinMC,"win");
            }
         }
         else if(!_loc18_ && this._league.relegatedPlayers > 0 || _loc19_ && this._league.relegatedPlayers > 0 && this._league.rank > this._league.getPlayers().length - this._league.relegatedPlayers)
         {
            _loc9_ = TournamentManager.getNeighborLeague(this._league,false);
            if(_loc9_)
            {
               _loc20_ = false;
               this._messageTextField.text = ProjectManager.getText("TOURNAMENT_RESULT_MOVE_DOWN",[_loc9_.name]);
               _loc1_ = (this._design as MovieClip).getChildByName("Icon_League_0" + _loc15_) as MovieClip;
               _loc1_.gotoAndPlay("Visible_To_Disabled");
               _loc3_ = (this._design as MovieClip).getChildByName("Icon_League_0" + (_loc15_ + 1)) as MovieClip;
               _loc3_.gotoAndPlay("Disabled_To_Visible");
               _loc4_ = (this._design as MovieClip).getChildByName("Arrow_" + _loc15_ + "_to_" + (_loc15_ + 1)) as MovieClip;
               _loc4_.visible = true;
               this.setupAvatar(this._characterLoseMC,"lose_01");
            }
         }
         if(_loc20_)
         {
            this._messageTextField.text = ProjectManager.getText("TOURNAMENT_RESULT_NORMAL",[this._league.name]);
            _loc1_ = (this._design as MovieClip).getChildByName("Icon_League_0" + _loc15_) as MovieClip;
            _loc1_.gotoAndPlay("Disabled_To_Visible");
            this.setupAvatar(this._characterStayMC,"idle");
         }
         if(_loc18_)
         {
            this._textRewardsTitle.visible = true;
            this._noRewards.visible = false;
            _loc10_ = this._league.rankReward;
            if(_loc10_)
            {
               this._rewardSpecialMC.visible = true;
               _loc11_ = this._rewardSpecialMC.getChildByName("Reward") as MovieClip;
               _loc12_ = this._rewardSpecialMC.getChildByName("Reward_Special") as MovieClip;
               _loc13_ = _loc11_.getChildByName("Text_Formula") as TextField;
               _loc13_.text = ProjectManager.getText("TOURNAMENT_RESULT_REWARDS_FORMULA",[this._league.points,this._league.pointRewardMultiplier]);
               _loc14_ = _loc11_.getChildByName("Text_Coins") as TextField;
               _loc14_.text = "" + this._league.points * this._league.pointRewardMultiplier;
               new TournamentRewardSlot(_loc12_,_game,_loc10_,this._league.rank,this,true);
            }
            else
            {
               this._rewardDefaultMC.visible = true;
               _loc11_ = this._rewardDefaultMC.getChildByName("Reward") as MovieClip;
               _loc13_ = _loc11_.getChildByName("Text_Formula") as TextField;
               _loc13_.text = ProjectManager.getText("TOURNAMENT_RESULT_REWARDS_FORMULA",[this._league.points,this._league.pointRewardMultiplier]);
               _loc14_ = _loc11_.getChildByName("Text_Coins") as TextField;
               _loc14_.text = "" + this._league.points * this._league.pointRewardMultiplier;
            }
            this._shareButton.setEnabled(true);
         }
         else
         {
            this._textRewardsTitle.visible = false;
            this._noRewards.visible = true;
            this._noRewardsText.text = ProjectManager.getText("TOURNAMENT_NO_REWARDS");
            this._shareButton.setEnabled(false);
         }
      }
      
      private function setupAvatar(param1:MovieClip, param2:String) : void
      {
         var _loc5_:* = undefined;
         param1.visible = true;
         var _loc3_:MovieClip = param1.getChildByName("Container_Character") as MovieClip;
         this._avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         this._avatar.animate(new AvatarAnimation(param2));
         _loc3_.addChild(this._avatar);
         var _loc4_:Object = _game.player.wornItemsContainer.getWornItems();
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_)
            {
               this._avatar.wearClothing(_loc5_);
            }
         }
      }
      
      private function okCallback(param1:MouseEvent) : void
      {
         this._okButton.setEnabled(false);
         var _loc2_:Object = {"reward_id":this._league.rewardId};
         MessageCenter.addListener("TournamentRewardClaimed",this.okPressedCallBack);
         MessageCenter.sendMessage("CollectTournamentRewards",_loc2_);
      }
      
      public function okPressedCallBack(param1:Message) : void
      {
         if(param1.data.reward_id != this._league.rewardId)
         {
            LogUtils.log("Trying to add reward with wrong id: " + param1.data.reward_id + ", should be:" + this._league.rewardId,null,3,"Tournament");
            return;
         }
         this._league.rewardId = null;
         MessageCenter.removeListener("TournamentRewardClaimed",this.okPressedCallBack);
         _game.player.addIngameMoney(param1.data.rewarded_coins);
         _game.player.addPremiumMoney(param1.data.rewarded_cash);
         _game.player.addExp(param1.data.rewarded_xp);
         if(Boolean(param1.data.rewarded_vip) && param1.data.rewarded_vip > 0)
         {
         }
         if(Boolean(param1.data.rank_reward_item) && Boolean(param1.data.rank_reward_item_amount) && param1.data.rank_reward_item_amount > 0)
         {
            _game.player.inventory.addItem(param1.data.rank_reward_item,param1.data.rank_reward_item_amount);
            CRMService.sendEvent("Economy","Earn VIP","Reward","Tournament",param1.data.rank_reward_item,param1.data.rank_reward_item_amount);
         }
         if(Boolean(param1.data.rewarded_coins) && param1.data.rewarded_coins > 0)
         {
            CRMService.sendEvent("Economy","Earn GC","Reward","Tournament",null,param1.data.rewarded_coins);
         }
         if(Boolean(param1.data.rewarded_cash) && param1.data.rewarded_cash > 0)
         {
            CRMService.sendEvent("Economy","Earn PC","Reward","Tournament",null,param1.data.rewarded_cash);
         }
         if(Boolean(param1.data.rewarded_xp) && param1.data.rewarded_xp > 0)
         {
            CRMService.sendEvent("Economy","Earn XP","Reward","Tournament",null,param1.data.rewarded_xp);
         }
         super.close();
      }
      
      private function shareCallback(param1:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tournament_Ended","Clicked","PostBragFeed");
         this.tournamentEndLogic.postBragFeed(this._league.rank);
      }
      
      private function closeCallback(param1:MouseEvent) : void
      {
         super.close();
      }
      
      public function get tournamentEndLogic() : TournamentEndLogic
      {
         return logic as TournamentEndLogic;
      }
      
      public function get shareButton() : UIButton
      {
         return this._shareButton;
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         this._okButton.dispose();
         this._okButton = null;
         this._closeButton.dispose();
         this._closeButton = null;
         this._shareButton.dispose();
         this._shareButton = null;
         this._avatar.dispose();
         this._avatar = null;
      }
   }
}

