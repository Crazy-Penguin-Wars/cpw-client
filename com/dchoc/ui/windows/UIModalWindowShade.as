package com.dchoc.ui.windows
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
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
      
      public function UIModalWindowShade(parent:DisplayObjectContainer, animate:Boolean = true)
      {
         super();
         this.parent = parent;
         add(animate);
      }
      
      public function add(animate:Boolean = true) : void
      {
         square = new MovieClip();
         square.name = "Modal_Square";
         square.graphics.beginFill(0);
         var _loc2_:Number = parent.width;
         var _loc3_:Number = parent.height;
         square.graphics.drawRect(0,0,parent.stage.stageWidth,parent.stage.stageHeight);
         if(animate)
         {
            square.setAlpha(0);
            squareStartAlpha = 0;
            squareTargetAlpha = MODAL_ALPHA_RECTANGLE_ALPHA_VALUE;
            squareAlphaTimer = 0;
            square.addEventListener("enterFrame",enterFrame);
         }
         else
         {
            square.setAlpha(MODAL_ALPHA_RECTANGLE_ALPHA_VALUE);
         }
         square.graphics.endFill();
         parent.addChild(square);
      }
      
      public function removeModalSquare() : void
      {
         if(square)
         {
            if(square.getParent())
            {
               square.getParent().removeChild(square);
            }
            square = null;
         }
      }
      
      public function close() : void
      {
         if(square)
         {
            square.setAlpha(MODAL_ALPHA_RECTANGLE_ALPHA_VALUE);
            squareStartAlpha = MODAL_ALPHA_RECTANGLE_ALPHA_VALUE;
            squareTargetAlpha = 0;
            squareAlphaTimer = 0;
            time = new Date().getTime();
            square.addEventListener("enterFrame",enterFrame);
         }
      }
      
      public function enterFrame(e:Event) : void
      {
         var currentTime:Number = NaN;
         var deltaTime:int = 0;
         var t:Number = NaN;
         if(square)
         {
            currentTime = new Date().getTime();
            if(time == -1)
            {
               time = currentTime;
            }
            deltaTime = currentTime - time;
            time = currentTime;
            squareAlphaTimer += deltaTime;
            if(squareAlphaTimer > 400)
            {
               squareAlphaTimer = 400;
               square.removeEventListener("enterFrame",enterFrame);
            }
            t = squareAlphaTimer / 400;
            square.setAlpha(squareStartAlpha * (1 - t) + squareTargetAlpha * t);
         }
      }
      
      public function getClip() : MovieClip
      {
         return square;
      }
   }
}
