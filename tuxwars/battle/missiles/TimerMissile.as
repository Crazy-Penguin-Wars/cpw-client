package tuxwars.battle.missiles
{
   import com.dchoc.game.DCGame;
   import com.dchoc.utils.*;
   import nape.dynamics.ArbiterList;
   import nape.phys.Body;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   
   public class TimerMissile extends Missile
   {
      private var _timer:int;
      
      public function TimerMissile(param1:MissileDef, param2:DCGame)
      {
         super(param1,param2);
         this._timer = param1.timer;
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         super.physicsUpdate(param1);
         if(!body)
         {
            return;
         }
         if(!_markedForExplosion && elapsedTime >= this._timer)
         {
            LogUtils.log("Time\'s up for: " + shortName,this,1,"Emission",false,false,false);
            markforExplosion();
            body.velocity.setxy(0,0);
            body.allowMovement = false;
            location = body.position.copy();
            emitLocation = body.position.copy();
         }
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         if(!_markedForExplosion)
         {
            super.handleCollision(param1,param2);
         }
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         if(param1 == "timermissile")
         {
            return true;
         }
         return super.affectsGameObject(param1,param2);
      }
   }
}

