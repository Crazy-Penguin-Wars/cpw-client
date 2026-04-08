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
      
      public function OdefuMovieClip(param1:Vector.<Texture>, param2:Array = null, param3:int = 12)
      {
         super(param1,param3);
         this.textures = param1;
         this._frameLabels = param2;
         this.frameScripts.length = this._frameLabels.length;
         addEventListener("addedToStage",this.addedToStage);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         removeEventListeners();
         this.frameScripts.splice(0,this.frameScripts.length);
         if(this.textures.length > 0)
         {
            for each(_loc1_ in this.textures)
            {
            }
            _loc1_.dispose();
            _loc1_.base.dispose();
            this.textures.splice(0,this.textures.length);
         }
         super.dispose();
      }
      
      public function gotoAndPlay(param1:*) : void
      {
         var _loc2_:int = int(param1 is String ? this.indexOfLabel(param1) : param1);
         if(_loc2_ != -1)
         {
            currentFrame = _loc2_;
            play();
            return;
         }
         throw new Error("No such frame label: " + param1 + " in clip: " + name);
      }
      
      public function gotoAndStop(param1:*) : void
      {
         var _loc2_:int = int(param1 is String ? this.indexOfLabel(param1) : param1);
         if(_loc2_ != -1)
         {
            currentFrame = _loc2_;
            pause();
            return;
         }
         throw new Error("No such frame label: " + param1 + " in clip: " + name);
      }
      
      public function frameLabel(param1:int) : String
      {
         if(param1 >= 0 && param1 < this._frameLabels.length)
         {
            return this._frameLabels[param1];
         }
         return null;
      }
      
      public function indexOfLabel(param1:String) : int
      {
         return this._frameLabels.indexOf(param1);
      }
      
      public function get frameLabels() : Array
      {
         return this._frameLabels.slice();
      }
      
      public function setFrameScript(param1:int, param2:Function) : Boolean
      {
         if(param1 >= 0 && param1 < this.frameScripts.length)
         {
            this.frameScripts[param1] = param2;
            return true;
         }
         return false;
      }
      
      protected function enterFrame(param1:Event) : void
      {
         if(this.frameScripts[currentFrame] != null)
         {
            this.frameScripts[currentFrame]();
         }
      }
      
      private function addedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",this.addedToStage);
         addEventListener("removedFromStage",this.removedFromStage);
         addEventListener("enterFrame",this.enterFrame);
      }
      
      private function removedFromStage(param1:Event) : void
      {
         addEventListener("addedToStage",this.addedToStage);
         removeEventListener("removedFromStage",this.removedFromStage);
         removeEventListener("enterFrame",this.enterFrame);
      }
   }
}

