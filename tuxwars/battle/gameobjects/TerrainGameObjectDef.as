package tuxwars.battle.gameobjects
{
   import nape.geom.Vec2;
   import nape.phys.*;
   import nape.space.Space;
   import tuxwars.battle.data.MaterialTheme;
   import tuxwars.battle.graphics.*;
   import tuxwars.battle.world.loader.*;
   
   public class TerrainGameObjectDef extends PhysicsGameObjectDef
   {
      private var terrainModel:TerrainModel;
      
      private var terrainDisplayObjectDef:TerrainDisplayObjectDef;
      
      private var originalTerrainPoints:Vector.<Vec2>;
      
      private var element:Element;
      
      public function TerrainGameObjectDef(param1:Space, param2:Element)
      {
         super(param1);
         objClass = TerrainGameObject;
         this.element = param2;
         id = param2.id;
         name = param2.getName();
         this.terrainModel = new TerrainModel(param2.getTerrainElementPhysics().getPoints());
         this.terrainDisplayObjectDef = new TerrainDisplayObjectDef(param2.getTheme(),param2.getGrassTheme(),this.terrainModel,param2.getTerrainTexture(),param2.getTerrainTextureRotation(),param2.getTerrainShade(),param2.getTerrainTint(),param2.getTerrainRed(),param2.getTerrainGreen(),param2.getTerrainBlue(),param2.isBorderDisabled());
         if(param2.isTerrainElementDynamic())
         {
            bodyDef.type = BodyType.DYNAMIC;
         }
         else
         {
            bodyDef.type = BodyType.STATIC;
         }
         bodyDef.position = param2.getTerrainElementPhysics().getLocation();
         this.originalTerrainPoints = param2.getTerrainElementPhysics().getOriginalPoints();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.terrainModel = null;
         this.terrainDisplayObjectDef = null;
         this.originalTerrainPoints = null;
      }
      
      public function getOriginalPoints() : Vector.<Vec2>
      {
         return this.originalTerrainPoints;
      }
      
      public function getTerrainModel() : TerrainModel
      {
         return this.terrainModel;
      }
      
      public function getTerrainDisplayObjectDef() : TerrainDisplayObjectDef
      {
         return this.terrainDisplayObjectDef;
      }
      
      public function getTheme() : MaterialTheme
      {
         return this.terrainDisplayObjectDef.getTheme();
      }
      
      public function canTakeDamage() : Boolean
      {
         return this.element.canTakeDamage();
      }
      
      public function isDynamic() : Boolean
      {
         return this.element.isTerrainElementDynamic();
      }
   }
}

