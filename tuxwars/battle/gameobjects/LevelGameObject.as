package tuxwars.battle.gameobjects
{
   import com.citrusengine.physics.*;
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.BitmapData;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import no.olog.utilfunctions.*;
   import starling.display.*;
   import starling.textures.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.*;
   import tuxwars.battle.data.particles.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.battle.world.loader.DynamicElementPhysics;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   import tuxwars.player.reports.events.*;
   
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
      
      public function LevelGameObject(param1:LevelGameObjectDef, param2:DCGame)
      {
         super(param1,param2);
         resourceType = "BitmapData";
         this.exportBase = param1.graphics.export;
         this.setToughness(param1.getElement().getDynamicElementPhysics().getLevelObjectData().getToughness());
         this._material = param1.getElement().getTheme().getName();
         this.score = param1.getElement().getDynamicElementPhysics().getLevelObjectData().getScore();
         setCanTakeDamage(param1.getElement().canTakeDamage());
         setCollisionFilterValues(PhysicsCollisionCategories.Get("LEVEL_OBJECT"),-1,2);
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         super.physicsUpdate(param1);
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
            this.destroyed();
         }
      }
      
      public function get material() : String
      {
         return this._material;
      }
      
      public function getToughness() : int
      {
         return this.toughness;
      }
      
      public function setToughness(param1:int) : void
      {
         this.toughness = param1;
         if(!_hasHPs)
         {
            stats.create("HP",null,0);
            _hasHPs = true;
         }
         var _loc2_:String = "HP";
         var _loc3_:String = "HP";
         (!!this.stats ? this.stats.getStat(_loc2_) : null).getModifier((!!this.stats ? this.stats.getStat(_loc3_) : null).getBaseModifierName()).value = this.toughness * 3;
      }
      
      override public function handleExplosionDamage(param1:Damage) : void
      {
         super.handleExplosionDamage(param1);
         this.setCorrectFrame();
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         if(param1 == "object" || param1 == "levelobject")
         {
            return true;
         }
         if(param1 == "metal" || param1 == "stone" || param1 == "ice" || param1 == "wood")
         {
            if(param1.toLowerCase() == this._material.toLowerCase())
            {
               return true;
            }
            return false;
         }
         return super.affectsGameObject(param1,param2);
      }
      
      override protected function createBody(param1:PhysicsGameObjectDef) : void
      {
         var _loc2_:LevelGameObjectDef = param1 as LevelGameObjectDef;
         var _loc3_:DynamicElementPhysics = _loc2_.getElement().getDynamicElementPhysics();
         body = _loc3_.getBodyManager().createBody(_loc3_.getFixtureName(),param1.space,_loc3_.getLocation(),this,_loc3_.getAngle(),false);
      }
      
      override protected function loadGraphics() : void
      {
         graphics.export = this.exportBase + "_1";
         super.loadGraphics();
         var _loc1_:Image = this.displayObject.getChildAt(0) as Image;
         _loc1_.pivotX = _loc1_.width >> 1;
         _loc1_.pivotY = _loc1_.height >> 1;
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         var _loc3_:LevelGameObject = null;
         var _loc4_:Vec2 = findFirstCollisionPosition(param2);
         super.handleCollision(param1,param2);
         if(param1.userData.gameObject is Missile)
         {
            return;
         }
         var _loc5_:Number = findFirstCollisionImpulse(param2,param1);
         if(this._material == "Ice")
         {
            takeCollisionDamage(_loc5_,param1.userData.gameObject);
         }
         else if(param1.userData.gameObject is LevelGameObject)
         {
            _loc3_ = param1.userData.gameObject as LevelGameObject;
            if(this.isHarder(_loc3_._material))
            {
               takeCollisionDamage(_loc5_,param1.userData.gameObject);
            }
         }
         else if(param1.userData.gameObject is TerrainGameObject)
         {
            takeCollisionDamage(_loc5_,param1.userData.gameObject);
         }
         if(_loc5_ * WorldPhysics.getFallDamageMultiplier() > WorldPhysics.getFallDamageEffectStartValue())
         {
            (this.game as TuxWarsGame).tuxWorld.addParticle(Particles.getParticlesReference("ObjectCollision"),_loc4_.x,_loc4_.y);
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
      
      override protected function updateTag(param1:PhysicsGameObject) : void
      {
         var _loc2_:Vector.<Tagger> = tag.playerTaggers;
         if(param1 is PlayerGameObject && Boolean(this.containsOtherPlayer(_loc2_,_loc3_._uniqueId)))
         {
            LogUtils.log("Skipping tagging this: " + shortName + " other: " + param1.shortName,this,1,"LevelObjects",false,false,false);
            return;
         }
         super.updateTag(param1);
      }
      
      private function containsOtherPlayer(param1:Vector.<Tagger>, param2:String) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.gameObject;
            if(_loc4_._uniqueId != param2)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isHarder(param1:String) : Boolean
      {
         return MATERIALS.indexOf(param1) >= MATERIALS.indexOf(this._material);
      }
      
      private function setCorrectFrame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:BitmapData = null;
         var _loc5_:Image = null;
         var _loc6_:int = calculateHitPoints();
         if(_loc6_ > 0)
         {
            _loc1_ = 3 - Math.ceil(_loc6_ / this.toughness) + 1;
            assert("Frame index out of bounds.",true,_loc1_ <= 3);
            _loc2_ = this.exportBase + "_" + _loc1_;
            _loc3_ = this.displayObject.numChildren > 0 ? this.displayObject.getChildAt(0) : null;
            if(!_loc3_ || _loc2_ != _loc3_.name)
            {
               _loc4_ = DCResourceManager.instance.getFromSWF(graphics.swf,_loc2_,"BitmapData");
               if(_loc4_)
               {
                  graphics.export = _loc2_;
                  if(_loc3_)
                  {
                     this.displayObject.removeChild(_loc3_);
                     _loc3_.dispose();
                  }
                  _loc5_ = new Image(Texture.fromBitmapData(_loc4_));
                  _loc5_.name = _loc2_;
                  _loc5_.pivotX = _loc5_.width >> 1;
                  _loc5_.pivotY = _loc5_.height >> 1;
                  this.displayObject.addChild(_loc5_);
               }
               this.playDamageSound(this is LevelGameObject ? (this as LevelGameObject).material : super.soundId);
            }
         }
      }
      
      private function playDamageSound(param1:String) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference(param1);
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getDamage(),_loc2_.getType()));
         }
      }
      
      private function destroyed() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:Tagger = null;
         var _loc2_:PlayerGameObject = null;
         if(!this._markedForRemoval)
         {
            (this.game as TuxWarsGame).tuxWorld.addParticle(Particles.getParticlesReference("ObjectDestroyed"),bodyLocation.x,bodyLocation.y);
            markForRemoval();
            if(tag.latestTagger != null && tag.latestTagger.gameObject != null)
            {
               _loc3_ = tag.latestTagger.gameObject;
               LogUtils.addDebugLine("LevelObjects",this._id + " Destroyed! Tagger: " + _loc3_._id,"LevelGameObject");
            }
            else
            {
               LogUtils.addDebugLine("LevelObjects",this._id + " Destroyed! Tagger: null (unable to get the tag gameObject)","LevelGameObject");
            }
            _loc1_ = tag.findLatestPlayerTagger();
            if(Boolean(_loc1_) && this.score != 0)
            {
               _loc2_ = _loc1_.gameObject as PlayerGameObject;
               _loc2_.addScore("Destroyed_" + this._name,this.score);
            }
            emptyCollectedDamage();
            MessageCenter.sendEvent(new ChallengeLevelObjectDestroyed(this,null));
            MessageCenter.sendEvent(new ReportLevelObjectDestroyedMessage(this));
            LogUtils.log("LevelGameObject destroyed hitPoints: " + calculateHitPoints(),this,1,"LevelObjects",false,false,false);
         }
      }
   }
}

