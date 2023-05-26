package tuxwars.battle.ui.screen.result.position
{
   import com.dchoc.avatar.AvatarAnimation;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.PlayerResult;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.data.player.Players;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.items.ClothingItem;
   import tuxwars.player.Player;
   import tuxwars.tournament.TournamentManager;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.utils.TuxUiUtils;
   
   public class PositionSlot
   {
      
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
      
      private static var tuxGame:TuxWarsGame;
       
      
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
      
      public function PositionSlot(design:MovieClip)
      {
         super();
         if(!tuxGame)
         {
            MessageCenter.addListener("SendGame",sendGameHandler);
            MessageCenter.sendMessage("GetGame");
         }
         activeSlot = design.getChildByName("Slot_Active") as MovieClip;
         defaultSlot = design.getChildByName("Slot_Default") as MovieClip;
         activeSlot.visible = false;
         defaultSlot.visible = false;
         _stamp = design.getChildByName("Stamp") as MovieClip;
         _stampWaiting = _stamp.getChildByName("Waiting") as MovieClip;
         _stampWaiting.visible = true;
         _stampReady = _stamp.getChildByName("Ready") as MovieClip;
         _stampReady.visible = false;
         var tf:TextField = _stampReady.getChildByName("Text") as TextField;
         tf.text = ProjectManager.getText("REMATCH_READY");
         _stampLeft = _stamp.getChildByName("Left") as MovieClip;
         _stampLeft.visible = false;
         tf = _stampLeft.getChildByName("Text") as TextField;
         tf.text = ProjectManager.getText("REMATCH_LEFT");
      }
      
      public function init(playerResult:PlayerResult, position:int, isTournament:Boolean, isZeroPointGame:Boolean) : void
      {
         var _loc5_:MovieClip = playerResult.player.id == tuxGame.player.id ? activeSlot : defaultSlot;
         _containerPoints = _loc5_.getChildByName("Container_Points") as MovieClip;
         initSlot(_loc5_,playerResult,position,isTournament,isZeroPointGame);
         if(playerResult.player.isMe() && !isZeroPointGame)
         {
            playFanfare(position);
         }
         _player = playerResult.player;
         _loc5_.visible = true;
         setRematchStamp(0);
         var _loc6_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            _stampWaiting.visible = false;
            _stampReady.visible = false;
            _stampLeft.visible = false;
         }
      }
      
      public function getRematchStamp() : int
      {
         if(_stampLeft.visible)
         {
            return 2;
         }
         if(_stampReady.visible)
         {
            return 1;
         }
         return 0;
      }
      
      public function setRematchStamp(value:int) : void
      {
         _stampWaiting.visible = value == 0;
         _stampReady.visible = value == 1;
         _stampLeft.visible = value == 2;
      }
      
      public function getSlotPlayer() : Player
      {
         return _player;
      }
      
      private function playFanfare(position:int) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         switch(position - 1)
         {
            case 0:
               _loc2_ = Sounds.getSoundReference("Position_1");
               if(_loc2_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType(),"PlaySound"));
                  break;
               }
               break;
            case 1:
               _loc5_ = Sounds.getSoundReference("Position_2");
               if(_loc5_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc5_.getMusicID(),_loc5_.getStart(),_loc5_.getType(),"PlaySound"));
                  break;
               }
               break;
            case 2:
               _loc4_ = Sounds.getSoundReference("Position_3");
               if(_loc4_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType(),"PlaySound"));
                  break;
               }
               break;
            case 3:
               _loc3_ = Sounds.getSoundReference("Position_4");
               if(_loc3_)
               {
                  MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
                  break;
               }
         }
      }
      
      public function dispose() : void
      {
         avatar.dispose();
         avatar = null;
         activeSlot = null;
         defaultSlot = null;
         _player = null;
      }
      
      private function initSlot(design:MovieClip, playerResult:PlayerResult, position:int, isTournament:Boolean, isZeroPointGame:Boolean) : void
      {
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Place") as TextField,"POSITION_" + position);
         if(isZeroPointGame)
         {
            position = 0;
         }
         TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Name") as TextField,playerResult.player.name);
         TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Score") as TextField,playerResult.score.toString());
         trophies = design.getChildByName("Trofies") as MovieClip;
         trophies.visible = false;
         var _loc6_:int = isZeroPointGame ? -1 : TournamentManager.getLeagueSortPriority(playerResult.player.getMatchLeagueInfo());
         showTrophy(_loc6_);
         if(isTournament && !isZeroPointGame)
         {
            compareTournamentPoints(design,position,playerResult.player.getMatchLeagueInfo() == null);
         }
         else
         {
            _containerPoints.visible = false;
         }
         setupAvatar(design.getChildByName("Container_Character") as MovieClip,playerResult.player,position);
      }
      
      private function setupAvatar(container:MovieClip, player:Player, position:int) : void
      {
         avatar = new TuxAvatar(Players.getPlayerData().graphics.swf);
         avatar.animate(new AvatarAnimation(position == 1 ? "win" : "lose_01"),true);
         container.addChild(avatar);
         var _loc4_:Object = player.wornItemsContainer.getWornItems();
         for each(var item in _loc4_)
         {
            if(item)
            {
               avatar.wearClothing(item);
            }
         }
      }
      
      private function sendGameHandler(msg:Message) : void
      {
         MessageCenter.removeListener("SendGame",sendGameHandler);
         tuxGame = msg.data;
      }
      
      private function compareTournamentPoints(design:MovieClip, position:int, pointsDisabled:Boolean) : void
      {
         var positionPoints:int = 0;
         var tournamentPoints:* = null;
         _containerPoints.visible = true;
         switch(position - 1)
         {
            case 0:
               positionPoints = tuxGame.player.tournament.firstPositionPoints;
               break;
            case 1:
               positionPoints = tuxGame.player.tournament.secondPositionPoints;
               break;
            case 2:
               positionPoints = tuxGame.player.tournament.thirdPositionPoints;
               break;
            case 3:
               positionPoints = tuxGame.player.tournament.fourthPositionPoints;
               break;
            default:
               positionPoints = 0;
         }
         var pointsClipDefault:MovieClip = _containerPoints.getChildByName("Default") as MovieClip;
         var pointsClipDisabled:MovieClip = _containerPoints.getChildByName("Disabled") as MovieClip;
         pointsClipDefault.visible = false;
         pointsClipDisabled.visible = false;
         if(pointsDisabled)
         {
            pointsClipDisabled.visible = true;
            tournamentPoints = TuxUiUtils.createAutoTextFieldWithText(pointsClipDisabled.getChildByName("Text_Points") as TextField,positionPoints + ProjectManager.getText("PTS"));
         }
         else
         {
            pointsClipDefault.visible = true;
            tournamentPoints = TuxUiUtils.createAutoTextFieldWithText(pointsClipDefault.getChildByName("Text_Points") as TextField,positionPoints + ProjectManager.getText("PTS"));
         }
      }
      
      private function showTrophy(leagueSortPriority:int) : void
      {
         var counter:int = 0;
         var _loc3_:* = null;
         trophies.visible = true;
         for(counter = 1; counter <= 5; )
         {
            _loc3_ = trophies.getChildByName("Trophy_0" + counter) as MovieClip;
            _loc3_.visible = leagueSortPriority == counter;
            counter++;
         }
      }
   }
}
