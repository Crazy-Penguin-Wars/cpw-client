package starling.core
{
   import com.adobe.utils.AGALMiniAssembler;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DProgramType;
   import flash.display3D.Program3D;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.BlendMode;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.QuadBatch;
   import starling.errors.MissingContextError;
   import starling.textures.Texture;
   import starling.utils.Color;
   import starling.utils.MatrixUtil;
   
   public class RenderSupport
   {
      
      private static var sPoint:Point = new Point();
      
      private static var sRectangle:Rectangle = new Rectangle();
      
      private static var sAssembler:AGALMiniAssembler = new AGALMiniAssembler();
       
      
      private var mProjectionMatrix:Matrix;
      
      private var mModelViewMatrix:Matrix;
      
      private var mMvpMatrix:Matrix;
      
      private var mMvpMatrix3D:Matrix3D;
      
      private var mMatrixStack:Vector.<Matrix>;
      
      private var mMatrixStackSize:int;
      
      private var mDrawCount:int;
      
      private var mBlendMode:String;
      
      private var mRenderTarget:Texture;
      
      private var mBackBufferWidth:int;
      
      private var mBackBufferHeight:int;
      
      private var mScissorRectangle:Rectangle;
      
      private var mQuadBatches:Vector.<QuadBatch>;
      
      private var mCurrentQuadBatchID:int;
      
      public function RenderSupport()
      {
         super();
         this.mProjectionMatrix = new Matrix();
         this.mModelViewMatrix = new Matrix();
         this.mMvpMatrix = new Matrix();
         this.mMvpMatrix3D = new Matrix3D();
         this.mMatrixStack = new Vector.<Matrix>(0);
         this.mMatrixStackSize = 0;
         this.mDrawCount = 0;
         this.mRenderTarget = null;
         this.mBlendMode = BlendMode.NORMAL;
         this.mScissorRectangle = new Rectangle();
         this.mCurrentQuadBatchID = 0;
         this.mQuadBatches = new <QuadBatch>[new QuadBatch()];
         this.loadIdentity();
         this.setOrthographicProjection(0,0,400,300);
      }
      
      public static function transformMatrixForObject(matrix:Matrix, object:DisplayObject) : void
      {
         MatrixUtil.prependMatrix(matrix,object.transformationMatrix);
      }
      
      public static function setDefaultBlendFactors(premultipliedAlpha:Boolean) : void
      {
         setBlendFactors(premultipliedAlpha);
      }
      
      public static function setBlendFactors(premultipliedAlpha:Boolean, blendMode:String = "normal") : void
      {
         var blendFactors:Array = BlendMode.getBlendFactors(blendMode,premultipliedAlpha);
         Starling.context.setBlendFactors(blendFactors[0],blendFactors[1]);
      }
      
      public static function clear(rgb:uint = 0, alpha:Number = 0) : void
      {
         Starling.context.clear(Color.getRed(rgb) / 255,Color.getGreen(rgb) / 255,Color.getBlue(rgb) / 255,alpha);
      }
      
      public static function assembleAgal(vertexShader:String, fragmentShader:String, resultProgram:Program3D = null) : Program3D
      {
         var context:Context3D = null;
         if(resultProgram == null)
         {
            context = Starling.context;
            if(context == null)
            {
               throw new MissingContextError();
            }
            resultProgram = context.createProgram();
         }
         resultProgram.upload(sAssembler.assemble(Context3DProgramType.VERTEX,vertexShader),sAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentShader));
         return resultProgram;
      }
      
      public function dispose() : void
      {
         var quadBatch:QuadBatch = null;
         for each(quadBatch in this.mQuadBatches)
         {
            quadBatch.dispose();
         }
      }
      
      public function setOrthographicProjection(x:Number, y:Number, width:Number, height:Number) : void
      {
         this.mProjectionMatrix.setTo(2 / width,0,0,-2 / height,-(2 * x + width) / width,(2 * y + height) / height);
      }
      
      public function loadIdentity() : void
      {
         this.mModelViewMatrix.identity();
      }
      
      public function translateMatrix(dx:Number, dy:Number) : void
      {
         MatrixUtil.prependTranslation(this.mModelViewMatrix,dx,dy);
      }
      
      public function rotateMatrix(angle:Number) : void
      {
         MatrixUtil.prependRotation(this.mModelViewMatrix,angle);
      }
      
      public function scaleMatrix(sx:Number, sy:Number) : void
      {
         MatrixUtil.prependScale(this.mModelViewMatrix,sx,sy);
      }
      
      public function prependMatrix(matrix:Matrix) : void
      {
         MatrixUtil.prependMatrix(this.mModelViewMatrix,matrix);
      }
      
      public function transformMatrix(object:DisplayObject) : void
      {
         MatrixUtil.prependMatrix(this.mModelViewMatrix,object.transformationMatrix);
      }
      
      public function pushMatrix() : void
      {
         if(this.mMatrixStack.length < this.mMatrixStackSize + 1)
         {
            this.mMatrixStack.push(new Matrix());
         }
         this.mMatrixStack[int(this.mMatrixStackSize++)].copyFrom(this.mModelViewMatrix);
      }
      
      public function popMatrix() : void
      {
         this.mModelViewMatrix.copyFrom(this.mMatrixStack[int(--this.mMatrixStackSize)]);
      }
      
      public function resetMatrix() : void
      {
         this.mMatrixStackSize = 0;
         this.loadIdentity();
      }
      
      public function get mvpMatrix() : Matrix
      {
         this.mMvpMatrix.copyFrom(this.mModelViewMatrix);
         this.mMvpMatrix.concat(this.mProjectionMatrix);
         return this.mMvpMatrix;
      }
      
      public function get mvpMatrix3D() : Matrix3D
      {
         return MatrixUtil.convertTo3D(this.mvpMatrix,this.mMvpMatrix3D);
      }
      
      public function get modelViewMatrix() : Matrix
      {
         return this.mModelViewMatrix;
      }
      
      public function get projectionMatrix() : Matrix
      {
         return this.mProjectionMatrix;
      }
      
      public function applyBlendMode(premultipliedAlpha:Boolean) : void
      {
         setBlendFactors(premultipliedAlpha,this.mBlendMode);
      }
      
      public function get blendMode() : String
      {
         return this.mBlendMode;
      }
      
      public function set blendMode(value:String) : void
      {
         if(value != BlendMode.AUTO)
         {
            this.mBlendMode = value;
         }
      }
      
      public function get renderTarget() : Texture
      {
         return this.mRenderTarget;
      }
      
      public function set renderTarget(target:Texture) : void
      {
         this.mRenderTarget = target;
         if(Boolean(target))
         {
            Starling.context.setRenderToTexture(target.base);
         }
         else
         {
            Starling.context.setRenderToBackBuffer();
         }
      }
      
      public function configureBackBuffer(width:int, height:int, antiAlias:int, enableDepthAndStencil:Boolean) : void
      {
         this.mBackBufferWidth = width;
         this.mBackBufferHeight = height;
         Starling.context.configureBackBuffer(width,height,antiAlias,enableDepthAndStencil);
      }
      
      public function get backBufferWidth() : int
      {
         return this.mBackBufferWidth;
      }
      
      public function set backBufferWidth(value:int) : void
      {
         this.mBackBufferWidth = value;
      }
      
      public function get backBufferHeight() : int
      {
         return this.mBackBufferHeight;
      }
      
      public function set backBufferHeight(value:int) : void
      {
         this.mBackBufferHeight = value;
      }
      
      public function get scissorRectangle() : Rectangle
      {
         return this.mScissorRectangle.isEmpty() ? null : this.mScissorRectangle;
      }
      
      public function set scissorRectangle(value:Rectangle) : void
      {
         var width:int = 0;
         var height:int = 0;
         if(Boolean(value))
         {
            this.mScissorRectangle.setTo(value.x,value.y,value.width,value.height);
            width = Boolean(this.mRenderTarget) ? this.mRenderTarget.root.nativeWidth : this.mBackBufferWidth;
            height = Boolean(this.mRenderTarget) ? this.mRenderTarget.root.nativeHeight : this.mBackBufferHeight;
            MatrixUtil.transformCoords(this.mProjectionMatrix,value.x,value.y,sPoint);
            sRectangle.x = Math.max(0,(sPoint.x + 1) / 2) * width;
            sRectangle.y = Math.max(0,(-sPoint.y + 1) / 2) * height;
            MatrixUtil.transformCoords(this.mProjectionMatrix,value.right,value.bottom,sPoint);
            sRectangle.right = Math.min(1,(sPoint.x + 1) / 2) * width;
            sRectangle.bottom = Math.min(1,(-sPoint.y + 1) / 2) * height;
            Starling.context.setScissorRectangle(sRectangle);
         }
         else
         {
            this.mScissorRectangle.setEmpty();
            Starling.context.setScissorRectangle(null);
         }
      }
      
      public function batchQuad(quad:Quad, parentAlpha:Number, texture:Texture = null, smoothing:String = null) : void
      {
         if(this.mQuadBatches[this.mCurrentQuadBatchID].isStateChange(quad.tinted,parentAlpha,texture,smoothing,this.mBlendMode))
         {
            this.finishQuadBatch();
         }
         this.mQuadBatches[this.mCurrentQuadBatchID].addQuad(quad,parentAlpha,texture,smoothing,this.mModelViewMatrix,this.mBlendMode);
      }
      
      public function finishQuadBatch() : void
      {
         var currentBatch:QuadBatch = this.mQuadBatches[this.mCurrentQuadBatchID];
         if(currentBatch.numQuads != 0)
         {
            currentBatch.renderCustom(this.mProjectionMatrix);
            currentBatch.reset();
            ++this.mCurrentQuadBatchID;
            ++this.mDrawCount;
            if(this.mQuadBatches.length <= this.mCurrentQuadBatchID)
            {
               this.mQuadBatches.push(new QuadBatch());
            }
         }
      }
      
      public function nextFrame() : void
      {
         this.resetMatrix();
         this.mBlendMode = BlendMode.NORMAL;
         this.mCurrentQuadBatchID = 0;
         this.mDrawCount = 0;
      }
      
      public function clear(rgb:uint = 0, alpha:Number = 0) : void
      {
         RenderSupport.clear(rgb,alpha);
      }
      
      public function raiseDrawCount(value:uint = 1) : void
      {
         this.mDrawCount += value;
      }
      
      public function get drawCount() : int
      {
         return this.mDrawCount;
      }
   }
}
