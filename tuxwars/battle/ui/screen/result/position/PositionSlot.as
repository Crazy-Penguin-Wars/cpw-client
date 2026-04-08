package tuxwars.battle.ui.screen.result.position
{
   import com.dchoc.avatar.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.PlayerResult;
   import tuxwars.battle.avatar.*;
   import tuxwars.battle.data.player.*;
   import tuxwars.data.*;
   import tuxwars.player.Player;
   import tuxwars.tournament.*;
   import tuxwars.tutorial.*;
   import tuxwars.utils.*;
   
   public class PositionSlot
   {
      private static var tuxGame:TuxWarsGame;
      
      private static const ACTIVE_SLOT:String = "Slot_Active";
      
      private static const DEFAULT_SLOT:String = "Slot_Default";
      
      private static const TROPHY_SLOT:String = "Trofies";
      
      private static const PLACE_TEXT:String = "Text_Place";
      
      private static const CONTAINER_POINTS:String = "Container_Points";
      
      private static const POINTS_DEFAULT:String = "Default";
      
      private static const POINTS_DISABLED:String = "Disabled";
      
      private static const POINTS_TEXT:String = "Text_Points";
      
      private static const NAME_TEXT:String = "Text_Name";
      
      private static const SCORE_TEXT:String = "Text_Score";
      
      private static const STAMP:String = "Stamp";
      
      private static const STAMP_WAITING:String = "Waiting";
      
      private static const STAMP_READY:String = "Ready";
      
      private static const STAMP_LEFT:String = "Left";
      
      private static const AVATAR_CONTAINER:String = "Container_Character";
      
      private var avatar:TuxAvatar;
      
      private var activeSlot:MovieClip;
      
      private var trophies:MovieClip;
      
      private var defaultSlot:MovieClip;
      
      private var _stamp:MovieClip;
      
      private var _stampWaiting:MovieClip;
      
      private var _stampReady:MovieClip;
      
      private var _stampLeft:MovieClip;
      
      private var _containerPoints:MovieClip;
      
      private var _player:Player;
      
      public function PositionSlot(param1:MovieClip)
      {
         super();
         if(!tuxGame)
         {
            MessageCenter.addListener("SendGame",this.sendGameHandler);
            MessageCenter.sendMessage("GetGame");
         }
         this.activeSlot = param1.getChildByName("Slot_Active") as MovieClip;
         this.defaultSlot = param1.getChildByName("Slot_Default") as MovieClip;
         this.activeSlot.visible = false;
         this.defaultSlot.visible = false;
         this._stamp = param1.getChildByName("Stamp") as MovieClip;
         this._stampWaiting = this._stamp.getChildByName("Waiting") as MovieClip;
         this._stampWaiting.visible = true;
         this._stampReady = this._stamp.getChildByName("Ready") as MovieClip;
         this._stampReady.visible = false;
         var _loc2_:TextField = this._stampReady.getChildByName("Text") as TextField;
         _loc2_.text = ProjectManager.getText("REMATCH_READY");
         this._stampLeft = this._stamp.getChildByName("Left") as MovieClip;
         this._stampLeft.visible = false;
         _loc2_ = this._stampLeft.getChildByName("Text") as TextField;
         _loc2_.text = ProjectManager.getText("REMATCH_LEFT");
      }
      
      public function init(param1:PlayerResult, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:MovieClip = param1.player.id == tuxGame.player.id ? this.activeSlot : this.defaultSlot;
         this._containerPoints = _loc5_.getChildByName("Container_Points") as MovieClip;
         this.initSlot(_loc5_,param1,param2,param3,param4);
         if(param1.player.isMe() && !param4)
         {
            this.playFanfare(param2);
         }
         this._player = param1.player;
         _loc5_.visible = true;
         this.setRematchStamp(0);
         if(Tutorial._tutorial)
         {
            this._stampWaiting.visible = false;
            this._stampReady.visible = false;
            this._stampLeft.visible = false;
         }
      }
      
      public function getRematchStamp() : int
      {
         if(this._stampLeft.visible)
         {
            return 2;
         }
         if(this._stampReady.visible)
         {
            return 1;
         }
         return 0;
      }
      
      public function setRematchStamp(param1:int) : void
      {
         this._stampWaiting.visible = param1 == 0;
         this._stampReady.visible = param1 == 1;
         this._stampLeft.visible = param1 == 2;
      }
      
      public function getSlotPlayer() : Player
      {
         return this._player;
      }
      
      private function playFanfare(param1:int) : void
      {
         var _loc2_:SoundReference = null;
         var _loc3_:SoundReference = null;
         var _loc4_:SoundReference = null;
         var _loc5_:SoundReference = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = Sounds.getSoundReference("Position_1");
               if(_loc2_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
               }
               break;
            case 1:
               _loc3_ = Sounds.getSoundReference("Position_2");
               if(_loc3_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
               }
               break;
            case 2:
               _loc4_ = Sounds.getSoundReference("Position_3");
               if(_loc4_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType(),"PlaySound"));
               }
               break;
            case 3:
               _loc5_ = Sounds.getSoundReference("Position_4");
               if(_loc5_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc5_.getMusicID(),_loc5_.getStart(),_loc5_.getType(),"PlaySound"));
               }
         }
      }
      
      public function dispose() : void
      {
         this.avatar.dispose();
         this.avatar = null;
         this.activeSlot = null;
         this.defaultSlot = null;
         this._player = null;
      }
      
      private function initSlot(param1:MovieClip, param2:PlayerResult, param3:int, param4:Boolean, param5:Boolean) : void
      {
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Place") as TextField,"POSITION_" + param3);
         if(param5)
         {
            param3 = 0;
         }
         TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Name") as TextField,param2.player.name);
         TuxUiUtils.createAutoTextFieldWithText(param1.getChildByName("Text_Score") as TextField,param2.score.toString());
         this.trophies = param1.getChildByName("Trofies") as MovieClip;
         this.trophies.visible = false;
         var _loc6_:int = param5 ? -1 : int(TournamentManager.getLeagueSortPriority(param2.player.getMatchLeagueInfo()));
         this.showTrophy(_loc6_);
         if(param4 && !param5)
         {
            this.compareTournamentPoints(param1,param3,param2.player.getMatchLeagueInfo() == null);
         }
         else
         {
            this._containerPoints.visible = false;
         }
         this.setupAvatar(param1.getChildByName("Container_Character") as MovieClip,param2.player,param3);
      }
      
      private function setupAvatar(param1:MovieClip, param2:Player, param3:int) : void
      {
         var _loc5_:* = undefined;
         this.avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         this.avatar.animate(new AvatarAnimation(param3 == 1 ? "win" : "lose_01"),true);
         param1.addChild(this.avatar);
         var _loc4_:Object = param2.wornItemsContainer.getWornItems();
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_)
            {
               this.avatar.wearClothing(_loc5_);
            }
         }
      }
      
      private function sendGameHandler(param1:Message) : void
      {
         MessageCenter.removeListener("SendGame",this.sendGameHandler);
         tuxGame = param1.data;
      }
      
      private function compareTournamentPoints(param1:MovieClip, param2:int, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:UIAutoTextField = null;
         this._containerPoints.visible = true;
         switch(param2 - 1)
         {
            case 0:
               _loc4_ = int(tuxGame.player.tournament.firstPositionPoints);
               break;
            case 1:
               _loc4_ = int(tuxGame.player.tournament.secondPositionPoints);
               break;
            case 2:
               _loc4_ = int(tuxGame.player.tournament.thirdPositionPoints);
               break;
            case 3:
               _loc4_ = int(tuxGame.player.tournament.fourthPositionPoints);
               break;
            default:
               _loc4_ = 0;
         }
         var _loc6_:MovieClip = this._containerPoints.getChildByName("Default") as MovieClip;
         var _loc7_:MovieClip = this._containerPoints.getChildByName("Disabled") as MovieClip;
         _loc6_.visible = false;
         _loc7_.visible = false;
         if(param3)
         {
            _loc7_.visible = true;
            _loc5_ = TuxUiUtils.createAutoTextFieldWithText(_loc7_.getChildByName("Text_Points") as TextField,_loc4_ + ProjectManager.getText("PTS"));
         }
         else
         {
            _loc6_.visible = true;
            _loc5_ = TuxUiUtils.createAutoTextFieldWithText(_loc6_.getChildByName("Text_Points") as TextField,_loc4_ + ProjectManager.getText("PTS"));
         }
      }
      
      private function showTrophy(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.trophies.visible = true;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc3_ = this.trophies.getChildByName("Trophy_0" + _loc2_) as MovieClip;
            _loc3_.visible = param1 == _loc2_;
            _loc2_++;
         }
      }
   }
}

