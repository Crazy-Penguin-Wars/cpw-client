package tuxwars.battle.gameobjects
{
   import com.citrusengine.physics.PhysicsCollisionCategories;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import earcutting.EarCutting;
   import earcutting.Triangle;
   import flash.geom.Rectangle;
   import nape.dynamics.InteractionFilter;
   import nape.geom.AABB;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyType;
   import nape.shape.Polygon;
   import nape.shape.Shape;
   import nape.shape.ValidationResult;
   import nape.space.Space;
   import starling.display.Image;
   import starling.textures.Texture;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.particles.Particles;
   import tuxwars.battle.explosions.ExplosionShape;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.graphics.TerrainDisplayObject;
   import tuxwars.battle.utils.GeomUtils;
   import tuxwars.battle.world.loader.TerrainElementPhysics;
   import tuxwars.battle.world.loader.TerrainModel;
   import tuxwars.data.SoundHelper;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.player.reports.events.ReportTerrainDestroyedMessage;
   
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
      
      public function TerrainGameObject(def:TerrainGameObjectDef, game:TuxWarsGame)
      {
         _position = def.position.copy();
         _terrainModels.push(def.getTerrainModel());
         super(def,game);
         createNewBodies();
         terrainDisplayObject = new TerrainDisplayObject(def.getTerrainDisplayObjectDef());
         graphicsLoaded = true;
         _material = def.getTheme().getName();
         var _loc4_:Texture = Texture.fromBitmapData(terrainDisplayObject.terrainBitmap.bitmapData);
         var _loc3_:Image = new Image(_loc4_);
         _loc3_.x -= 25;
         _loc3_.y -= 25;
         this._displayObject.addChild(_loc3_);
         setCanTakeDamage(def.canTakeDamage());
         lastTotalArea = calculateTotalArea();
      }
      
      public function get logged() : Boolean
      {
         return _logged;
      }
      
      public function set logged(value:Boolean) : void
      {
         _logged = value;
      }
      
      override public function dispose() : void
      {
         terrainDisplayObject.dispose();
         terrainDisplayObject = null;
         for each(var body in _bodies)
         {
            if(body)
            {
               body.space = null;
               body.shapes.clear();
            }
         }
         _bodies.splice(0,_bodies.length);
         super.dispose();
      }
      
      public function get bodies() : Vector.<Body>
      {
         return _bodies;
      }
      
      override public function get bodyLocation() : Vec2
      {
         return _position;
      }
      
      public function getBodyAt(x:int, y:int) : Body
      {
         var si:int = 0;
         var v:Vec2 = Vec2.get(x,y);
         for each(var body in _bodies)
         {
            if(body != null && body.space != null)
            {
               for(si = 0; si < body.shapes.length; )
               {
                  if(body.shapes.at(si).contains(v))
                  {
                     return body;
                  }
                  si++;
               }
            }
         }
         return null;
      }
      
      public function get numBodies() : int
      {
         return _bodies.length;
      }
      
      override public function get linearVelocity() : Vec2
      {
         return Vec2.get();
      }
      
      override public function handleExplosionTerrain(location:Vec2, explosionShape:ExplosionShape) : void
      {
         var i:int = 0;
         var _loc6_:* = null;
         if(!canTakeDamage())
         {
            return;
         }
         var _loc8_:Vec2 = location.sub(new Vec2(this._displayObject.x,this._displayObject.y));
         var _loc3_:Vector.<Vec2> = GeomUtils.duplicatePolygon(explosionShape.getPoints());
         GeomUtils.translatePolygon(_loc3_,_loc8_);
         for each(var terrainModel in _terrainModels)
         {
            terrainModel.applyExplosion(GeomUtils.toPointVector(_loc3_));
         }
         removeDestroyedModels();
         removeBodies();
         createNewModels();
         if(_terrainModels.length == 0)
         {
            markForRemoval();
            return;
         }
         createNewBodies();
         terrainDisplayObject.drawExplosion(_loc3_,_terrainModels);
         i = 0;
         while(i < this._displayObject.numChildren)
         {
            _loc6_ = this._displayObject.getChildAt(i) as Image;
            _loc6_.texture.dispose();
            _loc6_.texture.base.dispose();
            i++;
         }
         this._displayObject.removeChildren(0,-1,true);
         var _loc5_:Texture = Texture.fromBitmapData(terrainDisplayObject.terrainBitmap.bitmapData);
         var _loc4_:Image = new Image(_loc5_);
         _loc4_.x -= 25;
         _loc4_.y -= 25;
         this._displayObject.addChild(_loc4_);
         MessageCenter.sendEvent(new ReportTerrainDestroyedMessage(this));
         (this.game as tuxwars.TuxWarsGame).tuxWorld.addParticle(Particles.getParticlesReference("MissileExplosion" + _material),location.x,location.y);
         if(_bodies.length == 0)
         {
            markForRemoval();
         }
         _logged = false;
      }
      
      override public function affectsGameObject(type:String, taggerGameObject:PhysicsGameObject) : Boolean
      {
         if(type == "terrain" || type == _material)
         {
            return true;
         }
         return super.affectsGameObject(type,taggerGameObject);
      }
      
      override protected function updateGraphics() : void
      {
         if(isDynamic())
         {
            super.updateGraphics();
         }
      }
      
      public function calculateTotalArea() : Number
      {
         var _loc3_:int = 0;
         var i:int = 0;
         var ret:Number = 0;
         for each(var body in _bodies)
         {
            _loc3_ = body.shapes.length;
            for(i = 0; i < _loc3_; )
            {
               ret += body.shapes.at(i).area;
               i++;
            }
         }
         return ret;
      }
      
      public function generateAABB() : AABB
      {
         var rect:* = null;
         var i:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var j:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         for(i = 0; i < _bodies.length; )
         {
            _loc1_ = _bodies[i];
            _loc2_ = _loc1_.shapes.length;
            for(j = 0; j < _loc2_; )
            {
               _loc4_ = _loc1_.shapes.at(j);
               _loc3_ = _loc4_.bounds.toRect();
               if(rect)
               {
                  rect = rect.union(_loc3_);
               }
               else
               {
                  rect = _loc3_.union(_loc3_);
               }
               j++;
            }
            i++;
         }
         if(rect)
         {
            return AABB.fromRect(rect);
         }
         LogUtils.log("Terrain " + shortName + " cannot generate AABB",this,2,"Warning",false,false,true);
         return null;
      }
      
      public function get lastDestroyedArea() : Number
      {
         return _lastDestroyedArea;
      }
      
      override public function setCollisionFilterValues(group:uint, mask:uint, fluidGroup:int = -1) : void
      {
         var _loc5_:InteractionFilter = new InteractionFilter();
         _loc5_.collisionGroup = group;
         _loc5_.collisionMask = mask;
         if(fluidGroup != -1)
         {
            _loc5_.fluidGroup = fluidGroup;
         }
         for each(var body in _bodies)
         {
            if(body)
            {
               body.setShapeFilters(_loc5_);
            }
         }
         LogUtils.log("Collision set Mask: " + mask + " group: " + group,this,0,"Collision",false,false,false);
      }
      
      override protected function createBody(def:PhysicsGameObjectDef) : void
      {
      }
      
      override protected function createTag() : Tag
      {
         if(isDynamic())
         {
            return new Tag(this);
         }
         return new AlwaysEmptyTag(this);
      }
      
      override protected function loadGraphics() : void
      {
      }
      
      override protected function updateTag(other:PhysicsGameObject) : void
      {
         var _loc2_:* = undefined;
         if(isDynamic())
         {
            _loc2_ = tag.playerTaggers;
            if(other is PlayerGameObject && containsOtherPlayer(_loc2_,_loc3_._uniqueId))
            {
               LogUtils.log("Skipping tagging this: " + shortName + " other: " + other.shortName);
               return;
            }
            super.updateTag(other);
         }
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
      
      override protected function outOfWorld() : void
      {
         if(isDynamic())
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
         var _loc4_:SoundHelper = SoundHelper;
         if(tuxwars.data.SoundHelper._instance == null)
         {
            new tuxwars.data.SoundHelper();
         }
         var _loc1_:String = tuxwars.data.SoundHelper._instance.AreaReceiver(calculateTotalArea());
         var _loc5_:SoundHelper = SoundHelper;
         if(tuxwars.data.SoundHelper._instance == null)
         {
            new tuxwars.data.SoundHelper();
         }
         var _loc2_:String = tuxwars.data.SoundHelper._instance.SpeedReceiver(linearVelocity.length);
         var _loc3_:SoundReference = Sounds.getSoundReference("WaterHit" + _loc1_ + _loc2_);
         if(_loc3_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
         }
      }
      
      public function get material() : String
      {
         return _material;
      }
      
      public function isDynamic() : Boolean
      {
         return _isDynamic;
      }
      
      private function removeDestroyedModels() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         for(i = _terrainModels.length - 1; i >= 0; )
         {
            _loc1_ = _terrainModels[i];
            if(_loc1_.points.length == 0)
            {
               _terrainModels.splice(i,1);
            }
            i--;
         }
      }
      
      private function createNewModels() : void
      {
         var _loc5_:* = null;
         var _loc3_:Array = [];
         for each(var model in _terrainModels)
         {
            _loc5_ = model.createNewModels();
            for each(var terrainModel in _loc5_)
            {
               _loc3_.push(terrainModel);
            }
         }
         for each(var newModel in _loc3_)
         {
            _terrainModels.push(newModel);
         }
      }
      
      private function removeBodies() : void
      {
         for each(var body in _bodies)
         {
            body.space = null;
            body.shapes.clear();
         }
         _bodies.splice(0,_bodies.length);
      }
      
      private function createNewBodies() : void
      {
         var i:int = 0;
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
         var _loc3_:Space = (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.space;
         for(i = 0; i < _terrainModels.length; )
         {
            _loc1_ = new Body(BodyType.STATIC);
            _loc1_.position = _position.copy(true);
            _loc1_.userData.gameObject = this;
            addShapes(_loc1_,_terrainModels[i].points);
            if(_loc1_.shapes.length > 0)
            {
               _loc1_.space = _loc3_;
               _bodies.push(_loc1_);
            }
            i++;
         }
         setCollisionFilterValues(PhysicsCollisionCategories.Get("TERRAIN"),-1);
         if(!isNaN(lastTotalArea))
         {
            _loc2_ = calculateTotalArea();
            _lastDestroyedArea = lastTotalArea - _loc2_;
            lastTotalArea = _loc2_;
         }
      }
      
      private function addShapes(body:Body, points:Vector.<Vec2>) : void
      {
         var i:int = 0;
         var _loc6_:* = null;
         var _loc3_:Array = [];
         for(i = 0; i < points.length; )
         {
            _loc3_.push(points[i].toPoint());
            i++;
         }
         var _loc4_:Array = EarCutting.cut(_loc3_);
         for each(var poly in _loc4_)
         {
            _loc6_ = new Polygon([Vec2.fromPoint(poly.p0,true),Vec2.fromPoint(poly.p1,true),Vec2.fromPoint(poly.p2,true)]);
            if(_loc6_.validity() == ValidationResult.VALID)
            {
               body.shapes.add(_loc6_);
            }
         }
      }
      
      private function createElementPhysics(polygon:Vector.<Vec2>) : TerrainElementPhysics
      {
         var _loc3_:Vector.<Vec2> = GeomUtils.duplicatePolygon(polygon);
         var _loc2_:Object = {
            "theme":_material,
            "points":DCUtils.toArray(_loc3_)
         };
         return new TerrainElementPhysics(_loc2_);
      }
   }
}
