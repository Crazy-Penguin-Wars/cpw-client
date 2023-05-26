package com.dchoc.ui.effects
{
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class BuyingAnimation
   {
      
      private static const CONTENT:String = "Content";
      
      private static const BUY_ANIM:String = "buy_anim";
      
      private static const TEXT:String = "Text";
      
      private static const ICON:String = "Container_Icon";
      
      private static var mainClip:MovieClip;
      
      private static var animText:TextField;
      
      private static var animIcon:MovieClip;
       
      
      public function BuyingAnimation()
      {
         super();
         throw new Error("BuyingAnimation is a static class!");
      }
      
      public static function startAnimation(parent:MovieClip, amount:Number, icon:MovieClip) : void
      {
         var _loc4_:* = null;
         var i:int = 0;
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
         if(amount != 0)
         {
            animText.text = amount.toString();
         }
         else
         {
            animText.text = "";
         }
         for(i = animIcon.numChildren - 1; i >= 0; )
         {
            animIcon.removeChildAt(i);
            i--;
         }
         animIcon.addChild(icon);
         mainClip.gotoAndPlay(1);
         var grandParent:* = parent;
         while(grandParent)
         {
            parent = grandParent;
            mainClip.x += grandParent.x;
            mainClip.y += grandParent.y;
            grandParent = grandParent.parent as MovieClip;
         }
         parent.addChild(mainClip);
         mainClip.addEventListener("enterFrame",playAnimation);
      }
      
      private static function playAnimation(event:Event) : void
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
   }
}
