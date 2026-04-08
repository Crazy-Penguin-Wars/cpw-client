package tuxwars.battle.gameobjects
{
   import com.citrusengine.physics.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import earcutting.*;
   import flash.geom.Rectangle;
   import nape.dynamics.*;
   import nape.geom.*;
   import nape.phys.*;
   import nape.shape.*;
   import nape.space.Space;
   import starling.display.*;
   import starling.textures.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.particles.*;
   import tuxwars.battle.explosions.ExplosionShape;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.graphics.*;
   import tuxwars.battle.utils.*;
   import tuxwars.battle.world.loader.*;
   import tuxwars.data.*;
   import tuxwars.player.reports.events.*;
   
   public class TerrainGameObject extends PhysicsGameObject
   {
      private const _terrainModels:Vector.<TerrainModel> = new Vector.<TerrainModel>();
      
      private const _bodies:Vector.<Body> = new Vector.<Body>();
      
      private var terrainDisplayObject:TerrainDisplayObject;
      
      private var _material:String;
      
      private var _isDynamic:Boolean;
      
      private var width:int;
      
      private var height:int;
      
      private var _position:Vec2;
      
      private var _logged:Boolean;
      
      private var lastTotalArea:Number;
      
      private var _lastDestroyedArea:Number = 0;
      
      public function TerrainGameObject(param1:TerrainGameObjectDef, param2:TuxWarsGame)
      {
         this._position = param1.position.copy();
         this._terrainModels.push(param1.getTerrainModel());
         super(param1,param2);
         this.createNewBodies();
         this.terrainDisplayObject = new TerrainDisplayObject(param1.getTerrainDisplayObjectDef());
         graphicsLoaded = true;
         this._material = param1.getTheme().getName();
         var _loc3_:Texture = Texture.fromBitmapData(this.terrainDisplayObject.terrainBitmap.bitmapData);
         var _loc4_:Image = new Image(_loc3_);
         _loc4_.x -= 25;
         _loc4_.y -= 25;
         this.displayObject.addChild(_loc4_);
         setCanTakeDamage(param1.canTakeDamage());
         this.lastTotalArea = this.calculateTotalArea();
      }
      
      public function get logged() : Boolean
      {
         return this._logged;
      }
      
      public function set logged(param1:Boolean) : void
      {
         this._logged = param1;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         this.terrainDisplayObject.dispose();
         this.terrainDisplayObject = null;
         for each(_loc1_ in this._bodies)
         {
            if(_loc1_)
            {
               _loc1_.space = null;
               _loc1_.shapes.clear();
            }
         }
         this._bodies.splice(0,this._bodies.length);
         super.dispose();
      }
      
      public function get bodies() : Vector.<Body>
      {
         return this._bodies;
      }
      
      override public function get bodyLocation() : Vec2
      {
         return this._position;
      }
      
      public function getBodyAt(param1:int, param2:int) : Body
      {
         var _loc5_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:Vec2 = Vec2.get(param1,param2);
         for each(_loc5_ in this._bodies)
         {
            if(_loc5_ != null && _loc5_.space != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc5_.shapes.length)
               {
                  if(_loc5_.shapes.at(_loc3_).contains(_loc4_))
                  {
                     return _loc5_;
                  }
                  _loc3_++;
               }
            }
         }
         return null;
      }
      
      public function get numBodies() : int
      {
         return this._bodies.length;
      }
      
      override public function get linearVelocity() : Vec2
      {
         return Vec2.get();
      }
      
      override public function handleExplosionTerrain(param1:Vec2, param2:ExplosionShape) : void
      {
         var _loc7_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:Image = null;
         if(!canTakeDamage())
         {
            return;
         }
         var _loc5_:Vec2 = param1.sub(new Vec2(this.displayObject.x,this.displayObject.y));
         var _loc6_:Vector.<Vec2> = GeomUtils.duplicatePolygon(param2.getPoints());
         GeomUtils.translatePolygon(_loc6_,_loc5_);
         for each(_loc7_ in this._terrainModels)
         {
            _loc7_.applyExplosion(GeomUtils.toPointVector(_loc6_));
         }
         this.removeDestroyedModels();
         this.removeBodies();
         this.createNewModels();
         if(this._terrainModels.length == 0)
         {
            markForRemoval();
            return;
         }
         this.createNewBodies();
         this.terrainDisplayObject.drawExplosion(_loc6_,this._terrainModels);
         _loc3_ = 0;
         while(_loc3_ < this.displayObject.numChildren)
         {
            _loc4_ = this.displayObject.getChildAt(_loc3_) as Image;
            _loc4_.texture.dispose();
            _loc4_.texture.base.dispose();
            _loc3_++;
         }
         this.displayObject.removeChildren(0,-1,true);
         var _loc8_:Texture = Texture.fromBitmapData(this.terrainDisplayObject.terrainBitmap.bitmapData);
         var _loc9_:Image = new Image(_loc8_);
         _loc9_.x -= 25;
         _loc9_.y -= 25;
         this.displayObject.addChild(_loc9_);
         MessageCenter.sendEvent(new ReportTerrainDestroyedMessage(this));
         (this.game as TuxWarsGame).tuxWorld.addParticle(Particles.getParticlesReference("MissileExplosion" + this._material),param1.x,param1.y);
         if(this._bodies.length == 0)
         {
            markForRemoval();
         }
         this._logged = false;
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         if(param1 == "terrain" || param1 == this._material)
         {
            return true;
         }
         return super.affectsGameObject(param1,param2);
      }
      
      override protected function updateGraphics() : void
      {
         if(this.isDynamic())
         {
            super.updateGraphics();
         }
      }
      
      public function calculateTotalArea() : Number
      {
         var _loc4_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = 0;
         for each(_loc4_ in this._bodies)
         {
            _loc1_ = int(_loc4_.shapes.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ += _loc4_.shapes.at(_loc2_).area;
               _loc2_++;
            }
         }
         return _loc3_;
      }
      
      public function generateAABB() : AABB
      {
         var _loc1_:flash.geom.Rectangle = null;
         var _loc2_:int = 0;
         var _loc3_:Body = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Shape = null;
         var _loc7_:flash.geom.Rectangle = null;
         _loc2_ = 0;
         while(_loc2_ < this._bodies.length)
         {
            _loc3_ = this._bodies[_loc2_];
            _loc4_ = _loc3_.shapes.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc3_.shapes.at(_loc5_);
               _loc7_ = _loc6_.bounds.toRect();
               if(_loc1_)
               {
                  _loc1_ = _loc1_.union(_loc7_);
               }
               else
               {
                  _loc1_ = _loc7_.union(_loc7_);
               }
               _loc5_++;
            }
            _loc2_++;
         }
         if(_loc1_)
         {
            return AABB.fromRect(_loc1_);
         }
         LogUtils.log("Terrain " + shortName + " cannot generate AABB",this,2,"Warning",false,false,true);
         return null;
      }
      
      public function get lastDestroyedArea() : Number
      {
         return this._lastDestroyedArea;
      }
      
      override public function setCollisionFilterValues(param1:uint, param2:uint, param3:int = -1) : void
      {
         var _loc5_:* = undefined;
         var _loc4_:InteractionFilter = new InteractionFilter();
         _loc4_.collisionGroup = param1;
         _loc4_.collisionMask = param2;
         if(param3 != -1)
         {
            _loc4_.fluidGroup = param3;
         }
         for each(_loc5_ in this._bodies)
         {
            if(_loc5_)
            {
               _loc5_.setShapeFilters(_loc4_);
            }
         }
         LogUtils.log("Collision set Mask: " + param2 + " group: " + param1,this,0,"Collision",false,false,false);
      }
      
      override protected function createBody(param1:PhysicsGameObjectDef) : void
      {
      }
      
      override protected function createTag() : Tag
      {
         if(this.isDynamic())
         {
            return new Tag(this);
         }
         return new AlwaysEmptyTag(this);
      }
      
      override protected function loadGraphics() : void
      {
      }
      
      override protected function updateTag(param1:PhysicsGameObject) : void
      {
         var _loc2_:* = undefined;
         if(this.isDynamic())
         {
            _loc2_ = tag.playerTaggers;
            if(param1 is PlayerGameObject && Boolean(this.containsOtherPlayer(_loc2_,_loc3_._uniqueId)))
            {
               LogUtils.log("Skipping tagging this: " + shortName + " other: " + param1.shortName);
               return;
            }
            super.updateTag(param1);
         }
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
      
      override protected function outOfWorld() : void
      {
         if(this.isDynamic())
         {
            if(!this._markedForRemoval)
            {
               markForRemoval();
               LogUtils.log(this._id + ": Out of world!","TerrainGameObject",1,"GameObjects",false,false,false);
            }
         }
      }
      
      override public function enteredWater() : void
      {
         var _loc1_:SoundHelper = SoundHelper;
         if(SoundHelper._instance == null)
         {
            new SoundHelper();
         }
         var _loc2_:String = SoundHelper._instance.AreaReceiver(this.calculateTotalArea());
         var _loc3_:SoundHelper = SoundHelper;
         if(SoundHelper._instance == null)
         {
            new SoundHelper();
         }
         var _loc4_:String = SoundHelper._instance.SpeedReceiver(this.linearVelocity.length);
         var _loc5_:SoundReference = Sounds.getSoundReference("WaterHit" + _loc2_ + _loc4_);
         if(_loc5_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc5_.getMusicID(),_loc5_.getStart(),_loc5_.getType(),"PlaySound"));
         }
      }
      
      public function get material() : String
      {
         return this._material;
      }
      
      public function isDynamic() : Boolean
      {
         return this._isDynamic;
      }
      
      private function removeDestroyedModels() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TerrainModel = null;
         _loc1_ = this._terrainModels.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this._terrainModels[_loc1_];
            if(_loc2_.points.length == 0)
            {
               this._terrainModels.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      private function createNewModels() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc1_:Array = null;
         var _loc2_:Array = [];
         for each(_loc3_ in this._terrainModels)
         {
            _loc1_ = _loc3_.createNewModels();
            for each(_loc5_ in _loc1_)
            {
               _loc2_.push(_loc5_);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            this._terrainModels.push(_loc4_);
         }
      }
      
      private function removeBodies() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._bodies)
         {
            _loc1_.space = null;
            _loc1_.shapes.clear();
         }
         this._bodies.splice(0,this._bodies.length);
      }
      
      private function createNewBodies() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Body = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Space = (this.game as TuxWarsGame).tuxWorld.physicsWorld.space;
         _loc1_ = 0;
         while(_loc1_ < this._terrainModels.length)
         {
            _loc2_ = new Body(BodyType.STATIC);
            _loc2_.position = this._position.copy(true);
            _loc2_.userData.gameObject = this;
            this.addShapes(_loc2_,this._terrainModels[_loc1_].points);
            if(_loc2_.shapes.length > 0)
            {
               _loc2_.space = _loc4_;
               this._bodies.push(_loc2_);
            }
            _loc1_++;
         }
         this.setCollisionFilterValues(PhysicsCollisionCategories.Get("TERRAIN"),-1);
         if(!isNaN(this.lastTotalArea))
         {
            _loc3_ = this.calculateTotalArea();
            this._lastDestroyedArea = this.lastTotalArea - _loc3_;
            this.lastTotalArea = _loc3_;
         }
      }
      
      private function addShapes(param1:Body, param2:Vector.<Vec2>) : void
      {
         var _loc7_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:Polygon = null;
         var _loc5_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            _loc5_.push(param2[_loc3_].toPoint());
            _loc3_++;
         }
         var _loc6_:Array = EarCutting.cut(_loc5_);
         for each(_loc7_ in _loc6_)
         {
            _loc4_ = new Polygon([Vec2.fromPoint(_loc7_.p0,true),Vec2.fromPoint(_loc7_.p1,true),Vec2.fromPoint(_loc7_.p2,true)]);
            if(_loc4_.validity() == ValidationResult.VALID)
            {
               param1.shapes.add(_loc4_);
            }
         }
      }
      
      private function createElementPhysics(param1:Vector.<Vec2>) : TerrainElementPhysics
      {
         var _loc2_:Vector.<Vec2> = GeomUtils.duplicatePolygon(param1);
         var _loc3_:Object = {
            "theme":this._material,
            "points":DCUtils.toArray(_loc2_)
         };
         return new TerrainElementPhysics(_loc3_);
      }
   }
}

