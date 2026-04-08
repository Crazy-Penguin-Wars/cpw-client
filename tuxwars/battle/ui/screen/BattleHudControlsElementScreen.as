package tuxwars.battle.ui.screen
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import com.dchoc.ui.groups.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.text.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.events.BoosterActivatedMessage;
   import tuxwars.battle.events.PlayerFiredMessage;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.ui.logic.*;
   import tuxwars.battle.ui.screen.emoticonselection.*;
   import tuxwars.data.*;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.items.BoosterItem;
   import tuxwars.items.WeaponItem;
   import tuxwars.tutorial.*;
   import tuxwars.ui.components.*;
   import tuxwars.ui.tooltips.*;
   import tuxwars.utils.*;
   
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
      
      public function BattleHudControlsElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:BoosterItem = null;
         super(param1,param2);
         this.selectedWeapon = param2.player.inventory.getNextWeaponWithAmmo();
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Booster") as TextField,"BOOSTER");
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Change_Weapon") as TextField,"CHANGE_WEAPON");
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Weapon") as TextField,"HUD_SELECTED_WEAPON");
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Change_Booster") as TextField,"HUD_CHANGE_BOOSTER");
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Move") as TextField,"HUD_MOVE");
         TuxUiUtils.createAutoTextField(param1.getChildByName("Text_Emote") as TextField,"HUD_EMOTE");
         this._moveButton = TuxUiUtils.createButton(UIToggleButton,param1,"Button_Move",this.moveCallback,null,"TOOLTIP_BATTLE_MOVE");
         this._moveButton.addEventListener("out",this.mouseOut,false,0,true);
         this._moveButton.addEventListener("over",this.mouseOver,false,0,true);
         this._weaponButton = TuxUiUtils.createButton(IconToggleButton,param1,"Button_Weapon",this.weaponCallback,null,"TOOLTIP_BATTLE_SHOOT");
         this._weaponButton.addEventListener("out",this.mouseOut,false,0,true);
         this._weaponButton.addEventListener("over",this.mouseOver,false,0,true);
         if(BattleManager.isPracticeModeButNotTutorial())
         {
            this._weaponButton.setText(ProjectManager.getText("DEFAULT_WEAPON_COUNT"));
         }
         else
         {
            this._weaponButton.setText(this.selectedWeapon != null ? this.selectedWeapon.amount.toString() : "");
         }
         this._weaponButton.setIcon(this.selectedWeapon != null ? this.selectedWeapon.icon : null);
         this._weaponButton.setEnabled(false);
         this.radialGroup = new UIRadialGroup();
         this.radialGroup.add(this._moveButton);
         this.radialGroup.add(this._weaponButton);
         this.radialGroup.setSelectedIndex(0);
         this._changeWeaponButton = TuxUiUtils.createButton(UIButton,param1,"Button_Change_Weapon",this.changeWeaponCallback,null,"TOOLTIP_BATTLE_SWAP_WEAPON");
         this._changeWeaponButton.addEventListener("out",this.mouseOut,false,0,true);
         this._changeWeaponButton.addEventListener("over",this.mouseOver,false,0,true);
         this._changeBoosterButton = TuxUiUtils.createButton(UIButton,param1,"Button_Change_Booster",this.changeBoosterCallback,null,"TOOLTIP_BATTLE_SWAP_BOOSTER");
         this._changeBoosterButton.setEnabled(!BattleManager.isPracticeMode() || Config.isDev());
         this._changeBoosterButton.addEventListener("out",this.mouseOut,false,0,true);
         this._changeBoosterButton.addEventListener("over",this.mouseOver,false,0,true);
         this._boosterButton = TuxUiUtils.createButton(UIButton,param1,"Button_Booster",null,null);
         this._boosterButton.setEnabled(!BattleManager.isPracticeMode() || Config.isDev());
         this._boosterSelectedButton = TuxUiUtils.createButton(IconCoolDownButton,param1,"Button_Booster_Active",this.boosterActiveCallback,null,"TOOLTIP_BATTLE_BOOSTER",null);
         this._boosterSelectedButton.setCoolDownTime(BattleOptions.getRow().findField("BoosterCooldown").value * 1000);
         this._boosterSelectedButton.setType("Booster");
         this._boosterSelectedButton.setText("");
         this._boosterSelectedButton.setEnabled(false);
         this._boosterSelectedButton.setVisible(false);
         this._boosterSelectedButton.addEventListener("out",this.mouseOut,false,0,true);
         this._boosterSelectedButton.addEventListener("over",this.mouseOver,false,0,true);
         this.coolDownDoneContainer = (param1 as MovieClip).getChildByName("Container_Booster_Fx") as MovieClip;
         this.coolDownDone = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","booster_ready_fx");
         this.coolDownDone.mouseChildren = false;
         this.coolDownDone.mouseEnabled = false;
         this.coolDownDoneContainer.mouseChildren = false;
         this.coolDownDoneContainer.mouseEnabled = false;
         this.coolDownDoneContainer.addChild(this.coolDownDone);
         this.coolDownDoneContainer.visible = false;
         this.coolDownDone.stop();
         this.emoticonCoolDownDoneContainer = (param1 as MovieClip).getChildByName("Container_Emote_Fx") as MovieClip;
         this.emoticonCoolDownDone = DCResourceManager.instance.getFromSWF("flash/ui/ingame.swf","emote_ready_fx");
         this.emoticonCoolDownDone.mouseChildren = false;
         this.emoticonCoolDownDone.mouseEnabled = false;
         this.emoticonCoolDownDoneContainer.mouseChildren = false;
         this.emoticonCoolDownDoneContainer.mouseEnabled = false;
         this.emoticonCoolDownDoneContainer.addChild(this.emoticonCoolDownDone);
         this.emoticonCoolDownDoneContainer.visible = false;
         this.emoticonCoolDownDone.stop();
         this.emoticonSelectionScreen = new EmoticonSelectionScreen(param1,param2);
         this._emoteButton = TuxUiUtils.createButton(IconCoolDownButton,param1,"Button_Emote",this.emoticonSelectionScreen.emoteCallback,null,"TOOLTIP_BATTLE_EMOTE");
         this._emoteButton.setType("Emoticon");
         this._emoteButton.setCoolDownTime(3500);
         this._emoteButton.addEventListener("out",this.mouseOut,false,0,true);
         this._emoteButton.addEventListener("over",this.mouseOver,false,0,true);
         DCUtils.setBitmapSmoothing(true,this._weaponButton.getDesignMovieClip());
         MessageCenter.addListener("WeaponSelected",this.weaponSelected);
         MessageCenter.addListener("PlayerFired",this.handlePlayerFired);
         MessageCenter.addListener("BooserSelected",this.boosterSelected);
         MessageCenter.addListener("BoosterActivated",this.boosterActivated);
         MessageCenter.addListener("PlayerTurnStarted",this.playerTurnStarted);
         MessageCenter.addListener("PlayerTurnEnded",this.playerTurnEnded);
         MessageCenter.addListener("PlayerDied",this.playerDied);
         MessageCenter.addListener("PlayerSpawned",this.playerSpawned);
         MessageCenter.addListener("BoosterReadyShine",this.boosterCoolDownEnded);
         MessageCenter.addListener("EmoticonUsed",this.emoticonCoolDown);
         MessageCenter.addListener("EmoticonReadyShine",this.emoticonCoolDownEnded);
         if(!BattleManager.isPracticeMode() || Config.isDev())
         {
            _loc3_ = param2.player.getNextBooster();
            if(_loc3_)
            {
               MessageCenter.sendMessage("BooserSelected",_loc3_);
            }
         }
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("WeaponSelected",this.weaponSelected);
         MessageCenter.removeListener("PlayerFired",this.handlePlayerFired);
         MessageCenter.removeListener("BooserSelected",this.boosterSelected);
         MessageCenter.removeListener("BoosterActivated",this.boosterActivated);
         MessageCenter.removeListener("PlayerTurnStarted",this.playerTurnStarted);
         MessageCenter.removeListener("PlayerTurnEnded",this.playerTurnEnded);
         MessageCenter.removeListener("PlayerDied",this.playerDied);
         MessageCenter.removeListener("PlayerSpawned",this.playerSpawned);
         MessageCenter.removeListener("BoosterReadyShine",this.boosterCoolDownEnded);
         MessageCenter.removeListener("EmoticonUsed",this.emoticonCoolDown);
         MessageCenter.removeListener("EmoticonReadyShine",this.emoticonCoolDownEnded);
         this.radialGroup.dispose();
         this.radialGroup = null;
         this._moveButton = null;
         this._weaponButton = null;
         this._changeWeaponButton.dispose();
         this._changeWeaponButton = null;
         this._boosterButton.dispose();
         this._boosterButton = null;
         this._boosterSelectedButton.dispose();
         this._boosterSelectedButton = null;
         this._changeBoosterButton.dispose();
         this._changeBoosterButton = null;
         this._emoteButton.dispose();
         this._emoteButton = null;
         this.emoticonSelectionScreen.dispose();
         this.emoticonSelectionScreen = null;
         this.selectedBooster = null;
         this.selectedWeapon = null;
         if(this.showingTooltip)
         {
            TooltipManager.removeTooltip();
            this.showingTooltip = false;
         }
         super.dispose();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(!this.spawning)
         {
            this._boosterSelectedButton.logicUpdate(param1);
            this._emoteButton.logicUpdate(param1);
         }
      }
      
      public function get moveButton() : UIToggleButton
      {
         return this._moveButton;
      }
      
      public function get weaponButton() : IconToggleButton
      {
         return this._weaponButton;
      }
      
      public function get changeWeaponButton() : UIButton
      {
         return this._changeWeaponButton;
      }
      
      public function get boosterButton() : UIButton
      {
         return this._boosterButton;
      }
      
      public function get boosterSelectedButton() : IconCoolDownButton
      {
         return this._boosterSelectedButton;
      }
      
      public function get changeBoosterButton() : UIButton
      {
         return this._changeBoosterButton;
      }
      
      public function get emoteButton() : UIButton
      {
         return this._emoteButton;
      }
      
      private function moveCallback(param1:MouseEvent) : void
      {
         MessageCenter.sendMessage("PlayerWalkMode");
      }
      
      private function weaponCallback(param1:MouseEvent) : void
      {
         if(this.selectedWeapon)
         {
            MessageCenter.sendMessage("PlayerFireMode",this.selectedWeapon.id);
         }
         else
         {
            this.changeWeaponCallback(null);
         }
      }
      
      private function changeWeaponCallback(param1:MouseEvent) : void
      {
         this.battleHudLogic.showWeaponSelection();
      }
      
      private function changeBoosterCallback(param1:MouseEvent) : void
      {
         this.battleHudLogic.showBoosterSelection();
      }
      
      private function boosterActiveCallback(param1:MouseEvent) : void
      {
         if(Boolean(this._boosterSelectedButton.cooldownDone) && Boolean(BattleManager._boostersEnabled))
         {
            TooltipManager.removeTooltip();
            MessageCenter.sendEvent(new UseBoosterMessage(this.selectedBooster.id,game.player.id));
            this._boosterSelectedButton.activateCoolDown();
         }
      }
      
      private function emoticonCoolDown(param1:Message) : void
      {
         if(this._emoteButton.cooldownDone)
         {
            this._emoteButton.activateCoolDown();
         }
      }
      
      private function boosterActivated(param1:BoosterActivatedMessage) : void
      {
         var _loc2_:BoosterItem = null;
         if(param1.boosterItem == this.selectedBooster)
         {
            if(this.selectedBooster.amount > 0)
            {
               this._boosterSelectedButton.setText(this.selectedBooster.amount.toString());
            }
            else if(this.selectedBooster.amount == 0)
            {
               this.selectedBooster = null;
               this._boosterSelectedButton.setVisible(false);
               this._boosterButton.setVisible(true);
               _loc2_ = game.player.getNextBooster();
               if(_loc2_)
               {
                  MessageCenter.sendMessage("BooserSelected",_loc2_);
               }
            }
         }
      }
      
      private function weaponSelected(param1:Message) : void
      {
         this.selectedWeapon = param1.data;
         this._weaponButton.setIcon(this.selectedWeapon.icon);
         if(BattleManager.isPracticeModeButNotTutorial())
         {
            this._weaponButton.setText(ProjectManager.getText("DEFAULT_WEAPON_COUNT"));
         }
         else
         {
            this._weaponButton.setText(this.selectedWeapon.amount.toString());
         }
         if(Boolean(BattleManager.isLocalPlayersTurn()) && !BattleManager.getCurrentActivePlayer().fired)
         {
            this.radialGroup.setSelectedIndex(1);
         }
      }
      
      private function boosterSelected(param1:Message) : void
      {
         if(param1.data)
         {
            this.selectedBooster = param1.data;
            this._boosterSelectedButton.setIcon(this.selectedBooster.icon);
            this._boosterSelectedButton.setText(this.selectedBooster.amount.toString());
            this._boosterSelectedButton.setVisible(true);
            this._boosterButton.setVisible(false);
         }
      }
      
      private function boosterCoolDownEnded(param1:Message) : void
      {
         this.coolDownDoneContainer.visible = true;
         this.coolDownDone.gotoAndPlay(0);
         this.coolDownDone.addFrameScript(this.coolDownDone.totalFrames - 1,this.boosterCoolDownDoneEnd);
      }
      
      private function boosterCoolDownDoneEnd() : void
      {
         this.coolDownDone.stop();
         this.coolDownDoneContainer.visible = false;
      }
      
      private function emoticonCoolDownEnded(param1:Message) : void
      {
         if(this.emoticonCoolDownDoneContainer.visible == false)
         {
            this.emoticonCoolDownDoneContainer.visible = true;
            this.emoticonCoolDownDone.gotoAndPlay(0);
            this.emoticonCoolDownDone.addFrameScript(this.emoticonCoolDownDone.totalFrames - 1,this.emoticonCoolDownDoneEnd);
         }
      }
      
      private function emoticonCoolDownDoneEnd() : void
      {
         this.emoticonCoolDownDone.stop();
         this.emoticonCoolDownDoneContainer.visible = false;
      }
      
      private function playerTurnStarted(param1:Message) : void
      {
         var _loc2_:PlayerGameObject = param1.data;
         var _loc3_:* = _loc2_;
         if(_loc3_._id == game.player.id)
         {
            if(this._weaponButton)
            {
               this.radialGroup.setSelectedIndex(0);
               if(!Tutorial._tutorial || (Tutorial._tutorialStep == "TutorialMoved" || Tutorial._tutorialStep == "TutorialFired" || Tutorial._tutorialStep == "TutorialMatchTimer"))
               {
                  this._weaponButton.setEnabled(true);
               }
               this._moveButton.setEnabled(true);
            }
         }
         else
         {
            this.playerTurnEnded();
         }
      }
      
      private function playerTurnEnded(param1:Message = null) : void
      {
         this._weaponButton.setEnabled(false);
         this._moveButton.setEnabled(false);
         var _loc2_:SoundReference = Sounds.getSoundReference("TurnEnd");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType(),"PlaySound"));
         }
         if(this.showingTooltip)
         {
            TooltipManager.removeTooltip();
            this.showingTooltip = false;
         }
      }
      
      private function playerDied(param1:Message) : void
      {
         if(param1.data.id == game.player.id)
         {
            this._boosterButton.setEnabled(false);
            this._boosterSelectedButton.setEnabled(false);
            this.spawning = true;
         }
      }
      
      private function playerSpawned(param1:Message) : void
      {
         if(param1.data.id == game.player.id)
         {
            this._boosterButton.setEnabled(true);
            this.spawning = false;
         }
      }
      
      private function handlePlayerFired(param1:PlayerFiredMessage) : void
      {
         var _loc2_:* = param1.player;
         if(BattleManager.isLocalPlayer(_loc2_._id))
         {
            if(BattleManager.isPracticeModeButNotTutorial())
            {
               this._weaponButton.setText(ProjectManager.getText("DEFAULT_WEAPON_COUNT"));
            }
            else if(Boolean(this.selectedWeapon) && this.selectedWeapon.amount > 0)
            {
               this._weaponButton.setText(this.selectedWeapon.amount.toString());
            }
            else
            {
               this.selectedWeapon = game.player.inventory.getNextWeaponWithAmmo();
               this._weaponButton.setIcon(this.selectedWeapon != null ? this.selectedWeapon.icon : null);
               this._weaponButton.setText(this.selectedWeapon != null ? this.selectedWeapon.amount.toString() : "");
            }
            this.radialGroup.setSelectedIndex(0);
            this._weaponButton.setEnabled(false);
         }
      }
      
      private function get battleHudLogic() : BattleHudLogic
      {
         return logic as BattleHudLogic;
      }
      
      private function mouseOver(param1:UIButtonEvent) : void
      {
         TooltipManager.showTooltip(new GenericTooltip(param1.getButton().getParameter() as String),param1.getButton().getDesignMovieClip(),0);
         this.showingTooltip = true;
      }
      
      private function mouseOut(param1:UIButtonEvent) : void
      {
         TooltipManager.removeTooltip();
         this.showingTooltip = false;
      }
   }
}

