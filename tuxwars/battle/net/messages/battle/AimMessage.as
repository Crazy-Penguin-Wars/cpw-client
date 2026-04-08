package tuxwars.battle.net.messages.battle
{
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   
   public class AimMessage extends BattleMessage
   {
      public function AimMessage(param1:Vec2, param2:String)
      {
         super({
            "t":2,
            "id":param2,
            "x":int(param1.x),
            "y":int(param1.y)
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

