package starling.utils
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class VertexData
   {
      
      public static const ELEMENTS_PER_VERTEX:int = 8;
      
      public static const POSITION_OFFSET:int = 0;
      
      public static const COLOR_OFFSET:int = 2;
      
      public static const TEXCOORD_OFFSET:int = 6;
      
      private static var sHelperPoint:Point = new Point();
       
      
      private var mRawData:Vector.<Number>;
      
      private var mPremultipliedAlpha:Boolean;
      
      private var mNumVertices:int;
      
      public function VertexData(numVertices:int, premultipliedAlpha:Boolean = false)
      {
         super();
         this.mRawData = new Vector.<Number>(0);
         this.mPremultipliedAlpha = premultipliedAlpha;
         this.numVertices = numVertices;
      }
      
      public function clone(vertexID:int = 0, numVertices:int = -1) : VertexData
      {
         if(numVertices < 0 || vertexID + numVertices > this.mNumVertices)
         {
            numVertices = this.mNumVertices - vertexID;
         }
         var clone:VertexData = new VertexData(0,this.mPremultipliedAlpha);
         clone.mNumVertices = numVertices;
         clone.mRawData = this.mRawData.slice(vertexID * ELEMENTS_PER_VERTEX,numVertices * ELEMENTS_PER_VERTEX);
         clone.mRawData.fixed = true;
         return clone;
      }
      
      public function copyTo(targetData:VertexData, targetVertexID:int = 0, vertexID:int = 0, numVertices:int = -1) : void
      {
         if(numVertices < 0 || vertexID + numVertices > this.mNumVertices)
         {
            numVertices = this.mNumVertices - vertexID;
         }
         var targetRawData:Vector.<Number> = targetData.mRawData;
         var targetIndex:int = targetVertexID * ELEMENTS_PER_VERTEX;
         var sourceIndex:int = vertexID * ELEMENTS_PER_VERTEX;
         var dataLength:int = numVertices * ELEMENTS_PER_VERTEX;
         for(var i:int = sourceIndex; i < dataLength; i++)
         {
            targetRawData[int(targetIndex++)] = this.mRawData[i];
         }
      }
      
      public function append(data:VertexData) : void
      {
         this.mRawData.fixed = false;
         var targetIndex:int = this.mRawData.length;
         var rawData:Vector.<Number> = data.mRawData;
         var rawDataLength:int = rawData.length;
         for(var i:int = 0; i < rawDataLength; i++)
         {
            this.mRawData[int(targetIndex++)] = rawData[i];
         }
         this.mNumVertices += data.numVertices;
         this.mRawData.fixed = true;
      }
      
      public function setPosition(vertexID:int, x:Number, y:Number) : void
      {
         var offset:int = this.getOffset(vertexID) + POSITION_OFFSET;
         this.mRawData[offset] = x;
         this.mRawData[int(offset + 1)] = y;
      }
      
      public function getPosition(vertexID:int, position:Point) : void
      {
         var offset:int = this.getOffset(vertexID) + POSITION_OFFSET;
         position.x = this.mRawData[offset];
         position.y = this.mRawData[int(offset + 1)];
      }
      
      public function setColor(vertexID:int, color:uint) : void
      {
         var offset:int = this.getOffset(vertexID) + COLOR_OFFSET;
         var multiplier:Number = this.mPremultipliedAlpha ? this.mRawData[int(offset + 3)] : 1;
         this.mRawData[offset] = (color >> 16 & 255) / 255 * multiplier;
         this.mRawData[int(offset + 1)] = (color >> 8 & 255) / 255 * multiplier;
         this.mRawData[int(offset + 2)] = (color & 255) / 255 * multiplier;
      }
      
      public function getColor(vertexID:int) : uint
      {
         var red:Number = NaN;
         var green:Number = NaN;
         var blue:Number = NaN;
         var offset:int = this.getOffset(vertexID) + COLOR_OFFSET;
         var divisor:Number = this.mPremultipliedAlpha ? this.mRawData[int(offset + 3)] : 1;
         if(divisor == 0)
         {
            return 0;
         }
         red = this.mRawData[offset] / divisor;
         green = this.mRawData[int(offset + 1)] / divisor;
         blue = this.mRawData[int(offset + 2)] / divisor;
         return int(red * 255) << 16 | int(green * 255) << 8 | int(blue * 255);
      }
      
      public function setAlpha(vertexID:int, alpha:Number) : void
      {
         var color:uint = 0;
         var offset:int = this.getOffset(vertexID) + COLOR_OFFSET + 3;
         if(this.mPremultipliedAlpha)
         {
            if(alpha < 0.001)
            {
               alpha = 0.001;
            }
            color = this.getColor(vertexID);
            this.mRawData[offset] = alpha;
            this.setColor(vertexID,color);
         }
         else
         {
            this.mRawData[offset] = alpha;
         }
      }
      
      public function getAlpha(vertexID:int) : Number
      {
         var offset:int = this.getOffset(vertexID) + COLOR_OFFSET + 3;
         return this.mRawData[offset];
      }
      
      public function setTexCoords(vertexID:int, u:Number, v:Number) : void
      {
         var offset:int = this.getOffset(vertexID) + TEXCOORD_OFFSET;
         this.mRawData[offset] = u;
         this.mRawData[int(offset + 1)] = v;
      }
      
      public function getTexCoords(vertexID:int, texCoords:Point) : void
      {
         var offset:int = this.getOffset(vertexID) + TEXCOORD_OFFSET;
         texCoords.x = this.mRawData[offset];
         texCoords.y = this.mRawData[int(offset + 1)];
      }
      
      public function translateVertex(vertexID:int, deltaX:Number, deltaY:Number) : void
      {
         var offset:int = this.getOffset(vertexID) + POSITION_OFFSET;
         this.mRawData[offset] += deltaX;
         this.mRawData[int(offset + 1)] = this.mRawData[int(offset + 1)] + deltaY;
      }
      
      public function transformVertex(vertexID:int, matrix:Matrix, numVertices:int = 1) : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         var offset:int = this.getOffset(vertexID) + POSITION_OFFSET;
         for(var i:int = 0; i < numVertices; i++)
         {
            x = this.mRawData[offset];
            y = this.mRawData[int(offset + 1)];
            this.mRawData[offset] = matrix.a * x + matrix.c * y + matrix.tx;
            this.mRawData[int(offset + 1)] = matrix.d * y + matrix.b * x + matrix.ty;
            offset += ELEMENTS_PER_VERTEX;
         }
      }
      
      public function setUniformColor(color:uint) : void
      {
         for(var i:int = 0; i < this.mNumVertices; i++)
         {
            this.setColor(i,color);
         }
      }
      
      public function setUniformAlpha(alpha:Number) : void
      {
         for(var i:int = 0; i < this.mNumVertices; i++)
         {
            this.setAlpha(i,alpha);
         }
      }
      
      public function scaleAlpha(vertexID:int, alpha:Number, numVertices:int = 1) : void
      {
         var i:int = 0;
         var offset:int = 0;
         if(alpha == 1)
         {
            return;
         }
         if(numVertices < 0 || vertexID + numVertices > this.mNumVertices)
         {
            numVertices = this.mNumVertices - vertexID;
         }
         if(this.mPremultipliedAlpha)
         {
            for(i = 0; i < numVertices; i++)
            {
               this.setAlpha(vertexID + i,this.getAlpha(vertexID + i) * alpha);
            }
         }
         else
         {
            offset = this.getOffset(vertexID) + COLOR_OFFSET + 3;
            for(i = 0; i < numVertices; i++)
            {
               this.mRawData[int(offset + i * ELEMENTS_PER_VERTEX)] = this.mRawData[int(offset + i * ELEMENTS_PER_VERTEX)] * alpha;
            }
         }
      }
      
      private function getOffset(vertexID:int) : int
      {
         return vertexID * ELEMENTS_PER_VERTEX;
      }
      
      public function getBounds(transformationMatrix:Matrix = null, vertexID:int = 0, numVertices:int = -1, resultRect:Rectangle = null) : Rectangle
      {
         var x:Number = NaN;
         var y:Number = NaN;
         var i:int = 0;
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         if(numVertices < 0 || vertexID + numVertices > this.mNumVertices)
         {
            numVertices = this.mNumVertices - vertexID;
         }
         var minX:Number = Number.MAX_VALUE;
         var maxX:Number = -Number.MAX_VALUE;
         var minY:Number = Number.MAX_VALUE;
         var maxY:Number = -Number.MAX_VALUE;
         var offset:int = this.getOffset(vertexID) + POSITION_OFFSET;
         if(transformationMatrix == null)
         {
            for(i = vertexID; i < numVertices; i++)
            {
               x = this.mRawData[offset];
               y = this.mRawData[int(offset + 1)];
               offset += ELEMENTS_PER_VERTEX;
               minX = minX < x ? minX : x;
               maxX = maxX > x ? maxX : x;
               minY = minY < y ? minY : y;
               maxY = maxY > y ? maxY : y;
            }
         }
         else
         {
            for(i = vertexID; i < numVertices; i++)
            {
               x = this.mRawData[offset];
               y = this.mRawData[int(offset + 1)];
               offset += ELEMENTS_PER_VERTEX;
               MatrixUtil.transformCoords(transformationMatrix,x,y,sHelperPoint);
               minX = minX < sHelperPoint.x ? minX : sHelperPoint.x;
               maxX = maxX > sHelperPoint.x ? maxX : sHelperPoint.x;
               minY = minY < sHelperPoint.y ? minY : sHelperPoint.y;
               maxY = maxY > sHelperPoint.y ? maxY : sHelperPoint.y;
            }
         }
         resultRect.setTo(minX,minY,maxX - minX,maxY - minY);
         return resultRect;
      }
      
      public function get tinted() : Boolean
      {
         var j:int = 0;
         var offset:int = COLOR_OFFSET;
         for(var i:int = 0; i < this.mNumVertices; i++)
         {
            for(j = 0; j < 4; j++)
            {
               if(this.mRawData[int(offset + j)] != 1)
               {
                  return true;
               }
            }
            offset += ELEMENTS_PER_VERTEX;
         }
         return false;
      }
      
      public function setPremultipliedAlpha(value:Boolean, updateData:Boolean = true) : void
      {
         var dataLength:int = 0;
         var i:int = 0;
         var alpha:Number = NaN;
         var divisor:Number = NaN;
         var multiplier:Number = NaN;
         if(value == this.mPremultipliedAlpha)
         {
            return;
         }
         if(updateData)
         {
            dataLength = this.mNumVertices * ELEMENTS_PER_VERTEX;
            for(i = COLOR_OFFSET; i < dataLength; i += ELEMENTS_PER_VERTEX)
            {
               alpha = this.mRawData[int(i + 3)];
               divisor = this.mPremultipliedAlpha ? alpha : 1;
               multiplier = value ? alpha : 1;
               if(divisor != 0)
               {
                  this.mRawData[i] = this.mRawData[i] / divisor * multiplier;
                  this.mRawData[int(i + 1)] = this.mRawData[int(i + 1)] / divisor * multiplier;
                  this.mRawData[int(i + 2)] = this.mRawData[int(i + 2)] / divisor * multiplier;
               }
            }
         }
         this.mPremultipliedAlpha = value;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return this.mPremultipliedAlpha;
      }
      
      public function get numVertices() : int
      {
         return this.mNumVertices;
      }
      
      public function set numVertices(value:int) : void
      {
         var i:int = 0;
         this.mRawData.fixed = false;
         var delta:int = value - this.mNumVertices;
         for(i = 0; i < delta; i++)
         {
            this.mRawData.push(0,0,0,0,0,1,0,0);
         }
         for(i = 0; i < -(delta * ELEMENTS_PER_VERTEX); i++)
         {
            this.mRawData.pop();
         }
         this.mNumVertices = value;
         this.mRawData.fixed = true;
      }
      
      public function get rawData() : Vector.<Number>
      {
         return this.mRawData;
      }
   }
}
