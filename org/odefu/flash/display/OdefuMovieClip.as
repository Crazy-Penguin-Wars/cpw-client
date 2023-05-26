package org.odefu.flash.display
{
   import starling.display.MovieClip;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public final class OdefuMovieClip extends MovieClip
   {
       
      
      private const frameScripts:Vector.<Function> = new Vector.<Function>();
      
      private var _frameLabels:Array;
      
      private var textures:Vector.<Texture>;
      
      public function OdefuMovieClip(textures:Vector.<Texture>, frameLabels:Array = null, fps:int = 12)
      {
         super(textures,fps);
         this.textures = textures;
         _frameLabels = frameLabels;
         frameScripts.length = _frameLabels.length;
         addEventListener("addedToStage",addedToStage);
      }
      
      override public function dispose() : void
      {
         removeEventListeners();
         frameScripts.splice(0,frameScripts.length);
         if(textures.length > 0)
         {
            for each(var texture in textures)
            {
            }
            texture.dispose();
            texture.base.dispose();
            textures.splice(0,textures.length);
         }
         super.dispose();
      }
      
      public function gotoAndPlay(label:*) : void
      {
         var _loc2_:int = int(label is String ? indexOfLabel(label) : label);
         if(_loc2_ != -1)
         {
            currentFrame = _loc2_;
            play();
            return;
         }
         throw new Error("No such frame label: " + label + " in clip: " + name);
      }
      
      public function gotoAndStop(label:*) : void
      {
         var _loc2_:int = int(label is String ? indexOfLabel(label) : label);
         if(_loc2_ != -1)
         {
            currentFrame = _loc2_;
            pause();
            return;
         }
         throw new Error("No such frame label: " + label + " in clip: " + name);
      }
      
      public function frameLabel(index:int) : String
      {
         if(index >= 0 && index < _frameLabels.length)
         {
            return _frameLabels[index];
         }
         return null;
      }
      
      public function indexOfLabel(label:String) : int
      {
         return _frameLabels.indexOf(label);
      }
      
      public function get frameLabels() : Array
      {
         return _frameLabels.slice();
      }
      
      public function setFrameScript(index:int, func:Function) : Boolean
      {
         if(index >= 0 && index < frameScripts.length)
         {
            frameScripts[index] = func;
            return true;
         }
         return false;
      }
      
      protected function enterFrame(event:Event) : void
      {
         if(frameScripts[currentFrame] != null)
         {
            frameScripts[currentFrame]();
         }
      }
      
      private function addedToStage(event:Event) : void
      {
         removeEventListener("addedToStage",addedToStage);
         addEventListener("removedFromStage",removedFromStage);
         addEventListener("enterFrame",enterFrame);
      }
      
      private function removedFromStage(event:Event) : void
      {
         addEventListener("addedToStage",addedToStage);
         removeEventListener("removedFromStage",removedFromStage);
         removeEventListener("enterFrame",enterFrame);
      }
   }
}
