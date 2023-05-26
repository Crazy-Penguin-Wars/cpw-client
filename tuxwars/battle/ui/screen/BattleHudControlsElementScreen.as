package tuxwars.battle.ui.screen
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.buttons.UIToggleButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.groups.UIRadialGroup;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.BattleOptions;
   import tuxwars.battle.events.BoosterActivatedMessage;
   import tuxwars.battle.events.PlayerFiredMessage;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.UseBoosterMessage;
   import tuxwars.battle.ui.logic.BattleHudLogic;
   import tuxwars.battle.ui.screen.emoticonselection.EmoticonSelectionScreen;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.BoosterItem;
   import tuxwars.items.WeaponItem;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.components.IconCoolDownButton;
   import tuxwars.ui.components.IconToggleButton;
   import tuxwars.ui.tooltips.GenericTooltip;
   import tuxwars.ui.tooltips.TooltipManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class BattleHudControlsElementScreen extends TuxUIElementScreen
   {
      
      private static const BOOSTER_TEXT:String = "Text_Booster";
      
      private static const CHANGE_WEAPON_TEXT:String = "Text_Change_Weapon";
      
      private static const WEAPON_TEXT:String = "Text_Weapon";
      
      private static const MOVE_TEXT:String = "Text_Move";
      
      private static const CHANGE_BOOSTER_TEXT:String = "Text_Change_Booster";
      
      private static const EMOTE_TEXT:String = "Text_Emote";
      
      private static const BUTTON_WEAPON:String = "Button_Weapon";
      
      private static const BUTTON_MOVE:String = "Button_Move";
      
      private static const BUTTON_CHANGE_WEAPON:String = "Button_Change_Weapon";
      
      private static const BUTTON_BOOSTER:String = "Button_Booster";
      
      private static const BUTTON_BOOSTER_ACTIVE:String = "Button_Booster_Active";
      
      private static const BUTTON_CHANGE_BOOSTER:String = "Button_Change_Booster";
      
      private static const MOVE_BUTTON_INDEX:int = 0;
      
      private static const WEAPON_BUTTON_INDEX:int = 1;
      
      private static const BUTTON_EMOTE:String = "Button_Emote";
      
      private static const ANIM_IN:String = "Visible_To_Hover";
      
      private static const ANIM_OUT:String = "Hover_To_Visible";
       
      
      private var radialGroup:UIRadialGroup;
      
      private var _moveButton:UIToggleButton;
      
      private var _weaponButton:IconToggleButton;
      
      private var _changeWeaponButton:UIButton;
      
      private var _changeBoosterButton:UIButton;
      
      private var _boosterButton:UIButton;
      
      private var _boosterSelectedButton:IconCoolDownButton;
      
      private var _emoteButton:IconCoolDownButton;
      
      private var selectedWeapon:WeaponItem;
      
      private var selectedBooster:BoosterItem;
      
      private var emoticonSelectionScreen:EmoticonSelectionScreen;
      
      private var showingTooltip:Boolean;
      
      private var coolDownDone:MovieClip;
      
      private var coolDownDoneContainer:MovieClip;
      
      private var emoticonCoolDownDone:MovieClip;
      
      private var emoticonCoolDownDoneContainer:MovieClip;
      
      private var buttonBoosterActiveContainer:MovieClip;
      
      private var spawning:Boolean;
      
      public function BattleHudControlsElementScreen(design:MovieClip, game:TuxWarsGame)
      {
         var _loc3_:* = null;
         super(design,game);
         selectedWeapon = game.player.inventory.getNextWeaponWithAmmo();
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Booster") as TextField,"BOOSTER");
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Change_Weapon") as TextField,"CHANGE_WEAPON");
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Weapon") as TextField,"HUD_SELECTED_WEAPON");
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Change_Booster") as TextField,"HUD_CHANGE_BOOSTER");
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Move") as TextField,"HUD_MOVE");
         TuxUiUtils.createAutoTextField(design.getChildByName("Text_Emote") as TextField,"HUD_EMOTE");
         _moveButton = TuxUiUtils.createButton(UIToggleButton,design,"Button_Move",moveCallback,null,"TOOLTIP_BATTLE_MOVE");
         _moveButton.addEventListener("out",mouseOut,false,0,true);
         _moveButton.addEventListener("over",mouseOver,false,0,true);
         _weaponButton = TuxUiUtils.createButton(IconToggleButton,design,"Button_Weapon",weaponCallback,null,"TOOLTIP_BATTLE_SHOOT");
         _weaponButton.addEventListener("out",mouseOut,false,0,true);
         _weaponButton.addEventListener("over",mouseOver,false,0,true);
         if(BattleManager.isPracticeModeButNotTutorial())
         {
            _weaponButton.setText(ProjectManager.getText("DEFAULT_WEAPON_COUNT"));
         }
         else
         {
            _weaponButton.setText(selectedWeapon != null ? selectedWeapon.amount.toString() : "");
         }
         _weaponButton.setIcon(selectedWeapon != null ? selectedWeapon.icon : null);
         _weaponButton.setEnabled(false);
         radialGroup = new UIRadialGroup();
         radialGroup.add(_moveButton);
         radialGroup.add(_weaponButton);
         radialGroup.setSelectedIndex(0);
         _changeWeaponButton = TuxUiUtils.createButton(UIButton,design,"Button_Change_Weapon",changeWeaponCallback,null,"TOOLTIP_BATTLE_SWAP_WEAPON");
         _changeWeaponButton.addEventListener("out",mouseOut,false,0,true);
         _changeWeaponButton.addEventListener("over",mouseOver,false,0,true);
         _changeBoosterButton = TuxUiUtils.createButton(UIButton,design,"Button_Change_Booster",changeBoosterCallback,null,"TOOLTIP_BATTLE_SWAP_BOOSTER");
         _changeBoosterButton.setEnabled(!BattleManager.isPracticeMode() || Config.isDev());
         _changeBoosterButton.addEventListener("out",mouseOut,false,0,true);
         _changeBoosterButton.addEventListener("over",mouseOver,false,0,true);
         _boosterButton = TuxUiUtils.createButton(UIButton,design,"Button_Booster",null,null);
         _boosterButton.setEnabled(!BattleManager.isPracticeMode() || Config.isDev());
         _boosterSelectedButton = TuxUiUtils.createButton(IconCoolDownButton,design,"Button_Booster_Active",boosterActiveCallback,null,"TOOLTIP_BATTLE_BOOSTER",null);
         var _loc4_:BattleOptions = BattleOptions;
         _boosterSelectedButton.setCoolDownTime(Number(tuxwars.battle.data.BattleOptions.getRow().findField("BoosterCooldown").value) * 1000);
         _boosterSelectedButton.setType("Booster");
         _boosterSelectedButton.setText("");
         _boosterSelectedButton.setEnabled(false);
         _boosterSelectedButton.setVisible(false);
         _boosterSelectedButton.addEventListener("out",mouseOut,false,0,true);
         _boosterSelectedButton.addEventListener("over",mouseOver,false,0,true);
         coolDownDoneContainer = (design as MovieClip).getChildByName("Container_Booster_Fx") as MovieClip;
         coolDownDone = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","booster_ready_fx");
         coolDownDone.mouseChildren = false;
         coolDownDone.mouseEnabled = false;
         coolDownDoneContainer.mouseChildren = false;
         coolDownDoneContainer.mouseEnabled = false;
         coolDownDoneContainer.addChild(coolDownDone);
         coolDownDoneContainer.visible = false;
         coolDownDone.stop();
         emoticonCoolDownDoneContainer = (design as MovieClip).getChildByName("Container_Emote_Fx") as MovieClip;
         emoticonCoolDownDone = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","emote_ready_fx");
         emoticonCoolDownDone.mouseChildren = false;
         emoticonCoolDownDone.mouseEnabled = false;
         emoticonCoolDownDoneContainer.mouseChildren = false;
         emoticonCoolDownDoneContainer.mouseEnabled = false;
         emoticonCoolDownDoneContainer.addChild(emoticonCoolDownDone);
         emoticonCoolDownDoneContainer.visible = false;
         emoticonCoolDownDone.stop();
         emoticonSelectionScreen = new EmoticonSelectionScreen(design,game);
         _emoteButton = TuxUiUtils.createButton(IconCoolDownButton,design,"Button_Emote",emoticonSelectionScreen.emoteCallback,null,"TOOLTIP_BATTLE_EMOTE");
         _emoteButton.setType("Emoticon");
         _emoteButton.setCoolDownTime(3500);
         _emoteButton.addEventListener("out",mouseOut,false,0,true);
         _emoteButton.addEventListener("over",mouseOver,false,0,true);
         DCUtils.setBitmapSmoothing(true,_weaponButton.getDesignMovieClip());
         MessageCenter.addListener("WeaponSelected",weaponSelected);
         MessageCenter.addListener("PlayerFired",handlePlayerFired);
         MessageCenter.addListener("BooserSelected",boosterSelected);
         MessageCenter.addListener("BoosterActivated",boosterActivated);
         MessageCenter.addListener("PlayerTurnStarted",playerTurnStarted);
         MessageCenter.addListener("PlayerTurnEnded",playerTurnEnded);
         MessageCenter.addListener("PlayerDied",playerDied);
         MessageCenter.addListener("PlayerSpawned",playerSpawned);
         MessageCenter.addListener("BoosterReadyShine",boosterCoolDownEnded);
         MessageCenter.addListener("EmoticonUsed",emoticonCoolDown);
         MessageCenter.addListener("EmoticonReadyShine",emoticonCoolDownEnded);
         if(!BattleManager.isPracticeMode() || Config.isDev())
         {
            _loc3_ = game.player.getNextBooster();
            if(_loc3_)
            {
               MessageCenter.sendMessage("BooserSelected",_loc3_);
            }
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("WeaponSelected",weaponSelected);
         MessageCenter.removeListener("PlayerFired",handlePlayerFired);
         MessageCenter.removeListener("BooserSelected",boosterSelected);
         MessageCenter.removeListener("BoosterActivated",boosterActivated);
         MessageCenter.removeListener("PlayerTurnStarted",playerTurnStarted);
         MessageCenter.removeListener("PlayerTurnEnded",playerTurnEnded);
         MessageCenter.removeListener("PlayerDied",playerDied);
         MessageCenter.removeListener("PlayerSpawned",playerSpawned);
         MessageCenter.removeListener("BoosterReadyShine",boosterCoolDownEnded);
         MessageCenter.removeListener("EmoticonUsed",emoticonCoolDown);
         MessageCenter.removeListener("EmoticonReadyShine",emoticonCoolDownEnded);
         radialGroup.dispose();
         radialGroup = null;
         _moveButton = null;
         _weaponButton = null;
         _changeWeaponButton.dispose();
         _changeWeaponButton = null;
         _boosterButton.dispose();
         _boosterButton = null;
         _boosterSelectedButton.dispose();
         _boosterSelectedButton = null;
         _changeBoosterButton.dispose();
         _changeBoosterButton = null;
         _emoteButton.dispose();
         _emoteButton = null;
         emoticonSelectionScreen.dispose();
         emoticonSelectionScreen = null;
         selectedBooster = null;
         selectedWeapon = null;
         if(showingTooltip)
         {
            TooltipManager.removeTooltip();
            showingTooltip = false;
         }
         super.dispose();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(!spawning)
         {
            _boosterSelectedButton.logicUpdate(deltaTime);
            _emoteButton.logicUpdate(deltaTime);
         }
      }
      
      public function get moveButton() : UIToggleButton
      {
         return _moveButton;
      }
      
      public function get weaponButton() : IconToggleButton
      {
         return _weaponButton;
      }
      
      public function get changeWeaponButton() : UIButton
      {
         return _changeWeaponButton;
      }
      
      public function get boosterButton() : UIButton
      {
         return _boosterButton;
      }
      
      public function get boosterSelectedButton() : IconCoolDownButton
      {
         return _boosterSelectedButton;
      }
      
      public function get changeBoosterButton() : UIButton
      {
         return _changeBoosterButton;
      }
      
      public function get emoteButton() : UIButton
      {
         return _emoteButton;
      }
      
      private function moveCallback(event:MouseEvent) : void
      {
         MessageCenter.sendMessage("PlayerWalkMode");
      }
      
      private function weaponCallback(event:MouseEvent) : void
      {
         if(selectedWeapon)
         {
            MessageCenter.sendMessage("PlayerFireMode",selectedWeapon.id);
         }
         else
         {
            changeWeaponCallback(null);
         }
      }
      
      private function changeWeaponCallback(event:MouseEvent) : void
      {
         battleHudLogic.showWeaponSelection();
      }
      
      private function changeBoosterCallback(event:MouseEvent) : void
      {
         battleHudLogic.showBoosterSelection();
      }
      
      private function boosterActiveCallback(event:MouseEvent) : void
      {
         if(_boosterSelectedButton.cooldownDone && tuxwars.battle.BattleManager._boostersEnabled)
         {
            TooltipManager.removeTooltip();
            MessageCenter.sendEvent(new UseBoosterMessage(selectedBooster.id,game.player.id));
            _boosterSelectedButton.activateCoolDown();
         }
      }
      
      private function emoticonCoolDown(msg:Message) : void
      {
         if(_emoteButton.cooldownDone)
         {
            _emoteButton.activateCoolDown();
         }
      }
      
      private function boosterActivated(msg:BoosterActivatedMessage) : void
      {
         var _loc2_:* = null;
         if(msg.boosterItem == selectedBooster)
         {
            if(selectedBooster.amount > 0)
            {
               _boosterSelectedButton.setText(selectedBooster.amount.toString());
            }
            else if(selectedBooster.amount == 0)
            {
               selectedBooster = null;
               _boosterSelectedButton.setVisible(false);
               _boosterButton.setVisible(true);
               _loc2_ = game.player.getNextBooster();
               if(_loc2_)
               {
                  MessageCenter.sendMessage("BooserSelected",_loc2_);
               }
            }
         }
      }
      
      private function weaponSelected(msg:Message) : void
      {
         selectedWeapon = msg.data;
         _weaponButton.setIcon(selectedWeapon.icon);
         if(BattleManager.isPracticeModeButNotTutorial())
         {
            _weaponButton.setText(ProjectManager.getText("DEFAULT_WEAPON_COUNT"));
         }
         else
         {
            _weaponButton.setText(selectedWeapon.amount.toString());
         }
         if(BattleManager.isLocalPlayersTurn() && !BattleManager.getCurrentActivePlayer().fired)
         {
            radialGroup.setSelectedIndex(1);
         }
      }
      
      private function boosterSelected(msg:Message) : void
      {
         if(msg.data)
         {
            selectedBooster = msg.data;
            _boosterSelectedButton.setIcon(selectedBooster.icon);
            _boosterSelectedButton.setText(selectedBooster.amount.toString());
            _boosterSelectedButton.setVisible(true);
            _boosterButton.setVisible(false);
         }
      }
      
      private function boosterCoolDownEnded(msg:Message) : void
      {
         coolDownDoneContainer.visible = true;
         coolDownDone.gotoAndPlay(0);
         coolDownDone.addFrameScript(coolDownDone.totalFrames - 1,boosterCoolDownDoneEnd);
      }
      
      private function boosterCoolDownDoneEnd() : void
      {
         coolDownDone.stop();
         coolDownDoneContainer.visible = false;
      }
      
      private function emoticonCoolDownEnded(msg:Message) : void
      {
         if(emoticonCoolDownDoneContainer.visible == false)
         {
            emoticonCoolDownDoneContainer.visible = true;
            emoticonCoolDownDone.gotoAndPlay(0);
            emoticonCoolDownDone.addFrameScript(emoticonCoolDownDone.totalFrames - 1,emoticonCoolDownDoneEnd);
         }
      }
      
      private function emoticonCoolDownDoneEnd() : void
      {
         emoticonCoolDownDone.stop();
         emoticonCoolDownDoneContainer.visible = false;
      }
      
      private function playerTurnStarted(msg:Message) : void
      {
         var _loc2_:PlayerGameObject = msg.data;
         var _loc3_:* = _loc2_;
         if(_loc3_._id == game.player.id)
         {
            if(_weaponButton)
            {
               radialGroup.setSelectedIndex(0);
               var _loc4_:Tutorial = Tutorial;
               if(!tuxwars.tutorial.Tutorial._tutorial || (tuxwars.tutorial.Tutorial._tutorialStep == "TutorialMoved" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialFired" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialMatchTimer"))
               {
                  _weaponButton.setEnabled(true);
               }
               _moveButton.setEnabled(true);
            }
         }
         else
         {
            playerTurnEnded();
         }
      }
      
      private function playerTurnEnded(msg:Message = null) : void
      {
         _weaponButton.setEnabled(false);
         _moveButton.setEnabled(false);
         var _loc2_:SoundReference = Sounds.getSoundReference("TurnEnd");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType(),"PlaySound"));
         }
         if(showingTooltip)
         {
            TooltipManager.removeTooltip();
            showingTooltip = false;
         }
      }
      
      private function playerDied(msg:Message) : void
      {
         if(msg.data.id == game.player.id)
         {
            _boosterButton.setEnabled(false);
            _boosterSelectedButton.setEnabled(false);
            spawning = true;
         }
      }
      
      private function playerSpawned(msg:Message) : void
      {
         if(msg.data.id == game.player.id)
         {
            _boosterButton.setEnabled(true);
            spawning = false;
         }
      }
      
      private function handlePlayerFired(msg:PlayerFiredMessage) : void
      {
         var _loc2_:* = msg.player;
         if(BattleManager.isLocalPlayer(_loc2_._id))
         {
            if(BattleManager.isPracticeModeButNotTutorial())
            {
               _weaponButton.setText(ProjectManager.getText("DEFAULT_WEAPON_COUNT"));
            }
            else if(selectedWeapon && selectedWeapon.amount > 0)
            {
               _weaponButton.setText(selectedWeapon.amount.toString());
            }
            else
            {
               selectedWeapon = game.player.inventory.getNextWeaponWithAmmo();
               _weaponButton.setIcon(selectedWeapon != null ? selectedWeapon.icon : null);
               _weaponButton.setText(selectedWeapon != null ? selectedWeapon.amount.toString() : "");
            }
            radialGroup.setSelectedIndex(0);
            _weaponButton.setEnabled(false);
         }
      }
      
      private function get battleHudLogic() : BattleHudLogic
      {
         return logic as BattleHudLogic;
      }
      
      private function mouseOver(event:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(event.getButton().getParameter() as String),event.getButton().getDesignMovieClip(),0);
         showingTooltip = true;
      }
      
      private function mouseOut(event:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
         showingTooltip = false;
      }
   }
}
