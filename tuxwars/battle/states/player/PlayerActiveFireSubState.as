package tuxwars.battle.states.player
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.*;
   import tuxwars.battle.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.responses.*;
   import tuxwars.battle.states.weapon.*;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.challenges.events.*;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.net.*;
   
   public class PlayerActiveFireSubState extends PlayerState
   {
      private var playerAnimationPlayed:Boolean;
      
      private var finishHandled:Boolean;
      
      public function PlayerActiveFireSubState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         var _loc3_:PlayerGameObject = null;
         var _loc1_:Vec2 = null;
         var _loc2_:Vec2 = null;
         LogUtils.log(player + " Entering PlayerActiveFireSubState",null);
         super.enter();
         if(player.mode != "FireMode")
         {
            player.mode = "FireMode";
         }
         if(BattleManager.isLocalPlayersTurn())
         {
            _loc1_ = player.weapon.targeting == "Target" ? player.weapon.controls.targetLocation : player.bodyLocation;
            _loc2_ = Vec2.get(player.container.mouseX,player.container.mouseY);
            _loc3_ = player;
            MessageCenter.sendEvent(new FireWeaponMessage(_loc2_,_loc1_,player.weapon.controls.getLastTargetingPowerPercentage(),player.weapon.id,_loc3_._id));
            _loc2_.dispose();
         }
      }
      
      override public function handleMessage(param1:ActionResponse) : void
      {
         var _loc2_:FireWeaponResponse = null;
         super.handleMessage(param1);
         LogUtils.addDebugLine("HandleMessage","Handling response: " + param1.responseType,"PlayerActiveFireSubState");
         switch(param1.responseType - 3)
         {
            case 0:
            case 1:
            case 2:
            case 4:
               player.moveControls.applyActionResponse(param1);
               break;
            case 3:
               player.changeWeapon(ChangeWeaponResponse(param1).weaponId);
               break;
            case 7:
               _loc2_ = FireWeaponResponse(param1);
               _params = {
                  "dir":_loc2_.direction,
                  "powerBar":_loc2_.powerBar
               };
               if(!player.weapon)
               {
                  player.createWeapon(_loc2_.weaponId,true);
               }
               player.weapon.changeState(new WeaponFireState(player.weapon,game));
               player.changeAnimation("fire",false,this.animPlayed);
               player.weapon.emitLocation = _loc2_.location;
               this.fireEmissions();
         }
      }
      
      override public function exit() : void
      {
         player.changeWeapon(null);
         player.avatar.paperDoll.animation.clearCallback();
         if(player.moveControls.walking)
         {
            player.changeAnimation("walk");
         }
         else
         {
            player.idleMode = true;
         }
         super.exit();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(player.weapon && player.weapon.isFinished() && this.playerAnimationPlayed && !this.finishHandled)
         {
            this.finished();
         }
      }
      
      protected function finished() : void
      {
         var _loc1_:PlayerGameObject = null;
         var _loc2_:PlayerGameObject = null;
         player.moveControls.showControls();
         if(BattleManager.isLocalPlayersTurn())
         {
            _loc1_ = player;
            MessageCenter.sendEvent(new ChangeWeaponMessage(null,_loc1_._id));
            _loc2_ = player;
            MessageCenter.sendEvent(new WalkModeMessage(_loc2_._id));
         }
         this.finishHandled = true;
      }
      
      private function animPlayed() : void
      {
         this.playerAnimationPlayed = true;
      }
      
      private function fireEmissions() : void
      {
         var _loc1_:int = 0;
         var _loc2_:EmissionReference = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:int = 0;
         var _loc5_:Weapon = player.weapon;
         var _loc6_:Array = player.getMissileBoosterEmissions();
         var _loc7_:Array = player.getExplosionBoosterEmissions();
         var _loc8_:int = 1;
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            _loc2_ = _loc6_[_loc1_];
            _loc8_ *= _loc2_.number;
            _loc5_.setBoosterMissileEmissions(_loc2_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc7_.length)
         {
            _loc5_.setBoosterExplosionEmissions(_loc7_[_loc1_]);
            _loc1_++;
         }
         _loc5_.playerBoosterStats = player.playerBoosterStats;
         var _loc9_:Follower = player.getFollower("Status_WeaponFireChance");
         if(_loc9_)
         {
            _loc3_ = Number(_loc9_.variables[1]);
            if(!isNaN(_loc3_) && _loc3_ > 0)
            {
               _loc4_ = int(BattleManager.getRandom().integer(0,100));
               if(_loc4_ <= _loc3_)
               {
                  _loc8_ *= _loc9_.variables[2];
               }
               else
               {
                  _loc8_ *= _loc9_.variables[3];
               }
            }
         }
         _loc5_.setEmissionsParams("RepeatCount",_loc8_);
         _loc5_.setEmissionsParams("Params",params);
         var _loc10_:PlayerGameObject = player;
         MessageCenter.sendEvent(new EmissionMessage(new EmissionSpawn(_loc5_,_loc5_.location,_loc5_.tagger),_loc10_._id));
         player.reduceBoosterDurations("Shot",1);
         var _loc11_:PlayerGameObject = player;
         if(BattleManager.isLocalPlayer(_loc11_._id))
         {
            CRMService.sendEvent("Action","Use_Weapon","Used",_loc5_.id);
         }
         MessageCenter.sendEvent(new PlayerFiredMessage(player,_loc5_));
         MessageCenter.sendEvent(new ChallengeWeaponUsedMessage(_loc5_));
         var _loc12_:PlayerGameObject = player;
         LogUtils.log("PlayerActiveFireSubState weapon: " + _loc5_.id + " player: " + _loc12_._uniqueId,this,1,"Player",false,false,false);
      }
   }
}

