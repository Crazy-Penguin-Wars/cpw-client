package tuxwars.battle.net.messages.battle
{
   import nape.geom.Vec2;
   import tuxwars.battle.BattleManager;
   
   public class AimMessage extends BattleMessage
   {
       
      
      public function AimMessage(vec:Vec2, id:String)
      {
         super({
            "t":2,
            "id":id,
            "x":vec.x,
            "y":vec.y
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
