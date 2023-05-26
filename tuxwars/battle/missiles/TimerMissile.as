package tuxwars.battle.missiles
{
   import com.dchoc.game.DCGame;
   import com.dchoc.utils.LogUtils;
   import nape.dynamics.ArbiterList;
   import nape.phys.Body;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   
   public class TimerMissile extends Missile
   {
       
      
      private var _timer:int;
      
      public function TimerMissile(def:MissileDef, game:DCGame)
      {
         super(def,game);
         _timer = def.timer;
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         super.physicsUpdate(deltaTime);
         if(!body)
         {
            return;
         }
         if(!_markedForExplosion && elapsedTime >= _timer)
         {
            LogUtils.log("Time\'s up for: " + shortName,this,1,"Emission",false,false,false);
            markforExplosion();
            body.velocity.setxy(0,0);
            body.allowMovement = false;
            location = body.position.copy();
            emitLocation = body.position.copy();
         }
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         if(!_markedForExplosion)
         {
            super.handleCollision(otherBody,arbiterList);
         }
      }
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         if(type == "timermissile")
         {
            return true;
         }
         return super.affectsGameObject(type,taggerGameObject);
      }
   }
}
