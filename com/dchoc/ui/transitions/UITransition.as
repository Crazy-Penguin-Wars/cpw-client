package com.dchoc.ui.transitions
{
   import com.dchoc.ui.base.*;
   import com.dchoc.ui.events.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.geom.*;
   
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
      
      public function UITransition(param1:DisplayObject, param2:MovieClip, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false, param6:UIComponent = null)
      {
         var _loc9_:* = undefined;
         var _loc7_:flash.geom.Rectangle = null;
         super();
         if(param1 is UIComponent)
         {
            _loc9_ = UIComponent(param1);
            param1 = _loc9_._design;
         }
         if(param1.parent == null)
         {
            return;
         }
         if(param6 != null)
         {
            this.uiComponent = param6;
            this.uiComponent.setUiTransition(this);
         }
         name = "Transition";
         this.target = param1;
         this.anim = param2;
         addChild(this.anim);
         this.parentContainer = this.target.parent;
         this.parentChildIndex = this.parentContainer.getChildIndex(this.target);
         this.parentContainer.addChildAt(this,this.parentChildIndex);
         var _loc8_:MovieClip = this.anim.getChildByName(this.ADD_TARGET_TO_CHILD_NAME) as MovieClip;
         this.newPos = new Point(this.target.x,this.target.y);
         DisplayObjectContainer(_loc8_).addChildAt(this.target,this.parentChildIndex);
         this.target.x = this.anim.x;
         this.target.y = this.anim.y;
         this.anim.x = this.newPos.x;
         this.anim.y = this.newPos.y;
         _loc8_.Placeholder.visible = false;
         this.anim.gotoAndPlay(1);
         this.anim.addEventListener("transition_end",this.clean);
         this.removeParenting = false;
         this.deleteTarget = param5;
         this.transitioning = true;
      }
      
      public function clean(param1:Event) : void
      {
         this.anim.removeEventListener("transition_end",this.clean);
         if(this.removeParenting)
         {
            this.removeClips();
         }
         this.target.dispatchEvent(new UITransitionEvent("transition_end"));
         this.transitioning = false;
         if(this.uiComponent != null)
         {
            this.uiComponent.setUiTransition(null);
         }
      }
      
      public function dispose(param1:Boolean = false) : void
      {
         this.anim.removeEventListener("transition_end",this.clean);
         this.bufferBitmap.bitmapData.dispose();
         this.bufferBitmap = null;
         if(this.removeParenting)
         {
            this.removeClips();
         }
         if(!param1 && !this.deleteTarget && this.parentContainer.numChildren > this.parentChildIndex)
         {
            this.parentContainer.removeChildAt(this.parentChildIndex);
         }
         this.transitioning = false;
         if(this.uiComponent != null)
         {
            this.uiComponent.setUiTransition(null);
         }
      }
      
      public function removeClips() : void
      {
         var _loc1_:* = undefined;
         if(!this.deleteTarget && this.parentContainer.numChildren > this.parentChildIndex)
         {
            if(this.parentContainer.contains(this.target))
            {
               this.parentContainer.setChildIndex(this.target,this.parentChildIndex);
            }
            else
            {
               this.parentContainer.addChildAt(this.target,this.parentChildIndex);
            }
         }
         if(this.parentContainer.contains(this))
         {
            this.parentContainer.removeChild(this);
         }
         if(this.bufferBitmap == null)
         {
            this.target.x = this.newPos.x;
            this.target.y = this.newPos.y;
            this.bufferBitmap.bitmapData.dispose();
            this.bufferBitmap = null;
         }
         else
         {
            if(this.target is UIComponent)
            {
               _loc1_ = UIComponent(this.target);
               _loc1_._design.visible = true;
            }
            else
            {
               this.target.visible = true;
            }
            this.bufferBitmap.bitmapData.dispose();
            this.bufferBitmap = null;
         }
      }
      
      public function isTransitioning() : Boolean
      {
         return this.transitioning;
      }
   }
}

