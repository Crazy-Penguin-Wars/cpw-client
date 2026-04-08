package tuxwars.battle.states.player.ai
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.*;
   import nape.phys.Body;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.states.player.PlayerActiveWalkSubState;
   
   public class AIPlayerActiveWalkSubState extends PlayerActiveWalkSubState
   {
      private var walkingTimer:int;
      
      private var walkingDirectionLeft:Boolean;
      
      private var targetVec:Vec2;
      
      private var previousLocationX:Number;
      
      private var previousLocationJamTimer:int;
      
      public function AIPlayerActiveWalkSubState(param1:PlayerGameObject, param2:* = null)
      {
         super(param1,param2);
         this.walkingTimer = Random.integer(1000,3000);
         this.walkingDirectionLeft = Random.boolean();
         if(this.walkingDirectionLeft)
         {
            param1.direction = 0;
         }
         else
         {
            param1.direction = 1;
         }
         this.previousLocationJamTimer = 0;
         this.previousLocationX = param1.container.x;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         var _loc2_:PlayerGameObject = null;
         var _loc3_:PlayerGameObject = null;
         var _loc4_:PlayerGameObject = null;
         super.logicUpdate(param1);
         if(this.walkingTimer > 0)
         {
            _loc2_ = player;
            MessageCenter.sendEvent(new MoveMessage(!!this.walkingDirectionLeft ? 0 : 1,_loc2_._id));
            this.findTargets();
            this.walkingTimer -= param1;
            if(Boolean(this.targetVec) || this.walkingTimer <= 0)
            {
               _loc3_ = player;
               MessageCenter.sendEvent(new StopMessage(_loc3_._id));
               if(!BattleManager._aiPlayerHasShot)
               {
                  (player as AIPlayerGameObject).target = this.targetVec;
                  _loc4_ = player;
                  MessageCenter.sendEvent(new AimModeMessage(_loc4_._id,"BasicNuke"));
                  player.mode = "AimMode";
               }
            }
            if(player.container.x >= this.previousLocationX && player.container.x <= this.previousLocationX)
            {
               this.previousLocationJamTimer += param1;
               if(this.previousLocationJamTimer >= 200)
               {
                  this.previousLocationJamTimer = 0;
                  this.walkingDirectionLeft = !this.walkingDirectionLeft;
                  if(this.walkingDirectionLeft)
                  {
                     player.direction = 0;
                  }
                  else
                  {
                     player.direction = 1;
                  }
               }
            }
            else
            {
               this.previousLocationJamTimer = 0;
            }
            this.previousLocationX = player.container.x;
         }
      }
      
      private function findTargets() : void
      {
         var _loc6_:* = undefined;
         var _loc7_:PlayerGameObject = null;
         var _loc1_:Ray = null;
         var _loc2_:RayResultList = null;
         var _loc3_:int = 0;
         var _loc4_:Body = null;
         if(BattleManager._aiPlayerHasShot)
         {
            this.targetVec = null;
            return;
         }
         var _loc5_:Vector.<PlayerGameObject> = BattleManager.getOpponents();
         this.targetVec = null;
         for each(_loc6_ in _loc5_)
         {
            if(!this.targetVec)
            {
               _loc1_ = new Ray(player.body.position,_loc6_.body.position.sub(player.body.position));
               _loc7_ = player;
               _loc2_ = (_loc7_.game as TuxWarsGame).tuxWorld.physicsWorld.space.rayMultiCast(_loc1_);
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc4_ = _loc2_.at(_loc3_).shape.body;
                  if(_loc4_.userData.gameObject is PlayerGameObject)
                  {
                     this.targetVec = _loc4_.position.copy();
                     this.targetVec.y -= Random.integer(10,100);
                     this.targetVec.subeq(player.bodyLocation);
                     break;
                  }
                  _loc3_++;
               }
            }
         }
      }
   }
}

