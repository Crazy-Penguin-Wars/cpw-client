package tuxwars.battle.animationEmission
{
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
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
      
      public function AnimationEmission(def:AnimationEmissionDef, game:DCGame)
      {
         super(def,game);
         activationTime = def.activationTime;
         clipEnd = false;
      }
      
      override public function dispose() : void
      {
         mc.addFrameScript(getEndIndex(),null);
         var _loc1_:* = (this.game as tuxwars.TuxWarsGame).tuxWorld;
         _loc1_._objectContainer.removeChild(mc);
         soundId = null;
         super.dispose();
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         super.physicsUpdate(deltaTime);
         _elapsedTime += deltaTime;
         if(elapsedTime >= activationTime)
         {
            readyToEmitContent = true;
            if(clipEnd && isFinished())
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
         mc.addFrameScript(getEndIndex(),null);
         clipEnd = true;
      }
      
      override public function readyToEmit() : Boolean
      {
         return emissions != null && _location != null && readyToEmitContent;
      }
      
      override public function setEmittingDone() : void
      {
         _location = null;
         emittingDone = true;
      }
      
      public function set tagger(value:Tagger) : void
      {
         _tagger = value;
      }
      
      override public function get tagger() : Tagger
      {
         return _tagger;
      }
      
      public function set playerAttackValueStat(value:Stat) : void
      {
         stats.addStat("Attackers_Stat",value,null);
      }
      
      override protected function createBody(def:PhysicsGameObjectDef) : void
      {
      }
      
      override protected function loadGraphics() : void
      {
         mc = getDisplayObjectFromResourceManager() as MovieClip;
         if(mc)
         {
            mc.name = graphics.export;
            mc.x = this._displayObject.x;
            mc.y = this._displayObject.y;
            var _loc1_:* = (this.game as tuxwars.TuxWarsGame).tuxWorld;
            _loc1_._objectContainer.addChild(mc);
            graphicsLoaded = true;
            mc.addFrameScript(getEndIndex(),endClip);
            mc.gotoAndPlay(0);
         }
      }
      
      private function getEndIndex() : int
      {
         var _loc1_:int = DCUtils.indexOfLabel(mc,"end");
         if(_loc1_ == -1 && mc)
         {
            return mc.totalFrames - 1;
         }
         return _loc1_;
      }
   }
}
