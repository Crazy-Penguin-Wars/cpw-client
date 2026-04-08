package tuxwars.battle.missiles
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import org.odefu.flash.display.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.world.DynamicBodyManager;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   
   public class Mine extends Missile
   {
      private var activationTime:int = 250;
      
      private var primed:Boolean;
      
      public function Mine(param1:MissileDef, param2:DCGame)
      {
         super(param1,param2);
         allowDisplayObjectRotation = true;
         tag.allowClear = false;
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         super.physicsUpdate(param1);
         this.activationTime -= param1;
         if(Boolean(this.primed) && this.activationTime < 0)
         {
            this.triggerExplosion();
         }
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         switch(param1)
         {
            case "weapon":
            case "mine":
            case "object":
               return true;
            default:
               return super.affectsGameObject(param1,param2);
         }
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
      
      override protected function createBody(param1:PhysicsGameObjectDef) : void
      {
         var _loc2_:PhysicsGameObjectDef = param1 as PhysicsGameObjectDef;
         var _loc3_:DynamicBodyManager = param1.bodyManager;
         body = _loc3_.createBody(_loc2_.fixtureName,param1.space,param1.bodyDef.position,this,-180,false);
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,param1.userData.gameObject,findFirstCollisionPosition(param2)));
         if(!_markedForExplosion && param1.userData.gameObject is PlayerGameObject && this.activationTime < 0)
         {
            this.triggerExplosion();
         }
         else if(!_markedForExplosion && param1.userData.gameObject is PlayerGameObject && this.activationTime >= 0)
         {
            this.primed = true;
         }
         SoundManager.markCollision(this,param1.userData.gameObject);
      }
      
      override public function triggerEmission() : void
      {
         this.triggerExplosion();
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
         this.primed = false;
      }
      
      override public function get linearVelocity() : Vec2
      {
         return !!body ? body.velocity.copy() : null;
      }
   }
}

