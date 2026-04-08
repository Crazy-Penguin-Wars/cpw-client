package com.dchoc.ui
{
   public class UIConfig
   {
      public function UIConfig()
      {
         super();
         throw new Error("UIConfig is a static class!");
      }
      
      public static function init(param1:Array = null, param2:Array = null, param3:Boolean = true, param4:Object = null) : void
      {
         UIButtonConfig.setSoundStatus(param3);
         UIButtonConfig.setSounds(param4);
         UITransiotionConfig.setTransitionConfig(param1,param2);
      }
   }
}

