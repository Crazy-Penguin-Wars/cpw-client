package tuxwars.battle.gameobjects
{
   import nape.geom.Vec2;
   import nape.phys.BodyType;
   import nape.space.Space;
   import tuxwars.battle.data.MaterialTheme;
   import tuxwars.battle.graphics.TerrainDisplayObjectDef;
   import tuxwars.battle.world.loader.Element;
   import tuxwars.battle.world.loader.TerrainModel;
   
   public class TerrainGameObjectDef extends PhysicsGameObjectDef
   {
       
      
      private var terrainModel:TerrainModel;
      
      private var terrainDisplayObjectDef:TerrainDisplayObjectDef;
      
      private var originalTerrainPoints:Vector.<Vec2>;
      
      private var element:Element;
      
      public function TerrainGameObjectDef(world:Space, element:Element)
      {
         super(world);
         objClass = TerrainGameObject;
         this.element = element;
         id = element.id;
         name = element.getName();
         terrainModel = new TerrainModel(element.getTerrainElementPhysics().getPoints());
         terrainDisplayObjectDef = new TerrainDisplayObjectDef(element.getTheme(),element.getGrassTheme(),terrainModel,element.getTerrainTexture(),element.getTerrainTextureRotation(),element.getTerrainShade(),element.getTerrainTint(),element.getTerrainRed(),element.getTerrainGreen(),element.getTerrainBlue(),element.isBorderDisabled());
         if(element.isTerrainElementDynamic())
         {
            bodyDef.type = BodyType.DYNAMIC;
         }
         else
         {
            bodyDef.type = BodyType.STATIC;
         }
         bodyDef.position = element.getTerrainElementPhysics().getLocation();
         originalTerrainPoints = element.getTerrainElementPhysics().getOriginalPoints();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         terrainModel = null;
         terrainDisplayObjectDef = null;
         originalTerrainPoints = null;
      }
      
      public function getOriginalPoints() : Vector.<Vec2>
      {
         return originalTerrainPoints;
      }
      
      public function getTerrainModel() : TerrainModel
      {
         return terrainModel;
      }
      
      public function getTerrainDisplayObjectDef() : TerrainDisplayObjectDef
      {
         return terrainDisplayObjectDef;
      }
      
      public function getTheme() : MaterialTheme
      {
         return terrainDisplayObjectDef.getTheme();
      }
      
      public function canTakeDamage() : Boolean
      {
         return element.canTakeDamage();
      }
      
      public function isDynamic() : Boolean
      {
         return element.isTerrainElementDynamic();
      }
   }
}
