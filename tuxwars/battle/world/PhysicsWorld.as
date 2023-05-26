package tuxwars.battle.world
{
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.gameobjects.GameObjects;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import com.dchoc.utils.Random;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import nape.callbacks.CbEvent;
   import nape.callbacks.CbType;
   import nape.callbacks.InteractionCallback;
   import nape.callbacks.InteractionListener;
   import nape.callbacks.InteractionType;
   import nape.callbacks.PreCallback;
   import nape.callbacks.PreFlag;
   import nape.callbacks.PreListener;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintList;
   import nape.constraint.PivotJoint;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.Material;
   import nape.shape.Polygon;
   import nape.shape.Shape;
   import nape.space.Space;
   import nape.util.Debug;
   import nape.util.ShapeDebug;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.textures.Texture;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.WorldPhysics;
   import tuxwars.battle.data.follower.FollowerData;
   import tuxwars.battle.data.parallaxes.ParallaxLayer;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.data.particles.Particles;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.LevelGameObject;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObjectDef;
   import tuxwars.battle.gameobjects.PowerUpGameObject;
   import tuxwars.battle.gameobjects.TerrainGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.battle.world.loader.Element;
   import tuxwars.battle.world.loader.Joint;
   import tuxwars.battle.world.loader.Level;
   import tuxwars.battle.world.loader.LevelPowerUp;
   
   public class PhysicsWorld
   {
      
      private static const VELOCITY_ITERATIONS:int = 30;
      
      private static const POSITION_ITERATIONS:int = 20;
      
      private static const TIME_STEP:Number = 0.022222222222222223;
      
      public static const SINGLE_TIME_STEP:Number = 22.22222222222222;
      
      public static const MAX_UPDATE_TIME:int = 667;
      
      private static const MAX_HEIGHT:int = 2048;
      
      private static const MAX_WIDTH:int = 2048;
       
      
      private var _space:Space;
      
      private var _powerUpSpawnRandom:Random;
      
      private var world:TuxWorld;
      
      private var startLocations:Vector.<Vec2>;
      
      private const debug:Debug = new ShapeDebug(com.dchoc.game.DCGame._stage.stageWidth,com.dchoc.game.DCGame._stage.stageHeight,com.dchoc.game.DCGame._stage.color);
      
      private var debugMode:Boolean;
      
      private var _level:Level;
      
      private var water:Water;
      
      private var _waterGraphics:WaterGraphics;
      
      private var _joints:Vector.<Constraint>;
      
      private var _removableJoints:Vector.<Constraint>;
      
      private var _normalBG:Image;
      
      private var _fullscreenBG:Image;
      
      public function PhysicsWorld(world:TuxWorld)
      {
         _space = new Space(Vec2.weak(0,WorldPhysics.getGravity()));
         var _loc2_:DCGame = DCGame;
         var _loc3_:DCGame = DCGame;
         var _loc4_:DCGame = DCGame;
         super();
         this.world = world;
      }
      
      public function initContactListeners() : void
      {
         space.listeners.add(new PreListener(InteractionType.ANY,CbType.ANY_BODY,CbType.ANY_BODY,collisionPreListener));
         space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.ANY,CbType.ANY_BODY,CbType.ANY_BODY,beginContactHandler));
         space.listeners.add(new InteractionListener(CbEvent.END,InteractionType.ANY,CbType.ANY_BODY,CbType.ANY_BODY,endContactHandler));
      }
      
      public function get space() : Space
      {
         return _space;
      }
      
      public function loadLevel(level:Level) : void
      {
         _level = level;
         load();
      }
      
      public function dispose() : void
      {
         _space.listeners.clear();
         _space.clear();
         _space = null;
         _normalBG.dispose();
         _normalBG = null;
         _fullscreenBG.dispose();
         _fullscreenBG = null;
         _level.dispose();
         _level = null;
         water.dispose();
         water = null;
         _waterGraphics.dispose();
         _waterGraphics = null;
         if(_joints)
         {
            _joints.splice(0,_joints.length);
         }
         if(_removableJoints)
         {
            _removableJoints.splice(0,_removableJoints.length);
         }
         _powerUpSpawnRandom = null;
         world = null;
      }
      
      public function get level() : Level
      {
         return _level;
      }
      
      public function getStartLocations() : Vector.<Vec2>
      {
         return startLocations;
      }
      
      public function get waterGraphics() : WaterGraphics
      {
         return _waterGraphics;
      }
      
      public function fullscreenChanged(fullscreen:Boolean) : void
      {
         var _loc2_:TuxWorld = world;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).backgroundContainer.removeChildren();
         var _loc3_:TuxWorld = world;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).backgroundContainer.addChild(fullscreen ? _fullscreenBG : _normalBG);
      }
      
      public function setDebugMode(value:Boolean) : void
      {
         if(debugMode != value)
         {
            debugMode = value;
            if(debugMode)
            {
               debug.drawFluidArbiters = true;
               debug.drawConstraints = true;
               debug.drawSensorArbiters = true;
               debug.drawCollisionArbiters = true;
               var _loc2_:TuxWorld = world;
               _loc2_._objectContainer.addChild(debug.display);
            }
            else
            {
               var _loc3_:TuxWorld = world;
               _loc3_._objectContainer.removeChild(debug.display);
            }
         }
      }
      
      private function drawDebug() : void
      {
         debug.clear();
         debug.draw(_space);
         debug.flush();
      }
      
      public function toggleDebugMode() : void
      {
         setDebugMode(!debugMode);
      }
      
      public function addDisplayObject(obj:DisplayObject, index:int = -1) : void
      {
         world.addDisplayObject(obj,index);
      }
      
      public function removeDisplayObject(child:DisplayObject) : void
      {
         world.removeDisplayObject(child);
      }
      
      public function createGameObject(def:PhysicsGameObjectDef, addMC:Boolean = true) : *
      {
         var _loc3_:PhysicsGameObject = world.createGameObject(def);
         if(addMC)
         {
            var _loc4_:* = _loc3_;
            addDisplayObject(_loc4_._displayObject);
         }
         return _loc3_;
      }
      
      public function getRandomPowerUp() : String
      {
         var _loc5_:* = undefined;
         var _loc1_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = powerUpSpawnRandom.integer(0,100);
         LogUtils.log("Random powerup creation chance: " + _loc4_ + " < " + _level.powerUpPercentage,"PhysicsWorld",1,"PowerUps",false,false,false);
         if(_loc4_ < _level.powerUpPercentage)
         {
            _loc5_ = LevelPowerUp.getAllPowerUpNames();
            LogUtils.log("Creating random powerup. Number of possible powerups: " + _loc5_.length,"PhysicsWorld",1,"PowerUps",false,false,false);
            while(_loc5_.length > 0)
            {
               _loc1_ = powerUpSpawnRandom.integer(0,_loc5_.length);
               _loc3_ = {};
               _loc3_.export_name = _loc5_[_loc1_];
               _loc3_.appear_percentage = 100;
               _loc3_.angle = 0;
               _loc3_.id = 0;
               _loc3_.x = 0;
               _loc3_.y = 0;
               _loc2_ = new LevelPowerUp(_loc3_);
               if(isSuitablePowerUp(_loc2_))
               {
                  LogUtils.log("Adding upcoming powerup: " + _loc2_.id,"PhysicsWorld",1,"PowerUps",true,false,true);
                  return _loc2_.id;
               }
               LogUtils.log("PowerUp isn\'t suitable for this level: " + _loc2_.id,"PhysicsWorld",1,"PowerUps",true,false,true);
               _loc5_.splice(_loc1_,1);
            }
         }
         return null;
      }
      
      public function get stepCount() : int
      {
         return space.timeStamp;
      }
      
      public function updatePhysicsWorld(updateTime:int) : void
      {
         var _loc2_:int = updateTime / 22.22222222222222;
         var _loc3_:int = _loc2_ * 22.22222222222222;
         LogUtils.log("Updating physics world. stepCount = " + stepCount + " num: " + _loc2_ + " actualTime: " + _loc3_,this,1,"PhysicsWorld",false,false,false);
         updatePhysicsGameObjects(_loc3_);
         LogUtils.log("Updating PhysicsUpdater.",this,1,"PhysicsWorld",false,false,false);
         PhysicsUpdater.physicsUpdate(_loc3_);
         updateSimulation(_loc2_);
         if(debugMode)
         {
            drawDebug();
         }
         var _loc4_:TuxWorld = world;
         var _loc5_:TuxWorld = world;
         _loc4_._objectContainer.setChildIndex(_waterGraphics,Number(_loc5_._objectContainer.numChildren) - 1);
      }
      
      public function updateSimulation(num:int) : void
      {
         var i:int = 0;
         LogUtils.log("Updating simulation num times: " + num + " stepTime: " + stepCount,this,1,"PhysicsWorld",false,false,false);
         for(i = 0; i < num; )
         {
            checkJoints();
            _space.step(0.022222222222222223,30,20);
            water.physicsUpdate();
            roundPlayers();
            slowDownLevelObjects();
            logLevelData(false);
            i++;
         }
      }
      
      private function slowDownLevelObjects() : void
      {
         var i:int = 0;
         var _loc3_:* = null;
         var _loc5_:TuxWorld = world;
         var _loc1_:Vector.<GameObject> = _loc5_._gameObjects.gameObjects;
         var _loc2_:int = _loc1_.length;
         for(i = 0; i < _loc2_; )
         {
            _loc3_ = _loc1_[i] as LevelGameObject;
            if(_loc3_)
            {
               if(_loc3_.body)
               {
                  slowDownBody(_loc3_.body);
               }
            }
            i++;
         }
      }
      
      private function roundPlayers() : void
      {
         for each(var player in world.players)
         {
            if(player.body)
            {
               slowDownBody(player.body);
               player.body.position = MathUtils.roundV2(player.body.position,2);
            }
         }
      }
      
      private function checkJoints() : void
      {
         var i:int = 0;
         var joint:* = null;
         var body1:* = null;
         var body2:* = null;
         var _loc3_:ConstraintList = space.constraints;
         for(i = 0; i < _loc3_.length; )
         {
            joint = _loc3_.at(i);
            if(joint.active)
            {
               if(joint is PivotJoint)
               {
                  body1 = PivotJoint(joint).body1;
                  body2 = PivotJoint(joint).body2;
                  if(body1.space == null || body2.space == null || body1.space != body2.space)
                  {
                     joint.active = false;
                  }
               }
            }
            i++;
         }
      }
      
      public function createPowerUp(id:String) : void
      {
         var _loc3_:Object = {};
         _loc3_.export_name = id;
         _loc3_.appear_percentage = 100;
         _loc3_.angle = 0;
         _loc3_.id = 0;
         _loc3_.x = 0;
         _loc3_.y = 0;
         var _loc2_:LevelPowerUp = new LevelPowerUp(_loc3_);
         createLevelPowerUp(_loc2_);
         _loc2_.dispose();
      }
      
      public function reCreateJoint(id:String) : void
      {
         for each(var j in level.joints)
         {
            if(j.id == id)
            {
               createJoint(j);
               break;
            }
         }
      }
      
      public function removeJoint(joint:Constraint) : void
      {
         _removableJoints.push(joint);
      }
      
      private function createLevelPowerUp(powerUp:LevelPowerUp) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         LogUtils.log("Creating powerup: " + powerUp.id,"PhysicsWorld",1,"PowerUps");
         var _loc3_:Vec2 = getLocationForPowerUp(powerUp);
         if(_loc3_)
         {
            LogUtils.log("PowerUp location: " + _loc3_,"PhysicsWorld",1,"PowerUps");
            powerUp.setLocation(_loc3_);
            _loc4_ = new (powerUp.getGameObjectDefClass())(space,powerUp);
            _loc5_ = createGameObject(_loc4_) as PowerUpGameObject;
            var _loc6_:* = _loc5_;
            var _loc7_:* = _loc5_;
            _loc6_._displayObject.x = powerUp.getLocation().x - Number(_loc7_._displayObject.width);
            var _loc8_:* = _loc5_;
            _loc8_._displayObject.y = powerUp.getLocation().y;
            _loc4_.dispose();
            _loc5_.body.velocity = Vec2.weak(0,0.1);
            _loc2_ = Particles.getParticlesReference(powerUp.getPowerUpObjectPhysics().getSpawnEffect());
            if(_loc2_)
            {
               world.addParticle(_loc2_,_loc3_.x,_loc3_.y);
            }
         }
      }
      
      private function isSuitablePowerUp(powerUp:LevelPowerUp) : Boolean
      {
         var _loc2_:Vector.<String> = powerUp.getPowerUpObjectPhysics().getOnlyInThemes();
         if(_loc2_)
         {
            for each(var t in _loc2_)
            {
               if(t == _level.theme.getName())
               {
                  return true;
               }
            }
            return false;
         }
         return true;
      }
      
      private function updatePhysicsGameObjects(time:int) : void
      {
         var i:int = 0;
         var _loc6_:* = null;
         var k:int = 0;
         LogUtils.log("Updating physics game objects.","PhysicsWorld",1,"GameObjects",false,false,false);
         var _loc9_:TuxWorld = world;
         var _loc7_:GameObjects = _loc9_._gameObjects;
         var _loc2_:Vector.<GameObject> = _loc7_.gameObjects;
         var _loc3_:int = _loc2_.length;
         for(i = 0; i < _loc3_; )
         {
            _loc6_ = _loc2_[i] as PhysicsGameObject;
            if(_loc6_)
            {
               _loc6_.physicsUpdate(time);
            }
            i++;
         }
         _loc7_.removeMarkedGameObjects();
         if(_removableJoints)
         {
            for each(var j in _removableJoints)
            {
               for(k = 0; k < _joints.length; )
               {
                  if(_joints[k] == j)
                  {
                     _joints.splice(k,1);
                     break;
                  }
                  k++;
               }
            }
            _removableJoints.splice(0,_removableJoints.length);
         }
      }
      
      private function slowDownBody(body:Body) : void
      {
         if(Math.abs(body.velocity.x) < 1e-7)
         {
            body.velocity.x = 0;
         }
         if(Math.abs(body.velocity.y) < 1e-7)
         {
            body.velocity.y = 0;
         }
      }
      
      private function load() : void
      {
         setBackground(level);
         for each(var element in level.elements)
         {
            createElement(element);
         }
         for each(var joint in level.joints)
         {
            createJoint(joint);
         }
         for each(var powerup in level.powerUps)
         {
            if(tryToCreate(powerup,level))
            {
               createLevelPowerUp(powerup);
               MessageCenter.sendMessage("PowerUpObjectCreated",powerup);
            }
         }
         startLocations = level.spawnPoints;
         createWater(level.waterLine,level.waterDensity,level.waterLinearDrag,level.wateAngularDrag,level.waterVelocity,level.theme.followers);
      }
      
      private function tryToCreate(powerUp:LevelPowerUp, level:Level) : Boolean
      {
         var allowedThemeFound:Boolean = false;
         var _loc5_:Vector.<String> = powerUp.getPowerUpObjectPhysics().getOnlyInThemes();
         if(_loc5_)
         {
            allowedThemeFound = false;
            for each(var t in _loc5_)
            {
               if(level.theme.getName() == t)
               {
                  allowedThemeFound = true;
                  break;
               }
            }
            if(!allowedThemeFound)
            {
               return false;
            }
         }
         return powerUpSpawnRandom.integer(0,100) < powerUp.appearPercentage;
      }
      
      private function createWater(waterLine:int, density:Number, linearDrag:Number, angularDrag:Number, velocity:Point, followersData:Vector.<FollowerData>) : void
      {
         water = new Water(this,density,linearDrag,angularDrag,velocity,followersData);
         _waterGraphics = new WaterGraphics(_level);
         _waterGraphics.y = waterLine;
         var _loc7_:TuxWorld = world;
         _loc7_._objectContainer.addChild(_waterGraphics);
      }
      
      private function createElement(element:Element) : void
      {
         var _loc2_:PhysicsGameObjectDef = new (element.getGameObjectDefClass())(space,element);
         var physicsGameObject:PhysicsGameObject = createGameObject(_loc2_);
         var _loc4_:* = physicsGameObject;
         _loc4_._displayObject.x = element.getLocation().x;
         var _loc5_:* = physicsGameObject;
         _loc5_._displayObject.y = element.getLocation().y;
         _loc2_.dispose();
      }
      
      private function createJoint(joint:Joint) : void
      {
         var _loc5_:TuxWorld = world;
         var _loc3_:PhysicsGameObject = _loc5_._gameObjects.findGameObjectById(joint.elementA.id) as PhysicsGameObject;
         var _loc6_:TuxWorld = world;
         var _loc2_:PhysicsGameObject = _loc6_._gameObjects.findGameObjectById(joint.elementB.id) as PhysicsGameObject;
         if(!_joints)
         {
            _joints = new Vector.<Constraint>();
            _removableJoints = new Vector.<Constraint>();
         }
         var _loc7_:SimpleScriptManager = SimpleScriptManager;
         if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
         {
            new tuxwars.battle.simplescript.SimpleScriptManager();
         }
         var j:Constraint = tuxwars.battle.simplescript.SimpleScriptManager._instance.runWithName(false,"AddJoint",[_loc3_,_loc2_],new SimpleScriptParams(null,null,null,joint));
         j.space = space;
         _joints.push(j);
      }
      
      private function getLocationForPowerUp(powerUp:LevelPowerUp) : Vec2
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(Config.ZERO_POINT.equals(powerUp.getLocation().toPoint()))
         {
            _loc2_ = new Rectangle(0,0,50,50);
            _loc3_ = new SpawnPointFinder(world);
            return _loc3_.findSpawnLocation(50);
         }
         return powerUp.getLocation();
      }
      
      private function setBackground(level:Level) : void
      {
         var _loc2_:Bitmap = createParallaxes(level.theme.getBackground());
         var _loc3_:DCGame = DCGame;
         _normalBG = createBGImage(_loc2_,Number(com.dchoc.game.DCGame._stage.stageHeight) / _loc2_.height);
         var _loc4_:DCGame = DCGame;
         _fullscreenBG = createBGImage(_loc2_,Number(com.dchoc.game.DCGame._stage.fullScreenHeight) / _loc2_.height);
         var _loc5_:TuxWorld = world;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).backgroundContainer.addChild(_normalBG);
         _loc2_.bitmapData.dispose();
      }
      
      private function createBGImage(bg:Bitmap, scale:Number) : Image
      {
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(scale,scale);
         var _loc3_:BitmapData = new BitmapData(bg.width < 2048 ? bg.width : 2048,bg.height < 2048 ? bg.height : 2048);
         _loc3_.draw(bg,_loc5_,null,null,null,true);
         var _loc4_:Image = new Image(Texture.fromBitmapData(_loc3_));
         _loc3_.dispose();
         return _loc4_;
      }
      
      private function createParallaxes(parent:MovieClip) : Bitmap
      {
         var i:int = 0;
         var _loc4_:* = null;
         var _loc2_:BitmapData = new BitmapData(level.width,level.height);
         var _loc3_:Matrix = new Matrix();
         _loc3_.scale(level.width / parent.width,level.height / parent.height);
         _loc2_.draw(parent,_loc3_);
         if(level.parallaxData)
         {
            level.parseParallaxes();
            for(i = level.parallaxLayers.length - 1; i >= 0; )
            {
               _loc4_ = level.parallaxLayers[i];
               if(_loc4_.layerClip)
               {
                  _loc3_.identity();
                  _loc3_.translate(_loc4_.layerClip.x,_loc4_.layerClip.y);
                  _loc2_.draw(_loc4_.layerClip,_loc3_);
               }
               i--;
            }
            level.disposeParallaxLayers();
         }
         return new Bitmap(_loc2_,"auto",true);
      }
      
      private function get powerUpSpawnRandom() : Random
      {
         if(!_powerUpSpawnRandom)
         {
            var _loc1_:BattleManager = BattleManager;
            _powerUpSpawnRandom = new Random(tuxwars.battle.BattleManager._seed,"PowerUp Spawn Random",Config.debugMode);
         }
         return _powerUpSpawnRandom;
      }
      
      private function collisionPreListener(event:PreCallback) : PreFlag
      {
         var _loc5_:Body = event.int1.castBody;
         var _loc2_:Body = event.int2.castBody;
         var _loc4_:Collider = _loc5_.userData.gameObject;
         var _loc3_:Collider = _loc2_.userData.gameObject;
         return isAllowedContact(_loc4_,_loc3_) ? PreFlag.ACCEPT_ONCE : PreFlag.IGNORE;
      }
      
      private function endContactHandler(event:InteractionCallback) : void
      {
         var _loc2_:* = null;
         var _loc6_:Body = event.int1.castBody;
         var _loc3_:Body = event.int2.castBody;
         var _loc5_:Collider = _loc6_.userData.gameObject;
         var _loc4_:Collider = _loc3_.userData.gameObject;
         if(isAllowedContact(_loc5_,_loc4_))
         {
            if(_loc5_ is Water || _loc4_ is Water)
            {
               _loc2_ = _loc5_ is Water ? Water(_loc5_) : Water(_loc4_);
               _loc2_.handleEndContact(_loc5_ is Water ? _loc3_ : _loc6_,event.arbiters);
            }
            else
            {
               _loc5_.handleEndContact(_loc3_,event.arbiters);
               _loc4_.handleEndContact(_loc6_,event.arbiters);
            }
         }
      }
      
      private function ongoingContactHandler(event:InteractionCallback) : void
      {
         var _loc2_:* = null;
         var _loc6_:Body = event.int1.castBody;
         var _loc3_:Body = event.int2.castBody;
         var _loc5_:Collider = _loc6_.userData.gameObject;
         var _loc4_:Collider = _loc3_.userData.gameObject;
         if(isAllowedContact(_loc5_,_loc4_))
         {
            if(_loc5_ is Water || _loc4_ is Water)
            {
               _loc2_ = _loc5_ is Water ? Water(_loc5_) : Water(_loc4_);
               _loc2_.handleOngoingContact(_loc5_ is Water ? _loc3_ : _loc6_,event.arbiters);
            }
            else
            {
               _loc5_.handleOngoingContact(_loc3_,event.arbiters);
               _loc4_.handleOngoingContact(_loc6_,event.arbiters);
            }
         }
      }
      
      private function beginContactHandler(event:InteractionCallback) : void
      {
         var _loc2_:* = null;
         var _loc6_:Body = event.int1.castBody;
         var _loc3_:Body = event.int2.castBody;
         var _loc5_:Collider = _loc6_.userData.gameObject;
         var _loc4_:Collider = _loc3_.userData.gameObject;
         if(isAllowedContact(_loc5_,_loc4_))
         {
            if(_loc5_ is Water || _loc4_ is Water)
            {
               _loc2_ = _loc5_ is Water ? Water(_loc5_) : Water(_loc4_);
               _loc2_.handleBeginContact(_loc5_ is Water ? _loc3_ : _loc6_,event.arbiters);
            }
            else
            {
               _loc5_.handleBeginContact(_loc3_,event.arbiters);
               _loc4_.handleBeginContact(_loc6_,event.arbiters);
            }
         }
      }
      
      private function isAllowedContact(collider1:Collider, collider2:Collider) : Boolean
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(collider1 == null || collider2 == null)
         {
            return false;
         }
         if(collider1 is PowerUpGameObject || collider2 is PowerUpGameObject || collider1 is Follower || collider2 is Follower)
         {
            return true;
         }
         if(collider1 is PhysicsEmissionGameObject)
         {
            _loc4_ = PhysicsEmissionGameObject(collider1);
            if(_loc4_.firingPlayerId == collider2.id || collider2 is PhysicsEmissionGameObject)
            {
               return false;
            }
         }
         if(collider2 is PhysicsEmissionGameObject)
         {
            _loc3_ = PhysicsEmissionGameObject(collider2);
            if(_loc3_.firingPlayerId == collider1.id || collider1 is PhysicsEmissionGameObject)
            {
               return false;
            }
         }
         return true;
      }
      
      public function logLevelData(logShapeData:Boolean = true, logTerrainData:Boolean = true) : void
      {
         var _loc6_:* = undefined;
         var _loc5_:* = undefined;
         var _loc4_:* = undefined;
         var _loc3_:* = undefined;
         if(Config.debugMode)
         {
            LogUtils.log("",this,1,"PhysicsWorld",false,false,false);
            LogUtils.log("Level Object Physics Data, step: " + stepCount,this,1,"PhysicsWorld",false,false,false);
            var _loc7_:TuxWorld = world;
            _loc6_ = _loc7_._gameObjects.findGameObjectsbyClass(PlayerGameObject);
            LogUtils.log("Player Game Objects:",this,1,"PhysicsWorld",false,false,false);
            logGameObjectsData(_loc6_,logShapeData);
            var _loc8_:TuxWorld = world;
            _loc5_ = _loc8_._gameObjects.findGameObjectsbyClass(LevelGameObject);
            LogUtils.log("Level Game Objects:",this,1,"PhysicsWorld",false,false,false);
            logGameObjectsData(_loc5_,logShapeData);
            var _loc9_:TuxWorld = world;
            _loc4_ = _loc9_._gameObjects.findGameObjectsbyClass(PhysicsEmissionGameObject);
            LogUtils.log("Emissio Game Objects:",this,1,"PhysicsWorld",false,false,false);
            logGameObjectsData(_loc4_,logShapeData);
            if(logTerrainData)
            {
               var _loc10_:TuxWorld = world;
               _loc3_ = _loc10_._gameObjects.findGameObjectsbyClass(TerrainGameObject);
               LogUtils.log("Terrain Game Objects:",this,1,"PhysicsWorld",false,false,false);
               logGameObjectsData(_loc3_);
            }
         }
      }
      
      private function logGameObjectsData(gameObjects:Vector.<GameObject>, logShapeData:Boolean = true) : void
      {
         for each(var gameObject in gameObjects)
         {
            logGameObjectData(gameObject,logShapeData);
         }
      }
      
      private function logGameObjectData(gameObject:GameObject, logShapeData:Boolean = true) : void
      {
         var _loc3_:* = null;
         var k:int = 0;
         var _loc12_:* = null;
         var vertList:* = null;
         var j:int = 0;
         var _loc14_:* = null;
         var i:int = 0;
         var _loc5_:* = null;
         var _loc9_:* = null;
         var _loc7_:PhysicsGameObject = PhysicsGameObject(gameObject);
         var _loc4_:Body = _loc7_.body;
         if(gameObject is TerrainGameObject)
         {
            _loc3_ = TerrainGameObject(gameObject);
            if(!_loc3_.logged)
            {
               LogUtils.log(_loc3_.shortName + ": pos: " + _loc3_.bodyLocation + ", num bodies: " + _loc3_.numBodies,this,1,"PhysicsWorld",false,false,false);
               for each(var terrainBody in _loc3_.bodies)
               {
                  if(terrainBody)
                  {
                     for(k = 0; k < terrainBody.shapes.length; )
                     {
                        _loc12_ = terrainBody.shapes.at(k).castPolygon;
                        vertList = "";
                        for(j = 0; j < _loc12_.worldVerts.length; )
                        {
                           _loc14_ = _loc12_.worldVerts.at(j);
                           vertList += _loc14_.toString() + ", ";
                           j++;
                        }
                        LogUtils.log("\t" + vertList,this,1,"PhysicsWorld",false,false,false);
                        k++;
                     }
                  }
               }
               _loc3_.logged = true;
            }
         }
         else if(_loc4_)
         {
            LogUtils.log(gameObject.shortName + ": pos: " + _loc4_.position + ", rot: " + _loc4_.rotation + ", vel: " + _loc4_.velocity + " mass: " + _loc4_.mass,this,1,"PhysicsWorld",false,false,false);
            if(logShapeData)
            {
               LogUtils.log("\t Shapes:",this,1,"PhysicsWorld",false,false,false);
               for(i = 0; i < _loc4_.shapes.length; )
               {
                  _loc5_ = _loc4_.shapes.at(i);
                  LogUtils.log("\t type: " + _loc5_.type + ", area: " + _loc5_.area + ", fluid: " + _loc5_.fluidEnabled + ", sensor: " + _loc5_.sensorEnabled + ", world COM: " + _loc5_.worldCOM,this,1,"PhysicsWorld",false,false,false);
                  _loc9_ = _loc5_.material;
                  LogUtils.log("\t density: " + _loc9_.density + ", dyn friction: " + _loc9_.dynamicFriction + ", elasticity: " + _loc9_.elasticity,this,1,"PhysicsWorld",false,false,false);
                  i++;
               }
            }
         }
      }
   }
}
