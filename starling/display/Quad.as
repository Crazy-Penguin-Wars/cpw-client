package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.utils.VertexData;
   
   public class Quad extends DisplayObject
   {
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperMatrix:Matrix = new Matrix();
       
      
      private var mTinted:Boolean;
      
      protected var mVertexData:VertexData;
      
      public function Quad(width:Number, height:Number, color:uint = 16777215, premultipliedAlpha:Boolean = true)
      {
         super();
         this.mTinted = color != 16777215;
         this.mVertexData = new VertexData(4,premultipliedAlpha);
         this.mVertexData.setPosition(0,0,0);
         this.mVertexData.setPosition(1,width,0);
         this.mVertexData.setPosition(2,0,height);
         this.mVertexData.setPosition(3,width,height);
         this.mVertexData.setUniformColor(color);
         this.onVertexDataChanged();
      }
      
      protected function onVertexDataChanged() : void
      {
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         var scaleX:Number = NaN;
         var scaleY:Number = NaN;
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         if(targetSpace == this)
         {
            this.mVertexData.getPosition(3,sHelperPoint);
            resultRect.setTo(0,0,sHelperPoint.x,sHelperPoint.y);
         }
         else if(targetSpace == parent && rotation == 0)
         {
            scaleX = this.scaleX;
            scaleY = this.scaleY;
            this.mVertexData.getPosition(3,sHelperPoint);
            resultRect.setTo(x - pivotX * scaleX,y - pivotY * scaleY,sHelperPoint.x * scaleX,sHelperPoint.y * scaleY);
            if(scaleX < 0)
            {
               resultRect.width *= -1;
               resultRect.x -= resultRect.width;
            }
            if(scaleY < 0)
            {
               resultRect.height *= -1;
               resultRect.y -= resultRect.height;
            }
         }
         else
         {
            getTransformationMatrix(targetSpace,sHelperMatrix);
            this.mVertexData.getBounds(sHelperMatrix,0,4,resultRect);
         }
         return resultRect;
      }
      
      public function getVertexColor(vertexID:int) : uint
      {
         return this.mVertexData.getColor(vertexID);
      }
      
      public function setVertexColor(vertexID:int, color:uint) : void
      {
         this.mVertexData.setColor(vertexID,color);
         this.onVertexDataChanged();
         if(color != 16777215)
         {
            this.mTinted = true;
         }
         else
         {
            this.mTinted = this.mVertexData.tinted;
         }
      }
      
      public function getVertexAlpha(vertexID:int) : Number
      {
         return this.mVertexData.getAlpha(vertexID);
      }
      
      public function setVertexAlpha(vertexID:int, alpha:Number) : void
      {
         this.mVertexData.setAlpha(vertexID,alpha);
         this.onVertexDataChanged();
         if(alpha != 1)
         {
            this.mTinted = true;
         }
         else
         {
            this.mTinted = this.mVertexData.tinted;
         }
      }
      
      public function get color() : uint
      {
         return this.mVertexData.getColor(0);
      }
      
      public function set color(value:uint) : void
      {
         for(var i:int = 0; i < 4; i++)
         {
            this.setVertexColor(i,value);
         }
         if(value != 16777215 || alpha != 1)
         {
            this.mTinted = true;
         }
         else
         {
            this.mTinted = this.mVertexData.tinted;
         }
      }
      
      override public function set alpha(value:Number) : void
      {
         super.alpha = value;
         if(value < 1)
         {
            this.mTinted = true;
         }
         else
         {
            this.mTinted = this.mVertexData.tinted;
         }
      }
      
      public function copyVertexDataTo(targetData:VertexData, targetVertexID:int = 0) : void
      {
         this.mVertexData.copyTo(targetData,targetVertexID);
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         support.batchQuad(this,parentAlpha);
      }
      
      public function get tinted() : Boolean
      {
         return this.mTinted;
      }
   }
}
