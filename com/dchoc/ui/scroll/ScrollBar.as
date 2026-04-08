package com.dchoc.ui.scroll
{
   import com.dchoc.ui.buttons.*;
   import flash.display.*;
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
      
      private var mDragBounds:flash.geom.Rectangle;
      
      private var mCallback:Function;
      
      private var mEnabled:Boolean = true;
      
      private var mProcentage:Number = 0;
      
      public function ScrollBar(param1:UIButton, param2:Sprite, param3:String, param4:Stage)
      {
         super();
         if(param1 != null && param2 != null && param4 != null && (param3 == "horizontal" || param3 == "vertical"))
         {
            this.mScrollBar = param1;
            this.mDragArea = param2;
            this.mStage = param4;
            if(param3 != "")
            {
               this.mType = param3;
            }
            this.mDragBounds = this.mDragArea.getRect(param1.getDesignMovieClip());
            this.mDragBounds.height = Math.ceil(this.mDragArea.height);
            this.mDragBounds.width = Math.ceil(this.mDragArea.width);
            this.mDragBounds.x = Math.ceil(this.mDragArea.x);
            this.mDragBounds.y = Math.ceil(this.mDragArea.y - this.mDragArea.height * 0.5);
            if(param3 == "vertical")
            {
               this.mDragBounds.width = 0;
            }
            else if(param3 == "horizontal")
            {
               this.mDragBounds.height = 0;
            }
            this.init();
         }
      }
      
      public function setMoveCallback(param1:Function) : void
      {
         this.mCallback = param1;
      }
      
      public function setProcentage(param1:int) : void
      {
         this.mProcentage = param1;
         this.moveToPercentage();
      }
      
      public function setUpButton(param1:MovieClip, param2:String, param3:Function) : void
      {
         var _loc4_:MovieClip = null;
         if(param1 && param2 != "" && param3 != null)
         {
            _loc4_ = param1.getChildByName(param2) as MovieClip;
            if(_loc4_)
            {
               this.mButtonUp = new UIButton(_loc4_);
               this.mButtonUp.setMouseClickFunction(param3);
            }
         }
      }
      
      public function setDownButton(param1:MovieClip, param2:String, param3:Function) : void
      {
         var _loc4_:MovieClip = null;
         if(param1 && param2 != "" && param3 != null)
         {
            _loc4_ = param1.getChildByName(param2) as MovieClip;
            if(_loc4_)
            {
               this.mButtonDown = new UIButton(_loc4_);
               this.mButtonDown.setMouseClickFunction(param3);
            }
         }
      }
      
      public function mouseParentUpHandler(param1:MouseEvent) : void
      {
         this.mouseUpHandler(param1);
      }
      
      public function clean() : void
      {
         this.mScrollBar.removeEventListener("mouseUp",this.mouseUpHandler);
         this.mStage.removeEventListener("mouseMove",this.mouseMoveHandler);
         this.mStage.removeEventListener("mouseUp",this.mouseUpHandler);
         this.mScrollBar.getDesignMovieClip().stopDrag();
         this.mScrollBar.removeEventListener("mouseDown",this.mouseDownHandler);
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this.mEnabled = param1;
         if(this.mScrollBar != null)
         {
            this.mScrollBar.setEnabled(param1);
         }
         if(param1)
         {
            this.mScrollBar.addEventListener("mouseDown",this.mouseDownHandler,false,0,true);
         }
         else
         {
            this.clean();
         }
      }
      
      public function get enabled() : Boolean
      {
         return this.mEnabled;
      }
      
      public function get buttonUp() : UIButton
      {
         return this.mButtonUp;
      }
      
      public function get buttonDown() : UIButton
      {
         return this.mButtonDown;
      }
      
      protected function init() : void
      {
         this.mScrollBar.addEventListener("mouseDown",this.mouseDownHandler,false,0,true);
      }
      
      protected function moveToPercentage() : void
      {
         var _loc1_:int = int(this.mDragBounds.y);
         if(this.mEnabled)
         {
            if(this.mProcentage > 0)
            {
               this.mProcentage /= 100;
               _loc1_ = this.mDragBounds.y + this.mProcentage * this.mDragBounds.height;
            }
            this.mScrollBar.setY(_loc1_);
         }
         else
         {
            this.mScrollBar.setY(_loc1_);
         }
      }
      
      protected function mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(this.mEnabled)
         {
            _loc2_ = this.mScrollBar.getY() + this.mDragBounds.height * 0.5;
            if(_loc2_ > 0)
            {
               _loc3_ = Math.ceil(_loc2_ / this.mDragBounds.height * 100);
               if(_loc3_ > 98)
               {
                  _loc3_ = 100;
               }
               this.mCallback(_loc3_);
            }
            else
            {
               this.mCallback(0);
            }
         }
      }
      
      protected function mouseDownHandler(param1:MouseEvent) : void
      {
         this.mScrollBar.removeEventListener("mouseDown",this.mouseDownHandler);
         this.mScrollBar.addEventListener("mouseUp",this.mouseUpHandler,false,0,true);
         this.mStage.addEventListener("mouseMove",this.mouseMoveHandler,false,0,true);
         this.mStage.addEventListener("mouseUp",this.mouseUpHandler);
         this.mScrollBar.getDesignMovieClip().startDrag(false,this.mDragBounds);
      }
      
      protected function mouseUpHandler(param1:MouseEvent) : void
      {
         this.mScrollBar.removeEventListener("mouseUp",this.mouseUpHandler);
         this.mStage.removeEventListener("mouseMove",this.mouseMoveHandler);
         this.mStage.removeEventListener("mouseUp",this.mouseUpHandler);
         this.mScrollBar.getDesignMovieClip().stopDrag();
         this.mScrollBar.addEventListener("mouseDown",this.mouseDownHandler,false,0,true);
      }
   }
}

