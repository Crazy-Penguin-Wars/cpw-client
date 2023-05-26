package starling.display
{
   import flash.display.Bitmap;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.textures.Texture;
   import starling.textures.TextureSmoothing;
   import starling.utils.VertexData;
   
   public class Image extends Quad
   {
       
      
      private var mTexture:Texture;
      
      private var mSmoothing:String;
      
      private var mVertexDataCache:VertexData;
      
      private var mVertexDataCacheInvalid:Boolean;
      
      public function Image(texture:Texture)
      {
         var frame:Rectangle = null;
         var width:Number = NaN;
         var height:Number = NaN;
         var pma:Boolean = false;
         if(Boolean(texture))
         {
            frame = texture.frame;
            width = Boolean(frame) ? frame.width : texture.width;
            height = Boolean(frame) ? frame.height : texture.height;
            pma = texture.premultipliedAlpha;
            super(width,height,16777215,pma);
            mVertexData.setTexCoords(0,0,0);
            mVertexData.setTexCoords(1,1,0);
            mVertexData.setTexCoords(2,0,1);
            mVertexData.setTexCoords(3,1,1);
            this.mTexture = texture;
            this.mSmoothing = TextureSmoothing.BILINEAR;
            this.mVertexDataCache = new VertexData(4,pma);
            this.mVertexDataCacheInvalid = true;
            return;
         }
         throw new ArgumentError("Texture cannot be null");
      }
      
      public static function fromBitmap(bitmap:Bitmap, generateMipMaps:Boolean = true, scale:Number = 1) : Image
      {
         return new Image(Texture.fromBitmap(bitmap,generateMipMaps,false,scale));
      }
      
      override protected function onVertexDataChanged() : void
      {
         this.mVertexDataCacheInvalid = true;
      }
      
      public function readjustSize() : void
      {
         var frame:Rectangle = this.texture.frame;
         var width:Number = Boolean(frame) ? frame.width : this.texture.width;
         var height:Number = Boolean(frame) ? frame.height : this.texture.height;
         mVertexData.setPosition(0,0,0);
         mVertexData.setPosition(1,width,0);
         mVertexData.setPosition(2,0,height);
         mVertexData.setPosition(3,width,height);
         this.onVertexDataChanged();
      }
      
      public function setTexCoords(vertexID:int, coords:Point) : void
      {
         mVertexData.setTexCoords(vertexID,coords.x,coords.y);
         this.onVertexDataChanged();
      }
      
      public function getTexCoords(vertexID:int, resultPoint:Point = null) : Point
      {
         if(resultPoint == null)
         {
            resultPoint = new Point();
         }
         mVertexData.getTexCoords(vertexID,resultPoint);
         return resultPoint;
      }
      
      override public function copyVertexDataTo(targetData:VertexData, targetVertexID:int = 0) : void
      {
         if(this.mVertexDataCacheInvalid)
         {
            this.mVertexDataCacheInvalid = false;
            mVertexData.copyTo(this.mVertexDataCache);
            this.mTexture.adjustVertexData(this.mVertexDataCache,0,4);
         }
         this.mVertexDataCache.copyTo(targetData,targetVertexID);
      }
      
      public function get texture() : Texture
      {
         return this.mTexture;
      }
      
      public function set texture(value:Texture) : void
      {
         if(value == null)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         if(value != this.mTexture)
         {
            this.mTexture = value;
            mVertexData.setPremultipliedAlpha(this.mTexture.premultipliedAlpha);
            this.onVertexDataChanged();
         }
      }
      
      public function get smoothing() : String
      {
         return this.mSmoothing;
      }
      
      public function set smoothing(value:String) : void
      {
         if(TextureSmoothing.isValid(value))
         {
            this.mSmoothing = value;
            return;
         }
         throw new ArgumentError("Invalid smoothing mode: " + value);
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         support.batchQuad(this,parentAlpha,this.mTexture,this.mSmoothing);
      }
   }
}
