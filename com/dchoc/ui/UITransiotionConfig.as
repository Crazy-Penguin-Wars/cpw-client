package com.dchoc.ui
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.transitions.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.utils.*;
   
   public class UITransiotionConfig
   {
      private static const CONFIG_COLUMNS:int = 6;
      
      private static const TRANSITION_TYPE_NONE:int = 0;
      
      private static const TRANSITION_TYPE_UI_TRANSITION:int = 1;
      
      public static const CONFIG_COLUMN_ID:int = 0;
      
      public static const CONFIG_COLUMN_STATE_FROM:int = 1;
      
      public static const CONFIG_COLUMN_STATE_TO:int = 2;
      
      public static const CONFIG_COLUMN_TRANSITION_TYPE:int = 3;
      
      public static const CONFIG_COLUMN_GFX_FILE:int = 4;
      
      public static const CONFIG_COLUMN_GFX_CLIP:int = 5;
      
      public static const TRANSITION_ID_VALUE:int = 0;
      
      public static const TRANSITION_ID_CLASS:int = 1;
      
      private static var transitionConfigArray:Array = [];
      
      private static var transitionIDsArray:Array = [];
      
      public function UITransiotionConfig()
      {
         super();
         throw new Error("UITransiotionConfig is a static class!");
      }
      
      public static function setTransitionConfig(param1:Array, param2:Array) : void
      {
         if(param1)
         {
            transitionConfigArray = param1;
         }
         else
         {
            transitionConfigArray = [];
         }
         if(param2)
         {
            transitionIDsArray = param2;
         }
         else
         {
            transitionIDsArray = [];
         }
      }
      
      public static function playTransition(param1:UIComponent, param2:String, param3:String) : Boolean
      {
         var _loc13_:* = undefined;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Class = null;
         var _loc8_:MovieClip = null;
         var _loc9_:* = param1;
         var _loc10_:String = getQualifiedClassName(_loc9_._design);
         var _loc11_:String = getQualifiedClassName(param1);
         var _loc12_:int = int(transitionConfigArray.length);
         _loc5_ = 0;
         while(_loc5_ < _loc12_)
         {
            _loc4_ = false;
            if(transitionConfigArray[_loc5_] == _loc10_)
            {
               _loc4_ = true;
            }
            else if(transitionConfigArray[_loc5_] == _loc11_)
            {
               _loc4_ = true;
            }
            else if(transitionConfigArray[_loc5_] == param1.getDesignMovieClip().name)
            {
               _loc4_ = true;
            }
            else
            {
               _loc6_ = 0;
               while(_loc6_ < transitionIDsArray.length)
               {
                  _loc7_ = DCUtils.getClassDefinitionByName(transitionIDsArray[_loc6_ + 1]);
                  if(param1 as _loc7_ is _loc7_ && transitionConfigArray[_loc5_] == transitionIDsArray[_loc6_ + 0])
                  {
                     _loc4_ = true;
                     break;
                  }
                  _loc6_ += 2;
               }
            }
            if(_loc4_ && transitionConfigArray[_loc5_ + 1] == param2 && transitionConfigArray[_loc5_ + 2] == param3)
            {
               if(transitionConfigArray[_loc5_ + 3] == 0)
               {
                  return false;
               }
               if(transitionConfigArray[_loc5_ + 3] == 1)
               {
                  _loc8_ = DCResourceManager.instance.getFromSWF(transitionConfigArray[_loc5_ + 4],transitionConfigArray[_loc5_ + 5]);
                  _loc13_ = param1;
                  new UITransition(_loc13_._design,_loc8_,true,true,false,param1);
                  return true;
               }
            }
            _loc5_ += 6;
         }
         return false;
      }
   }
}

