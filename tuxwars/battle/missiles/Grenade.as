package tuxwars.battle.missiles
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import nape.dynamics.ArbiterList;
   import nape.phys.Body;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   
   public class Grenade extends TimerMissile
   {
      public function Grenade(param1:MissileDef, param2:DCGame)
      {
         super(param1,param2);
         tag.allowClear = false;
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,param1.userData.gameObject,findFirstCollisionPosition(param2)));
         SoundManager.markCollision(this,param1.userData.gameObject);
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         if(param1 == "grenade")
         {
            return true;
         }
         return super.affectsGameObject(param1,param2);
      }
   }
}

