package com.dchoc.ui.transitions
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.events.UITransitionEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class UITransition extends MovieClip
   {
      
      public static const SAFETY_MARGIN:int = 70;
       
      
      private var ADD_TARGET_TO_CHILD_NAME:String = "Icon";
      
      private var uiComponent:UIComponent;
      
      protected var anim:MovieClip;
      
      protected var target:DisplayObject;
      
      protected var parentContainer:DisplayObjectContainer;
      
      protected var parentChildIndex:int;
      
      protected var removeParenting:Boolean;
      
      protected var deleteTarget:Boolean;
      
      protected var transitioning:Boolean;
      
      protected var newPos:Point;
      
      private var bufferBitmap:Bitmap;
      
      public function UITransition(newTarget:DisplayObject, transitionClip:MovieClip, useBitmap:Boolean = true, removeParenting:Boolean = true, deleteTarget:Boolean = false, uiComp:UIComponent = null)
      {
         var bounds:* = null;
         super();
         if(newTarget is UIComponent)
         {
            var _loc9_:* = UIComponent(newTarget);
            newTarget = _loc9_._design;
         }
         if(newTarget.parent == null)
         {
            return;
         }
         if(uiComp != null)
         {
            uiComponent = uiComp;
            uiComponent.setUiTransition(this);
         }
         name = "Transition";
         target = newTarget;
         anim = transitionClip;
         addChild(anim);
         parentContainer = target.parent;
         parentChildIndex = parentContainer.getChildIndex(target);
         parentContainer.addChildAt(this,parentChildIndex);
         var iconClip:MovieClip = anim.getChildByName(ADD_TARGET_TO_CHILD_NAME) as MovieClip;
         newPos = new Point(target.x,target.y);
         if(useBitmap)
         {
            bufferBitmap = new Bitmap(new BitmapData(newTarget.width + 70,newTarget.height + 70,true,16711680));
            bounds = newTarget.getBounds(newTarget);
            bufferBitmap.bitmapData.draw(newTarget,new Matrix(1,0,0,1,-bounds.left + 70 / 2,-bounds.top + 70 / 2));
            DisplayObjectContainer(iconClip).addChild(bufferBitmap);
            bufferBitmap.x = bounds.left - 70 / 2;
            bufferBitmap.y = bounds.top - 70 / 2;
            if(newTarget is UIComponent)
            {
               var _loc10_:* = UIComponent(newTarget);
               _loc10_._design.visible = false;
            }
            else
            {
               newTarget.visible = false;
            }
         }
         else
         {
            DisplayObjectContainer(iconClip).addChildAt(target,parentChildIndex);
            target.x = anim.x;
            target.y = anim.y;
         }
         anim.x = newPos.x;
         anim.y = newPos.y;
         iconClip.Placeholder.visible = false;
         anim.gotoAndPlay(1);
         anim.addEventListener("transition_end",clean);
         this.removeParenting = removeParenting;
         this.deleteTarget = deleteTarget;
         transitioning = true;
      }
      
      public function clean(e:Event) : void
      {
         anim.removeEventListener("transition_end",clean);
         if(removeParenting)
         {
            removeClips();
         }
         target.dispatchEvent(new UITransitionEvent("transition_end"));
         transitioning = false;
         if(uiComponent != null)
         {
            uiComponent.setUiTransition(null);
         }
      }
      
      public function dispose(skipParentRemoving:Boolean = false) : void
      {
         anim.removeEventListener("transition_end",clean);
         if(removeParenting)
         {
            removeClips();
         }
         if(!skipParentRemoving && !deleteTarget && parentContainer.numChildren > parentChildIndex)
         {
            parentContainer.removeChildAt(parentChildIndex);
         }
         transitioning = false;
         if(uiComponent != null)
         {
            uiComponent.setUiTransition(null);
         }
      }
      
      public function removeClips() : void
      {
         if(!deleteTarget && parentContainer.numChildren > parentChildIndex)
         {
            if(parentContainer.contains(target))
            {
               parentContainer.setChildIndex(target,parentChildIndex);
            }
            else
            {
               parentContainer.addChildAt(target,parentChildIndex);
            }
         }
         if(parentContainer.contains(this))
         {
            parentContainer.removeChild(this);
         }
         if(bufferBitmap == null)
         {
            target.x = newPos.x;
            target.y = newPos.y;
         }
         else
         {
            if(target is UIComponent)
            {
               var _loc1_:* = UIComponent(target);
               _loc1_._design.visible = true;
            }
            else
            {
               target.visible = true;
            }
            bufferBitmap.bitmapData.dispose();
            bufferBitmap = null;
         }
      }
      
      public function isTransitioning() : Boolean
      {
         return transitioning;
      }
   }
}
