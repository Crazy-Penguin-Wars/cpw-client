package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.utils.getQualifiedClassName;
   import starling.core.RenderSupport;
   import starling.core.starling_internal;
   import starling.errors.AbstractClassError;
   import starling.events.Event;
   import starling.filters.FragmentFilter;
   import starling.utils.MatrixUtil;
   
   public class DisplayObjectContainer extends DisplayObject
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sBroadcastListeners:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
       
      
      private var mChildren:Vector.<DisplayObject>;
      
      public function DisplayObjectContainer()
      {
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "starling.display::DisplayObjectContainer")
         {
            throw new AbstractClassError();
         }
         this.mChildren = new Vector.<DisplayObject>(0);
      }
      
      override public function dispose() : void
      {
         for(var i:int = this.mChildren.length - 1; i >= 0; i--)
         {
            this.mChildren[i].dispose();
         }
         super.dispose();
      }
      
      public function addChild(child:DisplayObject) : DisplayObject
      {
         this.addChildAt(child,this.numChildren);
         return child;
      }
      
      public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         var container:DisplayObjectContainer = null;
         var numChildren:int = this.mChildren.length;
         if(index >= 0 && index <= numChildren)
         {
            child.removeFromParent();
            if(index == numChildren)
            {
               this.mChildren.push(child);
            }
            else
            {
               this.mChildren.splice(index,0,child);
            }
            child.setParent(this);
            child.dispatchEventWith(Event.ADDED,true);
            if(Boolean(stage))
            {
               container = child as DisplayObjectContainer;
               if(Boolean(container))
               {
                  container.broadcastEventWith(Event.ADDED_TO_STAGE);
               }
               else
               {
                  child.dispatchEventWith(Event.ADDED_TO_STAGE);
               }
            }
            return child;
         }
         throw new RangeError("Invalid child index");
      }
      
      public function removeChild(child:DisplayObject, dispose:Boolean = false) : DisplayObject
      {
         var childIndex:int = this.getChildIndex(child);
         if(childIndex != -1)
         {
            this.removeChildAt(childIndex,dispose);
         }
         return child;
      }
      
      public function removeChildAt(index:int, dispose:Boolean = false) : DisplayObject
      {
         var child:DisplayObject = null;
         var container:DisplayObjectContainer = null;
         if(index >= 0 && index < this.numChildren)
         {
            child = this.mChildren[index];
            child.dispatchEventWith(Event.REMOVED,true);
            if(Boolean(stage))
            {
               container = child as DisplayObjectContainer;
               if(Boolean(container))
               {
                  container.broadcastEventWith(Event.REMOVED_FROM_STAGE);
               }
               else
               {
                  child.dispatchEventWith(Event.REMOVED_FROM_STAGE);
               }
            }
            child.setParent(null);
            index = this.mChildren.indexOf(child);
            if(index >= 0)
            {
               this.mChildren.splice(index,1);
            }
            if(dispose)
            {
               child.dispose();
            }
            return child;
         }
         throw new RangeError("Invalid child index");
      }
      
      public function removeChildren(beginIndex:int = 0, endIndex:int = -1, dispose:Boolean = false) : void
      {
         if(endIndex < 0 || endIndex >= this.numChildren)
         {
            endIndex = this.numChildren - 1;
         }
         for(var i:int = beginIndex; i <= endIndex; i++)
         {
            this.removeChildAt(beginIndex,dispose);
         }
      }
      
      public function getChildAt(index:int) : DisplayObject
      {
         if(index >= 0 && index < this.numChildren)
         {
            return this.mChildren[index];
         }
         throw new RangeError("Invalid child index");
      }
      
      public function getChildByName(name:String) : DisplayObject
      {
         var numChildren:int = this.mChildren.length;
         for(var i:int = 0; i < numChildren; i++)
         {
            if(this.mChildren[i].name == name)
            {
               return this.mChildren[i];
            }
         }
         return null;
      }
      
      public function getChildIndex(child:DisplayObject) : int
      {
         return this.mChildren.indexOf(child);
      }
      
      public function setChildIndex(child:DisplayObject, index:int) : void
      {
         var oldIndex:int = this.getChildIndex(child);
         if(oldIndex == -1)
         {
            throw new ArgumentError("Not a child of this container");
         }
         this.mChildren.splice(oldIndex,1);
         this.mChildren.splice(index,0,child);
      }
      
      public function swapChildren(child1:DisplayObject, child2:DisplayObject) : void
      {
         var index1:int = this.getChildIndex(child1);
         var index2:int = this.getChildIndex(child2);
         if(index1 == -1 || index2 == -1)
         {
            throw new ArgumentError("Not a child of this container");
         }
         this.swapChildrenAt(index1,index2);
      }
      
      public function swapChildrenAt(index1:int, index2:int) : void
      {
         var child1:DisplayObject = this.getChildAt(index1);
         var child2:DisplayObject = this.getChildAt(index2);
         this.mChildren[index1] = child2;
         this.mChildren[index2] = child1;
      }
      
      public function sortChildren(compareFunction:Function) : void
      {
         this.mChildren = this.mChildren.sort(compareFunction);
      }
      
      public function contains(child:DisplayObject) : Boolean
      {
         while(Boolean(child))
         {
            if(child == this)
            {
               return true;
            }
            child = child.parent;
         }
         return false;
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         var minX:Number = NaN;
         var maxX:Number = NaN;
         var minY:Number = NaN;
         var maxY:Number = NaN;
         var i:int = 0;
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         var numChildren:int = this.mChildren.length;
         if(numChildren == 0)
         {
            getTransformationMatrix(targetSpace,sHelperMatrix);
            MatrixUtil.transformCoords(sHelperMatrix,0,0,sHelperPoint);
            resultRect.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
            return resultRect;
         }
         if(numChildren == 1)
         {
            return this.mChildren[0].getBounds(targetSpace,resultRect);
         }
         minX = Number.MAX_VALUE;
         maxX = -Number.MAX_VALUE;
         minY = Number.MAX_VALUE;
         maxY = -Number.MAX_VALUE;
         for(i = 0; i < numChildren; i++)
         {
            this.mChildren[i].getBounds(targetSpace,resultRect);
            minX = minX < resultRect.x ? minX : resultRect.x;
            maxX = maxX > resultRect.right ? maxX : resultRect.right;
            minY = minY < resultRect.y ? minY : resultRect.y;
            maxY = maxY > resultRect.bottom ? maxY : resultRect.bottom;
         }
         resultRect.setTo(minX,minY,maxX - minX,maxY - minY);
         return resultRect;
      }
      
      override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         var child:DisplayObject = null;
         var target:DisplayObject = null;
         if(forTouch && (!visible || !touchable))
         {
            return null;
         }
         var localX:Number = localPoint.x;
         var localY:Number = localPoint.y;
         var numChildren:int = this.mChildren.length;
         for(var i:int = numChildren - 1; i >= 0; i--)
         {
            child = this.mChildren[i];
            getTransformationMatrix(child,sHelperMatrix);
            MatrixUtil.transformCoords(sHelperMatrix,localX,localY,sHelperPoint);
            target = child.hitTest(sHelperPoint,forTouch);
            if(Boolean(target))
            {
               return target;
            }
         }
         return null;
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         var child:DisplayObject = null;
         var filter:FragmentFilter = null;
         var alpha:Number = parentAlpha * this.alpha;
         var numChildren:int = this.mChildren.length;
         var blendMode:String = support.blendMode;
         for(var i:int = 0; i < numChildren; i++)
         {
            child = this.mChildren[i];
            if(child.hasVisibleArea)
            {
               filter = child.filter;
               support.pushMatrix();
               support.transformMatrix(child);
               support.blendMode = child.blendMode;
               if(Boolean(filter))
               {
                  filter.render(child,support,alpha);
               }
               else
               {
                  child.render(support,alpha);
               }
               support.blendMode = blendMode;
               support.popMatrix();
            }
         }
      }
      
      public function broadcastEvent(event:Event) : void
      {
         if(event.bubbles)
         {
            throw new ArgumentError("Broadcast of bubbling events is prohibited");
         }
         var fromIndex:int = sBroadcastListeners.length;
         this.getChildEventListeners(this,event.type,sBroadcastListeners);
         var toIndex:int = sBroadcastListeners.length;
         for(var i:int = fromIndex; i < toIndex; i++)
         {
            sBroadcastListeners[i].dispatchEvent(event);
         }
         sBroadcastListeners.length = fromIndex;
      }
      
      public function broadcastEventWith(type:String, data:Object = null) : void
      {
         var event:Event = Event.starling_internal::fromPool(type,false,data);
         this.broadcastEvent(event);
         Event.starling_internal::toPool(event);
      }
      
      private function getChildEventListeners(object:DisplayObject, eventType:String, listeners:Vector.<DisplayObject>) : void
      {
         var children:Vector.<DisplayObject> = null;
         var numChildren:int = 0;
         var i:int = 0;
         var container:DisplayObjectContainer = object as DisplayObjectContainer;
         if(object.hasEventListener(eventType))
         {
            listeners.push(object);
         }
         if(Boolean(container))
         {
            children = container.mChildren;
            numChildren = children.length;
            for(i = 0; i < numChildren; i++)
            {
               this.getChildEventListeners(children[i],eventType,listeners);
            }
         }
      }
      
      public function get numChildren() : int
      {
         return this.mChildren.length;
      }
   }
}
