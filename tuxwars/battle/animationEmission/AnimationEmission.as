package tuxwars.battle.animationEmission
{
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObject;
   import tuxwars.battle.gameobjects.PhysicsGameObjectDef;
   import tuxwars.battle.gameobjects.Tagger;
   
   public class AnimationEmission extends PhysicsEmissionGameObject
   {
      private var activationTime:int;
      
      private var _tagger:Tagger;
      
      private var readyToEmitContent:Boolean;
      
      private var clipEnd:Boolean;
      
      private var mc:MovieClip;
      
      public function AnimationEmission(param1:AnimationEmissionDef, param2:DCGame)
      {
         super(param1,param2);
         this.activationTime = param1.activationTime;
         this.clipEnd = false;
      }
      
      override public function dispose() : void
      {
         this.mc.addFrameScript(this.getEndIndex(),null);
         var _loc1_:* = (this.game as TuxWarsGame).tuxWorld;
         _loc1_._objectContainer.removeChild(this.mc);
         soundId = null;
         super.dispose();
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         super.physicsUpdate(param1);
         _elapsedTime += param1;
         if(elapsedTime >= this.activationTime)
         {
            this.readyToEmitContent = true;
            if(Boolean(this.clipEnd) && this.isFinished())
            {
               markForRemoval();
            }
         }
      }
      
      override protected function updateGraphics() : void
      {
      }
      
      override public function isFinished() : Boolean
      {
         return emittingDone;
      }
      
      public function endClip() : void
      {
         this.mc.addFrameScript(this.getEndIndex(),null);
         this.clipEnd = true;
      }
      
      override public function readyToEmit() : Boolean
      {
         return emissions != null && _location != null && Boolean(this.readyToEmitContent);
      }
      
      override public function setEmittingDone() : void
      {
         _location = null;
         emittingDone = true;
      }
      
      public function set tagger(param1:Tagger) : void
      {
         this._tagger = param1;
      }
      
      override public function get tagger() : Tagger
      {
         return this._tagger;
      }
      
      public function set playerAttackValueStat(param1:Stat) : void
      {
         stats.addStat("Attackers_Stat",param1,null);
      }
      
      override protected function createBody(param1:PhysicsGameObjectDef) : void
      {
      }
      
      override protected function loadGraphics() : void
      {
         var _loc1_:* = undefined;
         this.mc = getDisplayObjectFromResourceManager() as MovieClip;
         if(this.mc)
         {
            this.mc.name = graphics.export;
            this.mc.x = this._displayObject.x;
            this.mc.y = this._displayObject.y;
            _loc1_ = (this.game as TuxWarsGame).tuxWorld;
            _loc1_._objectContainer.addChild(this.mc);
            graphicsLoaded = true;
            this.mc.addFrameScript(this.getEndIndex(),this.endClip);
            this.mc.gotoAndPlay(0);
         }
      }
      
      private function getEndIndex() : int
      {
         var _loc1_:int = int(DCUtils.indexOfLabel(this.mc,"end"));
         if(_loc1_ == -1 && Boolean(this.mc))
         {
            return this.mc.totalFrames - 1;
         }
         return _loc1_;
      }
   }
}

