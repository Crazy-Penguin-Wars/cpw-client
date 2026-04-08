package tuxwars.battle.net.messages.battle
{
   import nape.geom.Vec2;
   import tuxwars.battle.*;
   
   public class DieMessage extends BattleMessage
   {
      public function DieMessage(param1:String, param2:Vec2, param3:Boolean)
      {
         super({
            "t":35,
            "dead_dude":param1,
            "x":param2.x,
            "y":param2.y,
            "r":param3
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

