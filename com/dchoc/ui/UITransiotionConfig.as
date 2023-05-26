package com.dchoc.ui
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.transitions.UITransition;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   
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
      
      public static function setTransitionConfig(array:Array, transitionIDs:Array) : void
      {
         if(array)
         {
            transitionConfigArray = array;
         }
         else
         {
            transitionConfigArray = [];
         }
         if(transitionIDs)
         {
            transitionIDsArray = transitionIDs;
         }
         else
         {
            transitionIDsArray = [];
         }
      }
      
      public static function playTransition(uiComponent:UIComponent, fromState:String, toState:String) : Boolean
      {
         var play:Boolean = false;
         var i:int = 0;
         var j:int = 0;
         var klass:* = null;
         var mov:* = null;
         var _loc12_:* = uiComponent;
         var exportName:String = getQualifiedClassName(_loc12_._design);
         var className:String = getQualifiedClassName(uiComponent);
         var n:int = transitionConfigArray.length;
         for(i = 0; i < n; )
         {
            play = false;
            if(transitionConfigArray[i] == exportName)
            {
               play = true;
            }
            else if(transitionConfigArray[i] == className)
            {
               play = true;
            }
            else if(transitionConfigArray[i] == uiComponent.getDesignMovieClip().name)
            {
               play = true;
            }
            else
            {
               j = 0;
               while(j < transitionIDsArray.length)
               {
                  klass = DCUtils.getClassDefinitionByName(transitionIDsArray[j + 1]);
                  if(uiComponent as klass is klass && transitionConfigArray[i] == transitionIDsArray[j + 0])
                  {
                     play = true;
                     break;
                  }
                  j += 2;
               }
            }
            if(play && transitionConfigArray[i + 1] == fromState && transitionConfigArray[i + 2] == toState)
            {
               if(transitionConfigArray[i + 3] == 0)
               {
                  return false;
               }
               if(transitionConfigArray[i + 3] == 1)
               {
                  mov = DCResourceManager.instance.getFromSWF(transitionConfigArray[i + 4],transitionConfigArray[i + 5]);
                  var _loc13_:* = uiComponent;
                  new UITransition(_loc13_._design,mov,true,true,false,uiComponent);
                  return true;
               }
            }
            i += 6;
         }
         return false;
      }
   }
}
