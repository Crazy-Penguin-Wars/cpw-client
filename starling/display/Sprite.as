package starling.display
{
   import flash.geom.Matrix;
   import starling.core.RenderSupport;
   import starling.events.Event;
   
   public class Sprite extends DisplayObjectContainer
   {
       
      
      private var mFlattenedContents:Vector.<QuadBatch>;
      
      private var mFlattenRequested:Boolean;
      
      public function Sprite()
      {
         super();
      }
      
      override public function dispose() : void
      {
         this.disposeFlattenedContents();
         super.dispose();
      }
      
      private function disposeFlattenedContents() : void
      {
         var i:int = 0;
         var max:int = 0;
         if(Boolean(this.mFlattenedContents))
         {
            for(i = 0,max = this.mFlattenedContents.length; i < max; i++)
            {
               this.mFlattenedContents[i].dispose();
            }
            this.mFlattenedContents = null;
         }
      }
      
      public function flatten() : void
      {
         this.mFlattenRequested = true;
         broadcastEventWith(Event.FLATTEN);
      }
      
      public function unflatten() : void
      {
         this.mFlattenRequested = false;
         this.disposeFlattenedContents();
      }
      
      public function get isFlattened() : Boolean
      {
         return this.mFlattenedContents != null || this.mFlattenRequested;
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         var alpha:Number = NaN;
         var numBatches:int = 0;
         var mvpMatrix:Matrix = null;
         var i:int = 0;
         var quadBatch:QuadBatch = null;
         var blendMode:String = null;
         if(Boolean(this.mFlattenedContents) || this.mFlattenRequested)
         {
            if(this.mFlattenedContents == null)
            {
               this.mFlattenedContents = new Vector.<QuadBatch>(0);
            }
            if(this.mFlattenRequested)
            {
               QuadBatch.compile(this,this.mFlattenedContents);
               this.mFlattenRequested = false;
            }
            alpha = parentAlpha * this.alpha;
            numBatches = this.mFlattenedContents.length;
            mvpMatrix = support.mvpMatrix;
            support.finishQuadBatch();
            support.raiseDrawCount(numBatches);
            for(i = 0; i < numBatches; i++)
            {
               quadBatch = this.mFlattenedContents[i];
               blendMode = quadBatch.blendMode == BlendMode.AUTO ? support.blendMode : quadBatch.blendMode;
               quadBatch.renderCustom(mvpMatrix,alpha,blendMode);
            }
         }
         else
         {
            super.render(support,parentAlpha);
         }
      }
   }
}
