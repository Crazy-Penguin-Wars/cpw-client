package tuxwars.battle.net.messages.battle
{
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   
   public class DieMessage extends BattleMessage
   {
       
      
      public function DieMessage(id:String, loc:Vec2, sleep:Boolean)
      {
         super({
            "t":35,
            "dead_dude":id,
            "x":loc.x,
            "y":loc.y,
            "r":sleep
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
