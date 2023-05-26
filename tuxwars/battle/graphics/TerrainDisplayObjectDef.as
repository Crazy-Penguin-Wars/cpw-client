package tuxwars.battle.graphics
{
   import tuxwars.battle.data.MaterialTheme;
   import tuxwars.battle.world.loader.TerrainModel;
   import tuxwars.battle.world.loader.TerrainTexture;
   
   public class TerrainDisplayObjectDef
   {
       
      
      private var terrainModel:TerrainModel;
      
      private var theme:MaterialTheme;
      
      private var grassTheme:MaterialTheme;
      
      private var terrainTexture:TerrainTexture;
      
      private var terrainTextureRotation:int;
      
      private var shade:int;
      
      private var tint:int;
      
      private var red:int;
      
      private var green:int;
      
      private var blue:int;
      
      private var _isBorderDisabled:Boolean;
      
      public function TerrainDisplayObjectDef(theme:MaterialTheme, grassTheme:MaterialTheme, terrainModel:TerrainModel, terrainTexture:TerrainTexture, terrainTextureRotation:int, shade:int, tint:int, red:int, green:int, blue:int, isBorderDisabled:Boolean)
      {
         super();
         this.theme = theme;
         this.terrainModel = terrainModel;
         this.terrainTexture = terrainTexture;
         this.terrainTextureRotation = terrainTextureRotation;
         this.shade = shade;
         this.tint = tint;
         this.red = red;
         this.green = green;
         this.blue = blue;
         this.grassTheme = grassTheme;
         _isBorderDisabled = isBorderDisabled;
      }
      
      public function get isBorderDisabled() : Boolean
      {
         return _isBorderDisabled;
      }
      
      public function getTerrainModel() : TerrainModel
      {
         return terrainModel;
      }
      
      public function getTheme() : MaterialTheme
      {
         return theme;
      }
      
      public function getGrassTheme() : MaterialTheme
      {
         return grassTheme;
      }
      
      public function getTerrainTexture() : TerrainTexture
      {
         return terrainTexture;
      }
      
      public function getTerrainTextureRotation() : int
      {
         return terrainTextureRotation;
      }
      
      public function getShade() : int
      {
         return shade;
      }
      
      public function getTint() : int
      {
         return tint;
      }
      
      public function getRed() : int
      {
         return red;
      }
      
      public function getGreen() : int
      {
         return green;
      }
      
      public function getBlue() : int
      {
         return blue;
      }
   }
}
