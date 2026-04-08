package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class FireWeaponIDCollideAffectsIDNoDamage extends Counter
   {
      private var weaponIdFired:String;
      
      private var whoHit:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
      
      private var contacts:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
      
      public function FireWeaponIDCollideAffectsIDNoDamage(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleWeaponUsed(param1:ChallengeWeaponUsedMessage) : void
      {
         var _loc2_:* = param1.weapon.player;
         if(_loc2_._id == playerId)
         {
            this.weaponIdFired = param1.weapon.id;
            this.whoHit.splice(0,this.whoHit.length);
            this.contacts.splice(0,this.contacts.length);
         }
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = param1.firingPlayer;
         if(_loc3_._id == playerId && params.weaponIDs.indexOf(this.weaponIdFired) != -1 && this.contacts.length > 0 && this.whoHit.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.whoHit.length)
            {
               if(param1.emission.id == this.whoHit[_loc2_].id && param1.affectedGameObjects.indexOf(this.contacts[_loc2_]) == -1)
               {
                  updateValue(1);
               }
               _loc2_++;
            }
         }
      }
      
      override public function handlePhysicsObjectContact(param1:ChallengePhysicsObjectContactMessage) : void
      {
         var _loc2_:PhysicsGameObject = param1.object;
         var _loc3_:Tagger = _loc2_.tag.findLatestPlayerTagger();
         if(_loc2_ is Grenade && _loc3_ && _loc3_.gameObject && _loc4_._id == playerId)
         {
            if(ChallengeParamReference.getAffectsObject(param1.objectHit,params))
            {
               this.whoHit.push(_loc2_);
               this.contacts.push(param1.objectHit);
            }
         }
      }
   }
}

