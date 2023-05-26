package tuxwars.battle.graphics
{
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class InfoContainer
   {
       
      
      private const countDown:Array = [];
      
      private var _player:PlayerGameObject;
      
      private const counterFlags:Array = [];
      
      public function InfoContainer(player:PlayerGameObject)
      {
         super();
         _player = player;
         initCountDown();
      }
      
      public function initCountDown() : void
      {
         countDown[5] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_5") as MovieClip;
         countDown[4] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_4") as MovieClip;
         countDown[3] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_3") as MovieClip;
         countDown[2] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_2") as MovieClip;
         countDown[1] = DCResourceManager.instance.getFromSWF("flash/ui/character_ui.swf","turn_countdown_1") as MovieClip;
      }
      
      public function playCountDown(value:int) : void
      {
         if(countDown[value] != null)
         {
            _player.container.addChild(countDown[value]);
            var _loc2_:PlayerGameObject = _player;
            (_loc2_.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(countDown[value],true,false);
            countDown[value].gotoAndPlay(0);
            (countDown[value] as MovieClip).addEventListener("enterFrame",removeCountDown);
         }
      }
      
      public function removeCountDown(event:Event) : void
      {
         if((event.currentTarget as MovieClip).currentLabel == "end")
         {
            event.currentTarget.gotoAndStop("end");
            event.currentTarget.removeEventListener("enterFrame",removeCountDown);
         }
      }
      
      public function resetCountDownFlags() : void
      {
         var i:int = 0;
         while(i < counterFlags.length)
         {
            counterFlags[i] = false;
            i++;
         }
      }
      
      public function playCountDownTimer(time:int) : void
      {
         var i:int = 0;
         if(time < 6000)
         {
            i = time / 1000;
            if(i > 0 && !counterFlags[i])
            {
               counterFlags[i] = true;
               playCountDown(i);
            }
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         for(i = 1; i < 6; )
         {
            if(countDown[i] != null)
            {
               countDown[i].gotoAndStop("end");
               countDown[i].removeEventListener("enterFrame",removeCountDown);
            }
            countDown[i] = null;
            i++;
         }
      }
   }
}
