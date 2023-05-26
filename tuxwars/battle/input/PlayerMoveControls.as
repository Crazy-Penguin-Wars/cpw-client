package tuxwars.battle.input
{
   import com.dchoc.game.DCGame;
   import com.dchoc.game.GameWorld;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.modifier.StatModifier;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import flash.display.MovieClip;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.Contact;
   import nape.dynamics.ContactList;
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.actions.PlayerControlMouseDownAction;
   import tuxwars.battle.actions.PlayerControlsMouseUpAction;
   import tuxwars.battle.data.WorldPhysics;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.JumpFinishedMessage;
   import tuxwars.battle.net.messages.battle.JumpMessage;
   import tuxwars.battle.net.messages.battle.MoveMessage;
   import tuxwars.battle.net.messages.battle.StopMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.JumpResponse;
   import tuxwars.battle.net.responses.MoveResponse;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
   public class PlayerMoveControls
   {
      
      private static const MOVEMENT_UI:String = "move_ui";
      
      private static const JUMP:String = "Jump";
      
      private static const ARROW:String = "Arrow";
      
      private static const MOVE:String = "Move";
      
      private static const RIGHT:String = "Right";
      
      private static const LEFT:String = "Left";
      
      private static const DIRECTIONS:Array = ["Right","Left"];
      
      private static const VISIBLE:String = "Visible";
      
      private static const HOVER:String = "Hover";
      
      private static const DELIM:String = "_";
      
      private static const JUMP_COOLDOWN:int = 1000;
       
      
      private const controlsClip:MovieClip = new MovieClip();
      
      private var walkRightClip:MovieClip;
      
      private var walkLeftClip:MovieClip;
      
      private var jumpClip:MovieClip;
      
      private var arrowClip:MovieClip;
      
      private var _player:PlayerGameObject;
      
      private var actionClip:MovieClip;
      
      private var curWalkSpeed:int;
      
      private var mouseDownAction:PlayerControlMouseDownAction;
      
      private var mouseUpAction:PlayerControlsMouseUpAction;
      
      private var _mouseDown:Boolean;
      
      private var _leftKeyDown:Boolean;
      
      private var _rightKeyDown:Boolean;
      
      private var _upKeyDown:Boolean;
      
      private var lastJumpTime:int;
      
      private var _jumping:Boolean;
      
      public function PlayerMoveControls(player:PlayerGameObject)
      {
         super();
         _player = player;
         initControls();
         controlsClip.mouseEnabled = false;
         controlsClip.mouseChildren = false;
         mouseDownAction = new PlayerControlMouseDownAction(this);
         mouseUpAction = new PlayerControlsMouseUpAction(this);
      }
      
      public function dispose() : void
      {
         hideControls();
         _player = null;
         mouseDownAction = null;
         mouseUpAction = null;
         actionClip = null;
         walkRightClip = null;
         walkLeftClip = null;
         jumpClip = null;
         arrowClip = null;
      }
      
      public function physicsUpdate() : void
      {
         if(walking)
         {
            doWalk();
         }
         if(BattleManager.isLocalPlayersTurn())
         {
            updateActionClip();
            checkJumping();
            checkWalking();
         }
      }
      
      public function endTurn() : void
      {
         if(walking)
         {
            stop();
         }
         if(jumping)
         {
            jumpFinished();
         }
         if(player.body.allowRotation)
         {
            player.body.allowRotation = false;
         }
      }
      
      public function showControls() : void
      {
         var _loc1_:PlayerGameObject = player;
         var _loc2_:PlayerGameObject = player;
         if(_loc1_._id == (_loc2_.game as tuxwars.TuxWarsGame).player.id)
         {
            player.container.addChild(controlsClip);
            GameWorld.getInputSystem().addInputAction(mouseDownAction);
            GameWorld.getInputSystem().addInputAction(mouseUpAction);
         }
      }
      
      public function hideControls() : void
      {
         if(player.container.contains(controlsClip))
         {
            player.container.removeChild(controlsClip);
         }
         GameWorld.getInputSystem().removeInputAction(mouseDownAction);
         GameWorld.getInputSystem().removeInputAction(mouseUpAction);
         _mouseDown = false;
      }
      
      public function set mouseDown(value:Boolean) : void
      {
         _mouseDown = value;
      }
      
      public function get mouseDown() : Boolean
      {
         return _mouseDown;
      }
      
      public function set leftKeyDown(value:Boolean) : void
      {
         _leftKeyDown = value;
      }
      
      public function get leftKeyDown() : Boolean
      {
         return _leftKeyDown;
      }
      
      public function set rightKeyDown(value:Boolean) : void
      {
         _rightKeyDown = value;
      }
      
      public function get rightKeyDown() : Boolean
      {
         return _rightKeyDown;
      }
      
      public function set upKeyDown(value:Boolean) : void
      {
         _upKeyDown = value;
      }
      
      public function get upKeyDown() : Boolean
      {
         return _upKeyDown;
      }
      
      public function controlsVisible() : Boolean
      {
         return player.container.contains(controlsClip);
      }
      
      public function get walking() : Boolean
      {
         return curWalkSpeed != 0;
      }
      
      private function get walkingLeft() : Boolean
      {
         return curWalkSpeed < 0;
      }
      
      private function get walkingRight() : Boolean
      {
         return curWalkSpeed > 0;
      }
      
      public function get jumping() : Boolean
      {
         return _jumping;
      }
      
      public function canJump(mouseClick:Boolean) : Boolean
      {
         if(1000 > DCGame.getTime() - lastJumpTime)
         {
            return false;
         }
         var _loc2_:Array = findValidContactPoints();
         if(_loc2_.length == 0)
         {
            return false;
         }
         if(mouseClick)
         {
            return actionClip == jumpClip;
         }
         return true;
      }
      
      public function canWalk() : Boolean
      {
         return actionClip == walkLeftClip || actionClip == walkRightClip;
      }
      
      public function get player() : PlayerGameObject
      {
         return _player;
      }
      
      public function applyActionResponse(response:ActionResponse) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         switch(response.responseType - 3)
         {
            case 0:
               player.tag.clear();
               stop();
               break;
            case 1:
               player.tag.clear();
               if(!jumping)
               {
                  jump(JumpResponse(response).direction);
                  _loc2_ = Sounds.getSoundReference(Sounds.getWalk());
                  if(_loc2_)
                  {
                     MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc2_.getLoop(),_loc2_.getType(),"LoopSound"));
                  }
                  _loc4_ = Sounds.getSoundReference(Sounds.getJump());
                  if(_loc4_)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType()));
                     break;
                  }
                  break;
               }
               break;
            case 2:
               player.tag.clear();
               jumpFinished();
               break;
            case 4:
               player.tag.clear();
               walk(MoveResponse(response).direction == 0 ? "Left" : "Right");
               _loc3_ = Sounds.getSoundReference(Sounds.getWalk());
               if(_loc3_)
               {
                  if(walking && !isFallingDown())
                  {
                     MessageCenter.sendEvent(new SoundMessage("LoopSound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType()));
                     break;
                  }
                  if(isFallingDown())
                  {
                     MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc3_.getLoop(),_loc3_.getType(),"LoopSound"));
                     break;
                  }
                  break;
               }
         }
      }
      
      public function isFallingDown() : Boolean
      {
         var _loc1_:Array = findValidContactPoints();
         return _loc1_.length == 0 && player.linearVelocity.y > 0.5;
      }
      
      private function checkWalking() : void
      {
         if(mouseDown && canWalk())
         {
            if(actionClip == walkLeftClip && !walkingLeft)
            {
               var _loc1_:PlayerGameObject = player;
               MessageCenter.sendEvent(new MoveMessage(0,_loc1_._id));
            }
            else if(actionClip == walkRightClip && !walkingRight)
            {
               var _loc2_:PlayerGameObject = player;
               MessageCenter.sendEvent(new MoveMessage(1,_loc2_._id));
            }
         }
         else if(leftKeyDown && rightKeyDown && walking)
         {
            var _loc3_:PlayerGameObject = player;
            MessageCenter.sendEvent(new StopMessage(_loc3_._id));
         }
         else if(!leftKeyDown && !rightKeyDown && walking)
         {
            var _loc4_:PlayerGameObject = player;
            MessageCenter.sendEvent(new StopMessage(_loc4_._id));
         }
         else if(leftKeyDown && !walkingLeft)
         {
            var _loc5_:PlayerGameObject = player;
            MessageCenter.sendEvent(new MoveMessage(0,_loc5_._id));
         }
         else if(rightKeyDown && !walkingRight)
         {
            var _loc6_:PlayerGameObject = player;
            MessageCenter.sendEvent(new MoveMessage(1,_loc6_._id));
         }
      }
      
      private function checkJumping() : void
      {
         if(!jumping)
         {
            if(upKeyDown && canJump(false))
            {
               var _loc1_:PlayerGameObject = player;
               MessageCenter.sendEvent(new JumpMessage(getKeyboardJumpX(),-1,_loc1_._id));
            }
            else if(mouseDown && canJump(true))
            {
               var _loc2_:PlayerGameObject = player;
               MessageCenter.sendEvent(new JumpMessage(player.container.mouseX,player.container.mouseY,_loc2_._id));
            }
         }
         else if(_jumping && canJump(false) && BattleManager.isLocalPlayersTurn())
         {
            var _loc3_:PlayerGameObject = player;
            MessageCenter.sendEvent(new JumpFinishedMessage(_loc3_._id));
         }
      }
      
      private function updateActionClip() : void
      {
         var _loc1_:* = null;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         if(controlsVisible())
         {
            _loc1_ = new Vec2(player.container.mouseX,player.container.mouseY);
            if(_loc1_.length != 0)
            {
               _loc1_.normalise();
            }
            _loc4_ = Math.acos(_loc1_.dot(Config.VEC_UP));
            _loc2_ = Number(_loc1_.x >= 0 ? MathUtils.radiansToDegrees(_loc4_) : -MathUtils.radiansToDegrees(_loc4_));
            arrowClip.rotation = _loc2_;
            jumpClip.gotoAndStop("Visible");
            walkLeftClip.gotoAndStop("Visible");
            walkRightClip.gotoAndStop("Visible");
            _loc3_ = findActionMovieClip(_loc2_);
            if(_loc3_)
            {
               _loc3_.gotoAndStop("Hover");
            }
            actionClip = _loc3_;
            arrowClip.visible = actionClip != null;
         }
      }
      
      private function getKeyboardJumpX() : Number
      {
         var _loc1_:Number = WorldPhysics.getJumpAngle();
         if(leftKeyDown)
         {
            return -_loc1_;
         }
         if(rightKeyDown)
         {
            return _loc1_;
         }
         return 0;
      }
      
      private function stop() : void
      {
         curWalkSpeed = 0;
         player.body.allowRotation = false;
         player.body.angularVel = 0;
         player.body.velocity = Vec2.weak(0,player.linearVelocity.y);
         player.walking = false;
         player.idleMode = true;
         var _loc1_:SoundReference = Sounds.getSoundReference(Sounds.getWalk());
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc1_.getLoop(),_loc1_.getType(),"LoopSound"));
         }
      }
      
      private function findActionMovieClip(angleDegrees:Number) : MovieClip
      {
         var _loc2_:Number = Math.abs(angleDegrees);
         if(_loc2_ > 135)
         {
            return null;
         }
         if(_loc2_ > 45)
         {
            return angleDegrees < 0 ? walkLeftClip : walkRightClip;
         }
         return jumpClip;
      }
      
      private function initControls() : void
      {
         var _loc3_:* = null;
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","move_ui");
         for each(var dir in DIRECTIONS)
         {
            _loc3_ = _loc2_.getChildByName("Move" + "_" + dir) as MovieClip;
            controlsClip.addChild(_loc3_);
            if(dir == "Right")
            {
               walkRightClip = _loc3_;
            }
            else
            {
               walkLeftClip = _loc3_;
            }
         }
         jumpClip = _loc2_.getChildByName("Move" + "_" + "Jump") as MovieClip;
         controlsClip.addChild(jumpClip);
         arrowClip = _loc2_.getChildByName("Arrow") as MovieClip;
         controlsClip.addChild(arrowClip);
         jumpClip.gotoAndStop("Visible");
         walkLeftClip.gotoAndStop("Visible");
         walkRightClip.gotoAndStop("Visible");
      }
      
      private function walk(dir:String) : void
      {
         var walkSpeed:int = player.playerStats.walkSpeed.calculateValue();
         MessageCenter.sendMessage("HelpHudCancelMoveTimer");
         var _loc3_:Stat = player.findPlayerBoosterStat("WalkSpeed");
         if(_loc3_)
         {
            for each(var modifier in _loc3_.getModifiers())
            {
               walkSpeed = modifier.modify(walkSpeed);
            }
         }
         curWalkSpeed = dir == "Right" ? walkSpeed : -walkSpeed;
      }
      
      private function doWalk() : void
      {
         if(!player.isShooting() && !jumping && player.avatar.currentAnimation.classDefinitionName.indexOf("walk") == -1)
         {
            player.changeAnimation("walk");
         }
         player.body.allowRotation = true;
         player.body.allowMovement = true;
         var _loc1_:Vec2 = Vec2.get(curWalkSpeed,0);
         player.body.applyImpulse(_loc1_);
         player.walking = true;
         player.idleMode = false;
         if((_leftKeyDown || _rightKeyDown) && player.weapon)
         {
            player.direction = player.container.mouseX >= 0 ? 1 : 0;
         }
         else
         {
            player.direction = walkingRight ? 1 : 0;
         }
         player.activate();
         var _loc2_:PlayerGameObject = player;
         LogUtils.log("(" + player.shortName + ") PlayerMoveControls walk vec: " + _loc1_ + " pos: " + player.body.position + " stepTime: " + (_loc2_.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Controls",false,false,false);
         _loc1_.dispose();
      }
      
      private function jump(vec:Vec2) : void
      {
         player.idleMode = false;
         player.changeAnimation("jump",false);
         var sound:SoundReference = Sounds.getSoundReference(Sounds.getWalk());
         MessageCenter.sendMessage("HelpHudCancelMoveTimer");
         if(sound)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),sound.getLoop(),sound.getType(),"LoopSound"));
         }
         var jumpPowerValue:Number = player.playerStats.jumpPower.calculateValue();
         var _loc5_:Stat = player.findPlayerBoosterStat("JumpPower");
         if(_loc5_)
         {
            for each(var modifier in _loc5_.getModifiers())
            {
               jumpPowerValue = modifier.modify(jumpPowerValue);
            }
         }
         vec.normalise();
         vec.muleq(jumpPowerValue);
         player.body.allowRotation = false;
         player.body.allowMovement = true;
         player.body.angularVel = 0;
         player.body.applyImpulse(vec);
         lastJumpTime = DCGame.getTime();
         _jumping = true;
         player.activate();
         MessageCenter.sendMessage("Jumps",player);
         var _loc8_:PlayerGameObject = player;
         LogUtils.log("(" + player.shortName + ") PlayerMoveControls jump vec: " + vec + " pos: " + player.body.position + " stepTime: " + (_loc8_.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Controls",false,false,false);
      }
      
      private function jumpFinished() : void
      {
         var _loc1_:PlayerGameObject = player;
         LogUtils.log("(" + player.shortName + ") Finished jumping pos: " + player.body.position + " velocity: " + player.linearVelocity + " stepTime: " + (_loc1_.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Controls",false,false,false);
         _jumping = false;
      }
      
      private function findContactPoint(dirRight:Boolean) : Vec2
      {
         var _loc4_:Array = findValidContactPoints();
         var _loc2_:Vec2 = new Vec2(dirRight ? -2147483648 : 2147483647,0);
         for each(var p in _loc4_)
         {
            if(dirRight && p.x > _loc2_.x || !dirRight && p.x < _loc2_.x)
            {
               _loc2_.setxy(p.x,p.y);
            }
         }
         return _loc2_.x < 2147483647 && _loc2_.x > -2147483648 ? _loc2_ : null;
      }
      
      private function findValidContactPoints() : Array
      {
         var i:int = 0;
         var _loc2_:* = null;
         var ret:Array = [];
         var _loc3_:ArbiterList = player.body.arbiters;
         for(i = 0; i < _loc3_.length; )
         {
            if(_loc3_.at(i).isCollisionArbiter())
            {
               _loc2_ = _loc3_.at(i).collisionArbiter;
               ret = ret.concat(getValidPoints(_loc2_.contacts));
            }
            i++;
         }
         return ret;
      }
      
      private function getValidPoints(contacts:ContactList) : Array
      {
         var i:int = 0;
         var _loc4_:* = null;
         var _loc2_:Array = [];
         var _loc3_:Vec2 = player.body.position;
         for(i = 0; i < contacts.length; )
         {
            _loc4_ = contacts.at(i);
            if(_loc4_.position.y > _loc3_.y)
            {
               _loc2_.push(_loc4_.position.copy());
            }
            i++;
         }
         return _loc2_;
      }
   }
}
