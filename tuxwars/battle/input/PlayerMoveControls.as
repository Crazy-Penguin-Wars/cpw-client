package tuxwars.battle.input
{
   import com.dchoc.game.*;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.Contact;
   import nape.dynamics.ContactList;
   import nape.geom.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.actions.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.responses.*;
   import tuxwars.data.*;
   
   public class PlayerMoveControls
   {
      private static const MOVEMENT_UI:String = "move_ui";
      
      private static const JUMP:String = "Jump";
      
      private static const ARROW:String = "Arrow";
      
      private static const MOVE:String = "Move";
      
      private static const RIGHT:String = "Right";
      
      private static const LEFT:String = "Left";
      
      private static const VISIBLE:String = "Visible";
      
      private static const HOVER:String = "Hover";
      
      private static const DELIM:String = "_";
      
      private static const JUMP_COOLDOWN:int = 1000;
      
      private static const DIRECTIONS:Array = ["Right","Left"];
      
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
      
      public function PlayerMoveControls(param1:PlayerGameObject)
      {
         super();
         this._player = param1;
         this.initControls();
         this.controlsClip.mouseEnabled = false;
         this.controlsClip.mouseChildren = false;
         this.mouseDownAction = new PlayerControlMouseDownAction(this);
         this.mouseUpAction = new PlayerControlsMouseUpAction(this);
      }
      
      public function dispose() : void
      {
         this.hideControls();
         this._player = null;
         this.mouseDownAction = null;
         this.mouseUpAction = null;
         this.actionClip = null;
         this.walkRightClip = null;
         this.walkLeftClip = null;
         this.jumpClip = null;
         this.arrowClip = null;
      }
      
      public function physicsUpdate() : void
      {
         if(this.walking)
         {
            this.doWalk();
         }
         if(BattleManager.isLocalPlayersTurn())
         {
            this.updateActionClip();
            this.checkJumping();
            this.checkWalking();
         }
      }
      
      public function endTurn() : void
      {
         if(this.walking)
         {
            this.stop();
         }
         if(this.jumping)
         {
            this.jumpFinished();
         }
         if(this.player.body.allowRotation)
         {
            this.player.body.allowRotation = false;
         }
      }
      
      public function showControls() : void
      {
         var _loc1_:PlayerGameObject = this.player;
         var _loc2_:PlayerGameObject = this.player;
         if(_loc1_._id == (_loc2_.game as TuxWarsGame).player.id)
         {
            this.player.container.addChild(this.controlsClip);
            GameWorld.getInputSystem().addInputAction(this.mouseDownAction);
            GameWorld.getInputSystem().addInputAction(this.mouseUpAction);
         }
      }
      
      public function hideControls() : void
      {
         if(this.player.container.contains(this.controlsClip))
         {
            this.player.container.removeChild(this.controlsClip);
         }
         GameWorld.getInputSystem().removeInputAction(this.mouseDownAction);
         GameWorld.getInputSystem().removeInputAction(this.mouseUpAction);
         this._mouseDown = false;
      }
      
      public function set mouseDown(param1:Boolean) : void
      {
         this._mouseDown = param1;
      }
      
      public function get mouseDown() : Boolean
      {
         return this._mouseDown;
      }
      
      public function set leftKeyDown(param1:Boolean) : void
      {
         this._leftKeyDown = param1;
      }
      
      public function get leftKeyDown() : Boolean
      {
         return this._leftKeyDown;
      }
      
      public function set rightKeyDown(param1:Boolean) : void
      {
         this._rightKeyDown = param1;
      }
      
      public function get rightKeyDown() : Boolean
      {
         return this._rightKeyDown;
      }
      
      public function set upKeyDown(param1:Boolean) : void
      {
         this._upKeyDown = param1;
      }
      
      public function get upKeyDown() : Boolean
      {
         return this._upKeyDown;
      }
      
      public function controlsVisible() : Boolean
      {
         return this.player.container.contains(this.controlsClip);
      }
      
      public function get walking() : Boolean
      {
         return this.curWalkSpeed != 0;
      }
      
      private function get walkingLeft() : Boolean
      {
         return this.curWalkSpeed < 0;
      }
      
      private function get walkingRight() : Boolean
      {
         return this.curWalkSpeed > 0;
      }
      
      public function get jumping() : Boolean
      {
         return this._jumping;
      }
      
      public function canJump(param1:Boolean) : Boolean
      {
         if(1000 > DCGame.getTime() - this.lastJumpTime)
         {
            return false;
         }
         var _loc2_:Array = this.findValidContactPoints();
         if(_loc2_.length == 0)
         {
            return false;
         }
         if(param1)
         {
            return this.actionClip == this.jumpClip;
         }
         return true;
      }
      
      public function canWalk() : Boolean
      {
         return this.actionClip == this.walkLeftClip || this.actionClip == this.walkRightClip;
      }
      
      public function get player() : PlayerGameObject
      {
         return this._player;
      }
      
      public function applyActionResponse(param1:ActionResponse) : void
      {
         var _loc2_:SoundReference = null;
         var _loc3_:SoundReference = null;
         var _loc4_:SoundReference = null;
         switch(param1.responseType - 3)
         {
            case 0:
               this.player.tag.clear();
               this.stop();
               break;
            case 1:
               this.player.tag.clear();
               if(!this.jumping)
               {
                  this.jump(JumpResponse(param1).direction);
                  _loc3_ = Sounds.getSoundReference(Sounds.getWalk());
                  if(_loc3_)
                  {
                     MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc3_.getLoop(),_loc3_.getType(),"LoopSound"));
                  }
                  _loc4_ = Sounds.getSoundReference(Sounds.getJump());
                  if(_loc4_)
                  {
                     MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc4_.getMusicID(),_loc4_.getStart(),_loc4_.getType()));
                  }
               }
               break;
            case 2:
               this.player.tag.clear();
               this.jumpFinished();
               break;
            case 4:
               this.player.tag.clear();
               this.walk(MoveResponse(param1).direction == 0 ? "Left" : "Right");
               _loc2_ = Sounds.getSoundReference(Sounds.getWalk());
               if(_loc2_)
               {
                  if(this.walking && !this.isFallingDown())
                  {
                     MessageCenter.sendEvent(new SoundMessage("LoopSound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType()));
                  }
                  else if(this.isFallingDown())
                  {
                     MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc2_.getLoop(),_loc2_.getType(),"LoopSound"));
                  }
               }
         }
      }
      
      public function isFallingDown() : Boolean
      {
         var _loc1_:Array = this.findValidContactPoints();
         return _loc1_.length == 0 && this.player.linearVelocity.y > 0.5;
      }
      
      private function checkWalking() : void
      {
         var _loc1_:PlayerGameObject = null;
         var _loc2_:PlayerGameObject = null;
         var _loc3_:PlayerGameObject = null;
         var _loc4_:PlayerGameObject = null;
         var _loc5_:PlayerGameObject = null;
         var _loc6_:PlayerGameObject = null;
         if(this.mouseDown && this.canWalk())
         {
            if(this.actionClip == this.walkLeftClip && !this.walkingLeft)
            {
               _loc1_ = this.player;
               MessageCenter.sendEvent(new MoveMessage(0,_loc1_._id));
            }
            else if(this.actionClip == this.walkRightClip && !this.walkingRight)
            {
               _loc2_ = this.player;
               MessageCenter.sendEvent(new MoveMessage(1,_loc2_._id));
            }
         }
         else if(this.leftKeyDown && this.rightKeyDown && this.walking)
         {
            _loc3_ = this.player;
            MessageCenter.sendEvent(new StopMessage(_loc3_._id));
         }
         else if(!this.leftKeyDown && !this.rightKeyDown && this.walking)
         {
            _loc4_ = this.player;
            MessageCenter.sendEvent(new StopMessage(_loc4_._id));
         }
         else if(this.leftKeyDown && !this.walkingLeft)
         {
            _loc5_ = this.player;
            MessageCenter.sendEvent(new MoveMessage(0,_loc5_._id));
         }
         else if(this.rightKeyDown && !this.walkingRight)
         {
            _loc6_ = this.player;
            MessageCenter.sendEvent(new MoveMessage(1,_loc6_._id));
         }
      }
      
      private function checkJumping() : void
      {
         var _loc1_:PlayerGameObject = null;
         var _loc2_:PlayerGameObject = null;
         var _loc3_:PlayerGameObject = null;
         if(!this.jumping)
         {
            if(this.upKeyDown && this.canJump(false))
            {
               _loc1_ = this.player;
               MessageCenter.sendEvent(new JumpMessage(this.getKeyboardJumpX(),-1,_loc1_._id));
            }
            else if(this.mouseDown && this.canJump(true))
            {
               _loc2_ = this.player;
               MessageCenter.sendEvent(new JumpMessage(this.player.container.mouseX,this.player.container.mouseY,_loc2_._id));
            }
         }
         else if(Boolean(this._jumping) && this.canJump(false) && Boolean(BattleManager.isLocalPlayersTurn()))
         {
            _loc3_ = this.player;
            MessageCenter.sendEvent(new JumpFinishedMessage(_loc3_._id));
         }
      }
      
      private function updateActionClip() : void
      {
         var _loc1_:Vec2 = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:MovieClip = null;
         if(this.controlsVisible())
         {
            _loc1_ = new Vec2(this.player.container.mouseX,this.player.container.mouseY);
            if(_loc1_.length != 0)
            {
               _loc1_.normalise();
            }
            _loc2_ = Math.acos(_loc1_.dot(Config.VEC_UP));
            _loc3_ = _loc1_.x >= 0 ? Number(MathUtils.radiansToDegrees(_loc2_)) : -MathUtils.radiansToDegrees(_loc2_);
            this.arrowClip.rotation = _loc3_;
            this.jumpClip.gotoAndStop("Visible");
            this.walkLeftClip.gotoAndStop("Visible");
            this.walkRightClip.gotoAndStop("Visible");
            _loc4_ = this.findActionMovieClip(_loc3_);
            if(_loc4_)
            {
               _loc4_.gotoAndStop("Hover");
            }
            this.actionClip = _loc4_;
            this.arrowClip.visible = this.actionClip != null;
         }
      }
      
      private function getKeyboardJumpX() : Number
      {
         var _loc1_:Number = Number(WorldPhysics.getJumpAngle());
         if(this.leftKeyDown)
         {
            return -_loc1_;
         }
         if(this.rightKeyDown)
         {
            return _loc1_;
         }
         return 0;
      }
      
      private function stop() : void
      {
         this.curWalkSpeed = 0;
         this.player.body.allowRotation = false;
         this.player.body.angularVel = 0;
         this.player.body.velocity = Vec2.weak(0,this.player.linearVelocity.y);
         this.player.walking = false;
         this.player.idleMode = true;
         var _loc1_:SoundReference = Sounds.getSoundReference(Sounds.getWalk());
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc1_.getLoop(),_loc1_.getType(),"LoopSound"));
         }
      }
      
      private function findActionMovieClip(param1:Number) : MovieClip
      {
         var _loc2_:Number = Math.abs(param1);
         if(_loc2_ > 135)
         {
            return null;
         }
         if(_loc2_ > 45)
         {
            return param1 < 0 ? this.walkLeftClip : this.walkRightClip;
         }
         return this.jumpClip;
      }
      
      private function initControls() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","move_ui");
         for each(_loc3_ in DIRECTIONS)
         {
            _loc1_ = _loc2_.getChildByName("Move" + "_" + _loc3_) as MovieClip;
            this.controlsClip.addChild(_loc1_);
            if(_loc3_ == "Right")
            {
               this.walkRightClip = _loc1_;
            }
            else
            {
               this.walkLeftClip = _loc1_;
            }
         }
         this.jumpClip = _loc2_.getChildByName("Move" + "_" + "Jump") as MovieClip;
         this.controlsClip.addChild(this.jumpClip);
         this.arrowClip = _loc2_.getChildByName("Arrow") as MovieClip;
         this.controlsClip.addChild(this.arrowClip);
         this.jumpClip.gotoAndStop("Visible");
         this.walkLeftClip.gotoAndStop("Visible");
         this.walkRightClip.gotoAndStop("Visible");
      }
      
      private function walk(param1:String) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:int = this.player.playerStats.walkSpeed.calculateValue();
         MessageCenter.sendMessage("HelpHudCancelMoveTimer");
         var _loc3_:Stat = this.player.findPlayerBoosterStat("WalkSpeed");
         if(_loc3_)
         {
            for each(_loc4_ in _loc3_.getModifiers())
            {
               _loc2_ = int(_loc4_.modify(_loc2_));
            }
         }
         this.curWalkSpeed = param1 == "Right" ? _loc2_ : int(-_loc2_);
      }
      
      private function doWalk() : void
      {
         if(!this.player.isShooting() && !this.jumping && this.player.avatar.currentAnimation.classDefinitionName.indexOf("walk") == -1)
         {
            this.player.changeAnimation("walk");
         }
         this.player.body.allowRotation = true;
         this.player.body.allowMovement = true;
         var _loc1_:Vec2 = Vec2.get(this.curWalkSpeed,0);
         this.player.body.applyImpulse(_loc1_);
         this.player.walking = true;
         this.player.idleMode = false;
         if((Boolean(this._leftKeyDown) || Boolean(this._rightKeyDown)) && Boolean(this.player.weapon))
         {
            this.player.direction = this.player.container.mouseX >= 0 ? 1 : 0;
         }
         else
         {
            this.player.direction = !!this.walkingRight ? 1 : 0;
         }
         this.player.activate();
         var _loc2_:PlayerGameObject = this.player;
         LogUtils.log("(" + this.player.shortName + ") PlayerMoveControls walk vec: " + _loc1_ + " pos: " + this.player.body.position + " stepTime: " + (_loc2_.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Controls",false,false,false);
         _loc1_.dispose();
      }
      
      private function jump(param1:Vec2) : void
      {
         var _loc6_:* = undefined;
         this.player.idleMode = false;
         this.player.changeAnimation("jump",false);
         var _loc2_:SoundReference = Sounds.getSoundReference(Sounds.getWalk());
         MessageCenter.sendMessage("HelpHudCancelMoveTimer");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",Sounds.getWalk(),_loc2_.getLoop(),_loc2_.getType(),"LoopSound"));
         }
         var _loc3_:Number = this.player.playerStats.jumpPower.calculateValue();
         var _loc4_:Stat = this.player.findPlayerBoosterStat("JumpPower");
         if(_loc4_)
         {
            for each(_loc6_ in _loc4_.getModifiers())
            {
               _loc3_ = Number(_loc6_.modify(_loc3_));
            }
         }
         param1.normalise();
         param1.muleq(_loc3_);
         this.player.body.allowRotation = false;
         this.player.body.allowMovement = true;
         this.player.body.angularVel = 0;
         this.player.body.applyImpulse(param1);
         this.lastJumpTime = DCGame.getTime();
         this._jumping = true;
         this.player.activate();
         MessageCenter.sendMessage("Jumps",this.player);
         var _loc5_:PlayerGameObject = this.player;
         LogUtils.log("(" + this.player.shortName + ") PlayerMoveControls jump vec: " + param1 + " pos: " + this.player.body.position + " stepTime: " + (_loc5_.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Controls",false,false,false);
      }
      
      private function jumpFinished() : void
      {
         var _loc1_:PlayerGameObject = this.player;
         LogUtils.log("(" + this.player.shortName + ") Finished jumping pos: " + this.player.body.position + " velocity: " + this.player.linearVelocity + " stepTime: " + (_loc1_.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Controls",false,false,false);
         this._jumping = false;
      }
      
      private function findContactPoint(param1:Boolean) : Vec2
      {
         var _loc4_:* = undefined;
         var _loc2_:Array = this.findValidContactPoints();
         var _loc3_:Vec2 = new Vec2(param1 ? -2147483648 : 2147483647,0);
         for each(_loc4_ in _loc2_)
         {
            if(param1 && _loc4_.x > _loc3_.x || !param1 && _loc4_.x < _loc3_.x)
            {
               _loc3_.setxy(_loc4_.x,_loc4_.y);
            }
         }
         return _loc3_.x < 2147483647 && _loc3_.x > -2147483648 ? _loc3_ : null;
      }
      
      private function findValidContactPoints() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:CollisionArbiter = null;
         var _loc3_:Array = [];
         var _loc4_:ArbiterList = this.player.body.arbiters;
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            if(_loc4_.at(_loc1_).isCollisionArbiter())
            {
               _loc2_ = _loc4_.at(_loc1_).collisionArbiter;
               _loc3_ = _loc3_.concat(this.getValidPoints(_loc2_.contacts));
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      private function getValidPoints(param1:ContactList) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Contact = null;
         var _loc4_:Array = [];
         var _loc5_:Vec2 = this.player.body.position;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1.at(_loc2_);
            if(_loc3_.position.y > _loc5_.y)
            {
               _loc4_.push(_loc3_.position.copy());
            }
            _loc2_++;
         }
         return _loc4_;
      }
   }
}

