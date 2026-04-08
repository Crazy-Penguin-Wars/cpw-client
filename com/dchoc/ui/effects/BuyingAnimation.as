package com.dchoc.ui.effects
{
   import com.dchoc.resources.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.geom.*;
   import flash.text.*;
   
   public class BuyingAnimation
   {
      private static var mainClip:MovieClip;
      
      private static var animText:TextField;
      
      private static var animIcon:MovieClip;
      
      private static const CONTENT:String = "Content";
      
      private static const BUY_ANIM:String = "buy_anim";
      
      private static const TEXT:String = "Text";
      
      private static const ICON:String = "Container_Icon";
      
      public function BuyingAnimation()
      {
         super();
         throw new Error("BuyingAnimation is a static class!");
      }
      
      private static function playAnimation(param1:Event) : void
      {
         if(mainClip.currentFrameLabel == "end")
         {
            dispose();
         }
         else
         {
            mainClip.nextFrame();
         }
      }
      
      public static function dispose() : void
      {
         mainClip.removeEventListener("enterFrame",playAnimation);
         if(mainClip.parent)
         {
            mainClip.parent.removeChild(mainClip);
         }
      }
      
      public static function startAnimation(param1:MovieClip, param2:Number, param3:MovieClip) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         if(!mainClip)
         {
            mainClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","buy_anim");
            mainClip.mouseChildren = false;
            mainClip.mouseEnabled = false;
            _loc4_ = mainClip.getChildAt(0) as MovieClip;
            animText = _loc4_.getChildByName("Text") as TextField;
            animIcon = _loc4_.getChildByName("Container_Icon") as MovieClip;
         }
         mainClip.x = 0;
         mainClip.y = 0;
         if(param2 != 0)
         {
            animText.text = param2.toString();
         }
         else
         {
            animText.text = "";
         }
         _loc5_ = animIcon.numChildren - 1;
         while(_loc5_ >= 0)
         {
            animIcon.removeChildAt(_loc5_);
            _loc5_--;
         }
         animIcon.addChild(param3);
         mainClip.addEventListener("enterFrame",playAnimation);
         mainClip.gotoAndPlay(1);
         trace("Modified to support scaling and rotating, see Github for the original version");
         param1.addChild(mainClip);
         var _loc6_:Point = mainClip.localToGlobal(new Point(0,0));
         var _loc7_:Point = param1.globalToLocal(_loc6_);
         mainClip.x = _loc7_.x;
         mainClip.y = _loc7_.y;
      }
   }
}

