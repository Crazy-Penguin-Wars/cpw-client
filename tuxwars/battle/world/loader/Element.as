package tuxwars.battle.world.loader
{
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.data.MaterialTheme;
   import tuxwars.battle.data.MaterialThemes;
   import tuxwars.battle.gameobjects.LevelGameObjectDef;
   import tuxwars.battle.gameobjects.TerrainGameObjectDef;
   
   public class Element
   {
      
      private static const GRASS_NONE:String = "[None]";
      
      private static const GRASS_SAME_AS_THEME:String = "[Material]";
       
      
      private var name:String;
      
      private var theme:MaterialTheme;
      
      private var grassTheme:MaterialTheme;
      
      private var type:String;
      
      private var _id:String;
      
      private var terrainElementPhysics:TerrainElementPhysics;
      
      private var terrainElementIsDynamic:Boolean;
      
      private var terrainElementBordersDisabled:Boolean;
      
      private var terrainTexture:TerrainTexture;
      
      private var terrainTextureRotation:int;
      
      private var dynamicElementPhysics:DynamicElementPhysics;
      
      private var terrainShade:int;
      
      private var terrainTint:int;
      
      private var terrainRed:int;
      
      private var terrainGreen:int;
      
      private var terrainBlue:int;
      
      private var _unBreakable:Boolean;
      
      public function Element(data:Object)
      {
         super();
         assert("Data is null.",true,data != null);
         name = data.name;
         type = data.element_type;
         _id = data.id.toString();
         theme = MaterialThemes.findTheme(data.theme);
         terrainTextureRotation = 0;
         terrainShade = 0;
         terrainTint = 0;
         terrainRed = 0;
         terrainGreen = 0;
         terrainBlue = 0;
         terrainElementIsDynamic = false;
         terrainElementBordersDisabled = false;
         if(data.unbreakable != null)
         {
            _unBreakable = data.unbreakable;
         }
         else
         {
            _unBreakable = false;
         }
         if(type == "TerrainBlockEntity")
         {
            terrainElementPhysics = new TerrainElementPhysics(data);
            terrainElementIsDynamic = data.dynamic;
            terrainElementBordersDisabled = data.disable_borders;
            terrainTexture = new TerrainTexture(data.texture_swf,data.texture_export);
            terrainTextureRotation = !!data.texture_rotation ? data.texture_rotation : 0;
            terrainShade = !!data.shade ? data.shade : 0;
            terrainTint = !!data.tint ? data.tint : 0;
            terrainRed = !!data.red ? data.red : 0;
            terrainGreen = !!data.green ? data.green : 0;
            terrainBlue = !!data.blue ? data.blue : 0;
            if(data.grass_theme)
            {
               if(data.grass_theme == "[Material]")
               {
                  grassTheme = theme;
               }
               else if(data.grass_theme == "[None]")
               {
                  grassTheme = null;
               }
               else
               {
                  grassTheme = MaterialThemes.findTheme(data.grass_theme);
               }
            }
            else
            {
               grassTheme = theme;
            }
         }
         else if(type == "DynamicObject")
         {
            dynamicElementPhysics = new DynamicElementPhysics(data,this);
         }
      }
      
      public function dispose() : void
      {
         if(theme)
         {
            theme.dispose();
            theme = null;
         }
         if(grassTheme)
         {
            grassTheme.dispose();
            grassTheme = null;
         }
         if(terrainElementPhysics)
         {
            terrainElementPhysics.dispose();
            terrainElementPhysics = null;
         }
         if(terrainTexture)
         {
            terrainTexture.dispose();
            terrainTexture = null;
         }
         if(dynamicElementPhysics)
         {
            dynamicElementPhysics.dispose();
            dynamicElementPhysics = null;
         }
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function getGameObjectDefClass() : Class
      {
         return type == "TerrainBlockEntity" ? TerrainGameObjectDef : LevelGameObjectDef;
      }
      
      public function getLocation() : Vec2
      {
         return type == "TerrainBlockEntity" ? terrainElementPhysics.getLocation() : dynamicElementPhysics.getLocation();
      }
      
      public function getTerrainElementPhysics() : TerrainElementPhysics
      {
         return terrainElementPhysics;
      }
      
      public function getDynamicElementPhysics() : DynamicElementPhysics
      {
         return dynamicElementPhysics;
      }
      
      public function isLoaded() : Boolean
      {
         var loaded:Boolean = true;
         loaded = theme.isLoaded();
         if(loaded && terrainTexture)
         {
            loaded = terrainTexture.isLoaded();
         }
         if(loaded && grassTheme)
         {
            loaded = grassTheme.isLoaded();
         }
         if(loaded)
         {
            if(dynamicElementPhysics)
            {
               loaded = dynamicElementPhysics.isLoaded();
            }
            else if(terrainElementPhysics)
            {
               loaded = terrainElementPhysics.isLoaded();
            }
         }
         return loaded;
      }
      
      public function getType() : String
      {
         return type;
      }
      
      public function getName() : String
      {
         return name;
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
      
      public function getTerrainShade() : int
      {
         return terrainShade;
      }
      
      public function getTerrainTint() : int
      {
         return terrainTint;
      }
      
      public function getTerrainRed() : int
      {
         return terrainRed;
      }
      
      public function getTerrainGreen() : int
      {
         return terrainGreen;
      }
      
      public function getTerrainBlue() : int
      {
         return terrainBlue;
      }
      
      public function isTerrainElementDynamic() : Boolean
      {
         return terrainElementIsDynamic;
      }
      
      public function isBorderDisabled() : Boolean
      {
         return terrainElementBordersDisabled;
      }
      
      public function canTakeDamage() : Boolean
      {
         return !_unBreakable;
      }
   }
}
