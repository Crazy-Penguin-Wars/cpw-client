package tuxwars.battle.states.player
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.events.PlayerFiredMessage;
   import tuxwars.battle.gameobjects.EmissionSpawn;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.ChangeWeaponMessage;
   import tuxwars.battle.net.messages.battle.FireWeaponMessage;
   import tuxwars.battle.net.messages.battle.WalkModeMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.ChangeWeaponResponse;
   import tuxwars.battle.net.responses.FireWeaponResponse;
   import tuxwars.battle.states.weapon.WeaponFireState;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.net.CRMService;
   
   public class PlayerActiveFireSubState extends PlayerState
   {
       
      
      private var playerAnimationPlayed:Boolean;
      
      private var finishHandled:Boolean;
      
      public function PlayerActiveFireSubState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
      }
      
      override public function enter() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         LogUtils.log(player + " Entering PlayerActiveFireSubState",null);
         super.enter();
         if(player.mode != "FireMode")
         {
            player.mode = "FireMode";
         }
         if(BattleManager.isLocalPlayersTurn())
         {
            _loc2_ = player.weapon.targeting == "Target" ? player.weapon.controls.targetLocation : player.bodyLocation;
            _loc1_ = Vec2.get(player.container.mouseX,player.container.mouseY);
            var _loc3_:PlayerGameObject = player;
            MessageCenter.sendEvent(new FireWeaponMessage(_loc1_,_loc2_,player.weapon.controls.getLastTargetingPowerPercentage(),player.weapon.id,_loc3_._id));
            _loc1_.dispose();
         }
      }
      
      override public function handleMessage(response:ActionResponse) : void
      {
         var _loc2_:* = null;
         super.handleMessage(response);
         LogUtils.addDebugLine("HandleMessage","Handling response: " + response.responseType,"PlayerActiveFireSubState");
         switch(response.responseType - 3)
         {
            case 0:
            case 1:
            case 2:
            case 4:
               player.moveControls.applyActionResponse(response);
               break;
            case 3:
               player.changeWeapon(ChangeWeaponResponse(response).weaponId);
               break;
            case 7:
               _loc2_ = FireWeaponResponse(response);
               _params = {
                  "dir":_loc2_.direction,
                  "powerBar":_loc2_.powerBar
               };
               if(!player.weapon)
               {
                  player.createWeapon(_loc2_.weaponId,true);
               }
               player.weapon.changeState(new WeaponFireState(player.weapon,game));
               player.changeAnimation("fire",false,animPlayed);
               player.weapon.emitLocation = _loc2_.location;
               fireEmissions();
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
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(player.weapon && player.weapon.isFinished() && playerAnimationPlayed && !finishHandled)
         {
            finished();
         }
      }
      
      protected function finished() : void
      {
         player.moveControls.showControls();
         if(BattleManager.isLocalPlayersTurn())
         {
            var _loc1_:PlayerGameObject = player;
            MessageCenter.sendEvent(new ChangeWeaponMessage(null,_loc1_._id));
            var _loc2_:PlayerGameObject = player;
            MessageCenter.sendEvent(new WalkModeMessage(_loc2_._id));
         }
         finishHandled = true;
      }
      
      private function animPlayed() : void
      {
         playerAnimationPlayed = true;
      }
      
      private function fireEmissions() : void
      {
         var i:int = 0;
         var _loc2_:* = null;
         var _loc6_:Number = NaN;
         var _loc5_:int = 0;
         var _loc4_:Weapon = player.weapon;
         var _loc3_:Array = player.getMissileBoosterEmissions();
         var _loc9_:Array = player.getExplosionBoosterEmissions();
         var count:int = 1;
         for(i = 0; i < _loc3_.length; )
         {
            _loc2_ = _loc3_[i];
            count *= _loc2_.number;
            _loc4_.setBoosterMissileEmissions(_loc2_);
            i++;
         }
         for(i = 0; i < _loc9_.length; )
         {
            _loc4_.setBoosterExplosionEmissions(_loc9_[i]);
            i++;
         }
         _loc4_.playerBoosterStats = player.playerBoosterStats;
         var _loc7_:Follower = player.getFollower("Status_WeaponFireChance");
         if(_loc7_)
         {
            _loc6_ = Number(_loc7_.variables[1]);
            if(!isNaN(_loc6_) && _loc6_ > 0)
            {
               _loc5_ = BattleManager.getRandom().integer(0,100);
               if(_loc5_ <= _loc6_)
               {
                  count *= _loc7_.variables[2];
               }
               else
               {
                  count *= _loc7_.variables[3];
               }
            }
         }
         _loc4_.setEmissionsParams("RepeatCount",count);
         _loc4_.setEmissionsParams("Params",params);
         var _loc10_:PlayerGameObject = player;
         MessageCenter.sendEvent(new EmissionMessage(new EmissionSpawn(_loc4_,_loc4_.location,_loc4_.tagger),_loc10_._id));
         player.reduceBoosterDurations("Shot",1);
         var _loc11_:PlayerGameObject = player;
         if(BattleManager.isLocalPlayer(_loc11_._id))
         {
            CRMService.sendEvent("Action","Use_Weapon","Used",_loc4_.id);
         }
         MessageCenter.sendEvent(new PlayerFiredMessage(player,_loc4_));
         MessageCenter.sendEvent(new ChallengeWeaponUsedMessage(_loc4_));
         var _loc12_:PlayerGameObject = player;
         LogUtils.log("PlayerActiveFireSubState weapon: " + _loc4_.id + " player: " + _loc12_._uniqueId,this,1,"Player",false,false,false);
      }
   }
}
