package com.dchoc.ui
{
   public class UIConfig
   {
       
      
      public function UIConfig()
      {
         super();
         throw new Error("UIConfig is a static class!");
      }
      
      public static function init(transitionConfig:Array = null, transitionIDs:Array = null, buttonDefaultSoundStatus:Boolean = true, buttonDefaultSounds:Object = null) : void
      {
         UIButtonConfig.setSoundStatus(buttonDefaultSoundStatus);
         UIButtonConfig.setSounds(buttonDefaultSounds);
         UITransiotionConfig.setTransitionConfig(transitionConfig,transitionIDs);
      }
   }
}
