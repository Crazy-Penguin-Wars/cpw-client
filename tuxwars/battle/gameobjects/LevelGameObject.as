package tuxwars.battle.gameobjects
{
   import com.citrusengine.physics.PhysicsCollisionCategories;
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.LogUtils;
   import flash.display.BitmapData;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import no.olog.utilfunctions.assert;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.textures.Texture;
   import tuxwars.battle.data.WorldPhysics;
   import tuxwars.battle.data.particles.Particles;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.missiles.Missile;
   import tuxwars.battle.world.loader.DynamicElementPhysics;
   import tuxwars.challenges.events.ChallengeLevelObjectDestroyed;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.player.reports.events.ReportLevelObjectDestroyedMessage;
   
   public class LevelGameObject extends PhysicsGameObject
   {
      
      private static const NUM_STATES:int = 3;
      
      private static const FIRST_STATE:String = "_1";
      
      private static const SECOND_STATE:String = "_2";
      
      private static const THIRD_STATE:String = "_3";
      
      public static const MATERIAL_ICE:String = "Ice";
      
      public static const MATERIAL_WOOD:String = "Wood";
      
      public static const MATERIAL_STONE:String = "Stone";
      
      public static const MATERIAL_METAL:String = "Metal";
      
      private static const MATERIAL_CUSTOM:String = "CustomObjects";
      
      private static const MATERIALS:Array = ["CustomObjects","Ice","Wood","Stone","Metal"];
       
      
      private var toughness:int;
      
      private var exportBase:String;
      
      private var _material:String;
      
      private var score:int;
      
      public function LevelGameObject(def:LevelGameObjectDef, game:DCGame)
      {
         super(def,game);
         resourceType = "BitmapData";
         exportBase = def.graphics.export;
         setToughness(def.getElement().getDynamicElementPhysics().getLevelObjectData().getToughness());
         _material = def.getElement().getTheme().getName();
         score = def.getElement().getDynamicElementPhysics().getLevelObjectData().getScore();
         setCanTakeDamage(def.getElement().canTakeDamage());
         setCollisionFilterValues(PhysicsCollisionCategories.Get("LEVEL_OBJECT"),-1,2);
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         super.physicsUpdate(deltaTime);
         if(!body)
         {
            return;
         }
         if(body.isSleeping)
         {
            tag.clear();
         }
         if(isDeadHP())
         {
            destroyed();
         }
      }
      
      public function get material() : String
      {
         return _material;
      }
      
      public function getToughness() : int
      {
         return toughness;
      }
      
      public function setToughness(value:int) : void
      {
         toughness = value;
         if(!_hasHPs)
         {
            stats.create("HP",null,0);
            _hasHPs = true;
         }
         (!!this.stats ? this.stats.getStat("HP") : null).getModifier((!!this.stats ? this.stats.getStat("HP") : null).getBaseModifierName()).value = toughness * 3;
      }
      
      override public function handleExplosionDamage(damageSource:Damage) : void
      {
         super.handleExplosionDamage(damageSource);
         setCorrectFrame();
      }
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         if(type == "object" || type == "levelobject")
         {
            return true;
         }
         if(type == "metal" || type == "stone" || type == "ice" || type == "wood")
         {
            if(type.toLowerCase() == _material.toLowerCase())
            {
               return true;
            }
            return false;
         }
         return super.affectsGameObject(type,taggerGameObject);
      }
      
      override protected function createBody(def:PhysicsGameObjectDef) : void
      {
         var _loc3_:LevelGameObjectDef = def as LevelGameObjectDef;
         var _loc2_:DynamicElementPhysics = _loc3_.getElement().getDynamicElementPhysics();
         body = _loc2_.getBodyManager().createBody(_loc2_.getFixtureName(),def.space,_loc2_.getLocation(),this,_loc2_.getAngle(),false);
      }
      
      override protected function loadGraphics() : void
      {
         graphics.export = exportBase + "_1";
         super.loadGraphics();
         var _loc1_:Image = this._displayObject.getChildAt(0) as Image;
         _loc1_.pivotX = _loc1_.width >> 1;
         _loc1_.pivotY = _loc1_.height >> 1;
      }
      
      override protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         var _loc3_:* = null;
         var _loc4_:Vec2 = findFirstCollisionPosition(arbiterList);
         super.handleCollision(otherBody,arbiterList);
         if(otherBody.userData.gameObject is Missile)
         {
            return;
         }
         var _loc5_:Number = findFirstCollisionImpulse(arbiterList,otherBody);
         if(_material == "Ice")
         {
            takeCollisionDamage(_loc5_,otherBody.userData.gameObject);
         }
         else if(otherBody.userData.gameObject is LevelGameObject)
         {
            _loc3_ = otherBody.userData.gameObject as LevelGameObject;
            if(isHarder(_loc3_._material))
            {
               takeCollisionDamage(_loc5_,otherBody.userData.gameObject);
            }
         }
         else if(otherBody.userData.gameObject is TerrainGameObject)
         {
            takeCollisionDamage(_loc5_,otherBody.userData.gameObject);
         }
         if(_loc5_ * WorldPhysics.getFallDamageMultiplier() > WorldPhysics.getFallDamageEffectStartValue())
         {
            (this.game as tuxwars.TuxWarsGame).tuxWorld.addParticle(Particles.getParticlesReference("ObjectCollision"),_loc4_.x,_loc4_.y);
         }
      }
      
      override protected function outOfWorld() : void
      {
         if(!this._markedForRemoval)
         {
            MessageCenter.sendEvent(new ChallengeLevelObjectDestroyed(this,null));
         }
         super.outOfWorld();
      }
      
      override protected function updateTag(other:PhysicsGameObject) : void
      {
         var _loc2_:Vector.<Tagger> = tag.playerTaggers;
         if(other is PlayerGameObject && containsOtherPlayer(_loc2_,_loc3_._uniqueId))
         {
            LogUtils.log("Skipping tagging this: " + shortName + " other: " + other.shortName,this,1,"LevelObjects",false,false,false);
            return;
         }
         super.updateTag(other);
      }
      
      private function containsOtherPlayer(taggers:Vector.<Tagger>, id:String) : Boolean
      {
         for each(var tagger in taggers)
         {
            var _loc4_:* = tagger.gameObject;
            if(_loc4_._uniqueId != id)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isHarder(other:String) : Boolean
      {
         return MATERIALS.indexOf(other) >= MATERIALS.indexOf(_material);
      }
      
      private function setCorrectFrame() : void
      {
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc1_:int = calculateHitPoints();
         if(_loc1_ > 0)
         {
            _loc3_ = 3 - Math.ceil(_loc1_ / toughness) + 1;
            assert("Frame index out of bounds.",true,_loc3_ <= 3);
            _loc6_ = exportBase + "_" + _loc3_;
            _loc4_ = this._displayObject.numChildren > 0 ? this._displayObject.getChildAt(0) : null;
            if(!_loc4_ || _loc6_ != _loc4_.name)
            {
               _loc2_ = DCResourceManager.instance.getFromSWF(graphics.swf,_loc6_,"BitmapData");
               if(_loc2_)
               {
                  graphics.export = _loc6_;
                  if(_loc4_)
                  {
                     this._displayObject.removeChild(_loc4_);
                     _loc4_.dispose();
                  }
                  _loc5_ = new Image(Texture.fromBitmapData(_loc2_));
                  _loc5_.name = _loc6_;
                  _loc5_.pivotX = _loc5_.width >> 1;
                  _loc5_.pivotY = _loc5_.height >> 1;
                  this._displayObject.addChild(_loc5_);
               }
               playDamageSound(this is LevelGameObject ? (this as LevelGameObject).material : super.soundId);
            }
         }
      }
      
      private function playDamageSound(value:String) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference(value);
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getDamage(),_loc2_.getType()));
         }
      }
      
      private function destroyed() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!this._markedForRemoval)
         {
            (this.game as tuxwars.TuxWarsGame).tuxWorld.addParticle(Particles.getParticlesReference("ObjectDestroyed"),bodyLocation.x,bodyLocation.y);
            markForRemoval();
            if(tag.latestTagger != null && tag.latestTagger.gameObject != null)
            {
               var _loc3_:* = tag.latestTagger.gameObject;
               LogUtils.addDebugLine("LevelObjects",this._id + " Destroyed! Tagger: " + _loc3_._id,"LevelGameObject");
            }
            else
            {
               LogUtils.addDebugLine("LevelObjects",this._id + " Destroyed! Tagger: null (unable to get the tag gameObject)","LevelGameObject");
            }
            _loc1_ = tag.findLatestPlayerTagger();
            if(_loc1_ && score != 0)
            {
               _loc2_ = _loc1_.gameObject as PlayerGameObject;
               _loc2_.addScore("Destroyed_" + this._name,score);
            }
            emptyCollectedDamage();
            MessageCenter.sendEvent(new ChallengeLevelObjectDestroyed(this,null));
            MessageCenter.sendEvent(new ReportLevelObjectDestroyedMessage(this));
            LogUtils.log("LevelGameObject destroyed hitPoints: " + calculateHitPoints(),this,1,"LevelObjects",false,false,false);
         }
      }
   }
}
