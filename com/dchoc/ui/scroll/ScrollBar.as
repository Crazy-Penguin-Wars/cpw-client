package com.dchoc.ui.scroll
{
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ScrollBar
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      private var mType:String = "";
      
      private var mScrollBar:UIButton;
      
      private var mDragArea:Sprite;
      
      private var mButtonUp:UIButton;
      
      private var mButtonDown:UIButton;
      
      private var mStage:Stage;
      
      private var mDragBounds:Rectangle;
      
      private var mCallback:Function;
      
      private var mEnabled:Boolean = true;
      
      private var mProcentage:Number = 0;
      
      public function ScrollBar(scrollBar:UIButton, dragArea:Sprite, type:String, stage:Stage)
      {
         super();
         if(scrollBar != null && dragArea != null && stage != null && (type == "horizontal" || type == "vertical"))
         {
            mScrollBar = scrollBar;
            mDragArea = dragArea;
            mStage = stage;
            if(type != "")
            {
               mType = type;
            }
            mDragBounds = mDragArea.getRect(scrollBar.getDesignMovieClip());
            mDragBounds.height = Math.ceil(mDragArea.height);
            mDragBounds.width = Math.ceil(mDragArea.width);
            mDragBounds.x = Math.ceil(mDragArea.x);
            mDragBounds.y = Math.ceil(mDragArea.y - mDragArea.height * 0.5);
            if(type == "vertical")
            {
               mDragBounds.width = 0;
            }
            else if(type == "horizontal")
            {
               mDragBounds.height = 0;
            }
            init();
         }
      }
      
      public function setMoveCallback(callback:Function) : void
      {
         mCallback = callback;
      }
      
      public function setProcentage(value:int) : void
      {
         mProcentage = value;
         moveToPercentage();
      }
      
      public function setUpButton(design:MovieClip, buttonUpName:String, callback:Function) : void
      {
         var buttonClip:* = null;
         if(design && buttonUpName != "" && callback != null)
         {
            buttonClip = design.getChildByName(buttonUpName) as MovieClip;
            if(buttonClip)
            {
               mButtonUp = new UIButton(buttonClip);
               mButtonUp.setMouseClickFunction(callback);
            }
         }
      }
      
      public function setDownButton(design:MovieClip, buttonDownName:String, callback:Function) : void
      {
         var buttonClip:* = null;
         if(design && buttonDownName != "" && callback != null)
         {
            buttonClip = design.getChildByName(buttonDownName) as MovieClip;
            if(buttonClip)
            {
               mButtonDown = new UIButton(buttonClip);
               mButtonDown.setMouseClickFunction(callback);
            }
         }
      }
      
      public function mouseParentUpHandler(event:MouseEvent) : void
      {
         mouseUpHandler(event);
      }
      
      public function clean() : void
      {
         mScrollBar.removeEventListener("mouseUp",mouseUpHandler);
         mStage.removeEventListener("mouseMove",mouseMoveHandler);
         mStage.removeEventListener("mouseUp",mouseUpHandler);
         mScrollBar.getDesignMovieClip().stopDrag();
         mScrollBar.removeEventListener("mouseDown",mouseDownHandler);
      }
      
      public function set enabled(value:Boolean) : void
      {
         mEnabled = value;
         if(mScrollBar != null)
         {
            mScrollBar.setEnabled(value);
         }
         if(value)
         {
            mScrollBar.addEventListener("mouseDown",mouseDownHandler,false,0,true);
         }
         else
         {
            clean();
         }
      }
      
      public function get enabled() : Boolean
      {
         return mEnabled;
      }
      
      public function get buttonUp() : UIButton
      {
         return mButtonUp;
      }
      
      public function get buttonDown() : UIButton
      {
         return mButtonDown;
      }
      
      protected function init() : void
      {
         mScrollBar.addEventListener("mouseDown",mouseDownHandler,false,0,true);
      }
      
      protected function moveToPercentage() : void
      {
         var position:int = mDragBounds.y;
         if(mEnabled)
         {
            if(mProcentage > 0)
            {
               mProcentage /= 100;
               position = mDragBounds.y + mProcentage * mDragBounds.height;
            }
            mScrollBar.setY(position);
         }
         else
         {
            mScrollBar.setY(position);
         }
      }
      
      protected function mouseMoveHandler(event:MouseEvent) : void
      {
         var buttonY:* = 0;
         var percentage:* = 0;
         if(mEnabled)
         {
            buttonY = mScrollBar.getY() + mDragBounds.height * 0.5;
            if(buttonY > 0)
            {
               percentage = Math.ceil(buttonY / mDragBounds.height * 100);
               if(percentage > 98)
               {
                  percentage = 100;
               }
               mCallback(percentage);
            }
            else
            {
               mCallback(0);
            }
         }
      }
      
      protected function mouseDownHandler(event:MouseEvent) : void
      {
         mScrollBar.removeEventListener("mouseDown",mouseDownHandler);
         mScrollBar.addEventListener("mouseUp",mouseUpHandler,false,0,true);
         mStage.addEventListener("mouseMove",mouseMoveHandler,false,0,true);
         mStage.addEventListener("mouseUp",mouseUpHandler);
         mScrollBar.getDesignMovieClip().startDrag(false,mDragBounds);
      }
      
      protected function mouseUpHandler(event:MouseEvent) : void
      {
         mScrollBar.removeEventListener("mouseUp",mouseUpHandler);
         mStage.removeEventListener("mouseMove",mouseMoveHandler);
         mStage.removeEventListener("mouseUp",mouseUpHandler);
         mScrollBar.getDesignMovieClip().stopDrag();
         mScrollBar.addEventListener("mouseDown",mouseDownHandler,false,0,true);
      }
   }
}
