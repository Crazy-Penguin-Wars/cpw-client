package starling.animation
{
   import starling.core.starling_internal;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class Juggler implements IAnimatable
   {
       
      
      private var mObjects:Vector.<IAnimatable>;
      
      private var mElapsedTime:Number;
      
      public function Juggler()
      {
         super();
         this.mElapsedTime = 0;
         this.mObjects = new Vector.<IAnimatable>(0);
      }
      
      public function add(object:IAnimatable) : void
      {
         var dispatcher:EventDispatcher = null;
         if(Boolean(object) && this.mObjects.indexOf(object) == -1)
         {
            this.mObjects.push(object);
            dispatcher = object as EventDispatcher;
            if(Boolean(dispatcher))
            {
               dispatcher.addEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
            }
         }
      }
      
      public function contains(object:IAnimatable) : Boolean
      {
         return this.mObjects.indexOf(object) != -1;
      }
      
      public function remove(object:IAnimatable) : void
      {
         if(object == null)
         {
            return;
         }
         var dispatcher:EventDispatcher = object as EventDispatcher;
         if(Boolean(dispatcher))
         {
            dispatcher.removeEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
         }
         var index:int = this.mObjects.indexOf(object);
         if(index != -1)
         {
            this.mObjects[index] = null;
         }
      }
      
      public function removeTweens(target:Object) : void
      {
         var tween:Tween = null;
         if(target == null)
         {
            return;
         }
         for(var i:int = this.mObjects.length - 1; i >= 0; i--)
         {
            tween = this.mObjects[i] as Tween;
            if(Boolean(tween) && tween.target == target)
            {
               tween.removeEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
               this.mObjects[i] = null;
            }
         }
      }
      
      public function purge() : void
      {
         var dispatcher:EventDispatcher = null;
         for(var i:int = this.mObjects.length - 1; i >= 0; i--)
         {
            dispatcher = this.mObjects[i] as EventDispatcher;
            if(Boolean(dispatcher))
            {
               dispatcher.removeEventListener(Event.REMOVE_FROM_JUGGLER,this.onRemove);
            }
            this.mObjects[i] = null;
         }
      }
      
      public function delayCall(call:Function, delay:Number, ... args) : DelayedCall
      {
         if(call == null)
         {
            return null;
         }
         var delayedCall:DelayedCall = new DelayedCall(call,delay,args);
         this.add(delayedCall);
         return delayedCall;
      }
      
      public function tween(target:Object, time:Number, properties:Object) : void
      {
         var property:* = null;
         var value:Object = null;
         var tween:Tween = Tween.starling_internal::fromPool(target,time);
         for(property in properties)
         {
            value = properties[property];
            if(tween.hasOwnProperty(property))
            {
               tween[property] = value;
            }
            else
            {
               if(!target.hasOwnProperty(property))
               {
                  throw new ArgumentError("Invalid property: " + property);
               }
               tween.animate(property,value as Number);
            }
         }
         tween.addEventListener(Event.REMOVE_FROM_JUGGLER,this.onPooledTweenComplete);
         this.add(tween);
      }
      
      private function onPooledTweenComplete(event:Event) : void
      {
         Tween.starling_internal::toPool(event.target as Tween);
      }
      
      public function advanceTime(time:Number) : void
      {
         var i:int = 0;
         var object:IAnimatable = null;
         var numObjects:int = this.mObjects.length;
         var currentIndex:int = 0;
         this.mElapsedTime += time;
         if(numObjects == 0)
         {
            return;
         }
         for(i = 0; i < numObjects; i++)
         {
            object = this.mObjects[i];
            if(Boolean(object))
            {
               if(currentIndex != i)
               {
                  this.mObjects[currentIndex] = object;
                  this.mObjects[i] = null;
               }
               object.advanceTime(time);
               currentIndex++;
            }
         }
         if(currentIndex != i)
         {
            numObjects = this.mObjects.length;
            while(i < numObjects)
            {
               this.mObjects[int(currentIndex++)] = this.mObjects[int(i++)];
            }
            this.mObjects.length = currentIndex;
         }
      }
      
      private function onRemove(event:Event) : void
      {
         this.remove(event.target as IAnimatable);
         var tween:Tween = event.target as Tween;
         if(Boolean(tween) && tween.isComplete)
         {
            this.add(tween.nextTween);
         }
      }
      
      public function get elapsedTime() : Number
      {
         return this.mElapsedTime;
      }
   }
}
