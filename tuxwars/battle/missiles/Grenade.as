package tuxwars.battle.missiles
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import nape.dynamics.ArbiterList;
   import nape.phys.Body;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   import tuxwars.data.SoundManager;
   
   public class Grenade extends TimerMissile
   {
       
      
      public function Grenade(def:MissileDef, game:DCGame)
      {
         super(def,game);
         tag.allowClear = false;
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,otherBody.userData.gameObject,findFirstCollisionPosition(arbiterList)));
         SoundManager.markCollision(this,otherBody.userData.gameObject);
      }
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         if(type == "grenade")
         {
            return true;
         }
         return super.affectsGameObject(type,taggerGameObject);
      }
   }
}
