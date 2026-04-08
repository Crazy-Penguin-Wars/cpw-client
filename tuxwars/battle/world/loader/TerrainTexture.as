package tuxwars.battle.world.loader
{
   import com.dchoc.resources.*;
   import flash.display.*;
   
   public class TerrainTexture
   {
      private var terrainTextureSWF:String;
      
      private var terrainTextureExport:String;
      
      public function TerrainTexture(param1:String, param2:String)
      {
         super();
         this.terrainTextureSWF = param1;
         this.terrainTextureExport = param2;
         if(Boolean(param1) && Boolean(param2))
         {
            if(!DCResourceManager.instance.isLoaded(param1))
            {
               DCResourceManager.instance.load(Config.getDataDir() + param1,param1,null,true);
            }
         }
      }
      
      public function dispose() : void
      {
         DCResourceManager.instance.unload(this.terrainTextureExport);
      }
      
      public function isLoaded() : Boolean
      {
         if(Boolean(this.terrainTextureSWF) && Boolean(this.terrainTextureExport))
         {
            return DCResourceManager.instance.isLoaded(this.terrainTextureSWF);
         }
         return true;
      }
      
      public function getTextureBitmapData() : BitmapData
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         var _loc4_:BitmapData = null;
         if(Boolean(this.terrainTextureSWF) && Boolean(this.terrainTextureExport))
         {
            _loc1_ = int(this.terrainTextureExport.lastIndexOf("."));
            _loc2_ = ".swf";
            if(_loc1_ != -1)
            {
               _loc2_ = this.terrainTextureExport.substring(_loc1_);
            }
            if(_loc2_ == ".png")
            {
               return DCResourceManager.instance.getFromSWF(this.terrainTextureSWF,this.terrainTextureExport,"BitmapData");
            }
            _loc3_ = DCResourceManager.instance.getFromSWF(this.terrainTextureSWF,this.terrainTextureExport,"MovieClip");
            _loc4_ = new BitmapData(_loc3_.width,_loc3_.height);
            _loc4_.draw(_loc3_);
            return _loc4_;
         }
         return null;
      }
   }
}

