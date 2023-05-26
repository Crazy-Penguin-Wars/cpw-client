package starling.display
{
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   import starling.core.starling_internal;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   
   public class Stage extends DisplayObjectContainer
   {
       
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mColor:uint;
      
      private var mEnterFrameEvent:EnterFrameEvent;
      
      public function Stage(width:int, height:int, color:uint = 0)
      {
         this.mEnterFrameEvent = new EnterFrameEvent(Event.ENTER_FRAME,0);
         super();
         this.mWidth = width;
         this.mHeight = height;
         this.mColor = color;
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         this.mEnterFrameEvent.starling_internal::reset(Event.ENTER_FRAME,false,passedTime);
         broadcastEvent(this.mEnterFrameEvent);
      }
      
      override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         if(forTouch && (!visible || !touchable))
         {
            return null;
         }
         if(localPoint.x < 0 || localPoint.x > this.mWidth || localPoint.y < 0 || localPoint.y > this.mHeight)
         {
            return null;
         }
         var target:DisplayObject = super.hitTest(localPoint,forTouch);
         if(target == null)
         {
            target = this;
         }
         return target;
      }
      
      override public function set width(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set width of stage");
      }
      
      override public function set height(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set height of stage");
      }
      
      override public function set x(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set x-coordinate of stage");
      }
      
      override public function set y(value:Number) : void
      {
         throw new IllegalOperationError("Cannot set y-coordinate of stage");
      }
      
      override public function set scaleX(value:Number) : void
      {
         throw new IllegalOperationError("Cannot scale stage");
      }
      
      override public function set scaleY(value:Number) : void
      {
         throw new IllegalOperationError("Cannot scale stage");
      }
      
      override public function set rotation(value:Number) : void
      {
         throw new IllegalOperationError("Cannot rotate stage");
      }
      
      public function get color() : uint
      {
         return this.mColor;
      }
      
      public function set color(value:uint) : void
      {
         this.mColor = value;
      }
      
      public function get stageWidth() : int
      {
         return this.mWidth;
      }
      
      public function set stageWidth(value:int) : void
      {
         this.mWidth = value;
      }
      
      public function get stageHeight() : int
      {
         return this.mHeight;
      }
      
      public function set stageHeight(value:int) : void
      {
         this.mHeight = value;
      }
   }
}
