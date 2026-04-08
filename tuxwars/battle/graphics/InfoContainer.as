package tuxwars.battle.graphics
{
   import com.dchoc.resources.*;
   import flash.display.*;
   import flash.events.Event;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class InfoContainer
   {
      private const countDown:Array = [];
      
      private var _player:PlayerGameObject;
      
      private const counterFlags:Array = [];
      
      public function InfoContainer(param1:PlayerGameObject)
      {
         super();
         this._player = param1;
         this.initCountDown();
      }
      
      public function initCountDown() : void
      {
         this.countDown[5] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_5") as MovieClip;
         this.countDown[4] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_4") as MovieClip;
         this.countDown[3] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_3") as MovieClip;
         this.countDown[2] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_2") as MovieClip;
         this.countDown[1] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_1") as MovieClip;
      }
      
      public function playCountDown(param1:int) : void
      {
         var _loc2_:PlayerGameObject = null;
         if(this.countDown[param1] != null)
         {
            this._player.container.addChild(this.countDown[param1]);
            _loc2_ = this._player;
            (_loc2_.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(this.countDown[param1],true,false);
            this.countDown[param1].gotoAndPlay(0);
            (this.countDown[param1] as MovieClip).addEventListener("enterFrame",this.removeCountDown);
         }
      }
      
      public function removeCountDown(param1:Event) : void
      {
         if((param1.currentTarget as MovieClip).currentLabel == "end")
         {
            param1.currentTarget.gotoAndStop("end");
            param1.currentTarget.removeEventListener("enterFrame",this.removeCountDown);
         }
      }
      
      public function resetCountDownFlags() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.counterFlags.length)
         {
            this.counterFlags[_loc1_] = false;
            _loc1_++;
         }
      }
      
      public function playCountDownTimer(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 < 6000)
         {
            _loc2_ = param1 / 1000;
            if(_loc2_ > 0 && !this.counterFlags[_loc2_])
            {
               this.counterFlags[_loc2_] = true;
               this.playCountDown(_loc2_);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ < 6)
         {
            if(this.countDown[_loc1_] != null)
            {
               this.countDown[_loc1_].gotoAndStop("end");
               this.countDown[_loc1_].removeEventListener("enterFrame",this.removeCountDown);
            }
            this.countDown[_loc1_] = null;
            _loc1_++;
         }
      }
   }
}

