package tuxwars.battle.world.loader
{
   import nape.geom.Vec2;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.gameobjects.*;
   
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
      
      public function Element(param1:Object)
      {
         super();
         assert("Data is null.",true,param1 != null);
         this.name = param1.name;
         this.type = param1.element_type;
         this._id = param1.id.toString();
         this.theme = MaterialThemes.findTheme(param1.theme);
         this.terrainTextureRotation = 0;
         this.terrainShade = 0;
         this.terrainTint = 0;
         this.terrainRed = 0;
         this.terrainGreen = 0;
         this.terrainBlue = 0;
         this.terrainElementIsDynamic = false;
         this.terrainElementBordersDisabled = false;
         if(param1.unbreakable != null)
         {
            this._unBreakable = param1.unbreakable;
         }
         else
         {
            this._unBreakable = false;
         }
         if(this.type == "TerrainBlockEntity")
         {
            this.terrainElementPhysics = new TerrainElementPhysics(param1);
            this.terrainElementIsDynamic = param1.dynamic;
            this.terrainElementBordersDisabled = param1.disable_borders;
            this.terrainTexture = new TerrainTexture(param1.texture_swf,param1.texture_export);
            this.terrainTextureRotation = !!param1.texture_rotation ? int(param1.texture_rotation) : 0;
            this.terrainShade = !!param1.shade ? int(param1.shade) : 0;
            this.terrainTint = !!param1.tint ? int(param1.tint) : 0;
            this.terrainRed = !!param1.red ? int(param1.red) : 0;
            this.terrainGreen = !!param1.green ? int(param1.green) : 0;
            this.terrainBlue = !!param1.blue ? int(param1.blue) : 0;
            if(param1.grass_theme)
            {
               if(param1.grass_theme == "[Material]")
               {
                  this.grassTheme = this.theme;
               }
               else if(param1.grass_theme == "[None]")
               {
                  this.grassTheme = null;
               }
               else
               {
                  this.grassTheme = MaterialThemes.findTheme(param1.grass_theme);
               }
            }
            else
            {
               this.grassTheme = this.theme;
            }
         }
         else if(this.type == "DynamicObject")
         {
            this.dynamicElementPhysics = new DynamicElementPhysics(param1,this);
         }
      }
      
      public function dispose() : void
      {
         if(this.theme)
         {
            this.theme.dispose();
            this.theme = null;
         }
         if(this.grassTheme)
         {
            this.grassTheme.dispose();
            this.grassTheme = null;
         }
         if(this.terrainElementPhysics)
         {
            this.terrainElementPhysics.dispose();
            this.terrainElementPhysics = null;
         }
         if(this.terrainTexture)
         {
            this.terrainTexture.dispose();
            this.terrainTexture = null;
         }
         if(this.dynamicElementPhysics)
         {
            this.dynamicElementPhysics.dispose();
            this.dynamicElementPhysics = null;
         }
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function getGameObjectDefClass() : Class
      {
         return this.type == "TerrainBlockEntity" ? TerrainGameObjectDef : LevelGameObjectDef;
      }
      
      public function getLocation() : Vec2
      {
         return this.type == "TerrainBlockEntity" ? this.terrainElementPhysics.getLocation() : this.dynamicElementPhysics.getLocation();
      }
      
      public function getTerrainElementPhysics() : TerrainElementPhysics
      {
         return this.terrainElementPhysics;
      }
      
      public function getDynamicElementPhysics() : DynamicElementPhysics
      {
         return this.dynamicElementPhysics;
      }
      
      public function isLoaded() : Boolean
      {
         var _loc1_:Boolean = true;
         _loc1_ = Boolean(this.theme.isLoaded());
         if(_loc1_ && Boolean(this.terrainTexture))
         {
            _loc1_ = Boolean(this.terrainTexture.isLoaded());
         }
         if(_loc1_ && Boolean(this.grassTheme))
         {
            _loc1_ = Boolean(this.grassTheme.isLoaded());
         }
         if(_loc1_)
         {
            if(this.dynamicElementPhysics)
            {
               _loc1_ = Boolean(this.dynamicElementPhysics.isLoaded());
            }
            else if(this.terrainElementPhysics)
            {
               _loc1_ = Boolean(this.terrainElementPhysics.isLoaded());
            }
         }
         return _loc1_;
      }
      
      public function getType() : String
      {
         return this.type;
      }
      
      public function getName() : String
      {
         return this.name;
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
      
      public function getTerrainShade() : int
      {
         return this.terrainShade;
      }
      
      public function getTerrainTint() : int
      {
         return this.terrainTint;
      }
      
      public function getTerrainRed() : int
      {
         return this.terrainRed;
      }
      
      public function getTerrainGreen() : int
      {
         return this.terrainGreen;
      }
      
      public function getTerrainBlue() : int
      {
         return this.terrainBlue;
      }
      
      public function isTerrainElementDynamic() : Boolean
      {
         return this.terrainElementIsDynamic;
      }
      
      public function isBorderDisabled() : Boolean
      {
         return this.terrainElementBordersDisabled;
      }
      
      public function canTakeDamage() : Boolean
      {
         return !this._unBreakable;
      }
   }
}

