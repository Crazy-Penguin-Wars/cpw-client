package tuxwars.home.ui.screen.tournament
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.home.ui.logic.tournament.TournamentEndLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.TournamentRewardItem;
   import tuxwars.net.CRMService;
   import tuxwars.tournament.League;
   import tuxwars.tournament.Tournament;
   import tuxwars.tournament.TournamentManager;
   import tuxwars.tournament.TournamentPlayer;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function TournamentEndScreen(game:TuxWarsGame)
      {
         var slotCounter:int = 0;
         var slotDesign:* = null;
         var _loc8_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/tournament.swf","tournament_result");
         super(game,_loc8_);
         _okButton = TuxUiUtils.createButton(UIButton,_loc8_,"Button_Ok",okCallback,"BUTTON_OK");
         _shareButton = TuxUiUtils.createButton(UIButton,_loc8_,"Button_Share",shareCallback,"BUTTON_SHARE");
         _closeButton = TuxUiUtils.createButton(UIButton,_loc8_,"Button_Close",closeCallback);
         var _loc7_:UIAutoTextField = new UIAutoTextField();
         _loc7_.setTextField(_loc8_.Text_Header);
         _loc7_.setText(ProjectManager.getText("TOURNAMENT_OVER_HEADER"));
         _leagueSlots = new Vector.<LeagueSlot>();
         var slotContainer:MovieClip = (_loc8_ as MovieClip).getChildByName("slots") as MovieClip;
         var leagueSlots:MovieClip = slotContainer.getChildByName("Slots") as MovieClip;
         for(slotCounter = 1; slotCounter <= 3; )
         {
            slotDesign = leagueSlots.getChildByName("Slot_0" + slotCounter) as MovieClip;
            _leagueSlots.push(new LeagueSlot(slotDesign));
            slotCounter++;
         }
         var _loc3_:MovieClip = (_loc8_ as MovieClip).getChildByName("Character") as MovieClip;
         _characterWinMC = (_loc3_ as MovieClip).getChildByName("Character_Win") as MovieClip;
         _characterWinMC.visible = false;
         _characterStayMC = (_loc3_ as MovieClip).getChildByName("Character_Stay") as MovieClip;
         _characterStayMC.visible = false;
         _characterLoseMC = (_loc3_ as MovieClip).getChildByName("Character_Lose") as MovieClip;
         _characterLoseMC.visible = false;
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(params:*) : void
      {
         var arrowMC:* = null;
         var leagueIconMC:* = null;
         var leagueCounter:int = 0;
         super.init(params);
         for(leagueCounter = 1; leagueCounter <= 5; )
         {
            if(leagueCounter - 1 > 0)
            {
               arrowMC = (this._design as MovieClip).getChildByName("Arrow_" + leagueCounter + "_to_" + (leagueCounter - 1)) as MovieClip;
               arrowMC.visible = false;
            }
            if(leagueCounter + 1 <= 5)
            {
               arrowMC = (this._design as MovieClip).getChildByName("Arrow_" + leagueCounter + "_to_" + (leagueCounter + 1)) as MovieClip;
               arrowMC.visible = false;
            }
            leagueIconMC = (this._design as MovieClip).getChildByName("Icon_League_0" + leagueCounter) as MovieClip;
            leagueIconMC.gotoAndStop("Disabled");
            leagueCounter++;
         }
         _rankTextField = MovieClip(this._design).getChildByName("Text_Rank") as TextField;
         _rankTextField.text = "";
         _messageTextField = MovieClip(this._design).getChildByName("Text_Message") as TextField;
         _messageTextField.text = "";
         _qualification = (this._design as MovieClip).getChildByName("qualification") as MovieClip;
         _qualification.visible = false;
         _qualificationText = _qualification.getChildByName("Text") as TextField;
         _qualificationText.text = "";
         _noRewards = (this._design as MovieClip).getChildByName("no_rewards") as MovieClip;
         _noRewards.visible = false;
         _noRewardsText = _noRewards.getChildByName("Text") as TextField;
         _noRewardsText.text = "";
         var rewards:MovieClip = MovieClip(this._design).getChildByName("rewards") as MovieClip;
         _textRewardsTitle = rewards.getChildByName("Text_Reward") as TextField;
         _textRewardsTitle.text = ProjectManager.getText("TOURNAMENT_RESULT_REWARDS");
         var _loc3_:MovieClip = rewards.getChildByName("Reward") as MovieClip;
         _rewardDefaultMC = (_loc3_ as MovieClip).getChildByName("Reward_Default") as MovieClip;
         _rewardDefaultMC.visible = false;
         _rewardSpecialMC = (_loc3_ as MovieClip).getChildByName("Reward_Special") as MovieClip;
         _rewardSpecialMC.visible = false;
         initResultInfo();
      }
      
      private function initResultInfo() : void
      {
         var leagueIconMC:* = null;
         var nextLeagueIconMC:* = null;
         var prevLeagueIconMC:* = null;
         var arrowMC:* = null;
         var slotIndex:int = 0;
         var index:int = 0;
         var i:* = 0;
         var _loc9_:* = null;
         var _loc12_:* = null;
         var _loc16_:* = null;
         var rMC:* = null;
         var rSMC:* = null;
         var formulaTF:* = null;
         var coinsTF:* = null;
         _tournament = _game.player.tournament;
         _league = _tournament.league;
         var _loc13_:int = 5 - _league.sortPriority + 1;
         var _loc8_:int = _league.findMyIndex();
         var _loc5_:TournamentPlayer = _league.getPlayers()[_loc8_];
         var _loc15_:Boolean = _league.playedGames >= _tournament.requiredPlacementForLeague;
         var _loc14_:Boolean = _league.divisionId && _league.rank > 0;
         if(_loc15_)
         {
            if(_loc14_)
            {
               _rankTextField.text = ProjectManager.getText("TOURNAMENT_RESULT_RANK",[_league.rank]);
               _qualification.visible = false;
            }
            else
            {
               _rankTextField.text = ProjectManager.getText("TOURNAMENT_DID_NOT_GET_RANK_TITLE");
               _qualification.visible = true;
               _qualificationText.text = ProjectManager.getText("TOURNAMENT_DID_NOT_GET_RANK_TEXT");
            }
         }
         else
         {
            _rankTextField.text = ProjectManager.getText("TOURNAMENT_DID_NOT_QUALIFY_TITLE");
            _qualification.visible = true;
            if(_league.relegatedPlayers > 0)
            {
               _qualificationText.text = ProjectManager.getText("TOURNAMENT_DID_NOT_QUALIFY_TEXT");
            }
            else
            {
               _qualificationText.text = ProjectManager.getText("TOURNAMENT_DID_NOT_QUALIFY_BRONZE_TEXT");
            }
         }
         if(_loc15_ && _loc14_)
         {
            if(_loc8_ == 0)
            {
               index = 0;
               slotIndex = 1;
            }
            else if(_loc8_ == _league.getPlayers().length - 1)
            {
               index = _loc8_ - 1;
               slotIndex = 0;
            }
            else
            {
               index = _loc8_ - 1;
               slotIndex = 0;
            }
            i = index;
            while(slotIndex < 3 && i < _league.getPlayers().length)
            {
               _leagueSlots[slotIndex].setPlayer(_league.getPlayers()[i],_tournament,i);
               i++;
               slotIndex++;
            }
         }
         var playerStaysInTheLeague:Boolean = true;
         if(_loc15_ && _loc14_ && _league.rank <= _league.promotedPlayers)
         {
            _loc9_ = TournamentManager.getNeighborLeague(_league,true);
            if(_loc9_)
            {
               playerStaysInTheLeague = false;
               _messageTextField.text = ProjectManager.getText("TOURNAMENT_RESULT_MOVE_UP",[_loc9_.name]);
               leagueIconMC = (this._design as MovieClip).getChildByName("Icon_League_0" + _loc13_) as MovieClip;
               leagueIconMC.gotoAndPlay("Visible_To_Disabled");
               nextLeagueIconMC = (this._design as MovieClip).getChildByName("Icon_League_0" + (_loc13_ - 1)) as MovieClip;
               nextLeagueIconMC.gotoAndPlay("Disabled_To_Visible");
               arrowMC = (this._design as MovieClip).getChildByName("Arrow_" + _loc13_ + "_to_" + (_loc13_ - 1)) as MovieClip;
               arrowMC.visible = true;
               setupAvatar(_characterWinMC,"win");
            }
         }
         else if(!_loc15_ && _league.relegatedPlayers > 0 || _loc14_ && _league.relegatedPlayers > 0 && _league.rank > _league.getPlayers().length - _league.relegatedPlayers)
         {
            _loc12_ = TournamentManager.getNeighborLeague(_league,false);
            if(_loc12_)
            {
               playerStaysInTheLeague = false;
               _messageTextField.text = ProjectManager.getText("TOURNAMENT_RESULT_MOVE_DOWN",[_loc12_.name]);
               leagueIconMC = (this._design as MovieClip).getChildByName("Icon_League_0" + _loc13_) as MovieClip;
               leagueIconMC.gotoAndPlay("Visible_To_Disabled");
               prevLeagueIconMC = (this._design as MovieClip).getChildByName("Icon_League_0" + (_loc13_ + 1)) as MovieClip;
               prevLeagueIconMC.gotoAndPlay("Disabled_To_Visible");
               arrowMC = (this._design as MovieClip).getChildByName("Arrow_" + _loc13_ + "_to_" + (_loc13_ + 1)) as MovieClip;
               arrowMC.visible = true;
               setupAvatar(_characterLoseMC,"lose_01");
            }
         }
         if(playerStaysInTheLeague)
         {
            _messageTextField.text = ProjectManager.getText("TOURNAMENT_RESULT_NORMAL",[_league.name]);
            leagueIconMC = (this._design as MovieClip).getChildByName("Icon_League_0" + _loc13_) as MovieClip;
            leagueIconMC.gotoAndPlay("Disabled_To_Visible");
            setupAvatar(_characterStayMC,"idle");
         }
         if(_loc15_)
         {
            _textRewardsTitle.visible = true;
            _noRewards.visible = false;
            _loc16_ = _league.rankReward;
            if(_loc16_)
            {
               _rewardSpecialMC.visible = true;
               rMC = _rewardSpecialMC.getChildByName("Reward") as MovieClip;
               rSMC = _rewardSpecialMC.getChildByName("Reward_Special") as MovieClip;
               formulaTF = rMC.getChildByName("Text_Formula") as TextField;
               formulaTF.text = ProjectManager.getText("TOURNAMENT_RESULT_REWARDS_FORMULA",[_league.points,_league.pointRewardMultiplier]);
               coinsTF = rMC.getChildByName("Text_Coins") as TextField;
               coinsTF.text = "" + _league.points * _league.pointRewardMultiplier;
               new TournamentRewardSlot(rSMC,_game,_loc16_,_league.rank,this,true);
            }
            else
            {
               _rewardDefaultMC.visible = true;
               rMC = _rewardDefaultMC.getChildByName("Reward") as MovieClip;
               formulaTF = rMC.getChildByName("Text_Formula") as TextField;
               formulaTF.text = ProjectManager.getText("TOURNAMENT_RESULT_REWARDS_FORMULA",[_league.points,_league.pointRewardMultiplier]);
               coinsTF = rMC.getChildByName("Text_Coins") as TextField;
               coinsTF.text = "" + _league.points * _league.pointRewardMultiplier;
            }
            _shareButton.setEnabled(true);
         }
         else
         {
            _textRewardsTitle.visible = false;
            _noRewards.visible = true;
            _noRewardsText.text = ProjectManager.getText("TOURNAMENT_NO_REWARDS");
            _shareButton.setEnabled(false);
         }
      }
      
      private function setupAvatar(parent:MovieClip, tuxAnimation:String) : void
      {
         parent.visible = true;
         var container:MovieClip = parent.getChildByName("Container_Character") as MovieClip;
         _avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         _avatar.animate(new AvatarAnimation(tuxAnimation));
         container.addChild(_avatar);
         var _loc3_:Object = _game.player.wornItemsContainer.getWornItems();
         for each(var item in _loc3_)
         {
            if(item)
            {
               _avatar.wearClothing(item);
            }
         }
      }
      
      private function okCallback(event:MouseEvent) : void
      {
         _okButton.setEnabled(false);
         var _loc2_:Object = {"reward_id":_league.rewardId};
         MessageCenter.addListener("TournamentRewardClaimed",okPressedCallBack);
         MessageCenter.sendMessage("CollectTournamentRewards",_loc2_);
      }
      
      public function okPressedCallBack(msg:Message) : void
      {
         if(msg.data.reward_id != _league.rewardId)
         {
            LogUtils.log("Trying to add reward with wrong id: " + msg.data.reward_id + ", should be:" + _league.rewardId,null,3,"Tournament");
            return;
         }
         _league.rewardId = null;
         MessageCenter.removeListener("TournamentRewardClaimed",okPressedCallBack);
         _game.player.addIngameMoney(msg.data.rewarded_coins);
         _game.player.addPremiumMoney(msg.data.rewarded_cash);
         _game.player.addExp(msg.data.rewarded_xp);
         if(msg.data.rewarded_vip && msg.data.rewarded_vip > 0)
         {
         }
         if(msg.data.rank_reward_item && msg.data.rank_reward_item_amount && msg.data.rank_reward_item_amount > 0)
         {
            _game.player.inventory.addItem(msg.data.rank_reward_item,msg.data.rank_reward_item_amount);
            CRMService.sendEvent("Economy","Earn VIP","Reward","Tournament",msg.data.rank_reward_item,msg.data.rank_reward_item_amount);
         }
         if(msg.data.rewarded_coins && msg.data.rewarded_coins > 0)
         {
            CRMService.sendEvent("Economy","Earn GC","Reward","Tournament",null,msg.data.rewarded_coins);
         }
         if(msg.data.rewarded_cash && msg.data.rewarded_cash > 0)
         {
            CRMService.sendEvent("Economy","Earn PC","Reward","Tournament",null,msg.data.rewarded_cash);
         }
         if(msg.data.rewarded_xp && msg.data.rewarded_xp > 0)
         {
            CRMService.sendEvent("Economy","Earn XP","Reward","Tournament",null,msg.data.rewarded_xp);
         }
         super.close();
      }
      
      private function shareCallback(event:MouseEvent) : void
      {
         CRMService.sendEvent("Game","Tournament_Ended","Clicked","PostBragFeed");
         tournamentEndLogic.postBragFeed(_league.rank);
      }
      
      private function closeCallback(event:MouseEvent) : void
      {
         super.close();
      }
      
      public function get tournamentEndLogic() : TournamentEndLogic
      {
         return logic as TournamentEndLogic;
      }
      
      public function get shareButton() : UIButton
      {
         return _shareButton;
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         super.dispose();
         _okButton.dispose();
         _okButton = null;
         _closeButton.dispose();
         _closeButton = null;
         _shareButton.dispose();
         _shareButton = null;
         _avatar.dispose();
         _avatar = null;
      }
   }
}
