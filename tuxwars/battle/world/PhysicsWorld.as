package tuxwars.battle.world
{
   import com.dchoc.game.DCGame;
   import com.dchoc.game.WorldContainer;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.gameobjects.GameObjects;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.geom.*;
   import nape.callbacks.*;
   import nape.constraint.*;
   import nape.geom.*;
   import nape.phys.Body;
   import nape.phys.Material;
   import nape.shape.Polygon;
   import nape.shape.Shape;
   import nape.space.*;
   import nape.util.*;
   import starling.core.Starling;
   import starling.display.*;
   import starling.textures.*;
   import tuxwars.battle.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.parallaxes.ParallaxLayer;
   import tuxwars.battle.data.particles.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.battle.world.loader.*;
   
   public class PhysicsWorld
   {
      private static const VELOCITY_ITERATIONS:int = 30;
      
      private static const POSITION_ITERATIONS:int = 20;
      
      private static const TIME_STEP:Number = 0.022222222222222223;
      
      public static const SINGLE_TIME_STEP:Number = 22.22222222222222;
      
      public static const MAX_UPDATE_TIME:int = 667;
      
      private static const MAX_HEIGHT:int = 2048;
      
      private static const MAX_WIDTH:int = 2048;
      
      private var _space:Space = new Space(Vec2.weak(0,WorldPhysics.getGravity()));
      
      private var _powerUpSpawnRandom:Random;
      
      private var world:TuxWorld;
      
      private var startLocations:Vector.<Vec2>;
      
      private const debug:Debug;
      
      private var debugMode:Boolean;
      
      private var _level:Level;
      
      private var water:Water;
      
      private var _waterGraphics:WaterGraphics;
      
      private var _joints:Vector.<Constraint>;
      
      private var _removableJoints:Vector.<Constraint>;
      
      private var _normalBG:Image;
      
      private var _fullscreenBG:Image;
      
      public function PhysicsWorld(param1:TuxWorld)
      {
         this.debug = new ShapeDebug(DCGame.getStage().stageWidth,DCGame.getStage().stageHeight,DCGame.getStage().color);
         super();
         this.world = param1;
      }
      
      public function initContactListeners() : void
      {
         this.space.listeners.add(new PreListener(InteractionType.ANY,CbType.ANY_BODY,CbType.ANY_BODY,this.collisionPreListener));
         this.space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.ANY,CbType.ANY_BODY,CbType.ANY_BODY,this.beginContactHandler));
         this.space.listeners.add(new InteractionListener(CbEvent.END,InteractionType.ANY,CbType.ANY_BODY,CbType.ANY_BODY,this.endContactHandler));
      }
      
      public function get space() : Space
      {
         return this._space;
      }
      
      public function loadLevel(param1:Level) : void
      {
         this._level = param1;
         this.load();
      }
      
      public function dispose() : void
      {
         this._space.listeners.clear();
         this._space.clear();
         this._space = null;
         this._normalBG.dispose();
         this._normalBG = null;
         this._fullscreenBG.dispose();
         this._fullscreenBG = null;
         this._level.dispose();
         this._level = null;
         this.water.dispose();
         this.water = null;
         this._waterGraphics.dispose();
         this._waterGraphics = null;
         if(this._joints)
         {
            this._joints.splice(0,this._joints.length);
         }
         if(this._removableJoints)
         {
            this._removableJoints.splice(0,this._removableJoints.length);
         }
         this._powerUpSpawnRandom = null;
         this.world = null;
      }
      
      public function get level() : Level
      {
         return this._level;
      }
      
      public function getStartLocations() : Vector.<Vec2>
      {
         return this.startLocations;
      }
      
      public function get waterGraphics() : WaterGraphics
      {
         return this._waterGraphics;
      }
      
      public function fullscreenChanged(param1:Boolean) : void
      {
         var _loc2_:TuxWorld = this.world;
         (Starling.current.root as WorldContainer).backgroundContainer.removeChildren();
         var _loc3_:TuxWorld = this.world;
         (Starling.current.root as WorldContainer).backgroundContainer.addChild(param1 ? this._fullscreenBG : this._normalBG);
      }
      
      public function setDebugMode(param1:Boolean) : void
      {
         var _loc2_:TuxWorld = null;
         var _loc3_:TuxWorld = null;
         if(this.debugMode != param1)
         {
            this.debugMode = param1;
            if(this.debugMode)
            {
               this.debug.drawFluidArbiters = true;
               this.debug.drawConstraints = true;
               this.debug.drawSensorArbiters = true;
               this.debug.drawCollisionArbiters = true;
               _loc2_ = this.world;
               _loc2_._objectContainer.addChild(this.debug.display);
            }
            else
            {
               _loc3_ = this.world;
               _loc3_._objectContainer.removeChild(this.debug.display);
            }
         }
      }
      
      private function drawDebug() : void
      {
         this.debug.clear();
         this.debug.draw(this._space);
         this.debug.flush();
      }
      
      public function toggleDebugMode() : void
      {
         this.setDebugMode(!this.debugMode);
      }
      
      public function addDisplayObject(param1:starling.display.DisplayObject, param2:int = -1) : void
      {
         this.world.addDisplayObject(param1,param2);
      }
      
      public function removeDisplayObject(param1:starling.display.DisplayObject) : void
      {
         this.world.removeDisplayObject(param1);
      }
      
      public function createGameObject(param1:PhysicsGameObjectDef, param2:Boolean = true) : *
      {
         var _loc4_:* = undefined;
         var _loc3_:PhysicsGameObject = this.world.createGameObject(param1);
         if(param2)
         {
            _loc4_ = _loc3_;
            this.addDisplayObject(_loc4_.displayObject);
         }
         return _loc3_;
      }
      
      public function getRandomPowerUp() : String
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:LevelPowerUp = null;
         var _loc5_:int = int(this.powerUpSpawnRandom.integer(0,100));
         LogUtils.log("Random powerup creation chance: " + _loc5_ + " < " + this._level.powerUpPercentage,"PhysicsWorld",1,"PowerUps",false,false,false);
         if(_loc5_ < this._level.powerUpPercentage)
         {
            _loc1_ = LevelPowerUp.getAllPowerUpNames();
            LogUtils.log("Creating random powerup. Number of possible powerups: " + _loc1_.length,"PhysicsWorld",1,"PowerUps",false,false,false);
            while(_loc1_.length > 0)
            {
               _loc2_ = int(this.powerUpSpawnRandom.integer(0,_loc1_.length));
               _loc3_ = {};
               _loc3_.export_name = _loc1_[_loc2_];
               _loc3_.appear_percentage = 100;
               _loc3_.angle = 0;
               _loc3_.id = 0;
               _loc3_.x = 0;
               _loc3_.y = 0;
               _loc4_ = new LevelPowerUp(_loc3_);
               if(this.isSuitablePowerUp(_loc4_))
               {
                  LogUtils.log("Adding upcoming powerup: " + _loc4_.id,"PhysicsWorld",1,"PowerUps",true,false,true);
                  return _loc4_.id;
               }
               LogUtils.log("PowerUp isn\'t suitable for this level: " + _loc4_.id,"PhysicsWorld",1,"PowerUps",true,false,true);
               _loc1_.splice(_loc2_,1);
            }
         }
         return null;
      }
      
      public function get stepCount() : int
      {
         return this.space.timeStamp;
      }
      
      public function updatePhysicsWorld(param1:int) : void
      {
         var _loc2_:int = param1 / 22.22222222222222;
         var _loc3_:int = _loc2_ * 22.22222222222222;
         LogUtils.log("Updating physics world. stepCount = " + this.stepCount + " num: " + _loc2_ + " actualTime: " + _loc3_,this,1,"PhysicsWorld",false,false,false);
         this.updatePhysicsGameObjects(_loc3_);
         LogUtils.log("Updating PhysicsUpdater.",this,1,"PhysicsWorld",false,false,false);
         PhysicsUpdater.physicsUpdate(_loc3_);
         this.updateSimulation(_loc2_);
         if(this.debugMode)
         {
            this.drawDebug();
         }
         var _loc4_:TuxWorld = this.world;
         var _loc5_:TuxWorld = this.world;
         _loc4_._objectContainer.setChildIndex(this._waterGraphics,_loc5_._objectContainer.numChildren - 1);
      }
      
      public function updateSimulation(param1:int) : void
      {
         var _loc2_:int = 0;
         LogUtils.log("Updating simulation num times: " + param1 + " stepTime: " + this.stepCount,this,1,"PhysicsWorld",false,false,false);
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            this.checkJoints();
            this._space.step(0.022222222222222223,30,20);
            this.water.physicsUpdate();
            this.roundPlayers();
            this.slowDownLevelObjects();
            this.logLevelData(false);
            _loc2_++;
         }
      }
      
      private function slowDownLevelObjects() : void
      {
         var _loc1_:int = 0;
         var _loc2_:LevelGameObject = null;
         var _loc3_:TuxWorld = this.world;
         var _loc4_:Vector.<GameObject> = _loc3_._gameObjects.gameObjects;
         var _loc5_:int = int(_loc4_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc2_ = _loc4_[_loc1_] as LevelGameObject;
            if(_loc2_)
            {
               if(_loc2_.body)
               {
                  this.slowDownBody(_loc2_.body);
               }
            }
            _loc1_++;
         }
      }
      
      private function roundPlayers() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.world.players)
         {
            if(_loc1_.body)
            {
               this.slowDownBody(_loc1_.body);
               _loc1_.body.position = MathUtils.roundV2(_loc1_.body.position,2);
            }
         }
      }
      
      private function checkJoints() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Constraint = null;
         var _loc3_:Body = null;
         var _loc4_:Body = null;
         var _loc5_:ConstraintList = this.space.constraints;
         _loc1_ = 0;
         while(_loc1_ < _loc5_.length)
         {
            _loc2_ = _loc5_.at(_loc1_);
            if(_loc2_.active)
            {
               if(_loc2_ is PivotJoint)
               {
                  _loc3_ = PivotJoint(_loc2_).body1;
                  _loc4_ = PivotJoint(_loc2_).body2;
                  if(_loc3_.space == null || _loc4_.space == null || _loc3_.space != _loc4_.space)
                  {
                     _loc2_.active = false;
                  }
               }
            }
            _loc1_++;
         }
      }
      
      public function createPowerUp(param1:String) : void
      {
         var _loc2_:Object = {};
         _loc2_.export_name = param1;
         _loc2_.appear_percentage = 100;
         _loc2_.angle = 0;
         _loc2_.id = 0;
         _loc2_.x = 0;
         _loc2_.y = 0;
         var _loc3_:LevelPowerUp = new LevelPowerUp(_loc2_);
         this.createLevelPowerUp(_loc3_);
         _loc3_.dispose();
      }
      
      public function reCreateJoint(param1:String) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.level.joints)
         {
            if(_loc2_.id == param1)
            {
               this.createJoint(_loc2_);
               break;
            }
         }
      }
      
      public function removeJoint(param1:Constraint) : void
      {
         this._removableJoints.push(param1);
      }
      
      private function createLevelPowerUp(param1:LevelPowerUp) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc2_:PhysicsGameObjectDef = null;
         var _loc3_:PowerUpGameObject = null;
         var _loc4_:ParticleReference = null;
         LogUtils.log("Creating powerup: " + param1.id,"PhysicsWorld",1,"PowerUps");
         var _loc5_:Vec2 = this.getLocationForPowerUp(param1);
         if(_loc5_)
         {
            LogUtils.log("PowerUp location: " + _loc5_,"PhysicsWorld",1,"PowerUps");
            param1.setLocation(_loc5_);
            _loc2_ = new (param1.getGameObjectDefClass())(this.space,param1);
            _loc3_ = this.createGameObject(_loc2_) as PowerUpGameObject;
            _loc6_ = _loc3_;
            _loc7_ = _loc3_;
            _loc6_.displayObject.x = param1.getLocation().x - _loc7_.displayObject.width;
            _loc8_ = _loc3_;
            _loc8_.displayObject.y = param1.getLocation().y;
            _loc2_.dispose();
            _loc3_.body.velocity = Vec2.weak(0,0.1);
            _loc4_ = Particles.getParticlesReference(param1.getPowerUpObjectPhysics().getSpawnEffect());
            if(_loc4_)
            {
               this.world.addParticle(_loc4_,_loc5_.x,_loc5_.y);
            }
         }
      }
      
      private function isSuitablePowerUp(param1:LevelPowerUp) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<String> = param1.getPowerUpObjectPhysics().getOnlyInThemes();
         if(_loc2_)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_ == this._level.theme.getName())
               {
                  return true;
               }
            }
            return false;
         }
         return true;
      }
      
      private function updatePhysicsGameObjects(param1:int) : void
      {
         var _loc9_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:PhysicsGameObject = null;
         var _loc4_:int = 0;
         LogUtils.log("Updating physics game objects.","PhysicsWorld",1,"GameObjects",false,false,false);
         var _loc5_:TuxWorld = this.world;
         var _loc6_:GameObjects = _loc5_._gameObjects;
         var _loc7_:Vector.<GameObject> = _loc6_.gameObjects;
         var _loc8_:int = int(_loc7_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc8_)
         {
            _loc3_ = _loc7_[_loc2_] as PhysicsGameObject;
            if(_loc3_)
            {
               _loc3_.physicsUpdate(param1);
            }
            _loc2_++;
         }
         _loc6_.removeMarkedGameObjects();
         if(this._removableJoints)
         {
            for each(_loc9_ in this._removableJoints)
            {
               _loc4_ = 0;
               while(_loc4_ < this._joints.length)
               {
                  if(this._joints[_loc4_] == _loc9_)
                  {
                     this._joints.splice(_loc4_,1);
                     break;
                  }
                  _loc4_++;
               }
            }
            this._removableJoints.splice(0,this._removableJoints.length);
         }
      }
      
      private function slowDownBody(param1:Body) : void
      {
         if(Math.abs(param1.velocity.x) < 1e-7)
         {
            param1.velocity.x = 0;
         }
         if(Math.abs(param1.velocity.y) < 1e-7)
         {
            param1.velocity.y = 0;
         }
      }
      
      private function load() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         this.setBackground(this.level);
         for each(_loc1_ in this.level.elements)
         {
            this.createElement(_loc1_);
         }
         for each(_loc2_ in this.level.joints)
         {
            this.createJoint(_loc2_);
         }
         for each(_loc3_ in this.level.powerUps)
         {
            if(this.tryToCreate(_loc3_,this.level))
            {
               this.createLevelPowerUp(_loc3_);
               MessageCenter.sendMessage("PowerUpObjectCreated",_loc3_);
            }
         }
         this.startLocations = this.level.spawnPoints;
         this.createWater(this.level.waterLine,this.level.waterDensity,this.level.waterLinearDrag,this.level.wateAngularDrag,this.level.waterVelocity,this.level.theme.followers);
      }
      
      private function tryToCreate(param1:LevelPowerUp, param2:Level) : Boolean
      {
         var _loc5_:* = undefined;
         var _loc3_:Boolean = false;
         var _loc4_:Vector.<String> = param1.getPowerUpObjectPhysics().getOnlyInThemes();
         if(_loc4_)
         {
            _loc3_ = false;
            for each(_loc5_ in _loc4_)
            {
               if(param2.theme.getName() == _loc5_)
               {
                  _loc3_ = true;
                  break;
               }
            }
            if(!_loc3_)
            {
               return false;
            }
         }
         return this.powerUpSpawnRandom.integer(0,100) < param1.appearPercentage;
      }
      
      private function createWater(param1:int, param2:Number, param3:Number, param4:Number, param5:Point, param6:Vector.<FollowerData>) : void
      {
         this.water = new Water(this,param2,param3,param4,param5,param6);
         this._waterGraphics = new WaterGraphics(this._level);
         this._waterGraphics.y = param1;
         var _loc7_:TuxWorld = this.world;
         _loc7_._objectContainer.addChild(this._waterGraphics);
      }
      
      private function createElement(param1:Element) : void
      {
         var _loc2_:PhysicsGameObjectDef = new (param1.getGameObjectDefClass())(this.space,param1);
         var _loc3_:PhysicsGameObject = this.createGameObject(_loc2_);
         var _loc4_:* = _loc3_;
         _loc4_.displayObject.x = param1.getLocation().x;
         var _loc5_:* = _loc3_;
         _loc5_.displayObject.y = param1.getLocation().y;
         _loc2_.dispose();
      }
      
      private function createJoint(param1:Joint) : void
      {
         var _loc2_:TuxWorld = this.world;
         var _loc3_:PhysicsGameObject = _loc2_._gameObjects.findGameObjectById(param1.elementA.id) as PhysicsGameObject;
         var _loc4_:TuxWorld = this.world;
         var _loc5_:PhysicsGameObject = _loc4_._gameObjects.findGameObjectById(param1.elementB.id) as PhysicsGameObject;
         if(!this._joints)
         {
            this._joints = new Vector.<Constraint>();
            this._removableJoints = new Vector.<Constraint>();
         }
         if(!SimpleScriptManager.instance)
         {
            new SimpleScriptManager();
         }
         var _loc6_:Constraint = SimpleScriptManager.instance.runWithName(false,"AddJoint",[_loc3_,_loc5_],new SimpleScriptParams(null,null,null,param1));
         _loc6_.space = this.space;
         this._joints.push(_loc6_);
      }
      
      private function getLocationForPowerUp(param1:LevelPowerUp) : Vec2
      {
         var _loc2_:flash.geom.Rectangle = null;
         var _loc3_:SpawnPointFinder = null;
         if(Config.ZERO_POINT.equals(param1.getLocation().toPoint()))
         {
            _loc2_ = new Rectangle(0,0,50,50);
            _loc3_ = new SpawnPointFinder(this.world);
            return _loc3_.findSpawnLocation(50);
         }
         return param1.getLocation();
      }
      
      private function setBackground(param1:Level) : void
      {
         var _loc2_:Bitmap = this.createParallaxes(param1.theme.getBackground());
         this._normalBG = this.createBGImage(_loc2_,DCGame.getStage().stageHeight / _loc2_.height);
         this._fullscreenBG = this.createBGImage(_loc2_,DCGame.getStage().fullScreenHeight / _loc2_.height);
         var _loc3_:TuxWorld = this.world;
         (Starling.current.root as WorldContainer).backgroundContainer.addChild(this._normalBG);
         _loc2_.bitmapData.dispose();
      }
      
      private function createBGImage(param1:Bitmap, param2:Number) : Image
      {
         var _loc3_:Matrix = new Matrix();
         _loc3_.scale(param2,param2);
         var _loc4_:BitmapData = new BitmapData(param1.width < 2048 ? int(param1.width) : 2048,param1.height < 2048 ? int(param1.height) : 2048);
         _loc4_.draw(param1,_loc3_,null,null,null,true);
         var _loc5_:Image = new Image(Texture.fromBitmapData(_loc4_));
         _loc4_.dispose();
         return _loc5_;
      }
      
      private function createParallaxes(param1:flash.display.MovieClip) : Bitmap
      {
         var _loc2_:int = 0;
         var _loc3_:ParallaxLayer = null;
         var _loc4_:BitmapData = new BitmapData(this.level.width,this.level.height);
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(this.level.width / param1.width,this.level.height / param1.height);
         _loc4_.draw(param1,_loc5_);
         if(this.level.parallaxData)
         {
            this.level.parseParallaxes();
            _loc2_ = int(this.level.parallaxLayers.length - 1);
            while(_loc2_ >= 0)
            {
               _loc3_ = this.level.parallaxLayers[_loc2_];
               if(_loc3_.layerClip)
               {
                  _loc5_.identity();
                  _loc5_.translate(_loc3_.layerClip.x,_loc3_.layerClip.y);
                  _loc4_.draw(_loc3_.layerClip,_loc5_);
               }
               _loc2_--;
            }
            this.level.disposeParallaxLayers();
         }
         return new Bitmap(_loc4_,"auto",true);
      }
      
      private function get powerUpSpawnRandom() : Random
      {
         if(!this._powerUpSpawnRandom)
         {
            this._powerUpSpawnRandom = new Random(BattleManager._seed,"PowerUp Spawn Random",Config.debugMode);
         }
         return this._powerUpSpawnRandom;
      }
      
      private function collisionPreListener(param1:PreCallback) : PreFlag
      {
         var _loc2_:Body = param1.int1.castBody;
         var _loc3_:Body = param1.int2.castBody;
         var _loc4_:Collider = _loc2_.userData.gameObject;
         var _loc5_:Collider = _loc3_.userData.gameObject;
         return !!this.isAllowedContact(_loc4_,_loc5_) ? PreFlag.ACCEPT_ONCE : PreFlag.IGNORE;
      }
      
      private function endContactHandler(param1:InteractionCallback) : void
      {
         var _loc2_:Water = null;
         var _loc3_:Body = param1.int1.castBody;
         var _loc4_:Body = param1.int2.castBody;
         var _loc5_:Collider = _loc3_.userData.gameObject;
         var _loc6_:Collider = _loc4_.userData.gameObject;
         if(this.isAllowedContact(_loc5_,_loc6_))
         {
            if(_loc5_ is Water || _loc6_ is Water)
            {
               _loc2_ = _loc5_ is Water ? Water(_loc5_) : Water(_loc6_);
               _loc2_.handleEndContact(_loc5_ is Water ? _loc4_ : _loc3_,param1.arbiters);
            }
            else
            {
               _loc5_.handleEndContact(_loc4_,param1.arbiters);
               _loc6_.handleEndContact(_loc3_,param1.arbiters);
            }
         }
      }
      
      private function ongoingContactHandler(param1:InteractionCallback) : void
      {
         var _loc2_:Water = null;
         var _loc3_:Body = param1.int1.castBody;
         var _loc4_:Body = param1.int2.castBody;
         var _loc5_:Collider = _loc3_.userData.gameObject;
         var _loc6_:Collider = _loc4_.userData.gameObject;
         if(this.isAllowedContact(_loc5_,_loc6_))
         {
            if(_loc5_ is Water || _loc6_ is Water)
            {
               _loc2_ = _loc5_ is Water ? Water(_loc5_) : Water(_loc6_);
               _loc2_.handleOngoingContact(_loc5_ is Water ? _loc4_ : _loc3_,param1.arbiters);
            }
            else
            {
               _loc5_.handleOngoingContact(_loc4_,param1.arbiters);
               _loc6_.handleOngoingContact(_loc3_,param1.arbiters);
            }
         }
      }
      
      private function beginContactHandler(param1:InteractionCallback) : void
      {
         var _loc2_:Water = null;
         var _loc3_:Body = param1.int1.castBody;
         var _loc4_:Body = param1.int2.castBody;
         var _loc5_:Collider = _loc3_.userData.gameObject;
         var _loc6_:Collider = _loc4_.userData.gameObject;
         if(this.isAllowedContact(_loc5_,_loc6_))
         {
            if(_loc5_ is Water || _loc6_ is Water)
            {
               _loc2_ = _loc5_ is Water ? Water(_loc5_) : Water(_loc6_);
               _loc2_.handleBeginContact(_loc5_ is Water ? _loc4_ : _loc3_,param1.arbiters);
            }
            else
            {
               _loc5_.handleBeginContact(_loc4_,param1.arbiters);
               _loc6_.handleBeginContact(_loc3_,param1.arbiters);
            }
         }
      }
      
      private function isAllowedContact(param1:Collider, param2:Collider) : Boolean
      {
         var _loc3_:PhysicsEmissionGameObject = null;
         var _loc4_:PhysicsEmissionGameObject = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param1 is PowerUpGameObject || param2 is PowerUpGameObject || param1 is Follower || param2 is Follower)
         {
            return true;
         }
         if(param1 is PhysicsEmissionGameObject)
         {
            _loc3_ = PhysicsEmissionGameObject(param1);
            if(_loc3_.firingPlayerId == param2.id || param2 is PhysicsEmissionGameObject)
            {
               return false;
            }
         }
         if(param2 is PhysicsEmissionGameObject)
         {
            _loc4_ = PhysicsEmissionGameObject(param2);
            if(_loc4_.firingPlayerId == param1.id || param1 is PhysicsEmissionGameObject)
            {
               return false;
            }
         }
         return true;
      }
      
      public function logLevelData(param1:Boolean = true, param2:Boolean = true) : void
      {
         var _loc7_:TuxWorld = null;
         var _loc8_:TuxWorld = null;
         var _loc9_:TuxWorld = null;
         var _loc10_:TuxWorld = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(Config.debugMode)
         {
            LogUtils.log("",this,1,"PhysicsWorld",false,false,false);
            LogUtils.log("Level Object Physics Data, step: " + this.stepCount,this,1,"PhysicsWorld",false,false,false);
            _loc7_ = this.world;
            _loc3_ = _loc7_._gameObjects.findGameObjectsbyClass(PlayerGameObject);
            LogUtils.log("Player Game Objects:",this,1,"PhysicsWorld",false,false,false);
            this.logGameObjectsData(_loc3_,param1);
            _loc8_ = this.world;
            _loc4_ = _loc8_._gameObjects.findGameObjectsbyClass(LevelGameObject);
            LogUtils.log("Level Game Objects:",this,1,"PhysicsWorld",false,false,false);
            this.logGameObjectsData(_loc4_,param1);
            _loc9_ = this.world;
            _loc5_ = _loc9_._gameObjects.findGameObjectsbyClass(PhysicsEmissionGameObject);
            LogUtils.log("Emissio Game Objects:",this,1,"PhysicsWorld",false,false,false);
            this.logGameObjectsData(_loc5_,param1);
            if(param2)
            {
               _loc10_ = this.world;
               _loc6_ = _loc10_._gameObjects.findGameObjectsbyClass(TerrainGameObject);
               LogUtils.log("Terrain Game Objects:",this,1,"PhysicsWorld",false,false,false);
               this.logGameObjectsData(_loc6_);
            }
         }
      }
      
      private function logGameObjectsData(param1:Vector.<GameObject>, param2:Boolean = true) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1)
         {
            this.logGameObjectData(_loc3_,param2);
         }
      }
      
      private function logGameObjectData(param1:GameObject, param2:Boolean = true) : void
      {
         var _loc14_:* = undefined;
         var _loc3_:TerrainGameObject = null;
         var _loc4_:int = 0;
         var _loc5_:Polygon = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Vec2 = null;
         var _loc9_:int = 0;
         var _loc10_:nape.shape.Shape = null;
         var _loc11_:Material = null;
         var _loc12_:PhysicsGameObject = PhysicsGameObject(param1);
         var _loc13_:Body = _loc12_.body;
         if(param1 is TerrainGameObject)
         {
            _loc3_ = TerrainGameObject(param1);
            if(!_loc3_.logged)
            {
               LogUtils.log(_loc3_.shortName + ": pos: " + _loc3_.bodyLocation + ", num bodies: " + _loc3_.numBodies,this,1,"PhysicsWorld",false,false,false);
               for each(_loc14_ in _loc3_.bodies)
               {
                  if(_loc14_)
                  {
                     _loc4_ = 0;
                     while(_loc4_ < _loc14_.shapes.length)
                     {
                        _loc5_ = _loc14_.shapes.at(_loc4_).castPolygon;
                        _loc6_ = "";
                        _loc7_ = 0;
                        while(_loc7_ < _loc5_.worldVerts.length)
                        {
                           _loc8_ = _loc5_.worldVerts.at(_loc7_);
                           _loc6_ += _loc8_.toString() + ", ";
                           _loc7_++;
                        }
                        LogUtils.log("\t" + _loc6_,this,1,"PhysicsWorld",false,false,false);
                        _loc4_++;
                     }
                  }
               }
               _loc3_.logged = true;
            }
         }
         else if(_loc13_)
         {
            LogUtils.log(param1.shortName + ": pos: " + _loc13_.position + ", rot: " + _loc13_.rotation + ", vel: " + _loc13_.velocity + " mass: " + _loc13_.mass,this,1,"PhysicsWorld",false,false,false);
            if(param2)
            {
               LogUtils.log("\t Shapes:",this,1,"PhysicsWorld",false,false,false);
               _loc9_ = 0;
               while(_loc9_ < _loc13_.shapes.length)
               {
                  _loc10_ = _loc13_.shapes.at(_loc9_);
                  LogUtils.log("\t type: " + _loc10_.type + ", area: " + _loc10_.area + ", fluid: " + _loc10_.fluidEnabled + ", sensor: " + _loc10_.sensorEnabled + ", world COM: " + _loc10_.worldCOM,this,1,"PhysicsWorld",false,false,false);
                  _loc11_ = _loc10_.material;
                  LogUtils.log("\t density: " + _loc11_.density + ", dyn friction: " + _loc11_.dynamicFriction + ", elasticity: " + _loc11_.elasticity,this,1,"PhysicsWorld",false,false,false);
                  _loc9_++;
               }
            }
         }
      }
   }
}

