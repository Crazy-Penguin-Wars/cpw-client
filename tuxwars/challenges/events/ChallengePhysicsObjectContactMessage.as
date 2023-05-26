package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import nape.geom.Vec2;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   
   public class ChallengePhysicsObjectContactMessage extends Message
   {
       
      
      private var _objectHit:PhysicsGameObject;
      
      private var _contactPoint:Vec2;
      
      public function ChallengePhysicsObjectContactMessage(objectHitting:PhysicsGameObject, objectHit:PhysicsGameObject, contactPoint:Vec2)
      {
         _objectHit = objectHit;
         _contactPoint = contactPoint;
         super("ChallengePhysicsObjectContact",objectHitting);
      }
      
      public function get object() : PhysicsGameObject
      {
         return data;
      }
      
      public function get objectHit() : PhysicsGameObject
      {
         return _objectHit;
      }
      
      public function get contactPoint() : Vec2
      {
         return _contactPoint;
      }
   }
}
