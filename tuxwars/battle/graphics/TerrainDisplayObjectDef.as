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
      
      public function TerrainDisplayObjectDef(param1:MaterialTheme, param2:MaterialTheme, param3:TerrainModel, param4:TerrainTexture, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Boolean)
      {
         super();
         this.theme = param1;
         this.terrainModel = param3;
         this.terrainTexture = param4;
         this.terrainTextureRotation = param5;
         this.shade = param6;
         this.tint = param7;
         this.red = param8;
         this.green = param9;
         this.blue = param10;
         this.grassTheme = param2;
         this._isBorderDisabled = param11;
      }
      
      public function get isBorderDisabled() : Boolean
      {
         return this._isBorderDisabled;
      }
      
      public function getTerrainModel() : TerrainModel
      {
         return this.terrainModel;
      }
      
      public function getTheme() : MaterialTheme
      {
         return this.theme;
      }
      
      public function getGrassTheme() : MaterialTheme
      {
         return this.grassTheme;
      }
      
      public function getTerrainTexture() : TerrainTexture
      {
         return this.terrainTexture;
      }
      
      public function getTerrainTextureRotation() : int
      {
         return this.terrainTextureRotation;
      }
      
      public function getShade() : int
      {
         return this.shade;
      }
      
      public function getTint() : int
      {
         return this.tint;
      }
      
      public function getRed() : int
      {
         return this.red;
      }
      
      public function getGreen() : int
      {
         return this.green;
      }
      
      public function getBlue() : int
      {
         return this.blue;
      }
   }
}

