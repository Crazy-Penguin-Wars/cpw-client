package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.missiles.Grenade;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class FireWeaponIDCollideAffectsIDNoDamage extends Counter
   {
       
      
      private var weaponIdFired:String;
      
      private var whoHit:Vector.<PhysicsGameObject>;
      
      private var contacts:Vector.<PhysicsGameObject>;
      
      public function FireWeaponIDCollideAffectsIDNoDamage(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         whoHit = new Vector.<PhysicsGameObject>();
         contacts = new Vector.<PhysicsGameObject>();
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleWeaponUsed(msg:ChallengeWeaponUsedMessage) : void
      {
         var _loc2_:* = msg.weapon.player;
         if(_loc2_._id == playerId)
         {
            weaponIdFired = msg.weapon.id;
            whoHit.splice(0,whoHit.length);
            contacts.splice(0,contacts.length);
         }
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var i:int = 0;
         var _loc3_:* = msg.firingPlayer;
         if(_loc3_._id == playerId && params.weaponIDs.indexOf(weaponIdFired) != -1 && contacts.length > 0 && whoHit.length > 0)
         {
            for(i = 0; i < whoHit.length; )
            {
               if(msg.emission.id == whoHit[i].id && msg.affectedGameObjects.indexOf(contacts[i]) == -1)
               {
                  updateValue(1);
               }
               i++;
            }
         }
      }
      
      override public function handlePhysicsObjectContact(msg:ChallengePhysicsObjectContactMessage) : void
      {
         var _loc3_:PhysicsGameObject = msg.object;
         var _loc2_:Tagger = _loc3_.tag.findLatestPlayerTagger();
         if(_loc3_ is Grenade && _loc2_ && _loc2_.gameObject && _loc4_._id == playerId)
         {
            if(ChallengeParamReference.getAffectsObject(msg.objectHit,params))
            {
               whoHit.push(_loc3_);
               contacts.push(msg.objectHit);
            }
         }
      }
   }
}
