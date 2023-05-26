package tuxwars.battle.world.loader
{
   import com.dchoc.resources.DCResourceManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public class TerrainTexture
   {
       
      
      private var terrainTextureSWF:String;
      
      private var terrainTextureExport:String;
      
      public function TerrainTexture(terrainTextureSWF:String, terrainTextureExport:String)
      {
         super();
         this.terrainTextureSWF = terrainTextureSWF;
         this.terrainTextureExport = terrainTextureExport;
         if(terrainTextureSWF && terrainTextureExport)
         {
            if(!DCResourceManager.instance.isLoaded(terrainTextureSWF))
            {
               DCResourceManager.instance.load(Config.getDataDir() + terrainTextureSWF,terrainTextureSWF,null,true);
            }
         }
      }
      
      public function dispose() : void
      {
         DCResourceManager.instance.unload(terrainTextureExport);
      }
      
      public function isLoaded() : Boolean
      {
         if(terrainTextureSWF && terrainTextureExport)
         {
            return DCResourceManager.instance.isLoaded(terrainTextureSWF);
         }
         return true;
      }
      
      public function getTextureBitmapData() : BitmapData
      {
         var _loc3_:int = 0;
         var objectType:* = null;
         var _loc2_:* = null;
         var resBMData:* = null;
         if(terrainTextureSWF && terrainTextureExport)
         {
            _loc3_ = terrainTextureExport.lastIndexOf(".");
            objectType = ".swf";
            if(_loc3_ != -1)
            {
               objectType = terrainTextureExport.substring(_loc3_);
            }
            if(objectType == ".png")
            {
               return DCResourceManager.instance.getFromSWF(terrainTextureSWF,terrainTextureExport,"BitmapData");
            }
            _loc2_ = DCResourceManager.instance.getFromSWF(terrainTextureSWF,terrainTextureExport,"MovieClip");
            resBMData = new BitmapData(_loc2_.width,_loc2_.height);
            resBMData.draw(_loc2_);
            return resBMData;
         }
         return null;
      }
   }
}
