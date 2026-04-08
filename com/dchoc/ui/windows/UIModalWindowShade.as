package com.dchoc.ui.windows
{
   import flash.display.*;
   import flash.events.Event;
   
   public class UIModalWindowShade
   {
      public static const MODAL_ALPHA_RECTANGLE_COLOR:Number = 0;
      
      public static var MODAL_ALPHA_RECTANGLE_ALPHA_VALUE:Number = 0.6;
      
      private static const FADE_DURATION:int = 400;
      
      private var square:MovieClip;
      
      protected var parent:DisplayObjectContainer;
      
      protected var squareAlphaTimer:int;
      
      protected var squareTargetAlpha:Number;
      
      protected var squareStartAlpha:Number;
      
      private var time:Number = -1;
      
      public function UIModalWindowShade(param1:DisplayObjectContainer, param2:Boolean = true)
      {
         super();
         this.parent = param1;
         this.add(param2);
      }
      
      public function add(param1:Boolean = true) : void
      {
         this.square = new MovieClip();
         this.square.name = "Modal_Square";
         this.square.graphics.beginFill(0);
         var _loc2_:Number = Number(this.parent.width);
         var _loc3_:Number = Number(this.parent.height);
         this.square.graphics.drawRect(0,0,this.parent.stage.stageWidth,this.parent.stage.stageHeight);
         if(param1)
         {
            this.square.setAlpha(0);
            this.squareStartAlpha = 0;
            this.squareTargetAlpha = MODAL_ALPHA_RECTANGLE_ALPHA_VALUE;
            this.squareAlphaTimer = 0;
            this.square.addEventListener("enterFrame",this.enterFrame);
         }
         else
         {
            this.square.setAlpha(MODAL_ALPHA_RECTANGLE_ALPHA_VALUE);
         }
         this.square.graphics.endFill();
         this.parent.addChild(this.square);
      }
      
      public function removeModalSquare() : void
      {
         if(this.square)
         {
            if(this.square.getParent())
            {
               this.square.getParent().removeChild(this.square);
            }
            this.square = null;
         }
      }
      
      public function close() : void
      {
         if(this.square)
         {
            this.square.setAlpha(MODAL_ALPHA_RECTANGLE_ALPHA_VALUE);
            this.squareStartAlpha = MODAL_ALPHA_RECTANGLE_ALPHA_VALUE;
            this.squareTargetAlpha = 0;
            this.squareAlphaTimer = 0;
            this.time = new Date().getTime();
            this.square.addEventListener("enterFrame",this.enterFrame);
         }
      }
      
      public function enterFrame(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:int = 0;
         var _loc4_:Number = Number(NaN);
         if(this.square)
         {
            _loc2_ = Number(new Date().getTime());
            if(this.time == -1)
            {
               this.time = _loc2_;
            }
            _loc3_ = _loc2_ - this.time;
            this.time = _loc2_;
            this.squareAlphaTimer += _loc3_;
            if(this.squareAlphaTimer > 400)
            {
               this.squareAlphaTimer = 400;
               this.square.removeEventListener("enterFrame",this.enterFrame);
            }
            _loc4_ = this.squareAlphaTimer / 400;
            this.square.setAlpha(this.squareStartAlpha * (1 - _loc4_) + this.squareTargetAlpha * _loc4_);
         }
      }
      
      public function getClip() : MovieClip
      {
         return this.square;
      }
   }
}

