package tuxwars.battle.states.player.ai
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.Random;
   import nape.geom.Ray;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.gameobjects.player.AIPlayerGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.messages.battle.AimModeMessage;
   import tuxwars.battle.net.messages.battle.MoveMessage;
   import tuxwars.battle.net.messages.battle.StopMessage;
   import tuxwars.battle.states.player.PlayerActiveWalkSubState;
   
   public class AIPlayerActiveWalkSubState extends PlayerActiveWalkSubState
   {
       
      
      private var walkingTimer:int;
      
      private var walkingDirectionLeft:Boolean;
      
      private var targetVec:Vec2;
      
      private var previousLocationX:Number;
      
      private var previousLocationJamTimer:int;
      
      public function AIPlayerActiveWalkSubState(player:PlayerGameObject, params:* = null)
      {
         super(player,params);
         walkingTimer = Random.integer(1000,3000);
         walkingDirectionLeft = Random.boolean();
         if(walkingDirectionLeft)
         {
            player.direction = 0;
         }
         else
         {
            player.direction = 1;
         }
         previousLocationJamTimer = 0;
         previousLocationX = player.container.x;
      }
      
      override public function logicUpdate(time:int) : void
      {
         super.logicUpdate(time);
         if(walkingTimer > 0)
         {
            var _loc2_:PlayerGameObject = player;
            MessageCenter.sendEvent(new MoveMessage(walkingDirectionLeft ? 0 : 1,_loc2_._id));
            findTargets();
            walkingTimer -= time;
            if(targetVec || walkingTimer <= 0)
            {
               var _loc3_:PlayerGameObject = player;
               MessageCenter.sendEvent(new StopMessage(_loc3_._id));
               var _loc4_:BattleManager = BattleManager;
               if(!tuxwars.battle.BattleManager._aiPlayerHasShot)
               {
                  (player as AIPlayerGameObject).target = targetVec;
                  var _loc5_:PlayerGameObject = player;
                  MessageCenter.sendEvent(new AimModeMessage(_loc5_._id,"BasicNuke"));
                  player.mode = "AimMode";
               }
            }
            if(player.container.x >= previousLocationX && player.container.x <= previousLocationX)
            {
               previousLocationJamTimer += time;
               if(previousLocationJamTimer >= 200)
               {
                  previousLocationJamTimer = 0;
                  walkingDirectionLeft = !walkingDirectionLeft;
                  if(walkingDirectionLeft)
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
               previousLocationJamTimer = 0;
            }
            previousLocationX = player.container.x;
         }
      }
      
      private function findTargets() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var i:int = 0;
         var _loc1_:* = null;
         var _loc7_:BattleManager = BattleManager;
         if(tuxwars.battle.BattleManager._aiPlayerHasShot)
         {
            targetVec = null;
            return;
         }
         var _loc5_:Vector.<PlayerGameObject> = BattleManager.getOpponents();
         targetVec = null;
         for each(var opponent in _loc5_)
         {
            if(!targetVec)
            {
               _loc3_ = new Ray(player.body.position,opponent.body.position.sub(player.body.position));
               var _loc8_:PlayerGameObject = player;
               _loc4_ = (_loc8_.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.space.rayMultiCast(_loc3_);
               for(i = 0; i < _loc4_.length; )
               {
                  _loc1_ = _loc4_.at(i).shape.body;
                  if(_loc1_.userData.gameObject is PlayerGameObject)
                  {
                     targetVec = _loc1_.position.copy();
                     targetVec.y -= Random.integer(10,100);
                     targetVec.subeq(player.bodyLocation);
                     break;
                  }
                  i++;
               }
            }
         }
      }
   }
}
