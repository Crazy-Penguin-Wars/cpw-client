package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ChallengeTakeCollisionDamageMessage extends Message
   {
       
      
      private var _damagedObject:PhysicsGameObject;
      
      private var _objectDoingDamage:PhysicsGameObject;
      
      private var _damageAmount:int;
      
      private var _playerTaggerOfObjectDoingDamage:PlayerGameObject;
      
      public function ChallengeTakeCollisionDamageMessage(damagedObject:PhysicsGameObject, objectDoingDamage:PhysicsGameObject, damageAmount:int)
      {
         var _loc4_:* = null;
         super("ChallengeTakeCollisionDamage");
         _damagedObject = damagedObject;
         _objectDoingDamage = objectDoingDamage;
         _damageAmount = damageAmount;
         if(objectDoingDamage != null)
         {
            _loc4_ = objectDoingDamage.tag.findLatestPlayerTagger();
            if(_loc4_ != null && _loc4_.gameObject)
            {
               _playerTaggerOfObjectDoingDamage = _loc4_.gameObject as PlayerGameObject;
            }
            else if(objectDoingDamage is PlayerGameObject)
            {
               _playerTaggerOfObjectDoingDamage = objectDoingDamage as PlayerGameObject;
            }
         }
      }
      
      public function get damagedObject() : PhysicsGameObject
      {
         return _damagedObject;
      }
      
      public function get objectDoingDamage() : PhysicsGameObject
      {
         return _objectDoingDamage;
      }
      
      public function get damageAmount() : int
      {
         return _damageAmount;
      }
      
      public function get playerTaggerOfObjectDoingDamage() : PlayerGameObject
      {
         return _playerTaggerOfObjectDoingDamage;
      }
   }
}
