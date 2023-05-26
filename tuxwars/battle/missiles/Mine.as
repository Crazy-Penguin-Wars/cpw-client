package tuxwars.battle.missiles
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import org.odefu.flash.display.OdefuMovieClip;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObjectDef;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.world.DynamicBodyManager;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   import tuxwars.data.SoundManager;
   
   public class Mine extends Missile
   {
       
      
      private var activationTime:int = 250;
      
      private var primed:Boolean;
      
      public function Mine(def:MissileDef, game:DCGame)
      {
         super(def,game);
         allowDisplayObjectRotation = true;
         tag.allowClear = false;
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         super.physicsUpdate(deltaTime);
         activationTime -= deltaTime;
         if(primed && activationTime < 0)
         {
            triggerExplosion();
         }
      }
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         switch(type)
         {
            case "weapon":
            case "mine":
               break;
            case "object":
               break;
            default:
               return super.affectsGameObject(type,taggerGameObject);
         }
         return true;
      }
      
      override public function isFinished() : Boolean
      {
         return true;
      }
      
      override protected function loadGraphics() : void
      {
         super.loadGraphics();
         if((!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null) is OdefuMovieClip)
         {
            (!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null).loop = false;
         }
         (!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null).rotation = 3.141592653589793;
      }
      
      override protected function createBody(def:PhysicsGameObjectDef) : void
      {
         var _loc2_:PhysicsGameObjectDef = def as PhysicsGameObjectDef;
         var _loc3_:DynamicBodyManager = def.bodyManager;
         body = _loc3_.createBody(_loc2_.fixtureName,def.space,def.bodyDef.position,this,-180,false);
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,otherBody.userData.gameObject,findFirstCollisionPosition(arbiterList)));
         if(!_markedForExplosion && otherBody.userData.gameObject is PlayerGameObject && activationTime < 0)
         {
            triggerExplosion();
         }
         else if(!_markedForExplosion && otherBody.userData.gameObject is PlayerGameObject && activationTime >= 0)
         {
            primed = true;
         }
         SoundManager.markCollision(this,otherBody.userData.gameObject);
      }
      
      override public function triggerEmission() : void
      {
         triggerExplosion();
      }
      
      private function triggerExplosion() : void
      {
         body.velocity.setxy(0,0);
         body.allowMovement = false;
         location = body.position.copy();
         emitLocation = body.position.copy();
         markforExplosion();
         var _loc1_:* = tagger.gameObject;
         MessageCenter.sendEvent(new EmissionMessage(this,_loc1_._id));
         primed = false;
      }
      
      override public function get linearVelocity() : Vec2
      {
         return !!body ? body.velocity.copy() : null;
      }
   }
}
